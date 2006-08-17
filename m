Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965006AbWHQN4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965006AbWHQN4A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964998AbWHQNzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:55:33 -0400
Received: from euridica.enternet.net.pl ([62.233.231.82]:47009 "EHLO
	euridica.enternet.net.pl") by vger.kernel.org with ESMTP
	id S964849AbWHQN1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:27:04 -0400
Date: Thu, 17 Aug 2006 13:27:30 +0000
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: romieu@cogenit.fr
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC][PATCH 19/75] net: drivers/net/wan/dscc4.c pci_module_init to pci_register_driver conversion
Message-ID: <20060817132730.19.syFWXZ4113.3636.michal@euridica.enternet.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
In-Reply-To: <20060817132638.0.iSIzDm3640.3636.michal@euridica.enternet.net.pl>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/wan/dscc4.c linux-work2/drivers/net/wan/dscc4.c
--- linux-work-clean/drivers/net/wan/dscc4.c	2006-08-16 22:41:00.000000000 +0200
+++ linux-work2/drivers/net/wan/dscc4.c	2006-08-17 05:19:30.000000000 +0200
@@ -2062,7 +2062,7 @@ static struct pci_driver dscc4_driver = 
 
 static int __init dscc4_init_module(void)
 {
-	return pci_module_init(&dscc4_driver);
+	return pci_register_driver(&dscc4_driver);
 }
 
 static void __exit dscc4_cleanup_module(void)
