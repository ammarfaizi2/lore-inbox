Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751464AbWF1Q5G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbWF1Q5G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 12:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbWF1Q45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 12:56:57 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:46596 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751459AbWF1Qz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 12:55:28 -0400
Date: Wed, 28 Jun 2006 18:55:27 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] re-add CONFIG_SOUND_SSCAPE
Message-ID: <20060628165527.GH13915@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Due to a regression in the correcponding ALSA driver (ALSA #2234), the 
OSS driver should stay until it's fixed.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.17-mm3-full/sound/oss/Kconfig.old	2006-06-28 00:26:25.000000000 +0200
+++ linux-2.6.17-mm3-full/sound/oss/Kconfig	2006-06-28 00:33:41.000000000 +0200
@@ -493,6 +493,19 @@
 	  See <file:Documentation/sound/oss/CS4232> for more information on
 	  configuring this card.
 
+config SOUND_SSCAPE
+	tristate "Ensoniq SoundScape support"
+	depends on SOUND_OSS
+	help
+	  Answer Y if you have a sound card based on the Ensoniq SoundScape
+	  chipset. Such cards are being manufactured at least by Ensoniq, Spea
+	  and Reveal (Reveal makes also other cards).
+
+	  If you compile the driver into the kernel, you have to add
+	  "sscape=<io>,<irq>,<dma>,<mpuio>,<mpuirq>" to the kernel command
+	  line.
+
+
 config SOUND_VMIDI
 	tristate "Loopback MIDI device support"
 	depends on SOUND_OSS

