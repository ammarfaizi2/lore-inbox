Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261344AbVCEWxt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261344AbVCEWxt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 17:53:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbVCEWxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 17:53:21 -0500
Received: from coderock.org ([193.77.147.115]:61349 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261321AbVCEWnq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 17:43:46 -0500
Subject: [patch 14/15] drivers/block/*: convert to pci_register_driver
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, c.lucas@ifrance.com
From: domen@coderock.org
Date: Sat, 05 Mar 2005 23:43:27 +0100
Message-Id: <20050305224327.781571F07A@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


convert from pci_module_init to pci_register_driver

Signed-off-by: Christophe Lucas <c.lucas@ifrance.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/block/DAC960.c |    2 +-
 kj-domen/drivers/block/cciss.c  |    2 +-
 kj-domen/drivers/block/sx8.c    |    2 +-
 kj-domen/drivers/block/umem.c   |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff -puN drivers/block/DAC960.c~pci_register_driver-drivers_block drivers/block/DAC960.c
--- kj/drivers/block/DAC960.c~pci_register_driver-drivers_block	2005-03-05 16:12:15.000000000 +0100
+++ kj-domen/drivers/block/DAC960.c	2005-03-05 16:12:16.000000000 +0100
@@ -7067,7 +7067,7 @@ static int DAC960_init_module(void)
 {
 	int ret;
 
-	ret =  pci_module_init(&DAC960_pci_driver);
+	ret =  pci_register_driver(&DAC960_pci_driver);
 #ifdef DAC960_GAM_MINOR
 	if (!ret)
 		DAC960_gam_init();
diff -puN drivers/block/cciss.c~pci_register_driver-drivers_block drivers/block/cciss.c
--- kj/drivers/block/cciss.c~pci_register_driver-drivers_block	2005-03-05 16:12:15.000000000 +0100
+++ kj-domen/drivers/block/cciss.c	2005-03-05 16:12:16.000000000 +0100
@@ -2880,7 +2880,7 @@ int __init cciss_init(void)
 	printk(KERN_INFO DRIVER_NAME "\n");
 
 	/* Register for our PCI devices */
-	return pci_module_init(&cciss_pci_driver);
+	return pci_register_driver(&cciss_pci_driver);
 }
 
 static int __init init_cciss_module(void)
diff -puN drivers/block/sx8.c~pci_register_driver-drivers_block drivers/block/sx8.c
--- kj/drivers/block/sx8.c~pci_register_driver-drivers_block	2005-03-05 16:12:15.000000000 +0100
+++ kj-domen/drivers/block/sx8.c	2005-03-05 16:12:16.000000000 +0100
@@ -1750,7 +1750,7 @@ static void carm_remove_one (struct pci_
 
 static int __init carm_init(void)
 {
-	return pci_module_init(&carm_driver);
+	return pci_register_driver(&carm_driver);
 }
 
 static void __exit carm_exit(void)
diff -puN drivers/block/umem.c~pci_register_driver-drivers_block drivers/block/umem.c
--- kj/drivers/block/umem.c~pci_register_driver-drivers_block	2005-03-05 16:12:16.000000000 +0100
+++ kj-domen/drivers/block/umem.c	2005-03-05 16:12:16.000000000 +0100
@@ -1185,7 +1185,7 @@ int __init mm_init(void)
 
 	printk(KERN_INFO DRIVER_VERSION " : " DRIVER_DESC "\n");
 
-	retval = pci_module_init(&mm_pci_driver);
+	retval = pci_register_driver(&mm_pci_driver);
 	if (retval)
 		return -ENOMEM;
 
_
