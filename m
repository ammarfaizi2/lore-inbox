Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbTILXXM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 19:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261955AbTILXXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 19:23:11 -0400
Received: from smtp12.eresmas.com ([62.81.235.112]:53159 "EHLO
	smtp12.eresmas.com") by vger.kernel.org with ESMTP id S261932AbTILXTg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 19:19:36 -0400
Message-ID: <3F625475.9000502@wanadoo.es>
Date: Sat, 13 Sep 2003 01:19:17 +0200
From: Xose Vazquez Perez <xose@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: gl, es, en
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
CC: Tosatti <marcelo@cyclades.com.br>,
       Lista Linux-Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pci.ids (2.4.23-pre3) now -pre4
References: <3F61FF67.7080504@wanadoo.es> <20030912224447.GA3917@werewolf.able.es>
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------000804090703080205020604"
X-Spam-Score: -2.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000804090703080205020604
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

J.A. Magallon wrote:
> On 09.12, Xose Vazquez Perez wrote:
> 
>>hi,
>>
>>here it goes a sync patch against latest pciids.sourceforge.net
>>(Daily snapshot on Thu 2003-05-29 10:00:04)
>>
> 
> 
> gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -o gen-devlist gen-devlist.c
> ./gen-devlist <pci.ids
> Line 1345: Device name too long
> SiS650/651/M650/740 PCI/AGP VGA Display Adapter
> 
> Line 3081: Device name too long
> VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE
> 
> Changed to
> 
>     6325  SiS65x/M65x/740 PCI/AGP VGA Display Adapter
> 
>     0571  VT82C586x/C686x/33x/35 PIPC Bus Master IDE


now, it should be ok. patch against 2.4.23-pre4
and PCI-X/AGP -> zx1 was fixed too

-- 
Que trabajen los romanos, que tienen el pecho de lata.

--------------000804090703080205020604
Content-Type: text/plain;
 name="pci.ids.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pci.ids.diff"

--- linux/drivers/pci/pci.ids	2003-09-04 01:13:05.000000000 +0200
+++ linux.new/drivers/pci/pci.ids	2003-09-13 01:10:04.000000000 +0200
@@ -7,8 +7,8 @@
 #	so if you have anything to contribute, please visit the home page or
 #	send a diff -u against the most recent pci.ids to pci-ids@ucw.cz.
 #
-#	Daily snapshot on Thu 2003-05-29 10:00:04
-#	Modded on Fri 2003-05-30 03:13:05
+#	Daily snapshot on Fri 2003-09-12 10:00:05
+#	Modded on Fri 2003-09-13 01:01:19
 #
 
 # Vendors, devices and subsystems. Please keep sorted.
@@ -119,6 +119,8 @@
 		0e11 7004  Embedded Ultra Wide SCSI Controller
 		1092 8760  FirePort 40 Dual SCSI Controller
 		1de1 3904  DC390F Ultra Wide SCSI Controller
+		4c53 1000  CC7/CR7/CP7/VC7/VP7/VR7 mainboard
+		4c53 1050  CT7 mainboard
 	0010  53c895
 		0e11 4040  Integrated Array Controller
 		0e11 4048  Integrated Array Controller
@@ -127,6 +129,9 @@
 	0020  53c1010 Ultra3 SCSI Adapter
 		1de1 1020  DC-390U3W
 	0021  53c1010 66MHz  Ultra3 SCSI Adapter
+		4c53 1080  CT8 mainboard
+		4c53 1300  P017 mezzanine (32-bit PMC)
+		4c53 1310  P017 mezzanine (64-bit PMC)
 	0030  53c1030 PCI-X Fusion-MPT Dual Ultra320 SCSI
 		1028 1010  LSI U320 SCSI Controller
 	0040  53c1035
@@ -163,15 +168,12 @@
 	9100  INI-9100/9100W SCSI Host
 1002  ATI Technologies Inc
 	4136  Radeon IGP 320 M
-# New support forthcoming in XFree86 4.3.0
 	4144  Radeon R300 AD [Radeon 9500 Pro]
-# New support forthcoming in XFree86 4.3.0
 	4145  Radeon R300 AE [Radeon 9500 Pro]
-# New support forthcoming in XFree86 4.3.0
 	4146  Radeon R300 AF [Radeon 9500 Pro]
-# Update:  Oops, AF was a typo above for 4147, should be AG
 	4147  Radeon R300 AG [FireGL Z1/X1]
 	4158  68800AX [Mach32]
+	4164  Radeon R300 Secondary (DVI) output
 	4242  Radeon R200 BB [Radeon All in Wonder 8500DV]
 		1002 02aa  Radeon 8500 AIW DV Edition
 	4336  Radeon Mobility U1
@@ -226,6 +228,7 @@
 		1002 0008  Rage XL
 		1002 4752  Rage XL
 		1002 8008  Rage XL
+		1028 00ce  PowerEdge 1400
 		1028 00d1  PowerEdge 2550
 	4753  Rage XC
 		1002 4753  Rage XC
@@ -269,6 +272,7 @@
 	4c44  3D Rage LT Pro AGP-66
 	4c45  Rage Mobility M3 AGP
 	4c46  Rage Mobility M3 AGP 2x
+		1028 00b1  Latitude C600
 	4c47  3D Rage LT-G 215LG
 	4c49  3D Rage LT Pro
 		1002 0004  Rage LT Pro
@@ -277,8 +281,10 @@
 		1002 4c49  Rage LT Pro
 	4c4d  Rage Mobility P/M AGP 2x
 		0e11 b111  Armada M700
+		0e11 b160  Armada E500
 		1002 0084  Xpert 98 AGP 2X (Mobility)
 		1014 0154  ThinkPad A20m
+		1028 00aa  Latitude CPt
 	4c4e  Rage Mobility L AGP 2x
 	4c50  3D Rage LT Pro
 		1002 4c50  Rage LT Pro
@@ -290,32 +296,29 @@
 		1014 0517  ThinkPad T30
 		1028 00e6  Radeon Mobility M7 LW (Dell Inspiron 8100)
 		144d c006  Radeon Mobility M7 LW in vpr Matrix 170B4
-# Update:  More correct labelling for this FireGL chipset
 	4c58  Radeon RV200 LX [Mobility FireGL 7800 M7]
 	4c59  Radeon Mobility M6 LY
 		1014 0235  ThinkPad A30p (2653-64G)
 		1014 0239  ThinkPad X22/X23/X24
 		104d 80e7  VAIO PCG-GR214EP/GR214MP/GR215MP/GR314MP/GR315MP
 	4c5a  Radeon Mobility M6 LZ
-# Update:  Add M9 to product name
 	4c64  Radeon R250 Ld [Radeon Mobility 9000 M9]
-# Update:  Add M9 to product name
 	4c65  Radeon R250 Le [Radeon Mobility 9000 M9]
-# Update:  Add M9 to product name
 	4c66  Radeon R250 Lf [Radeon Mobility 9000 M9]
-# Update:  Add M9 to product name
 	4c67  Radeon R250 Lg [Radeon Mobility 9000 M9]
+# Secondary chip to the Lf
+	4c6e  Radeon R250 Ln [Radeon Mobility 9000 M9] [Secondary]
 	4d46  Rage Mobility M4 AGP
 	4d4c  Rage Mobility M4 AGP
 	4e44  Radeon R300 ND [Radeon 9700 Pro]
 	4e45  Radeon R300 NE [Radeon 9500 Pro]
 		1002 0002  Radeon R300 NE [Radeon 9500 Pro]
 	4e46  Radeon R300 NF [Radeon 9700]
-# Update:  This is FireGL X1, not Radeon 9700
 	4e47  Radeon R300 NG [FireGL X1]
 	4e48  Radeon R350 [Radeon 9800]
 	4e64  Radeon R300 [Radeon 9700 Pro] (Secondary)
 	4e65  Radeon R300 [Radeon 9500 Pro] (Secondary)
+		1002 0003  Radeon R300 NE [Radeon 9500 Pro]
 	4e66  Radeon R300 [Radeon 9700] (Secondary)
 	4e67  Radeon R300 [FireGL X1] (Secondary)
 	4e68  Radeon R350 [Radeon 9800] (Secondary)
@@ -355,7 +358,6 @@
 	5056  Rage 128 PV/PRO TMDS
 	5057  Rage 128 PW/PRO AGP 2x TMDS
 	5058  Rage 128 PX/PRO AGP 4x TMDS
-# Update: This same chip is used in all 32Mb and 64Mb SDR/DDR orig Radeons, and is now known as 7200
 	5144  Radeon R100 QD [Radeon 7200]
 		1002 0008  Radeon 7000/Radeon VE
 		1002 0009  Radeon 7000/Radeon
@@ -386,11 +388,8 @@
 		1002 013a  Radeon 8500
 		148c 2026  R200 QL [Radeon 8500 Evil Master II Multi Display Edition]
 		174b 7149  Radeon R200 QL [Sapphire Radeon 8500 LE]
-# New: Radeon 9100 is basically a Radeon 8500LE branded as 9100 by Sapphire
 	514d  Radeon R200 QM [Radeon 9100]
-# New: Radeon 8500LE chip
 	514e  Radeon R200 QN [Radeon 8500LE]
-# New: Radeon 8500LE chip
 	514f  Radeon R200 QO [Radeon 8500LE]
 	5157  Radeon RV200 QW [Radeon 7500]
 		1002 013a  Radeon 7500
@@ -402,7 +401,6 @@
 		174b 7161  Radeon RV200 QW [Radeon 7500 LE]
 		17af 0202  RV200 QW [Excalibur Radeon 7500LE]
 	5158  Radeon RV200 QX [Radeon 7500]
-# Update: More correct name
 	5159  Radeon RV100 QY [Radeon 7000/VE]
 		1002 000a  Radeon 7000/Radeon VE
 		1002 000b  Radeon 7000
@@ -415,13 +413,12 @@
 		148c 2023  RV100 QY [Radeon 7000 Evil Master Multi-Display]
 		174b 7112  RV100 QY [Sapphire Radeon VE 7000]
 		1787 0202  RV100 QY [Excalibur Radeon 7000]
-# Update: More correct name
 	515a  Radeon RV100 QZ [Radeon 7000/VE]
 	5168  Radeon R200 Qh
 	5169  Radeon R200 Qi
 	516a  Radeon R200 Qj
 	516b  Radeon R200 Qk
-# new: This one is not in ATI documentation, but is in XFree86 source code
+# This one is not in ATI documentation, but is in XFree86 source code
 	516c  Radeon R200 Ql
 	5245  Rage 128 RE/SG
 		1002 0008  Xpert 128
@@ -473,8 +470,10 @@
 		1002 5654  Mach64VT Reference
 	5655  264VT3 [Mach64 VT3]
 	5656  264VT4 [Mach64 VT4]
+	5961  Radeon RV280 [Radeon 9200]
 	700f  PCI Bridge [IGP 320M]
 	7010  PCI Bridge [IGP 340M]
+	cab0  AGP Bridge [IGP 320M]
 	cab2  RS200/RS200M AGP Bridge [IGP 340M]
 1003  ULSI Systems
 	0201  US201
@@ -529,7 +528,14 @@
 	0011  NS87560 National PCI System I/O
 	0012  USB Controller
 	0020  DP83815 (MacPhyter) Ethernet Controller
+		1385 f311  FA311 / FA312 (FA311 with WoL HW)
 	0022  DP83820 10/100/1000 Ethernet Controller
+	0028  CS5535 Host bridge
+	002b  CS5535 ISA bridge
+	002d  CS5535 IDE
+	002e  CS5535 Audio
+	002f  CS5535 USB
+	0030  CS5535 Video
 	0500  SCx200 Bridge
 	0501  SCx200 SMI
 	0502  SCx200 IDE
@@ -631,7 +637,9 @@
 		0e11 4051  Integrated Smart Array
 		0e11 4058  Integrated Smart Array
 		103c 10c2  Hewlett-Packard NetRAID-4M
-		12d9 000a  VoIP PCI Gateway
+		12d9 000a  IP Telephony card
+		4c53 1050  CT7 mainboard
+		4c53 1051  CE7 mainboard
 		9005 0365  Adaptec 5400S
 		9005 1364  Dell PowerEdge RAID Controller 2
 		9005 1365  Dell PowerEdge RAID Controller 2
@@ -696,14 +704,17 @@
 	001b  GXT-150P
 	001c  Carrera
 	001d  82G2675
-	0020  MCA
+	0020  GXT1000 Graphics Adapter
 	0022  IBM27-82351
 	002d  Python
-	002e  ServeRAID Controller
+# [official name in AIX 5]
+	002e  SCSI RAID Adapter [ServeRAID]
 		1014 002e  ServeRAID-3x
 		1014 022e  ServeRAID-4H
+	0031  2 Port Serial Adapter
 	0036  Miami
 	003a  CPU to PCI Bridge
+	003c  GXT250P/GXT255P Graphics Adapter
 	003e  16/4 Token ring UTP/STP controller
 		1014 003e  Token-Ring Adapter
 		1014 00cd  Token-Ring Adapter + Wake-On-LAN
@@ -721,24 +732,31 @@
 	004f  ATM Controller (14104f00)
 	0050  ATM Controller (14105000)
 	0053  25 MBit ATM Controller
+	0054  GXT500P/GXT550P Graphics Adapter
 	0057  MPEG PCI Bridge
 	005c  i82557B 10/100
+	005e  GXT800P Graphics Adapter
 	007c  ATM Controller (14107c00)
 	007d  3780IDSP [MWave]
+	008e  GXT3000P Graphics Adapter
 	0090  GXT 3000P
 		1014 008e  GXT-3000P
+	0091  SSA Adapter
 	0095  20H2999 PCI Docking Bridge
 	0096  Chukar chipset SCSI controller
 		1014 0097  iSeries 2778 DASD IOA
 		1014 0098  iSeries 2763 DASD IOA
 		1014 0099  iSeries 2748 DASD IOA
+	009f  PCI 4758 Cryptographic Accelerator
 	00a5  ATM Controller (1410a500)
 	00a6  ATM 155MBPS MM Controller (1410a600)
 	00b7  256-bit Graphics Rasterizer [Fire GL1]
 		1902 00b8  Fire GL1
+	00b8  GXT2000P Graphics Adapter
 	00be  ATM 622MBPS Controller (1410be00)
 	00dc  Advanced Systems Management Adapter (ASMA)
 	00fc  CPC710 Dual Bridge and Memory Controller (PCI-64)
+	0104  Gigabit Ethernet-SX Adapter
 	0105  CPC710 Dual Bridge and Memory Controller (PCI-32)
 	010f  Remote Supervisor Adapter (RSA)
 	0142  Yotta Video Compositor Input
@@ -746,6 +764,14 @@
 	0144  Yotta Video Compositor Output
 		1014 0145  Yotta Output Controller (ytout)
 	0156  405GP PLB to PCI Bridge
+	015e  622Mbps ATM PCI Adapter
+	0160  64bit/66MHz PCI ATM 155 MMF
+	016e  GXT4000P Graphics Adapter
+	0170  GXT6000P Graphics Adapter
+	017d  GXT300P Graphics Adapter
+	0180  Snipe chipset SCSI controller
+		1014 0241  iSeries 2757 DASD IOA
+		1014 0264  Quad Channel PCI-X U320 SCSI RAID Adapter (2780)
 	01a7  PCI-X to PCI-X Bridge
 	01bd  ServeRAID Controller
 		1014 01be  ServeRAID-4M
@@ -755,6 +781,19 @@
 		1014 022e  ServeRAID-4H
 		1014 0258  ServeRAID-5i
 		1014 0259  ServeRAID-5i
+	01c1  64bit/66MHz PCI ATM 155 UTP
+	01e6  Cryptographic Accelerator
+	01ff  10/100 Mbps Ethernet
+	0219  Multiport Serial Adapter
+		1014 021a  Dual RVX
+		1014 0251  Internal Modem/RVX
+		1014 0252  Quad Internal Modem
+	021b  GXT6500P Graphics Adapter
+	021c  GXT4500P Graphics Adapter
+	0233  GXT135P Graphics Adapter
+	0266  PCI-X Dual Channel SCSI
+	0268  Gigabit Ethernet-SX Adapter (PCI-X)
+	0269  10/100/1000 Base-TX Ethernet Adapter (PCI-X)
 	0302  XA-32 chipset [Summit]
 	ffff  MPIC-2 interrupt controller
 1015  LSI Logic Corp of Canada
@@ -817,9 +856,16 @@
 		1259 2454  AT-2450v4 10Mb Ethernet Adapter
 		1259 2700  AT-2700TX 10/100 Fast Ethernet
 		1259 2701  AT-2700FX 100Mb Ethernet
+		4c53 1000  CC7/CR7/CP7/VC7/VP7/VR7 mainboard
+		4c53 1010  CP5/CR6 mainboard
+		4c53 1020  VR6 mainboard
+		4c53 1030  PC5 mainboard
+		4c53 1040  CL7 mainboard
+		4c53 1060  PC7 mainboard
 	2001  79c978 [HomePNA]
 		1092 0a78  Multimedia Home Network Adapter
 		1668 0299  ActionLink Home Network Adapter
+	2003  Am 1771 MBW [Alchemy]
 	2020  53c974 [PCscsi]
 	2040  79c974
 	3000  ELanSC520 Microcontroller
@@ -864,6 +910,7 @@
 	746b  AMD-8111 ACPI
 	746d  AMD-8111 AC97 Audio
 	746e  AMD-8111 MC97 Modem
+	756b  AMD-8111 ACPI
 1023  Trident Microsystems
 	0194  82C194
 	2000  4DWave DX
@@ -1133,6 +1180,12 @@
 	00b8  F64310
 	00c0  F69000 HiQVideo
 		102c 00c0  F69000 HiQVideo
+		4c53 1000  CC7/CR7/CP7/VC7/VP7/VR7 mainboard
+		4c53 1010  CP5/CR6 mainboard
+		4c53 1020  VR6 mainboard
+		4c53 1030  PC5 mainboard
+		4c53 1050  CT7 mainboard
+		4c53 1051  CE7 mainboard
 	00d0  F65545
 	00d8  F65545
 	00dc  F65548
@@ -1144,6 +1197,11 @@
 	00f4  F68554 HiQVision
 	00f5  F68555
 	0c30  F69030
+		4c53 1000  CC7/CR7/CP7/VC7/VP7/VR7 mainboard
+		4c53 1050  CT7 mainboard
+		4c53 1051  CE7 mainboard
+# C5C project cancelled
+		4c53 1080  CT8 mainboard
 102d  Wyse Technology Inc.
 	50dc  3328 Audio
 102e  Olivetti Advanced Technology
@@ -1160,6 +1218,7 @@
 	6057  MiroVideo DC10/DC30+
 1032  Compaq
 1033  NEC Corporation
+	0000  Vr4181A USB Host or Function Control Unit
 	0001  PCI to 486-like bus Bridge
 	0002  PCI to VL98 Bridge
 	0003  ATM Controller
@@ -1201,9 +1260,11 @@
 	00a6  VRC5477 AC97
 	00cd  IEEE 1394 [OrangeLink] Host Controller
 		12ee 8011  Root hub
+	00df  Vr4131
 	00e0  USB 2.0
 		12ee 7001  Root hub
 		1799 0002  Root Hub
+	00f3  uPD6113x Multimedia Decoder/Processor [EMMA2]
 1034  Framatome Connectors USA Inc.
 1035  Comp. & Comm. Research Lab
 1036  Future Domain Corp.
@@ -1252,6 +1313,7 @@
 	0755  SiS 755 Host Bridge
 	0900  SiS900 10/100 Ethernet
 		1039 0900  SiS900 10/100 Ethernet Adapter
+		1043 8035  CUSI-FX motherboard
 	0961  SiS961 [MuTIOL Media IO]
 	0962  SiS962 [MuTIOL Media IO]
 	3602  83C602
@@ -1263,6 +1325,7 @@
 	5513  5513 [IDE]
 		1019 0970  P6STP-FL motherboard
 		1039 5513  SiS5513 EIDE Controller (A,B step)
+		1043 8035  CUSI-FX motherboard
 	5517  5517
 	5571  5571
 	5581  5581 Pentium Chipset
@@ -1276,6 +1339,7 @@
 	6236  6236 3D-AGP
 	6300  SiS630 GUI Accelerator+3D
 		1019 0970  P6STP-FL motherboard
+		1043 8035  CUSI-FX motherboard
 	6306  SiS530 3D PCI/AGP
 		1039 6306  SiS530,620 GUI Accelerator+3D
 	6325  SiS65x/M650/740 PCI/AGP VGA Display Adapter
@@ -1318,6 +1382,7 @@
 		15c5 0111  SiS PCI Audio Accelerator
 		270f a171  SiS PCI Audio Accelerator
 		a0a0 0022  SiS PCI Audio Accelerator
+	7019  SiS7019 Audio Accelerator
 103a  Seiko Epson Corporation
 103b  Tatung Co. of America
 103c  Hewlett-Packard Company
@@ -1362,7 +1427,7 @@
 	121c  NetServer PCI COM Port Decoder
 	1229  zx1 System Bus Adapter
 	122a  zx1 I/O Controller
-	122e  PCI-X/AGP Local Bus Adapter
+	122e  zx1 PCI-X/AGP Local Bus Adapter
 	127c  sx1000 I/O Controller
 	1290  Auxiliary Diva Serial Port
 	2910  E2910A PCIBus Exerciser
@@ -1380,7 +1445,7 @@
 1043  Asustek Computer, Inc.
 	0675  ISDNLink P-IN100-ST-D
 	4021  v7100 Combo Deluxe [GeForce2 MX + TV tuner]
-	4057  V8200 GeForce 3
+	4057  v8200 GeForce 3
 1044  Distributed Processing Technology
 	1012  Domino RAID Engine
 	a400  SmartCache/Raid I-IV Controller
@@ -1442,7 +1507,7 @@
 	c832  82C832
 	c861  82C861
 	c895  82C895
-	c935  EV1935 ECTIVA MachOne PCI Audio
+	c935  EV1935 ECTIVA MachOne PCIAudio
 	d568  82C825 [Firebridge 2]
 	d721  IDE [FireStar]
 1046  IPC Corporation, Ltd.
@@ -1452,16 +1517,24 @@
 	1000  QuickStep 1000
 	3000  QuickStep 3000
 1049  Fountain Technologies, Inc.
-104a  SGS Thomson Microelectronics
+# # nee SGS Thomson Microelectronics
+104a  STMicroelectronics
 	0008  STG 2000X
 	0009  STG 1764X
 	0010  STG4000 [3D Prophet Kyro Series]
+	0209  STPC Consumer/Industrial North- and Southbridge
+	020a  STPC Atlas/ConsumerS/Consumer IIA Northbridge
 # From <http://gatekeeper.dec.com/pub/BSD/FreeBSD/FreeBSD-stable/src/share/misc/pci_vendors>
 	0210  STPC Atlas ISA Bridge
+	021a  STPC Consumer S Southbridge
+	021b  STPC Consumer IIA Southbridge
+	0500  ST70137 [Unicorn] ADSL DMT Transceiver
+	0564  STPC Client Northbridge
 	0981  DEC-Tulip compatible 10/100 Ethernet
 	1746  STG 1764X
 	2774  DEC-Tulip compatible 10/100 Ethernet
 	3520  MPEG-II decoder card
+	55cc  STPC Client Southbridge
 104b  BusLogic
 	0140  BT-946C (old) [multimaster  01]
 	1040  BT-946C (BA80C30) [MultiMaster 10]
@@ -1516,6 +1589,9 @@
 		1028 00e6  PCI4451 IEEE-1394 Controller (Dell Inspiron 8100)
 	8029  PCI4510 IEEE-1394 Controller
 	8400  ACX 100 22Mbps Wireless Interface
+	8401  ACX 100 22Mbps Wireless Interface
+# OK, this info is almost useless as is, but at least it's known that it's a wireless card. More info requested from reporter (whi
+	9000  Wireless Interface (of unknown type)
 	a001  TDC1570
 	a100  TDC1561
 	a102  TNETA1575 HyperSAR Plus w/PCI Host i/f & UTOPIA i/f
@@ -1533,6 +1609,7 @@
 	ac1b  PCI1450
 		0e11 b113  Armada M700
 	ac1c  PCI1225
+		0e11 b121  Armada E500
 	ac1d  PCI1251A
 	ac1e  PCI1211
 	ac1f  PCI1251B
@@ -1550,6 +1627,7 @@
 	ac50  PCI1410 PC card Cardbus Controller
 	ac51  PCI1420
 		1014 023b  ThinkPad T23 (2647-4MG)
+		1028 00b1  Latitude C600
 		10cf 1095  Lifebook C6155
 		e4bf 1000  CP2-2-HIPHOP
 	ac52  PCI1451 PC card Cardbus Controller
@@ -1638,6 +1716,7 @@
 	0d38  20263
 		105a 4d39  Fasttrak66
 	1275  20275
+	3318  PDC20318 (SATA150 TX4)
 	3376  PDC20376
 		1043 809e  A7V8X motherboard
 	4d30  20267
@@ -1660,6 +1739,7 @@
 	6269  PDC20271
 		105a 6269  FastTrak TX2/TX2000
 	6621  PDC20621 [SX4000] 4 Channel IDE RAID Controller
+	6629  PDC20619 FastTrak TX4000 RAID
 	7275  PDC20277
 105b  Foxconn International, Inc.
 105c  Wipro Infotech Limited
@@ -1746,6 +1826,7 @@
 	0002  DAC960PD
 	0010  DAC960PX
 	0050  AcceleRAID 352/170/160 support Device
+	b166  Gemstone chipset SCSI controller
 	ba55  eXtremeRAID 1100 support Device
 	ba56  eXtremeRAID 2000/3000 support Device
 106a  Aten Research Inc
@@ -1974,6 +2055,8 @@
 	1190  PCI-MIO-16E-4
 	1330  PCI-6031E
 	1350  PCI-6071E
+	17d0  PCI-6503
+	2410  PCI-6733
 	2a60  PCI-6023E
 	b001  IMAQ-PCI-1408
 	b011  IMAQ-PXI-1408
@@ -2241,6 +2324,7 @@
 		d84d 4078  EX-4078 2S(16C552) RS-232+1P
 	9054  PCI <-> IOBus Bridge
 		10b5 2455  Wessex Techology PHIL-PCI
+		10b5 2696  Innes Corp AM Radcap card
 		12d9 0002  PCI Prosody Card rev 1.5
 	9060  9060
 	906d  9060SD
@@ -2250,6 +2334,7 @@
 		10b5 9080  9080 [real subsystem ID not set]
 		129d 0002  Aculab PCI Prosidy card
 		12d9 0002  PCI Prosody Card
+	bb04  B&B 3PCIOSD1A Isolated PCI Serial
 10b6  Madge Networks
 	0001  Smart 16/4 PCI Ringnode
 	0002  Smart 16/4 PCI Ringnode Mk2
@@ -2316,6 +2401,7 @@
 		10b7 656b  3CCFEM656 10/100 LAN+56K Modem CardBus
 	6564  3CCFEM656 [id 6564] Cyclone CardBus
 	7646  3cSOHO100-TX Hurricane
+	7770  3CRWE777 PCI(PLX) Wireless Adaptor [Airconnect]
 	7940  3c803 FDDILink UTP Controller
 	7980  3c804 FDDILink SAS Controller
 	7990  3c805 FDDILink DAS Controller
@@ -2356,7 +2442,8 @@
 	9058  3c905B-Combo [Deluxe Etherlink XL 10/100]
 	905a  3c905B-FX [Fast Etherlink XL FX 10/100]
 	9200  3c905C-TX/TX-M [Tornado]
-		1028 0095  Integrated 3C905C-TX Fast Etherlink for PC Management NIC
+		1028 0095  3C920 Integrated Fast Ethernet Controller
+		1028 0097  3C920 Integrated Fast Ethernet Controller
 		10b7 1000  3C905C-TX Fast Etherlink for PC Management NIC
 		10b7 7000  10/100 Mini PCI Ethernet Adapter
 	9201  3C920B-EMB Integrated Fast Ethernet Controller
@@ -2539,7 +2626,10 @@
 10c9  Dataexpert Corporation
 10ca  Fujitsu Microelectr., Inc.
 10cb  Omron Corporation
-10cc  Mentor ARC Inc
+# nee Mentor ARC Inc
+10cc  Mai Logic Incorporated
+	0660  Articia S Host Bridge
+	0661  Articia S PCI Bridge
 10cd  Advanced System Products, Inc
 	1100  ASC1100
 	1200  ASC1200 [(abp940) Fast SCSI-II]
@@ -2548,9 +2638,9 @@
 	2300  ABP940-UW
 	2500  ABP940-U2W
 10ce  Radius
-10cf  Citicorp TTI
+# nee Citicorp TTI
+10cf  Fujitsu Limited.
 	2001  mb86605
-10d0  Fujitsu Limited
 10d1  FuturePlus Systems Corp.
 10d2  Molex Incorporated
 10d3  Jabil Circuit Inc
@@ -2659,9 +2749,21 @@
 		1043 0c11  A7N8X Mainboard
 	006a  nForce2 AC97 Audio Controler (MCP)
 	006b  nForce MultiMedia audio [Via VT82C686B]
+	006c  nForce2 External PCI Bridge
+	006d  nForce2 PCI Bridge
 	006e  nForce2 FireWire (IEEE 1394) Controller
 	00a0  NV5 [Aladdin TNT2]
 		14af 5810  Maxi Gamer Xentor
+	00d0  nForce3 LPC Bridge
+	00d1  nForce3 Host Bridge
+	00d2  nForce3 AGP Bridge
+	00d4  nForce3 SMBus
+	00d5  nForce3 IDE
+	00d6  nForce3 Ethernet
+	00d7  nForce3 USB 1.1
+	00d8  nForce3 USB 2.0
+	00da  nForce3 Audio
+	00dd  nForce3 PCI Bridge
 	0100  NV10 [GeForce 256 SDR]
 		1043 0200  AGP-V6600 SGRAM
 		1043 0201  AGP-V6600 SDRAM
@@ -2673,6 +2775,7 @@
 		1043 0202  AGP-V6800 DDR
 		1043 400a  AGP-V6800 DDR SGRAM
 		1043 400b  AGP-V6800 DDR SDRAM
+		107d 2822  WinFast GeForce 256
 		1102 102e  CT6971 GeForce 256 DDR
 		14af 5021  3D Prophet DDR-DVI
 	0103  NV10GL [Quadro]
@@ -2711,12 +2814,14 @@
 	017b  NV17GL [Quadro4 550 XGL]
 	017c  NV17GL [Quadro4 550 GoGL]
 	0181  NV18 [GeForce4 MX 440 AGP 8x]
+		1043 806f  V9180 Magic
+		1462 8880  MS-StarForce GeForce4 MX 440 with AGP8X
 	0182  NV18 [GeForce4 MX 440SE AGP 8x]
 	0183  NV18 [GeForce4 MX 420 AGP 8x]
 	0188  NV18GL [Quadro4 580 XGL]
-	018a  NV18GL [Quadro4 NVS]
+	018a  NV18GL [Quadro4 NVS AGP 8x]
 	018b  NV18GL [Quadro4 380 XGL]
-	01a0  NV15 [GeForce2 - nForce GPU]
+	01a0  NVCrush11 [GeForce2 MX Integrated Graphics]
 	01a4  nForce CPU bridge
 	01ab  nForce 420 Memory Controller (DDR)
 	01ac  nForce 220/420 Memory Controller
@@ -2730,7 +2835,14 @@
 	01c1  Intel 537 [nForce MC97 Modem]
 	01c2  nForce USB Controller
 	01c3  nForce Ethernet Controller
+	01e0  nForce2 AGP (different version?)
 	01e8  nForce2 AGP
+	01ea  nForce2 Memory Controller 0
+	01eb  nForce2 Memory Controller 1
+	01ec  nForce2 Memory Controller 2
+	01ed  nForce2 Memory Controller 3
+	01ee  nForce2 Memory Controller 4
+	01ef  nForce2 Memory Controller 5
 	01f0  NV18 [GeForce4 MX - nForce GPU]
 	0200  NV20 [GeForce3]
 		1043 402f  AGP-V8200 DDR
@@ -2759,6 +2871,14 @@
 	0302  NV30 [GeForce FX 5800]
 	0308  NV30GL [Quadro FX 2000]
 	0309  NV30GL [Quadro FX 1000]
+	0311  NV31 [GeForce FX 5600 Ultra]
+	0312  NV31 [GeForce FX 5600]
+	0321  NV34 [GeForce FX 5200 Ultra]
+	0322  NV34 [GeForce FX 5200]
+	032b  NV34GL [Quadro FX 500]
+	0330  NV35 [GeForce FX 5900 Ultra]
+	0331  NV35 [GeForce FX 5900]
+	0338  NV35GL [Quadro FX 3000]
 10df  Emulex Corporation
 	1ae5  LP6000 Fibre Channel Host Adapter
 	f085  LP850 Fibre Channel Adapter
@@ -2805,6 +2925,7 @@
 	811a  PCI-IEEE1355-DS-DE Interface
 	8170  S5933 [Matchmaker] (Chipset Development Tool)
 	82db  AJA HDNTV HD SDI Framestore
+	8851  S5933 on Innes Corp FM Radio Capture card
 10e9  Alps Electric Co., Ltd.
 10ea  Intergraphics Systems
 	1680  IGA-1680
@@ -2864,6 +2985,7 @@
 	3fc3  RME Digi96/8 Pad
 	3fc4  RME Digi9652 (Hammerfall)
 	3fc5  RME Hammerfall DSP
+	8381  Ellips Santos Frame Grabber
 10ef  Racore Computer Products, Inc.
 	8154  M815x Token Ring Adapter
 10f0  Peritek Corporation
@@ -2962,6 +3084,7 @@
 		1043 808c  A7V8X motherboard
 		1106 0571  VT82C586/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE
 		1179 0001  Magnia Z310
+		1297 f641  FX41 motherboard
 		1458 5002  GA-7VAX Mainboard
 	0576  VT82C576 3V [Apollo Master]
 	0585  VT82C585VP [Apollo VP1/VPX]
@@ -3004,6 +3127,7 @@
 		1019 0985  P6VXA Motherboard
 		1043 808c  A7V8X motherboard
 		1179 0001  Magnia Z310
+		1458 5004  GA-7VAX Mainboard
 	3040  VT82C586B ACPI
 	3043  VT86C100A [Rhine]
 		10bd 0000  VT86C100A Fast Ethernet Adapter
@@ -3028,6 +3152,7 @@
 		15dd 7609  Onboard Audio
 	3059  VT8233/A/8235 AC97 Audio Controller
 		1043 8095  A7V8X Motherboard (Realtek ALC650 codec)
+		1297 c160  FX41 motherboard (Realtek ALC650 codec)
 		1458 a002  GA-7VAX Onboard Audio (Realtek ALC650)
 	3065  VT6102 [Rhine-II]
 		1106 0102  VT6102 [Rhine II] Embeded Ethernet Controller on VT8235
@@ -3046,11 +3171,13 @@
 	3103  VT8615 Host Bridge
 	3104  USB 2.0
 		1043 808c  A7V8X motherboard
+		1297 f641  FX41 motherboard
 		1458 5004  GA-7VAX Mainboard
 	3106  VT6105 [Rhine-III]
 	3109  VT8233C PCI to ISA Bridge
 	3112  VT8361 [KLE133] Host Bridge
 	3116  VT8375 [KM266/KL266] Host Bridge
+		1297 f641  FX41 motherboard
 # found on EPIA M6000/9000 mainboard
 	3122  VT8623 [Apollo CLE266] integrated CastleRock graphics
 # found on EPIA M6000/9000 mainboard
@@ -3063,6 +3190,7 @@
 	3168  VT8374 P4X400 Host Controller/AGP Bridge
 	3177  VT8235 ISA Bridge
 		1043 808c  A7V8X motherboard
+		1297 f641  FX41 motherboard
 		1458 5001  GA-7VAX Mainboard
 	3189  VT8377 [KT400 AGP] Host Bridge
 		1043 807f  A7V8X motherboard
@@ -3089,6 +3217,7 @@
 	b103  VT8615 AGP Bridge
 	b112  VT8361 [KLE133] AGP Bridge
 	b168  VT8235 PCI Bridge
+	b198  VT8237 PCI Bridge
 1107  Stratus Computers
 	0576  VIA VT82C570MV [Apollo] (Wrong vendor ID!)
 1108  Proteon, Inc.
@@ -3112,6 +3241,7 @@
 	007c  FSC Remote Service Controller, shared memory device
 	007d  FSC Remote Service Controller, SMIC device
 	2102  DSCC4 WAN adapter
+	4021  SIMATIC NET CP 5512 (Profibus and MPI Cardbus Adapter)
 	4942  FPGA I-Bus Tracer for MBD
 	6120  SZB6120
 110b  Chromatic Research Inc.
@@ -3281,7 +3411,9 @@
 	1562  USB 2.0 Host Controller
 	3400  SmartPCI56(UCB1500) 56K Modem
 	7130  SAA7130 Video Broadcast Decoder
+		5168 0138  LiveView FlyVideo 2000
 	7133  SAA7133 Audio+video broadcast decoder
+		5168 0138  LifeView FlyVideo 3000
 # PCI audio and video broadcast decoder (http://www.semiconductors.philips.com/pip/saa7134hl)
 	7134  SAA7134
 	7135  SAA7135 Audio+video broadcast decoder
@@ -3303,24 +3435,67 @@
 	b921  EiconCard P92
 	b922  EiconCard P92
 	b923  EiconCard P92
-	e001  DIVA 20PRO
-		1133 e001  DIVA Pro 2.0 S/T
-	e002  DIVA 20
-		1133 e002  DIVA 2.0 S/T
-	e003  DIVA 20PRO_U
-		1133 e003  DIVA Pro 2.0 U
-	e004  DIVA 20_U
-		1133 e004  DIVA 2.0 U
-	e005  DIVA LOW
-		1133 e005  DIVA 2.01 S/T
-	e00b  DIVA 2.02
-	e010  DIVA Server BRI-2M
-		1133 e010  DIVA Server BRI-2M
-	e012  DIVA Server BRI-8M
-		1133 e012  DIVA Server BRI-8M
-	e014  DIVA Server PRI-30M
-		1133 e014  DIVA Server PRI-30M
-	e018  DIVA Server BRI-2M/-2F
+	e001  Diva Pro 2.0 S/T
+		1133 e001  Diva Pro 2.0 S/T
+	e002  Diva 2.0 S/T PCI
+		1133 e002  Diva 2.0 S/T
+	e003  Diva Pro 2.0 U
+		1133 e003  Diva Pro 2.0 U
+	e004  Diva 2.0 U PCI
+		1133 e004  Diva 2.0 U
+	e005  Diva 2.01 S/T PCI
+		1133 e005  Diva 2.01 S/T
+	e006  Diva CT S/T PCI
+	e007  Diva CT U PCI
+	e008  Diva CT Lite S/T PCI
+	e009  Diva CT Lite U PCI
+	e00a  Diva ISDN+V.90 PCI
+	e00b  Diva 2.02 PCI S/T
+	e00c  Diva 2.02 PCI U
+	e00d  Diva ISDN Pro 3.0 PCI
+	e00e  Diva ISDN+CT S/T PCI Rev 2
+	e010  Diva Server BRI-2M PCI
+		110a 0021  Fujitsu Siemens ISDN S0
+		1133 e010  Diva Server BRI-2M
+		8001 0014  Diva Server BRI-2M PCI Cornet NQ
+	e011  Diva Server BRI S/T Rev 2
+	e012  Diva Server 4BRI-8M PCI
+		1133 e012  Diva Server BRI-8M
+		8001 0014  Diva Server 4BRI-8M PCI Cornet NQ
+	e013  Diva Server 4BRI-8M Rev 2
+		8001 0014  Diva Server 4BRI-8M Cornet NQ 2
+	e014  Diva Server PRI-30M PCI
+		0008 0100  Diva Server PRI-30M PCI
+		1133 e014  Diva Server PRI-30M
+		8001 0014  Diva Server PRI-30M PCI Cornet NQ
+	e015  DIVA Server PRI-30M 2.0
+		8001 0014  Diva Server PRI Cornet NQ 2
+	e016  Diva Server Voice 4BRI PCI
+		8001 0014  Diva Server PRI Cornet NQ
+	e017  Diva Server Voice 4BRI PCI Rev 2
+		8001 0014  Diva Server Voice 4BRI PCI Cornet NQ 2
+	e018  Diva Server BRI 2M Revision 2
+		8001 0014  Diva Server BRI 2M Cornet NQ 2
+	e019  Diva Server Voice PRI PCI Rev 2
+		8001 0014  Diva Server Voice PRI PCI Cornet NQ 2
+	e01a  Diva Server 2FX
+	e01b  Diva Server BRI-2M Voice Revision 2
+		8001 0014  Diva Server BRI-2M Voice Cornet NQ 2
+	e01c  Diva Server PRI Rev 3.0
+		1133 1c01  Diva Server PRI/E1/T1-8 Rev 3.0
+		1133 1c02  Diva Server PRI/T1-24 Rev 3.0
+		1133 1c03  Diva Server PRI/E1-30 Rev 3.0
+		1133 1c04  Diva Server V-PRI/E1/T1 Rev 3.0
+		1133 1c05  Diva Server V-PRI/T1-24 Rev 3.0
+		1133 1c06  Diva Server V-PRI/E1-30 Rev 3.0
+		1133 1c07  Diva Server PRI/E1/T1-8 Cornet NQ 3
+		1133 1c08  Diva Server PRI/T1-24 Cornet NQ 3
+		1133 1c09  Diva Server PRI/E1-30 Cornet NQ 3
+		1133 1c0a  Diva Server V-PRI/E1/T1 Cornet NQ 3
+		1133 1c0b  Diva Server V-PRI/T1-24 Cornet NQ 3
+		1133 1c0c  Diva Server V-PRI/E1-30 Cornet NQ 3
+	e01e  Diva Server 2PRI
+	e020  Diva Server 4PRI
 1134  Mercury Computer Systems
 	0001  Raceway Bridge
 1135  Fuji Xerox Co Ltd
@@ -3559,14 +3734,20 @@
 	0017  GCNB-LE Host Bridge
 	0200  OSB4 South Bridge
 	0201  CSB5 South Bridge
+		4c53 1080  CT8 mainboard
 	0203  CSB6 South Bridge
 	0211  OSB4 IDE Controller
 	0212  CSB5 IDE Controller
+		4c53 1080  CT8 mainboard
 	0213  CSB6 RAID/IDE Controller
 	0220  OSB4/CSB5 OHCI USB Controller
+		4c53 1080  CT8 mainboard
 	0221  CSB6 OHCI USB Controller
 	0225  GCLE Host Bridge
+# cancelled
+		4c53 1080  CT8 mainboard
 	0227  GCLE-2 Host Bridge
+		4c53 1080  CT8 mainboard
 1167  Mutoh Industries Inc
 1168  Thine Electronics Inc
 1169  Centre for Development of Advanced Computing
@@ -3854,6 +4035,7 @@
 	044e  LT WinModem
 	044f  V90 WildWire Modem
 	0450  LT WinModem
+		1033 80a8  Versa Note Vxi
 		144f 4005  Magnia SG20
 	0451  LT WinModem
 	0452  LT WinModem
@@ -4155,8 +4337,11 @@
 		1328 0001  Cinemaster C 3.0 DVD Decoder
 1240  Marathon Technologies Corp.
 1241  DSC Communications
-1242  Jaycor Networks, Inc.
-	1242  JNI Corporation (former Jaycor Networks, Inc.)
+# Formerly Jaycor Networks, Inc.
+1242  JNI Corporation
+	1560  JNIC-1560 PCI-X Fibre Channel Controller
+		1242 6562  FCX2-6562 Dual Channel PCI-X Fibre Channel Adapter
+		1242 656a  FCX-6562 PCI-X Fibre Channel Adapter
 	4643  FCI-1063 Fibre Channel Adapter
 	6562  FCX2-6562 Dual Channel PCI-X Fibre Channel Adapter
 	656a  FCX-6562 PCI-X Fibre Channel Adapter
@@ -4221,7 +4406,7 @@
 		125d 8888  Solo-1 Audio Adapter
 		525f c888  ES1969 SOLO-1 AudioDrive (+ES1938)
 	1978  ES1978 Maestro 2E
-		0e11 b112  Armada M700
+		0e11 b112  Armada M700/E500
 		1033 803c  ES1978 Maestro-2E Audiodrive
 		1033 8058  ES1978 Maestro-2E Audiodrive
 		1092 4000  Monster Sound MX400
@@ -4232,6 +4417,7 @@
 	1989  ESS Modem
 		125d 1989  ESS Modem
 	1998  ES1983S Maestro-3i PCI Audio Accelerator
+		1028 00b1  Latitude C600
 		1028 00e6  ES1983S Maestro-3i (Dell Inspiron 8100)
 	1999  ES1983S Maestro-3i PCI Modem Accelerator
 	199a  ES1983S Maestro-3i PCI Audio Accelerator
@@ -4282,6 +4468,7 @@
 	0710  SM710 LynxEM
 	0712  SM712 LynxEM+
 	0720  SM720 Lynx3DM
+	0730  SM731 Cougar3DR
 	0810  SM810 LynxE
 	0811  SM811 LynxE
 	0820  SM820 Lynx3D
@@ -4571,7 +4758,7 @@
 12b6  Natural Microsystems
 12b7  Cognex Modular Vision Systems Div. - Acumen Inc.
 12b8  Korg
-12b9  US Robotics/3Com
+12b9  5610 56K FaxModem
 	1006  WinModem
 		12b9 005c  USR 56k Internal Voice WinModem (Model 3472)
 		12b9 005e  USR 56k Internal WinModem (Models 662975)
@@ -4667,6 +4854,7 @@
 12dc  Symicron Computer Communication Ltd.
 12dd  Management Graphics
 12de  Rainbow Technologies
+	0200  CryptoSwift CS200
 12df  SBS Technologies Inc
 12e0  Chase Research
 	0010  ST16C654 Quad UART
@@ -4865,6 +5053,10 @@
 132d  Integrated Silicon Solution, Inc.
 1330  MMC Networks
 1331  Radisys Corp.
+	8200  82600 Host Bridge
+	8201  82600 IDE
+	8202  82600 USB
+	8210  82600 PCI Bridge
 1332  Micro Memory
 	5415  MM-5415CN PCI Memory Module with Battery Backup
 	5425  MM-5425CN PCI 64/66 Memory Module with Battery Backup
@@ -4893,6 +5085,7 @@
 134c  Chori Joho System Co. Ltd
 134d  PCTel Inc
 	7890  HSP MicroModem 56
+		134d 0001  PCT789 adapter
 	7891  HSP MicroModem 56
 		134d 0001  HSP MicroModem 56
 	7892  HSP MicroModem 56
@@ -4952,6 +5145,7 @@
 1369  Digigram
 136a  High Soft Tech
 136b  Kawasaki Steel Corporation
+	ff01  KL5A72002 Motion JPEG
 136c  Adtek System Science Co Ltd
 136d  Gigalabs Inc
 136f  Applied Magic Inc
@@ -5066,7 +5260,10 @@
 13be  Miroku Jyoho Service Co. Ltd
 13bf  Sharewave Inc
 13c0  Microgate Corporation
-	0010  SyncLink WAN Adapter
+	0010  SyncLink Adapter v1
+	0020  SyncLink SCC Adapter
+	0030  SyncLink Multiport Adapter
+	0210  SyncLink Adapter v2
 13c1  3ware Inc
 	1000  3ware ATA-RAID
 	1001  3ware 7000-series ATA-RAID
@@ -5138,6 +5335,7 @@
 		13f6 0101  CMI8338-031 PCI Audio Device
 	0111  CM8738
 		1019 0970  P6STP-FL motherboard
+		1043 8035  CUSI-FX motherboard
 		1043 8077  CMI8738 6-channel audio controller
 		1043 80e2  CMI8738 6ch-MX
 		13f6 0111  CMI8738/C3DX PCI Audio Device
@@ -5212,6 +5410,8 @@
 141e  Fanuc Ltd
 141f  Visiontech Ltd
 1420  Psion Dacom plc
+	8002  Gold Card NetGlobal 56k+10/100Mb CardBus (Ethernet part)
+	8003  Gold Card NetGlobal 56k+10/100Mb CardBus (Modem part)
 1421  Ads Technologies Inc
 1422  Ygrec Systems Co Ltd
 1423  Custom Technology Corp.
@@ -5560,6 +5760,7 @@
 	4212  BCM4212 v.90 56k modem
 	4301  BCM4301 802.11b
 	4320  BCM94306 802.11g
+		1737 4320  WPC54G
 	4401  BCM4401 100Base-T
 		1043 80a8  A7V8X motherboard
 	4402  BCM4402 Integrated 10/100BaseT
@@ -5728,8 +5929,8 @@
 14fa  WANDEL & GOCHERMANN
 14fb  TRANSAS MARINE (UK) Ltd
 14fc  Quadrics Ltd
-	0000  QsNet Cluster Interconnect
-	0001  QsNetII Cluster Interconnect
+	0000  QsNet Elan3 Network Adapter
+	0001  QsNetII Elan4 Network Adapter
 14fd  JAPAN Computer Industry Inc
 14fe  ARCHTEK TELECOM Corp
 14ff  TWINHEAD INTERNATIONAL Corp
@@ -6164,7 +6365,11 @@
 3388  Hint Corp
 	0013  HiNT HC4 PCI to ISDN bridge, Multimedia audio controller
 	0014  HiNT HC4 PCI to ISDN bridge, Network controller
-	0021  HB1-SE33 PCI-PCI Bridge
+	0020  HB6 Universal PCI-PCI bridge (transparent mode)
+	0021  HB6 Universal PCI-PCI bridge (non-transparent mode)
+		4c53 1050  CT7 mainboard
+		4c53 1080  CT8 mainboard
+		4c53 3010  PPCI mezzanine (32-bit PMC)
 	101a  E.Band [AudioTrak Inca88]
 	101b  E.Band [AudioTrak Inca88]
 	8011  VXPro II Chipset

--------------000804090703080205020604--

