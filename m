Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964883AbWHQN2S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964883AbWHQN2S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964892AbWHQN2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:28:16 -0400
Received: from euridica.enternet.net.pl ([62.233.231.82]:4258 "EHLO
	euridica.enternet.net.pl") by vger.kernel.org with ESMTP
	id S964859AbWHQN14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:27:56 -0400
Date: Thu, 17 Aug 2006 13:28:32 +0000
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: mikep@linuxtr.net
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC][PATCH 43/75] net: drivers/net/tokenring/olympic.c pci_module_init to pci_register_driver conversion
Message-ID: <20060817132832.43.kWltTh4713.3636.michal@euridica.enternet.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
In-Reply-To: <20060817132638.0.iSIzDm3640.3636.michal@euridica.enternet.net.pl>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/tokenring/olympic.c linux-work2/drivers/net/tokenring/olympic.c
--- linux-work-clean/drivers/net/tokenring/olympic.c	2006-08-16 22:41:00.000000000 +0200
+++ linux-work2/drivers/net/tokenring/olympic.c	2006-08-17 05:18:24.000000000 +0200
@@ -1771,7 +1771,7 @@ static struct pci_driver olympic_driver 
 
 static int __init olympic_pci_init(void) 
 {
-	return pci_module_init (&olympic_driver) ; 
+	return pci_register_driver(&olympic_driver);
 }
 
 static void __exit olympic_pci_cleanup(void)
