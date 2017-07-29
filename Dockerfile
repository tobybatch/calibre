FROM fedora:25
MAINTAINER bradley leonard <bradley@leonard.pub>
MAINTAINER toby batch <tobias@neontribe.co.uk>

# install net-tools, required for serverspec to check ports
# install calibre
RUN dnf clean all && dnf -y install procps-ng calibre

# create directories
RUN mkdir /data && mkdir /scripts

# add startup.sh
ADD startup.sh /scripts/startup.sh
RUN chmod 755 /scripts/startup.sh

# add add-books.sh
ADD add-books.sh /scripts/add-books.sh
RUN chmod 755 /scripts/add-books.sh

# add remove-books.sh
ADD remove-books.sh /scripts/remove-books.sh
RUN chmod 755 /scripts/remove-books.sh

# Put the sql db in a place where it can be mounted
RUN mkdir /var/lib/calibre
RUN mv /usr/share/calibre/metadata_sqlite.sql /var/lib/calibre/metadata_sqlite.sql
RUN ln -s /var/lib/calibre/metadata_sqlite.sql /usr/share/calibre/metadata_sqlite.sql

# Expose port
EXPOSE 8080

CMD ["/scripts/startup.sh"]
