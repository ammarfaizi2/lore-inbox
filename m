Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269204AbTGZTmT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 15:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269226AbTGZTmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 15:42:19 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:1993 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S269204AbTGZTmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 15:42:13 -0400
Date: Sat, 26 Jul 2003 21:57:22 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [TRIVIAL] use ext2/ext3 consistently in Kconfig
Message-ID: <20030726195722.GB16160@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

$subj + also clarify what fs versions the current reiser module supports.
Patch against -bk3.

-- 
Tomas Szepe <szepe@pinerecords.com>


diff -urN a/fs/Kconfig b/fs/Kconfig
--- a/fs/Kconfig	2003-07-26 20:50:55.000000000 +0200
+++ b/fs/Kconfig	2003-07-26 20:51:48.000000000 +0200
@@ -5,7 +5,7 @@
 menu "File systems"
 
 config EXT2_FS
-	tristate "Second extended fs support"
+	tristate "Ext2 fs support"
 	help
 	  This is the de facto standard Linux file system (method to organize
 	  files on a storage device) for hard disks.
@@ -89,7 +89,7 @@
 	tristate "Ext3 journalling file system support"
 	help
 	  This is the journaling version of the Second extended file system
-	  (often called ext3), the de facto standard Linux file system
+	  (often called ext2), the de facto standard Linux file system
 	  (method to organize files on a storage device) for hard disks.
 
 	  The journaling code included in this driver means you do not have
@@ -200,7 +200,7 @@
 	default m if EXT2_FS=m || EXT3_FS=m
 
 config REISERFS_FS
-	tristate "Reiserfs support"
+	tristate "Reiserfs support (for v3.5 & v3.6 filesystems)"
 	help
 	  Stores not just filenames but the files themselves in a balanced
 	  tree.  Uses journaling.
