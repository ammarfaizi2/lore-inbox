Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964848AbWHQN6B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964848AbWHQN6B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:58:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964844AbWHQN0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:26:52 -0400
Received: from euridica.enternet.net.pl ([62.233.231.82]:36769 "EHLO
	euridica.enternet.net.pl") by vger.kernel.org with ESMTP
	id S932503AbWHQN0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:26:34 -0400
Date: Thu, 17 Aug 2006 13:27:00 +0000
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: mchan@broadcom.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC][PATCH 10/75] net: drivers/net/bnx2.c pci_module_init to pci_register_driver conversion
Message-ID: <20060817132700.10.oTCEXL3895.3636.michal@euridica.enternet.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
In-Reply-To: <20060817132638.0.iSIzDm3640.3636.michal@euridica.enternet.net.pl>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/bnx2.c linux-work2/drivers/net/bnx2.c
--- linux-work-clean/drivers/net/bnx2.c	2006-08-16 22:41:17.000000000 +0200
+++ linux-work2/drivers/net/bnx2.c	2006-08-17 05:14:02.000000000 +0200
@@ -6015,7 +6015,7 @@ static struct pci_driver bnx2_pci_driver
 
 static int __init bnx2_init(void)
 {
-	return pci_module_init(&bnx2_pci_driver);
+	return pci_register_driver(&bnx2_pci_driver);
 }
 
 static void __exit bnx2_cleanup(void)
