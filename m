Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263028AbVGIBXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263028AbVGIBXM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 21:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbVGIAjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 20:39:17 -0400
Received: from smtp3.brturbo.com.br ([200.199.201.164]:35745 "EHLO
	smtp3.brturbo.com.br") by vger.kernel.org with ESMTP
	id S263030AbVGIAjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 20:39:04 -0400
Message-ID: <42CF1CA2.3060504@brturbo.com.br>
Date: Fri, 08 Jul 2005 21:38:58 -0300
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
User-Agent: Mozilla Thunderbird 1.0.2-3mdk (X11/20050322)
X-Accept-Language: pt-br, pt, es, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: LKML <linux-kernel@vger.kernel.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>
Subject: [PATCH 4/14 2.6.13-rc2-mm1] V4L Documentation
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/mixed;
 boundary="------------050601090801020403040501"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050601090801020403040501
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


--------------050601090801020403040501
Content-Type: text/x-patch;
 name="v4l_driver-doc.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="v4l_driver-doc.diff"

- Card definitions updated.
- Tail spaces removed.
- Mark all 7135 cards as 7133.
- Correct info about sync byte for MPEG-2 transport stream packets.

Signed-off-by: Michael Krufky <mkrufky@m1k.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Signed-off-by: hermann pitton <hermann.pitton@onlinehome.de>
Signed-Off-By: Nickolay V. Shmyrev <nshmyrev@yandex.ru>

 linux/Documentation/video4linux/CARDLIST.bttv                |    2 
 linux/Documentation/video4linux/CARDLIST.cx88                |    2 
 linux/Documentation/video4linux/CARDLIST.saa7134             |   14 +
 linux/Documentation/video4linux/CARDLIST.tuner               |    4 
 linux/Documentation/video4linux/README.saa7134               |    6 
 linux/Documentation/video4linux/bttv/Cards                   |   74 +++++-----
 linux/Documentation/video4linux/not-in-cx2388x-datasheet.txt |    4 
 7 files changed, 57 insertions(+), 49 deletions(-)

diff -u linux-2.6.13/Documentation/video4linux/bttv/Cards linux/Documentation/video4linux/bttv/Cards
--- linux-2.6.13/Documentation/video4linux/bttv/Cards	2005-07-06 00:46:33.000000000 -0300
+++ linux/Documentation/video4linux/bttv/Cards	2005-07-07 21:32:26.000000000 -0300
@@ -20,7 +20,7 @@
 decoders, EEPROMs, teletext decoders ...
 
 
-Unsupported Cards: 
+Unsupported Cards:
 ------------------
 
 Cards with Zoran (ZR) or Philips (SAA) or ISA are not supported by
@@ -50,11 +50,11 @@
 Miro/Pinnacle PCTV
 ------------------
 
-- Bt848 
-  some (all??) come with 2 crystals for PAL/SECAM and NTSC 
+- Bt848
+  some (all??) come with 2 crystals for PAL/SECAM and NTSC
 - PAL, SECAM or NTSC TV tuner (Philips or TEMIC)
 - MSP34xx sound decoder on add on board
-  decoder is supported but AFAIK does not yet work 
+  decoder is supported but AFAIK does not yet work
   (other sound MUX setting in GPIO port needed??? somebody who fixed this???)
 - 1 tuner, 1 composite and 1 S-VHS input
 - tuner type is autodetected
@@ -70,7 +70,7 @@
 Hauppauge Win/TV pci
 --------------------
 
-There are many different versions of the Hauppauge cards with different 
+There are many different versions of the Hauppauge cards with different
 tuners (TV+Radio ...), teletext decoders.
 Note that even cards with same model numbers have (depending on the revision)
 different chips on it.
@@ -80,22 +80,22 @@
 - PAL, SECAM, NTSC or tuner with or without Radio support
 
 e.g.:
-  PAL: 
+  PAL:
   TDA5737: VHF, hyperband and UHF mixer/oscillator for TV and VCR 3-band tuners
   TSA5522: 1.4 GHz I2C-bus controlled synthesizer, I2C 0xc2-0xc3
-  
+
   NTSC:
   TDA5731: VHF, hyperband and UHF mixer/oscillator for TV and VCR 3-band tuners
   TSA5518: no datasheet available on Philips site
-- Philips SAA5246 or SAA5284 ( or no) Teletext decoder chip	
+- Philips SAA5246 or SAA5284 ( or no) Teletext decoder chip
   with buffer RAM (e.g. Winbond W24257AS-35: 32Kx8 CMOS static RAM)
   SAA5246 (I2C 0x22) is supported
-- 256 bytes EEPROM: Microchip 24LC02B or Philips 8582E2Y 
+- 256 bytes EEPROM: Microchip 24LC02B or Philips 8582E2Y
   with configuration information
   I2C address 0xa0 (24LC02B also responds to 0xa2-0xaf)
 - 1 tuner, 1 composite and (depending on model) 1 S-VHS input
 - 14052B: mux for selection of sound source
-- sound decoder: TDA9800, MSP34xx (stereo cards) 
+- sound decoder: TDA9800, MSP34xx (stereo cards)
 
 
 Askey CPH-Series
@@ -108,17 +108,17 @@
     CPH05x: BT878 with FM
     CPH06x: BT878 (w/o FM)
     CPH07x: BT878 capture only
- 
+
   TV standards:
      CPH0x0: NTSC-M/M
      CPH0x1: PAL-B/G
      CPH0x2: PAL-I/I
      CPH0x3: PAL-D/K
-     CPH0x4: SECAM-L/L 
-     CPH0x5: SECAM-B/G 
-     CPH0x6: SECAM-D/K 
-     CPH0x7: PAL-N/N 
-     CPH0x8: PAL-B/H 
+     CPH0x4: SECAM-L/L
+     CPH0x5: SECAM-B/G
+     CPH0x6: SECAM-D/K
+     CPH0x7: PAL-N/N
+     CPH0x8: PAL-B/H
      CPH0x9: PAL-M/M
 
   CPH03x was often sold as "TV capturer".
@@ -174,7 +174,7 @@
       "The FlyVideo2000 and FlyVideo2000s product name have renamed to FlyVideo98."
       Their Bt8x8 cards are listed as discontinued.
       Flyvideo 2000S was probably sold as Flyvideo 3000 in some contries(Europe?).
-      The new Flyvideo 2000/3000 are SAA7130/SAA7134 based. 
+      The new Flyvideo 2000/3000 are SAA7130/SAA7134 based.
 
   "Flyvideo II" had been the name for the 848 cards, nowadays (in Germany)
   this name is re-used for LR50 Rev.W.
@@ -235,12 +235,12 @@
    Multimedia TV packages (card + software pack):
    PixelView Play TV Theater - (Model: PV-M4200) =  PixelView Play TV pro + Software
    PixelView Play TV PAK -     (Model: PV-BT878P+ REV 4E)
-   PixelView Play TV/VCR -     (Model: PV-M3200 REV 4C / 8D / 10A ) 
+   PixelView Play TV/VCR -     (Model: PV-M3200 REV 4C / 8D / 10A )
    PixelView Studio PAK -      (Model:    M2200 REV 4C / 8D / 10A )
    PixelView PowerStudio PAK - (Model: PV-M3600 REV 4E)
    PixelView DigitalVCR PAK -  (Model: PV-M2400 REV 4C / 8D / 10A )
 
-   PixelView PlayTV PAK II (TV/FM card + usb camera)  PV-M3800 
+   PixelView PlayTV PAK II (TV/FM card + usb camera)  PV-M3800
    PixelView PlayTV XP PV-M4700,PV-M4700(w/FM)
    PixelView PlayTV DVR PV-M4600  package contents:PixelView PlayTV pro, windvr & videoMail s/w
 
@@ -254,7 +254,7 @@
 
    DTV3000 PV-DTV3000P+ DVB-S CI = Twinhan VP-1030
    DTV2000 DVB-S = Twinhan VP-1020
-   
+
    Video Conferencing:
    PixelView Meeting PAK - (Model: PV-BT878P)
    PixelView Meeting PAK Lite - (Model: PV-BT878P)
@@ -308,7 +308,7 @@
 
    newer Cards have saa7134, but model name stayed the same?
 
-Provideo 
+Provideo
 --------
   PV951 or PV-951 (also are sold as:
    Boeder TV-FM Video Capture Card
@@ -353,7 +353,7 @@
    AVerTV
    AVerTV Stereo
    AVerTV Studio (w/FM)
-   AVerMedia TV98 with Remote 
+   AVerMedia TV98 with Remote
    AVerMedia TV/FM98 Stereo
    AVerMedia TVCAM98
    TVCapture (Bt848)
@@ -373,7 +373,7 @@
    (1) Daughterboard MB68-A with TDA9820T and TDA9840T
    (2) Sony NE41S soldered (stereo sound?)
    (3) Daughterboard M118-A w/ pic 16c54 and 4 MHz quartz
- 
+
    US site has different drivers for (as of 09/2002):
    EZ Capture/InterCam PCI (BT-848 chip)
    EZ Capture/InterCam PCI (BT-878 chip)
@@ -437,7 +437,7 @@
    Terra TValueRadio,             "LR102 Rev.C" printed on the PCB
    Terra TV/Radio+ Version 1.0,   "80-CP2830100-0" TTTV3 printed on the PCB,
 				     "CPH010-E83" on the back, SAA6588T, TDA9873H
-   Terra TValue Version BT878,    "80-CP2830110-0 TTTV4" printed on the PCB, 
+   Terra TValue Version BT878,    "80-CP2830110-0 TTTV4" printed on the PCB,
 				     "CPH011-D83" on back
    Terra TValue Version 1.0       "ceb105.PCB" (really identical to Terra TV+ Version 1.0)
    Terra TValue New Revision	  "LR102 Rec.C"
@@ -528,7 +528,7 @@
    KW-606RSF
    KW-607A (capture only)
    KW-608 (Zoran capture only)
- 
+
 IODATA (jp)
 ------
    GV-BCTV/PCI
@@ -542,15 +542,15 @@
 -------
    WinDVR	= Kworld "KW-TVL878RF"
 
-www.sigmacom.co.kr 
+www.sigmacom.co.kr
 ------------------
-   Sigma Cyber TV II 
+   Sigma Cyber TV II
 
 www.sasem.co.kr
 ---------------
    Litte OnAir TV
 
-hama 
+hama
 ----
    TV/Radio-Tuner Card, PCI (Model 44677) = CPH051
 
@@ -638,7 +638,7 @@
 
 Jetway (www.jetway.com.tw)
 --------------------------
-   JW-TV 878M 
+   JW-TV 878M
    JW-TV 878  = KWorld KW-TV878RF
 
 Galaxis
@@ -715,7 +715,7 @@
   809 MyVideo
   872 MyTV2Go FM
 
- 
+
   546 WinTV Nova-S CI
   543 WinTV Nova
   907 Nova-S USB
@@ -739,7 +739,7 @@
   832 MyTV2Go
   869 MyTV2Go-FM
   805 MyVideo (USB)
-  
+
 
 Matrix-Vision
 -------------
@@ -764,7 +764,7 @@
    Intervision IV-550 (bt8x8)
    Intervision IV-100 (zoran)
    Intervision IV-1000 (bt8x8)
-   
+
 Asonic (www.asonic.com.cn) (website down)
 -----------------------------------------
    SkyEye tv 878
@@ -804,11 +804,11 @@
 
 JTT/ Justy Corp.http://www.justy.co.jp/ (www.jtt.com.jp website down)
 ---------------------------------------------------------------------
-   JTT-02 (JTT TV) "TV watchmate pro" (bt848) 
+   JTT-02 (JTT TV) "TV watchmate pro" (bt848)
 
 ADS www.adstech.com
 -------------------
-   Channel Surfer TV ( CHX-950 ) 
+   Channel Surfer TV ( CHX-950 )
    Channel Surfer TV+FM ( CHX-960FM )
 
 AVEC www.prochips.com
@@ -874,7 +874,7 @@
 ------------------
    Falcon Series (capture only)
  In USA: http://www.theimagingsource.com/
-   DFG/LC1	
+   DFG/LC1
 
 www.sknet-web.co.jp
 -------------------
@@ -890,7 +890,7 @@
    CyberMail Xtreme
   These are Flyvideo
 
-VCR (http://www.vcrinc.com/) 
+VCR (http://www.vcrinc.com/)
 ---
   Video Catcher 16
 
@@ -920,7 +920,7 @@
     SDI Silk 200 SDI Input Card
 
 www.euresys.com
-    PICOLO series 
+    PICOLO series
 
 PMC/Pace
 www.pacecom.co.uk website closed
diff -u linux-2.6.13/Documentation/video4linux/README.saa7134 linux/Documentation/video4linux/README.saa7134
--- linux-2.6.13/Documentation/video4linux/README.saa7134	2005-07-06 00:46:33.000000000 -0300
+++ linux/Documentation/video4linux/README.saa7134	2005-07-07 21:32:26.000000000 -0300
@@ -61,11 +61,11 @@
 
  - saa7130 - low-price chip, doesn't have mute, that is why all those
  cards should have .mute field defined in their tuner structure.
-
+ 
  - saa7134 - usual chip
-
+ 
  - saa7133/35 - saa7135 is probably a marketing decision, since all those
- chips identifies itself as 33 on pci.
+ chips identifies itself as 33 on pci. 
 
 Credits
 =======
diff -u linux-2.6.13/Documentation/video4linux/not-in-cx2388x-datasheet.txt linux/Documentation/video4linux/not-in-cx2388x-datasheet.txt
--- linux-2.6.13/Documentation/video4linux/not-in-cx2388x-datasheet.txt	2005-07-06 00:46:33.000000000 -0300
+++ linux/Documentation/video4linux/not-in-cx2388x-datasheet.txt	2005-07-07 21:32:26.000000000 -0300
@@ -34,4 +34,8 @@
   2: HACTEXT
   1: HSFMT
 
+0x47 is the sync byte for MPEG-2 transport stream packets.
+Datasheet incorrectly states to use 47 decimal. 188 is the length. 
+All DVB compliant frontends output packets with this start code.
+
 =================================================================================
diff -u linux-2.6.13/Documentation/video4linux/CARDLIST.bttv linux/Documentation/video4linux/CARDLIST.bttv
--- linux-2.6.13/Documentation/video4linux/CARDLIST.bttv	2005-07-06 00:46:33.000000000 -0300
+++ linux/Documentation/video4linux/CARDLIST.bttv	2005-07-07 21:32:26.000000000 -0300
@@ -1,4 +1,4 @@
-card=0 -  *** UNKNOWN/GENERIC *** 
+card=0 -  *** UNKNOWN/GENERIC ***
 card=1 - MIRO PCTV
 card=2 - Hauppauge (bt848)
 card=3 - STB, Gateway P/N 6000699 (bt848)
diff -u linux-2.6.13/Documentation/video4linux/CARDLIST.saa7134 linux/Documentation/video4linux/CARDLIST.saa7134
--- linux-2.6.13/Documentation/video4linux/CARDLIST.saa7134	2005-07-06 00:46:33.000000000 -0300
+++ linux/Documentation/video4linux/CARDLIST.saa7134	2005-07-07 21:32:26.000000000 -0300
@@ -1,10 +1,10 @@
-  0 -> UNKNOWN/GENERIC                         
+  0 -> UNKNOWN/GENERIC
   1 -> Proteus Pro [philips reference design]   [1131:2001,1131:2001]
   2 -> LifeView FlyVIDEO3000                    [5168:0138,4e42:0138]
   3 -> LifeView FlyVIDEO2000                    [5168:0138]
   4 -> EMPRESS                                  [1131:6752]
   5 -> SKNet Monster TV                         [1131:4e85]
-  6 -> Tevion MD 9717                          
+  6 -> Tevion MD 9717
   7 -> KNC One TV-Station RDS / Typhoon TV Tuner RDS [1131:fe01,1894:fe01]
   8 -> Terratec Cinergy 400 TV                  [153B:1142]
   9 -> Medion 5044
@@ -34,6 +34,7 @@
  33 -> AVerMedia DVD EZMaker                    [1461:10ff]
  34 -> Noval Prime TV 7133
  35 -> AverMedia AverTV Studio 305              [1461:2115]
+ 36 -> UPMOST PURPLE TV                         [12ab:0800]
  37 -> Items MuchTV Plus / IT-005
  38 -> Terratec Cinergy 200 TV                  [153B:1152]
  39 -> LifeView FlyTV Platinum Mini             [5168:0212]
@@ -43,20 +44,21 @@
  43 -> :Zolid Xpert TV7134
  44 -> Empire PCI TV-Radio LE
  45 -> Avermedia AVerTV Studio 307              [1461:9715]
- 46 -> AVerMedia Cardbus TV/Radio               [1461:d6ee]
+ 46 -> AVerMedia Cardbus TV/Radio (E500)        [1461:d6ee]
  47 -> Terratec Cinergy 400 mobile              [153b:1162]
  48 -> Terratec Cinergy 600 TV MK3              [153B:1158]
  49 -> Compro VideoMate Gold+ Pal               [185b:c200]
  50 -> Pinnacle PCTV 300i DVB-T + PAL           [11bd:002d]
  51 -> ProVideo PV952                           [1540:9524]
  52 -> AverMedia AverTV/305                     [1461:2108]
+ 53 -> ASUS TV-FM 7135                          [1043:4845]
  54 -> LifeView FlyTV Platinum FM               [5168:0214,1489:0214]
- 55 -> LifeView FlyDVB-T DUO                    [5168:0306]
+ 55 -> LifeView FlyDVB-T DUO                    [5168:0502,5168:0306]
  56 -> Avermedia AVerTV 307                     [1461:a70a]
  57 -> Avermedia AVerTV GO 007 FM               [1461:f31f]
  58 -> ADS Tech Instant TV (saa7135)            [1421:0350,1421:0370]
  59 -> Kworld/Tevion V-Stream Xpert TV PVR7134
- 60 -> Typhoon DVB-T Duo Digital/Analog Cardbus
- 61 -> Philips TOUGH DVB-T reference design
+ 60 -> Typhoon DVB-T Duo Digital/Analog Cardbus [4e42:0502]
+ 61 -> Philips TOUGH DVB-T reference design     [1131:2004]
  62 -> Compro VideoMate TV Gold+II
  63 -> Kworld Xpert TV PVR7134
diff -u linux-2.6.13/Documentation/video4linux/CARDLIST.tuner linux/Documentation/video4linux/CARDLIST.tuner
--- linux-2.6.13/Documentation/video4linux/CARDLIST.tuner	2005-07-06 00:46:33.000000000 -0300
+++ linux/Documentation/video4linux/CARDLIST.tuner	2005-07-07 21:32:26.000000000 -0300
@@ -56,9 +56,9 @@
 tuner=55 - LG PAL (TAPE series)
 tuner=56 - Philips PAL/SECAM multi (FQ1216AME MK4)
 tuner=57 - Philips FQ1236A MK4
-tuner=58 - Ymec TVision TVF-8531MF
+tuner=58 - Ymec TVision TVF-8531MF/8831MF/8731MF
 tuner=59 - Ymec TVision TVF-5533MF
 tuner=60 - Thomson DDT 7611 (ATSC/NTSC)
-tuner=61 - Tena TNF9533-D/IF
+tuner=61 - Tena TNF9533-D/IF/TNF9533-B/DF
 tuner=62 - Philips TEA5767HN FM Radio
 tuner=63 - Philips FMD1216ME MK3 Hybrid Tuner
diff -u linux-2.6.13/Documentation/video4linux/CARDLIST.cx88 linux/Documentation/video4linux/CARDLIST.cx88
--- linux-2.6.13/Documentation/video4linux/CARDLIST.cx88	2005-07-06 00:46:33.000000000 -0300
+++ linux/Documentation/video4linux/CARDLIST.cx88	2005-07-07 21:32:26.000000000 -0300
@@ -27,3 +27,5 @@
 card=26 - IODATA GV/BCTV7E
 card=27 - PixelView PlayTV Ultra Pro (Stereo)
 card=28 - DViCO FusionHDTV 3 Gold-T
+card=29 - ADS Tech Instant TV DVB-T PCI
+card=30 - TerraTec Cinergy 1400 DVB-T

--------------050601090801020403040501--
