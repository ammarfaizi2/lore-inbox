Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261574AbSKTQ7y>; Wed, 20 Nov 2002 11:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261582AbSKTQ7y>; Wed, 20 Nov 2002 11:59:54 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:44738 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S261574AbSKTQ7r>; Wed, 20 Nov 2002 11:59:47 -0500
Date: Wed, 20 Nov 2002 18:06:46 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [2.5 patch] fixes for sound/oss/Kconfig
Message-ID: <20021120170645.GC11952@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below includes the following fixes for sound/oss/Kconfig:

- MSNDCLAS_HAVE_BOOT are MSNDPIN_HAVE_BOOT questions that should be
  asked, not variables that get set automatically

- s|Documentation/sound|Documentation/sound/oss|g


Please apply
Adrian


--- l/sound/oss/Kconfig.old	2002-11-20 17:56:08.000000000 +0100
+++ l/sound/oss/Kconfig	2002-11-20 17:59:31.000000000 +0100
@@ -156,7 +156,7 @@
 	  1274:5000. Since Ensoniq was bought by Creative Labs,
 	  Sound Blaster 64/PCI models are either ES1370 or ES1371 based.
 	  This driver differs slightly from OSS/Free, so PLEASE READ
-	  <file:Documentation/sound/es1370>.
+	  <file:Documentation/sound/oss/es1370>.
 
 config SOUND_ES1371
 	tristate "Creative Ensoniq AudioPCI 97 (ES1371)"
@@ -180,7 +180,7 @@
 	  Solo1 chip without removing your computer's cover, use
 	  lspci -n and look for the PCI ID 125D:1969. This driver
 	  differs slightly from OSS/Free, so PLEASE READ
-	  <file:Documentation/sound/solo1>.
+	  <file:Documentation/sound/oss/solo1>.
 
 config SOUND_MAESTRO
 	tristate "ESS Maestro, Maestro2, Maestro2E driver"
@@ -188,7 +188,7 @@
 	help
 	  Say Y or M if you have a sound system driven by ESS's Maestro line
 	  of PCI sound chips.  These include the Maestro 1, Maestro 2, and
-	  Maestro 2E.  See <file:Documentation/sound/Maestro> for more
+	  Maestro 2E.  See <file:Documentation/sound/oss/Maestro> for more
 	  details.
 
 config SOUND_MAESTRO3
@@ -221,7 +221,7 @@
 	  SonicVibes chip without removing your computer's cover, use
 	  lspci -n and look for the PCI ID 5333:CA00. This driver
 	  differs slightly from OSS/Free, so PLEASE READ
-	  <file:Documentation/sound/sonicvibes>.
+	  <file:Documentation/sound/oss/sonicvibes>.
 
 config SOUND_VWSND
 	tristate "SGI Visual Workstation Sound"
@@ -229,7 +229,7 @@
 	help
 	  Say Y or M if you have an SGI Visual Workstation and you want to be
 	  able to use its on-board audio.  Read
-	  <file:Documentation/sound/vwsnd> for more info on this driver's
+	  <file:Documentation/sound/oss/vwsnd> for more info on this driver's
 	  capabilities.
 
 config SOUND_VRC5477
@@ -284,7 +284,7 @@
 	  Say M here if you have a Turtle Beach MultiSound Classic, Tahiti or
 	  Monterey (not for the Pinnacle or Fiji).
 
-	  See <file:Documentation/sound/MultiSound> for important information
+	  See <file:Documentation/sound/oss/MultiSound> for important information
 	  about this driver.  Note that it has been discontinued, but the
 	  Voyetra Turtle Beach knowledge base entry for it is still available
 	  at <http://www.voyetra-turtle-beach.com/site/kb_ftp/790.asp>.
@@ -293,7 +293,7 @@
 	depends on SOUND_PRIME && SOUND_MSNDCLAS=y
 
 config MSNDCLAS_HAVE_BOOT
