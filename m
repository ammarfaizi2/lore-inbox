Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965155AbWCTPNM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965155AbWCTPNM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966231AbWCTPNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:13:12 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:64482 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965155AbWCTPNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:13:11 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Michael Krufky <mkrufky@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 083/141] V4L/DVB (3335): Fix in-kernel build
Date: Mon, 20 Mar 2006 12:08:50 -0300
Message-id: <20060320150850.PS881408000083@infradead.org>
In-Reply-To: <20060320150819.PS760228000000@infradead.org>
References: <20060320150819.PS760228000000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Krufky <mkrufky@linuxtv.org>
Date: 1141009663 -0300

- remove tuner.ko build dependency on xc3028.o , which will be added again later.
- fix the following build error when using the "make kernel-links" build method to
  symlink the latest code from the v4l-dvb repository into the kernel source:
drivers/media/video/xc3028.c:31:20: em28xx.h: No such file or directory
drivers/media/video/xc3028.c: In function `xc3028_init':
drivers/media/video/xc3028.c:120: error: dereferencing pointer to incomplete type
drivers/media/video/xc3028.c:121: error: dereferencing pointer to incomplete type
drivers/media/video/xc3028.c:139: error: dereferencing pointer to incomplete type
drivers/media/video/xc3028.c:140: error: dereferencing pointer to incomplete type
make[3]: *** [drivers/media/video/xc3028.o] Error 1

Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/Makefile b/drivers/media/video/Makefile
diff --git a/drivers/media/video/Makefile b/drivers/media/video/Makefile
index 60e9c6e..faf7283 100644
--- a/drivers/media/video/Makefile
+++ b/drivers/media/video/Makefile
@@ -9,7 +9,7 @@ zoran-objs      :=	zr36120.o zr36120_i2c
 zr36067-objs	:=	zoran_procfs.o zoran_device.o \
 			zoran_driver.o zoran_card.o
 tuner-objs	:=	tuner-core.o tuner-types.o tuner-simple.o \
-			mt20xx.o tda8290.o tea5767.o xc3028.o
+			mt20xx.o tda8290.o tea5767.o
 
 msp3400-objs	:=	msp3400-driver.o msp3400-kthreads.o
 

