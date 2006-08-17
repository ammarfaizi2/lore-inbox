Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964960AbWHQNcv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964960AbWHQNcv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964964AbWHQNcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:32:17 -0400
Received: from euridica.enternet.net.pl ([62.233.231.82]:49074 "EHLO
	euridica.enternet.net.pl") by vger.kernel.org with ESMTP
	id S964956AbWHQNcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:32:11 -0400
Date: Thu, 17 Aug 2006 13:28:08 +0000
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: hvr@gnu.org
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC][PATCH 33/75] net: drivers/net/wireless/prism54/islpci_hotplug.c pci_module_init to pci_register_driver conversion
Message-ID: <20060817132808.33.ePqstk4499.3636.michal@euridica.enternet.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
In-Reply-To: <20060817132638.0.iSIzDm3640.3636.michal@euridica.enternet.net.pl>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/wireless/prism54/islpci_hotplug.c linux-work2/drivers/net/wireless/prism54/islpci_hotplug.c
--- linux-work-clean/drivers/net/wireless/prism54/islpci_hotplug.c	2006-08-16 22:41:00.000000000 +0200
+++ linux-work2/drivers/net/wireless/prism54/islpci_hotplug.c	2006-08-17 05:20:43.000000000 +0200
@@ -313,7 +313,7 @@ prism54_module_init(void)
 
 	__bug_on_wrong_struct_sizes ();
 
-	return pci_module_init(&prism54_driver);
+	return pci_register_driver(&prism54_driver);
 }
 
 /* by the time prism54_module_exit() terminates, as a postcondition
