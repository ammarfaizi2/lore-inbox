Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964935AbWHQNhQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964935AbWHQNhQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964972AbWHQNgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:36:52 -0400
Received: from euridica.enternet.net.pl ([62.233.231.82]:145 "EHLO
	euridica.enternet.net.pl") by vger.kernel.org with ESMTP
	id S964973AbWHQNgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:36:48 -0400
Date: Thu, 17 Aug 2006 13:29:45 +0000
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC][PATCH 68/75] net: drivers/net/tulip/tulip_core.c pci_module_init to pci_register_driver conversion
Message-ID: <20060817132945.68.cHhBof5402.3636.michal@euridica.enternet.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
In-Reply-To: <20060817132638.0.iSIzDm3640.3636.michal@euridica.enternet.net.pl>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/tulip/tulip_core.c linux-work2/drivers/net/tulip/tulip_core.c
--- linux-work-clean/drivers/net/tulip/tulip_core.c	2006-08-16 22:41:17.000000000 +0200
+++ linux-work2/drivers/net/tulip/tulip_core.c	2006-08-17 05:18:56.000000000 +0200
@@ -1860,7 +1860,7 @@ static int __init tulip_init (void)
 	tulip_max_interrupt_work = max_interrupt_work;
 
 	/* probe for and init boards */
-	return pci_module_init (&tulip_driver);
+	return pci_register_driver(&tulip_driver);
 }
 
 
