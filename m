Return-Path: <linux-kernel-owner+w=401wt.eu-S932991AbWL0RLY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932991AbWL0RLY (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 12:11:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932933AbWL0RKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 12:10:49 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:41429 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933001AbWL0RKS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 12:10:18 -0500
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: V4L-DVB Maintainers <v4l-dvb-maintainer@linuxtv.org>,
       Hans Verkuil <hverkuil@xs4all.nl>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 08/28] V4L/DVB (4968): Add PAL-60 support for cx2584x.
Date: Wed, 27 Dec 2006 14:57:28 -0200
Message-id: <20061227165728.PS49134400008@infradead.org>
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


From: Hans Verkuil <hverkuil@xs4all.nl>

Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/cx25840/cx25840-vbi.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/media/video/cx25840/cx25840-vbi.c b/drivers/media/video/cx25840/cx25840-vbi.c
index f85f208..ced13fe 100644
--- a/drivers/media/video/cx25840/cx25840-vbi.c
+++ b/drivers/media/video/cx25840/cx25840-vbi.c
@@ -128,7 +128,14 @@ void cx25840_vbi_setup(struct i2c_client
 		uv_lpf=1;
 
 		src_decimation=0x21f;
-		if (std == V4L2_STD_PAL_M) {
+		if (std == V4L2_STD_PAL_60) {
+			vblank=26;
+			vblank656=26;
+			burst=0x5b;
+			luma_lpf=2;
+			comb=0x20;
+			sc=0x0a8263;
+		} else if (std == V4L2_STD_PAL_M) {
 			vblank=20;
 			vblank656=24;
 			burst=0x61;

