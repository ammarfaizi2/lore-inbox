Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265772AbTHKQBc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 12:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264448AbTHKQBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 12:01:31 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:15142 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S272776AbTHKP7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 11:59:42 -0400
To: torvalds@osdl.org
From: davej@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] c99 for blkmtd
Message-Id: <E19mF4Y-0005Em-00@tetrachloride>
Date: Mon, 11 Aug 2003 16:59:02 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/mtd/devices/blkmtd.c linux-2.5/drivers/mtd/devices/blkmtd.c
--- bk-linus/drivers/mtd/devices/blkmtd.c	2003-08-04 01:00:26.000000000 +0100
+++ linux-2.5/drivers/mtd/devices/blkmtd.c	2003-08-06 18:59:36.000000000 +0100
@@ -287,13 +287,10 @@ static int blkmtd_readpage(mtd_raw_dev_d
   return 0;
 }
 
-                    
 static struct address_space_operations blkmtd_aops = {
-  writepage:     blkmtd_writepage,
-  readpage:      NULL,
+	.writepage	= blkmtd_writepage,
 }; 
 
-
 /* This is the kernel thread that empties the write queue to disk */
 static int write_queue_task(void *data)
 {
