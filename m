Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964932AbWHQNcA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964932AbWHQNcA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964957AbWHQNb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:31:59 -0400
Received: from euridica.enternet.net.pl ([62.233.231.82]:48306 "EHLO
	euridica.enternet.net.pl") by vger.kernel.org with ESMTP
	id S964956AbWHQNbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:31:40 -0400
Date: Thu, 17 Aug 2006 13:28:40 +0000
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: proski@gnu.org
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC][PATCH 46/75] net: drivers/net/wireless/orinoco_plx.c pci_module_init to pci_register_driver conversion
Message-ID: <20060817132840.46.BhNzEm4802.3636.michal@euridica.enternet.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
In-Reply-To: <20060817132638.0.iSIzDm3640.3636.michal@euridica.enternet.net.pl>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/wireless/orinoco_plx.c linux-work2/drivers/net/wireless/orinoco_plx.c
--- linux-work-clean/drivers/net/wireless/orinoco_plx.c	2006-08-16 22:41:00.000000000 +0200
+++ linux-work2/drivers/net/wireless/orinoco_plx.c	2006-08-17 05:20:31.000000000 +0200
@@ -351,7 +351,7 @@ MODULE_LICENSE("Dual MPL/GPL");
 static int __init orinoco_plx_init(void)
 {
 	printk(KERN_DEBUG "%s\n", version);
-	return pci_module_init(&orinoco_plx_driver);
+	return pci_register_driver(&orinoco_plx_driver);
 }
 
 static void __exit orinoco_plx_exit(void)
