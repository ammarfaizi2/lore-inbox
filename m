Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422688AbWJFQMW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422688AbWJFQMW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 12:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751570AbWJFQMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 12:12:22 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:1003 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1751563AbWJFQMU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 12:12:20 -0400
From: Matthew Wilcox <matthew@wil.cx>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>
Subject: [PATCH] [PATCH] Rename pdc_init
Reply-To: Matthew Wilcox <matthew@wil.cx>
Date: Fri, 06 Oct 2006 10:12:19 -0600
Message-Id: <11601511393703-git-send-email-matthew@wil.cx>
X-Mailer: git-send-email 1.4.1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

parisc uses pdc_init() for different purposes, so call it pdc202xx_init
instead.

Signed-off-by: Matthew Wilcox <matthew@wil.cx>
---
 drivers/ata/pata_pdc202xx_old.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/pata_pdc202xx_old.c b/drivers/ata/pata_pdc202xx_old.c
index 5ba9eb2..8850ed5 100644
--- a/drivers/ata/pata_pdc202xx_old.c
+++ b/drivers/ata/pata_pdc202xx_old.c
@@ -402,12 +402,12 @@ static struct pci_driver pdc_pci_driver 
 	.remove		= ata_pci_remove_one
 };
 
-static int __init pdc_init(void)
+static int __init pdc202xx_init(void)
 {
 	return pci_register_driver(&pdc_pci_driver);
 }
 
-static void __exit pdc_exit(void)
+static void __exit pdc202xx_exit(void)
 {
 	pci_unregister_driver(&pdc_pci_driver);
 }
@@ -418,5 +418,5 @@ MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, pdc);
 MODULE_VERSION(DRV_VERSION);
 
-module_init(pdc_init);
-module_exit(pdc_exit);
+module_init(pdc202xx_init);
+module_exit(pdc202xx_exit);
-- 
1.4.1.1

