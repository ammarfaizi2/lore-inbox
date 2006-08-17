Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964863AbWHQN12@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863AbWHQN12 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964865AbWHQN11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:27:27 -0400
Received: from euridica.enternet.net.pl ([62.233.231.82]:55457 "EHLO
	euridica.enternet.net.pl") by vger.kernel.org with ESMTP
	id S964858AbWHQN1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:27:24 -0400
Date: Thu, 17 Aug 2006 13:27:54 +0000
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: info-linux@geode.amd.com
Cc: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 27/75] crypto: drivers/crypto/geode-aes.c pci_module_init to pci_register_driver conversion
Message-ID: <20060817132754.27.aeCzuw4334.3636.michal@euridica.enternet.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
In-Reply-To: <20060817132638.0.iSIzDm3640.3636.michal@euridica.enternet.net.pl>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/crypto/geode-aes.c linux-work2/drivers/crypto/geode-aes.c
--- linux-work-clean/drivers/crypto/geode-aes.c	2006-08-16 22:41:16.000000000 +0200
+++ linux-work2/drivers/crypto/geode-aes.c	2006-08-17 05:12:48.000000000 +0200
@@ -378,7 +378,7 @@ static struct pci_driver geode_aes_drive
 static int __devinit
 geode_aes_init(void)
 {
-	return pci_module_init(&geode_aes_driver);
+	return pci_register_driver(&geode_aes_driver);
 }
 
 static void __devexit
