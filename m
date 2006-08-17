Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964850AbWHQN05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964850AbWHQN05 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964849AbWHQN04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:26:56 -0400
Received: from euridica.enternet.net.pl ([62.233.231.82]:34465 "EHLO
	euridica.enternet.net.pl") by vger.kernel.org with ESMTP
	id S932499AbWHQN0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:26:25 -0400
Date: Thu, 17 Aug 2006 13:26:56 +0000
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: simon@thekelleys.org.uk
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC][PATCH 8/75] net: drivers/net/wireless/atmel_pci.c pci_module_init to pci_register_driver conversion
Message-ID: <20060817132656.8.tjGvrI3853.3636.michal@euridica.enternet.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
In-Reply-To: <20060817132638.0.iSIzDm3640.3636.michal@euridica.enternet.net.pl>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/wireless/atmel_pci.c linux-work2/drivers/net/wireless/atmel_pci.c
--- linux-work-clean/drivers/net/wireless/atmel_pci.c	2006-08-16 22:41:00.000000000 +0200
+++ linux-work2/drivers/net/wireless/atmel_pci.c	2006-08-17 05:20:06.000000000 +0200
@@ -76,7 +76,7 @@ static void __devexit atmel_pci_remove(s
 
 static int __init atmel_init_module(void)
 {
-	return pci_module_init(&atmel_driver);
+	return pci_register_driver(&atmel_driver);
 }
 
 static void __exit atmel_cleanup_module(void)
