Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964907AbWHQN2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964907AbWHQN2g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964892AbWHQN21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:28:27 -0400
Received: from euridica.enternet.net.pl ([62.233.231.82]:11938 "EHLO
	euridica.enternet.net.pl") by vger.kernel.org with ESMTP
	id S964893AbWHQN2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:28:20 -0400
Date: Thu, 17 Aug 2006 13:28:42 +0000
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: joerg@dorchain.net
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC][PATCH 47/75] net: drivers/net/wireless/orinoco_tmd.c pci_module_init to pci_register_driver conversion
Message-ID: <20060817132842.47.NURIpB4835.3636.michal@euridica.enternet.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
In-Reply-To: <20060817132638.0.iSIzDm3640.3636.michal@euridica.enternet.net.pl>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/wireless/orinoco_tmd.c linux-work2/drivers/net/wireless/orinoco_tmd.c
--- linux-work-clean/drivers/net/wireless/orinoco_tmd.c	2006-08-16 22:41:00.000000000 +0200
+++ linux-work2/drivers/net/wireless/orinoco_tmd.c	2006-08-17 05:20:37.000000000 +0200
@@ -228,7 +228,7 @@ MODULE_LICENSE("Dual MPL/GPL");
 static int __init orinoco_tmd_init(void)
 {
 	printk(KERN_DEBUG "%s\n", version);
-	return pci_module_init(&orinoco_tmd_driver);
+	return pci_register_driver(&orinoco_tmd_driver);
 }
 
 static void __exit orinoco_tmd_exit(void)
