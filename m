Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261772AbTHTIMh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 04:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261835AbTHTIMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 04:12:21 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:43469 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S261772AbTHTICR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 04:02:17 -0400
Date: Wed, 20 Aug 2003 18:03:26 +1000
Message-Id: <200308200803.h7K83QX6011743@theirongiant.lochness.weebeastie.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 10/16] C99: 2.6.0-t3-bk7/arch/ppc64
Cc: Linus Torvalds <torvalds@osdl.org>
From: CaT <cat@zip.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -aur linux.backup/arch/ppc64/kernel/proc_ppc64.c linux/arch/ppc64/kernel/proc_ppc64.c
--- linux.backup/arch/ppc64/kernel/proc_ppc64.c	Thu Jun 26 23:46:16 2003
+++ linux/arch/ppc64/kernel/proc_ppc64.c	Wed Aug 20 16:40:22 2003
@@ -47,9 +47,9 @@
 static int     page_map_mmap( struct file *file, struct vm_area_struct *vma );
 
 static struct file_operations page_map_fops = {
-	llseek:	page_map_seek,
-	read:	page_map_read,
-	mmap:	page_map_mmap
+	.llseek	= page_map_seek,
+	.read	= page_map_read,
+	.mmap	= page_map_mmap
 };
 
 
diff -aur linux.backup/arch/ppc64/kernel/scanlog.c linux/arch/ppc64/kernel/scanlog.c
--- linux.backup/arch/ppc64/kernel/scanlog.c	Tue Mar 25 10:52:19 2003
+++ linux/arch/ppc64/kernel/scanlog.c	Wed Aug 20 16:40:22 2003
@@ -190,11 +190,11 @@
 }
 
 struct file_operations scanlog_fops = {
-	owner:		THIS_MODULE,
-	read:		scanlog_read,
-	write:		scanlog_write,
-	open:		scanlog_open,
-	release:	scanlog_release,
+	.owner		= THIS_MODULE,
+	.read		= scanlog_read,
+	.write		= scanlog_write,
+	.open		= scanlog_open,
+	.release	= scanlog_release,
 };
 
 int __init scanlog_init(void)
