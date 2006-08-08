Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030265AbWHHVMy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030265AbWHHVMy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 17:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030263AbWHHVMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 17:12:31 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:51402 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030233AbWHHVM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 17:12:28 -0400
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Luc Van Oostenryck <luc.vanoostenryck@looxix.net>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 04/14] V4L/DVB (4395): Restore compat_ioctl in pwc driver
Date: Tue, 08 Aug 2006 18:06:53 -0300
Message-id: <20060808210653.PS19939700004@infradead.org>
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


From: Luc Van Oostenryck <luc.vanoostenryck@looxix.net>

The compat_ioctl support of the pwc driver was dropped during the last update of the driver.
I suppose it was by mistake. If yes here is the patch to restore the support.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@looxix.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/pwc/pwc-if.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/media/video/pwc/pwc-if.c b/drivers/media/video/pwc/pwc-if.c
index 47d0d83..d470394 100644
--- a/drivers/media/video/pwc/pwc-if.c
+++ b/drivers/media/video/pwc/pwc-if.c
@@ -160,6 +160,7 @@ static struct file_operations pwc_fops =
 	.poll =		pwc_video_poll,
 	.mmap =		pwc_video_mmap,
 	.ioctl =        pwc_video_ioctl,
+	.compat_ioctl = v4l_compat_ioctl32,
 	.llseek =       no_llseek,
 };
 static struct video_device pwc_template = {

