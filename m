Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964859AbWHQN2T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964859AbWHQN2T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964894AbWHQN2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:28:18 -0400
Received: from euridica.enternet.net.pl ([62.233.231.82]:2466 "EHLO
	euridica.enternet.net.pl") by vger.kernel.org with ESMTP
	id S964882AbWHQN1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:27:53 -0400
Date: Thu, 17 Aug 2006 13:28:28 +0000
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: p_gortmaker@yahoo.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC][PATCH 41/75] net: drivers/net/ne2k-pci.c pci_module_init to pci_register_driver conversion
Message-ID: <20060817132828.41.eNlfeS4675.3636.michal@euridica.enternet.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
In-Reply-To: <20060817132638.0.iSIzDm3640.3636.michal@euridica.enternet.net.pl>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/ne2k-pci.c linux-work2/drivers/net/ne2k-pci.c
--- linux-work-clean/drivers/net/ne2k-pci.c	2006-08-16 22:41:00.000000000 +0200
+++ linux-work2/drivers/net/ne2k-pci.c	2006-08-17 05:15:27.000000000 +0200
@@ -702,7 +702,7 @@ static int __init ne2k_pci_init(void)
 #ifdef MODULE
 	printk(version);
 #endif
-	return pci_module_init (&ne2k_driver);
+	return pci_register_driver(&ne2k_driver);
 }
 
 
