Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264930AbUBEAHb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 19:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264392AbUBEAGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 19:06:12 -0500
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:30216 "EHLO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S264930AbUBEADP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 19:03:15 -0500
Date: Wed, 4 Feb 2004 18:07:30 -0600 (CST)
From: mikem@beardog.cca.cpqcorp.net
To: akpm@osdl.org, axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: cciss updates for 2.6 [2 of 11]
Message-ID: <Pine.LNX.4.58.0402041804540.18320@beardog.cca.cpqcorp.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 2 of 11. Please apply in order.
This patch fixes a bug where under certain error conditions we bail and
try to free our I/O memory. Bug fix.
This patch is in the 2.4 tree.
--------------------------------------------------------------------------------------
diff -burN lx261-p001/drivers/block/cciss.c lx261/drivers/block/cciss.c
--- lx261-p001/drivers/block/cciss.c	2004-01-21 15:55:37.000000000 -0600
+++ lx261/drivers/block/cciss.c	2004-01-21 16:16:41.000000000 -0600
@@ -2234,7 +2234,7 @@
 #endif /* CCISS_DEBUG */
 	if (cfg_base_addr_index == -1) {
 		printk(KERN_WARNING "cciss: Cannot find cfg_base_addr_index\n");
-		release_io_mem(hba[i]);
+		release_io_mem(c);
 		return -1;
 	}


Thanks,
mikem
mike.miller@hp.com

