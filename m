Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261511AbUKSRrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261511AbUKSRrJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 12:47:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261514AbUKSRps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 12:45:48 -0500
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:58960 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S261512AbUKSRnu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 12:43:50 -0500
X-Ironport-AV: i="3.87,100,1099288800"; 
   d="scan'208"; a="117408070:sNHT24765264"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6527.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: [PATCH][SERIAL][2.6.10-rc2] Add support for Dell Remote Access Card 4.
Date: Fri, 19 Nov 2004 11:43:46 -0600
Message-ID: <4B0A1C17AA88F94289B0704CFABEF1AB0B4CED@ausx2kmps304.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH][SERIAL][2.6.10-rc2] Add support for Dell Remote Access Card 4.
Thread-Index: AcTOXyGvCCsIhvbzTRO9t+PESQ9Zzg==
From: <Tim_T_Murphy@Dell.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 19 Nov 2004 17:43:47.0434 (UTC) FILETIME=[527CC4A0:01C4CE5F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a patch to include Dell's 4th generation Remote Access Controller ids.

--- linux-2.6.10-rc2.orig/drivers/serial/8250_pci.c	2004-11-19 10:18:46.961572456 -0600
+++ linux-2.6.10-rc2.patched/drivers/serial/8250_pci.c	2004-11-19 09:21:58.000000000 -0600
@@ -2116,6 +2116,13 @@
 		pbn_b0_bt_1_460800 },
 
 	/*
+	 * Dell Remote Access Card 4 - Tim_T_Murphy@Dell.com
+	 */
+	{	PCI_VENDOR_ID_DELL, PCI_DEVICE_ID_DELL_RAC4,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b1_1_1382400 },
+
+	/*
 	 * Dell Remote Access Card III - Tim_T_Murphy@Dell.com
 	 */
 	{	PCI_VENDOR_ID_DELL, PCI_DEVICE_ID_DELL_RACIII,
--- linux-2.6.10-rc2.orig/include/linux/pci_ids.h	2004-11-19 10:18:22.876233984 -0600
+++ linux-2.6.10-rc2.patched/include/linux/pci_ids.h	2004-11-19 09:24:40.000000000 -0600
@@ -523,6 +523,7 @@
 
 #define PCI_VENDOR_ID_DELL		0x1028
 #define PCI_DEVICE_ID_DELL_RACIII	0x0008
+#define PCI_DEVICE_ID_DELL_RAC4		0x0012
 
 #define PCI_VENDOR_ID_MATROX		0x102B
 #define PCI_DEVICE_ID_MATROX_MGA_2	0x0518
