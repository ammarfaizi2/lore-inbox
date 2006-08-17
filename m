Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965004AbWHQNyI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965004AbWHQNyI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964865AbWHQN1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:27:30 -0400
Received: from euridica.enternet.net.pl ([62.233.231.82]:52129 "EHLO
	euridica.enternet.net.pl") by vger.kernel.org with ESMTP
	id S964861AbWHQN1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:27:17 -0400
Date: Thu, 17 Aug 2006 13:27:50 +0000
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: becker@scyld.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC][PATCH 25/75] net: drivers/net/fealnx.c module_init to pci_register_driver conversion
Message-ID: <20060817132750.25.yenkew4276.3636.michal@euridica.enternet.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
In-Reply-To: <20060817132638.0.iSIzDm3640.3636.michal@euridica.enternet.net.pl>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/fealnx.c linux-work2/drivers/net/fealnx.c
--- linux-work-clean/drivers/net/fealnx.c	2006-08-16 22:41:17.000000000 +0200
+++ linux-work2/drivers/net/fealnx.c	2006-08-17 05:14:55.000000000 +0200
@@ -1984,7 +1984,7 @@ static int __init fealnx_init(void)
 	printk(version);
 #endif
 
-	return pci_module_init(&fealnx_driver);
+	return pci_register_driver(&fealnx_driver);
 }
 
 static void __exit fealnx_exit(void)
