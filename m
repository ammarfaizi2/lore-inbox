Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030207AbWHHVMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030207AbWHHVMK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 17:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030212AbWHHVMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 17:12:10 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:49354 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030207AbWHHVMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 17:12:00 -0400
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Hans Verkuil <hverkuil@xs4all.nl>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 10/14] V4L/DVB (4419): Turn on the Low Noise Amplifier of
	the Samsung tuners.
Date: Tue, 08 Aug 2006 18:06:54 -0300
Message-id: <20060808210654.PS21465100010@infradead.org>
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


From: Hans Verkuil <hverkuil@xs4all.nl>

Without the LNA these tuners perform very poorly (read 'unwatchable') when
the signal is weak.

Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/tuner-types.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/media/video/tuner-types.c b/drivers/media/video/tuner-types.c
index a167e17..d7eadc2 100644
--- a/drivers/media/video/tuner-types.c
+++ b/drivers/media/video/tuner-types.c
@@ -1027,10 +1027,11 @@ static struct tuner_params tuner_tnf_533
 /* 70-79 */
 /* ------------ TUNER_SAMSUNG_TCPN_2121P30A - Samsung NTSC ------------ */
 
+/* '+ 4' turns on the Low Noise Amplifier */
 static struct tuner_range tuner_samsung_tcpn_2121p30a_ntsc_ranges[] = {
-	{ 16 * 130.00 /*MHz*/, 0xce, 0x01, },
-	{ 16 * 364.50 /*MHz*/, 0xce, 0x02, },
-	{ 16 * 999.99        , 0xce, 0x08, },
+	{ 16 * 130.00 /*MHz*/, 0xce, 0x01 + 4, },
+	{ 16 * 364.50 /*MHz*/, 0xce, 0x02 + 4, },
+	{ 16 * 999.99        , 0xce, 0x08 + 4, },
 };
 
 static struct tuner_params tuner_samsung_tcpn_2121p30a_params[] = {
@@ -1060,10 +1061,11 @@ static struct tuner_params tuner_thomson
 
 /* ------------ TUNER_SAMSUNG_TCPG_6121P30A - Samsung PAL ------------ */
 
+/* '+ 4' turns on the Low Noise Amplifier */
 static struct tuner_range tuner_samsung_tcpg_6121p30a_pal_ranges[] = {
-	{ 16 * 146.25 /*MHz*/, 0xce, 0x01, },
-	{ 16 * 428.50 /*MHz*/, 0xce, 0x02, },
-	{ 16 * 999.99        , 0xce, 0x08, },
+	{ 16 * 146.25 /*MHz*/, 0xce, 0x01 + 4, },
+	{ 16 * 428.50 /*MHz*/, 0xce, 0x02 + 4, },
+	{ 16 * 999.99        , 0xce, 0x08 + 4, },
 };
 
 static struct tuner_params tuner_samsung_tcpg_6121p30a_params[] = {

