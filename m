Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129215AbRBMVa1>; Tue, 13 Feb 2001 16:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129273AbRBMVaR>; Tue, 13 Feb 2001 16:30:17 -0500
Received: from mail.netgem.com ([195.154.83.81]:17162 "EHLO netgem.com")
	by vger.kernel.org with ESMTP id <S129215AbRBMVaM>;
	Tue, 13 Feb 2001 16:30:12 -0500
From: Jocelyn Mayer <jocelyn.mayer@netgem.com>
To: jmaurer@cck.uni-kl.de
Cc: linux-kernel@vger.kernel.org
Message-ID: <3A89A737.A268AFFC@netgem.com>
Date: Tue, 13 Feb 2001 22:29:27 +0100
Organization: Netgem S.A.
X-Mailer: Mozilla 4.61 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
Subject: Updates for the PCI devices Database.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm starting to work on an Intel i815 board.
I take this occasion to make a few updates
to the PCI device database, so it will be easier
to identify the whole hardware...

I changed the base, according what Intel says
in the datasheets for 82815 Chipset
and 82801BA Chip.

Here's the patch:

--- pci.ids-orig	Wed Jan  3 01:58:45 2001
+++ pci.ids	Tue Feb 13 23:29:58 2001
@@ -4484,6 +4484,16 @@
 		1014 0119  Netfinity Gigabit Ethernet SX Adapter
 		8086 1000  EtherExpress PRO/1000 Gigabit Server Adapter
 	1030  82559 InBusiness 10/100
+	1100  82815 Chipset GMCH / FSB DRAM Controler
+	1101  82815 Chipset AGP/PCI Bridge 
+	1102  82815 Chipset Internal Graphic Device
+	1110  82815 Chipset GMCH / FSB DRAM Controler [no AGP]
+	1112  82815 Chipset Internal Graphic Device [no AGP]
+	1120  82815 Chipset GMCH / FSB DRAM Controler [AGP only]
+	1121  82815 Chipset AGP/PCI Bridge [AGP only]
+	1130  82815 Chipset GMCH / FSB DRAM Controler
+	1131  82815 Chipset AGP/PCI Bridge 
+	1132  82815 Chipset Internal Graphic Device
 	1161  82806AA PCI64 Hub Advanced Programmable Interrupt Controller
 	1209  82559ER
 	1221  82092AA_0
@@ -4584,13 +4594,18 @@
 		11d4 0048  SoundMAX Integrated Digital Audio
 	2426  82801AB AC'97 Modem
 	2428  82801AB PCI Bridge
-	2440  82820 820 (Camino 2) Chipset ISA Bridge (ICH2)
-	2442  82820 820 (Camino 2) Chipset USB (Hub A)
-	2443  82820 820 (Camino 2) Chipset SMBus
-	2444  82820 820 (Camino 2) Chipset USB (Hub B)
-	2449  82820 820 (Camino 2) Chipset Ethernet
-	244b  82820 820 (Camino 2) Chipset IDE U100
-	244e  82820 820 (Camino 2) Chipset PCI
+	2440  82801BA (ICH2) Chipset Multi-purpose IO / Interrupt controler
+	2442  82801BA (ICH2) Chipset USB (Hub A)
+	2443  82801BA (ICH2) Chipset SMBus
+	2444  82801BA (ICH2) Chipset USB (Hub B)
+	2445  82801BA (ICH2) Chipset AC'97 Audio 
+	2446  82801BA (ICH2) Chipset Ac'97 Modem 
+	2448  82801BAM (ICH2-M) Chipset PCI Bridge
+	2449  82801BA (ICH2) Chipset Ethernet
+	244a  82801BAM (ICH2-M) Chipset IDE U100
+	244b  82801BA (ICH2) Chipset IDE U100
+	244c  82801BAM (ICH2-M) Multi-purpose IO / Interrupt controler
+	244e  82801 (ICH2) Chipset PCI Bridge
 	2500  82820 820 (Camino) Chipset Host Bridge (MCH)
 		1043 801c  P3C-2000 system chipset
 	2501  82820 820 (Camino) Chipset Host Bridge (MCH)
