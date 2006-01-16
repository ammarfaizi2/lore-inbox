Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932286AbWAPJX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286AbWAPJX6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 04:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbWAPJXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 04:23:35 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:42731 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932268AbWAPJXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 04:23:22 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       akpm@osdl.org, Eric Sesterhenn / snakebyte <snakebyte@gmx.de>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 01/25] Remove old MODULE_PARM in media/video/
Date: Mon, 16 Jan 2006 07:11:19 -0200
Message-id: <20060116091118.PS84223900001@infradead.org>
In-Reply-To: <20060116091105.PS83611600000@infradead.org>
References: <20060116091105.PS83611600000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Eric Sesterhenn / snakebyte <snakebyte@gmx.de>

Changes MODULE_PARM usage to module_param

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/arv.c     |    6 +++---
 drivers/media/video/planb.c   |    4 ++--
 drivers/media/video/saa6588.c |   10 +++++-----
 drivers/media/video/saa711x.c |    2 +-
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/media/video/arv.c b/drivers/media/video/arv.c
index 7d5a068..994b75f 100644
--- a/drivers/media/video/arv.c
+++ b/drivers/media/video/arv.c
@@ -129,9 +129,9 @@ static unsigned char	yuv[MAX_AR_FRAME_BY
 static int freq = DEFAULT_FREQ;	/* BCLK: available 50 or 70 (MHz) */
 static int vga = 0;		/* default mode(0:QVGA mode, other:VGA mode) */
 static int vga_interlace = 0;	/* 0 is normal mode for, else interlace mode */
-MODULE_PARM(freq, "i");
-MODULE_PARM(vga, "i");
-MODULE_PARM(vga_interlace, "i");
+module_param(freq, int, 0);
+module_param(vga, int, 0);
+module_param(vga_interlace, int, 0);
 
 static int ar_initialize(struct video_device *dev);
 
diff --git a/drivers/media/video/planb.c b/drivers/media/video/planb.c
index b19c334..f3fc361 100644
--- a/drivers/media/video/planb.c
+++ b/drivers/media/video/planb.c
@@ -76,9 +76,9 @@ static volatile struct planb_registers *
 static int def_norm = PLANB_DEF_NORM;	/* default norm */
 static int video_nr = -1;
 
-MODULE_PARM(def_norm, "i");
+module_param(def_norm, int, 0);
 MODULE_PARM_DESC(def_norm, "Default startup norm (0=PAL, 1=NTSC, 2=SECAM)");
-MODULE_PARM(video_nr,"i");
+module_param(video_nr, int, 0);
 MODULE_LICENSE("GPL");
 
 
diff --git a/drivers/media/video/saa6588.c b/drivers/media/video/saa6588.c
index e70b17e..d17395c 100644
--- a/drivers/media/video/saa6588.c
+++ b/drivers/media/video/saa6588.c
@@ -50,15 +50,15 @@ static unsigned int rbds = 0;
 static unsigned int plvl = 0;
 static unsigned int bufblocks = 100;
 
-MODULE_PARM(debug, "i");
+module_param(debug, int, 0644);
 MODULE_PARM_DESC(debug, "enable debug messages");
-MODULE_PARM(xtal, "i");
+module_param(xtal, int, 0);
 MODULE_PARM_DESC(xtal, "select oscillator frequency (0..3), default 0");
-MODULE_PARM(rbds, "i");
+module_param(rbds, int, 0);
 MODULE_PARM_DESC(rbds, "select mode, 0=RDS, 1=RBDS, default 0");
-MODULE_PARM(plvl, "i");
+module_param(plvl, int, 0);
 MODULE_PARM_DESC(plvl, "select pause level (0..3), default 0");
-MODULE_PARM(bufblocks, "i");
+module_param(bufblocks, int, 0);
 MODULE_PARM_DESC(bufblocks, "number of buffered blocks, default 100");
 
 MODULE_DESCRIPTION("v4l2 driver module for SAA6588 RDS decoder");
diff --git a/drivers/media/video/saa711x.c b/drivers/media/video/saa711x.c
index ae53063..6c161f2 100644
--- a/drivers/media/video/saa711x.c
+++ b/drivers/media/video/saa711x.c
@@ -52,7 +52,7 @@ MODULE_LICENSE("GPL");
 #include <linux/video_decoder.h>
 
 static int debug = 0;
-MODULE_PARM(debug, "i");
+module_param(debug, int, 0644);
 MODULE_PARM_DESC(debug, " Set the default Debug level.  Default: 0 (Off) - (0-1)");
 
 

