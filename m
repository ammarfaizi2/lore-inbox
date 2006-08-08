Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030286AbWHHVOW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030286AbWHHVOW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 17:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030242AbWHHVNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 17:13:38 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:57034 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030233AbWHHVNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 17:13:14 -0400
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 03/14] V4L/DVB (4371b): Fix V4L1 dependencies at drivers
	under sound/oss and sound/pci
Date: Tue, 08 Aug 2006 18:06:53 -0300
Message-id: <20060808210653.PS04143800003@infradead.org>
In-Reply-To: <20060808210151.PS78629800000@infradead.org>
References: <20060808210151.PS78629800000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.2.1-4mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Mauro Carvalho Chehab <mchehab@infradead.org>

TVMixer and FM801 Tea5757 are still using V4L1 API. 

Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 sound/oss/Kconfig |    6 ++---
 sound/pci/Kconfig |   70 +++++++++++++++++++++++++++--------------------------
 2 files changed, 39 insertions(+), 37 deletions(-)

diff --git a/sound/oss/Kconfig b/sound/oss/Kconfig
index f4980ca..1b7c3df 100644
--- a/sound/oss/Kconfig
+++ b/sound/oss/Kconfig
@@ -31,7 +31,7 @@ config SOUND_EMU10K1
 	  For more information on this driver and the degree of support for
 	  the different card models please check:
 
-	        <http://sourceforge.net/projects/emu10k1/>
+		<http://sourceforge.net/projects/emu10k1/>
 
 	  It is now possible to load dsp microcode patches into the EMU10K1
 	  chip.  These patches are used to implement real time sound
@@ -140,7 +140,7 @@ config SOUND_TRIDENT
 	  system support" and "Sysctl support", and after the /proc file
 	  system has been mounted, executing the command
 
-	  	command			what is enabled
+		command			what is enabled
 
 	  echo 0>/proc/ALi5451	pcm out is also set to S/PDIF out. (Default).
 
@@ -838,7 +838,7 @@ config SOUND_WAVEARTIST
 
 config SOUND_TVMIXER
 	tristate "TV card (bt848) mixer support"
-	depends on SOUND_PRIME && I2C
+	depends on SOUND_PRIME && I2C && VIDEO_V4L1
 	help
 	  Support for audio mixer facilities on the BT848 TV frame-grabber
 	  card.
diff --git a/sound/pci/Kconfig b/sound/pci/Kconfig
index d7ad32f..e49c0fe 100644
--- a/sound/pci/Kconfig
+++ b/sound/pci/Kconfig
@@ -16,16 +16,16 @@ config SND_AD1889
 	  will be called snd-ad1889.
 
 config SND_ALS300
-        tristate "Avance Logic ALS300/ALS300+"
-        depends on SND
-        select SND_PCM
-        select SND_AC97_CODEC
-        select SND_OPL3_LIB
-        help
-          Say 'Y' or 'M' to include support for Avance Logic ALS300/ALS300+
+	tristate "Avance Logic ALS300/ALS300+"
+	depends on SND
+	select SND_PCM
+	select SND_AC97_CODEC
+	select SND_OPL3_LIB
+	help
+	  Say 'Y' or 'M' to include support for Avance Logic ALS300/ALS300+
 
-          To compile this driver as a module, choose M here: the module
-          will be called snd-als300
+	  To compile this driver as a module, choose M here: the module
+	  will be called snd-als300
 
 config SND_ALS4000
 	tristate "Avance Logic ALS4000"
@@ -78,49 +78,49 @@ config SND_ATIIXP_MODEM
 	  will be called snd-atiixp-modem.
 
 config SND_AU8810
-        tristate "Aureal Advantage"
-        depends on SND
+	tristate "Aureal Advantage"
+	depends on SND
 	select SND_MPU401_UART
 	select SND_AC97_CODEC
-        help
+	help
 	  Say Y here to include support for Aureal Advantage soundcards.
 
 	  Supported features: Hardware Mixer, SRC, EQ and SPDIF output.
