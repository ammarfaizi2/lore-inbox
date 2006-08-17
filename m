Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964988AbWHQNwL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964988AbWHQNwL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965004AbWHQNwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:52:06 -0400
Received: from euridica.enternet.net.pl ([62.233.231.82]:60833 "EHLO
	euridica.enternet.net.pl") by vger.kernel.org with ESMTP
	id S964872AbWHQN1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:27:36 -0400
Date: Thu, 17 Aug 2006 13:28:12 +0000
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: norsk5@xmission.com
Cc: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 35/75] edac: drivers/edac/k8_edac.c pci_module_init to pci_register_driver conversion
Message-ID: <20060817132812.35.jYjYhI4545.3636.michal@euridica.enternet.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
In-Reply-To: <20060817132638.0.iSIzDm3640.3636.michal@euridica.enternet.net.pl>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/edac/k8_edac.c linux-work2/drivers/edac/k8_edac.c
--- linux-work-clean/drivers/edac/k8_edac.c	2006-08-16 22:41:16.000000000 +0200
+++ linux-work2/drivers/edac/k8_edac.c	2006-08-17 05:12:55.000000000 +0200
@@ -1865,7 +1865,7 @@ static struct pci_driver k8_driver = {
 
 static int __init k8_init(void)
 {
-	return pci_module_init(&k8_driver);
+	return pci_register_driver(&k8_driver);
 }
 
 static void __exit k8_exit(void)
