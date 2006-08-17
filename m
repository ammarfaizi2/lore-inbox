Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964974AbWHQNiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964974AbWHQNiY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964973AbWHQNiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:38:09 -0400
Received: from euridica.enternet.net.pl ([62.233.231.82]:31666 "EHLO
	euridica.enternet.net.pl") by vger.kernel.org with ESMTP
	id S964921AbWHQN3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:29:13 -0400
Date: Thu, 17 Aug 2006 13:29:47 +0000
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: dave@thedillows.org
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC][PATCH 69/75] net: drivers/net/typhoon.c pci_module_init to pci_register_driver conversion
Message-ID: <20060817132947.69.izIScU5429.3636.michal@euridica.enternet.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
In-Reply-To: <20060817132638.0.iSIzDm3640.3636.michal@euridica.enternet.net.pl>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/typhoon.c linux-work2/drivers/net/typhoon.c
--- linux-work-clean/drivers/net/typhoon.c	2006-08-17 00:10:47.000000000 +0200
+++ linux-work2/drivers/net/typhoon.c	2006-08-17 05:19:13.000000000 +0200
@@ -2660,7 +2660,7 @@ static struct pci_driver typhoon_driver 
 static int __init
 typhoon_init(void)
 {
-	return pci_module_init(&typhoon_driver);
+	return pci_register_driver(&typhoon_driver);
 }
 
 static void __exit
