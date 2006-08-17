Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964886AbWHQNtl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964886AbWHQNtl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964910AbWHQNth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:49:37 -0400
Received: from euridica.enternet.net.pl ([62.233.231.82]:2210 "EHLO
	euridica.enternet.net.pl") by vger.kernel.org with ESMTP
	id S964881AbWHQN1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:27:53 -0400
Date: Thu, 17 Aug 2006 13:28:24 +0000
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: laforge@gnumonks.org
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC][PATCH 40/75] net: drivers/net/natsemi.c pci_module_init to pci_register_driver conversion
Message-ID: <20060817132824.40.ADmmVk4649.3636.michal@euridica.enternet.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
In-Reply-To: <20060817132638.0.iSIzDm3640.3636.michal@euridica.enternet.net.pl>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/natsemi.c linux-work2/drivers/net/natsemi.c
--- linux-work-clean/drivers/net/natsemi.c	2006-08-16 22:41:17.000000000 +0200
+++ linux-work2/drivers/net/natsemi.c	2006-08-17 05:15:22.000000000 +0200
@@ -3275,7 +3275,7 @@ static int __init natsemi_init_mod (void
 	printk(version);
 #endif
 
-	return pci_module_init (&natsemi_driver);
+	return pci_register_driver(&natsemi_driver);
 }
 
 static void __exit natsemi_exit_mod (void)
