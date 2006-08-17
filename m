Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965000AbWHQNn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965000AbWHQNn6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964996AbWHQNnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:43:53 -0400
Received: from euridica.enternet.net.pl ([62.233.231.82]:19618 "EHLO
	euridica.enternet.net.pl") by vger.kernel.org with ESMTP
	id S964911AbWHQN2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:28:41 -0400
Date: Thu, 17 Aug 2006 13:26:52 +0000
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC][PATCH 6/75] net: drivers/net/amd8111e.c pci_module_init to pci_register_driver conversion
Message-ID: <20060817132652.6.cLyUtH3793.3636.michal@euridica.enternet.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
In-Reply-To: <20060817132638.0.iSIzDm3640.3636.michal@euridica.enternet.net.pl>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/amd8111e.c linux-work2/drivers/net/amd8111e.c
--- linux-work-clean/drivers/net/amd8111e.c	2006-08-16 22:40:59.000000000 +0200
+++ linux-work2/drivers/net/amd8111e.c	2006-08-17 05:13:42.000000000 +0200
@@ -2158,7 +2158,7 @@ static struct pci_driver amd8111e_driver
 
 static int __init amd8111e_init(void)
 {
-	return pci_module_init(&amd8111e_driver);
+	return pci_register_driver(&amd8111e_driver);
 }
 
 static void __exit amd8111e_cleanup(void)
