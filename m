Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264446AbUBEAYV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 19:24:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264954AbUBEAPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 19:15:12 -0500
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:63758 "EHLO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S264353AbUBEANI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 19:13:08 -0500
Date: Wed, 4 Feb 2004 18:17:26 -0600 (CST)
From: mikem@beardog.cca.cpqcorp.net
To: akpm@osdl.org, axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: cciss updates for 2.6 [8 of 11]
Message-ID: <Pine.LNX.4.58.0402041816190.18320@beardog.cca.cpqcorp.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 8 of 11. Please apply in order.
This patch changes a format specifier to unsigned to prevent the number of
blocks being displayed as a negative value on very large volumes.
--------------------------------------------------------------------------------------
diff -burN lx261-p007/drivers/block/cciss.c lx261/drivers/block/cciss.c
--- lx261-p007/drivers/block/cciss.c	2004-01-22 15:36:17.000000000 -0600
+++ lx261/drivers/block/cciss.c	2004-01-22 15:47:43.000000000 -0600
@@ -1309,7 +1309,7 @@
 		*total_size = 0;
 		*block_size = BLOCK_SIZE;
 	}
-	printk(KERN_INFO "      blocks= %d block_size= %d\n",
+	printk(KERN_INFO "      blocks= %u block_size= %d\n",
 		*total_size, *block_size);
 	return;
 }

Thanks,
mikem
mike.miller@hp.com