-          3D support code is in place, but not yet useable. For more info, 
-          email the ALSA developer list, or <mjander@users.sourceforge.net>.
+	  3D support code is in place, but not yet useable. For more info,
+	  email the ALSA developer list, or <mjander@users.sourceforge.net>.
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-au8810.
- 
+
 config SND_AU8820
-        tristate "Aureal Vortex"
-        depends on SND
+	tristate "Aureal Vortex"
+	depends on SND
 	select SND_MPU401_UART
 	select SND_AC97_CODEC
-        help
+	help
 	  Say Y here to include support for Aureal Vortex soundcards.
 
-          Supported features: Hardware Mixer and SRC. For more info, email 
-          the ALSA developer list, or <mjander@users.sourceforge.net>.
+	  Supported features: Hardware Mixer and SRC. For more info, email
+	  the ALSA developer list, or <mjander@users.sourceforge.net>.
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-au8820.
- 
+
 config SND_AU8830
-        tristate "Aureal Vortex 2"
-        depends on SND
+	tristate "Aureal Vortex 2"
+	depends on SND
 	select SND_MPU401_UART
 	select SND_AC97_CODEC
-        help
+	help
 	  Say Y here to include support for Aureal Vortex 2 soundcards.
 
-          Supported features: Hardware Mixer, SRC, EQ and SPDIF output.
-          3D support code is in place, but not yet useable. For more info, 
-          email the ALSA developer list, or <mjander@users.sourceforge.net>.
+	  Supported features: Hardware Mixer, SRC, EQ and SPDIF output.
+	  3D support code is in place, but not yet useable. For more info,
+	  email the ALSA developer list, or <mjander@users.sourceforge.net>.
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-au8830.
- 
+
 config SND_AZT3328
 	tristate "Aztech AZF3328 / PCI168 (EXPERIMENTAL)"
 	depends on SND && EXPERIMENTAL
@@ -135,10 +135,10 @@ config SND_AZT3328
 	  will be called snd-azt3328.
 
 config SND_BT87X
-        tristate "Bt87x Audio Capture"
-        depends on SND
+	tristate "Bt87x Audio Capture"
+	depends on SND
 	select SND_PCM
-        help
+	help
 	  If you want to record audio from TV cards based on
 	  Brooktree Bt878/Bt879 chips, say Y here and read
 	  <file:Documentation/sound/alsa/Bt87x.txt>.
@@ -209,7 +209,7 @@ config SND_CS46XX
 config SND_CS46XX_NEW_DSP
 	bool "Cirrus Logic (Sound Fusion) New DSP support"
 	depends on SND_CS46XX
-        default y
+	default y
 	help
 	  Say Y here to use a new DSP image for SPDIF and dual codecs.
 
@@ -225,7 +225,7 @@ config SND_CS5535AUDIO
 	  referred to as NS CS5535 IO or AMD CS5535 IO companion in
 	  various literature. This driver also supports the CS5536 audio
 	  device. However, for both chips, on certain boards, you may
-	  need to use ac97_quirk=hp_only if your board has physically 
+	  need to use ac97_quirk=hp_only if your board has physically
 	  mapped headphone out to master output. If that works for you,
 	  send lspci -vvv output to the mailing list so that your board
 	  can be identified in the quirks list.
@@ -468,11 +468,13 @@ config SND_FM801_TEA575X_BOOL
 	  FM801 chip with a TEA5757 tuner connected to GPIO1-3 pins (Media
 	  Forte SF256-PCS-02) into the snd-fm801 driver.
 
+	  This will enable support for the old V4L1 API.
+
 config SND_FM801_TEA575X
 	tristate
 	depends on SND_FM801_TEA575X_BOOL
 	default SND_FM801
-	select VIDEO_DEV
+	select VIDEO_V4L1
 
 config SND_HDA_INTEL
 	tristate "Intel HD Audio"

