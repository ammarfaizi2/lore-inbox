Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267581AbSLMBcj>; Thu, 12 Dec 2002 20:32:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267584AbSLMBcj>; Thu, 12 Dec 2002 20:32:39 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:22734
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267581AbSLMBci>; Thu, 12 Dec 2002 20:32:38 -0500
Date: Thu, 12 Dec 2002 20:43:11 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][2.5] OSS ad1848 initialisation order
Message-ID: <Pine.LNX.4.50.0212121156260.23467-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I need to initialise the ad1848 driver before attempting attach/probe from
dependent drivers (e.g. opl3sa2)

Please apply,

Index: linux-2.5.51/sound/oss/Makefile
===================================================================
RCS file: /build/cvsroot/linux-2.5.51/sound/oss/Makefile,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 Makefile
--- linux-2.5.51/sound/oss/Makefile	10 Dec 2002 12:48:01 -0000	1.1.1.1
+++ linux-2.5.51/sound/oss/Makefile	12 Dec 2002 07:42:42 -0000
@@ -24,8 +24,8 @@
 obj-$(CONFIG_SOUND_SSCAPE)	+= sscape.o ad1848.o mpu401.o
 obj-$(CONFIG_SOUND_MAD16)	+= mad16.o ad1848.o sb_lib.o uart401.o
 obj-$(CONFIG_SOUND_CS4232)	+= cs4232.o uart401.o
-obj-$(CONFIG_SOUND_OPL3SA2)	+= opl3sa2.o ad1848.o mpu401.o
 obj-$(CONFIG_SOUND_MSS)		+= ad1848.o
+obj-$(CONFIG_SOUND_OPL3SA2)	+= opl3sa2.o ad1848.o mpu401.o
 obj-$(CONFIG_SOUND_PAS)		+= pas2.o sb.o sb_lib.o uart401.o
 obj-$(CONFIG_SOUND_SB)		+= sb.o sb_lib.o uart401.o
 obj-$(CONFIG_SOUND_WAVEFRONT)	+= wavefront.o

-- 
function.linuxpower.ca
