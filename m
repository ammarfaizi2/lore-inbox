Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030263AbWHHVMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030263AbWHHVMz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 17:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030266AbWHHVMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 17:12:54 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:52938 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030233AbWHHVMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 17:12:42 -0400
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 11/14] V4L/DVB (4427): Fix V4L1 Compat for VIDIOCGPICT ioctl
Date: Tue, 08 Aug 2006 18:06:54 -0300
Message-id: <20060808210654.PS37751400011@infradead.org>
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


From: Mauro Carvalho Chehab <mchehab@infradead.org>

Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/v4l1-compat.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/media/video/v4l1-compat.c b/drivers/media/video/v4l1-compat.c
index d83a2c8..d7c3fcb 100644
--- a/drivers/media/video/v4l1-compat.c
+++ b/drivers/media/video/v4l1-compat.c
@@ -599,6 +599,10 @@ v4l_compat_translate_ioctl(struct inode 
 			dprintk("VIDIOCGPICT / VIDIOC_G_FMT: %d\n",err);
 			break;
 		}
+
+		pict->depth   = ((fmt2->fmt.pix.bytesperline<<3)
+				 + (fmt2->fmt.pix.width-1) )
+				 /fmt2->fmt.pix.width;
 		pict->palette = pixelformat_to_palette(
 			fmt2->fmt.pix.pixelformat);
 		break;

