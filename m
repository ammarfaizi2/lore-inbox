Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964989AbWHQNmi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964989AbWHQNmi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964916AbWHQNmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:42:33 -0400
Received: from euridica.enternet.net.pl ([62.233.231.82]:19634 "EHLO
	euridica.enternet.net.pl") by vger.kernel.org with ESMTP
	id S964913AbWHQN2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:28:46 -0400
Date: Thu, 17 Aug 2006 13:29:16 +0000
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: romieu@fr.zoreil.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC][PATCH 57/75] net: drivers/net/sis190.c pci_module_init to pci_register_driver conversion
Message-ID: <20060817132916.57.LNhXxP5102.3636.michal@euridica.enternet.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
In-Reply-To: <20060817132638.0.iSIzDm3640.3636.michal@euridica.enternet.net.pl>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/sis190.c linux-work2/drivers/net/sis190.c
--- linux-work-clean/drivers/net/sis190.c	2006-08-16 22:41:00.000000000 +0200
+++ linux-work2/drivers/net/sis190.c	2006-08-17 05:16:27.000000000 +0200
@@ -1871,7 +1871,7 @@ static struct pci_driver sis190_pci_driv
 
 static int __init sis190_init_module(void)
 {
-	return pci_module_init(&sis190_pci_driver);
+	return pci_register_driver(&sis190_pci_driver);
 }
 
 static void __exit sis190_cleanup_module(void)
