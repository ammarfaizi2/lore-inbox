Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932192AbWCQU5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbWCQU5J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 15:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932769AbWCQU5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 15:57:08 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:64682 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932763AbWCQU5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 15:57:04 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Michael Krufky <mkrufky@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 16/21] Kconfig: swap VIDEO_CX88_ALSA and VIDEO_CX88_DVB
Date: Fri, 17 Mar 2006 17:54:37 -0300
Message-id: <20060317205437.PS38148600016@infradead.org>
In-Reply-To: <20060317205359.PS65198900000@infradead.org>
References: <20060317205359.PS65198900000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Michael Krufky <mkrufky@linuxtv.org>
Date: 1142400973 \-0300

VIDEO_CX88_ALSA should not be between
VIDEO_CX88_DVB and VIDEO_CX88_DVB_ALL_FRONTENDS
When cx88-alsa was added to cx88/Kconfig, it was
added in between VIDEO_CX88_DVB and
VIDEO_CX88_DVB_ALL_FRONTENDS.  This caused
undesireable effects to the appearance of the menu
options in menuconfig.
This fix reorders cx88-alsa and cx88-dvb in Kconfig,
to match saa7134, and restore the correct menuconfig
appearance.

Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/cx88/Kconfig |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/media/video/cx88/Kconfig b/drivers/media/video/cx88/Kconfig
index e99dfbb..87d79df 100644
--- a/drivers/media/video/cx88/Kconfig
+++ b/drivers/media/video/cx88/Kconfig
@@ -15,20 +15,6 @@ config VIDEO_CX88
 	  To compile this driver as a module, choose M here: the
 	  module will be called cx8800
 
-config VIDEO_CX88_DVB
-	tristate "DVB/ATSC Support for cx2388x based TV cards"
-	depends on VIDEO_CX88 && DVB_CORE
-	select VIDEO_BUF_DVB
-	---help---
-	  This adds support for DVB/ATSC cards based on the
-	  Connexant 2388x chip.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called cx88-dvb.
-
-	  You must also select one or more DVB/ATSC demodulators.
-	  If you are unsure which you need, choose all of them.
-
 config VIDEO_CX88_ALSA
 	tristate "ALSA DMA audio support"
 	depends on VIDEO_CX88 && SND && EXPERIMENTAL
@@ -44,6 +30,20 @@ config VIDEO_CX88_ALSA
 	  To compile this driver as a module, choose M here: the
 	  module will be called cx88-alsa.
 
+config VIDEO_CX88_DVB
+	tristate "DVB/ATSC Support for cx2388x based TV cards"
+	depends on VIDEO_CX88 && DVB_CORE
+	select VIDEO_BUF_DVB
+	---help---
+	  This adds support for DVB/ATSC cards based on the
+	  Connexant 2388x chip.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called cx88-dvb.
+
+	  You must also select one or more DVB/ATSC demodulators.
+	  If you are unsure which you need, choose all of them.
+
 config VIDEO_CX88_DVB_ALL_FRONTENDS
 	bool "Build all supported frontends for cx2388x based TV cards"
 	default y

