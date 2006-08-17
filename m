Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932507AbWHQN0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932507AbWHQN0r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932509AbWHQN0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:26:46 -0400
Received: from euridica.enternet.net.pl ([62.233.231.82]:38305 "EHLO
	euridica.enternet.net.pl") by vger.kernel.org with ESMTP
	id S932505AbWHQN0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:26:38 -0400
Date: Thu, 17 Aug 2006 13:27:07 +0000
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: mj@ucw.cz
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC][PATCH 12/75] net: drivers/net/arcnet/com20020-pci.c pci_module_init to pci_register_driver conversion
Message-ID: <20060817132707.12.qhNVUc3952.3636.michal@euridica.enternet.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
In-Reply-To: <20060817132638.0.iSIzDm3640.3636.michal@euridica.enternet.net.pl>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/arcnet/com20020-pci.c linux-work2/drivers/net/arcnet/com20020-pci.c
--- linux-work-clean/drivers/net/arcnet/com20020-pci.c	2006-08-16 22:41:17.000000000 +0200
+++ linux-work2/drivers/net/arcnet/com20020-pci.c	2006-08-17 05:13:48.000000000 +0200
@@ -178,7 +178,7 @@ static struct pci_driver com20020pci_dri
 static int __init com20020pci_init(void)
 {
 	BUGLVL(D_NORMAL) printk(VERSION);
-	return pci_module_init(&com20020pci_driver);
+	return pci_register_driver(&com20020pci_driver);
 }
 
 static void __exit com20020pci_cleanup(void)
