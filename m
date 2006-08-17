Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964979AbWHQNjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964979AbWHQNjF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964927AbWHQN3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:29:08 -0400
Received: from euridica.enternet.net.pl ([62.233.231.82]:27058 "EHLO
	euridica.enternet.net.pl") by vger.kernel.org with ESMTP
	id S964925AbWHQN3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:29:01 -0400
Date: Thu, 17 Aug 2006 13:29:28 +0000
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: shemminger@osdl.org
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC][PATCH 61/75] net: drivers/net/skge.c pci_module_init to pci_register_driver conversion
Message-ID: <20060817132928.61.yPYKdp5226.3636.michal@euridica.enternet.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
In-Reply-To: <20060817132638.0.iSIzDm3640.3636.michal@euridica.enternet.net.pl>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/skge.c linux-work2/drivers/net/skge.c
--- linux-work-clean/drivers/net/skge.c	2006-08-16 22:41:17.000000000 +0200
+++ linux-work2/drivers/net/skge.c	2006-08-17 05:17:04.000000000 +0200
@@ -3510,7 +3510,7 @@ static struct pci_driver skge_driver = {
 
 static int __init skge_init_module(void)
 {
-	return pci_module_init(&skge_driver);
+	return pci_register_driver(&skge_driver);
 }
 
 static void __exit skge_cleanup_module(void)
