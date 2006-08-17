Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964852AbWHQN4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964852AbWHQN4s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964841AbWHQN0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:26:54 -0400
Received: from euridica.enternet.net.pl ([62.233.231.82]:35745 "EHLO
	euridica.enternet.net.pl") by vger.kernel.org with ESMTP
	id S932502AbWHQN03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:26:29 -0400
Date: Thu, 17 Aug 2006 13:26:58 +0000
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: zambrano@broadcom.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC][PATCH 9/75] net: drivers/net/b44.c pci_module_init to pci_register_driver conversion
Message-ID: <20060817132658.9.MvYVuH3876.3636.michal@euridica.enternet.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
In-Reply-To: <20060817132638.0.iSIzDm3640.3636.michal@euridica.enternet.net.pl>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/b44.c linux-work2/drivers/net/b44.c
--- linux-work-clean/drivers/net/b44.c	2006-08-16 22:40:59.000000000 +0200
+++ linux-work2/drivers/net/b44.c	2006-08-17 05:13:54.000000000 +0200
@@ -2354,7 +2354,7 @@ static int __init b44_init(void)
 	dma_desc_align_mask = ~(dma_desc_align_size - 1);
 	dma_desc_sync_size = max_t(unsigned int, dma_desc_align_size, sizeof(struct dma_desc));
 
-	return pci_module_init(&b44_driver);
+	return pci_register_driver(&b44_driver);
 }
 
 static void __exit b44_cleanup(void)
