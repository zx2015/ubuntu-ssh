FROM ubuntu:16.04
MAINTAINER zhouxin@day-one.cn

#ADD sources.list /etc/apt/sources.list

ADD .bashrc /root/.bashrc
ENV DEBIAN_FRONTEND noninteractive

#Packages
RUN rm -rf /var/lib/apt/lists
RUN apt-get update -q --fix-missing
RUN apt-get -y upgrade

RUN apt-get install -y nano curl wget ssh -qq
RUN rm -rf /var/lib/apt/lists/*

RUN update-rc.d ssh defaults

RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
RUN sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config
RUN echo "UseDNS no" >> /etc/ssh/sshd_config

#set root default passwrd
ADD rootpwd /root/rootpwd
RUN /bin/bash /root/rootpwd
RUN rm /root/rootpwd

EXPOSE 22/tcp

# overwrite this with 'CMD []' in a dependent Dockerfile
CMD ["/bin/bash"]
