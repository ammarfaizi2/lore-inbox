Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964849AbWHQN4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964849AbWHQN4s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964852AbWHQN05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:26:57 -0400
Received: from euridica.enternet.net.pl ([62.233.231.82]:34721 "EHLO
	euridica.enternet.net.pl") by vger.kernel.org with ESMTP
	id S932498AbWHQN0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:26:24 -0400
Date: Thu, 17 Aug 2006 13:26:50 +0000
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: jes@trained-monkey.org
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC][PATCH 5/75] net: drivers/net/acenic.c pci_module_init to pci_register_driver conversion
Message-ID: <20060817132650.5.bPNCUZ3766.3636.michal@euridica.enternet.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
In-Reply-To: <20060817132638.0.iSIzDm3640.3636.michal@euridica.enternet.net.pl>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/acenic.c linux-work2/drivers/net/acenic.c
--- linux-work-clean/drivers/net/acenic.c	2006-08-17 00:10:47.000000000 +0200
+++ linux-work2/drivers/net/acenic.c	2006-08-17 05:13:37.000000000 +0200
@@ -725,7 +725,7 @@ static struct pci_driver acenic_pci_driv
 
 static int __init acenic_init(void)
 {
-	return pci_module_init(&acenic_pci_driver);
+	return pci_register_driver(&acenic_pci_driver);
 }
 
 static void __exit acenic_exit(void)
