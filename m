Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964906AbWHQNq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964906AbWHQNq7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964999AbWHQNn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:43:59 -0400
Received: from euridica.enternet.net.pl ([62.233.231.82]:17570 "EHLO
	euridica.enternet.net.pl") by vger.kernel.org with ESMTP
	id S964892AbWHQN2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:28:38 -0400
Date: Thu, 17 Aug 2006 13:28:46 +0000
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: albertcc@tw.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 48/75] ata: drivers/ata/pata_pdc2027x.c pci_module_init to pci_register_driver conversion
Message-ID: <20060817132846.48.bZXvDk4874.3636.michal@euridica.enternet.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
In-Reply-To: <20060817132638.0.iSIzDm3640.3636.michal@euridica.enternet.net.pl>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/ata/pata_pdc2027x.c linux-work2/drivers/ata/pata_pdc2027x.c
--- linux-work-clean/drivers/ata/pata_pdc2027x.c	2006-08-16 22:41:16.000000000 +0200
+++ linux-work2/drivers/ata/pata_pdc2027x.c	2006-08-17 05:12:32.000000000 +0200
@@ -854,7 +854,7 @@ static void __devexit pdc2027x_remove_on
  */
 static int __init pdc2027x_init(void)
 {
-	return pci_module_init(&pdc2027x_pci_driver);
+	return pci_register_driver(&pdc2027x_pci_driver);
 }
 
 /**
