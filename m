Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964919AbWHQNjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964919AbWHQNjx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964982AbWHQNjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:39:41 -0400
Received: from euridica.enternet.net.pl ([62.233.231.82]:20402 "EHLO
	euridica.enternet.net.pl") by vger.kernel.org with ESMTP
	id S964917AbWHQN2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:28:49 -0400
Date: Thu, 17 Aug 2006 13:29:11 +0000
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: carstenl@mips.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC][PATCH 56/75] net: drivers/net/saa9730.c pci_module_init to pci_register_driver conversion
Message-ID: <20060817132911.56.MeCpaG5071.3636.michal@euridica.enternet.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
In-Reply-To: <20060817132638.0.iSIzDm3640.3636.michal@euridica.enternet.net.pl>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/saa9730.c linux-work2/drivers/net/saa9730.c
--- linux-work-clean/drivers/net/saa9730.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-work2/drivers/net/saa9730.c	2006-08-17 05:16:21.000000000 +0200
@@ -1131,7 +1131,7 @@ static struct pci_driver saa9730_driver 
 
 static int __init saa9730_init(void)
 {
-	return pci_module_init(&saa9730_driver);
+	return pci_register_driver(&saa9730_driver);
 }
 
 static void __exit saa9730_cleanup(void)
