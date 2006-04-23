Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932083AbWDWWRF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbWDWWRF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 18:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932085AbWDWWRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 18:17:04 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:48401 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932083AbWDWWRD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 18:17:03 -0400
Date: Mon, 24 Apr 2006 00:17:01 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] readd the OSS SOUND_CS4232 option
Message-ID: <20060423221701.GJ13666@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A regression in the ALSA driver compared to the OSS driver was reported 
as ALSA bug #1520, so let's keep the OSS driver for now.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 sound/oss/Kconfig |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- devel/sound/oss/Kconfig~update-obsolete_oss_driver-schedule-and-dependencies	2006-03-23 03:20:21.000000000 -0800
+++ devel-akpm/sound/oss/Kconfig	2006-03-23 03:20:23.000000000 -0800
@@ -612,6 +458,20 @@ config SOUND_ACI_MIXER
 
 	  This driver is also available as a module and will be called aci.
 
+config SOUND_CS4232
+	tristate "Crystal CS4232 based (PnP) cards"
+	depends on SOUND_OSS
+	help
+	  Say Y here if you have a card based on the Crystal CS4232 chip set,
+	  which uses its own Plug and Play protocol.
+
+	  If you compile the driver into the kernel, you have to add
+	  "cs4232=<io>,<irq>,<dma>,<dma2>,<mpuio>,<mpuirq>" to the kernel
+	  command line.
+
+	  See <file:Documentation/sound/oss/CS4232> for more information on
+	  configuring this card.
+
 config SOUND_VMIDI
 	tristate "Loopback MIDI device support"
 	depends on SOUND_OSS

