Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932772AbWCQU4p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932772AbWCQU4p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 15:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932768AbWCQU4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 15:56:34 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:60586 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030199AbWCQU43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 15:56:29 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Michael Krufky <mkrufky@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 19/21] Cpia2: move Kconfig build logic into cpia2/Kconfig
Date: Fri, 17 Mar 2006 17:54:38 -0300
Message-id: <20060317205438.PS34586400019@infradead.org>
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
Date: 1142308340 \-0300

Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/Kconfig       |    2 ++
 drivers/media/video/cpia2/Kconfig |    9 +++++++++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/media/video/Kconfig b/drivers/media/video/Kconfig
index 995f033..ee0eed4 100644
--- a/drivers/media/video/Kconfig
+++ b/drivers/media/video/Kconfig
@@ -142,6 +142,8 @@ config VIDEO_CPIA_USB
 	  otherwise say N. This will not work with the Creative Webcam III.
 	  It is also available as a module (cpia_usb).
 
+source "drivers/media/video/cpia2/Kconfig"
+
 config VIDEO_SAA5246A
 	tristate "SAA5246A, SAA5281 Teletext processor"
 	depends on VIDEO_DEV && I2C
diff --git a/drivers/media/video/cpia2/Kconfig b/drivers/media/video/cpia2/Kconfig
new file mode 100644
index 0000000..1c09ef9
--- /dev/null
+++ b/drivers/media/video/cpia2/Kconfig
@@ -0,0 +1,9 @@
+config VIDEO_CPIA2
+	tristate "CPiA2 Video For Linux"
+	depends on VIDEO_DEV
+	---help---
+	  This is the video4linux driver for cameras based on Vision's CPiA2
+	  (Colour Processor Interface ASIC), such as the Digital Blue QX5
+	  Microscope. If you have one of these cameras, say Y here
+
+	  This driver is also available as a module (cpia2).

