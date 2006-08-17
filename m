Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964933AbWHQN3U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964933AbWHQN3U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964937AbWHQN3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:29:19 -0400
Received: from euridica.enternet.net.pl ([62.233.231.82]:33458 "EHLO
	euridica.enternet.net.pl") by vger.kernel.org with ESMTP
	id S964922AbWHQN3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:29:15 -0400
Date: Thu, 17 Aug 2006 13:29:37 +0000
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: ahennessy@mvista.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC][PATCH 65/75] net: drivers/net/tc35815.c pci_module_init to pci_register_driver conversion
Message-ID: <20060817132937.65.HKvqQP5317.3636.michal@euridica.enternet.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
In-Reply-To: <20060817132638.0.iSIzDm3640.3636.michal@euridica.enternet.net.pl>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/tc35815.c linux-work2/drivers/net/tc35815.c
--- linux-work-clean/drivers/net/tc35815.c	2006-08-16 22:41:00.000000000 +0200
+++ linux-work2/drivers/net/tc35815.c	2006-08-17 05:17:42.000000000 +0200
@@ -1725,7 +1725,7 @@ static struct pci_driver tc35815_driver 
 
 static int __init tc35815_init_module(void)
 {
-	return pci_module_init(&tc35815_driver);
+	return pci_register_driver(&tc35815_driver);
 }
 
 static void __exit tc35815_cleanup_module(void)
