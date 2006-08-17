Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964868AbWHQN1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964868AbWHQN1r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964859AbWHQN1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:27:43 -0400
Received: from euridica.enternet.net.pl ([62.233.231.82]:59297 "EHLO
	euridica.enternet.net.pl") by vger.kernel.org with ESMTP
	id S964868AbWHQN1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:27:32 -0400
Date: Thu, 17 Aug 2006 13:27:58 +0000
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: minyard@mvista.com
Cc: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 29/75] char: drivers/char/ipmi/ipmi_si_intf.c pci_module_init to pci_register_driver conversion
Message-ID: <20060817132758.29.IlpbiS4384.3636.michal@euridica.enternet.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
In-Reply-To: <20060817132638.0.iSIzDm3640.3636.michal@euridica.enternet.net.pl>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/char/ipmi/ipmi_si_intf.c linux-work2/drivers/char/ipmi/ipmi_si_intf.c
--- linux-work-clean/drivers/char/ipmi/ipmi_si_intf.c	2006-08-16 22:40:58.000000000 +0200
+++ linux-work2/drivers/char/ipmi/ipmi_si_intf.c	2006-08-17 05:12:42.000000000 +0200
@@ -2461,7 +2461,7 @@ static __devinit int init_ipmi_si(void)
 #endif
 
 #ifdef CONFIG_PCI
-	pci_module_init(&ipmi_pci_driver);
+	pci_register_driver(&ipmi_pci_driver);
 #endif
 
 	if (si_trydefaults) {
