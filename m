Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267198AbTAHLvv>; Wed, 8 Jan 2003 06:51:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267213AbTAHLvv>; Wed, 8 Jan 2003 06:51:51 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:5268 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S267198AbTAHLvZ>; Wed, 8 Jan 2003 06:51:25 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Wed, 8 Jan 2003 13:04:44 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] 30_bttv-doc
Message-ID: <20030108120444.GA17331@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

$subject says all:  This patch updates the bttv documentation.

  Gerd

--- linux-2.5.54/Documentation/video4linux/bttv/CARDLIST	2003-01-08 10:33:57.000000000 +0100
+++ linux/Documentation/video4linux/bttv/CARDLIST	2003-01-08 10:59:58.000000000 +0100
@@ -69,7 +69,7 @@
   card=67 - IODATA GV-BCTV4/PCI
   card=68 - 3Dfx VoodooTV FM (Euro), VoodooTV 200 (USA)
   card=69 - Active Imaging AIMMS
-  card=70 - Prolink Pixelview PV-BT878P+ (Rev.4C)
+  card=70 - Prolink Pixelview PV-BT878P+ (Rev.4C,8E)
   card=71 - Lifeview FlyVideo 98EZ (capture only) LR51
   card=72 - Prolink Pixelview PV-BT878P+9B (PlayTV Pro rev.9B FM+NICAM)
   card=73 - Sensoray 311
--- linux-2.5.54/Documentation/video4linux/bttv/Cards	2003-01-08 10:34:02.000000000 +0100
+++ linux/Documentation/video4linux/bttv/Cards	2003-01-08 10:59:58.000000000 +0100
@@ -4,25 +4,27 @@
 
 
 Suppported cards:
-
-
 Bt848/Bt848a/Bt849/Bt878/Bt879 cards
 ------------------------------------
 
-All cards with Bt848/Bt848a/Bt849/Bt878/Bt879 and normal Composite/S-VHS inputs
-are supported.
-Teletext and Intercast support (PAL only) for ALL cards via VBI sample decoding
-in software.
+All cards with Bt848/Bt848a/Bt849/Bt878/Bt879 and normal
+Composite/S-VHS inputs are supported.  Teletext and Intercast support
+(PAL only) for ALL cards via VBI sample decoding in software.
+
+Some cards with additional multiplexing of inputs or other additional
+fancy chips are only partially supported (unless specifications by the
+card manufacturer are given).  When a card is listed here it isn't
+necessarily fully supported.
 
-Some cards with additional multiplexing of inputs are only partially 
-supported (unless specifications by the card manufacturer are given).
+All other cards only differ by additional components as tuners, sound
+decoders, EEPROMs, teletext decoders ...
 
-All other cards only differ by additional components as tuners, sound decoders,
-EEPROMs, teletext decoders ...
 
 Unsupported Cards: 
 ------------------
-Cards with Zoran (ZR) or Philips (SAA) or ISA are not supported by this driver. 
+
+Cards with Zoran (ZR) or Philips (SAA) or ISA are not supported by
+this driver.
 
 
 MATRIX Vision
@@ -197,7 +199,7 @@
   50686 "TV Tuner"                       = KNC1 TV Station
   50687 "TV Tuner stereo"                = KNC1 TV Station pro
   50688 "TV Tuner RDS" (black package)   = KNC1 TV Station RDS
-  50689  TV SAT DVB-S CARD CI PCI (SAA7146AH)
+  50689  TV SAT DVB-S CARD CI PCI (SAA7146AH, SU1278?) = "KNC1 TV Station DVB-S"
   50692 "TV/FM Tuner" (small PCB)
   50694  TV TUNER CARD RDS (PHILIPS CHIPSET SAA7134HL)
   50696  TV TUNER STEREO (PHILIPS CHIPSET SAA7134HL, MK3ME Tuner)
@@ -234,10 +236,20 @@
    PixelView PowerStudio PAK - (Model: PV-M3600 REV 4E)
    PixelView DigitalVCR PAK -  (Model: PV-M2400 REV 4C / 8D / 10A )
 
+   PixelView PlayTV PAK II (TV/FM card + usb camera)  PV-M3800 
+   PixelView PlayTV XP PV-M4700,PV-M4700(w/FM)
+   PixelView PlayTV DVR PV-M4600  package contents:PixelView PlayTV pro, windvr & videoMail s/w
+
    Further Cards:
    PV-BT878P+rev.9B (Play TV Pro, opt. w/FM w/NICAM)
    PV-BT878P+rev.2F
    PV-BT878P Rev.1D (bt878, capture only)
+
+   XCapture PV-CX881P (cx23881)
+   PlayTV HD PV-CX881PL+, PV-CX881PL+(w/FM) (cx23881)
+
+   DTV3000 PV-DTV3000P+ DVB-S CI = Twinhan VP-1030
+   DTV2000 DVB-S = Twinhan VP-1020
    
    Video Conferencing:
    PixelView Meeting PAK - (Model: PV-BT878P)
