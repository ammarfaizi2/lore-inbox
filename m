Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964854AbWHQN1B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964854AbWHQN1B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964853AbWHQN07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:26:59 -0400
Received: from euridica.enternet.net.pl ([62.233.231.82]:42145 "EHLO
	euridica.enternet.net.pl") by vger.kernel.org with ESMTP
	id S964798AbWHQN0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:26:50 -0400
Date: Thu, 17 Aug 2006 13:27:23 +0000
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: macro@linux-mips.org
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC][PATCH 16/75] net: drivers/net/defxx.c pci_module_init to pci_register_driver conversion
Message-ID: <20060817132723.16.nTqjEk4058.3636.michal@euridica.enternet.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
In-Reply-To: <20060817132638.0.iSIzDm3640.3636.michal@euridica.enternet.net.pl>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/defxx.c linux-work2/drivers/net/defxx.c
--- linux-work-clean/drivers/net/defxx.c	2006-08-16 22:40:59.000000000 +0200
+++ linux-work2/drivers/net/defxx.c	2006-08-17 05:14:19.000000000 +0200
@@ -3444,7 +3444,7 @@ static int __init dfx_init(void)
 {
 	int rc_pci, rc_eisa;
 
-	rc_pci = pci_module_init(&dfx_driver);
+	rc_pci = pci_register_driver(&dfx_driver);
 	if (rc_pci >= 0) dfx_have_pci = 1;
 	
 	rc_eisa = dfx_eisa_init();