-	bool
+	bool "Have MSNDINIT.BIN firmware file"
 	depends on SOUND_MSNDCLAS=y
 	default y
 
@@ -305,7 +305,7 @@
 	  The MultiSound cards have two firmware files which are required for
 	  operation, and are not currently included. These files can be
 	  obtained from Turtle Beach. See
-	  <file:Documentation/sound/MultiSound> for information on how to
+	  <file:Documentation/sound/oss/MultiSound> for information on how to
 	  obtain this.
 
 config MSNDCLAS_PERM_FILE
@@ -316,7 +316,7 @@
 	  The MultiSound cards have two firmware files which are required for
 	  operation, and are not currently included. These files can be
 	  obtained from Turtle Beach. See
-	  <file:Documentation/sound/MultiSound> for information on how to
+	  <file:Documentation/sound/oss/MultiSound> for information on how to
 	  obtain this.
 
 config MSNDCLAS_IRQ
@@ -346,7 +346,7 @@
 	depends on SOUND_PRIME!=n && SOUND
 	help
 	  Say M here if you have a Turtle Beach MultiSound Pinnacle or Fiji.
-	  See <file:Documentation/sound/MultiSound> for important information
+	  See <file:Documentation/sound/oss/MultiSound> for important information
 	  about this driver. Note that it has been discontinued, but the
 	  Voyetra Turtle Beach knowledge base entry for it is still available
 	  at <http://www.voyetra-turtle-beach.com/site/kb_ftp/600.asp>.
@@ -355,7 +355,7 @@
 	depends on SOUND_PRIME && SOUND_MSNDPIN=y
 
 config MSNDPIN_HAVE_BOOT
-	bool
+	bool "Have PNDSPINI.BIN firmware file"
 	depends on SOUND_MSNDPIN=y
 	default y
 
@@ -367,7 +367,7 @@
 	  The MultiSound cards have two firmware files which are required
 	  for operation, and are not currently included. These files can be
 	  obtained from Turtle Beach. See
-	  <file:Documentation/sound/MultiSound> for information on how to
+	  <file:Documentation/sound/oss/MultiSound> for information on how to
 	  obtain this.
 
 config MSNDPIN_PERM_FILE
@@ -378,7 +378,7 @@
 	  The MultiSound cards have two firmware files which are required for
 	  operation, and are not currently included. These files can be
 	  obtained from Turtle Beach. See
-	  <file:Documentation/sound/MultiSound> for information on how to
+	  <file:Documentation/sound/oss/MultiSound> for information on how to
 	  obtain this.
 
 config MSNDPIN_IRQ
@@ -412,7 +412,7 @@
 	  If you have the S/PDIF daughter board for the Pinnacle or Fiji,
 	  answer Y here; otherwise, say N. If you have this, you will be able
 	  to play and record from the S/PDIF port (digital signal). See
-	  <file:Documentation/sound/MultiSound> for information on how to make
+	  <file:Documentation/sound/oss/MultiSound> for information on how to make
 	  use of this capability.
 
 config MSNDPIN_NONPNP
@@ -613,7 +613,7 @@
 	  "cs4232=<io>,<irq>,<dma>,<dma2>,<mpuio>,<mpuirq>" to the kernel
 	  command line.
 
-	  See <file:Documentation/sound/CS4232> for more information on
+	  See <file:Documentation/sound/oss/CS4232> for more information on
 	  configuring this card.
 
 config SOUND_SSCAPE
@@ -633,7 +633,7 @@
 	depends on SOUND_OSS
 	help
 	  Say Y here for any type of Gravis Ultrasound card, including the GUS
-	  or GUS MAX.  See also <file:Documentation/sound/ultrasound> for more
+	  or GUS MAX.  See also <file:Documentation/sound/oss/ultrasound> for more
 	  information on configuring this card with modules.
 
 	  If you compile the driver into the kernel, you have to add
@@ -706,7 +706,7 @@
 	  synthesizers (OPL2, OPL3 and OPL4), 6850 UART MIDI Interface.
 
 	  For cards having native support in VoxWare, consult the card
