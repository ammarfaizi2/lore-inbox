Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964867AbWHQN70@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964867AbWHQN70 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932500AbWHQN0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:26:19 -0400
Received: from euridica.enternet.net.pl ([62.233.231.82]:30369 "EHLO
	euridica.enternet.net.pl") by vger.kernel.org with ESMTP
	id S932498AbWHQN0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:26:13 -0400
Date: Thu, 17 Aug 2006 13:26:42 +0000
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: becker@scyld.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC][PATCH 2/75] net: drivers/net/3c59x.c pci_module_init to pci_register_driver conversion
Message-ID: <20060817132642.2.nLUCxk3688.3636.michal@euridica.enternet.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
In-Reply-To: <20060817132638.0.iSIzDm3640.3636.michal@euridica.enternet.net.pl>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/3c59x.c linux-work2/drivers/net/3c59x.c
--- linux-work-clean/drivers/net/3c59x.c	2006-08-16 22:41:16.000000000 +0200
+++ linux-work2/drivers/net/3c59x.c	2006-08-17 05:13:16.000000000 +0200
@@ -3170,7 +3170,7 @@ static int __init vortex_init(void)
 {
 	int pci_rc, eisa_rc;
 
-	pci_rc = pci_module_init(&vortex_driver);
+	pci_rc = pci_register_driver(&vortex_driver);
 	eisa_rc = vortex_eisa_init();
 
 	if (pci_rc == 0)
