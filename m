Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965012AbWCTPde@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965012AbWCTPde (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965306AbWCTP0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:26:49 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:33976 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965274AbWCTP0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:26:07 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Michael Krufky <mkrufky@m1k.net>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 035/141] V4L/DVB (3439): removed duplicated tuner_ranges
Date: Mon, 20 Mar 2006 12:08:42 -0300
Message-id: <20060320150842.PS851137000035@infradead.org>
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

From: Michael Krufky <mkrufky@m1k.net>
Date: 1138043471 -0200

- removed duplicated tuner_ranges

Signed-off-by: Michael Krufky <mkrufky@m1k.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/tuner-types.c b/drivers/media/video/tuner-types.c
diff --git a/drivers/media/video/tuner-types.c b/drivers/media/video/tuner-types.c
index d37f833..f77584d 100644
--- a/drivers/media/video/tuner-types.c
+++ b/drivers/media/video/tuner-types.c
@@ -229,7 +229,7 @@ static struct tuner_params tuner_alps_ts
 
 /* ------------ TUNER_TEMIC_4006FH5_PAL - TEMIC PAL ------------ */
 
-static struct tuner_range tuner_temic_4006fh5_pal_ranges[] = {
+static struct tuner_range tuner_lg_pal_ranges[] = {
 	{ 16 * 170.00 /*MHz*/, 0x8e, 0xa0, },
 	{ 16 * 450.00 /*MHz*/, 0x8e, 0x90, },
 	{ 16 * 999.99        , 0x8e, 0x30, },
@@ -238,8 +238,8 @@ static struct tuner_range tuner_temic_40
 static struct tuner_params tuner_temic_4006fh5_params[] = {
 	{
 		.type   = TUNER_PARAM_TYPE_PAL,
-		.ranges = tuner_temic_4006fh5_pal_ranges,
-		.count  = ARRAY_SIZE(tuner_temic_4006fh5_pal_ranges),
+		.ranges = tuner_lg_pal_ranges,
+		.count  = ARRAY_SIZE(tuner_lg_pal_ranges),
 	},
 };
 
@@ -336,7 +336,7 @@ static struct tuner_params tuner_temic_4
 
 /* ------------ TUNER_TEMIC_4039FR5_NTSC - TEMIC NTSC ------------ */
 
-static struct tuner_range tuner_temic_4039fr5_ntsc_ranges[] = {
+static struct tuner_range tuner_temic_4x3x_f_5_ntsc_ranges[] = {
 	{ 16 * 158.00 /*MHz*/, 0x8e, 0xa0, },
 	{ 16 * 453.00 /*MHz*/, 0x8e, 0x90, },
 	{ 16 * 999.99        , 0x8e, 0x30, },
@@ -345,35 +345,23 @@ static struct tuner_range tuner_temic_40
 static struct tuner_params tuner_temic_4039fr5_params[] = {
 	{
 		.type   = TUNER_PARAM_TYPE_NTSC,
-		.ranges = tuner_temic_4039fr5_ntsc_ranges,
-		.count  = ARRAY_SIZE(tuner_temic_4039fr5_ntsc_ranges),
+		.ranges = tuner_temic_4x3x_f_5_ntsc_ranges,
+		.count  = ARRAY_SIZE(tuner_temic_4x3x_f_5_ntsc_ranges),
 	},
 };
 
 /* ------------ TUNER_TEMIC_4046FM5 - TEMIC PAL ------------ */
 
-static struct tuner_range tuner_temic_4046fm5_pal_ranges[] = {
-	{ 16 * 169.00 /*MHz*/, 0x8e, 0xa0, },
-	{ 16 * 454.00 /*MHz*/, 0x8e, 0x90, },
-	{ 16 * 999.99        , 0x8e, 0x30, },
-};
-
 static struct tuner_params tuner_temic_4046fm5_params[] = {
 	{
 		.type   = TUNER_PARAM_TYPE_PAL,
-		.ranges = tuner_temic_4046fm5_pal_ranges,
-		.count  = ARRAY_SIZE(tuner_temic_4046fm5_pal_ranges),
+		.ranges = tuner_temic_40x6f_5_pal_ranges,
+		.count  = ARRAY_SIZE(tuner_temic_40x6f_5_pal_ranges),
 	},
 };
 
 /* ------------ TUNER_PHILIPS_PAL_DK - Philips PAL ------------ */
 
-static struct tuner_range tuner_lg_pal_ranges[] = {
-	{ 16 * 170.00 /*MHz*/, 0x8e, 0xa0, },
-	{ 16 * 450.00 /*MHz*/, 0x8e, 0x90, },
-	{ 16 * 999.99        , 0x8e, 0x30, },
-};
-
 static struct tuner_params tuner_philips_pal_dk_params[] = {
 	{
 		.type   = TUNER_PARAM_TYPE_PAL,
@@ -503,33 +491,21 @@ static struct tuner_params tuner_temic_4
 
 /* ------------ TUNER_TEMIC_4012FY5 - TEMIC PAL ------------ */
 
-static struct tuner_range tuner_temic_4012fy5_pal_ranges[] = {
-	{ 16 * 140.25 /*MHz*/, 0x8e, 0x02, },
-	{ 16 * 463.25 /*MHz*/, 0x8e, 0x04, },
-	{ 16 * 999.99        , 0x8e, 0x01, },
-};
-
 static struct tuner_params tuner_temic_4012fy5_params[] = {
 	{
 		.type   = TUNER_PARAM_TYPE_PAL,
-		.ranges = tuner_temic_4012fy5_pal_ranges,
-		.count  = ARRAY_SIZE(tuner_temic_4012fy5_pal_ranges),
+		.ranges = tuner_temic_pal_ranges,
+		.count  = ARRAY_SIZE(tuner_temic_pal_ranges),
 	},
 };
 
 /* ------------ TUNER_TEMIC_4136FY5 - TEMIC NTSC ------------ */
 
-static struct tuner_range tuner_temic_4136_fy5_ntsc_ranges[] = {
-	{ 16 * 158.00 /*MHz*/, 0x8e, 0xa0, },
-	{ 16 * 453.00 /*MHz*/, 0x8e, 0x90, },
-	{ 16 * 999.99        , 0x8e, 0x30, },
-};
-
 static struct tuner_params tuner_temic_4136_fy5_params[] = {
 	{
 		.type   = TUNER_PARAM_TYPE_NTSC,
-		.ranges = tuner_temic_4136_fy5_ntsc_ranges,
-		.count  = ARRAY_SIZE(tuner_temic_4136_fy5_ntsc_ranges),
+		.ranges = tuner_temic_4x3x_f_5_ntsc_ranges,
+		.count  = ARRAY_SIZE(tuner_temic_4x3x_f_5_ntsc_ranges),
 	},
 };
 
@@ -638,17 +614,11 @@ static struct tuner_params tuner_fm1236_
 
 /* ------------ TUNER_PHILIPS_4IN1 - Philips NTSC ------------ */
 
-static struct tuner_range tuner_philips_4in1_ntsc_ranges[] = {
-	{ 16 * 160.00 /*MHz*/, 0x8e, 0x01, },
-	{ 16 * 442.00 /*MHz*/, 0x8e, 0x02, },
-	{ 16 * 999.99        , 0x8e, 0x04, },
-};
-
 static struct tuner_params tuner_philips_4in1_params[] = {
 	{
 		.type   = TUNER_PARAM_TYPE_NTSC,
-		.ranges = tuner_philips_4in1_ntsc_ranges,
-		.count  = ARRAY_SIZE(tuner_philips_4in1_ntsc_ranges),
+		.ranges = tuner_fm1236_mk3_ntsc_ranges,
+		.count  = ARRAY_SIZE(tuner_fm1236_mk3_ntsc_ranges),
 	},
 };
 
@@ -680,17 +650,11 @@ static struct tuner_params tuner_panason
 
 /* ------------ TUNER_LG_NTSC_TAPE - LGINNOTEK NTSC ------------ */
 
-static struct tuner_range tuner_lg_ntsc_tape_ranges[] = {
-	{ 16 * 160.00 /*MHz*/, 0x8e, 0x01, },
-	{ 16 * 442.00 /*MHz*/, 0x8e, 0x02, },
-	{ 16 * 999.99        , 0x8e, 0x04, },
-};
-
 static struct tuner_params tuner_lg_ntsc_tape_params[] = {
 	{
 		.type   = TUNER_PARAM_TYPE_NTSC,
-		.ranges = tuner_lg_ntsc_tape_ranges,
-		.count  = ARRAY_SIZE(tuner_lg_ntsc_tape_ranges),
+		.ranges = tuner_fm1236_mk3_ntsc_ranges,
+		.count  = ARRAY_SIZE(tuner_fm1236_mk3_ntsc_ranges),
 	},
 };
 
@@ -746,17 +710,11 @@ static struct tuner_params tuner_tcl_200
 
 /* ------------ TUNER_PHILIPS_FM1256_IH3 - Philips PAL ------------ */
 
-static struct tuner_range tuner_philips_fm1256_ih3_pal_ranges[] = {
-	{ 16 * 160.00 /*MHz*/, 0x8e, 0x01, },
-	{ 16 * 442.00 /*MHz*/, 0x8e, 0x02, },
-	{ 16 * 999.99        , 0x8e, 0x04, },
-};
-
 static struct tuner_params tuner_philips_fm1256_ih3_params[] = {
 	{
 		.type   = TUNER_PARAM_TYPE_PAL,
-		.ranges = tuner_philips_fm1256_ih3_pal_ranges,
-		.count  = ARRAY_SIZE(tuner_philips_fm1256_ih3_pal_ranges),
+		.ranges = tuner_fm1236_mk3_ntsc_ranges,
+		.count  = ARRAY_SIZE(tuner_fm1236_mk3_ntsc_ranges),
 	},
 };
 
@@ -826,33 +784,21 @@ static struct tuner_params tuner_philips
 
 /* ------------ TUNER_PHILIPS_FQ1236A_MK4 - Philips NTSC ------------ */
 
-static struct tuner_range tuner_philips_fq12_6a___mk4_ntsc_ranges[] = {
-	{ 16 * 160.00 /*MHz*/, 0x8e, 0x01, },
-	{ 16 * 442.00 /*MHz*/, 0x8e, 0x02, },
-	{ 16 * 999.99        , 0x8e, 0x04, },
-};
-
 static struct tuner_params tuner_philips_fq1236a_mk4_params[] = {
 	{
 		.type   = TUNER_PARAM_TYPE_NTSC,
-		.ranges = tuner_philips_fq12_6a___mk4_ntsc_ranges,
-		.count  = ARRAY_SIZE(tuner_philips_fq12_6a___mk4_ntsc_ranges),
+		.ranges = tuner_fm1236_mk3_ntsc_ranges,
+		.count  = ARRAY_SIZE(tuner_fm1236_mk3_ntsc_ranges),
 	},
 };
 
 /* ------------ TUNER_YMEC_TVF_8531MF - Philips NTSC ------------ */
 
-static struct tuner_range tuner_ymec_tvf_8531mf_ntsc_ranges[] = {
-	{ 16 * 160.00 /*MHz*/, 0x8e, 0xa0, },
-	{ 16 * 454.00 /*MHz*/, 0x8e, 0x90, },
-	{ 16 * 999.99        , 0x8e, 0x30, },
-};
-
 static struct tuner_params tuner_ymec_tvf_8531mf_params[] = {
 	{
 		.type   = TUNER_PARAM_TYPE_NTSC,
-		.ranges = tuner_ymec_tvf_8531mf_ntsc_ranges,
-		.count  = ARRAY_SIZE(tuner_ymec_tvf_8531mf_ntsc_ranges),
+		.ranges = tuner_philips_ntsc_m_ranges,
+		.count  = ARRAY_SIZE(tuner_philips_ntsc_m_ranges),
 	},
 };
 
@@ -893,7 +839,7 @@ static struct tuner_params tuner_thomson
 
 /* ------------ TUNER_TENA_9533_DI - Philips PAL ------------ */
 
-static struct tuner_range tuner_tuner_tena_9533_di_pal_ranges[] = {
+static struct tuner_range tuner_tena_9533_di_pal_ranges[] = {
 	{ 16 * 160.25 /*MHz*/, 0x8e, 0x01, },
 	{ 16 * 464.25 /*MHz*/, 0x8e, 0x02, },
 	{ 16 * 999.99        , 0x8e, 0x04, },
@@ -902,8 +848,8 @@ static struct tuner_range tuner_tuner_te
 static struct tuner_params tuner_tena_9533_di_params[] = {
 	{
 		.type   = TUNER_PARAM_TYPE_PAL,
-		.ranges = tuner_tuner_tena_9533_di_pal_ranges,
-		.count  = ARRAY_SIZE(tuner_tuner_tena_9533_di_pal_ranges),
+		.ranges = tuner_tena_9533_di_pal_ranges,
+		.count  = ARRAY_SIZE(tuner_tena_9533_di_pal_ranges),
 	},
 };
 
@@ -916,7 +862,7 @@ static struct tuner_range tuner_philips_
 };
 
 
-static struct tuner_params tuner_tuner_philips_fmd1216me_mk3_params[] = {
+static struct tuner_params tuner_philips_fmd1216me_mk3_params[] = {
 	{
 		.type   = TUNER_PARAM_TYPE_PAL,
 		.ranges = tuner_philips_fmd1216me_mk3_pal_ranges,
@@ -944,17 +890,11 @@ static struct tuner_params tuner_tua6034
 
 /* ------------ TUNER_YMEC_TVF66T5_B_DFF - Philips PAL ------------ */
 
-static struct tuner_range tuner_ymec_tvf66t5_b_dff_pal_ranges[] = {
-	{ 16 * 160.25 /*MHz*/, 0x8e, 0x01, },
-	{ 16 * 464.25 /*MHz*/, 0x8e, 0x02, },
-	{ 16 * 999.99        , 0x8e, 0x08, },
-};
-
 static struct tuner_params tuner_ymec_tvf66t5_b_dff_params[] = {
 	{
 		.type   = TUNER_PARAM_TYPE_PAL,
-		.ranges = tuner_ymec_tvf66t5_b_dff_pal_ranges,
-		.count  = ARRAY_SIZE(tuner_ymec_tvf66t5_b_dff_pal_ranges),
+		.ranges = tuner_tena_9533_di_pal_ranges,
+		.count  = ARRAY_SIZE(tuner_tena_9533_di_pal_ranges),
 	},
 };
 
@@ -999,7 +939,7 @@ static struct tuner_range tuner_tuv1236d
 };
 
 
-static struct tuner_params tuner_tuner_tuv1236d_params[] = {
+static struct tuner_params tuner_tuv1236d_params[] = {
 	{
 		.type   = TUNER_PARAM_TYPE_NTSC,
 		.ranges = tuner_tuv1236d_ntsc_ranges,
@@ -1308,7 +1248,7 @@ struct tunertype tuners[] = {
 	},
 	[TUNER_PHILIPS_FMD1216ME_MK3] = { /* Philips PAL */
 		.name   = "Philips FMD1216ME MK3 Hybrid Tuner",
-		.params = tuner_tuner_philips_fmd1216me_mk3_params,
+		.params = tuner_philips_fmd1216me_mk3_params,
 	},
 	[TUNER_LG_TDVS_H062F] = { /* LGINNOTEK ATSC */
 		.name   = "LG TDVS-H062F/TUA6034",
@@ -1328,7 +1268,7 @@ struct tunertype tuners[] = {
 	},
 	[TUNER_PHILIPS_TUV1236D] = { /* Philips ATSC */
 		.name   = "Philips TUV1236D ATSC/NTSC dual in",
-		.params = tuner_tuner_tuv1236d_params,
+		.params = tuner_tuv1236d_params,
 	},
 	[TUNER_TNF_5335MF] = { /* Philips NTSC */
 		.name   = "Tena TNF 5335 MF",

