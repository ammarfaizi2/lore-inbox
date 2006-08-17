Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964847AbWHQN5X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964847AbWHQN5X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964848AbWHQN4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:56:48 -0400
Received: from euridica.enternet.net.pl ([62.233.231.82]:44449 "EHLO
	euridica.enternet.net.pl") by vger.kernel.org with ESMTP
	id S964847AbWHQN05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:26:57 -0400
Date: Thu, 17 Aug 2006 13:27:27 +0000
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: edward_peng@dlink.com.tw
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC][PATCH 17/75] net: drivers/net/dl2k.c pci_module_init to pci_register_driver conversion
Message-ID: <20060817132727.17.eJLrXu4077.3636.michal@euridica.enternet.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
In-Reply-To: <20060817132638.0.iSIzDm3640.3636.michal@euridica.enternet.net.pl>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/dl2k.c linux-work2/drivers/net/dl2k.c
--- linux-work-clean/drivers/net/dl2k.c	2006-08-16 22:41:17.000000000 +0200
+++ linux-work2/drivers/net/dl2k.c	2006-08-17 05:14:25.000000000 +0200
@@ -1815,7 +1815,7 @@ static struct pci_driver rio_driver = {
 static int __init
 rio_init (void)
 {
-	return pci_module_init (&rio_driver);
+	return pci_register_driver(&rio_driver);
 }
 
 static void __exit
