Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964894AbWHQNoF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964894AbWHQNoF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964990AbWHQNoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:44:04 -0400
Received: from euridica.enternet.net.pl ([62.233.231.82]:14242 "EHLO
	euridica.enternet.net.pl") by vger.kernel.org with ESMTP
	id S964896AbWHQN2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:28:25 -0400
Date: Thu, 17 Aug 2006 13:29:00 +0000
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: tsbogend@alpha.franken.de
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC][PATCH 52/75] net: drivers/net/pcnet32.c pci_module_init to pci_register_driver conversion
Message-ID: <20060817132900.52.txQQul4978.3636.michal@euridica.enternet.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
In-Reply-To: <20060817132638.0.iSIzDm3640.3636.michal@euridica.enternet.net.pl>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/pcnet32.c linux-work2/drivers/net/pcnet32.c
--- linux-work-clean/drivers/net/pcnet32.c	2006-08-16 22:41:00.000000000 +0200
+++ linux-work2/drivers/net/pcnet32.c	2006-08-17 05:15:52.000000000 +0200
@@ -2969,7 +2969,7 @@ static int __init pcnet32_init_module(vo
 		tx_start = tx_start_pt;
 
 	/* find the PCI devices */
-	if (!pci_module_init(&pcnet32_driver))
+	if (!pci_register_driver(&pcnet32_driver))
 		pcnet32_have_pci = 1;
 
 	/* should we find any remaining VLbus devices ? */
