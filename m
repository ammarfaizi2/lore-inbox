Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268939AbTBZUvR>; Wed, 26 Feb 2003 15:51:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268941AbTBZUvQ>; Wed, 26 Feb 2003 15:51:16 -0500
Received: from covert.brown-ring.iadfw.net ([209.196.123.142]:52241 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id <S268939AbTBZUu6>; Wed, 26 Feb 2003 15:50:58 -0500
Date: Wed, 26 Feb 2003 14:53:34 -0600
From: Art Haas <ahaas@airmail.net>
To: mtd@infradead.org, linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] C99 initializers for drivers/mtd files
Message-ID: <20030226205334.GB8966@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Here is a set of patches for converting files in drivers/mtd to use C99
initializers. The patches are against the current BK.

Art Haas

===== drivers/mtd/ftl.c 1.43 vs edited =====
--- 1.43/drivers/mtd/ftl.c	Sun Feb  9 19:29:55 2003
+++ edited/drivers/mtd/ftl.c	Wed Feb 26 13:35:35 2003
@@ -155,8 +155,8 @@
 void ftl_freepart(partition_t *part);
 
 static struct mtd_notifier ftl_notifier = {
-	add:	ftl_notify_add,
-	remove:	ftl_notify_remove,
+	.add	= ftl_notify_add,
+	.remove	= ftl_notify_remove,
 };
 
 /* Partition state flags */
===== drivers/mtd/mtdchar.c 1.10 vs edited =====
--- 1.10/drivers/mtd/mtdchar.c	Mon Dec  2 17:20:17 2002
+++ edited/drivers/mtd/mtdchar.c	Wed Feb 26 12:10:18 2003
@@ -19,8 +19,8 @@
 static void mtd_notify_remove(struct mtd_info* mtd);
 
 static struct mtd_notifier notifier = {
-	add:	mtd_notify_add,
-	remove:	mtd_notify_remove,
+	.add	= mtd_notify_add,
+	.remove	= mtd_notify_remove,
 };
 
 #endif
@@ -445,13 +445,13 @@
 } /* memory_ioctl */
 
 static struct file_operations mtd_fops = {
-	owner:		THIS_MODULE,
-	llseek:		mtd_lseek,     	/* lseek */
-	read:		mtd_read,	/* read */
-	write: 		mtd_write, 	/* write */
-	ioctl:		mtd_ioctl,	/* ioctl */
-	open:		mtd_open,	/* open */
-	release:	mtd_close,	/* release */
+	.owner		= THIS_MODULE,
+	.llseek		= mtd_lseek,	/* lseek */
+	.read		= mtd_read,	/* read */
+	.write 		= mtd_write, 	/* write */
+	.ioctl		= mtd_ioctl,	/* ioctl */
+	.open		= mtd_open,	/* open */
+	.release	= mtd_close,	/* release */
 };
 
 
===== drivers/mtd/nftlcore.c 1.39 vs edited =====
--- 1.39/drivers/mtd/nftlcore.c	Mon Oct 28 13:57:50 2002
+++ edited/drivers/mtd/nftlcore.c	Wed Feb 26 13:35:01 2003
@@ -914,8 +914,8 @@
  ****************************************************************************/
 
 static struct mtd_notifier nftl_notifier = {
-	add:	NFTL_notify_add,
-	remove:	NFTL_notify_remove
+	.add	= NFTL_notify_add,
+	.remove	= NFTL_notify_remove
 };
 
 extern char nftlmountrev[];
-- 
They that can give up essential liberty to obtain a little temporary safety
deserve neither liberty nor safety.
 -- Benjamin Franklin, Historical Review of Pennsylvania, 1759
