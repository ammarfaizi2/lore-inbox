Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266473AbSKGKS2>; Thu, 7 Nov 2002 05:18:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266475AbSKGKS2>; Thu, 7 Nov 2002 05:18:28 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:49827 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S266473AbSKGKS1>; Thu, 7 Nov 2002 05:18:27 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 7 Nov 2002 11:32:28 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Kernel List <linux-kernel@vger.kernel.org>,
       Trivial Patch Monkey <trivial@rustcorp.com.au>
Subject: [patch] saa7134 build fix
Message-ID: <20021107103228.GA2172@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This patch adds the missing video-buf.o module to the module list if
CONFIG_VIDEO_SAA7134 is enabled.

  Gerd

--- linux-2.5.46/drivers/media/video/Makefile	2002-11-07 09:51:44.000000000 +0100
+++ linux/drivers/media/video/Makefile	2002-11-07 09:51:58.000000000 +0100
@@ -35,7 +35,7 @@
 obj-$(CONFIG_VIDEO_CPIA_PP) += cpia_pp.o
 obj-$(CONFIG_VIDEO_CPIA_USB) += cpia_usb.o
 obj-$(CONFIG_VIDEO_MEYE) += meye.o
-obj-$(CONFIG_VIDEO_SAA7134) += saa7134/ tuner.o tda9887.o
+obj-$(CONFIG_VIDEO_SAA7134) += saa7134/ tuner.o tda9887.o video-buf.o
 obj-$(CONFIG_TUNER_3036) += tuner-3036.o
 
 include $(TOPDIR)/Rules.make

-- 
You can't please everybody.  And usually if you _try_ to please
everybody, the end result is one big mess.
				-- Linus Torvalds, 2002-04-20
