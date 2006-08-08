Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030203AbWHHVLr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030203AbWHHVLr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 17:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030207AbWHHVLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 17:11:47 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:48330 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030233AbWHHVLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 17:11:45 -0400
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 14/14] V4L/DVB (4485): Fix a warning on PPC64
Date: Tue, 08 Aug 2006 18:06:55 -0300
Message-id: <20060808210654.PS88745600014@infradead.org>
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

drivers/media/video/pvrusb2/pvrusb2-i2c-cmd-v4l2.c: In function 'set_standard':
drivers/media/video/pvrusb2/pvrusb2-i2c-cmd-v4l2.c:33: warning: format '%llx' expects type 'long long unsigned int', but argument 2 has type 'v4l2_std_id'

Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/pvrusb2/pvrusb2-i2c-cmd-v4l2.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/media/video/pvrusb2/pvrusb2-i2c-cmd-v4l2.c b/drivers/media/video/pvrusb2/pvrusb2-i2c-cmd-v4l2.c
index 8a9933d..05ea17a 100644
--- a/drivers/media/video/pvrusb2/pvrusb2-i2c-cmd-v4l2.c
+++ b/drivers/media/video/pvrusb2/pvrusb2-i2c-cmd-v4l2.c
@@ -31,7 +31,7 @@ static void set_standard(struct pvr2_hdw
 	v4l2_std_id vs;
 	vs = hdw->std_mask_cur;
 	pvr2_trace(PVR2_TRACE_CHIPS,
-		   "i2c v4l2 set_standard(0x%llx)",(__u64)vs);
+		   "i2c v4l2 set_standard(0x%llx)",(long long unsigned)vs);
 
 	pvr2_i2c_core_cmd(hdw,VIDIOC_S_STD,&vs);
 }

