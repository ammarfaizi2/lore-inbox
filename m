Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132986AbRDRDDD>; Tue, 17 Apr 2001 23:03:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132987AbRDRDCx>; Tue, 17 Apr 2001 23:02:53 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:23044 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S132986AbRDRDCo>;
	Tue, 17 Apr 2001 23:02:44 -0400
Date: Tue, 17 Apr 2001 23:03:39 -0400
Message-Id: <200104180303.f3I33dJ12581@snark.thyrsus.com>
From: "Eric S. Raymond" <esr@snark.thyrsus.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@transmeta.com,
        axel@uni-paderborn.de, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Supplying missing entries for Configure.help, part 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch supplies sixteen more missing entries for the
Configure.help file, for a total of 48 so far.  It also corrects some
places where periods are run onto URLs.  It should be applied after my
previous patches 1 and 2 under the same title.  More to come...

--- /home/esr/src/linux/Documentation/Configure.help	2001/04/18 00:55:22	1.3
+++ /home/esr/src/linux/Documentation/Configure.help	2001/04/18 02:58:20
@@ -2575,7 +2575,7 @@
   Find out whether you have ISA slots on your motherboard.  ISA is the 
   name of a bus system, i.e. the way the CPU talks to the other stuff 
   inside your box. Other bus systems are PCI, EISA, Microchannel (MCA) or
-  VESA.  ISA is an older system, now being displaced by PCI; newer boards.
+  VESA.  ISA is an older system, now being displaced by PCI; newer boards
   don't support it.  If you have ISA, say Y, otherwise N. 
 
 PCI support
@@ -2883,7 +2883,7 @@
   interface consists of a system call, but if you say Y to "/proc
   file system support", a tree of modifiable sysctl entries will be
   generated beneath the /proc/sys directory. They are explained in the
-  files in Documentation/sysctl/. Note that enabling this option will
+  files in Documentation/sysctl/ . Note that enabling this option will
   enlarge the kernel by at least 8 KB.
 
   As it is generally a good thing, you should say Y here unless
@@ -3113,6 +3113,26 @@
   hardware found in Acorn RISC PCs and other ARM-based machines.  If
   unsure, say N.
 
+Permedia2 support
+CONFIG_FB_PM2
+  This is the frame buffer device driver for the Permedia2 AGP frame buffer
+  card from ASK, aka `Graphic Blaster Exxtreme'.  There is a product page
+  at http://www.ask.com.hk/product/Permedia%202/permedia2.htm .
+
+Enable FIFO disconnect feature
+CONFIG_FB_PM2_FIFO_DISCONNECT
+  Support the Permedia2 FIFOI disconnect feature (see CONFIG_FB_PM2).
+
+Generic Permedia2 PCI board support
+CONFIG_FB_PM2_PCI
+  Say Y to enable support for Permedia2 AGP frame buffer card from 3Dlabs
+  (aka `Graphic Blaster Exxtreme') on the PCI bus.
+
+Phase5 CVisionPPC/BVisionPPC support
+CONFIG_FB_PM2_CVPPC
+  Say Y to enable support for the Amiga Phase 5 CVisionPPC BVisionPPC
+  framebuffer cards.  Phase 5 is no longer with us, alas.
+
 Amiga native chipset support
 CONFIG_FB_AMIGA
   This is the frame buffer device driver for the builtin graphics
@@ -3208,6 +3228,11 @@
   This is the frame buffer device driver for the builtin graphics
   chipset found in Ataris.
 
+Amiga FrameMaster II/Rainbow II support
+CONFIG_FB_FM2
+  This is the frame buffer device driver for the Amiga FrameMaster
+  card from BSC (exhibited 1992 but not shipped as a CBM product).
+
 Open Firmware frame buffer device support 
 CONFIG_FB_OF
   Say Y if you want support with Open Firmware for your graphics
@@ -3544,11 +3569,46 @@
 CONFIG_FB_CGTHREE
   This is the frame buffer device driver for the CGthree frame buffer.
 
+CGfourteen (SX) support
+CONFIG_FB_CGFOURTEEN
+  This is the frame buffer device driver for the CGfourteen frame buffer
+  on Desktop SPARCsystems with the SX graphics option.
+
+P9100 (Sparcbook 3 only) support
+CONFIG_FB_P9100
+  This is the frame buffer device driver for the P9100 card supported
+  on Sparcbook 3 machines.
+
+Leo (ZX) support
+CONFIG_FB_LEO
+  This is the frame buffer device driver for the SBUS-based Sun ZX (leo)
+  frame buffer cards.  
+
+IGA 168x display support
+CONFIG_FB_IGA
+  This is the framebuffer device for the INTERGRAPHICS 1680 and 
+  successor frame buffer cards.
+
 TCX (SS4/SS5 only) support
 CONFIG_FB_TCX
   This is the frame buffer device driver for the TCX 24/8bit frame
   buffer.
 