@@ -245,6 +257,9 @@
    PixelView Meeting PAK plus - (Model: PV-BT878P+rev 4C/8D/10A)
    PixelView Capture - (Model: PV-BT848P)
 
+   PixelView PlayTV USB pro
+   Model No. PV-NT1004+, PV-NT1004+ (w/FM) = NT1004 USB decoder chip + SAA7113 video decoder chip
+
 Dynalink
 --------
    These are CPH series.
@@ -284,6 +299,8 @@
    TV-Station pro (+TV stereo)
    TV-Station FM (+Radio)
    TV-Station RDS (+RDS)
+   TV Station SAT (analog satellite)
+   TV-Station DVB-S
 
    newer Cards have saa7134, but model name stayed the same?
 
@@ -296,8 +313,23 @@
    3DeMon PV951
    MediaForte TV-Vision PV951
    Yoko PV951
-  )
+   Vivanco Tuner Card PCI Art.-Nr.: 68404
+  ) now named PV-951T
+
+  Surveillance Series
+  PV-141
+  PV-143
+  PV-147
   PV-148 (capture only)
+  PV-150
+  PV-151
+
+  TV-FM Tuner Series
+  PV-951TDV (tv tuner + 1394)
+  PV-951T/TF
+  PV-951PT/TF
+  PV-956T/TF Low Profile
+  PV-911
 
 Highscreen
 ----------
@@ -372,9 +404,9 @@
 
 IXMicro (former: IMS=Integrated Micro Solutions)
 -------
-   IXTV BT848
+   IXTV BT848 (=TurboTV)
    IXTV BT878
-   TurboTV (Bt848)
+   IMS TurboTV (Bt848)
 
 Lifetec/Medion/Tevion/Aldi
 --------------------------
@@ -386,8 +418,10 @@
 Modular Technologies (www.modulartech.com) UK
 ---------------------------------------------
    MM100 PCTV (Bt848)
+   MM201 PCTV (Bt878, Bt832) w/ Quartzsight camera
+   MM202 PCTV (Bt878, Bt832, tda9874)
    MM205 PCTV (Bt878)
-   MM210 PCTV (Bt878) (Galaxy TV)
+   MM210 PCTV (Bt878) (Galaxy TV, Galaxymedia ?)
 
 Terratec
 --------
@@ -399,6 +433,7 @@
    Terra TValue Version BT878,    "80-CP2830110-0 TTTV4" printed on the PCB, 
 				     "CPH011-D83" on back
    Terra TValue Version 1.0       "ceb105.PCB" (really identical to Terra TV+ Version 1.0)
+   Terra TValue New Revision	  "LR102 Rec.C"
    Terra Active Radio Upgrade (tea5757h, saa6588t)
 
    LR74 is a newer PCB revision of ceb105 (both incl. connector for Active Radio Upgrade)
@@ -446,7 +481,7 @@
    Studio PCTV Pro  (Bt878 stereo w/ FM)
    Pinnacle PCTV    (Bt878, MT2032)
    Pinnacle PCTV Pro (Bt878, MT2032)
-   Pinncale PCTV Sat
+   Pinncale PCTV Sat (bt878a, HM1821/1221)
 
    M(J)PEG capture and playback:
    DC1+ (ISA)
@@ -519,7 +554,7 @@
 ------
    iProTV (Card for iMac Mezzanine slot, Bt848+SCSI)
    ProTV (Bt848)
-   ProTV II = ProTV Stereo (Bt878)
+   ProTV II = ProTV Stereo (Bt878) ["stereo" means FM stereo, tv is still mono]
 
 ATI
 ---
@@ -544,7 +579,7 @@
 
 STB
 ---
-   STB bt878 == Gateway 6000704 
+   STB Gateway 6000704 (bt878)
    STB Gateway 6000699 (bt848)
    STB Gateway 6000402 (bt848)
    STB TV130 PCI
