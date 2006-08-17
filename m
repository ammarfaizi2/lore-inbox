Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964998AbWHQN4P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964998AbWHQN4P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964798AbWHQN1B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:27:01 -0400
Received: from euridica.enternet.net.pl ([62.233.231.82]:43681 "EHLO
	euridica.enternet.net.pl") by vger.kernel.org with ESMTP
	id S964846AbWHQN04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:26:56 -0400
Date: Thu, 17 Aug 2006 13:26:54 +0000
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: alan@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 7/75] ata: drivers/ata/ata_generic.c pci_module_init to pci_register_driver conversion
Message-ID: <20060817132654.7.bYvqkJ3826.3636.michal@euridica.enternet.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
In-Reply-To: <20060817132638.0.iSIzDm3640.3636.michal@euridica.enternet.net.pl>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/ata/ata_generic.c linux-work2/drivers/ata/ata_generic.c
--- linux-work-clean/drivers/ata/ata_generic.c	2006-08-16 22:41:16.000000000 +0200
+++ linux-work2/drivers/ata/ata_generic.c	2006-08-17 05:12:23.000000000 +0200
@@ -230,7 +230,7 @@ static struct pci_driver ata_generic_pci
 
 static int __init ata_generic_init(void)
 {
-	return pci_module_init(&ata_generic_pci_driver);
+	return pci_register_driver(&ata_generic_pci_driver);
 }
 
 
