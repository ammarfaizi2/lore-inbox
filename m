Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267665AbRGPSod>; Mon, 16 Jul 2001 14:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267664AbRGPSoW>; Mon, 16 Jul 2001 14:44:22 -0400
Received: from tele-post-20.mail.demon.net ([194.217.242.20]:11013 "EHLO
	tele-post-20.mail.demon.net") by vger.kernel.org with ESMTP
	id <S267658AbRGPSoK>; Mon, 16 Jul 2001 14:44:10 -0400
Date: Mon, 16 Jul 2001 19:36:34 +0100 (BST)
From: Peter Denison <peterd@pnd-pc.demon.co.uk>
To: <jmaurer@cck.uni-kl.de>
cc: <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH 2.4.6] Intel i815 chipset PCI device IDs
Message-ID: <Pine.LNX.4.33.0107161932400.1095-100000@pnd-pc.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description:
	Adds PCI device IDs for the Intel i815(E) chipset and corrects the
PCI device IDs for the mobile/non-mobile versions of the ICH2 hub found in
the same chipset.

--- drivers/pci/pci.ids.old	Sun Jul 15 16:44:00 2001
+++ drivers/pci/pci.ids	Sun Jul 15 16:58:38 2001
@@ -4522,6 +4522,9 @@
 		1014 0119  Netfinity Gigabit Ethernet SX Adapter
 		8086 1000  EtherExpress PRO/1000 Gigabit Server Adapter
 	1030  82559 InBusiness 10/100
+	1130  82815 GMCH Host-Hub Bridge/DRAM Controller
+	1131  82815 GMCH AGP Bridge
+	1132  82815 GMCH Internal Graphics Controller
 	1161  82806AA PCI64 Hub Advanced Programmable Interrupt Controller
 	1209  82559ER
 	1221  82092AA_0
@@ -4628,12 +4631,12 @@
 	2444  82801BA(M) USB (Hub B)
 	2445  82801BA(M) AC'97 Audio
 	2446  82801BA(M) AC'97 Modem
-	2448  82801BA PCI
+	2448  82801BAM PCI Bridge
 	2449  82801BA(M) Ethernet
 	244a  82801BAM IDE U100
 	244b  82801BA IDE U100
-	244c  82801BAM ISA Bridge (ICH2)
-	244e  82801BAM PCI
+	244c  82801BAM ISA Bridge (ICH2-M)
+	244e  82801BA PCI Bridge
 	2500  82820 820 (Camino) Chipset Host Bridge (MCH)
 		1043 801c  P3C-2000 system chipset
 	2501  82820 820 (Camino) Chipset Host Bridge (MCH)
--- include/linux/pci_ids.h.old	Sun Jul 15 16:44:07 2001
+++ include/linux/pci_ids.h	Sun Jul 15 16:50:04 2001
@@ -1494,6 +1494,9 @@
 #define PCI_DEVICE_ID_INTEL_82430	0x0486
 #define PCI_DEVICE_ID_INTEL_82434	0x04a3
 #define PCI_DEVICE_ID_INTEL_I960	0x0960
+#define PCI_DEVICE_ID_INTEL_82815_0	0x1130
+#define PCI_DEVICE_ID_INTEL_82815_1	0x1131
+#define PCI_DEVICE_ID_INTEL_82815_2	0x1132
 #define PCI_DEVICE_ID_INTEL_82559ER	0x1209
 #define PCI_DEVICE_ID_INTEL_82092AA_0	0x1221
 #define PCI_DEVICE_ID_INTEL_82092AA_1	0x1222

-- 
Peter Denison <peterd@pnd-pc.demon.co.uk>
Linux Driver for Promise DC4030VL cards.
See http://www.pnd-pc.demon.co.uk/promise/promise.html for details

