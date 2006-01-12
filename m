Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161355AbWALWIl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161355AbWALWIl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 17:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161349AbWALWIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 17:08:40 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:45532 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161352AbWALWIh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 17:08:37 -0500
Date: Thu, 12 Jan 2006 16:08:28 -0600
From: Jon Mason <jdmason@us.ibm.com>
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Jiri Slaby <slaby@liberouter.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent trident driver from grabbing pcnet32 hardware
Message-ID: <20060112220827.GG17539@us.ibm.com>
References: <20060112175051.GA17539@us.ibm.com> <43C6ADDE.5060904@liberouter.org> <20060112200735.GD5399@granada.merseine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060112200735.GD5399@granada.merseine.nu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This revised version of the OSS Trident patch includes PCI_DEVICE Macro
usage.

Thanks,
Jon

Signed-off-by: Jon Mason <jdmason@us.ibm.com>

diff -r 4a7597b41d25 sound/oss/trident.c
--- a/sound/oss/trident.c	Wed Jan 11 19:14:08 2006
+++ b/sound/oss/trident.c	Thu Jan 12 15:33:02 2006
@@ -278,16 +278,14 @@
 };
 
 static struct pci_device_id trident_pci_tbl[] = {
-	{PCI_VENDOR_ID_TRIDENT, PCI_DEVICE_ID_TRIDENT_4DWAVE_DX,
-	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, TRIDENT_4D_DX},
-	{PCI_VENDOR_ID_TRIDENT, PCI_DEVICE_ID_TRIDENT_4DWAVE_NX,
-	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, TRIDENT_4D_NX},
-	{PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_7018,
-	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, SIS_7018},
-	{PCI_VENDOR_ID_ALI, PCI_DEVICE_ID_ALI_5451,
-	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, ALI_5451},
-	{PCI_VENDOR_ID_INTERG, PCI_DEVICE_ID_INTERG_5050,
-	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, CYBER5050},
+	{PCI_DEVICE(PCI_VENDOR_ID_TRIDENT, PCI_DEVICE_ID_TRIDENT_4DWAVE_DX), 
+		PCI_CLASS_MULTIMEDIA_AUDIO << 8, 0xffff00, TRIDENT_4D_DX},
+	{PCI_DEVICE(PCI_VENDOR_ID_TRIDENT, PCI_DEVICE_ID_TRIDENT_4DWAVE_NX), 
+		0, 0, TRIDENT_4D_NX},
+	{PCI_DEVICE(PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_7018), 0, 0, SIS_7018},
+	{PCI_DEVICE(PCI_VENDOR_ID_ALI, PCI_DEVICE_ID_ALI_5451), 0, 0, ALI_5451},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTERG, PCI_DEVICE_ID_INTERG_5050), 
+		0, 0, CYBER5050},
 	{0,}
 };
 
