Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316232AbSFDSi0>; Tue, 4 Jun 2002 14:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316397AbSFDSiZ>; Tue, 4 Jun 2002 14:38:25 -0400
Received: from medelec.uia.ac.be ([143.169.17.1]:23559 "EHLO medelec.uia.ac.be")
	by vger.kernel.org with ESMTP id <S316289AbSFDSiW>;
	Tue, 4 Jun 2002 14:38:22 -0400
Date: Tue, 4 Jun 2002 20:36:12 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] linux-2.4.19-pre10 - i8xx series chipsets patches (patch 1)
Message-ID: <20020604203612.A14631@medelec.uia.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

I redid my i8xx series patches for v2.4.19-pre10 . They include support for the 82801DB and 82801E
I/O Controller Hubs for various modules.

Patch 1 is a patch to add the PCI ID's for these new ICH's to the pci.ids file.

Greetings,
Wim.


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.537   -> 1.538  
#	 drivers/pci/pci.ids	1.25    -> 1.26   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/06/04	wim@iguana.be	1.538
# [PATCH] 2.4.19-pre10 - i8xx series chipsets patches (patch 1)
# 
# Add 82801E and 82801DB I/O Controller Hub PCI-IDS to pci.ids file.
# Also add '(Plumas)' name to e7500 chip.
# --------------------------------------------
#
diff -Nru a/drivers/pci/pci.ids b/drivers/pci/pci.ids
--- a/drivers/pci/pci.ids	Tue Jun  4 18:53:49 2002
+++ b/drivers/pci/pci.ids	Tue Jun  4 18:53:50 2002
@@ -5805,7 +5805,14 @@
 	244a  82801BAM IDE U100
 	244b  82801BA IDE U100
 	244c  82801BAM ISA Bridge (LPC)
-	244e  82801BA/CA PCI Bridge
+	244e  82801BA/CA/DB PCI Bridge
+	2450  82801E ISA Bridge (LPC)
+	2452  82801E USB
+	2453  82801E SMBus
+	2459  82801E Ethernet Controller 0
+	245b  82801E IDE U100
+	245d  82801E Ethernet Controller 1
+	245e  82801E PCI Bridge
 	2480  82801CA ISA Bridge (LPC)
 	2482  82801CA/CAM USB (Hub #1)
 	2483  82801CA/CAM SMBus
@@ -5816,6 +5823,15 @@
 	248a  82801CAM IDE U100
 	248b  82801CA IDE U100
 	248c  82801CAM ISA Bridge (LPC)
+	24c0  82801DB ISA Bridge (LPC)
+	24c2  82801DB USB (Hub #1)
+	24c3  82801DB SMBus
+	24c4  82801DB USB (Hub #2)
+	24c5  82801DB AC'97 Audio
+	24c6  82801DB AC'97 Modem
+	24c7  82801DB USB (Hub #3)
+	24cb  82801DB IDE U100
+	24cd  82801DB USB EHCI Controller
 	2500  82820 820 (Camino) Chipset Host Bridge (MCH)
 		1043 801c  P3C-2000 system chipset
 	2501  82820 820 (Camino) Chipset Host Bridge (MCH)
@@ -5829,14 +5845,14 @@
 	2532  82850 850 (Tehama) Chipset AGP Bridge
 	2533  82860 860 (Wombat) Chipset AGP Bridge
 	2534  82860 860 (Wombat) Chipset PCI Bridge
-	2540  e7500 DRAM Controller
-	2541  e7500 DRAM Controller Error Reporting
-	2543  e7500 HI_B Virtual PCI-to-PCI Bridge (F0)
-	2544  e7500 HI_B Virtual PCI-to-PCI Bridge (F1)
-	2545  e7500 HI_C Virtual PCI-to-PCI Bridge (F0)
-	2546  e7500 HI_C Virtual PCI-to-PCI Bridge (F1)
-	2547  e7500 HI_D Virtual PCI-to-PCI Bridge (F0)
-	2548  e7500 HI_D Virtual PCI-to-PCI Bridge (F1)
+	2540  e7500 (Plumas) DRAM Controller
+	2541  e7500 (Plumas) DRAM Controller Error Reporting
+	2543  e7500 (Plumas) HI_B Virtual PCI-to-PCI Bridge (F0)
+	2544  e7500 (Plumas) HI_B Virtual PCI-to-PCI Bridge (F1)
+	2545  e7500 (Plumas) HI_C Virtual PCI-to-PCI Bridge (F0)
+	2546  e7500 (Plumas) HI_C Virtual PCI-to-PCI Bridge (F1)
+	2547  e7500 (Plumas) HI_D Virtual PCI-to-PCI Bridge (F0)
+	2548  e7500 (Plumas) HI_D Virtual PCI-to-PCI Bridge (F1)
 	3092  Integrated RAID
 	3575  82830 830 Chipset Host Bridge
 	3576  82830 830 Chipset AGP Bridge
