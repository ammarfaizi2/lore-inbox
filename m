Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270000AbTGZVGo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 17:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270013AbTGZVGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 17:06:43 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:19145 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S270000AbTGZVG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 17:06:27 -0400
Date: Sat, 26 Jul 2003 23:21:28 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Jeff Sipek <jeffpc@optonline.net>, Linus Torvalds <torvalds@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [TRIVIAL] use ext2/ext3 consistently in Kconfig
Message-ID: <20030726212128.GB16798@louise.pinerecords.com>
References: <20030726195722.GB16160@louise.pinerecords.com> <200307261621.55553.jeffpc@optonline.net> <6ud6fx118p.fsf@zork.zork.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ud6fx118p.fsf@zork.zork.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [sneakums@zork.net]
> 
> Jeff Sipek <jeffpc@optonline.net> writes:
> 
> > On Saturday 26 July 2003 15:57, Tomas Szepe wrote:
> > <snip>
> >> @@ -89,7 +89,7 @@
> >>         tristate "Ext3 journalling file system support"
> >>         help
> >>           This is the journaling version of the Second extended file system
> >> -         (often called ext3), the de facto standard Linux file system
> >> +         (often called ext2), the de facto standard Linux file system
> >
> > The journaling version is ext3, not ext2...
> 
> But the *second* extended file system is indeed often called ext2.

Oh well, I guess I should have rephrased this wonderful little
stylistics exhibit in the first place.

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
+	  Ext3 is a jornaling version of the Second extended fs
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
