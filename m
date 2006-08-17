Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964921AbWHQNi3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964921AbWHQNi3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964977AbWHQNi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:38:26 -0400
Received: from euridica.enternet.net.pl ([62.233.231.82]:657 "EHLO
	euridica.enternet.net.pl") by vger.kernel.org with ESMTP
	id S964921AbWHQNiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:38:12 -0400
Date: Thu, 17 Aug 2006 13:27:19 +0000
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC][PATCH 14/75] net: drivers/net/tulip/de2104x.c pci_module_init to pci_register_driver conversion
Message-ID: <20060817132719.14.HYHEKd4004.3636.michal@euridica.enternet.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
In-Reply-To: <20060817132638.0.iSIzDm3640.3636.michal@euridica.enternet.net.pl>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/tulip/de2104x.c linux-work2/drivers/net/tulip/de2104x.c
--- linux-work-clean/drivers/net/tulip/de2104x.c	2006-08-16 22:41:00.000000000 +0200
+++ linux-work2/drivers/net/tulip/de2104x.c	2006-08-17 05:18:32.000000000 +0200
@@ -2172,7 +2172,7 @@ static int __init de_init (void)
 #ifdef MODULE
 	printk("%s", version);
 #endif
-	return pci_module_init (&de_driver);
+	return pci_register_driver(&de_driver);
 }
 
 static void __exit de_exit (void)
