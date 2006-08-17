Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965014AbWHQNyG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965014AbWHQNyG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965006AbWHQNxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:53:42 -0400
Received: from euridica.enternet.net.pl ([62.233.231.82]:58529 "EHLO
	euridica.enternet.net.pl") by vger.kernel.org with ESMTP
	id S964867AbWHQN1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:27:31 -0400
Date: Thu, 17 Aug 2006 13:28:01 +0000
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: ipslinux@adaptec.com
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [RFC][PATCH 30/75] scsi: drivers/scsi/ips.c pci_module_init to pci_register_driver conversion
Message-ID: <20060817132801.30.tjrmRy4419.3636.michal@euridica.enternet.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
In-Reply-To: <20060817132638.0.iSIzDm3640.3636.michal@euridica.enternet.net.pl>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/scsi/ips.c linux-work2/drivers/scsi/ips.c
--- linux-work-clean/drivers/scsi/ips.c	2006-08-16 22:41:01.000000000 +0200
+++ linux-work2/drivers/scsi/ips.c	2006-08-17 05:20:58.000000000 +0200
@@ -7078,7 +7078,7 @@ ips_remove_device(struct pci_dev *pci_de
 static int __init
 ips_module_init(void)
 {
-	if (pci_module_init(&ips_pci_driver) < 0)
+	if (pci_register_driver(&ips_pci_driver) < 0)
 		return -ENODEV;
 	ips_driver_template.module = THIS_MODULE;
 	ips_order_controllers();
