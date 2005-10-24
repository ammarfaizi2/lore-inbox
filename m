Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751319AbVJXVjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbVJXVjK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 17:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbVJXVjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 17:39:09 -0400
Received: from palrel10.hp.com ([156.153.255.245]:7117 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S1751324AbVJXVjI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 17:39:08 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] new hp diva console port
Date: Mon, 24 Oct 2005 14:38:02 -0700
Message-ID: <C1BB5827EB7A364EA57B4E8C7C02ADAC054EB8D6@cacexc04.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] new hp diva console port
Thread-Index: AcXYyVJSKuUmHoaASj+iw7KuAhMLpAADw5hA
From: "Chen, Justin" <justin.chen@hp.com>
To: "Helgaas, Bjorn" <bjorn.helgaas@hp.com>
Cc: <rmk+serial@arm.linux.org.uk>, <linux-kernel@vger.kernel.org>,
       <linux-serial@vger.kernel.org>
X-OriginalArrivalTime: 24 Oct 2005 21:38:03.0660 (UTC) FILETIME=[36AFE4C0:01C5D8E3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, October 24, 2005 11:33 AM, Helgaas, Bjorn wrote:
>It'll be easier to apply this if you follow the guidelines in 
>Documentation/SubmittingPatches.  For example, the patch 
>should apply with "patch -p1", add "Signed-off-by:", etc.

Okay,  here is the adjusted format and the signature -

This patch adds the new ID 0x132a and configure the new PCI Diva console
port.  This device support only 1 single console UART. Please apply.
Thanks,
 
Signed-off-by: Justin Chen <justin.chen@hp.com>

------------------------------------------------------------------------
-------------------------------------------------------
diff -uprN -X dontdiff linux-vanilla/drivers/serial/8250_pci.c
ia-26126/drivers/serial/8250_pci.c
--- linux-vanilla/drivers/serial/8250_pci.c	2005-10-24
12:32:01.817851490 -0700
+++ ia-26126/drivers/serial/8250_pci.c	2005-10-24 12:24:13.628404100
-0700
@@ -177,6 +177,7 @@ static int __devinit pci_hp_diva_init(st
 		rc = 4;
 		break;
 	case PCI_DEVICE_ID_HP_DIVA_POWERBAR:
+	case PCI_DEVICE_ID_HP_DIVA_HURRICANE:
 		rc = 1;
 		break;
 	}
diff -uprN -X dontdiff linux-vanilla/include/linux/pci_ids.h
ia-26126/include/linux/pci_ids.h
--- linux-vanilla/include/linux/pci_ids.h	2005-10-24
12:31:49.661601638 -0700
+++ ia-26126/include/linux/pci_ids.h	2005-10-24 12:23:31.366685868
-0700
@@ -711,6 +711,7 @@
 #define PCI_DEVICE_ID_HP_DIVA_EVEREST	0x1282
 #define PCI_DEVICE_ID_HP_DIVA_AUX	0x1290
 #define PCI_DEVICE_ID_HP_DIVA_RMP3	0x1301
+#define PCI_DEVICE_ID_HP_DIVA_HURRICANE 0x132a
 #define PCI_DEVICE_ID_HP_CISSA		0x3220
 #define PCI_DEVICE_ID_HP_CISSB		0x3230
 #define PCI_DEVICE_ID_HP_ZX2_IOC	0x4031
------------------------------------------------------------------------
--------------------------------------------------------------
