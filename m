Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261594AbVCFWpc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261594AbVCFWpc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 17:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261593AbVCFWnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 17:43:13 -0500
Received: from coderock.org ([193.77.147.115]:12720 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261588AbVCFWiU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 17:38:20 -0500
Subject: [patch 5/8] drivers/isdn/tpam/*: convert to pci_register_driver
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, isdn4linux@listserv.isdn4linux.de,
       domen@coderock.org, c.lucas@ifrance.com
From: domen@coderock.org
Date: Sun, 06 Mar 2005 23:38:12 +0100
Message-Id: <20050306223813.129381ED3D@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


convert from pci_module_init to pci_register_driver

Signed-off-by: Christophe Lucas <c.lucas@ifrance.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/isdn/tpam/tpam_main.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/isdn/tpam/tpam_main.c~pci_register_driver-drivers_isdn_tpam drivers/isdn/tpam/tpam_main.c
--- kj/drivers/isdn/tpam/tpam_main.c~pci_register_driver-drivers_isdn_tpam	2005-03-05 16:12:25.000000000 +0100
+++ kj-domen/drivers/isdn/tpam/tpam_main.c	2005-03-05 16:12:25.000000000 +0100
@@ -278,7 +278,7 @@ static struct pci_driver tpam_driver = {
 static int __init tpam_init(void) {
 	int ret;
 	
-	ret = pci_module_init(&tpam_driver);
+	ret = pci_register_driver(&tpam_driver);
 	if (ret)
 		return ret;
 	printk(KERN_INFO "TurboPAM: %d card%s found, driver loaded.\n", 
_
