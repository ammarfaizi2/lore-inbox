Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266023AbUFIXci@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266023AbUFIXci (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 19:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266025AbUFIXch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 19:32:37 -0400
Received: from [82.147.40.124] ([82.147.40.124]:64414 "EHLO dodge.jordet.nu")
	by vger.kernel.org with ESMTP id S266023AbUFIXcg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 19:32:36 -0400
Subject: Fix warning in hisax/config.c
From: Stian Jordet <liste@jordet.nu>
To: linux-kernel@vger.kernel.org
Cc: kkeil@suse.de
Content-Type: text/plain
Date: Thu, 10 Jun 2004 01:32:18 +0200
Message-Id: <1086823938.3242.5.camel@chevrolet.jordet>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.8 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

is this patch correct? It silences the warning, and everything seems to
work fine for me.

Best regards,
Stian

--- linux-2.6.6/drivers/isdn/hisax/config.c.old	2004-06-06
01:43:01.000000000 +0200
+++ linux-2.6.6/drivers/isdn/hisax/config.c	2004-06-06
01:43:24.000000000 +0200
@@ -1886,6 +1886,8 @@
 
 #include <linux/pci.h>
 
+#ifdef MODULE
+
 static struct pci_device_id hisax_pci_tbl[] __initdata = {
 #ifdef CONFIG_HISAX_FRITZPCI
 	{PCI_VENDOR_ID_AVM,      PCI_DEVICE_ID_AVM_A1,           PCI_ANY_ID,
PCI_ANY_ID},
@@ -1953,6 +1955,8 @@
 
 MODULE_DEVICE_TABLE(pci, hisax_pci_tbl);
 
+#endif
+
 module_init(HiSax_init);
 module_exit(HiSax_exit);
 


