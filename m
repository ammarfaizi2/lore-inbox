Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264353AbUBEA1c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 19:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264291AbUBEAZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 19:25:49 -0500
Received: from zcamail05.zca.compaq.com ([161.114.32.105]:25349 "EHLO
	zcamail05.zca.compaq.com") by vger.kernel.org with ESMTP
	id S264353AbUBEAPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 19:15:34 -0500
Date: Wed, 4 Feb 2004 18:19:43 -0600 (CST)
From: mikem@beardog.cca.cpqcorp.net
To: akpm@osdl.org, axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: cciss updates for 2.6 [10 0f 11]
Message-ID: <Pine.LNX.4.58.0402041818480.18320@beardog.cca.cpqcorp.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 10 0f 11. Please apply in order.
This patch uses the pci_module_init wrapper for hot plug cases.
It is in the 2.4. tree.
--------------------------------------------------------------------------------------
diff -burN lx261-p009/drivers/block/cciss.c lx261/drivers/block/cciss.c
--- lx261-p009/drivers/block/cciss.c	2004-01-26 15:02:45.000000000 -0600
+++ lx261/drivers/block/cciss.c	2004-01-26 15:19:42.000000000 -0600
@@ -2704,7 +2704,7 @@
 	printk(KERN_INFO DRIVER_NAME "\n");

 	/* Register for our PCI devices */
-	return pci_register_driver(&cciss_pci_driver);
+	return pci_module_init(&cciss_pci_driver);
 }

 static int __init init_cciss_module(void)

Thanks,
mikem
mike.miller@hp.com

