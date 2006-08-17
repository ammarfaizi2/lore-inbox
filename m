Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964931AbWHQNbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964931AbWHQNbY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964938AbWHQN3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:29:22 -0400
Received: from euridica.enternet.net.pl ([62.233.231.82]:33714 "EHLO
	euridica.enternet.net.pl") by vger.kernel.org with ESMTP
	id S964931AbWHQN3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:29:16 -0400
Date: Thu, 17 Aug 2006 13:29:49 +0000
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: rl@hellgate.ch
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC][PATCH 70/75] net: drivers/net/via-rhine.c pci_module_init to pci_register_driver conversion
Message-ID: <20060817132949.70.vAMjdA5456.3636.michal@euridica.enternet.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
In-Reply-To: <20060817132638.0.iSIzDm3640.3636.michal@euridica.enternet.net.pl>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/via-rhine.c linux-work2/drivers/net/via-rhine.c
--- linux-work-clean/drivers/net/via-rhine.c	2006-08-16 22:41:17.000000000 +0200
+++ linux-work2/drivers/net/via-rhine.c	2006-08-17 05:19:18.000000000 +0200
@@ -2005,7 +2005,7 @@ static int __init rhine_init(void)
 #ifdef MODULE
 	printk(version);
 #endif
-	return pci_module_init(&rhine_driver);
+	return pci_register_driver(&rhine_driver);
 }
 
 
