Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272560AbTHEH3W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 03:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272563AbTHEH3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 03:29:21 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:18082 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S272560AbTHEH3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 03:29:17 -0400
Date: Tue, 5 Aug 2003 09:29:13 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: torvalds@osdl.org
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [TRIVIAL] use ext2/ext3 consistently in Kconfig
Message-ID: <20030805072913.GE5876@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Resend: patch against test2-bk4.
Use ext2/ext3 consistently in Kconfig.  Also clarify what fs versions the
current reiser module supports.

-- 
Tomas Szepe <szepe@pinerecords.com>


diff -urN a/fs/Kconfig b/fs/Kconfig
--- a/fs/Kconfig	2003-06-14 23:07:12.000000000 +0200
+++ b/fs/Kconfig	2003-07-26 23:18:35.000000000 +0200
@@ -5,7 +5,7 @@
 menu "File systems"
 
 config EXT2_FS
-	tristate "Second extended fs support"
+	tristate "Ext2 fs support"
 	help
 	  This is the de facto standard Linux file system (method to organize
 	  files on a storage device) for hard disks.
@@ -86,11 +86,12 @@
 	  extended attributes for file security labels, say N.
 
 config EXT3_FS
-	tristate "Ext3 journalling file system support"
+	tristate "Ext3 journaling file system support"
 	help
-	  This is the journaling version of the Second extended file system
-	  (often called ext3), the de facto standard Linux file system
-	  (method to organize files on a storage device) for hard disks.
+	  Ext3 is a journaling version of the Second extended fs
+	  (or just ext2fs), the de facto standard Linux filesystem
+	  (method to organize files on a storage device) for block
+	  devices such as hard disk partitions.
 
 	  The journaling code included in this driver means you do not have
 	  to run e2fsck (file system checker) on your file systems after a
@@ -200,7 +201,7 @@
 	default m if EXT2_FS=m || EXT3_FS=m
 
 config REISERFS_FS
-	tristate "Reiserfs support"
+	tristate "Reiserfs support (for v3.5 & v3.6 filesystems)"
 	help
 	  Stores not just filenames but the files themselves in a balanced
 	  tree.  Uses journaling.
