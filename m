Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964870AbWHQNxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964870AbWHQNxV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964861AbWHQN1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:27:32 -0400
Received: from euridica.enternet.net.pl ([62.233.231.82]:51873 "EHLO
	euridica.enternet.net.pl") by vger.kernel.org with ESMTP
	id S964862AbWHQN1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:27:16 -0400
Date: Thu, 17 Aug 2006 13:27:52 +0000
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 26/75] net: drivers/net/forcedeth.c pci_module_init to pci_register_driver conversion
Message-ID: <20060817132752.26.EHLcWf4305.3636.michal@euridica.enternet.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
In-Reply-To: <20060817132638.0.iSIzDm3640.3636.michal@euridica.enternet.net.pl>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/forcedeth.c linux-work2/drivers/net/forcedeth.c
--- linux-work-clean/drivers/net/forcedeth.c	2006-08-16 22:41:17.000000000 +0200
+++ linux-work2/drivers/net/forcedeth.c	2006-08-17 05:15:01.000000000 +0200
@@ -4668,7 +4668,7 @@ static struct pci_driver driver = {
 static int __init init_nic(void)
 {
 	printk(KERN_INFO "forcedeth.c: Reverse Engineered nForce ethernet driver. Version %s.\n", FORCEDETH_VERSION);
-	return pci_module_init(&driver);
+	return pci_register_driver(&driver);
 }
 
 static void __exit exit_nic(void)
