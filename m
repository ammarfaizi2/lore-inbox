Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964901AbWHQNn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964901AbWHQNn0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964904AbWHQN2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:28:42 -0400
Received: from euridica.enternet.net.pl ([62.233.231.82]:15778 "EHLO
	euridica.enternet.net.pl") by vger.kernel.org with ESMTP
	id S964893AbWHQN2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:28:31 -0400
Date: Thu, 17 Aug 2006 13:28:03 +0000
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: ipw2100-admin@linux.intel.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC][PATCH 31/75] net: drivers/net/wireless/ipw2100.c pci_module_init to pci_register_driver conversion
Message-ID: <20060817132803.31.sQszUH4440.3636.michal@euridica.enternet.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
In-Reply-To: <20060817132638.0.iSIzDm3640.3636.michal@euridica.enternet.net.pl>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/wireless/ipw2100.c linux-work2/drivers/net/wireless/ipw2100.c
--- linux-work-clean/drivers/net/wireless/ipw2100.c	2006-08-16 22:41:00.000000000 +0200
+++ linux-work2/drivers/net/wireless/ipw2100.c	2006-08-17 05:20:12.000000000 +0200
@@ -6531,7 +6531,7 @@ static int __init ipw2100_init(void)
 	printk(KERN_INFO DRV_NAME ": %s, %s\n", DRV_DESCRIPTION, DRV_VERSION);
 	printk(KERN_INFO DRV_NAME ": %s\n", DRV_COPYRIGHT);
 
-	ret = pci_module_init(&ipw2100_pci_driver);
+	ret = pci_register_driver(&ipw2100_pci_driver);
 
 #ifdef CONFIG_IPW2100_DEBUG
 	ipw2100_debug_level = debug;