-	  specific instructions in <file:Documentation/sound/README.OSS>.
+	  specific instructions in <file:Documentation/sound/oss/README.OSS>.
 	  Some drivers have their own MSS support and saying Y to this option
 	  will cause a conflict.
 
@@ -724,7 +724,7 @@
 	  will cause a conflict.  Also, enabling MPU401 on a system that
 	  doesn't really have a MPU401 could cause some trouble.  If your card
 	  was in the list of supported cards, look at the card specific
-	  instructions in the <file:Documentation/sound/README.OSS> file.  It
+	  instructions in the <file:Documentation/sound/oss/README.OSS> file.  It
 	  is safe to answer Y if you have a true MPU401 MIDI interface card.
 
 	  If you compile the driver into the kernel, you have to add
@@ -740,7 +740,7 @@
 	  laptops. It includes support for an AC97-compatible mixer and an
 	  apparently proprietary sound engine.
 
-	  See <file:Documentation/sound/NM256> for further information.
+	  See <file:Documentation/sound/oss/NM256> for further information.
 
 config SOUND_MAD16
 	tristate "OPTi MAD16 and/or Mozart based cards"
@@ -759,8 +759,8 @@
 	  "mad16=<io>,<irq>,<dma>,<dma2>,<mpuio>,<mpuirq>" to the
 	  kernel command line.
 
-	  See also <file:Documentation/sound/Opti> and
-	  <file:Documentation/sound/MAD16> for more information on setting
+	  See also <file:Documentation/sound/oss/Opti> and
+	  <file:Documentation/sound/oss/MAD16> for more information on setting
 	  these cards up as modules.
 
 config MAD16_OLDCARD
@@ -778,7 +778,7 @@
 	  Answer Y only if you have a Pro Audio Spectrum 16, ProAudio Studio
 	  16 or Logitech SoundMan 16 sound card. Answer N if you have some
 	  other card made by Media Vision or Logitech since those are not
-	  PAS16 compatible. Please read <file:Documentation/sound/PAS16>.
+	  PAS16 compatible. Please read <file:Documentation/sound/oss/PAS16>.
 	  It is not necessary to add Sound Blaster support separately; it
 	  is included in PAS support.
 
@@ -801,7 +801,7 @@
 	  ADSP-16 or some other card based on the PSS chipset (AD1848 codec +
 	  ADSP-2115 DSP chip + Echo ESC614 ASIC CHIP). For more information on
 	  how to compile it into the kernel or as a module see the file
-	  <file:Documentation/sound/PSS>.
+	  <file:Documentation/sound/oss/PSS>.
 
 	  If you compile the driver into the kernel, you have to add
 	  "pss=<io>,<mssio>,<mssirq>,<mssdma>,<mpuio>,<mpuirq>" to the kernel
@@ -818,7 +818,7 @@
 
 	  If you said M to "PSS support" above, you may enable or disable this
 	  PSS mixer with the module parameter pss_mixer. For more information
-	  see the file <file:Documentation/sound/PSS>.
+	  see the file <file:Documentation/sound/oss/PSS>.
 
 config PSS_HAVE_BOOT
 	bool "Have DSPxxx.LD firmware file"
@@ -845,16 +845,16 @@
 	  SM Games). For an unknown card you may answer Y if the card claims
 	  to be Sound Blaster-compatible.
 
-	  Please read the file <file:Documentation/sound/Soundblaster>.
+	  Please read the file <file:Documentation/sound/oss/Soundblaster>.
 
 	  You should also say Y here for cards based on the Avance Logic
-	  ALS-007 and ALS-1X0 chips (read <file:Documentation/sound/ALS>) and
+	  ALS-007 and ALS-1X0 chips (read <file:Documentation/sound/oss/ALS>) and
 	  for cards based on ESS chips (read
-	  <file:Documentation/sound/ESS1868> and
-	  <file:Documentation/sound/ESS>). If you have an SB AWE 32 or SB AWE
+	  <file:Documentation/sound/oss/ESS1868> and
+	  <file:Documentation/sound/oss/ESS>). If you have an SB AWE 32 or SB AWE
 	  64, say Y here and also to "AWE32 synth" below and read
