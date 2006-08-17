Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964982AbWHQNmA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964982AbWHQNmA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964915AbWHQN2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:28:46 -0400
Received: from euridica.enternet.net.pl ([62.233.231.82]:17826 "EHLO
	euridica.enternet.net.pl") by vger.kernel.org with ESMTP
	id S964903AbWHQN2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:28:35 -0400
Date: Thu, 17 Aug 2006 13:29:04 +0000
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: jes@wildopensource.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC][PATCH 54/75] net: net/rrunner.c pci_module_init to pci_register_driver conversion
Message-ID: <20060817132904.54.bUvzeS5037.3636.michal@euridica.enternet.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
In-Reply-To: <20060817132638.0.iSIzDm3640.3636.michal@euridica.enternet.net.pl>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/rrunner.c linux-work2/drivers/net/rrunner.c
--- linux-work-clean/drivers/net/rrunner.c	2006-08-16 22:41:00.000000000 +0200
+++ linux-work2/drivers/net/rrunner.c	2006-08-17 05:16:04.000000000 +0200
@@ -1736,7 +1736,7 @@ static struct pci_driver rr_driver = {
 
 static int __init rr_init_module(void)
 {
-	return pci_module_init(&rr_driver);
+	return pci_register_driver(&rr_driver);
 }
 
 static void __exit rr_cleanup_module(void)
