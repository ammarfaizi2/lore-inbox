Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288075AbSAHOtk>; Tue, 8 Jan 2002 09:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288076AbSAHOta>; Tue, 8 Jan 2002 09:49:30 -0500
Received: from OL10K-24.207.148.94.charter-stl.com ([24.207.148.94]:28288 "EHLO
	linux.local") by vger.kernel.org with ESMTP id <S288075AbSAHOtT>;
	Tue, 8 Jan 2002 09:49:19 -0500
Message-Id: <200201081440.g08EeX301230@linux.local>
Content-Type: text/plain; charset=US-ASCII
From: Its Squash <squash2@dropnet.net>
Reply-To: squash2@dropnet.net
To: Andrey Savochkin <saw@saw.sw.com.sg>
Subject: [PATCH] Add support for a newer eepro100 chipset for 2.5
Date: Tue, 8 Jan 2002 08:39:55 -0600
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <200201041649.g04GnJU29948@linux.local> <20020104202821.A30057@castle.nmd.msu.ru>
In-Reply-To: <20020104202821.A30057@castle.nmd.msu.ru>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

This is a "nicer" patch that adds this chipset entry to pci_ids.h as well as 
adding the check in eepro100.c. This chipset is used in (at least) newer 
Compaq laptops, and woks very well. This chipset is already supported in the 
2.4 series, the patch I sent earlier was a diff of the 2.4 driver and the 2.5 
driver.   I am not able to nicely add support for the remaining chipsets, as 
I don't know thier names other then thier pci id's, so this patch does not 
add support for the 7 other chipsets supported in 2.4 but not in 2.5.

I think the earlier patch is more helpful, but at this point I would like to 
at least see my laptop supported by the stock kernel.

Josh



--- drivers/net/eepro100.c.orig	Tue Jan  8 08:26:49 2002
+++ drivers/net/eepro100.c	Tue Jan  8 08:19:35 2002
@@ -2267,6 +2267,8 @@
 		PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82559ER,
 		PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CAM,
+		PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ID1029,
 		PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ID1030,
--- include/linux/pci_ids.h.orig	Tue Jan  8 08:26:49 2002
+++ include/linux/pci_ids.h	Tue Jan  8 08:10:32 2002
@@ -1570,6 +1570,7 @@
 #define PCI_DEVICE_ID_INTEL_82434	0x04a3
 #define PCI_DEVICE_ID_INTEL_I960	0x0960
 #define PCI_DEVICE_ID_INTEL_82562ET	0x1031
+#define PCI_DEVICE_ID_INTEL_82801CAM	0x1038
 #define PCI_DEVICE_ID_INTEL_82559ER	0x1209
 #define PCI_DEVICE_ID_INTEL_82092AA_0	0x1221
 #define PCI_DEVICE_ID_INTEL_82092AA_1	0x1222


