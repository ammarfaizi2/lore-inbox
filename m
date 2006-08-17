Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964904AbWHQNoq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964904AbWHQNoq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964898AbWHQNoB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:44:01 -0400
Received: from euridica.enternet.net.pl ([62.233.231.82]:14498 "EHLO
	euridica.enternet.net.pl") by vger.kernel.org with ESMTP
	id S964897AbWHQN20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:28:26 -0400
Date: Thu, 17 Aug 2006 13:29:02 +0000
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 53/75] net: drivers/net/r8169.c pci_module_init to pci_register_driver conversion
Message-ID: <20060817132902.53.iGyoRk5003.3636.michal@euridica.enternet.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
In-Reply-To: <20060817132638.0.iSIzDm3640.3636.michal@euridica.enternet.net.pl>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/r8169.c linux-work2/drivers/net/r8169.c
--- linux-work-clean/drivers/net/r8169.c	2006-08-16 22:41:17.000000000 +0200
+++ linux-work2/drivers/net/r8169.c	2006-08-17 05:15:58.000000000 +0200
@@ -2910,7 +2910,7 @@ static struct pci_driver rtl8169_pci_dri
 static int __init
 rtl8169_init_module(void)
 {
-	return pci_module_init(&rtl8169_pci_driver);
+	return pci_register_driver(&rtl8169_pci_driver);
 }
 
 static void __exit
