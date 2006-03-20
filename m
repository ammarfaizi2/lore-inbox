Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964992AbWCTPbg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964992AbWCTPbg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:31:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965005AbWCTP16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:27:58 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:51896 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965316AbWCTP1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:27:49 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Michael Krufky <mkrufky@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 136/141] V4L/DVB (3409): Kconfig: fix in-kernel build for
	cx88-dvb: zl10353 frontend
Date: Mon, 20 Mar 2006 12:08:59 -0300
Message-id: <20060320150859.PS692065000136@infradead.org>
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
Date: 1141146135 -0300

- VIDEO_CX88_DVB_ALL_FRONTENDS should select DVB_ZL10353
- created VIDEO_CX88_DVB_ZL10353, for selective zl10353 support in cx88-dvb.

Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/cx88/Kconfig b/drivers/media/video/cx88/Kconfig
diff --git a/drivers/media/video/cx88/Kconfig b/drivers/media/video/cx88/Kconfig
index e99dfbb..b52a243 100644
--- a/drivers/media/video/cx88/Kconfig
+++ b/drivers/media/video/cx88/Kconfig
@@ -50,6 +50,7 @@ config VIDEO_CX88_DVB_ALL_FRONTENDS
 	depends on VIDEO_CX88_DVB
 	select DVB_MT352
 	select VIDEO_CX88_VP3054
+	select DVB_ZL10353
 	select DVB_OR51132
 	select DVB_CX22702
 	select DVB_LGDT330X
@@ -81,6 +82,16 @@ config VIDEO_CX88_VP3054
 	  which also require support for the VP-3054
 	  Secondary I2C bus, such at DNTV Live! DVB-T Pro.
 
+config VIDEO_CX88_DVB_ZL10353
+	bool "Zarlink ZL10353 DVB-T Support"
+	default y
+	depends on VIDEO_CX88_DVB && !VIDEO_CX88_DVB_ALL_FRONTENDS
+	select DVB_ZL10353
+	---help---
+	  This adds DVB-T support for cards based on the
+	  Connexant 2388x chip and the ZL10353 demodulator,
+	  successor to the Zarlink MT352.
+
 config VIDEO_CX88_DVB_OR51132
 	bool "OR51132 ATSC Support"
 	default y

