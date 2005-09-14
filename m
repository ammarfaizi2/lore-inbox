Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964816AbVINLTO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbVINLTO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 07:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964921AbVINLTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 07:19:14 -0400
Received: from cpanel02.rubas.net ([62.216.182.2]:6604 "EHLO
	cpanel02.rubas.net") by vger.kernel.org with ESMTP id S964816AbVINLTN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 07:19:13 -0400
Subject: Re: [ANNOUNCE] udev 069 release
From: =?ISO-8859-1?Q?J=FCrg?= Billeter <j@bitron.ch>
To: Greg KH <greg@kroah.com>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20050913174848.GA6702@kroah.com>
References: <20050913174848.GA6702@kroah.com>
Content-Type: multipart/mixed; boundary="=-JuNeNYYhXJj+mgLNAisv"
Date: Wed, 14 Sep 2005 13:18:47 +0200
Message-Id: <1126696727.3983.2.camel@juerg-pd.bitron.ch>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel02.rubas.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - bitron.ch
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-JuNeNYYhXJj+mgLNAisv
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Die, 2005-09-13 at 10:48 -0700, Greg KH wrote:
>   Makefile: cleanup install targets

The extras Makefiles haven't been updated and thus break the install
targets. Something like the attached patch should help.

Regards,

J=C3=BCrg

--=20
J=C3=BCrg Billeter <j@bitron.ch>

--=-JuNeNYYhXJj+mgLNAisv
Content-Disposition: attachment; filename=udev-069-makefile-1.patch
Content-Type: text/x-patch; name=udev-069-makefile-1.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -puNr udev-069.orig/extras/ata_id/Makefile udev-069/extras/ata_id/Makefile
--- udev-069.orig/extras/ata_id/Makefile	2005-09-13 19:24:51.000000000 +0200
+++ udev-069/extras/ata_id/Makefile	2005-09-14 11:57:13.000000000 +0200
@@ -43,8 +43,8 @@ clean:
 
 spotless: clean
 
-install: all
+install-bin: all
 	$(INSTALL_PROGRAM) $(PROG) $(DESTDIR)$(sbindir)/$(PROG)
 
-uninstall:
+uninstall-bin:
 	- rm $(DESTDIR)$(sbindir)/$(PROG)
diff -puNr udev-069.orig/extras/cdrom_id/Makefile udev-069/extras/cdrom_id/Makefile
--- udev-069.orig/extras/cdrom_id/Makefile	2005-09-13 19:24:51.000000000 +0200
+++ udev-069/extras/cdrom_id/Makefile	2005-09-14 11:57:13.000000000 +0200
@@ -44,8 +44,8 @@ clean:
 
 spotless: clean
 
-install: all
+install-bin: all
 	$(INSTALL_PROGRAM) $(PROG) $(DESTDIR)$(sbindir)/$(PROG)
 
-uninstall:
+uninstall-bin:
 	- rm $(DESTDIR)$(sbindir)/$(PROG)
diff -puNr udev-069.orig/extras/dasd_id/Makefile udev-069/extras/dasd_id/Makefile
--- udev-069.orig/extras/dasd_id/Makefile	2005-09-13 19:24:51.000000000 +0200
+++ udev-069/extras/dasd_id/Makefile	2005-09-14 11:57:13.000000000 +0200
@@ -43,8 +43,8 @@ clean:
 
 spotless: clean
 
-install: all
+install-bin: all
 	$(INSTALL_PROGRAM) $(PROG) $(DESTDIR)$(sbindir)/$(PROG)
 
-uninstall:
+uninstall-bin:
 	- rm $(DESTDIR)$(sbindir)/$(PROG)
diff -puNr udev-069.orig/extras/edd_id/Makefile udev-069/extras/edd_id/Makefile
--- udev-069.orig/extras/edd_id/Makefile	2005-09-13 19:24:51.000000000 +0200
+++ udev-069/extras/edd_id/Makefile	2005-09-14 11:57:13.000000000 +0200
@@ -43,8 +43,8 @@ clean:
 
 spotless: clean
 
-install: all
+install-bin: all
 	$(INSTALL_PROGRAM) $(PROG) $(DESTDIR)$(sbindir)/$(PROG)
 
-uninstall:
+uninstall-bin:
 	- rm $(DESTDIR)$(sbindir)/$(PROG)
diff -puNr udev-069.orig/extras/firmware/Makefile udev-069/extras/firmware/Makefile
--- udev-069.orig/extras/firmware/Makefile	2005-09-13 19:24:51.000000000 +0200
+++ udev-069/extras/firmware/Makefile	2005-09-14 11:57:13.000000000 +0200
@@ -44,8 +44,8 @@ clean:
 
 spotless: clean
 
-install: all
+install-bin: all
 	$(INSTALL_PROGRAM) $(PROG) $(DESTDIR)$(sbindir)/$(PROG)
 
-uninstall:
+uninstall-bin:
 	- rm $(DESTDIR)$(sbindir)/$(PROG)
diff -puNr udev-069.orig/extras/floppy/Makefile udev-069/extras/floppy/Makefile
--- udev-069.orig/extras/floppy/Makefile	2005-09-13 19:24:51.000000000 +0200
+++ udev-069/extras/floppy/Makefile	2005-09-14 11:57:13.000000000 +0200
@@ -43,8 +43,8 @@ clean:
 
 spotless: clean
 
-install: all
+install-bin: all
 	$(INSTALL_PROGRAM) $(PROG) $(DESTDIR)$(sbindir)/$(PROG)
 
-uninstall:
+uninstall-bin:
 	- rm $(DESTDIR)$(sbindir)/$(PROG)
diff -puNr udev-069.orig/extras/run_directory/Makefile udev-069/extras/run_directory/Makefile
--- udev-069.orig/extras/run_directory/Makefile	2005-09-13 19:24:51.000000000 +0200
+++ udev-069/extras/run_directory/Makefile	2005-09-14 11:57:13.000000000 +0200
@@ -45,9 +45,9 @@ clean:
 
 spotless: clean
 
-install: all
+install-bin: all
 	$(INSTALL_PROGRAM) $(DEVD) $(DESTDIR)$(sbindir)/$(DEVD)
 	$(INSTALL_PROGRAM) $(HOTPLUGD) $(DESTDIR)$(sbindir)/$(HOTPLUGD)
 
-uninstall:
+uninstall-bin:
 	- rm $(DESTDIR)$(sbindir)/$(DEVD)
diff -puNr udev-069.orig/extras/scsi_id/Makefile udev-069/extras/scsi_id/Makefile
--- udev-069.orig/extras/scsi_id/Makefile	2005-09-13 19:24:51.000000000 +0200
+++ udev-069/extras/scsi_id/Makefile	2005-09-14 11:57:55.000000000 +0200
@@ -46,18 +46,23 @@ all:	$(PROG)
 
 # XXX use a compressed man page?
 
-install: all
+install-bin: all
 	$(INSTALL_PROGRAM) -D $(PROG) $(DESTDIR)$(sbindir)/$(PROG)
+
+install-man:
 	$(INSTALL_DATA) -D scsi_id.8 $(DESTDIR)$(mandir)/man8/scsi_id.8
+
+install-config:
 	@if [ ! -r $(DESTDIR)$(etcdir)/scsi_id.config ]; then \
 		echo $(INSTALL_DATA) -D ./scsi_id.config  $(DESTDIR)$(etcdir); \
 		$(INSTALL_DATA) -D ./scsi_id.config $(DESTDIR)$(etcdir)/scsi_id.config; \
 	fi
 	
-uninstall:
+uninstall-bin:
 	-rm $(DESTDIR)$(sbindir)/$(PROG)
+
+uninstall-man:
 	-rm $(DESTDIR)$(mandir)/man8/scsi_id.8
-	-rm $(DESTDIR)$(etcdir)/scsi_id.config
 
 GEN_HEADER=scsi_id_version.h
 
diff -puNr udev-069.orig/extras/usb_id/Makefile udev-069/extras/usb_id/Makefile
--- udev-069.orig/extras/usb_id/Makefile	2005-09-13 19:24:51.000000000 +0200
+++ udev-069/extras/usb_id/Makefile	2005-09-14 11:57:13.000000000 +0200
@@ -44,8 +44,8 @@ clean:
 
 spotless: clean
 
-install: all
+install-bin: all
 	$(INSTALL_PROGRAM) $(PROG) $(DESTDIR)$(sbindir)/$(PROG)
 
-uninstall:
+uninstall-bin:
 	- rm $(DESTDIR)$(sbindir)/$(PROG)
diff -puNr udev-069.orig/extras/volume_id/Makefile udev-069/extras/volume_id/Makefile
--- udev-069.orig/extras/volume_id/Makefile	2005-09-13 19:24:51.000000000 +0200
+++ udev-069/extras/volume_id/Makefile	2005-09-14 11:57:13.000000000 +0200
@@ -47,8 +47,8 @@ clean:
 
 spotless: clean
 
-install: all
+install-bin: all
 	$(INSTALL_PROGRAM) $(PROG) $(DESTDIR)$(sbindir)/$(PROG)
 
-uninstall:
+uninstall-bin:
 	- rm $(DESTDIR)$(sbindir)/$(PROG)
diff -puNr udev-069.orig/Makefile udev-069/Makefile
--- udev-069.orig/Makefile	2005-09-13 19:24:51.000000000 +0200
+++ udev-069/Makefile	2005-09-14 11:59:07.000000000 +0200
@@ -333,6 +333,10 @@ install-config: $(GEN_CONFIGS)
 		echo "pick a udev rules file from the etc/udev directory that matches your distribution"; \
 		echo; \
 	fi
+	@extras="$(EXTRAS)"; for target in $$extras; do \
+		echo $$target; \
+		$(MAKE) prefix=$(prefix) -C $$target $@; \
+	done;
 .PHONY: install-config
 
 install-man:
@@ -344,6 +348,10 @@ install-man:
 	$(INSTALL_DATA) -D udevsend.8 $(DESTDIR)$(mandir)/man8/udevsend.8
 	$(INSTALL_DATA) -D udevmonitor.8 $(DESTDIR)$(mandir)/man8/udevmonitor.8
 	- ln -f -s udevd.8 $(DESTDIR)$(mandir)/man8/udevcontrol.8
+	@extras="$(EXTRAS)"; for target in $$extras; do \
+		echo $$target; \
+		$(MAKE) prefix=$(prefix) -C $$target $@; \
+	done;
 .PHONY: install-man
 
 uninstall-man:
@@ -355,6 +363,10 @@ uninstall-man:
 	- rm $(mandir)/man8/udevmonitor.8
 	- rm $(mandir)/man8/udevsend.8
 	- rm $(mandir)/man8/udevcontrol.8
+	@extras="$(EXTRAS)"; for target in $$extras; do \
+		echo $$target; \
+		$(MAKE) prefix=$(prefix) -C $$target $@; \
+	done;
 .PHONY: uninstall-man
 
 install-bin:

--=-JuNeNYYhXJj+mgLNAisv--

