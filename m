Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265997AbUFIXhZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265997AbUFIXhZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 19:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266009AbUFIXhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 19:37:25 -0400
Received: from [82.147.40.124] ([82.147.40.124]:65182 "EHLO dodge.jordet.nu")
	by vger.kernel.org with ESMTP id S265997AbUFIXhT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 19:37:19 -0400
Subject: Re: Fix warning in hisax/config.c
From: Stian Jordet <liste@jordet.nu>
To: linux-kernel@vger.kernel.org
Cc: kkeil@suse.de
In-Reply-To: <1086823938.3242.5.camel@chevrolet.jordet>
References: <1086823938.3242.5.camel@chevrolet.jordet>
Content-Type: multipart/mixed; boundary="=-sSj7vIv91L67khE5ehck"
Date: Thu, 10 Jun 2004 01:37:15 +0200
Message-Id: <1086824235.3242.8.camel@chevrolet.jordet>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.8 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-sSj7vIv91L67khE5ehck
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

tor, 10.06.2004 kl. 01.32 +0200, skrev Stian Jordet:
> Hi,
> 
> is this patch correct? It silences the warning, and everything seems to
> work fine for me.

Uhh, more like this. Sorry.

Best regards,
Stian

--=-sSj7vIv91L67khE5ehck
Content-Disposition: attachment; filename=isdn-patch.txt
Content-Type: text/plain; name=isdn-patch.txt; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

--- linux-2.6.6/drivers/isdn/hisax/config.c.old	2004-06-06 01:43:01.000000000 +0200
+++ linux-2.6.6/drivers/isdn/hisax/config.c	2004-06-06 01:43:24.000000000 +0200
@@ -1886,6 +1886,8 @@
 
 #include <linux/pci.h>
 
+#ifdef MODULE
+
 static struct pci_device_id hisax_pci_tbl[] __initdata = {
 #ifdef CONFIG_HISAX_FRITZPCI
 	{PCI_VENDOR_ID_AVM,      PCI_DEVICE_ID_AVM_A1,           PCI_ANY_ID, PCI_ANY_ID},
@@ -1953,6 +1955,8 @@
 
 MODULE_DEVICE_TABLE(pci, hisax_pci_tbl);
 
+#endif
+
 module_init(HiSax_init);
 module_exit(HiSax_exit);
 

--=-sSj7vIv91L67khE5ehck--

