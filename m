Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267272AbUHWTRb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267272AbUHWTRb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 15:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267285AbUHWTPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 15:15:37 -0400
Received: from mail.kroah.org ([69.55.234.183]:6340 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267272AbUHWSgz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:36:55 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <10932860811635@kroah.com>
Date: Mon, 23 Aug 2004 11:34:41 -0700
Message-Id: <10932860812879@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1790.2.2, 2004/08/02 15:24:01-07:00, greg@kroah.com

PCI: update pci.ids from sf.net site.

Patch taken from http://www.codemonkey.org.uk/projects/pci/pci.ids-2004-08-02.diff
and tweaked by hand to build with no warnings.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/pci.ids |  541 +++++++++++++++++++++++++++++++++++++---------------
 1 files changed, 389 insertions(+), 152 deletions(-)


diff -Nru a/drivers/pci/pci.ids b/drivers/pci/pci.ids
--- a/drivers/pci/pci.ids	2004-08-23 11:08:45 -07:00
+++ b/drivers/pci/pci.ids	2004-08-23 11:08:45 -07:00
@@ -7,7 +7,7 @@
 #	so if you have anything to contribute, please visit the home page or
 #	send a diff -u against the most recent pci.ids to pci-ids@ucw.cz.
 #
-#	Daily snapshot on Thu 2004-04-15 10:00:04
+#	Daily snapshot on Mon 2004-07-12 10:00:27
 #
 
 # Vendors, devices and subsystems. Please keep sorted.
@@ -150,37 +150,58 @@
 		0e11 4082  Smart Array 532
 		0e11 4083  Smart Array 5312
 	b1a4  NC7131 Gigabit Server Adapter
+	b203  Integrated Lights Out Controller
+	b204  Integrated Lights Out  Processor
 	f130  NetFlex-3/P ThunderLAN 1.0
 	f150  NetFlex-3/P ThunderLAN 2.3
 0e55  HaSoTec GmbH
 # Formerly NCR
 1000  LSI Logic / Symbios Logic
 	0001  53c810
-		1000 1000  8100S
+		1000 1000  LSI53C810AE PCI to SCSI I/O Processor
 	0002  53c820
 	0003  53c825
+		1000 1000  LSI53C825AE PCI to SCSI I/O Processor (Ultra Wide)
 	0004  53c815
 	0005  53c810AP
 	0006  53c860
+		1000 1000  LSI53C860E PCI to Ultra SCSI I/O Processor
 	000a  53c1510
-	000b  53c896
+		1000 1000  LSI53C1510 PCI to Dual Channel Wide Ultra2 SCSI Controller (Nonintelligent mode)
+	000b  53C896/897
+		1000 1000  LSI53C896/7 PCI to Dual Channel Ultra2 SCSI Multifunction Controller
+		1000 1010  LSI22910 PCI to Dual Channel Ultra2 SCSI host adapter
+		1000 1020  LSI21002 PCI to Dual Channel Ultra2 SCSI host adapter
+# multifunction PCI card: Dual U2W SCSI, dual 10/100TX, graphics
+		13e9 1000  6221L-4U
 	000c  53c895
+		1000 1010  LSI8951U PCI to Ultra2 SCSI host adapter
+		1000 1020  LSI8952U PCI to Ultra2 SCSI host adapter
+		1de1 3906  DC-390U2B SCSI adapter
 		1de1 3907  DC-390U2W
 	000d  53c885
 	000f  53c875
 		0e11 7004  Embedded Ultra Wide SCSI Controller
+		1000 1000  LSI53C876/E PCI to Dual Channel SCSI Controller
+		1000 1010  LSI22801 PCI to Dual Channel Ultra SCSI host adapter
+		1000 1020  LSI22802 PCI to Dual Channel Ultra SCSI host adapter
 		1092 8760  FirePort 40 Dual SCSI Controller
-		1de1 3904  DC390F Ultra Wide SCSI Controller
+		1de1 3904  DC390F/U Ultra Wide SCSI Adapter
 		4c53 1000  CC7/CR7/CP7/VC7/VP7/VR7 mainboard
 		4c53 1050  CT7 mainboard
-	0010  53c895
+	0010  53C1510
 		0e11 4040  Integrated Array Controller
 		0e11 4048  Integrated Array Controller
+		1000 1000  53C1510 PCI to Dual Channel Wide Ultra2 SCSI Controller (Intelligent mode)
 	0012  53c895a
+		1000 1000  LSI53C895A PCI to Ultra2 SCSI Controller
 	0013  53c875a
+		1000 1000  LSI53C875A PCI to Ultra SCSI Controller
 	0020  53c1010 Ultra3 SCSI Adapter
+		1000 1000  LSI53C1010-33 PCI to Dual Channel Ultra160 SCSI Controller
 		1de1 1020  DC-390U3W
 	0021  53c1010 66MHz  Ultra3 SCSI Adapter
+		1000 1000  LSI53C1000/1000R/1010R/1010-66 PCI to Ultra160 SCSI Controller
 		124b 1070  PMC-USCSI3
 		4c53 1080  CT8 mainboard
 		4c53 1300  P017 mezzanine (32-bit PMC)
@@ -191,6 +212,7 @@
 		1028 1010  LSI U320 SCSI Controller
 	0031  53c1030ZC PCI-X Fusion-MPT Dual Ultra320 SCSI
 	0032  53c1035 PCI-X Fusion-MPT Dual Ultra320 SCSI
+		1000 1000  LSI53C1020/1030 PCI-X to Ultra320 SCSI Controller
 	0033  1030ZC_53c1035 PCI-X Fusion-MPT Dual Ultra320 SCSI
 	0040  53c1035 PCI-X Fusion-MPT Dual Ultra320 SCSI
 		1000 0033  MegaRAID SCSI 320-2XR
@@ -203,8 +225,10 @@
 		1000 0530  MegaRAID 530 SCSI 320-0X RAID Controller
 		1000 0531  MegaRAID 531 SCSI 320-4X RAID Controller
 		1000 0532  MegaRAID 532 SCSI 320-2X RAID Controller
-		1028 0533  PowerEgde Expandable RAID Controller 4/QC
+		1028 0533  PowerEdge Expandable RAID Controller 4/QC
 		8086 0532  Storage RAID Controller SRCU42X
+	0408  MegaRAID
+		1028 0002  PowerEdge Expandable RAID Controller 4e/DC
 	0621  FC909 Fibre Channel Adapter
 	0622  FC929 Fibre Channel Adapter
 		1000 1020  44929 O Dual Fibre Channel card
@@ -235,6 +259,7 @@
 		1028 0518  MegaRAID 518 DELL PERC 4/DC RAID Controller
 		1028 0520  MegaRAID 520 DELL PERC 4/SC RAID Controller
 		1028 0531  PowerEdge Expandable RAID Controller 4/QC
+		1028 0533  PowerEdge Expandable RAID Controller 4/QC
 1001  Kolter Electronic
 	0010  PCI 1616 Measurement card with 32 digital I/O lines
 	0011  OPTO-PCI Opto-Isolated digital I/O board
@@ -350,6 +375,8 @@
 		1002 8008  Rage XL
 		1028 00ce  PowerEdge 1400
 		1028 00d1  PowerEdge 2550
+		8086 3411  SDS2 Mainboard
+		8086 3427  S875WP1-E mainboard
 	4753  Rage XC
 		1002 4753  Rage XC
 	4754  3D Rage I/II 215GT [Mach64 GT]
@@ -435,10 +462,12 @@
 	4e44  Radeon R300 ND [Radeon 9700 Pro]
 	4e45  Radeon R300 NE [Radeon 9500 Pro]
 		1002 0002  Radeon R300 NE [Radeon 9500 Pro]
+		1681 0002  Hercules 3D Prophet 9500 PRO [Radeon 9500 Pro]
 # New PCI ID provided by ATI developer relations (correction to above)
 	4e46  RV350 NF [Radeon 9600]
 	4e47  Radeon R300 NG [FireGL X1]
-	4e48  Radeon R350 [Radeon 9800]
+# (added pro)
+	4e48  Radeon R350 [Radeon 9800 Pro]
 # New PCI ID provided by ATI developer relations
 	4e49  Radeon R350 [Radeon 9800]
 	4e4a  RV350 NJ [Radeon 9800 XT]
@@ -451,10 +480,12 @@
 	4e64  Radeon R300 [Radeon 9700 Pro] (Secondary)
 	4e65  Radeon R300 [Radeon 9500 Pro] (Secondary)
 		1002 0003  Radeon R300 NE [Radeon 9500 Pro]
+		1681 0003  Hercules 3D Prophet 9500 PRO [Radeon 9500 Pro] (Secondary)
 # New PCI ID provided by ATI developer relations (correction to above)
 	4e66  RV350 NF [Radeon 9600] (Secondary)
 	4e67  Radeon R300 [FireGL X1] (Secondary)
-	4e68  Radeon R350 [Radeon 9800] (Secondary)
+# (added pro)
+	4e68  Radeon R350 [Radeon 9800 Pro] (Secondary)
 # New PCI ID provided by ATI developer relations
 	4e69  Radeon R350 [Radeon 9800] (Secondary)
 	4e6a  RV350 NJ [Radeon 9800 XT] (Secondary)
@@ -535,6 +566,7 @@
 		148c 2024  RV200 QW [Radeon 7500LE Dual Display]
 		148c 2025  RV200 QW [Radeon 7500 Evil Master Multi Display Edition]
 		148c 2036  RV200 QW [Radeon 7500 PCI Dual Display]
+		174b 7146  RV200 QW [Radeon 7500 LE]
 		174b 7147  RV200 QW [Sapphire Radeon 7500LE]
 		174b 7161  Radeon RV200 QW [Radeon 7500 LE]
 		17af 0202  RV200 QW [Excalibur Radeon 7500LE]
@@ -624,6 +656,7 @@
 	5d44  RV280 [Radeon 9200 SE] (Secondary)
 	700f  PCI Bridge [IGP 320M]
 	7010  PCI Bridge [IGP 340M]
+	7c37  RV350 AQ [Radeon 9600 SE]
 	cab0  AGP Bridge [IGP 320M]
 	cab2  RS200/RS200M AGP Bridge [IGP 340M]
 1003  ULSI Systems
@@ -865,6 +898,8 @@
 		1014 002e  ServeRAID-3x
 		1014 022e  ServeRAID-4H
 	0031  2 Port Serial Adapter
+# AS400 iSeries PCI sync serial card
+		1014 0031  2721 WAN IOA - 2 Port Sync Serial Adapter
 	0036  Miami
 	003a  CPU to PCI Bridge
 	003c  GXT250P/GXT255P Graphics Adapter
@@ -946,7 +981,7 @@
 	0266  PCI-X Dual Channel SCSI
 	0268  Gigabit Ethernet-SX Adapter (PCI-X)
 	0269  10/100/1000 Base-TX Ethernet Adapter (PCI-X)
-	0302  XA-32 chipset [Summit]
+	0302  X-Architecture Bridge [Summit]
 	ffff  MPIC-2 interrupt controller
 1015  LSI Logic Corp of Canada
 1016  ICL Personal Systems
@@ -1059,20 +1094,27 @@
 	7454  AMD-8151 System Controller
 	7455  AMD-8151 AGP Bridge
 	7460  AMD-8111 PCI
+		161f 3017  HDAMB
 	7461  AMD-8111 USB
 	7462  AMD-8111 Ethernet
 	7464  AMD-8111 USB
+		161f 3017  HDAMB
 	7468  AMD-8111 LPC
+		161f 3017  HDAMB
 	7469  AMD-8111 IDE
+		161f 3017  HDAMB
 	746a  AMD-8111 SMBus 2.0
 	746b  AMD-8111 ACPI
+		161f 3017  HDAMB
 	746d  AMD-8111 AC97 Audio
+		161f 3017  HDAMB
 	746e  AMD-8111 MC97 Modem
 	756b  AMD-8111 ACPI
 1023  Trident Microsystems
 	0194  82C194
 	2000  4DWave DX
 	2001  4DWave NX
+		122d 1400  Trident PCI288-Q3DII (NX)
 	2100  CyberBlade XP4m32
 	8400  CyberBlade/i7
 		1023 8400  CyberBlade i7 AGP
@@ -1083,7 +1125,7 @@
 		0e11 b16e  CyberBlade i1 AGP
 		1023 8520  CyberBlade i1 AGP
 	8620  CyberBlade/i1
-		1014 0502  ThinkPad T30
+		1014 0502  ThinkPad R30/T30
 	8820  CyberBlade XPAi1
 	9320  TGUI 9320
 	9350  GUI Accelerator
@@ -1179,34 +1221,30 @@
 	5453  M5453 PCI AC-Link Controller Modem Device
 	7101  M7101 PCI PMU Power Management Controller
 		10b9 7101  M7101 PCI PMU Power Management Controller
-1028  Dell Computer Corporation
+1028  Dell
 	0001  PowerEdge Expandable RAID Controller 2/Si
-		1028 0001  PowerEdge Expandable RAID Controller 2/Si
-	0002  PowerEdge Expandable RAID Controller 3
-		1028 0002  PowerEdge Expandable RAID Controller 3/Di
-		1028 00d1  PowerEdge Expandable RAID Controller 3/Di
-		1028 00d9  PowerEdge Expandable RAID Controller 3/Di
+		1028 0001  PowerEdge 2400
+	0002  PowerEdge Expandable RAID Controller 3/Di
+		1028 0002  PowerEdge 4400
 	0003  PowerEdge Expandable RAID Controller 3/Si
-		1028 0003  PowerEdge Expandable RAID Controller 3/Si
-	0004  PowerEdge Expandable RAID Controller 3/Si
-		1028 00d0  PowerEdge Expandable RAID Controller 3/Si
+		1028 0003  PowerEdge 2450
 	0006  PowerEdge Expandable RAID Controller 3/Di
-	0007  Remote Access Controller:DRAC III
-	0008  Remote Access Controller
-	0009  BMC/SMIC device not present
-	000a  PowerEdge Expandable RAID Controller 3
-		1028 0106  PowerEdge Expandable RAID Controller 3/Di
-		1028 011b  PowerEdge Expandable RAID Controller 3/Di
-		1028 0121  PowerEdge Expandable RAID Controller 3/Di
-	000c  Remote Access Controller:ERA or ERA/O
-	000d  BMC/SMIC device
-	000e  PowerEdge Expandable RAID controller 4
-		1028 0123  PowerEdge Expandable RAID Controller 4/Di
-	000f  PowerEdge Expandable RAID controller 4
-		1028 013b  MegaRAID DELL PERC 4/Di RAID On Motherboard
-		1028 014a  PowerEdge Expandable RAID Controller 4/Di
-		1028 014c  MegaRAID DELL PERC 4/Di RAID On Motherboard
-		1028 014d  MegaRAID DELL PERC 4/Di RAID On Motherboard
+	0007  Remote Access Card III
+	0008  Remote Access Card III
+	0009  Remote Access Card III: BMC/SMIC device not present
+	000a  PowerEdge Expandable RAID Controller 3/Di
+	000c  Embedded Remote Access or ERA/O
+	000d  Embedded Remote Access: BMC/SMIC device
+	000e  PowerEdge Expandable RAID controller 4/Di
+	000f  PowerEdge Expandable RAID controller 4/Di
+	0010  Remote Access Card 4
+	0011  Remote Access Card 4 Daughter Card
+	0012  Remote Access Card 4 Daughter Card Virtual UART
+	0013  PowerEdge Expandable RAID controller 4
+		1028 016c  PowerEdge Expandable RAID Controller 4e/Si
+		1028 016d  PowerEdge Expandable RAID Controller 4e/Di
+		1028 016e  PowerEdge Expandable RAID Controller 4e/Di
+	0014  Remote Access Card 4 Daughter Card SMIC interface
 1029  Siemens Nixdorf IS
 102a  LSI Logic
 	0000  HYDRA
@@ -1542,6 +1580,7 @@
 		1092 4920  SpeedStar A70
 		1569 6326  SiS6326 GUI Accelerator
 	6330  661FX/M661FX/M661MX/741/M741/760/M760 PCI/AGP
+		1039 6330  [M]661FX/M661MX/[M]741/[M]760 PCI/AGP VGA Display Adapter
 	7001  USB 1.0 Controller
 		1039 7000  Onboard USB Controller
 	7002  USB 2.0 Controller
@@ -1604,7 +1643,7 @@
 		103c 1049  Tosca Console
 		103c 104a  Tosca Secondary
 		103c 104b  Maestro SP2
-		103c 1223  Halfdome Console
+		103c 1223  Superdome Console
 		103c 1226  Keystone SP2
 		103c 1227  Powerbar SP2
 		103c 1282  Everest SP2
@@ -1642,7 +1681,7 @@
 	4057  v8200 GeForce 3
 	8043  v8240 PAL 128M [P4T] Motherboard
 	807b  v9280/TD [Geforce4 TI4200 8X With TV-Out and DVI]
-1044  Distributed Processing Technology
+1044  Adaptec (formerly DPT)
 	1012  Domino RAID Engine
 	a400  SmartCache/Raid I-IV Controller
 	a500  PCI Bridge
@@ -1683,6 +1722,7 @@
 		1044 c065  3010S Ultra3 Four Channel
 		1044 c066  3010S Fibre Channel
 	a511  SmartRAID V Controller
+		1044 c032  ASR-2005S I2O Zero Channel
 1045  OPTi Inc.
 	a0f8  82C750 [Vendetta] USB Controller
 	c101  92C264
@@ -1786,6 +1826,7 @@
 		1028 00e6  PCI4451 IEEE-1394 Controller (Dell Inspiron 8100)
 	8029  PCI4510 IEEE-1394 Controller
 		1071 8160  MIM2900
+	802e  PCI7x20 1394a-2000 OHCI Two-Port PHY/Link-Layer Controller
 	8400  ACX 100 22Mbps Wireless Interface
 		00fc 16ec  U.S. Robotics 22 Mbps Wireless PC Card (model 2210)
 		00fd 16ec  U.S. Robotics 22Mbps Wireless PCI Adapter (model 2216)
@@ -1894,6 +1935,8 @@
 	0003  MPC8240 [Kahlua]
 	0004  MPC107
 	0006  MPC8245 [Unity]
+	0008  MPC8540
+	0009  MPC8560
 	0100  MC145575 [HFC-PCI]
 	0431  KTI829c 100VG
 	1801  DSP56301 Digital Signal Processor
@@ -1939,44 +1982,49 @@
 1058  Electronics & Telecommunications RSH
 1059  Teknor Industrial Computers Inc
 105a  Promise Technology, Inc.
-	0d30  20265
+# more correct description from promise linux sources
+	0d30  PDC20265 (FastTrak100 Lite/Ultra100)
 		105a 4d33  Ultra100
 	0d38  20263
 		105a 4d39  Fasttrak66
 	1275  20275
 	3318  PDC20318 (SATA150 TX4)
-	3319  PDC20319 (SATA150 TX4)
-	3373  PDC20378 (SATA150 TX)
+	3319  PDC20319 (FastTrak S150 TX4)
+		8086 3427  S875WP1-E mainboard
+	3371  PDC20371 (FastTrak S150 TX2plus)
+	3373  PDC20378 (FastTrak 378/SATA 378)
+		1043 80f5  PC-DL Deluxe motherboard
 		1462 702e  K8T NEO FIS2R motherboard
 	3375  PDC20375 (SATA150 TX2plus)
-	3376  PDC20376
+	3376  PDC20376 (FastTrak 376)
 		1043 809e  A7V8X motherboard
-	4d30  20267
+	4d30  PDC20267 (FastTrak100/Ultra100)
 		105a 4d33  Ultra100
-		105a 4d39  Fasttrak100
+		105a 4d39  FastTrak100
 	4d33  20246
 		105a 4d33  20246 IDE Controller
-	4d38  20262
+	4d38  PDC20262 (FastTrak66/Ultra66)
 		105a 4d30  Ultra Device on SuperTrak
 		105a 4d33  Ultra66
-		105a 4d39  Fasttrak66
-	4d68  20268
+		105a 4d39  FastTrak66
+	4d68  PDC20268 (Ultra100 TX2)
 		105a 4d68  Ultra100TX2
 	4d69  20269
 		105a 4d68  Ultra133TX2
-	5275  PDC20276 IDE
+	5275  PDC20276 (MBFastTrak133 Lite)
 		105a 0275  SuperTrak SX6000 IDE
 		105a 1275  MBFastTrak133 Lite (tm) Controller (RAID mode)
 		1458 b001  MBUltra 133
 	5300  DC5300
-	6268  20268R
-	6269  PDC20271
+	6268  PDC20270 (FastTrak100 LP/TX2/TX4)
+		105a 4d68  FastTrak100 TX2
+	6269  PDC20271 (FastTrak TX2000)
 		105a 6269  FastTrak TX2/TX2000
-	6621  PDC20621 [SX4000] 4 Channel IDE RAID Controller
+	6621  PDC20621 (FastTrak S150 SX4/FastTrak SX4000 lite)
 	6622  PDC20621 [SATA150 SX4] 4 Channel IDE RAID Controller
-	6626  PDC20618 Ultra 618
-	6629  PDC20619 FastTrak TX4000 RAID
-	7275  PDC20277
+	6626  PDC20618 (Ultra 618)
+	6629  PDC20619 (FastTrak TX4000)
+	7275  PDC20277 (SBFastTrak133 Lite)
 105b  Foxconn International, Inc.
 105c  Wipro Infotech Limited
 105d  Number 9 Computer Company
@@ -2199,6 +2247,7 @@
 107c  LG Electronics [Lucky Goldstar Co. Ltd]
 107d  LeadTek Research Inc.
 	0000  P86C850
+	2134  WinFast 3D S320 II
 107e  Interphase Corporation
 	0001  5515 ATM Adapter [Flipper]
 	0002  100 VG AnyLan Controller
@@ -2348,10 +2397,10 @@
 	0673  USB0673
 	0680  PCI0680 Ultra ATA-133 Host Controller
 		1095 3680  Winic W-680 (Silicon Image 680 based)
-	3112  Silicon Image Serial ATARaid Controller [ CMD/Sil 3112/3112A ]
+	3112  SiI 3112 [SATALink/SATARaid] Serial ATA Controller
 		1095 6112  Asus A7N8X
-	3114  Silicon Image SiI 3114 SATARaid
-	3512  Silicon Image Serial ATARaid Controller [ CMD/Sil 3512 ]
+	3114  SiI 3114 [SATALink/SATARaid] Serial ATA Controller
+	3512  SiI 3512 [SATALink/SATARaid] Serial ATA Controller
 1096  Alacron
 1097  Appian Technology
 1098  Quantum Designs (H.K.) Ltd
@@ -2742,6 +2791,7 @@
 		10b7 7000  10/100 Mini PCI Ethernet Adapter
 		10f1 2466  Tiger MPX S2466 (3C920 Integrated Fast Ethernet Controller)
 	9201  3C920B-EMB Integrated Fast Ethernet Controller [Tornado]
+		1043 80ab  A7N8X Deluxe onboard 3C920B-EMB Integrated Fast Ethernet Controller
 	9202  3Com 3C920B-EMB-WNM Integrated Fast Ethernet Controller
 	9210  3C920B-EMB-WNM Integrated Fast Ethernet Controller
 	9300  3CSOHO100B-TX 910-A01 [tulip]
@@ -2837,6 +2887,7 @@
 	5219  M5219
 	5225  M5225
 	5229  M5229 IDE
+		1014 050f  ThinkPad R30
 		1043 8053  A7A266 Motherboard IDE
 	5235  M5225
 	5237  USB 1.1 Controller
@@ -2859,8 +2910,8 @@
 	545a  SmartLink SmartPCI563 56K Modem
 	5471  M5471 Memory Stick Controller
 	5473  M5473 SD-MMC Controller
-	7101  M7101 PMU
-		10b9 7101  ALI M7101 Power Management Controller
+	7101  M7101 Power Management Controller [PMU]
+		1014 0510  ThinkPad R30
 10ba  Mitsubishi Electric Corp.
 	0301  AccelGraphics AccelECLIPSE
 	0304  AccelGALAXY A2100 [OEM Evans & Sutherland]
@@ -3001,6 +3052,7 @@
 		1043 0205  PCI-V3800
 		1043 4000  AGP-V3800PRO
 		1048 0c21  Synergy II
+		107d 2134  WinFast 3D S320 II + TV-Out
 		1092 4804  Viper V770
 		1092 4a00  Viper V770
 		1092 4a02  Viper V770 Ultra
@@ -3041,11 +3093,13 @@
 		1554 1041  Pixelview RIVA TNT2 M64
 	002e  NV6 [Vanta]
 	002f  NV6 [Vanta]
+	0041  NV40 OS1RT00B30
 	0060  nForce2 ISA Bridge
 		1043 80ad  A7N8X Mainboard
 	0064  nForce2 SMBus (MCP)
 	0065  nForce2 IDE
 	0066  nForce2 Ethernet Controller
+		1043 80a7  A7N8X Mainboard onboard nForce2 Ethernet
 	0067  nForce2 USB Controller
 		1043 0c11  A7N8X Mainboard
 	0068  nForce2 USB Controller
@@ -3292,6 +3346,7 @@
 		1071 8160  MIM2000
 		10bd 0320  EP-320X-R
 		10ec 8139  RT8139
+		1113 ec01  FNC-0107TX
 		1186 1300  DFE-538TX
 		1186 1320  SN5200
 		1186 8139  DRN-32TX
@@ -3342,7 +3397,7 @@
 10f9  PC Direct
 10fa  Truevision
 	000c  TARGA 1000
-10fb  Thesys Gesellschaft fÃ¼r Mikroelektronik mbH
+10fb  Thesys Gesellschaft für Mikroelektronik mbH
 	186f  TH 6255
 10fc  I-O Data Device, Inc.
 # What's in the cardbus end of a Sony ACR-A01 card, comes with newer Vaio CD-RW drives
@@ -3358,6 +3413,7 @@
 	9400  INI-940
 	9401  INI-950
 	9500  360P
+	9502  Initio INI-9100UW Ultra Wide SCSI Controller INIC-950P chip
 1102  Creative Labs
 	0002  SB Live! EMU10k1
 		1102 0020  CT4850 SBLive! Value
@@ -3507,13 +3563,16 @@
 		0e11 0097  SoundMax Digital Integrated Audio
 		0e11 b194  Soundmax integrated digital audio
 		1019 0985  P6VXA Motherboard
+		1043 1106  A7V133/A7V133-C Mainboard
 		1106 4511  Onboard Audio on EP7KXA
 		1458 7600  Onboard Audio
 		1462 3091  MS-6309 Onboard Audio
+		1462 3300  MS-6330 Onboard Audio
 		15dd 7609  Onboard Audio
 	3059  VT8233/A/8235/8237 AC97 Audio Controller
 		1019 0a81  L7VTA v1.0 Motherboard (KT400-8235)
 		1043 8095  A7V8X Motherboard (Realtek ALC650 codec)
+		1043 80a1  A7V8X-X Motherboard
 		1043 80b0  A7V600 motherboard (ADI AD1980 codec [SoundMAX])
 		1106 3059  L7VMM2 Motherboard
 		1297 c160  FX41 motherboard (Realtek ALC650 codec)
@@ -3526,6 +3585,7 @@
 		1186 1401  DFE-530TX rev B
 		13b9 1421  LD-10/100AL PCI Fast Ethernet Adapter (rev.B)
 	3068  Intel 537 [AC97 Modem]
+		1462 309e  MS-6309 Saturn Motherboard
 	3074  VT8233 PCI to ISA Bridge
 		1043 8052  VT8233A
 	3091  VT8633 [Apollo Pro266]
@@ -3906,7 +3966,15 @@
 		1133 1c0b  Diva Server V-PRI/T1-24 Cornet NQ 3
 		1133 1c0c  Diva Server V-PRI/E1-30 Cornet NQ 3
 	e01e  Diva Server 2PRI
+		1133 1e00  Diva Server V-2PRI/E1-60
+		1133 1e01  Diva Server V-2PRI/T1-48
+		1133 1e02  Diva Server 2PRI/E1-60
+		1133 1e03  Diva Server 2PRI/T1-48
 	e020  Diva Server 4PRI
+		1133 2000  Diva Server V-4PRI/E1-120
+		1133 2001  Diva Server V-4PRI/T1-96
+		1133 2002  Diva Server 4PRI/E1-120
+		1133 2003  Diva Server 4PRI/T1-96
 	e024  Diva Server Analog-4P
 	e028  Diva Server Analog-8P
 1134  Mercury Computer Systems
@@ -4145,6 +4213,7 @@
 1165  Imagraph Corporation
 	0001  Motion TPEG Recorder/Player with audio
 1166  ServerWorks
+	0000  CMIC-LE
 	0005  CNB20-LE Host Bridge
 	0006  CNB20HE Host Bridge
 	0007  CNB20-LE Host Bridge
@@ -4152,13 +4221,13 @@
 	0009  CNB20LE Host Bridge
 	0010  CIOB30
 	0011  CMIC-HE
-	0012  CMIC-LE
+	0012  CMIC-WS Host Bridge (GC-LE chipset)
 	0013  CNB20-HE Host Bridge
-	0014  CNB20-HE Host Bridge
+	0014  CMIC-LE Host Bridge (GC-LE chipset)
 	0015  CMIC-GC Host Bridge
 	0016  CMIC-GC Host Bridge
 	0017  GCNB-LE Host Bridge
-	0101  CIOB-X2
+	0101  CIOB-X2 PCI-X I/O Bridge
 	0110  CIOB-E I/O Bridge with Gigabit Ethernet
 	0200  OSB4 South Bridge
 	0201  CSB5 South Bridge
@@ -4255,6 +4324,7 @@
 		1186 1300  DFE-538TX 10/100 Ethernet Adapter
 		1186 1301  DFE-530TX+ 10/100 Ethernet Adapter
 	1340  DFE-690TXD CardBus PC Card
+	1541  DFE-680TXD CardBus PC Card
 	1561  DRP-32TXD Cardbus PC Card
 	3300  DWL-510 2.4GHz Wireless PCI Adapter
 	3b05  DWL-G650+ CardBus PC Card
@@ -4337,9 +4407,10 @@
 11a9  InnoSys Inc.
 	4240  AMCC S933Q Intelligent Serial Card
 11aa  Actel
-# (formerly Galileo technologies)
-11ab  Marvell
+# Formerly Galileo Technology, Inc.
+11ab  Marvell Technology Group Ltd.
 	0146  GT-64010/64010A System Controller
+	1fa6  Marvell W8300 802.11 Adapter
 	4320  Yukon Gigabit Ethernet 10/100/1000Base-T Adapter
 	4611  GT-64115 System Controller
 	4620  GT-64120/64120A/64121A System Controller
@@ -4677,6 +4748,7 @@
 	6933  OZ6933 Cardbus Controller
 		1025 1016  Travelmate 612 TX
 	6972  OZ6912 Cardbus Controller
+		1014 020c  ThinkPad R30
 		1179 0001  Magnia Z310
 	7110  OZ711Mx MultiMediaBay Accelerator
 	7112  OZ711EC1/M1 SmartCardBus MultiMediaBay Controller
@@ -4762,6 +4834,7 @@
 122c  Sican GmbH
 122d  Aztech System Ltd
 	1206  368DSP
+	1400  Trident PCI288-Q3DII (NX)
 	50dc  3328 Audio
 		122d 0001  3328 Audio
 	80da  3328 Audio
@@ -4905,11 +4978,15 @@
 	3873  Prism 2.5 Wavelan chipset
 		1186 3501  DWL-520 Wireless PCI Adapter
 		1186 3700  DWL-520 Wireless PCI Adapter, Rev E1
+		1385 4105  MA311 802.11b wireless adapter
 		1668 0414  HWP01170-01 802.11b PCI Wireless Adapter
 		16a5 1601  AIR.mate PC-400 PCI Wireless LAN Adapter
 		1737 3874  WMP11 Wireless 802.11b PCI Adapter
 		8086 2513  Wireless 802.11b MiniPCI Adapter
+	3886  ISL3886 [Prism Javelin/Prism Xbow]
 	3890  Intersil ISL3890 [Prism GT/Prism Duette]
+		10b8 a835  SMC2835W V2 Wireless Cardbus Adapter
+		16a5 1605  ALLNET ALL0271 Wireless PCI Adapter
 		17cf 0014  Ovislink WL-5400PCM, Prism GT
 	8130  HMP8130 NTSC/PAL Video Decoder
 	8131  HMP8131 NTSC/PAL Video Decoder
@@ -5155,7 +5232,7 @@
 	9132  Ethernet 100/10 MBit
 1283  Integrated Technology Express, Inc.
 	673a  IT8330G
-	8212  IT/ITE8212 Dual channel ATA RAID
+	8212  IT/ITE8212 Dual channel ATA RAID controller
 	8330  IT8330G
 	8872  IT8874F PCI Dual Serial Port Controller
 	8888  IT8888F PCI to ISA Bridge with SMB
@@ -5466,7 +5543,8 @@
 	0985  NC100 Network Everywhere Fast Ethernet 10/100
 	1985  21x4x DEC-Tulip compatible 10/100 Ethernet
 	2850  HSP MicroModem 56
-	8201  [ADMtek] SP906B_V2 Wireless LAN adapter
+	8201  ADMtek ADM8211 802.11b Wireless Interface
+		10b8 2635  SMC2635W 802.11b (11Mbps) wireless lan pcmcia (cardbus) card
 		1317 8201  SMC2635W 802.11b (11mbps) wireless lan pcmcia (cardbus) card
 	9511  21x4x DEC-Tulip compatible 10/100 Ethernet
 1318  Packet Engines Inc.
@@ -5535,7 +5613,6 @@
 132d  Integrated Silicon Solution, Inc.
 1330  MMC Networks
 1331  Radisys Corp.
-	0030  ENP-2611
 	8200  82600 Host Bridge
 	8201  82600 IDE
 	8202  82600 USB
@@ -5659,9 +5736,11 @@
 1385  Netgear
 	4100  802.11b Wireless Adapter (MA301)
 	4105  MA311 802.11b wireless adapter
+	4a00  WAG311 802.11abg Wireless Adapter
 	620a  GA620 Gigabit Ethernet
 	622a  GA622
 	630a  GA630 Gigabit Ethernet
+	f004  FA310TX
 1386  Video Domain Technologies
 1387  Systran Corp
 1388  Hitachi Information Technology Co Ltd
@@ -5720,6 +5799,7 @@
 13a6  Videonics Inc
 13a7  Teles AG
 13a8  Exar Corp.
+	0154  XR17C154 Quad UART
 	0158  XR17C158 Octal UART
 13a9  Siemens Medical Systems, Ultrasound Group
 13aa  Broadband Networks Inc
@@ -5752,6 +5832,7 @@
 13c1  3ware Inc
 	1000  3ware ATA-RAID
 	1001  3ware 7000-series ATA-RAID
+		13c1 1001  3ware Inc 3ware 7xxx/8xxx-series PATA/SATA-RAID
 	1002  3ware ATA-RAID
 13c2  Technotrend Systemtechnik GmbH
 13c3  Janz Computer AG
@@ -5884,10 +5965,11 @@
 140f  Salient Systems Corp
 1410  Midas lab Inc
 1411  Ikos Systems Inc
-1412  IC Ensemble Inc
-	1712  ICE1712 [Envy24]
+# formerly IC Ensemble Inc.
+1412  VIA Technologies Inc.
+	1712  ICE1712 [Envy24] PCI Multi-Channel I/O Controller
 		1412 d638  M-Audio Delta 410
-	1724  ICE1724 [Envy24HT]
+	1724  VT1720/24 [Envy24PT/HT] PCI Multi-Channel Audio Controller
 1413  Addonics
 1414  Microsoft Corporation
 1415  Oxford Semiconductor Ltd
@@ -5990,6 +6072,7 @@
 1460  DYNARC INC
 1461  Avermedia Technologies Inc
 1462  Micro-Star International Co., Ltd.
+	6825  PCI Card wireless 11g [PC54G]
 	8725  NVIDIA NV25 [GeForce4 Ti 4600] VGA Adapter
 # MSI G4Ti4800, 128MB DDR SDRAM, TV-Out, DVI-I
 	9000  NVIDIA NV28 [GeForce4 Ti 4800] VGA Adapter
@@ -6150,8 +6233,9 @@
 14d6  Accusys Inc
 14d7  Hirakawa Hewtech Corp
 14d8  HOPF Elektronik GmBH
-14d9  Alpha Processor Inc
-	0010  AP1011 HyperTransport-PCI Bridge [Sturgeon]
+# Formerly SiPackets, Inc., formerly API NetWorks, Inc., formerly Alpha Processor, Inc.
+14d9  Alliance Semiconductor Corporation
+	0010  AP1011/SP1011 HyperTransport-PCI Bridge [Sturgeon]
 14da  National Aerospace Laboratories
 14db  AFAVLAB Technology Inc
 	2120  TK9902
@@ -6175,6 +6259,14 @@
 14e2  INFOLIBRIA
 14e3  AMTELCO
 14e4  Broadcom Corporation
+	0800  Sentry5 Chipcommon I/O Controller
+	0804  Sentry5 PCI Bridge
+	0805  Sentry5 MIPS32 CPU
+	0806  Sentry5 Ethernet Controller
+	080b  Sentry5 Crypto Accelerator
+	080f  Sentry5 DDR/SDR RAM Controller
+	0811  Sentry5 External Interface Core
+	0816  BCM3302 Sentry5 MIPS32 CPU
 	1644  NetXtreme BCM5700 Gigabit Ethernet
 		1014 0277  Broadcom Vigil B5700 1000Base-T
 		1028 00d1  Broadcom BCM5700
@@ -6241,21 +6333,14 @@
 	164d  NetXtreme BCM5702FE Gigabit Ethernet
 	1653  NetXtreme BCM5705 Gigabit Ethernet
 	1654  NetXtreme BCM5705_2 Gigabit Ethernet
-	1658  NetXtreme BCM5720 Gigabit Ethernet
-	1659  NetXtreme BCM5721 Gigabit Ethernet
+	1659  NetXtreme BCM5721 Gigabit Ethernet PCI Express
 	165d  NetXtreme BCM5705M Gigabit Ethernet
 	165e  NetXtreme BCM5705M_2 Gigabit Ethernet
-	166e  NetXtreme BCM5705F Gigabit Ethernet
-	1676  NetXtreme BCM5750 Gigabit Ethernet
-	1677  NetXtreme BCM5751 Gigabit Ethernet
-	167c  NetXtreme BCM5750M Gigabit Ethernet
-	167d  NetXtreme BCM5751M Gigabit Ethernet
-	167e  NetXtreme BCM5751F Gigabit Ethernet
+	1677  NetXtreme BCM5751 Gigabit Ethernet PCI Express
 	1696  NetXtreme BCM5782 Gigabit Ethernet
 		103c 12bc  HP d530 CMT (DG746A)
 		14e4 000d  NetXtreme BCM5782 1000Base-T
 	169c  NetXtreme BCM5788 Gigabit Ethernet
-	169d  NetXtreme BCM5789 Gigabit Ethernet
 	16a6  NetXtreme BCM5702X Gigabit Ethernet
 		0e11 00bb  NC7760 Gigabit Server Adapter (PCI-X, 10/100/1000-T)
 		1028 0126  BCM5702 1000Base-T
@@ -6279,13 +6364,17 @@
 		103c 12ca  HP Combo FC/GigE-T [A9784A]
 		14e4 0009  NetXtreme BCM5703 1000Base-T
 		14e4 000a  NetXtreme BCM5703 1000Base-SX
-	170d  NetXtreme BCM5901 Gigabit Ethernet
-	170e  NetXtreme BCM5901_2 Gigabit Ethernet
+	170c  BCM4401-B0 100Base-TX
+	170d  NetXtreme BCM5901 100Base-TX
+	170e  NetXtreme BCM5901 100Base-TX
+	3352  BCM3352
+	3360  BCM3360
 	4210  BCM4210 iLine10 HomePNA 2.0
 	4211  BCM4211 iLine10 HomePNA 2.0 + V.90 56k modem
 	4212  BCM4212 v.90 56k modem
 	4301  BCM4301 802.11b
-	4320  BCM94306 802.11g
+	4307  BCM4307 802.11b Wireless LAN Controller
+	4320  BCM4306 802.11b/g Wireless LAN Controller
 		1028 0001  TrueMobile 1300 WLAN Mini-PCI Card
 		1737 4320  WPC54G
 	4324  BCM4309 802.11a/b/g
@@ -6293,12 +6382,47 @@
 	4401  BCM4401 100Base-T
 		1043 80a8  A7V8X motherboard
 	4402  BCM4402 Integrated 10/100BaseT
+	4403  BCM4402 V.90 56k Modem
 	4410  BCM4413 iLine32 HomePNA 2.0
 	4411  BCM4413 V.90 56k modem
 	4412  BCM4413 10/100BaseT
+	4430  BCM44xx CardBus iLine32 HomePNA 2.0
+	4432  BCM44xx CardBus 10/100BaseT
+	4610  BCM4610 Sentry5 PCI to SB Bridge
+	4611  BCM4610 Sentry5 iLine32 HomePNA 1.0
+	4612  BCM4610 Sentry5 V.90 56k Modem
+	4613  BCM4610 Sentry5 Ethernet Controller
+	4614  BCM4610 Sentry5 External Interface
+	4615  BCM4610 Sentry5 USB Controller
+	4704  BCM4704 PCI to SB Bridge
+	4708  BCM4708 Sentry5 PCI to SB Bridge
+	4710  BCM4710 Sentry5 PCI to SB Bridge
+	4711  BCM47xx Sentry5 iLine32 HomePNA 2.0
+	4712  Sentry5 UART
+	4713  Sentry5 Ethernet Controller
+	4714  BCM47xx Sentry5 External Interface
+	4715  Sentry5 USB Controller
+	4716  BCM47xx Sentry5 USB Host Controller
+	4717  BCM47xx Sentry5 USB Device Controller
+	4718  Sentry5 Crypto Accelerator
+	5365  BCM5365P Sentry5 Host Bridge
+	5600  BCM5600 StrataSwitch 24+2 Ethernet Switch Controller
+	5605  BCM5605 StrataSwitch 24+2 Ethernet Switch Controller
+	5615  BCM5615 StrataSwitch 24+2 Ethernet Switch Controller
+	5625  BCM5625 StrataSwitch 24+2 Ethernet Switch Controller
+	5645  BCM5645 StrataSwitch 24+2 Ethernet Switch Controller
+	5670  BCM5670 8-Port 10GE Ethernet Switch Fabric
+	5680  BCM5680 G-Switch 8 Port Gigabit Ethernet Switch Controller
 	5690  BCM5690 12-port Multi-Layer Gigabit Ethernet Switch
+	5691  BCM5691 GE/10GE 8+2 Gigabit Ethernet Switch Controller
 	5820  BCM5820 Crypto Accelerator
 	5821  BCM5821 Crypto Accelerator
+	5822  BCM5822 Crypto Accelerator
+	5823  BCM5823 Crypto Accelerator
+	5824  BCM5824 Crypto Accelerator
+	5840  BCM5840 Crypto Accelerator
+	5841  BCM5841 Crypto Accelerator
+	5850  BCM5850 Crypto Accelerator
 14e5  Pixelfusion Ltd
 14e6  SHINING Technology Inc
 14e7  3CX
@@ -6823,11 +6947,16 @@
 1619  FarSite Communications Ltd
 	0400  FarSync T2P (2 port X.21/V.35/V.24)
 	0440  FarSync T4P (4 port X.21/V.35/V.24)
+# www.rioworks.com
+161f  Rioworks
 1626  TDK Semiconductor Corp.
 	8410  RTL81xx Fast Ethernet
 1629  Kongsberg Spacetec AS
 	1003  Format synchronizer v3.0
 	2002  Fast Universal Data Output
+# This seems to occur on their 802.11b Wireless card WMP-11
+1637  Linksys
+	3874  Linksys 802.11b WMP11 PCI Wireless card
 1638  Standard Microsystems Corp [SMC]
 	1100  SMC2602W EZConnect/Addtron AWA-100/Eumitcom WL11000
 163c  Smart Link Ltd.
@@ -6862,6 +6991,7 @@
 		168c 0013  WG511T Wireless CardBus Adapter
 		168c 1025  DWL-G650B2 Wireless CardBus Adapter
 	1014  AR5212 802.11abg NIC
+16a5  Tekram Technology Co.,Ltd.
 16ab  Global Sun Technology Inc
 	1100  GL24110P
 	1101  PLX9052 PCMCIA-to-PCI Wireless LAN
@@ -6874,9 +7004,13 @@
 16cd  Densitron Technologies
 # www.pikatechnologies.com
 16df  PIKA Technologies Inc.
+16e3  European Space Agency
+	1e0f  LEON2FT Processor
 16ec  U.S. Robotics
 	00ff  USR997900 10/100 Mbps PCI Network Card
 	3685  Wireless Access PCI Adapter Model 022415
+16f4  Vweb Corp
+	8000  VW2010
 16f6  VideoTele.com, Inc.
 # www.internetmachines.com
 1702  Internet Machines Corporation (IMC)
@@ -6884,8 +7018,12 @@
 170b  NetOctave
 	0100  NSP2000-SSL crypto accelerator
 170c  YottaYotta Inc.
+# Seems to be a 2nd ID for Vitesse Semiconductor
+1725  Vitesse Semiconductor
+	7174  VSC7174 PCI/PCI-X Serial ATA Host Bus Controller
 172a  Accelerated Encryption
 1737  Linksys
+	0013  WMP54G Wireless Pci Card
 	1032  Gigabit Network Adapter
 		1737 0015  EG1032 v2 Instant Gigabit Network Adapter
 	1064  Gigabit Network Adapter
@@ -6914,10 +7052,12 @@
 	0004  CAMAC Controller
 	0005  PROFIBUS
 	0006  AMCC HOTlink
+1797  JumpTec h, GMBH
 1799  Belkin
 	6001  Wireless PCI Card - F5D6001
 	6020  Wireless PCMCIA Card - F5D6020
 	6060  Wireless PDA Card - F5D6060
+	7000  Wireless PCI Card - F5D7000
 17af  Hightech Information System Ltd.
 17b3  Hawking Technologies
 	ab08  PN672TX 10/100 Ethernet
@@ -6929,6 +7069,9 @@
 	2280  USB 2.0
 # S2io ships 10Gb PCI-X Ethernet adapters www.s2io.com
 17d5  S2io Inc.
+# Supplying full name for a currently green entry
+17fe  Linksys, A Division of Cisco Systems
+	2220  [AirConn] INPROCOMM IPN 2220 WLAN Adapter (rev 01)
 1813  Ambient Technologies Inc
 	4000  HaM controllerless modem
 		16be 0001  V9x HAM Data Fax Modem
@@ -6937,6 +7080,8 @@
 1814  RaLink
 	0101  Wireless PCI Adpator RT2400 / RT2460
 	0201  Ralink RT2500 802.11 Cardbus Reference Card
+1820  InfiniCon Systems Inc.
+1822  Twinhan Technology Co. Ltd
 1830  Credence Systems Corporation
 1851  Microtune, Inc.
 1852  Anritsu Corp.
@@ -6952,6 +7097,8 @@
 # found e.g. on KNC DVB-S card
 1894  KNC One
 18a1  Astute Networks Inc.
+18bc  Info-Tek Corp.
+18c9  ARVOO Engineering BV
 18ca  XGI - Xabre Graphics Inc
 	0040  Volari V8
 18e6  MPL AG
@@ -7018,6 +7165,7 @@
 	0008  GLINT Gamma G1
 	0009  Permedia II 2D+3D
 		1040 0011  AccelStar II
+		13e9 1000  6221L-4U
 		3d3d 0100  AccelStar II 3D Accelerator
 		3d3d 0111  Permedia 3:16
 		3d3d 0114  Santa Ana
@@ -7269,10 +7417,11 @@
 5555  Genroco, Inc
 	0003  TURBOstor HFP-832 [HiPPI NIC]
 5654  VoiceTronix Pty Ltd
+	3132  OpenSwitch12
 5700  Netpower
 5851  Exacq Technologies
 6356  UltraStor
-6374  c't Magazin fÃ¼r Computertechnik
+6374  c't Magazin für Computertechnik
 	6773  GPPCI
 6409  Logitec Corp.
 6666  Decision Computer International Co.
@@ -7292,6 +7441,8 @@
 		0008 1000  WorldMark 4300 INCA ASIC
 	0039  21145 Fast Ethernet
 	0122  82437FX
+	0309  80303 I/O Processor PCI-to-PCI Bridge
+	030d  80312 I/O Companion Chip PCI-to-PCI Bridge
 	0326  PCI Bridge Hub I/OxAPIC Interrupt Controller A
 	0327  PCI Bridge Hub I/OxAPIC Interrupt Controller B
 	0329  PCI Bridge Hub A
@@ -7315,13 +7466,38 @@
 	0340  41210 [Lanai] Serial to Parallel PCI Bridge
 # B-segment bridge
 	0341  41210 [Lanai] Serial to Parallel PCI Bridge
-	0482  82375EB
-	0483  82424ZX [Saturn]
-	0484  82378IB [SIO ISA Bridge]
-	0486  82430ZX [Aries]
-	04a3  82434LX [Mercury/Neptune]
+	0482  82375EB/SB PCI to EISA Bridge
+	0483  82424TX/ZX [Saturn] CPU to PCI bridge
+	0484  82378ZB/IB, 82379AB (SIO, SIO.A) PCI to ISA Bridge
+	0486  82425EX/ZX [Aries] PCIset with ISA bridge
+	04a3  82434LX/NX [Mercury/Neptune] Processor to PCI bridge
 	04d0  82437FX [Triton FX]
+	0500  E8870 Processor bus control
+	0501  E8870 Memory controller
+# and registers common to both SPs
+	0502  E8870 Scalability Port 0
+# and global performance monitoring
+	0503  E8870 Scalability Port 1
+	0510  E8870IO Hub Interface Port 0 registers (8-bit compatibility port)
+	0511  E8870IO Hub Interface Port 1 registers
+	0512  E8870IO Hub Interface Port 2 registers
+	0513  E8870IO Hub Interface Port 3 registers
+	0514  E8870IO Hub Interface Port 4 registers
+	0515  E8870IO General SIOH registers
+	0516  E8870IO RAS registers
+	0530  E8870SP Scalability Port 0 registers
+	0531  E8870SP Scalability Port 1 registers
+	0532  E8870SP Scalability Port 2 registers
+	0533  E8870SP Scalability Port 3 registers
+	0534  E8870SP Scalability Port 4 registers
+	0535  E8870SP Scalability Port 5 registers
+# (bi-interleave 0) and global registers that are neither per-port nor per-interleave
+	0536  E8870SP Interleave registers 0 and 1
+# (bi-interleave 1)
+	0537  E8870SP Interleave registers 2 and 3
 	0600  RAID Controller
+		8086 01c1  ICP Vortex GDT8546RZ
+		8086 01f7  SCRU32
 	0960  80960RP [i960 RP Microprocessor/Bridge]
 	0962  80960RM [i960RM Bridge]
 	0964  80960RP [i960 RP Microprocessor/Bridge]
@@ -7406,6 +7582,7 @@
 	1019  82547EI Gigabit Ethernet Controller (LOM)
 		1458 1019  GA-8IPE1000 Pro2 motherboard (865PE)
 		8086 1019  PRO/1000 CT Desktop Connection
+		8086 3427  S875WP1-E mainboard
 	101d  82546EB Gigabit Ethernet Controller
 		8086 1000  PRO/1000 MT Quad Port Server Adapter
 	101e  82540EP Gigabit Ethernet Controller (Mobile)
@@ -7453,13 +7630,16 @@
 		16be 1040  V.9X DSP Data Fax Modem
 	1043  PRO/Wireless LAN 2100 3B Mini PCI Adapter
 		8086 2527  MIM2000/Centrino
-	1048  Intel(R) PRO/10GbE LR Server Adapter
+	1048  PRO/10GbE LR Server Adapter
 		8086 a01f  PRO/10GbE LR Server Adapter
 		8086 a11f  PRO/10GbE LR Server Adapter
 	1050  82562EZ 10/100 Ethernet Controller
 		1462 728c  865PE Neo2 (MS-6728)
+		1462 758c  MS-6758 (875P Neo)
+		8086 3427  S875WP1-E mainboard
 	1051  82801EB/ER (ICH5/ICH5R) integrated LAN Controller
 	1059  82551QM Ethernet Controller
+	1065  82801FB/FBM/FR/FW/FRW (ICH6 Family) LAN Controller
 # Updated controller name from 82547EI to 82547GI
 	1075  82547GI Gigabit Ethernet Controller
 		8086 0075  PRO/1000 CT Network Connection
@@ -7516,8 +7696,8 @@
 		4c53 1050  CT7 mainboard
 		4c53 1051  CE7 mainboard
 		4c53 1070  PC6 mainboard
-	1221  82092AA_0
-	1222  82092AA_1
+	1221  82092AA PCI to PCMCIA Bridge
+	1222  82092AA IDE Controller
 	1223  SAA7116
 	1225  82452KX/GX [Orion]
 	1226  82596 PRO/10 PCI
@@ -7587,6 +7767,7 @@
 		1259 2560  AT-2560 100
 		1259 2561  AT-2560 100 FX Ethernet Adapter
 		1266 0001  NE10/100 Adapter
+		13e9 1000  6221L-4U
 		144d 2501  SEM-2000 MiniPCI LAN Adapter
 		144d 2502  SEM-2100IL MiniPCI LAN Adapter
 		1668 1100  EtherExpress PRO/100B (TX) (MiniPCI Ethernet+Modem)
@@ -7675,6 +7856,7 @@
 		8086 3010  EtherExpress PRO/100 S Network Connection
 		8086 3011  EtherExpress PRO/100 S Network Connection
 		8086 3012  EtherExpress PRO/100 Network Connection
+		8086 3411  SDS2 Mainboard
 	122d  430FX - 82437FX TSC [Triton I]
 	122e  82371FB PIIX ISA [Triton I]
 	1230  82371FB PIIX IDE [Triton I]
@@ -7682,13 +7864,15 @@
 	1234  430MX - 82371MX Mobile PCI I/O IDE Xcelerator (MPIIX)
 	1235  430MX - 82437MX Mob. System Ctrlr (MTSC) & 82438MX Data Path (MTDP)
 	1237  440FX - 82441FX PMC [Natoma]
-	1239  82371FB
-	123b  82380PB
-	123c  82380AB
+	1239  82371FB PIIX IDE Interface
+	123b  82380PB PCI to PCI Docking Bridge
+	123c  82380AB (MISA) Mobile PCI-to-ISA Bridge
 	123d  683053 Programmable Interrupt Device
+# in" hidden" mode
+	123e  82466GX (IHPC) Integrated Hot-Plug Controller
 	123f  82466GX Integrated Hot-Plug Controller (IHPC)
-	1240  752 AGP
-	124b  82380FB
+	1240  82752 (752) AGP Graphics Accelerator
+	124b  82380FB (MPCI2) Mobile Docking Controller
 	1250  430HX - 82439HX TXC [Triton II]
 	1360  82806AA PCI64 Hub PCI Bridge
 	1361  82806AA PCI64 Hub Controller (HRes)
@@ -7782,7 +7966,7 @@
 	2446  Intel 537 [82801BA/BAM AC'97 Modem]
 		1025 1016  Travelmate 612 TX
 		104d 80df  Vaio PCG-FX403
-	2448  82801BAM/CAM PCI Bridge
+	2448  82801 PCI Bridge
 	2449  82801BA/BAM/CA/CAM Ethernet Controller
 		0e11 0012  EtherExpress PRO/100 VM
 		0e11 0091  EtherExpress PRO/100 VE
@@ -7824,7 +8008,7 @@
 		8086 4532  D815EEA2 mainboard
 		8086 4557  D815EGEW Mainboard
 	244c  82801BAM ISA Bridge (LPC)
-	244e  82801BA/CA/DB/EB/ER Hub interface to PCI Bridge
+	244e  82801 PCI Bridge
 		1014 0267  NetVista A30p
 	2450  82801E ISA Bridge (LPC)
 	2452  82801E USB
@@ -7879,45 +8063,45 @@
 	248b  82801CA Ultra ATA Storage Controller
 		15d9 3480  P4DP6
 	248c  82801CAM ISA Bridge (LPC)
-	24c0  82801DB (ICH4) LPC Bridge
+	24c0  82801DB/DBL (ICH4/ICH4-L) LPC Bridge
 		1014 0267  NetVista A30p
 		1462 5800  845PE Max (MS-6580)
-	24c2  82801DB (ICH4) USB UHCI #1
+	24c2  82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1
 		1014 0267  NetVista A30p
 		1071 8160  MIM2000
 		1462 5800  845PE Max (MS-6580)
-	24c3  82801DB/DBM (ICH4) SMBus Controller
+	24c3  82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) SMBus Controller
 		1014 0267  NetVista A30p
 		1071 8160  MIM2000
 		1458 24c2  GA-8PE667 Ultra
 		1462 5800  845PE Max (MS-6580)
 		4c53 1090  Cx9 / Vx9 mainboard
-	24c4  82801DB (ICH4) USB UHCI #2
+	24c4  82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2
 		1014 0267  NetVista A30p
 		1071 8160  MIM2000
 		1462 5800  845PE Max (MS-6580)
 		4c53 1090  Cx9 / Vx9 mainboard
-	24c5  82801DB (ICH4) AC'97 Audio Controller
+	24c5  82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller
 		0e11 00b8  Analog Devices Inc. codec [SoundMAX]
 		1014 0267  NetVista A30p
 		1071 8160  MIM2000
 		1458 a002  GA-8PE667 Ultra
 		1462 5800  845PE Max (MS-6580)
-	24c6  82801DB (ICH4) AC'97 Modem Controller
+	24c6  82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Modem Controller
 		1071 8160  MIM2000
-	24c7  82801DB (ICH4) USB UHCI #3
+	24c7  82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3
 		1014 0267  NetVista A30p
 		1071 8160  MIM2000
 		1462 5800  845PE Max (MS-6580)
 	24ca  82801DBM (ICH4) Ultra ATA Storage Controller
 		1071 8160  MIM2000
-	24cb  82801DB (ICH4) Ultra ATA 100 Storage Controller
+	24cb  82801DB/DBL (ICH4/ICH4-L) UltraATA-100 IDE Controller
 		1014 0267  NetVista A30p
 		1458 24c2  GA-8PE667 Ultra
 		1462 5800  845PE Max (MS-6580)
 		4c53 1090  Cx9 / Vx9 mainboard
 	24cc  82801DBM LPC Interface Controller
-	24cd  82801DB (ICH4) USB2 EHCI Controller
+	24cd  82801DB/DBM (ICH4/ICH4-M) USB 2.0 EHCI Controller
 		1014 0267  NetVista A30p
 		1071 8160  MIM2000
 		1462 3981  845PE Max (MS-6580)
@@ -7927,19 +8111,23 @@
 		103c 12bc  d530 CMT (DG746A)
 		1458 24d1  GA-8IPE1000 Pro2 motherboard (865PE)
 		1462 7280  865PE Neo2 (MS-6728)
+		8086 3427  S875WP1-E mainboard
 	24d2  82801EB/ER (ICH5/ICH5R) USB UHCI #1
 		103c 12bc  d530 CMT (DG746A)
 		1043 80a6  P4P800 Mainboard
 		1462 7280  865PE Neo2 (MS-6728)
+		8086 3427  S875WP1-E mainboard
 	24d3  82801EB/ER (ICH5/ICH5R) SMBus Controller
 		1043 80a6  P4P800 Mainboard
 		1458 24d2  GA-8IPE1000 Pro2 motherboard (865PE)
 		1462 7280  865PE Neo2 (MS-6728)
+		8086 3427  S875WP1-E mainboard
 	24d4  82801EB/ER (ICH5/ICH5R) USB UHCI #2
 		103c 12bc  d530 CMT (DG746A)
 		1043 80a6  P4P800 Mainboard
 		1458 24d2  GA-8IPE1000 Pro2 motherboard (865PE)
 		1462 7280  865PE Neo2 (MS-6728)
+		8086 3427  S875WP1-E mainboard
 	24d5  82801EB/ER (ICH5/ICH5R) AC'97 Audio Controller
 		103c 12bc  Analog Devices codec [SoundMAX Integrated Digital Audio]
 		1043 80f3  P4P800 Mainboard
@@ -7950,22 +8138,26 @@
 		1043 80a6  P4P800 Mainboard
 		1458 24d2  GA-8IPE1000 Pro2 motherboard (865PE)
 		1462 7280  865PE Neo2 (MS-6728)
+		8086 3427  S875WP1-E mainboard
 	24db  82801EB/ER (ICH5/ICH5R) Ultra ATA 100 Storage Controller
 		103c 12bc  d530 CMT (DG746A)
 		1043 80a6  P4P800 Mainboard
 		1458 24d2  GA-8IPE1000 Pro2 motherboard (865PE)
 		1462 7280  865PE Neo2 (MS-6728)
 		1462 7580  MSI 875P
+		8086 3427  S875WP1-E mainboard
 	24dc  82801EB LPC Interface Controller
 	24dd  82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller
 		103c 12bc  d530 CMT (DG746A)
 		1043 80a6  P4P800 Mainboard
 		1458 5006  GA-8IPE1000 Pro2 motherboard (865PE)
 		1462 7280  865PE Neo2 (MS-6728)
+		8086 3427  S875WP1-E mainboard
 	24de  82801EB/ER (ICH5/ICH5R) USB UHCI #4
 		1043 80a6  P4P800 Mainboard
 		1458 24d2  GA-8IPE1000 Pro2 motherboard (865PE)
 		1462 7280  865PE Neo2 (MS-6728)
+		8086 3427  S875WP1-E mainboard
 	24df  82801EB (ICH5R) SATA (cc=RAID)
 	2500  82820 820 (Camino) Chipset Host Bridge (MCH)
 		1028 0095  Precision Workstation 220 Chipset
@@ -7984,23 +8176,23 @@
 	2534  82860 860 (Wombat) Chipset PCI Bridge
 	2540  E7500 Memory Controller Hub
 		15d9 3480  P4DP6
-	2541  E7000 Series Host RASUM Controller
+	2541  E7500/E7501 Host RASUM Controller
 		15d9 3480  P4DP6
 		4c53 1090  Cx9 / Vx9 mainboard
-	2543  E7000 Series Hub Interface B PCI-to-PCI Bridge
-	2544  E7000 Series Hub Interface B RASUM Controller
+	2543  E7500/E7501 Hub Interface B PCI-to-PCI Bridge
+	2544  E7500/E7501 Hub Interface B RASUM Controller
 		4c53 1090  Cx9 / Vx9 mainboard
-	2545  E7000 Series Hub Interface C PCI-to-PCI Bridge
-	2546  E7000 Series Hub Interface C RASUM Controller
-	2547  E7000 Series Hub Interface D PCI-to-PCI Bridge
-	2548  E7000 Series Hub Interface D RASUM Controller
+	2545  E7500/E7501 Hub Interface C PCI-to-PCI Bridge
+	2546  E7500/E7501 Hub Interface C RASUM Controller
+	2547  E7500/E7501 Hub Interface D PCI-to-PCI Bridge
+	2548  E7500/E7501 Hub Interface D RASUM Controller
 	254c  E7501 Memory Controller Hub
 		4c53 1090  Cx9 / Vx9 mainboard
 	2550  E7505 Memory Controller Hub
-	2551  E7000 Series RAS Controller
-	2552  E7000 Series Processor to AGP Controller
-	2553  E7000 Series Hub Interface B PCI-to-PCI Bridge
-	2554  E7000 Series Hub Interface B PCI-to-PCI Bridge RAS Controller
+	2551  E7505/E7205 Series RAS Controller
+	2552  E7505/E7205 PCI-to-AGP Bridge
+	2553  E7505 Hub Interface B PCI-to-PCI Bridge
+	2554  E7505 Hub Interface B PCI-to-PCI Bridge RAS Controller
 	255d  E7205 Memory Controller Hub
 	2560  82845G/GL[Brookdale-G]/GE/PE DRAM Controller/Host-Hub Interface
 		1458 2560  GA-8PE667 Ultra
@@ -8022,14 +8214,17 @@
 	2579  82875P Processor to AGP Controller
 	257b  82875P Processor to PCI to CSA Bridge
 	257e  82875P Processor to I/O Memory Interface
-	2580  Memory Controller Hub
-	2581  Memory Controller Hub PCI Express Port
-	2582  Graphics Controller
-	2584  Workstation Memory Controller Hub
-	2585  Workstation Memory Controller Hub PCI Express Port
+	2580  915G/P/GV Processor to I/O Controller
+	2581  915G/P/GV PCI Express Root Port
+	2582  82915G Express Chipset Family Graphics Controller
+	2584  925X Memory Controller Hub
+	2585  925X PCI Express Root Port
 	2588  Server Memory Controller Hub
 	2589  Server Memory Controller Hub PCI Express Port
 	258a  Graphics Controller
+	2590  Mobile Memory Controller Hub
+	2591  Mobile Memory Controller Hub PCI Express Port
+	2592  Mobile Graphics Controller
 	25a1  6300ESB LPC Interface Controller
 	25a2  6300ESB PATA Storage Controller
 	25a3  6300ESB SATA Storage Controller
@@ -8043,26 +8238,63 @@
 	25ad  6300ESB USB2 Enhanced Host Controller
 	25ae  6300ESB 64-bit PCI-X Bridge
 	25b0  6300ESB SATA RAID Controller
-	2640  I/O Controller Hub LPC
-	2641  I/O Controller Hub LPC
-	2642  I/O Controller Hub LPC
-	2651  I/O Controller Hub SATA cc=ide
-	2652  I/O Controller Hub SATA cc=raid
-	2658  I/O Controller Hub USB
-	2659  I/O Controller Hub USB
-	265a  I/O Controller Hub USB
-	265b  I/O Controller Hub USB
-	265c  I/O Controller Hub USB2
-	2660  I/O Controller Hub PCI Express Port 0
-	2662  I/O Controller Hub PCI Express Port 1
-	2664  I/O Controller Hub PCI Express Port 2
-	2666  I/O Controller Hub PCI Express Port 3
-	2668  I/O Controller Hub Audio
-	266a  I/O Controller Hub SMBus
-	266d  I/O Controller Hub Modem
-	266e  I/O Controller Hub Audio
-	266f  I/O Controller Hub PATA
-	2782  Graphics Controller
+	2600  Server Hub Interface
+	2601  Server Hub PCI Express x4 Port D
+	2602  Server Hub PCI Express x4 Port C0
+	2603  Server Hub PCI Express x4 Port C1
+	2604  Server Hub PCI Express x4 Port B0
+	2605  Server Hub PCI Express x4 Port B1
+	2606  Server Hub PCI Express x4 Port A0
+	2607  Server Hub PCI Express x4 Port A1
+	2608  Server Hub PCI Express x8 Port C
+	2609  Server Hub PCI Express x8 Port B
+	260a  Server Hub PCI Express x8 Port A
+	260c  Server Hub IMI Registers
+	2610  Server Hub System Bus, Boot, and Interrupt Registers
+	2611  Server Hub Address Mapping Registers
+	2612  Server Hub RAS Registers
+	2613  Server Hub Performance Monitoring Registers
+	2614  Server Hub Performance Monitoring Registers
+	2615  Server Hub Performance Monitoring Registers
+	2617  Server Hub Debug Registers
+	2618  Server Hub Debug Registers
+	2619  Server Hub Debug Registers
+	261a  Server Hub Debug Registers
+	261b  Server Hub Debug Registers
+	261c  Server Hub Debug Registers
+	261d  Server Hub Debug Registers
+	261e  Server Hub Debug Registers
+	2620  External Memory Bridge
+	2621  External Memory Bridge Control Registers
+	2622  External Memory Bridge Memory Interleaving Registers
+	2623  External Memory Bridge DDR Initialization and Calibration
+	2624  External Memory Bridge Reserved Registers
+	2625  External Memory Bridge Reserved Registers
+	2626  External Memory Bridge Reserved Registers
+	2627  External Memory Bridge Reserved Registers
+	2640  82801FB/FR (ICH6/ICH6R) LPC Interface Bridge
+	2641  82801FBM (ICH6M) LPC Interface Bridge
+	2642  82801FW/FRW (ICH6W/ICH6RW) LPC Interface Bridge
+	2651  82801FB/FW (ICH6/ICH6W) SATA Controller
+	2652  82801FR/FRW (ICH6R/ICH6RW) SATA Controller
+	2653  82801FBM (ICH6M) SATA Controller
+	2658  82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #1
+	2659  82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #2
+	265a  82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #3
+	265b  82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #4
+	265c  82801FB/FBM/FR/FW/FRW (ICH6 Family) USB2 EHCI Controller
+	2660  82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 1
+	2662  82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 2
+	2664  82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 3
+	2666  82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 4
+	2668  82801FB/FBM/FR/FW/FRW (ICH6 Family) High Definition Audio Controller
+	266a  82801FB/FBM/FR/FW/FRW (ICH6 Family) SMBus Controller
+	266c  82801FB/FBM/FR/FW/FRW (ICH6 Family) LAN Controller
+	266d  82801FB/FBM/FR/FW/FRW (ICH6 Family) AC'97 Modem Controller
+	266e  82801FB/FBM/FR/FW/FRW (ICH6 Family) AC'97 Audio Controller
+	266f  82801FB/FBM/FR/FW/FRW (ICH6 Family) IDE Controller
+	2782  82915G Express Chipset Family Graphics Controller
+	2792  Mobile Graphics Controller
 	3092  Integrated RAID
 	3200  GD31244 PCI-X SATA HBA
 	3340  82855PM Processor to I/O Controller
@@ -8092,7 +8324,7 @@
 	359a  Memory Controller Hub PCI Express Port C1
 	359b  Memory Controller Hub Extended Configuration Registers
 	359e  Workstation Memory Controller Hub
-	4220  Intel(R) PRO/Wireless 2200BG
+	4220  PRO/Wireless 2200BG
 	5200  EtherExpress PRO/100 Intelligent Server
 	5201  EtherExpress PRO/100 Intelligent Server
 		8086 0001  EtherExpress PRO/100 Server Ethernet Adapter
@@ -8155,7 +8387,7 @@
 	7601  82372FB PIIX5 IDE
 	7602  82372FB PIIX5 USB
 	7603  82372FB PIIX5 SMBus
-	7800  i740
+	7800  82740 (i740) AGP Graphics Accelerator
 		003d 0008  Starfighter AGP
 		003d 000b  Starfighter AGP
 		1092 0100  Stealth II G460
@@ -8191,6 +8423,7 @@
 		4c53 1051  CE7 mainboard
 		e4bf 1000  CC8-1-BLUES
 	ffff  450NX/GX [Orion] - 82453KX/GX Memory controller [BUG]
+8401  TRENDware International Inc.
 8800  Trigem Computer Inc.
 	2008  Video assistent component
 8866  T-Square Design Inc.
@@ -8355,15 +8588,18 @@
 	00c1  AIC-7899B U160/m
 	00c3  AIC-7899D U160/m
 	00c5  RAID subsystem HBA
-		1028 00c5  PowerEdge 2550
+		1028 00c5  PowerEdge 2400,2500,2550,4400
 	00cf  AIC-7899P U160/m
 		1028 00ce  PowerEdge 1400
 		1028 00d1  PowerEdge 2550
 		10f1 2462  Thunder K7 S2462
 		15d9 9005  Onboard SCSI Host Adapter
+		8086 3411  SDS2 Mainboard
 	0250  ServeRAID Controller
 		1014 0279  ServeRAID-xx
 		1014 028c  ServeRAID-xx
+# from kernel sources
+	0279  ServeRAID 6M
 	0283  AAC-RAID
 		9005 0283  Catapult
 	0284  AAC-RAID
@@ -8432,7 +8668,7 @@
 		1000 0012  1P2S
 	9845  PCI 9845 Multi-I/O Controller
 		1000 0006  0P6S (6 port 16550a serial card)
-	9855  PCI 9855 Multi-I/O Controller 4 Serial 1 Parallel
+	9855  PCI 9855 Multi-I/O Controller
 		1000 0014  1P4S
 9902  Stargen Inc.
 	0001  SG2010 PCI over Starfabric Bridge
@@ -8447,6 +8683,7 @@
 a727  3Com Corporation
 aa42  Scitex Digital Video
 ac1e  Digital Receiver Technology Inc
+aecb  Adrienne Electronics Corporation
 b1b3  Shiva Europe Limited
 # Pinnacle should be 11bd, but they got it wrong several times --mj
 bd11  Pinnacle Systems, Inc. (Wrong ID)
@@ -8467,9 +8704,9 @@
 dead  Indigita Corporation
 e000  Winbond
 	e000  W89C940
-# see : http://www.schoenfeld.de/inside/Inside_CWMK3.txt
-e159  Individual Computers - Jens Schoenfeld
-	0001  Intel 537
+# see also : http://www.schoenfeld.de/inside/Inside_CWMK3.txt maybe a misuse of TJN id or it use the TJN 3XX chip for other applic
+e159  Tiger Jet Network Inc.
+	0001  Tiger3XX Modem/ISDN interface
 		0059 0001  128k ISDN-S/T Adapter
 		0059 0003  128k ISDN-U Adapter
 	0002  Tiger100APC ISDN chipset

