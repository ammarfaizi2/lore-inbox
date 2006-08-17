Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964936AbWHQN3S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964936AbWHQN3S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964934AbWHQN3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:29:16 -0400
Received: from euridica.enternet.net.pl ([62.233.231.82]:28594 "EHLO
	euridica.enternet.net.pl") by vger.kernel.org with ESMTP
	id S964926AbWHQN3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:29:06 -0400
Date: Thu, 17 Aug 2006 13:29:39 +0000
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: mchan@broadcom.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC][PATCH 66/75] net: drivers/net/tg3.c pci_module_init to pci_register_driver conversion
Message-ID: <20060817132939.66.qKjoAB5350.3636.michal@euridica.enternet.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
In-Reply-To: <20060817132638.0.iSIzDm3640.3636.michal@euridica.enternet.net.pl>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/tg3.c linux-work2/drivers/net/tg3.c
--- linux-work-clean/drivers/net/tg3.c	2006-08-16 22:41:17.000000000 +0200
+++ linux-work2/drivers/net/tg3.c	2006-08-17 05:17:47.000000000 +0200
@@ -11819,7 +11819,7 @@ static struct pci_driver tg3_driver = {
 
 static int __init tg3_init(void)
 {
-	return pci_module_init(&tg3_driver);
+	return pci_register_driver(&tg3_driver);
 }
 
 static void __exit tg3_cleanup(void)
