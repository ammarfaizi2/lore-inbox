Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750882AbWDQBDm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882AbWDQBDm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Apr 2006 21:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750885AbWDQBDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Apr 2006 21:03:42 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:26631 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750868AbWDQBDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Apr 2006 21:03:42 -0400
Date: Mon, 17 Apr 2006 03:03:41 +0200
From: Adrian Bunk <bunk@stusta.de>
To: perex@suse.cz
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] sound/pci/: remove duplicate #include's
Message-ID: <20060417010341.GA7429@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's no reason for #include'ing linux/dma-mapping.h more than once.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 sound/pci/ad1889.c           |    1 -
 sound/pci/emu10k1/emu10k1x.c |    1 -
 sound/pci/es1968.c           |    1 -
 sound/pci/ice1712/ice1712.c  |    1 -
 sound/pci/maestro3.c         |    1 -
 sound/pci/mixart/mixart.c    |    1 -
 sound/pci/pcxhr/pcxhr.c      |    1 -
 7 files changed, 7 deletions(-)

--- linux-2.6.17-rc1-mm2-full/sound/pci/ad1889.c.old	2006-04-17 02:51:46.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/sound/pci/ad1889.c	2006-04-17 02:51:55.000000000 +0200
@@ -37,11 +37,10 @@
 #include <linux/dma-mapping.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/compiler.h>
 #include <linux/delay.h>
-#include <linux/dma-mapping.h>
 
 #include <sound/driver.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/initval.h>
--- linux-2.6.17-rc1-mm2-full/sound/pci/emu10k1/emu10k1x.c.old	2006-04-17 02:52:04.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/sound/pci/emu10k1/emu10k1x.c	2006-04-17 02:52:07.000000000 +0200
@@ -34,11 +34,10 @@
 #include <linux/interrupt.h>
 #include <linux/pci.h>
 #include <linux/dma-mapping.h>
 #include <linux/slab.h>
 #include <linux/moduleparam.h>
-#include <linux/dma-mapping.h>
 #include <sound/core.h>
 #include <sound/initval.h>
 #include <sound/pcm.h>
 #include <sound/ac97_codec.h>
 #include <sound/info.h>
--- linux-2.6.17-rc1-mm2-full/sound/pci/es1968.c.old	2006-04-17 02:52:16.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/sound/pci/es1968.c	2006-04-17 02:52:27.000000000 +0200
@@ -102,11 +102,10 @@
 #include <linux/pci.h>
 #include <linux/dma-mapping.h>
 #include <linux/slab.h>
 #include <linux/gameport.h>
 #include <linux/moduleparam.h>
-#include <linux/dma-mapping.h>
 #include <linux/mutex.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/mpu401.h>
--- linux-2.6.17-rc1-mm2-full/sound/pci/ice1712/ice1712.c.old	2006-04-17 02:52:31.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/sound/pci/ice1712/ice1712.c	2006-04-17 02:52:34.000000000 +0200
@@ -54,11 +54,10 @@
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/dma-mapping.h>
 #include <linux/slab.h>
 #include <linux/moduleparam.h>
-#include <linux/dma-mapping.h>
 #include <linux/mutex.h>
 
 #include <sound/core.h>
 #include <sound/cs8427.h>
 #include <sound/info.h>
--- linux-2.6.17-rc1-mm2-full/sound/pci/maestro3.c.old	2006-04-17 02:52:43.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/sound/pci/maestro3.c	2006-04-17 02:52:47.000000000 +0200
@@ -39,11 +39,10 @@
 #include <linux/pci.h>
 #include <linux/dma-mapping.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/moduleparam.h>
-#include <linux/dma-mapping.h>
 #include <sound/core.h>
 #include <sound/info.h>
 #include <sound/control.h>
 #include <sound/pcm.h>
 #include <sound/mpu401.h>
--- linux-2.6.17-rc1-mm2-full/sound/pci/mixart/mixart.c.old	2006-04-17 02:53:06.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/sound/pci/mixart/mixart.c	2006-04-17 02:53:09.000000000 +0200
@@ -26,11 +26,10 @@
 #include <linux/interrupt.h>
 #include <linux/pci.h>
 #include <linux/dma-mapping.h>
 #include <linux/moduleparam.h>
 #include <linux/mutex.h>
-#include <linux/dma-mapping.h>
 
 #include <sound/core.h>
 #include <sound/initval.h>
 #include <sound/info.h>
 #include <sound/control.h>
--- linux-2.6.17-rc1-mm2-full/sound/pci/pcxhr/pcxhr.c.old	2006-04-17 02:53:18.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/sound/pci/pcxhr/pcxhr.c	2006-04-17 02:53:21.000000000 +0200
@@ -28,11 +28,10 @@
 #include <linux/pci.h>
 #include <linux/dma-mapping.h>
 #include <linux/delay.h>
 #include <linux/moduleparam.h>
 #include <linux/mutex.h>
-#include <linux/dma-mapping.h>
 
 #include <sound/core.h>
 #include <sound/initval.h>
 #include <sound/info.h>
 #include <sound/control.h>