@@ -558,13 +593,14 @@
 ------------
    TT-SAT PCI (PCB "Sat-PCI Rev.:1.3.1"; zr36125, vpx3225d, stc0056a, Tuner:BSKE6-155A
    TT-DVB-Sat
+    revisions 1.1, 1.3, 1.5, 1.6 and 2.1
     This card is sold as OEM from:
 	Siemens DVB-s Card
 	Hauppauge WinTV DVB-S
 	Technisat SkyStar 1 DVB
 	Galaxis DVB Sat
     Now this card is called TT-PCline Premium Family
-   TT-Budget
+   TT-Budget (saa7146, bsru6-701a)
     This card is sold as OEM from:
 	Hauppauge WinTV Nova
 	Satelco Standard PCI (DVB-S)
@@ -603,18 +639,71 @@
    Galaxis DVB Card C CI
    Galaxis DVB Card S
    Galaxis DVB Card C
+   Galaxis plug.in S [neuer Name: Galaxis DVB Card S CI
 
 Hauppauge
 ---------
    many many WinTV models ...
-   WinTV DVBs = Tehcnotrend Premium
-   WinTV NOVA = Technotrend Budget
-   WinTV NOVA-CI
-   WinTV-Nexus-s
+   WinTV DVBs = Technotrend Premium 1.3
+   WinTV NOVA = Technotrend Budget 1.1 "S-DVB DATA"
+   WinTV NOVA-CI "SDVBACI"
+   WinTV Nova USB (=Technotrend USB 1.0)
+   WinTV-Nexus-s (=Technotrend Premium 2.1 or 2.2)
    WinTV PVR
    WinTV PVR 250
    WinTV PVR 450
 
+  US models
+  990 WinTV-PVR-350 (249USD)
+  980 WinTV-PVR-250 (149USD)
+  880 WinTV-PVR-PCI (199USD)
+  881 WinTV-PVR-USB
+  190 WinTV-GO
+  191 WinTV-GO-FM
+  404 WinTV
+  401 WinTV-radio
+  495 WinTV-Theater
+  602 WinTV-USB
+  621 WinTV-USB-FM
+  600 USB-Live
+  698 WinTV-HD
+  697 WinTV-D
+  564 WinTV-Nexus-S
+
+  Deutsche Modelle
+  603 WinTV GO
+  719 WinTV Primio-FM
+  718 WinTV PCI-FM
+  497 WinTV Theater
+  569 WinTV USB
+  568 WinTV USB-FM
+  882 WinTV PVR
+  981 WinTV PVR 250
+  891 WinTV-PVR-USB
+  541 WinTV Nova
+  488 WinTV Nova-Ci
+  564 WinTV-Nexus-s
+  727 WinTV-DVB-c
+  545 Common Interface
+  898 WinTV-Nova-USB
+
+  UK models
+  607 WinTV Go
+  693,793 WinTV Primio FM
+  647,747 WinTV PCI FM
+  498 WinTV Theater
+  883 WinTV PVR
+  893 WinTV PVR USB  (Duplicate entry)
+  566 WinTV USB (UK)
+  573 WinTV USB FM
+  429 Impact VCB (bt848)
+  600 USB Libe (Video-In 1x Comp, 1xSVHS)
+  542 WinTV Nova
+  717 WinTV DVB-S
+  909 Nova-t PCI
+  893 Nova-t USB   (Duplicate entry)
+  
+
 Matrix-Vision
 -------------
    MATRIX-Vision MV-Delta
@@ -699,7 +788,7 @@
    HS-878 Mini PCI Capture Add-on Card
    HS-879 Mini PCI 3D Audio and Capture Add-on Card (w/ ES1938 Solo-1)
 
-Satelco
+Satelco www.citycom-gmbh.de, www.satelco.de
 -------
    TV-FM =KNC1 saa7134
    Standard PCI (DVB-S) = Technotrend Budget
@@ -724,7 +813,8 @@
 
 AITech
 ------
-   AITech WaveWatcher TV-PCI = LR26
+   Wavewatcher TV (ISA)
+   AITech WaveWatcher TV-PCI = can be LR26 (Bt848) or LR50 (BT878)
    WaveWatcher TVR-202 TV/FM Radio Card (ISA)
 
 MAXRON
@@ -750,3 +840,42 @@
    CyberMail AV Video Email Kit w/ PCI Capture Card (capture only)
    CyberMail Xtreme
   These are Flyvideo
+
+VCR (http://www.vcrinc.com/) 
+---
+  Video Catcher 16
+
+Twinhan
+-------
+   DST Card/DST-IP (bt878, twinhan asic) VP-1020
+    Sold as:
+     KWorld DVBS Satellite TV-Card
+     Powercolor DSTV Satellite Tuner Card
+     Prolink Pixelview DTV2000
+     Provideo PV-911 Digital Satellite TV Tuner Card With Common Interface ?
+   DST-CI Card (DVB Satellite) VP-1030
+   DCT Card (DVB cable)
+
+MSI
+---
+    MSI TV@nywhere Tuner Card (MS-8876) (CX23881/883) Not Bt878 compatible.
+    MS-8401 DVB-S
+
+Focus www.focusinfo.com
+-----
+    InVideo PCI (bt878)
+
+Sdisilk www.sdisilk.com/
+-------
+    SDI Silk 100
+    SDI Silk 200 SDI Input Card
+
+www.euresys.com
+    PICOLO series 
+
+PMC/Pace
+www.pacecom.co.uk website closed
+
+Mercury www.kobian.com (UK and FR)
+    LR50
+    LR138RBG-Rx  == LR138

-- 
Weil die späten Diskussionen nicht mal mehr den Rotwein lohnen.
				-- Wacholder in "Melanie"
