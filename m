Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263202AbUKTXMT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263202AbUKTXMT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 18:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263219AbUKTXMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 18:12:03 -0500
Received: from mail.euroweb.hu ([193.226.220.4]:11915 "HELO mail.euroweb.hu")
	by vger.kernel.org with SMTP id S263202AbUKTXJY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 18:09:24 -0500
To: akpm@osdl.org, torvalds@osdl.org
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/13] Filesystem in Userspace
Message-Id: <E1CVeM1-0007Ot-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sun, 21 Nov 2004 00:09:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds FUSE filesystem to MAINTAINERS, fs/Kconfig and
fs/Makefile.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
--- linux-2.6.10-rc2/fs/Kconfig	2004-11-20 21:14:44.000000000 +0100
+++ linux-2.6.10-rc2-fuse/fs/Kconfig	2004-11-20 12:50:30.000000000 +0100
@@ -492,6 +492,19 @@ config AUTOFS4_FS
 	  local network, you probably do not need an automounter, and can say
 	  N here.
 
+config FUSE
+	tristate "Filesystem in Userspace support"
+	help
+	  With FUSE it is possible to implement a fully functional filesystem
+	  in a userspace program.  
+
+	  There's also companion library: libfuse.  This library along with
+	  utilities is available from the FUSE homepage:
+	  <http://fuse.sourceforge.net/>
+
+	  If you want to develop a userspace FS, or if you want to use
+	  a filesystem based on FUSE, answer Y or M.
+
 menu "CD-ROM/DVD Filesystems"
 
 config ISO9660_FS
--- linux-2.6.10-rc2/fs/Makefile	2004-11-20 21:14:51.000000000 +0100
+++ linux-2.6.10-rc2-fuse/fs/Makefile	2004-11-20 13:41:14.000000000 +0100
@@ -94,3 +94,4 @@ obj-$(CONFIG_AFS_FS)		+= afs/
 obj-$(CONFIG_BEFS_FS)		+= befs/
 obj-$(CONFIG_HOSTFS)		+= hostfs/
 obj-$(CONFIG_HPPFS)		+= hppfs/
+obj-$(CONFIG_FUSE)		+= fuse/
--- linux-2.6.10-rc2/MAINTAINERS	2004-11-20 21:14:30.000000000 +0100
+++ linux-2.6.10-rc2-fuse/MAINTAINERS	2004-11-17 10:15:45.000000000 +0100
@@ -861,6 +861,13 @@ L:	linux-tape@vger.kernel.org
 W:	http://sourceforge.net/projects/ftape
 S:	Orphan
 
+FUSE: FILESYSTEM IN USERSPACE
+P:	Miklos Szeredi
+M:	miklos@szeredi.hu
+L:	fuse-devel@lists.sourceforge.net
+W:	http://fuse.sourceforge.net/
+S:	Maintained
+
 FUTURE DOMAIN TMC-16x0 SCSI DRIVER (16-bit)
 P:	Rik Faith
 M:	faith@cs.unc.edu
