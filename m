Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267167AbSKEBtS>; Mon, 4 Nov 2002 20:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269750AbSKEBtS>; Mon, 4 Nov 2002 20:49:18 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:16095 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S267167AbSKEBsf>;
	Mon, 4 Nov 2002 20:48:35 -0500
Date: Mon, 4 Nov 2002 17:55:09 -0800
To: irda-users@lists.sourceforge.net, Jeff Garzik <jgarzik@mandrakesoft.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5] : ir254_donauboe_init.diff
Message-ID: <20021105015509.GC8849@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir254_donauboe_init.diff :
------------------------
		<Thanks to Adrian Bunk>
	o [FEATURE] Fix exported function name to avoid clash with toshoboe


diff -u -p linux/drivers/net/irda/donauboe.d4.c linux/drivers/net/irda/donauboe.c
--- linux/drivers/net/irda/donauboe.d4.c	Thu Oct 31 13:57:31 2002
+++ linux/drivers/net/irda/donauboe.c	Thu Oct 31 14:03:05 2002
@@ -1826,25 +1826,25 @@ toshoboe_wakeup (struct pci_dev *pci_dev
 }
 
 static struct pci_driver toshoboe_pci_driver = {
-  name		: "toshoboe",
-  id_table	: toshoboe_pci_tbl,
-  probe		: toshoboe_open,
-  remove	: toshoboe_close,
-  suspend	: toshoboe_gotosleep,
-  resume	: toshoboe_wakeup 
+  .name		= "toshoboe",
+  .id_table	= toshoboe_pci_tbl,
+  .probe	= toshoboe_open,
+  .remove	= toshoboe_close,
+  .suspend	= toshoboe_gotosleep,
+  .resume	= toshoboe_wakeup 
 };
 
 int __init
-toshoboe_init (void)
+donauboe_init (void)
 {
   return pci_module_init(&toshoboe_pci_driver);
 }
 
 STATIC void __exit
-toshoboe_cleanup (void)
+donauboe_cleanup (void)
 {
   pci_unregister_driver(&toshoboe_pci_driver);
 }
 
-module_init(toshoboe_init);
-module_exit(toshoboe_cleanup);
+module_init(donauboe_init);
+module_exit(donauboe_cleanup);
