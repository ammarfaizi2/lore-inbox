Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262452AbVAJTF0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262452AbVAJTF0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 14:05:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262451AbVAJTFC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 14:05:02 -0500
Received: from adsl-298.mirage.euroweb.hu ([193.226.239.42]:44978 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262286AbVAJS45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 13:56:57 -0500
To: akpm@osdl.org, torvalds@osdl.org
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/11] FUSE - MAINTAINERS, Kconfig and Makefile changes
Message-Id: <E1Co4iU-00043y-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 10 Jan 2005 19:56:38 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds FUSE filesystem to MAINTAINERS, fs/Kconfig and
fs/Makefile.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
--- a/fs/Kconfig	2004-11-20 21:14:44.000000000 +0100
+++ b/fs/Kconfig	2004-11-20 12:50:30.000000000 +0100
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
--- a/fs/Makefile	2004-11-20 21:14:51.000000000 +0100
+++ b/fs/Makefile	2004-11-20 13:41:14.000000000 +0100
@@ -94,3 +94,4 @@ obj-$(CONFIG_AFS_FS)		+= afs/
 obj-$(CONFIG_BEFS_FS)		+= befs/
 obj-$(CONFIG_HOSTFS)		+= hostfs/
 obj-$(CONFIG_HPPFS)		+= hppfs/
+obj-$(CONFIG_FUSE)		+= fuse/
--- a/MAINTAINERS	2004-11-20 21:14:30.000000000 +0100
+++ b/MAINTAINERS	2004-11-17 10:15:45.000000000 +0100
@@ -867,6 +867,13 @@ L:	linux-tape@vger.kernel.org
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
