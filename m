Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316580AbSEWM1z>; Thu, 23 May 2002 08:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316542AbSEWM1u>; Thu, 23 May 2002 08:27:50 -0400
Received: from imladris.infradead.org ([194.205.184.45]:42250 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S316526AbSEWM1L>; Thu, 23 May 2002 08:27:11 -0400
Date: Thu, 23 May 2002 13:27:05 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] include buffer_head.h in actual users instead of fs.h (7/10)
Message-ID: <20020523132705.H24361@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make the 5 headers in include/linux that need it include buffer_head.h
directly.


--- 1.10/include/linux/amigaffs.h	Mon May 20 16:22:37 2002
+++ edited/include/linux/amigaffs.h	Thu May 23 13:19:02 2002
@@ -2,7 +2,7 @@
 #define AMIGAFFS_H
 
 #include <linux/types.h>
-
+#include <linux/buffer_head.h>
 #include <asm/byteorder.h>
 
 /* AmigaOS allows file names with up to 30 characters length.
--- 1.6/include/linux/hfs_sysdep.h	Mon May 20 16:54:06 2002
+++ edited/include/linux/hfs_sysdep.h	Thu May 23 13:19:03 2002
@@ -21,6 +21,7 @@
 #include <linux/types.h>
 #include <linux/fs.h>
 #include <linux/sched.h>
+#include <linux/buffer_head.h>
 
 #include <asm/byteorder.h>
 #include <asm/unaligned.h>
--- 1.6/include/linux/jbd.h	Sun May 19 13:50:46 2002
+++ edited/include/linux/jbd.h	Thu May 23 14:21:44 2002
@@ -25,6 +25,7 @@
 #define jfs_debug jbd_debug
 #else
 
+#include <linux/buffer_head.h>
 #include <linux/journal-head.h>
 #include <linux/stddef.h>
 #include <asm/semaphore.h>
--- 1.14/include/linux/msdos_fs.h	Thu Apr 25 03:38:44 2002
+++ edited/include/linux/msdos_fs.h	Thu May 23 14:27:42 2002
@@ -4,6 +4,7 @@
 /*
  * The MS-DOS filesystem constants/structures
  */
+#include <linux/buffer_head.h>
 #include <asm/byteorder.h>
 
 #define SECTOR_SIZE	512		/* sector size (bytes) */
--- 1.30/include/linux/reiserfs_fs.h	Tue May 21 11:12:36 2002
+++ edited/include/linux/reiserfs_fs.h	Thu May 23 13:19:04 2002
@@ -20,6 +20,7 @@
 #include <asm/unaligned.h>
 #include <linux/bitops.h>
 #include <linux/proc_fs.h>
+#include <linux/buffer_head.h>
 #include <linux/reiserfs_fs_i.h>
 #include <linux/reiserfs_fs_sb.h>
 #endif
