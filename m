Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964963AbWHQNcF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964963AbWHQNcF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964958AbWHQNcB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:32:01 -0400
Received: from euridica.enternet.net.pl ([62.233.231.82]:48050 "EHLO
	euridica.enternet.net.pl") by vger.kernel.org with ESMTP
	id S964939AbWHQNbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:31:39 -0400
Date: Thu, 17 Aug 2006 13:28:38 +0000
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: proski@gnu.org
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC][PATCH 45/75] net: drivers/net/wireless/orinoco_pci.c pci_module_init to pci_register_driver conversion
Message-ID: <20060817132838.45.UcPjPU4769.3636.michal@euridica.enternet.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
In-Reply-To: <20060817132638.0.iSIzDm3640.3636.michal@euridica.enternet.net.pl>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/wireless/orinoco_pci.c linux-work2/drivers/net/wireless/orinoco_pci.c
--- linux-work-clean/drivers/net/wireless/orinoco_pci.c	2006-08-16 22:41:00.000000000 +0200
+++ linux-work2/drivers/net/wireless/orinoco_pci.c	2006-08-17 05:20:26.000000000 +0200
@@ -244,7 +244,7 @@ MODULE_LICENSE("Dual MPL/GPL");
 static int __init orinoco_pci_init(void)
 {
 	printk(KERN_DEBUG "%s\n", version);
-	return pci_module_init(&orinoco_pci_driver);
+	return pci_register_driver(&orinoco_pci_driver);
 }
 
 static void __exit orinoco_pci_exit(void)
