Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261584AbVA2W1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261584AbVA2W1i (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 17:27:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261594AbVA2W0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 17:26:05 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:28079 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261585AbVA2WUw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 17:20:52 -0500
Date: Sat, 29 Jan 2005 23:20:48 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] Kconfig: cleanup sound menu
Message-ID: <Pine.LNX.4.61.0501292320430.7666@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This properly indents the sound menu.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 core/Kconfig |    7 ++++++-
 oss/Kconfig  |    8 ++++----
 2 files changed, 10 insertions(+), 5 deletions(-)

Index: linux-2.6.11/sound/oss/Kconfig
===================================================================
--- linux-2.6.11.orig/sound/oss/Kconfig	2005-01-29 22:56:42.549085439 +0100
+++ linux-2.6.11/sound/oss/Kconfig	2005-01-29 22:56:50.842656776 +0100
@@ -880,6 +880,10 @@ config SOUND_SB
 	  You can say M here to compile this driver as a module; the module is
 	  called sb.
 
+config SOUND_KAHLUA
+	tristate "XpressAudio Sound Blaster emulation"
+	depends on SOUND_SB
+
 config SOUND_AWE32_SYNTH
 	tristate "AWE32 synth"
 	depends on SOUND_OSS
@@ -1104,10 +1108,6 @@ config SOUND_TVMIXER
 	  Support for audio mixer facilities on the BT848 TV frame-grabber
 	  card.
 
-config SOUND_KAHLUA
-	tristate "XpressAudio Sound Blaster emulation"
-	depends on SOUND_SB
-
 config SOUND_ALI5455
 	tristate "ALi5455 audio support"
 	depends on SOUND_PRIME!=n && PCI
Index: linux-2.6.11/sound/core/Kconfig
===================================================================
--- linux-2.6.11.orig/sound/core/Kconfig	2005-01-29 22:50:43.345956362 +0100
+++ linux-2.6.11/sound/core/Kconfig	2005-01-29 22:56:50.843656604 +0100
@@ -1,16 +1,20 @@
 # ALSA soundcard-configuration
 config SND_TIMER
 	tristate
+	depends on SND
 
 config SND_PCM
 	tristate
 	select SND_TIMER
+	depends on SND
 
 config SND_HWDEP
 	tristate
+	depends on SND
 
 config SND_RAWMIDI
 	tristate
+	depends on SND
 
 config SND_SEQUENCER
 	tristate "Sequencer support"
@@ -40,6 +44,7 @@ config SND_SEQ_DUMMY
 
 config SND_OSSEMUL
 	bool
+	depends on SND
 
 config SND_MIXER_OSS
 	tristate "OSS Mixer API"
@@ -70,7 +75,7 @@ config SND_PCM_OSS
 
 config SND_SEQUENCER_OSS
 	bool "OSS Sequencer API"
-	depends on SND_SEQUENCER
+	depends on SND && SND_SEQUENCER
 	select SND_OSSEMUL
 	help
 	  Say Y here to enable OSS sequencer emulation (both
