Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964999AbWHQNu2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964999AbWHQNu2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964873AbWHQNuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:50:10 -0400
Received: from euridica.enternet.net.pl ([62.233.231.82]:1954 "EHLO
	euridica.enternet.net.pl") by vger.kernel.org with ESMTP
	id S964878AbWHQN1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:27:52 -0400
Date: Thu, 17 Aug 2006 13:28:22 +0000
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: Sreenivas.Bagalkote@lsil.com
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [RFC][PATCH 39/75] scsi: drivers/scsi/megaraid/megaraid_sas.c pci_module_init to pci_register_driver conversion
Message-ID: <20060817132822.39.nANzcW4632.3636.michal@euridica.enternet.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
In-Reply-To: <20060817132638.0.iSIzDm3640.3636.michal@euridica.enternet.net.pl>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/scsi/megaraid/megaraid_sas.c linux-work2/drivers/scsi/megaraid/megaraid_sas.c
--- linux-work-clean/drivers/scsi/megaraid/megaraid_sas.c	2006-08-16 22:41:01.000000000 +0200
+++ linux-work2/drivers/scsi/megaraid/megaraid_sas.c	2006-08-17 05:21:09.000000000 +0200
@@ -2854,7 +2854,7 @@ static int __init megasas_init(void)
 	/*
 	 * Register ourselves as PCI hotplug module
 	 */
-	rval = pci_module_init(&megasas_pci_driver);
+	rval = pci_register_driver(&megasas_pci_driver);
 
 	if (rval) {
 		printk(KERN_DEBUG "megasas: PCI hotplug regisration failed \n");
