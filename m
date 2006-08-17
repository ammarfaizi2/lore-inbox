Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964926AbWHQNgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964926AbWHQNgv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964967AbWHQNgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:36:38 -0400
Received: from euridica.enternet.net.pl ([62.233.231.82]:34994 "EHLO
	euridica.enternet.net.pl") by vger.kernel.org with ESMTP
	id S964926AbWHQN3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:29:19 -0400
Date: Thu, 17 Aug 2006 13:29:53 +0000
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: khc@pm.waw.pl
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC][PATCH 72/75] net: drivers/net/wan/wanxl.c pci_module_init to pci_register_driver conversion
Message-ID: <20060817132953.72.KFiEzs5518.3636.michal@euridica.enternet.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
In-Reply-To: <20060817132638.0.iSIzDm3640.3636.michal@euridica.enternet.net.pl>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/wan/wanxl.c linux-work2/drivers/net/wan/wanxl.c
--- linux-work-clean/drivers/net/wan/wanxl.c	2006-08-16 22:41:00.000000000 +0200
+++ linux-work2/drivers/net/wan/wanxl.c	2006-08-17 05:20:02.000000000 +0200
@@ -837,7 +837,7 @@ static int __init wanxl_init_module(void
 #ifdef MODULE
 	printk(KERN_INFO "%s\n", version);
 #endif
-	return pci_module_init(&wanxl_pci_driver);
+	return pci_register_driver(&wanxl_pci_driver);
 }
 
 static void __exit wanxl_cleanup_module(void)
