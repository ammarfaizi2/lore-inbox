Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964968AbWHQNiH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964968AbWHQNiH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964918AbWHQN3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:29:10 -0400
Received: from euridica.enternet.net.pl ([62.233.231.82]:26290 "EHLO
	euridica.enternet.net.pl") by vger.kernel.org with ESMTP
	id S964921AbWHQN3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:29:00 -0400
Date: Thu, 17 Aug 2006 13:29:32 +0000
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: ionut@badula.org
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC][PATCH 62/75] net: drivers/net/starfire.c pci_module_init to pci_register_driver conversion
Message-ID: <20060817132932.62.DSvssd5251.3636.michal@euridica.enternet.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
In-Reply-To: <20060817132638.0.iSIzDm3640.3636.michal@euridica.enternet.net.pl>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/starfire.c linux-work2/drivers/net/starfire.c
--- linux-work-clean/drivers/net/starfire.c	2006-08-16 22:41:17.000000000 +0200
+++ linux-work2/drivers/net/starfire.c	2006-08-17 05:17:15.000000000 +0200
@@ -2053,7 +2053,7 @@ static int __init starfire_init (void)
 		return -ENODEV;
 	}
 
-	return pci_module_init (&starfire_driver);
+	return pci_register_driver(&starfire_driver);
 }
 
 
