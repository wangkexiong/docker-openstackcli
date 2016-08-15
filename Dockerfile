FROM alpine:3.4

MAINTAINER wangkexiong<wangkexiong@gmail.com>

# For Company Resource Accelaration
# #################################
# Using pypi mirror to speed up Internet access
#
#COPY pip.conf /root/.pip/

# To avoid the following warning
#   [WARNING]: Host file not found: /etc/ansible/hosts
#   [WARNING]: provided hosts list is empty, only localhost is available
# #################################
COPY ansible.hosts /etc/ansible/hosts

# Alpine-based installation
# #########################
# Until pypi mirrors are freshed with canonicalize_name feature changing,
# Use pip==8.1.1 for backwards.
#
RUN apk add --no-cache python-dev py-pip ca-certificates gcc musl-dev linux-headers \
                       openssh-client libffi-dev openssl-dev ansible curl && \
    pip install pip==8.1.1 && \
    pip install --upgrade --no-cache-dir shade==1.9.0 && \
    ssh-keygen -f ~/.ssh/id_rsa -t rsa -N '' && \
    apk del gcc musl-dev linux-headers

VOLUME ["/mnt"]

CMD ["/bin/sh"]
