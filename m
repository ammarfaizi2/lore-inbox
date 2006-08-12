Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964908AbWHLRB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964908AbWHLRB6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 13:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964907AbWHLRBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 13:01:35 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:37421 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964901AbWHLRBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 13:01:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=sQmv62TGTWU3+YpgMOlGOTsQ9Q/i+U3eWSX9zxxVESnxJKVuXvvq1gYBy2iI0hnjV8kvUoV9O53nL5BF2ERgzi6LT0B5FratQNHMYtKubeVmCQjgpUED+kX3eeZT0kMwldwmg77QFYZwa/0Rq9YOIM78bCFpBfxVwhp/GQJSBX0=
Message-ID: <44DE0989.1030608@gmail.com>
Date: Sat, 12 Aug 2006 19:02:01 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
CC: Andrew Morton <akpm@osdl.org>,
       Thomas Winischhofer <thomas@winischhofer.net>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH 6/10] drivers/video/sis/sis_accel.h Removal of old
 code
References: <44DE05FC.2090001@gmail.com>
In-Reply-To: <44DE05FC.2090001@gmail.com>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/video/sis/sis_accel.h linux-work/drivers/video/sis/sis_accel.h
--- linux-work-clean/drivers/video/sis/sis_accel.h	2006-03-20 06:53:29.000000000 +0100
+++ linux-work/drivers/video/sis/sis_accel.h	2006-08-12 18:14:37.000000000 +0200
@@ -390,25 +390,11 @@
 	MMIO_OUT32(ivideo->mmio_vbase, FIRE_TRIGGER, 0); \
 	CmdQueLen -= 2;

-
 int  sisfb_initaccel(struct sis_video_info *ivideo);
 void sisfb_syncaccel(struct sis_video_info *ivideo);

-#if LINUX_VERSION_CODE <= KERNEL_VERSION(2,5,33)
-void fbcon_sis_bmove(struct display *p, int srcy, int srcx, int dsty,
-			int dstx, int height, int width);
-void fbcon_sis_revc(struct display *p, int srcy, int srcx);
-void fbcon_sis_clear8(struct vc_data *conp, struct display *p, int srcy,
-			int srcx, int height, int width);
-void fbcon_sis_clear16(struct vc_data *conp, struct display *p, int srcy,
-			int srcx, int height, int width);
-void fbcon_sis_clear32(struct vc_data *conp, struct display *p, int srcy,
-			int srcx, int height, int width);
-#endif
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,34)
 int  fbcon_sis_sync(struct fb_info *info);
 void fbcon_sis_fillrect(struct fb_info *info, const struct fb_fillrect *rect);
 void fbcon_sis_copyarea(struct fb_info *info, const struct fb_copyarea *area);
-#endif

-#endif
+#endif



