Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270553AbTGZV1A (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 17:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270622AbTGZV07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 17:26:59 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:31433 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S270553AbTGZVZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 17:25:39 -0400
Date: Sat, 26 Jul 2003 23:40:47 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL] use ext2/ext3 consistently in Kconfig
Message-ID: <20030726214047.GD16798@louise.pinerecords.com>
References: <20030726195722.GB16160@louise.pinerecords.com> <200307261621.55553.jeffpc@optonline.net> <6ud6fx118p.fsf@zork.zork.net> <20030726212128.GB16798@louise.pinerecords.com> <6uwue5ynzl.fsf@zork.zork.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6uwue5ynzl.fsf@zork.zork.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [sneakums@zork.net]
> 
> I hate to drag this out further...
> 
> Tomas Szepe <szepe@pinerecords.com> writes:
> 
> > -	  This is the journaling version of the Second extended file system
> > -	  (often called ext3), the de facto standard Linux file system
> > -	  (method to organize files on a storage device) for hard disks.
> > +	  Ext3 is a jornaling version of the Second extended fs
> 
> s/jornaling/journaling/

Damn.


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
