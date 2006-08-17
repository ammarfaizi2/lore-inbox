Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964892AbWHQNoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964892AbWHQNoA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964905AbWHQN2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:28:40 -0400
Received: from euridica.enternet.net.pl ([62.233.231.82]:17314 "EHLO
	euridica.enternet.net.pl") by vger.kernel.org with ESMTP
	id S964904AbWHQN2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:28:33 -0400
Date: Thu, 17 Aug 2006 13:29:10 +0000
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 55/75] net: drivers/net/s2io.c pci_module_init to pci_register_driver conversion
Message-ID: <20060817132910.55.PeZrVT5054.3636.michal@euridica.enternet.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
In-Reply-To: <20060817132638.0.iSIzDm3640.3636.michal@euridica.enternet.net.pl>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/s2io.c linux-work2/drivers/net/s2io.c
--- linux-work-clean/drivers/net/s2io.c	2006-08-16 22:41:17.000000000 +0200
+++ linux-work2/drivers/net/s2io.c	2006-08-17 05:16:10.000000000 +0200
@@ -7233,7 +7233,7 @@ static void __devexit s2io_rem_nic(struc
 
 int __init s2io_starter(void)
 {
-	return pci_module_init(&s2io_driver);
+	return pci_register_driver(&s2io_driver);
 }
 
 /**
