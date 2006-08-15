Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965109AbWHONRO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965109AbWHONRO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 09:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965246AbWHONRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 09:17:14 -0400
Received: from server6.greatnet.de ([83.133.96.26]:21150 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP id S965109AbWHONRN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 09:17:13 -0400
Message-ID: <44E1C624.4010607@nachtwindheim.de>
Date: Tue, 15 Aug 2006 15:03:32 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.5 (X11/20060725)
MIME-Version: 1.0
To: proski@gnu.org
Cc: orinoco-devel@lists.sourceforge.net, hernes@gibson.dropbear.id.au,
       linux-kernel@vger.kernel.org
Subject: [PATCH] [NETDEV] [ORINOCO] pci_module_init() -> pci_register_driver()
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Henrik Kretzschmar <henne@nachtwindheim.de>

Change pci_module_init() to pci_register_driver().
This pci_module_init() came to the kernel after 2.6.17.

Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>

---

diff -ruN linux-2.6.18-rc4/drivers/net/wireless/orinoco_nortel.c linux/drivers/net/wireless/orinoco_nortel.c
--- linux-2.6.18-rc4/drivers/net/wireless/orinoco_nortel.c	2006-08-11 10:09:08.000000000 +0200
+++ linux/drivers/net/wireless/orinoco_nortel.c	2006-08-15 14:52:31.000000000 +0200
@@ -304,7 +304,7 @@
 static int __init orinoco_nortel_init(void)
 {
 	printk(KERN_DEBUG "%s\n", version);
-	return pci_module_init(&orinoco_nortel_driver);
+	return pci_register_driver(&orinoco_nortel_driver);
 }
 
 static void __exit orinoco_nortel_exit(void)


