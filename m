Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965327AbWHOJSE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965327AbWHOJSE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 05:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965325AbWHOJSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 05:18:03 -0400
Received: from server6.greatnet.de ([83.133.96.26]:47232 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP id S965319AbWHOJSC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 05:18:02 -0400
Message-ID: <44E19121.2060200@nachtwindheim.de>
Date: Tue, 15 Aug 2006 11:17:21 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.5 (X11/20060725)
MIME-Version: 1.0
To: Neela.Kolli@engenio.com
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] [MEGARAID] convert to PCI_DEVICE() macro
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Henrik Kretzschmar <henne@nachtwidheim.de>

Convert the pci_device_id-table of the megaraid_sas-driver to
the PCI_DEVICE-macro, to safe some lines.

Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>

---

--- linux-2.6.18-rc4/drivers/scsi/megaraid/megaraid_sas.c	2006-08-11 10:09:21.000000000 +0200
+++ linux/drivers/scsi/megaraid/megaraid_sas.c	2006-08-11 13:29:29.000000000 +0200
@@ -53,31 +53,15 @@
  */
 static struct pci_device_id megasas_pci_table[] = {
 
-	{
-	 PCI_VENDOR_ID_LSI_LOGIC,
-	 PCI_DEVICE_ID_LSI_SAS1064R, /* xscale IOP */
-	 PCI_ANY_ID,
-	 PCI_ANY_ID,
-	 },
-	{
-	 PCI_VENDOR_ID_LSI_LOGIC,
-	 PCI_DEVICE_ID_LSI_SAS1078R, /* ppc IOP */
-	 PCI_ANY_ID,
-	 PCI_ANY_ID,
-	},
-	{
-	 PCI_VENDOR_ID_LSI_LOGIC,
-	 PCI_DEVICE_ID_LSI_VERDE_ZCR,	/* xscale IOP, vega */
-	 PCI_ANY_ID,
-	 PCI_ANY_ID,
-	 },
-	{
-	 PCI_VENDOR_ID_DELL,
-	 PCI_DEVICE_ID_DELL_PERC5, /* xscale IOP */
-	 PCI_ANY_ID,
-	 PCI_ANY_ID,
-	 },
-	{0}			/* Terminating entry */
+	{PCI_DEVICE(PCI_VENDOR_ID_LSI_LOGIC, PCI_DEVICE_ID_LSI_SAS1064R)},
+	/* xscale IOP */
+	{PCI_DEVICE(PCI_VENDOR_ID_LSI_LOGIC, PCI_DEVICE_ID_LSI_SAS1078R)},
+	/* ppc IOP */
+	{PCI_DEVICE(PCI_VENDOR_ID_LSI_LOGIC, PCI_DEVICE_ID_LSI_VERDE_ZCR)},
+	/* xscale IOP, vega */
+	{PCI_DEVICE(PCI_VENDOR_ID_DELL, PCI_DEVICE_ID_DELL_PERC5)},
+	/* xscale IOP */
+	{}
 };
 
 MODULE_DEVICE_TABLE(pci, megasas_pci_table);


