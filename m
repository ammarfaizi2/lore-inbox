Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262708AbTDIEJ1 (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 00:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262710AbTDIEJ0 (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 00:09:26 -0400
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:38078 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S262708AbTDIEJ0 (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 00:09:26 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH]  Add a missing right-paren in drivers/mtd/mtdblock.c
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030409042046.87334370F@mcspd15.ucom.lsi.nec.co.jp>
Date: Wed,  9 Apr 2003 13:20:46 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruN -X../cludes linux-2.5.67-moo.orig/drivers/mtd/mtdblock.c linux-2.5.67-moo/drivers/mtd/mtdblock.c
--- linux-2.5.67-moo.orig/drivers/mtd/mtdblock.c	2003-04-08 10:15:42.000000000 +0900
+++ linux-2.5.67-moo/drivers/mtd/mtdblock.c	2003-04-08 14:49:37.000000000 +0900
@@ -388,7 +388,7 @@
 	struct mtdblk_dev *mtdblk;
 	unsigned int res;
 
-	while ((req = elv_next_request(&mtd_queue) != NULL) {
+	while ((req = elv_next_request(&mtd_queue)) != NULL) {
 		struct mtdblk_dev **p = req->rq_disk->private_data;
 		spin_unlock_irq(mtd_queue.queue_lock);
 		mtdblk = *p;
