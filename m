Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030219AbWHHVLS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030219AbWHHVLS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 17:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030212AbWHHVLS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 17:11:18 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:45514 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030263AbWHHVLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 17:11:16 -0400
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Diego Calleja <diegocg@gmail.com>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 12/14] V4L/DVB (4430): Quickcam_messenger compilation fix
Date: Tue, 08 Aug 2006 18:06:54 -0300
Message-id: <20060808210654.PS54412700012@infradead.org>
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


From: Diego Calleja <diegocg@gmail.com>

In bugzilla #6943, Maxim Britov reported:
"I can enable Logitech quickcam support in .config, but it want be compile.
I have to add into drivers/media/video/Makefile:
obj-$(CONFIG_USB_QUICKCAM_MESSENGER)    += usbvideo/"
He's right, just enable that driver as module while disabling every other
driver that gets into that directory, nothing will get compiled.
This patch fixes the Makefile.

Signed-off-by: Diego Calleja <diegocg@gmail.com>
Acked-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/media/video/Makefile b/drivers/media/video/Makefile
index 010833d..e82e511 100644
--- a/drivers/media/video/Makefile
+++ b/drivers/media/video/Makefile
@@ -90,6 +90,7 @@ obj-$(CONFIG_USB_ZC0301)        += zc030
 obj-$(CONFIG_USB_IBMCAM)        += usbvideo/
 obj-$(CONFIG_USB_KONICAWC)      += usbvideo/
 obj-$(CONFIG_USB_VICAM)         += usbvideo/
+obj-$(CONFIG_USB_QUICKCAM_MESSENGER)	+= usbvideo/
 
 obj-$(CONFIG_VIDEO_VIVI) += vivi.o
 

