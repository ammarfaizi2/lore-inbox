Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030242AbWHHVO0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030242AbWHHVO0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 17:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030266AbWHHVOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 17:14:23 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:58570 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030273AbWHHVNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 17:13:43 -0400
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Trent Piepho <xyzzy@speakeasy.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 07/14] V4L/DVB (4411): Fix minor errors in build files
Date: Tue, 08 Aug 2006 18:06:53 -0300
Message-id: <20060808210653.PS71259900007@infradead.org>
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


From: Trent Piepho <xyzzy@speakeasy.org>

In pwc Kconfig, change 'depends' to 'depends on'
In dvb-core Makefile, change '=' to ':='

Signed-off-by: Trent Piepho <xyzzy@speakeasy.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/dvb/dvb-core/Makefile |    6 +++---
 drivers/media/video/pwc/Kconfig     |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/dvb/dvb-core/Makefile b/drivers/media/dvb/dvb-core/Makefile
index 1105465..0b51828 100644
--- a/drivers/media/dvb/dvb-core/Makefile
+++ b/drivers/media/dvb/dvb-core/Makefile
@@ -2,8 +2,8 @@ #
 # Makefile for the kernel DVB device drivers.
 #
 
-dvb-core-objs = dvbdev.o dmxdev.o dvb_demux.o dvb_filter.o 	\
-		dvb_ca_en50221.o dvb_frontend.o 		\
-		dvb_net.o dvb_ringbuffer.o dvb_math.o
+dvb-core-objs := dvbdev.o dmxdev.o dvb_demux.o dvb_filter.o 	\
+		 dvb_ca_en50221.o dvb_frontend.o 		\
+		 dvb_net.o dvb_ringbuffer.o dvb_math.o
 
 obj-$(CONFIG_DVB_CORE) += dvb-core.o
diff --git a/drivers/media/video/pwc/Kconfig b/drivers/media/video/pwc/Kconfig
index 697145e..8fdf710 100644
--- a/drivers/media/video/pwc/Kconfig
+++ b/drivers/media/video/pwc/Kconfig
@@ -30,7 +30,7 @@ config USB_PWC
 
 config USB_PWC_DEBUG
 	bool "USB Philips Cameras verbose debug"
-	depends USB_PWC
+	depends on USB_PWC
 	help
 	  Say Y here in order to have the pwc driver generate verbose debugging
 	  messages.

