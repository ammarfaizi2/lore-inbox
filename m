Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261587AbVCFWpc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261587AbVCFWpc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 17:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261594AbVCFWng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 17:43:36 -0500
Received: from coderock.org ([193.77.147.115]:11440 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261587AbVCFWiS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 17:38:18 -0500
Subject: [patch 4/8] drivers/isdn/hardware/avm/*: convert to pci_register_driver
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, isdn4linux@listserv.isdn4linux.de,
       domen@coderock.org, c.lucas@ifrance.com
From: domen@coderock.org
Date: Sun, 06 Mar 2005 23:38:09 +0100
Message-Id: <20050306223809.E65A51EC90@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


convert from pci_module_init to pci_register_driver

Signed-off-by: Christophe Lucas <c.lucas@ifrance.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/isdn/hardware/avm/b1pci.c |    2 +-
 kj-domen/drivers/isdn/hardware/avm/c4.c    |    2 +-
 kj-domen/drivers/isdn/hardware/avm/t1pci.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff -puN drivers/isdn/hardware/avm/b1pci.c~pci_register_driver-drivers_isdn_hardware_avm drivers/isdn/hardware/avm/b1pci.c
--- kj/drivers/isdn/hardware/avm/b1pci.c~pci_register_driver-drivers_isdn_hardware_avm	2005-03-05 16:12:24.000000000 +0100
+++ kj-domen/drivers/isdn/hardware/avm/b1pci.c	2005-03-05 16:12:24.000000000 +0100
@@ -391,7 +391,7 @@ static int __init b1pci_init(void)
 		strcpy(rev, "1.0");
 
 
-	err = pci_module_init(&b1pci_pci_driver);
+	err = pci_register_driver(&b1pci_pci_driver);
 	if (!err) {
 		strlcpy(capi_driver_b1pci.revision, rev, 32);
 		register_capi_driver(&capi_driver_b1pci);
diff -puN drivers/isdn/hardware/avm/c4.c~pci_register_driver-drivers_isdn_hardware_avm drivers/isdn/hardware/avm/c4.c
--- kj/drivers/isdn/hardware/avm/c4.c~pci_register_driver-drivers_isdn_hardware_avm	2005-03-05 16:12:24.000000000 +0100
+++ kj-domen/drivers/isdn/hardware/avm/c4.c	2005-03-05 16:12:24.000000000 +0100
@@ -1288,7 +1288,7 @@ static int __init c4_init(void)
 	} else
 		strcpy(rev, "1.0");
 
-	err = pci_module_init(&c4_pci_driver);
+	err = pci_register_driver(&c4_pci_driver);
 	if (!err) {
 		strlcpy(capi_driver_c2.revision, rev, 32);
 		register_capi_driver(&capi_driver_c2);
diff -puN drivers/isdn/hardware/avm/t1pci.c~pci_register_driver-drivers_isdn_hardware_avm drivers/isdn/hardware/avm/t1pci.c
--- kj/drivers/isdn/hardware/avm/t1pci.c~pci_register_driver-drivers_isdn_hardware_avm	2005-03-05 16:12:24.000000000 +0100
+++ kj-domen/drivers/isdn/hardware/avm/t1pci.c	2005-03-05 16:12:24.000000000 +0100
@@ -241,7 +241,7 @@ static int __init t1pci_init(void)
 	} else
 		strcpy(rev, "1.0");
 
-	err = pci_module_init(&t1pci_pci_driver);
+	err = pci_register_driver(&t1pci_pci_driver);
 	if (!err) {
 		strlcpy(capi_driver_t1pci.revision, rev, 32);
 		register_capi_driver(&capi_driver_t1pci);
_
