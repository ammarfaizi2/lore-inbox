Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964950AbWAWU3i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964950AbWAWU3i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 15:29:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964955AbWAWU25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 15:28:57 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:45253 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964936AbWAWU21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 15:28:27 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       akpm@osdl.org, Michael Krufky <mkrufky@m1k.net>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 10/16] make VP-3054 Secondary I2C Bus Support a Kconfig
	option.
Date: Mon, 23 Jan 2006 18:24:44 -0200
Message-id: <20060123202444.PS83596100010@infradead.org>
In-Reply-To: <20060123202404.PS66974000000@infradead.org>
References: <20060123202404.PS66974000000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Krufky <mkrufky@m1k.net>

- make VP-3054 Secondary I2C Bus Support a Kconfig option.

Signed-off-by: Michael Krufky <mkrufky@m1k.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/cx88/Kconfig  |   11 +++++++++++
 drivers/media/video/cx88/Makefile |    2 +-
 2 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/drivers/media/video/cx88/Kconfig b/drivers/media/video/cx88/Kconfig
index fdf45f7..e99dfbb 100644
--- a/drivers/media/video/cx88/Kconfig
+++ b/drivers/media/video/cx88/Kconfig
@@ -49,6 +49,7 @@ config VIDEO_CX88_DVB_ALL_FRONTENDS
 	default y
 	depends on VIDEO_CX88_DVB
 	select DVB_MT352
+	select VIDEO_CX88_VP3054
 	select DVB_OR51132
 	select DVB_CX22702
 	select DVB_LGDT330X
@@ -70,6 +71,16 @@ config VIDEO_CX88_DVB_MT352
 	  This adds DVB-T support for cards based on the
 	  Connexant 2388x chip and the MT352 demodulator.
 
+config VIDEO_CX88_VP3054
+	tristate "VP-3054 Secondary I2C Bus Support"
+	default m
+	depends on DVB_MT352
+	---help---
+	  This adds DVB-T support for cards based on the
+	  Connexant 2388x chip and the MT352 demodulator,
+	  which also require support for the VP-3054
+	  Secondary I2C bus, such at DNTV Live! DVB-T Pro.
+
 config VIDEO_CX88_DVB_OR51132
 	bool "OR51132 ATSC Support"
 	default y
diff --git a/drivers/media/video/cx88/Makefile b/drivers/media/video/cx88/Makefile
index 6e5eaa2..e78da88 100644
--- a/drivers/media/video/cx88/Makefile
+++ b/drivers/media/video/cx88/Makefile
@@ -18,6 +18,6 @@ extra-cflags-$(CONFIG_DVB_LGDT330X)  += 
 extra-cflags-$(CONFIG_DVB_MT352)     += -DHAVE_MT352=1
 extra-cflags-$(CONFIG_DVB_NXT200X)   += -DHAVE_NXT200X=1
 extra-cflags-$(CONFIG_DVB_CX24123)   += -DHAVE_CX24123=1
-extra-cflags-$(CONFIG_VIDEO_CX88_DVB)+= -DHAVE_VP3054_I2C=1
+extra-cflags-$(CONFIG_VIDEO_CX88_VP3054)+= -DHAVE_VP3054_I2C=1
 
 EXTRA_CFLAGS += $(extra-cflags-y) $(extra-cflags-m)