+HD64461 Frame Buffer support
+CONFIG_FB_HIT
+  This is the frame buffer device driver for the Hitachi HD64461 LCD frame
+  buffer card.
+
+SIS 630/540 display support
+CONFIG_FB_SIS
+  This is the frame buffer device driver for the SiS 630 and 640 Super
+  Socket 7 UMA cards.  Specs available at http://www.sis.com.tw/ .
+
+IMS Twin Turbo display support
+CONFIG_FB_IMSTT
+  The IMS Twin Turbo is a PCI-based frame buffer card bundled with many
+  Macintosh and compatible computers. 
+
 Virtual Frame Buffer support (ONLY FOR TESTING!)
 CONFIG_FB_VIRTUAL
   This is a `virtual' frame buffer device. It operates on a chunk of
@@ -8332,7 +8392,7 @@
   MultiGate family. Say Y if you have one of these. 
 
   You will need additional firmware to use these cards, which are
-  downloadable from ftp://ftp.itc.hu/.
+  downloadable from ftp://ftp.itc.hu/ .
 
   If you want to compile this as a module, say M and read
   Documentation/modules.txt. The module will be called comx-hw-comx.o.
@@ -8356,7 +8416,7 @@
   configuration. The ISDN interface of this card is Teles 16.3
   compatible, you should enable it in the ISDN configuration menu. The
   driver for the flash ROM of this card is available separately on
-  ftp://ftp.itc.hu/.
+  ftp://ftp.itc.hu/ .
 
   If you want to compile this as a module, say M and read
   Documentation/modules.txt. The module will be called
@@ -8448,7 +8508,7 @@
   Say Y to this option if your Linux box contains a WAN card supported
   by this driver and you are planning to connect the box to a WAN
   ( = Wide Area Network). You will need supporting software from
-  http://hq.pm.waw.pl/hdlc/.
+  http://hq.pm.waw.pl/hdlc/ .
   Generic HDLC driver currently supports raw HDLC, Cisco HDLC, Frame
   Relay, synchronous Point-to-Point Protocol (PPP) and X.25.
 
@@ -14221,6 +14281,12 @@
   The module will be called lightning.o. If you want to compile
   it as a module, say M here and read Documentation/modules.txt.
 
+Crystal SoundFusion gameports
+CONFIG_INPUT_CS461X
+  Say Y here if you have a Cirrus CS461x aka "Crystal SoundFusion" 
+  PCI audio accelerator.  A product page for the CS4614 is at 
+  http://www.cirrus.com/design/products/overview/index.cfm?ProductID=40 .
+
 Aureal Vortex and Trident 4DWave gameports
 CONFIG_INPUT_PCIGAME
   Say Y here if you have a Trident 4DWave DX/NX or Aureal Vortex 1/2
@@ -14387,6 +14453,11 @@
   connected to your computer's serial port. For more information on
   how to use the driver please read Documentation/joystick.txt
 
+Gravis Stinger gamepad
+CONFIG_INPUT_STINGER
+  Say Y here if you have a Gravis Stinger connected to one of your serial
+  ports.  Gravis has a home page at http://www.gravis.com/ .
+
 I-Force joysticks/wheels
 CONFIG_INPUT_IFORCE_232
   Say Y here if you have an I-Force joystick or steering wheel
@@ -16296,6 +16367,16 @@
   If you want to use a GVP IO-Extender serial card in Linux, say Y.
   Otherwise, say N.
 
+GVP IO-Extender parallel printer support
+CONFIG_GVPIOEXT_LP
+  Say Y to enable driving a printer from the parallel port on your 
+  GVP IO-Extender card, N otherwise
+
+GVP IO-Extender PLIP support
+GVPIOEXT_PLIP
+  Say Y to enable doing IP over the parallel port on your  GVP IO-Extender
+  card, N otherwise
+
 Multiface Card III serial support
 CONFIG_MULTIFACE_III_TTY
   If you want to use a Multiface III card's serial port in Linux,
@@ -16536,7 +16617,7 @@
 
   If you are interested in writing a driver for such an audio/video
   device or user software interacting with such a driver, please read
-  the file Documentation/video4linux/API.html.
+  the file Documentation/video4linux/API.html .
 
   This driver is also available as a module called videodev.o ( = code
   which can be inserted in and removed from the running kernel
@@ -17720,7 +17801,7 @@
   a kernel for your specific system, it will be faster and smaller.
 
   To find out what type of IA-64 system you have, you may want to
-  check the IA-64 Linux web site at http://www.linux-ia64.org/.
+  check the IA-64 Linux web site at http://www.linux-ia64.org/ .
   As of the time of this writing, most hardware is DIG compliant,
   so the "DIG-compliant" option is usually the right choice.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

"If I must write the truth, I am disposed to avoid every assembly 
of bishops; for of no synod have I seen a profitable end, but
rather an addition to than a diminution of evils; for the love 
of strife and the thirst for superiority are beyond the power 
of words to express."
	-- Father Gregory Nazianzen, 381 AD
