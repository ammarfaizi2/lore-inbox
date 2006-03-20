Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965758AbWCTQH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965758AbWCTQH1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 11:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965761AbWCTQHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 11:07:25 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:29592 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S966365AbWCTPPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:15:13 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Hans Verkuil <hverkuil@xs4all.nl>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 095/141] V4L/DVB (3354): Fix maximum for the saturation and
	contrast controls.
Date: Mon, 20 Mar 2006 12:08:52 -0300
Message-id: <20060320150852.PS851296000095@infradead.org>
In-Reply-To: <20060320150819.PS760228000000@infradead.org>
References: <20060320150819.PS760228000000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Verkuil <hverkuil@xs4all.nl>
Date: 1141009700 -0300

Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/cx25840/cx25840-core.c b/drivers/media/video/cx25840/cx25840-core.c
diff --git a/drivers/media/video/cx25840/cx25840-core.c b/drivers/media/video/cx25840/cx25840-core.c
index 8d8aa8e..8a25797 100644
--- a/drivers/media/video/cx25840/cx25840-core.c
+++ b/drivers/media/video/cx25840/cx25840-core.c
@@ -567,7 +567,7 @@ static struct v4l2_queryctrl cx25840_qct
 		.type          = V4L2_CTRL_TYPE_INTEGER,
 		.name          = "Contrast",
 		.minimum       = 0,
-		.maximum       = 255,
+		.maximum       = 127,
 		.step          = 1,
 		.default_value = 64,
 		.flags         = 0,
@@ -576,7 +576,7 @@ static struct v4l2_queryctrl cx25840_qct
 		.type          = V4L2_CTRL_TYPE_INTEGER,
 		.name          = "Saturation",
 		.minimum       = 0,
-		.maximum       = 255,
+		.maximum       = 127,
 		.step          = 1,
 		.default_value = 64,
 		.flags         = 0,
diff --git a/drivers/media/video/saa7115.c b/drivers/media/video/saa7115.c
diff --git a/drivers/media/video/saa7115.c b/drivers/media/video/saa7115.c
index 487a429..f0eb985 100644
--- a/drivers/media/video/saa7115.c
+++ b/drivers/media/video/saa7115.c
@@ -1027,7 +1027,7 @@ static struct v4l2_queryctrl saa7115_qct
 		.type          = V4L2_CTRL_TYPE_INTEGER,
 		.name          = "Contrast",
 		.minimum       = 0,
-		.maximum       = 255,
+		.maximum       = 127,
 		.step          = 1,
 		.default_value = 64,
 		.flags         = 0,
@@ -1036,7 +1036,7 @@ static struct v4l2_queryctrl saa7115_qct
 		.type          = V4L2_CTRL_TYPE_INTEGER,
 		.name          = "Saturation",
 		.minimum       = 0,
-		.maximum       = 255,
+		.maximum       = 127,
 		.step          = 1,
 		.default_value = 64,
 		.flags         = 0,

