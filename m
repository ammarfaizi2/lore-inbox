Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965605AbWCTPz4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965605AbWCTPz4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:55:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965598AbWCTPzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:55:55 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:24034 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S966636AbWCTPTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:19:21 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Michael Krufky <mkrufky@m1k.net>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 039/141] V4L/DVB (3265): Add count to tunertype struct
Date: Mon, 20 Mar 2006 12:08:43 -0300
Message-id: <20060320150843.PS508705000039@infradead.org>
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
Date: 1139224511 -0200

The tuner_params element is an array of undefined length,
with each array member being a set of parameters for each
video standard type.
The number of members in the tuner_params array
will be stored in tuners[]->count

Signed-off-by: Michael Krufky <mkrufky@m1k.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/tuner-types.c b/drivers/media/video/tuner-types.c
diff --git a/drivers/media/video/tuner-types.c b/drivers/media/video/tuner-types.c
index f77584d..27fc4d0 100644
--- a/drivers/media/video/tuner-types.c
+++ b/drivers/media/video/tuner-types.c
@@ -987,18 +987,22 @@ struct tunertype tuners[] = {
 	[TUNER_TEMIC_PAL] = { /* TEMIC PAL */
 		.name   = "Temic PAL (4002 FH5)",
 		.params = tuner_temic_pal_params,
+		.count  = ARRAY_SIZE(tuner_temic_pal_params),
 	},
 	[TUNER_PHILIPS_PAL_I] = { /* Philips PAL_I */
 		.name   = "Philips PAL_I (FI1246 and compatibles)",
 		.params = tuner_philips_pal_i_params,
+		.count  = ARRAY_SIZE(tuner_philips_pal_i_params),
 	},
 	[TUNER_PHILIPS_NTSC] = { /* Philips NTSC */
 		.name   = "Philips NTSC (FI1236,FM1236 and compatibles)",
 		.params = tuner_philips_ntsc_params,
+		.count  = ARRAY_SIZE(tuner_philips_ntsc_params),
 	},
 	[TUNER_PHILIPS_SECAM] = { /* Philips SECAM */
 		.name   = "Philips (SECAM+PAL_BG) (FI1216MF, FM1216MF, FR1216MF)",
 		.params = tuner_philips_secam_params,
+		.count  = ARRAY_SIZE(tuner_philips_secam_params),
 	},
 	[TUNER_ABSENT] = { /* Tuner Absent */
 		.name   = "NoTuner",
@@ -1006,120 +1010,148 @@ struct tunertype tuners[] = {
 	[TUNER_PHILIPS_PAL] = { /* Philips PAL */
 		.name   = "Philips PAL_BG (FI1216 and compatibles)",
 		.params = tuner_philips_pal_params,
+		.count  = ARRAY_SIZE(tuner_philips_pal_params),
 	},
 	[TUNER_TEMIC_NTSC] = { /* TEMIC NTSC */
 		.name   = "Temic NTSC (4032 FY5)",
 		.params = tuner_temic_ntsc_params,
+		.count  = ARRAY_SIZE(tuner_temic_ntsc_params),
 	},
 	[TUNER_TEMIC_PAL_I] = { /* TEMIC PAL_I */
 		.name   = "Temic PAL_I (4062 FY5)",
 		.params = tuner_temic_pal_i_params,
+		.count  = ARRAY_SIZE(tuner_temic_pal_i_params),
 	},
 	[TUNER_TEMIC_4036FY5_NTSC] = { /* TEMIC NTSC */
 		.name   = "Temic NTSC (4036 FY5)",
 		.params = tuner_temic_4036fy5_ntsc_params,
+		.count  = ARRAY_SIZE(tuner_temic_4036fy5_ntsc_params),
 	},
 	[TUNER_ALPS_TSBH1_NTSC] = { /* TEMIC NTSC */
 		.name   = "Alps HSBH1",
 		.params = tuner_alps_tsbh1_ntsc_params,
+		.count  = ARRAY_SIZE(tuner_alps_tsbh1_ntsc_params),
 	},
 
 	/* 10-19 */
 	[TUNER_ALPS_TSBE1_PAL] = { /* TEMIC PAL */
 		.name   = "Alps TSBE1",
 		.params = tuner_alps_tsb_1_params,
+		.count  = ARRAY_SIZE(tuner_alps_tsb_1_params),
 	},
 	[TUNER_ALPS_TSBB5_PAL_I] = { /* Alps PAL_I */
 		.name   = "Alps TSBB5",
 		.params = tuner_alps_tsbb5_params,
+		.count  = ARRAY_SIZE(tuner_alps_tsbb5_params),
 	},
 	[TUNER_ALPS_TSBE5_PAL] = { /* Alps PAL */
 		.name   = "Alps TSBE5",
 		.params = tuner_alps_tsbe5_params,
+		.count  = ARRAY_SIZE(tuner_alps_tsbe5_params),
 	},
 	[TUNER_ALPS_TSBC5_PAL] = { /* Alps PAL */
 		.name   = "Alps TSBC5",
 		.params = tuner_alps_tsbc5_params,
+		.count  = ARRAY_SIZE(tuner_alps_tsbc5_params),
 	},
 	[TUNER_TEMIC_4006FH5_PAL] = { /* TEMIC PAL */
 		.name   = "Temic PAL_BG (4006FH5)",
 		.params = tuner_temic_4006fh5_params,
+		.count  = ARRAY_SIZE(tuner_temic_4006fh5_params),
 	},
 	[TUNER_ALPS_TSHC6_NTSC] = { /* Alps NTSC */
 		.name   = "Alps TSCH6",
 		.params = tuner_alps_tshc6_params,
+		.count  = ARRAY_SIZE(tuner_alps_tshc6_params),
 	},
 	[TUNER_TEMIC_PAL_DK] = { /* TEMIC PAL */
 		.name   = "Temic PAL_DK (4016 FY5)",
 		.params = tuner_temic_pal_dk_params,
+		.count  = ARRAY_SIZE(tuner_temic_pal_dk_params),
 	},
 	[TUNER_PHILIPS_NTSC_M] = { /* Philips NTSC */
 		.name   = "Philips NTSC_M (MK2)",
 		.params = tuner_philips_ntsc_m_params,
+		.count  = ARRAY_SIZE(tuner_philips_ntsc_m_params),
 	},
 	[TUNER_TEMIC_4066FY5_PAL_I] = { /* TEMIC PAL_I */
 		.name   = "Temic PAL_I (4066 FY5)",
 		.params = tuner_temic_4066fy5_pal_i_params,
+		.count  = ARRAY_SIZE(tuner_temic_4066fy5_pal_i_params),
 	},
 	[TUNER_TEMIC_4006FN5_MULTI_PAL] = { /* TEMIC PAL */
 		.name   = "Temic PAL* auto (4006 FN5)",
 		.params = tuner_temic_4006fn5_multi_params,
+		.count  = ARRAY_SIZE(tuner_temic_4006fn5_multi_params),
 	},
 
 	/* 20-29 */
 	[TUNER_TEMIC_4009FR5_PAL] = { /* TEMIC PAL */
 		.name   = "Temic PAL_BG (4009 FR5) or PAL_I (4069 FR5)",
 		.params = tuner_temic_4009f_5_params,
+		.count  = ARRAY_SIZE(tuner_temic_4009f_5_params),
 	},
 	[TUNER_TEMIC_4039FR5_NTSC] = { /* TEMIC NTSC */
 		.name   = "Temic NTSC (4039 FR5)",
 		.params = tuner_temic_4039fr5_params,
+		.count  = ARRAY_SIZE(tuner_temic_4039fr5_params),
 	},
 	[TUNER_TEMIC_4046FM5] = { /* TEMIC PAL */
 		.name   = "Temic PAL/SECAM multi (4046 FM5)",
 		.params = tuner_temic_4046fm5_params,
+		.count  = ARRAY_SIZE(tuner_temic_4046fm5_params),
 	},
 	[TUNER_PHILIPS_PAL_DK] = { /* Philips PAL */
 		.name   = "Philips PAL_DK (FI1256 and compatibles)",
 		.params = tuner_philips_pal_dk_params,
+		.count  = ARRAY_SIZE(tuner_philips_pal_dk_params),
 	},
 	[TUNER_PHILIPS_FQ1216ME] = { /* Philips PAL */
 		.name   = "Philips PAL/SECAM multi (FQ1216ME)",
 		.params = tuner_philips_fq1216me_params,
+		.count  = ARRAY_SIZE(tuner_philips_fq1216me_params),
 	},
 	[TUNER_LG_PAL_I_FM] = { /* LGINNOTEK PAL_I */
 		.name   = "LG PAL_I+FM (TAPC-I001D)",
 		.params = tuner_lg_pal_i_fm_params,
+		.count  = ARRAY_SIZE(tuner_lg_pal_i_fm_params),
 	},
 	[TUNER_LG_PAL_I] = { /* LGINNOTEK PAL_I */
 		.name   = "LG PAL_I (TAPC-I701D)",
 		.params = tuner_lg_pal_i_params,
+		.count  = ARRAY_SIZE(tuner_lg_pal_i_params),
 	},
 	[TUNER_LG_NTSC_FM] = { /* LGINNOTEK NTSC */
 		.name   = "LG NTSC+FM (TPI8NSR01F)",
 		.params = tuner_lg_ntsc_fm_params,
+		.count  = ARRAY_SIZE(tuner_lg_ntsc_fm_params),
 	},
 	[TUNER_LG_PAL_FM] = { /* LGINNOTEK PAL */
 		.name   = "LG PAL_BG+FM (TPI8PSB01D)",
 		.params = tuner_lg_pal_fm_params,
+		.count  = ARRAY_SIZE(tuner_lg_pal_fm_params),
 	},
 	[TUNER_LG_PAL] = { /* LGINNOTEK PAL */
 		.name   = "LG PAL_BG (TPI8PSB11D)",
 		.params = tuner_lg_pal_params,
+		.count  = ARRAY_SIZE(tuner_lg_pal_params),
 	},
 
 	/* 30-39 */
 	[TUNER_TEMIC_4009FN5_MULTI_PAL_FM] = { /* TEMIC PAL */
 		.name   = "Temic PAL* auto + FM (4009 FN5)",
 		.params = tuner_temic_4009_fn5_multi_pal_fm_params,
+		.count  = ARRAY_SIZE(tuner_temic_4009_fn5_multi_pal_fm_params),
 	},
 	[TUNER_SHARP_2U5JF5540_NTSC] = { /* SHARP NTSC */
 		.name   = "SHARP NTSC_JP (2U5JF5540)",
 		.params = tuner_sharp_2u5jf5540_params,
+		.count  = ARRAY_SIZE(tuner_sharp_2u5jf5540_params),
 	},
 	[TUNER_Samsung_PAL_TCPM9091PD27] = { /* Samsung PAL */
 		.name   = "Samsung PAL TCPM9091PD27",
 		.params = tuner_samsung_pal_tcpm9091pd27_params,
+		.count  = ARRAY_SIZE(tuner_samsung_pal_tcpm9091pd27_params),
 	},
 	[TUNER_MT2032] = { /* Microtune PAL|NTSC */
 		.name   = "MT20xx universal",
@@ -1127,86 +1159,106 @@ struct tunertype tuners[] = {
 	[TUNER_TEMIC_4106FH5] = { /* TEMIC PAL */
 		.name   = "Temic PAL_BG (4106 FH5)",
 		.params = tuner_temic_4106fh5_params,
+		.count  = ARRAY_SIZE(tuner_temic_4106fh5_params),
 	},
 	[TUNER_TEMIC_4012FY5] = { /* TEMIC PAL */
 		.name   = "Temic PAL_DK/SECAM_L (4012 FY5)",
 		.params = tuner_temic_4012fy5_params,
+		.count  = ARRAY_SIZE(tuner_temic_4012fy5_params),
 	},
 	[TUNER_TEMIC_4136FY5] = { /* TEMIC NTSC */
 		.name   = "Temic NTSC (4136 FY5)",
 		.params = tuner_temic_4136_fy5_params,
+		.count  = ARRAY_SIZE(tuner_temic_4136_fy5_params),
 	},
 	[TUNER_LG_PAL_NEW_TAPC] = { /* LGINNOTEK PAL */
 		.name   = "LG PAL (newer TAPC series)",
 		.params = tuner_lg_pal_new_tapc_params,
+		.count  = ARRAY_SIZE(tuner_lg_pal_new_tapc_params),
 	},
 	[TUNER_PHILIPS_FM1216ME_MK3] = { /* Philips PAL */
 		.name   = "Philips PAL/SECAM multi (FM1216ME MK3)",
 		.params = tuner_fm1216me_mk3_params,
+		.count  = ARRAY_SIZE(tuner_fm1216me_mk3_params),
 	},
 	[TUNER_LG_NTSC_NEW_TAPC] = { /* LGINNOTEK NTSC */
 		.name   = "LG NTSC (newer TAPC series)",
 		.params = tuner_lg_ntsc_new_tapc_params,
+		.count  = ARRAY_SIZE(tuner_lg_ntsc_new_tapc_params),
 	},
 
 	/* 40-49 */
 	[TUNER_HITACHI_NTSC] = { /* HITACHI NTSC */
 		.name   = "HITACHI V7-J180AT",
 		.params = tuner_hitachi_ntsc_params,
+		.count  = ARRAY_SIZE(tuner_hitachi_ntsc_params),
 	},
 	[TUNER_PHILIPS_PAL_MK] = { /* Philips PAL */
 		.name   = "Philips PAL_MK (FI1216 MK)",
 		.params = tuner_philips_pal_mk_params,
+		.count  = ARRAY_SIZE(tuner_philips_pal_mk_params),
 	},
 	[TUNER_PHILIPS_ATSC] = { /* Philips ATSC */
 		.name   = "Philips 1236D ATSC/NTSC dual in",
 		.params = tuner_philips_atsc_params,
+		.count  = ARRAY_SIZE(tuner_philips_atsc_params),
 	},
 	[TUNER_PHILIPS_FM1236_MK3] = { /* Philips NTSC */
 		.name   = "Philips NTSC MK3 (FM1236MK3 or FM1236/F)",
 		.params = tuner_fm1236_mk3_params,
+		.count  = ARRAY_SIZE(tuner_fm1236_mk3_params),
 	},
 	[TUNER_PHILIPS_4IN1] = { /* Philips NTSC */
 		.name   = "Philips 4 in 1 (ATI TV Wonder Pro/Conexant)",
 		.params = tuner_philips_4in1_params,
+		.count  = ARRAY_SIZE(tuner_philips_4in1_params),
 	},
 	[TUNER_MICROTUNE_4049FM5] = { /* Microtune PAL */
 		.name   = "Microtune 4049 FM5",
 		.params = tuner_microtune_4049_fm5_params,
+		.count  = ARRAY_SIZE(tuner_microtune_4049_fm5_params),
 	},
 	[TUNER_PANASONIC_VP27] = { /* Panasonic NTSC */
 		.name   = "Panasonic VP27s/ENGE4324D",
 		.params = tuner_panasonic_vp27_params,
+		.count  = ARRAY_SIZE(tuner_panasonic_vp27_params),
 	},
 	[TUNER_LG_NTSC_TAPE] = { /* LGINNOTEK NTSC */
 		.name   = "LG NTSC (TAPE series)",
 		.params = tuner_lg_ntsc_tape_params,
+		.count  = ARRAY_SIZE(tuner_lg_ntsc_tape_params),
 	},
 	[TUNER_TNF_8831BGFF] = { /* Philips PAL */
 		.name   = "Tenna TNF 8831 BGFF)",
 		.params = tuner_tnf_8831bgff_params,
+		.count  = ARRAY_SIZE(tuner_tnf_8831bgff_params),
 	},
 	[TUNER_MICROTUNE_4042FI5] = { /* Microtune NTSC */
 		.name   = "Microtune 4042 FI5 ATSC/NTSC dual in",
 		.params = tuner_microtune_4042fi5_params,
+		.count  = ARRAY_SIZE(tuner_microtune_4042fi5_params),
 	},
 
 	/* 50-59 */
 	[TUNER_TCL_2002N] = { /* TCL NTSC */
 		.name   = "TCL 2002N",
 		.params = tuner_tcl_2002n_params,
+		.count  = ARRAY_SIZE(tuner_tcl_2002n_params),
 	},
 	[TUNER_PHILIPS_FM1256_IH3] = { /* Philips PAL */
 		.name   = "Philips PAL/SECAM_D (FM 1256 I-H3)",
 		.params = tuner_philips_fm1256_ih3_params,
+		.count  = ARRAY_SIZE(tuner_philips_fm1256_ih3_params),
 	},
 	[TUNER_THOMSON_DTT7610] = { /* THOMSON ATSC */
 		.name   = "Thomson DTT 7610 (ATSC/NTSC)",
 		.params = tuner_thomson_dtt7610_params,
+		.count  = ARRAY_SIZE(tuner_thomson_dtt7610_params),
 	},
 	[TUNER_PHILIPS_FQ1286] = { /* Philips NTSC */
 		.name   = "Philips FQ1286",
 		.params = tuner_philips_fq1286_params,
+		.count  = ARRAY_SIZE(tuner_philips_fq1286_params),
 	},
 	[TUNER_PHILIPS_TDA8290] = { /* Philips PAL|NTSC */
 		.name   = "tda8290+75",
@@ -1214,22 +1266,27 @@ struct tunertype tuners[] = {
 	[TUNER_TCL_2002MB] = { /* TCL PAL */
 		.name   = "TCL 2002MB",
 		.params = tuner_tcl_2002mb_params,
+		.count  = ARRAY_SIZE(tuner_tcl_2002mb_params),
 	},
 	[TUNER_PHILIPS_FQ1216AME_MK4] = { /* Philips PAL */
 		.name   = "Philips PAL/SECAM multi (FQ1216AME MK4)",
 		.params = tuner_philips_fq1216ame_mk4_params,
+		.count  = ARRAY_SIZE(tuner_philips_fq1216ame_mk4_params),
 	},
 	[TUNER_PHILIPS_FQ1236A_MK4] = { /* Philips NTSC */
 		.name   = "Philips FQ1236A MK4",
 		.params = tuner_philips_fq1236a_mk4_params,
+		.count  = ARRAY_SIZE(tuner_philips_fq1236a_mk4_params),
 	},
 	[TUNER_YMEC_TVF_8531MF] = { /* Philips NTSC */
 		.name   = "Ymec TVision TVF-8531MF/8831MF/8731MF",
 		.params = tuner_ymec_tvf_8531mf_params,
+		.count  = ARRAY_SIZE(tuner_ymec_tvf_8531mf_params),
 	},
 	[TUNER_YMEC_TVF_5533MF] = { /* Philips NTSC */
 		.name   = "Ymec TVision TVF-5533MF",
 		.params = tuner_ymec_tvf_5533mf_params,
+		.count  = ARRAY_SIZE(tuner_ymec_tvf_5533mf_params),
 	},
 
 	/* 60-69 */
@@ -1237,10 +1294,12 @@ struct tunertype tuners[] = {
 		/* DTT 7611 7611A 7612 7613 7613A 7614 7615 7615A */
 		.name   = "Thomson DTT 761X (ATSC/NTSC)",
 		.params = tuner_thomson_dtt761x_params,
+		.count  = ARRAY_SIZE(tuner_thomson_dtt761x_params),
 	},
 	[TUNER_TENA_9533_DI] = { /* Philips PAL */
 		.name   = "Tena TNF9533-D/IF/TNF9533-B/DF",
 		.params = tuner_tena_9533_di_params,
+		.count  = ARRAY_SIZE(tuner_tena_9533_di_params),
 	},
 	[TUNER_TEA5767] = { /* Philips RADIO */
 		.name   = "Philips TEA5767HN FM Radio",
@@ -1249,36 +1308,44 @@ struct tunertype tuners[] = {
 	[TUNER_PHILIPS_FMD1216ME_MK3] = { /* Philips PAL */
 		.name   = "Philips FMD1216ME MK3 Hybrid Tuner",
 		.params = tuner_philips_fmd1216me_mk3_params,
+		.count  = ARRAY_SIZE(tuner_philips_fmd1216me_mk3_params),
 	},
 	[TUNER_LG_TDVS_H062F] = { /* LGINNOTEK ATSC */
 		.name   = "LG TDVS-H062F/TUA6034",
 		.params = tuner_tua6034_params,
+		.count  = ARRAY_SIZE(tuner_tua6034_params),
 	},
 	[TUNER_YMEC_TVF66T5_B_DFF] = { /* Philips PAL */
 		.name   = "Ymec TVF66T5-B/DFF",
 		.params = tuner_ymec_tvf66t5_b_dff_params,
+		.count  = ARRAY_SIZE(tuner_ymec_tvf66t5_b_dff_params),
 	},
 	[TUNER_LG_NTSC_TALN_MINI] = { /* LGINNOTEK NTSC */
 		.name   = "LG NTSC (TALN mini series)",
 		.params = tuner_lg_taln_mini_params,
+		.count  = ARRAY_SIZE(tuner_lg_taln_mini_params),
 	},
 	[TUNER_PHILIPS_TD1316] = { /* Philips PAL */
 		.name   = "Philips TD1316 Hybrid Tuner",
 		.params = tuner_philips_td1316_params,
+		.count  = ARRAY_SIZE(tuner_philips_td1316_params),
 	},
 	[TUNER_PHILIPS_TUV1236D] = { /* Philips ATSC */
 		.name   = "Philips TUV1236D ATSC/NTSC dual in",
 		.params = tuner_tuv1236d_params,
+		.count  = ARRAY_SIZE(tuner_tuv1236d_params),
 	},
 	[TUNER_TNF_5335MF] = { /* Philips NTSC */
 		.name   = "Tena TNF 5335 MF",
 		.params = tuner_tnf_5335mf_params,
+		.count  = ARRAY_SIZE(tuner_tnf_5335mf_params),
 	},
 
 	/* 70-79 */
 	[TUNER_SAMSUNG_TCPN_2121P30A] = { /* Samsung NTSC */
 		.name   = "Samsung TCPN 2121P30A",
 		.params = tuner_samsung_tcpn_2121p30a_params,
+		.count  = ARRAY_SIZE(tuner_samsung_tcpn_2121p30a_params),
 	},
 };
 
diff --git a/include/media/tuner-types.h b/include/media/tuner-types.h
diff --git a/include/media/tuner-types.h b/include/media/tuner-types.h
index 53ac66e..ad9c171 100644
--- a/include/media/tuner-types.h
+++ b/include/media/tuner-types.h
@@ -46,6 +46,7 @@ struct tuner_params {
 
 struct tunertype {
 	char *name;
+	unsigned int count;
 	struct tuner_params *params;
 };
 

