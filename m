Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964996AbWHQNn7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964996AbWHQNn7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964908AbWHQN2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:28:36 -0400
Received: from euridica.enternet.net.pl ([62.233.231.82]:16034 "EHLO
	euridica.enternet.net.pl") by vger.kernel.org with ESMTP
	id S964901AbWHQN2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:28:31 -0400
Date: Thu, 17 Aug 2006 13:28:06 +0000
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: ipw2100-admin@linux.intel.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC][PATCH 32/75] net: drivers/net/wireless/ipw2200.c pci_module_init to pci_register_driver conversion
Message-ID: <20060817132806.32.NwBxBR4470.3636.michal@euridica.enternet.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
In-Reply-To: <20060817132638.0.iSIzDm3640.3636.michal@euridica.enternet.net.pl>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/wireless/ipw2200.c linux-work2/drivers/net/wireless/ipw2200.c
--- linux-work-clean/drivers/net/wireless/ipw2200.c	2006-08-16 22:41:17.000000000 +0200
+++ linux-work2/drivers/net/wireless/ipw2200.c	2006-08-17 05:20:17.000000000 +0200
@@ -11753,7 +11753,7 @@ static int __init ipw_init(void)
 	printk(KERN_INFO DRV_NAME ": " DRV_DESCRIPTION ", " DRV_VERSION "\n");
 	printk(KERN_INFO DRV_NAME ": " DRV_COPYRIGHT "\n");
 
-	ret = pci_module_init(&ipw_driver);
+	ret = pci_register_driver(&ipw_driver);
 	if (ret) {
 		IPW_ERROR("Unable to initialize PCI module\n");
 		return ret;
