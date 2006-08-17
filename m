Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964862AbWHQN1f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964862AbWHQN1f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964869AbWHQN1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:27:34 -0400
Received: from euridica.enternet.net.pl ([62.233.231.82]:56225 "EHLO
	euridica.enternet.net.pl") by vger.kernel.org with ESMTP
	id S964860AbWHQN10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:27:26 -0400
Date: Thu, 17 Aug 2006 13:27:56 +0000
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: perex@suse.cz
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC][PATCH 28/75] net: drivers/net/hp100.c pci_module_init to pci_register_driver conversion
Message-ID: <20060817132756.28.huuPOV4353.3636.michal@euridica.enternet.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
In-Reply-To: <20060817132638.0.iSIzDm3640.3636.michal@euridica.enternet.net.pl>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/hp100.c linux-work2/drivers/net/hp100.c
--- linux-work-clean/drivers/net/hp100.c	2006-08-16 22:41:17.000000000 +0200
+++ linux-work2/drivers/net/hp100.c	2006-08-17 05:15:07.000000000 +0200
@@ -3031,7 +3031,7 @@ static int __init hp100_module_init(void
 		goto out2;
 #endif
 #ifdef CONFIG_PCI
-	err = pci_module_init(&hp100_pci_driver);
+	err = pci_register_driver(&hp100_pci_driver);
 	if (err && err != -ENODEV) 
 		goto out3;
 #endif
