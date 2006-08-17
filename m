Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964976AbWHQNky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964976AbWHQNky (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964977AbWHQNkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:40:52 -0400
Received: from euridica.enternet.net.pl ([62.233.231.82]:21938 "EHLO
	euridica.enternet.net.pl") by vger.kernel.org with ESMTP
	id S964914AbWHQN2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:28:49 -0400
Date: Thu, 17 Aug 2006 13:29:23 +0000
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: cgoos@syskonnect.de
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC][PATCH 59/75] net: net/skfp/skfddi.c pci_module_init to pci_register_driver conversion
Message-ID: <20060817132923.59.cJVopb5162.3636.michal@euridica.enternet.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
In-Reply-To: <20060817132638.0.iSIzDm3640.3636.michal@euridica.enternet.net.pl>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/skfp/skfddi.c linux-work2/drivers/net/skfp/skfddi.c
--- linux-work-clean/drivers/net/skfp/skfddi.c	2006-08-16 22:41:00.000000000 +0200
+++ linux-work2/drivers/net/skfp/skfddi.c	2006-08-17 05:16:45.000000000 +0200
@@ -2280,7 +2280,7 @@ static struct pci_driver skfddi_pci_driv
 
 static int __init skfd_init(void)
 {
-	return pci_module_init(&skfddi_pci_driver);
+	return pci_register_driver(&skfddi_pci_driver);
 }
 
 static void __exit skfd_exit(void)
