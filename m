Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261560AbVCFWgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261560AbVCFWgj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 17:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261524AbVCFWgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 17:36:20 -0500
Received: from coderock.org ([193.77.147.115]:45999 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261562AbVCFWfv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 17:35:51 -0500
Subject: [patch 1/1] drivers/char/watchdog/*: convert to pci_register_driver
To: wim@iguana.be
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, c.lucas@ifrance.com
From: domen@coderock.org
Date: Sun, 06 Mar 2005 23:35:44 +0100
Message-Id: <20050306223544.CDA321EC90@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


convert from pci_module_init to pci_register_driver

Signed-off-by: Christophe Lucas <c.lucas@ifrance.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/char/watchdog/pcwd_pci.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/char/watchdog/pcwd_pci.c~pci_register_driver-drivers_char_watchdog drivers/char/watchdog/pcwd_pci.c
--- kj/drivers/char/watchdog/pcwd_pci.c~pci_register_driver-drivers_char_watchdog	2005-03-05 16:12:18.000000000 +0100
+++ kj-domen/drivers/char/watchdog/pcwd_pci.c	2005-03-05 16:12:18.000000000 +0100
@@ -659,7 +659,7 @@ static int __init pcipcwd_init_module(vo
 {
 	spin_lock_init (&pcipcwd_private.io_lock);
 
-	return pci_module_init(&pcipcwd_driver);
+	return pci_register_driver(&pcipcwd_driver);
 }
 
 static void __exit pcipcwd_cleanup_module(void)
_
