Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964871AbWHQNwo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964871AbWHQNwo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964870AbWHQN1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:27:36 -0400
Received: from euridica.enternet.net.pl ([62.233.231.82]:51617 "EHLO
	euridica.enternet.net.pl") by vger.kernel.org with ESMTP
	id S964859AbWHQN1P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:27:15 -0400
Date: Thu, 17 Aug 2006 13:27:41 +0000
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: saw@saw.sw.com.sg
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC][PATCH 22/75] net: drivers/net/eepro100.c pci_module_init to pci_register_driver conversion
Message-ID: <20060817132741.22.yzQssS4186.3636.michal@euridica.enternet.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
In-Reply-To: <20060817132638.0.iSIzDm3640.3636.michal@euridica.enternet.net.pl>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/eepro100.c linux-work2/drivers/net/eepro100.c
--- linux-work-clean/drivers/net/eepro100.c	2006-08-16 22:41:00.000000000 +0200
+++ linux-work2/drivers/net/eepro100.c	2006-08-17 05:14:42.000000000 +0200
@@ -2385,7 +2385,7 @@ static int __init eepro100_init_module(v
 #ifdef MODULE
 	printk(version);
 #endif
-	return pci_module_init(&eepro100_driver);
+	return pci_register_driver(&eepro100_driver);
 }
 
 static void __exit eepro100_cleanup_module(void)
