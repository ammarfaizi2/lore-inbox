Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932314AbWIJRKQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbWIJRKQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 13:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932321AbWIJRJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 13:09:59 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:51686 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932314AbWIJRJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 13:09:43 -0400
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 6/6] V4L/DVB (4608c): Fix I2C dependencies for saa7146
	modules
Date: Sun, 10 Sep 2006 14:06:45 -0300
Message-id: <20060910170645.PS9018750006@infradead.org>
In-Reply-To: <20060910170419.PS3030230000@infradead.org>
References: <20060910170419.PS3030230000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.92-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Mauro Carvalho Chehab <mchehab@infradead.org>

Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/Kconfig |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/video/Kconfig b/drivers/media/video/Kconfig
index 732bf1e..94d078b 100644
--- a/drivers/media/video/Kconfig
+++ b/drivers/media/video/Kconfig
@@ -260,7 +260,7 @@ source "drivers/media/video/saa7134/Kcon
 
 config VIDEO_MXB
 	tristate "Siemens-Nixdorf 'Multimedia eXtension Board'"
-	depends on PCI && VIDEO_V4L1
+	depends on PCI && VIDEO_V4L1 && I2C
 	select VIDEO_SAA7146_VV
 	select VIDEO_TUNER
 	---help---
@@ -272,7 +272,7 @@ config VIDEO_MXB
 
 config VIDEO_DPC
 	tristate "Philips-Semiconductors 'dpc7146 demonstration board'"
-	depends on PCI && VIDEO_V4L1
+	depends on PCI && VIDEO_V4L1 && I2C
 	select VIDEO_SAA7146_VV
 	select VIDEO_V4L2
 	---help---
@@ -287,7 +287,7 @@ config VIDEO_DPC
 
 config VIDEO_HEXIUM_ORION
 	tristate "Hexium HV-PCI6 and Orion frame grabber"
-	depends on PCI && VIDEO_V4L1
+	depends on PCI && VIDEO_V4L1 && I2C
 	select VIDEO_SAA7146_VV
 	select VIDEO_V4L2
 	---help---
@@ -299,7 +299,7 @@ config VIDEO_HEXIUM_ORION
 
 config VIDEO_HEXIUM_GEMINI
 	tristate "Hexium Gemini frame grabber"
-	depends on PCI && VIDEO_V4L1
+	depends on PCI && VIDEO_V4L1 && I2C
 	select VIDEO_SAA7146_VV
 	select VIDEO_V4L2
 	---help---

