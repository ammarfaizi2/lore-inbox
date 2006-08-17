Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964949AbWHQN3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964949AbWHQN3y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964950AbWHQN3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:29:52 -0400
Received: from euridica.enternet.net.pl ([62.233.231.82]:39858 "EHLO
	euridica.enternet.net.pl") by vger.kernel.org with ESMTP
	id S964944AbWHQN3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:29:31 -0400
Date: Thu, 17 Aug 2006 13:28:58 +0000
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC][PATCH 51/75] net: drivers/net/pci-skeleton.c pci_module_init to pci_register_driver conversion
Message-ID: <20060817132858.51.mFaGck4945.3636.michal@euridica.enternet.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
In-Reply-To: <20060817132638.0.iSIzDm3640.3636.michal@euridica.enternet.net.pl>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/pci-skeleton.c linux-work2/drivers/net/pci-skeleton.c
--- linux-work-clean/drivers/net/pci-skeleton.c	2006-08-16 22:41:00.000000000 +0200
+++ linux-work2/drivers/net/pci-skeleton.c	2006-08-17 05:15:43.000000000 +0200
@@ -1963,7 +1963,7 @@ static int __init netdrv_init_module (vo
 #ifdef MODULE
 	printk(version);
 #endif
-	return pci_module_init (&netdrv_pci_driver);
+	return pci_register_driver(&netdrv_pci_driver);
 }
 
 
