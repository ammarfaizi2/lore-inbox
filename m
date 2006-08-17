Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964877AbWHQN1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964877AbWHQN1q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964868AbWHQN1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:27:45 -0400
Received: from euridica.enternet.net.pl ([62.233.231.82]:62113 "EHLO
	euridica.enternet.net.pl") by vger.kernel.org with ESMTP
	id S964869AbWHQN1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:27:38 -0400
Date: Thu, 17 Aug 2006 13:28:14 +0000
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: mikep@linuxtr.net
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC][PATCH 36/75] net: drivers/net/tokenring/lanstreamer.c pci_module_init to pci_register_driver conversion
Message-ID: <20060817132814.36.nhiybj4565.3636.michal@euridica.enternet.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
In-Reply-To: <20060817132638.0.iSIzDm3640.3636.michal@euridica.enternet.net.pl>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/tokenring/lanstreamer.c linux-work2/drivers/net/tokenring/lanstreamer.c
--- linux-work-clean/drivers/net/tokenring/lanstreamer.c	2006-08-17 00:10:47.000000000 +0200
+++ linux-work2/drivers/net/tokenring/lanstreamer.c	2006-08-17 05:18:15.000000000 +0200
@@ -1998,7 +1998,7 @@ static struct pci_driver streamer_pci_dr
 };
 
 static int __init streamer_init_module(void) {
-  return pci_module_init(&streamer_pci_driver);
+  return pci_register_driver(&streamer_pci_driver);
 }
 
 static void __exit streamer_cleanup_module(void) {
