Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964893AbWHQNmc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964893AbWHQNmc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964910AbWHQN2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:28:44 -0400
Received: from euridica.enternet.net.pl ([62.233.231.82]:15010 "EHLO
	euridica.enternet.net.pl") by vger.kernel.org with ESMTP
	id S964899AbWHQN23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:28:29 -0400
Date: Thu, 17 Aug 2006 13:28:52 +0000
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: pc300@cyclades.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC][PATCH 49/75] net: drivers/net/wan/pc300_drv.c pci_module_init to pci_register_driver conversion
Message-ID: <20060817132852.49.EjbOTA4899.3636.michal@euridica.enternet.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
In-Reply-To: <20060817132638.0.iSIzDm3640.3636.michal@euridica.enternet.net.pl>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/wan/pc300_drv.c linux-work2/drivers/net/wan/pc300_drv.c
--- linux-work-clean/drivers/net/wan/pc300_drv.c	2006-08-16 22:41:00.000000000 +0200
+++ linux-work2/drivers/net/wan/pc300_drv.c	2006-08-17 05:19:51.000000000 +0200
@@ -3677,7 +3677,7 @@ static struct pci_driver cpc_driver = {
 
 static int __init cpc_init(void)
 {
-	return pci_module_init(&cpc_driver);
+	return pci_register_driver(&cpc_driver);
 }
 
 static void __exit cpc_cleanup_module(void)
