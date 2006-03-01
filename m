Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932350AbWCAO7u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbWCAO7u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 09:59:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932394AbWCAO7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 09:59:49 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:29092 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932393AbWCAO7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 09:59:48 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Hans Verkuil <hverkuil@xs4all.nl>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 08/13] Fix maximum for the saturation and contrast controls.
Date: Wed, 01 Mar 2006 09:05:39 -0300
Message-id: <20060301120539.PS03281500008@infradead.org>
In-Reply-To: <20060301120529.PS80375900000@infradead.org>
References: <20060301120529.PS80375900000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Hans Verkuil <hverkuil@xs4all.nl>
Date: 1141009700 \-0300

Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/cx25840/cx25840-core.c |    4 ++--
 drivers/media/video/saa7115.c              |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/video/cx25840/cx25840-core.c b/drivers/media/video/cx25840/cx25840-core.c
index 08ffd1f..5588b9a 100644
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
index 048d000..ffd87ce 100644
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

