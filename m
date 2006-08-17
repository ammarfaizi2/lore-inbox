Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964959AbWHQNb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964959AbWHQNb7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964958AbWHQNb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:31:58 -0400
Received: from euridica.enternet.net.pl ([62.233.231.82]:48562 "EHLO
	euridica.enternet.net.pl") by vger.kernel.org with ESMTP
	id S964957AbWHQNbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:31:46 -0400
Date: Thu, 17 Aug 2006 13:26:48 +0000
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC][PATCH 4/75] net: drivers/net/8139too.c pci_module_init to pci_register_driver conversion
Message-ID: <20060817132648.4.PiPgmQ3737.3636.michal@euridica.enternet.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
In-Reply-To: <20060817132638.0.iSIzDm3640.3636.michal@euridica.enternet.net.pl>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/8139too.c linux-work2/drivers/net/8139too.c
--- linux-work-clean/drivers/net/8139too.c	2006-08-16 22:40:59.000000000 +0200
+++ linux-work2/drivers/net/8139too.c	2006-08-17 05:13:30.000000000 +0200
@@ -2629,7 +2629,7 @@ static int __init rtl8139_init_module (v
 	printk (KERN_INFO RTL8139_DRIVER_NAME "\n");
 #endif
 
-	return pci_module_init (&rtl8139_pci_driver);
+	return pci_register_driver(&rtl8139_pci_driver);
 }
 
 
