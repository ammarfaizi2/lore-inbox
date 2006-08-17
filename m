Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964845AbWHQN0w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964845AbWHQN0w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964841AbWHQN0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:26:50 -0400
Received: from euridica.enternet.net.pl ([62.233.231.82]:38049 "EHLO
	euridica.enternet.net.pl") by vger.kernel.org with ESMTP
	id S932504AbWHQN0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:26:36 -0400
Date: Thu, 17 Aug 2006 13:27:04 +0000
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: asun@darksunrising.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC][PATCH 11/75] net: drivers/net/cassini.c pci_module_init to pci_register_driver conversion
Message-ID: <20060817132704.11.KHnhyW3917.3636.michal@euridica.enternet.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
In-Reply-To: <20060817132638.0.iSIzDm3640.3636.michal@euridica.enternet.net.pl>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/cassini.c linux-work2/drivers/net/cassini.c
--- linux-work-clean/drivers/net/cassini.c	2006-08-16 22:41:17.000000000 +0200
+++ linux-work2/drivers/net/cassini.c	2006-08-17 05:14:07.000000000 +0200
@@ -5245,7 +5245,7 @@ static int __init cas_init(void)
 	else
 		link_transition_timeout = 0;
 
-	return pci_module_init(&cas_driver);
+	return pci_register_driver(&cas_driver);
 }
 
 static void __exit cas_cleanup(void)
