Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272593AbTHKNot (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 09:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272661AbTHKNn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 09:43:26 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:29579 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S272599AbTHKNk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 09:40:56 -0400
To: torvalds@transmeta.com
From: davej@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] CCISS 64bit fixup.
Message-Id: <E19mCuO-0003dU-00@tetrachloride>
Date: Mon, 11 Aug 2003 14:40:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/block/cciss.c linux-2.5/drivers/block/cciss.c
--- bk-linus/drivers/block/cciss.c	2003-08-07 13:51:31.000000000 +0100
+++ linux-2.5/drivers/block/cciss.c	2003-08-07 14:13:28.000000000 +0100
@@ -2457,7 +2457,7 @@ static int __init cciss_init_one(struct 
 	hba[i]->pdev = pdev;
 
 	/* configure PCI DMA stuff */
-	if (!pci_set_dma_mask(pdev, (u64) 0xffffffffffffffff))
+	if (!pci_set_dma_mask(pdev, (u64) 0xffffffffffffffffULL))
 		printk("cciss: using DAC cycles\n");
 	else if (!pci_set_dma_mask(pdev, 0xffffffff))
 		printk("cciss: not using DAC cycles\n");
