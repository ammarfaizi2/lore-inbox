Return-Path: <linux-kernel-owner+w=401wt.eu-S933006AbWL0RJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933006AbWL0RJ4 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 12:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933002AbWL0RJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 12:09:55 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:41414 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932996AbWL0RJl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 12:09:41 -0500
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: V4L-DVB Maintainers <v4l-dvb-maintainer@linuxtv.org>,
       Hans Verkuil <hverkuil@xs4all.nl>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 07/28] V4L/DVB (4967): Add missing tuner module option
	pal=60 for PAL-60 support.
Date: Wed, 27 Dec 2006 14:57:28 -0200
Message-id: <20061227165728.PS25871000007@infradead.org>
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

 drivers/media/video/tuner-core.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/media/video/tuner-core.c b/drivers/media/video/tuner-core.c
index 705daaa..ee4a493 100644
--- a/drivers/media/video/tuner-core.c
+++ b/drivers/media/video/tuner-core.c
@@ -267,6 +267,10 @@ static int tuner_fixup_std(struct tuner 
 {
 	if ((t->std & V4L2_STD_PAL) == V4L2_STD_PAL) {
 		switch (pal[0]) {
+		case '6':
+			tuner_dbg ("insmod fixup: PAL => PAL-60\n");
+			t->std = V4L2_STD_PAL_60;
+			break;
 		case 'b':
 		case 'B':
 		case 'g':

