Return-Path: <linux-kernel-owner+w=401wt.eu-S933008AbWL0RL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933008AbWL0RL0 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 12:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932993AbWL0RLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 12:11:25 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:41455 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933008AbWL0RLP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 12:11:15 -0500
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: V4L-DVB Maintainers <v4l-dvb-maintainer@linuxtv.org>,
       Alexey Dobriyan <adobriyan@gmail.com>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 27/28] V4L/DVB (5012): Usbvision fix: It was using "&&"
	instead "&"
Date: Wed, 27 Dec 2006 14:57:32 -0200
Message-id: <20061227165732.PS76773800027@infradead.org>
In-Reply-To: <20061227165016.PS89442900000@infradead.org>
References: <20061227165016.PS89442900000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Alexey Dobriyan <adobriyan@gmail.com>

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/usbvision/usbvision-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/media/video/usbvision/usbvision-core.c b/drivers/media/video/usbvision/usbvision-core.c
index 68542f2..a807d97 100644
--- a/drivers/media/video/usbvision/usbvision-core.c
+++ b/drivers/media/video/usbvision/usbvision-core.c
@@ -2311,7 +2311,7 @@ int usbvision_restart_isoc(struct usb_us
 				  usbvision->Vin_Reg2_Preset)) < 0) return ret;
 
 	/* TODO: schedule timeout */
-	while ((usbvision_read_reg(usbvision, USBVISION_STATUS_REG) && 0x01) != 1);
+	while ((usbvision_read_reg(usbvision, USBVISION_STATUS_REG) & 0x01) != 1);
 
 	return 0;
 }