-	  <file:Documentation/sound/INSTALL.awe>. If you have an IBM Mwave
-	  card, say Y here and read <file:Documentation/sound/mwave>.
+	  <file:Documentation/sound/oss/INSTALL.awe>. If you have an IBM Mwave
+	  card, say Y here and read <file:Documentation/sound/oss/mwave>.
 
 	  If you compile the driver into the kernel and don't want to use
 	  isapnp, you have to add "sb=<io>,<irq>,<dma>,<dma2>" to the kernel
@@ -868,8 +868,8 @@
 	depends on SOUND_OSS
 	help
 	  Say Y here if you have a Sound Blaster SB32, AWE32-PnP, SB AWE64 or
-	  similar sound card. See <file:Documentation/sound/README.awe>,
-	  <file:Documentation/sound/AWE32> and the Soundblaster-AWE
+	  similar sound card. See <file:Documentation/sound/oss/README.awe>,
+	  <file:Documentation/sound/oss/AWE32> and the Soundblaster-AWE
 	  mini-HOWTO, available from <http://www.linuxdoc.org/docs.html#howto>
 	  for more info.
 
@@ -878,8 +878,8 @@
 	depends on SOUND_OSS && m
 	help
 	  Answer Y or M if you have a Tropez Plus, Tropez or Maui sound card
-	  and read the files <file:Documentation/sound/Wavefront> and
-	  <file:Documentation/sound/Tropez+>.
+	  and read the files <file:Documentation/sound/oss/Wavefront> and
+	  <file:Documentation/sound/oss/Tropez+>.
 
 config SOUND_MAUI
 	tristate "Limited support for Turtle Beach Wave Front (Maui, Tropez) synthesizers"
@@ -916,7 +916,7 @@
 	  cards may have software (TSR) FM emulation. Enabling FM support with
 	  these cards may cause trouble (I don't currently know of any such
 	  cards, however). Please read the file
-	  <file:Documentation/sound/OPL3> if your card has an OPL3 chip.
+	  <file:Documentation/sound/oss/OPL3> if your card has an OPL3 chip.
 
 	  If you compile the driver into the kernel, you have to add
 	  "opl3=<io>" to the kernel command line.
@@ -929,7 +929,7 @@
 	help
 	  Say Y or M if you have a Yamaha OPL3-SA1 sound chip, which is
 	  usually built into motherboards. Read
-	  <file:Documentation/sound/OPL3-SA> for details.
+	  <file:Documentation/sound/oss/OPL3-SA> for details.
 
 	  If you compile the driver into the kernel, you have to add
 	  "opl3sa=<io>,<irq>,<dma>,<dma2>,<mpuio>,<mpuirq>" to the kernel
@@ -941,7 +941,7 @@
 	help
 	  Say Y or M if you have a card based on one of these Yamaha sound
 	  chipsets or the "SAx", which is actually a SA3. Read
-	  <file:Documentation/sound/OPL3-SA2> for more information on
+	  <file:Documentation/sound/oss/OPL3-SA2> for more information on
 	  configuring these cards.
 
 	  If you compile the driver into the kernel and do not also
@@ -989,9 +989,9 @@
 	  accordingly. You should say Y to one and only one of these two
 	  questions.
 
-	  Read the <file:Documentation/sound/README.OSS> file and the head of
+	  Read the <file:Documentation/sound/oss/README.OSS> file and the head of
 	  <file:drivers/sound/aedsp16.c> as well as
-	  <file:Documentation/sound/AudioExcelDSP16> to get more information
+	  <file:Documentation/sound/oss/AudioExcelDSP16> to get more information
 	  about this driver and its configuration.
 
 config SC6600
