Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272548AbTHEH14 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 03:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272560AbTHEH14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 03:27:56 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:17058 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S272548AbTHEH1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 03:27:50 -0400
Date: Tue, 5 Aug 2003 09:27:47 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: torvalds@osdl.org
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [TRIVIAL] kill annoying submenus in fs/Kconfig
Message-ID: <20030805072747.GD5876@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Resend: patch against test2-bk4.
Kill annoying submenus in fs/Kconfig.

-- 
Tomas Szepe <szepe@pinerecords.com>


diff -urN a/fs/Kconfig b/fs/Kconfig
--- a/fs/Kconfig	2003-06-14 23:07:12.000000000 +0200
+++ b/fs/Kconfig	2003-07-26 20:48:56.000000000 +0200
@@ -481,7 +481,11 @@
 	  local network, you probably do not need an automounter, and can say
 	  N here.
 
-menu "CD-ROM/DVD Filesystems"
+config CD_FS
+	bool "CD-ROM/DVD Filesystems"
+	default y
+
+if CD_FS
 
 config ISO9660_FS
 	tristate "ISO 9660 CDROM file system support"
@@ -545,9 +549,13 @@
 
 	  If unsure, say N.
 
-endmenu
+endif
+
+config MS_FS
+	bool "DOS/FAT/NT Filesystems"
+	default y
 
-menu "DOS/FAT/NT Filesystems"
+if MS_FS
 
 config FAT_FS
 	tristate "DOS FAT fs support"
@@ -728,9 +736,13 @@
 
 	  It is strongly recommended and perfectly safe to say N here.
 
-endmenu
+endif
+
+config PSEUDO_FS
+	bool "Pseudo filesystems"
+	default y
 
-menu "Pseudo filesystems"
+if PSEUDO_FS
 
 config PROC_FS
 	bool "/proc file system support"
@@ -881,9 +893,13 @@
 	  say M here and read <file:Documentation/modules.txt>.  The module
 	  will be called ramfs.
 
-endmenu
+endif
+
+config MISC_FS
+	bool "Miscellaneous filesystems"
+	default y
 
-menu "Miscellaneous filesystems"
+if MISC_FS
 
 config ADFS_FS
 	tristate "ADFS file system support (EXPERIMENTAL)"
@@ -1261,10 +1277,14 @@
 	  Say Y here if you want to try writing to UFS partitions. This is
 	  experimental, so you should back up your UFS partitions beforehand.
 
-endmenu
+endif
 
-menu "Network File Systems"
+config NET_FS
+	bool "Network File Systems"
 	depends on NET
+	default y
+
+if NET_FS
 
 config NFS_FS
 	tristate "NFS file system support"
@@ -1591,7 +1611,7 @@
 	default m if AFS_FS=m
 	default y if AFS_FS=y
 
-endmenu
+endif
 
 menu "Partition Types"
 

