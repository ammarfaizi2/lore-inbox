Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965012AbWHQN6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965012AbWHQN6n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964844AbWHQN6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:58:04 -0400
Received: from euridica.enternet.net.pl ([62.233.231.82]:43425 "EHLO
	euridica.enternet.net.pl") by vger.kernel.org with ESMTP
	id S964842AbWHQN0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:26:52 -0400
Date: Thu, 17 Aug 2006 13:27:29 +0000
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 18/75] net: drivers/net/tulip/dmfe.c pci_module_init to pci_register_driver conversion
Message-ID: <20060817132729.18.taAaNA4094.3636.michal@euridica.enternet.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
In-Reply-To: <20060817132638.0.iSIzDm3640.3636.michal@euridica.enternet.net.pl>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/tulip/dmfe.c linux-work2/drivers/net/tulip/dmfe.c
--- linux-work-clean/drivers/net/tulip/dmfe.c	2006-08-16 22:41:00.000000000 +0200
+++ linux-work2/drivers/net/tulip/dmfe.c	2006-08-17 05:18:50.000000000 +0200
@@ -2039,7 +2039,7 @@ static int __init dmfe_init_module(void)
 	if (HPNA_NoiseFloor > 15)
 		HPNA_NoiseFloor = 0;
 
-	rc = pci_module_init(&dmfe_driver);
+	rc = pci_register_driver(&dmfe_driver);
 	if (rc < 0)
 		return rc;
 
