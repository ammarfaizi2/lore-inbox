Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268086AbUH1VfK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268086AbUH1VfK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 17:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267851AbUH1Vco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 17:32:44 -0400
Received: from hera.cwi.nl ([192.16.191.8]:54175 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S267974AbUH1VaT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 17:30:19 -0400
Date: Sat, 28 Aug 2004 23:30:14 +0200
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andries Brouwer <Andries.Brouwer@cwi.nl>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] ext2 mount options doc
Message-ID: <20040828213014.GA2079@apps.cwi.nl>
References: <UTC200408271606.i7RG6tV27596.aeb@smtp.cwi.nl> <Pine.LNX.4.58.0408271104300.14196@ppc970.osdl.org> <20040828011959.GC16444@apps.cwi.nl> <Pine.LNX.4.58.0408271856071.14196@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408271856071.14196@ppc970.osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Updated mount.8, and in the process added a few words to
Documentation/filesystems/ext2.txt too.

Andries


diff -uprN -X /linux/dontdiff a/Documentation/filesystems/ext2.txt b/Documentation/filesystems/ext2.txt
--- a/Documentation/filesystems/ext2.txt	2003-12-18 03:58:28.000000000 +0100
+++ b/Documentation/filesystems/ext2.txt	2004-08-28 23:17:15.000000000 +0200
@@ -12,29 +12,47 @@ Options
 =======
 
 When mounting an ext2 filesystem, the following options are accepted.
-Defaults are marked with (*).
+Most defaults are determined by the filesystem superblock, and can be
+set using tune2fs(8). Kernel-determined defaults are indicated by (*).
 
 bsddf			(*)	Makes `df' act like BSD.
 minixdf				Makes `df' act like Minix.
 
+check				Check block and inode bitmaps at mount time
+				(requires CONFIG_EXT2_CHECK).
 check=none, nocheck	(*)	Don't do extra checking of bitmaps on mount
 				(check=normal and check=strict options removed)
 
 debug				Extra debugging information is sent to the
 				kernel syslog.  Useful for developers.
 
-errors=continue		(*)	Keep going on a filesystem error.
+errors=continue			Keep going on a filesystem error.
 errors=remount-ro		Remount the filesystem read-only on an error.
 errors=panic			Panic and halt the machine if an error occurs.
 
 grpid, bsdgroups		Give objects the same group ID as their parent.
-nogrpid, sysvgroups	(*)	New objects have the group ID of their creator.
+nogrpid, sysvgroups		New objects have the group ID of their creator.
 
 resuid=n			The user ID which may use the reserved blocks.
 resgid=n			The group ID which may use the reserved blocks. 
 
 sb=n				Use alternate superblock at this location.
 
+nouid32				Use 16-bit UIDs and GIDs.
+
+oldalloc			Use old allocator for new inodes.
+orlov			(*)	Use Orlov allocator.
+
+nobh				Do not attach buffer_heads to file pagecache.
+
+user_xattr			Support "user." extended attributes
+				(requires CONFIG_EXT2_FS_XATTR).
+nouser_xattr			Don't support "user." extended attributes.
+
+acl				Support POSIX Access Control Lists
+				(requires CONFIG_EXT2_FS_POSIX_ACL).
+noacl				Don't support POSIX ACLs.
+
 grpquota,noquota,quota,usrquota	Quota options are silently ignored by ext2.
 
 
