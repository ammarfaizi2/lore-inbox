Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030383AbWHRBvL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030383AbWHRBvL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 21:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030211AbWHRBvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 21:51:11 -0400
Received: from mail0.lsil.com ([147.145.40.20]:6111 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S1030201AbWHRBvJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 21:51:09 -0400
x-mimeole: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] [MEGARAID] convert to PCI_DEVICE() macro
Date: Thu, 17 Aug 2006 19:50:55 -0600
Message-ID: <0631C836DBF79F42B5A60C8C8D4E8229674D30@NAMAIL2.ad.lsil.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] [MEGARAID] convert to PCI_DEVICE() macro
Thread-Index: AcbAS/NWljqBJfpaRbKUT5RSEyMWJwCHKbDg
From: "Patro, Sumant" <Sumant.Patro@lsil.com>
To: "Henne" <henne@nachtwindheim.de>, "Kolli, Neela" <Neela.Kolli@engenio.com>
Cc: <James.Bottomley@SteelEye.com>, <linux-scsi@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 18 Aug 2006 01:50:56.0228 (UTC) FILETIME=[BEEDCA40:01C6C268]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ACK.
Thanks for submitting the patch.

Regards,
Sumant

-----Original Message-----
From: linux-scsi-owner@vger.kernel.org
[mailto:linux-scsi-owner@vger.kernel.org] On Behalf Of Henne
Sent: Tuesday, August 15, 2006 2:17 AM
To: Kolli, Neela
Cc: James.Bottomley@SteelEye.com; linux-scsi@vger.kernel.org;
linux-kernel@vger.kernel.org
Subject: [PATCH] [MEGARAID] convert to PCI_DEVICE() macro

From: Henrik Kretzschmar <henne@nachtwidheim.de>

Convert the pci_device_id-table of the megaraid_sas-driver to
the PCI_DEVICE-macro, to safe some lines.

Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>

---

--- linux-2.6.18-rc4/drivers/scsi/megaraid/megaraid_sas.c
2006-08-11 10:09:21.000000000 +0200
+++ linux/drivers/scsi/megaraid/megaraid_sas.c	2006-08-11
13:29:29.000000000 +0200
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
+	{PCI_DEVICE(PCI_VENDOR_ID_LSI_LOGIC,
PCI_DEVICE_ID_LSI_SAS1064R)},
+	/* xscale IOP */
+	{PCI_DEVICE(PCI_VENDOR_ID_LSI_LOGIC,
PCI_DEVICE_ID_LSI_SAS1078R)},
+	/* ppc IOP */
+	{PCI_DEVICE(PCI_VENDOR_ID_LSI_LOGIC,
PCI_DEVICE_ID_LSI_VERDE_ZCR)},
+	/* xscale IOP, vega */
+	{PCI_DEVICE(PCI_VENDOR_ID_DELL, PCI_DEVICE_ID_DELL_PERC5)},
+	/* xscale IOP */
+	{}
 };
 
 MODULE_DEVICE_TABLE(pci, megasas_pci_table);


-
To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
