Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbVHRCza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbVHRCza (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 22:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932111AbVHRCza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 22:55:30 -0400
Received: from hulk.hostingexpert.com ([69.57.134.39]:38362 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S932109AbVHRCz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 22:55:29 -0400
Message-ID: <4303F89B.3080401@linuxtv.org>
Date: Wed, 17 Aug 2005 22:55:23 -0400
From: Michael Krufky <mkrufky@linuxtv.org>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-dvb-maintainer@linuxtv.org,
       Patrick Boettcher <patrick.boettcher@desy.de>,
       LKML <linux-kernel@vger.kernel.org>, Michael Krufky <mkrufky@m1k.net>
Subject: [PATCH] DVB: lgdt330x check callback fix
Content-Type: multipart/mixed;
 boundary="------------090305010309060201010402"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - linuxtv.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090305010309060201010402
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------090305010309060201010402
Content-Type: text/plain;
 name="dvb-lgdt330x-check-callback.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dvb-lgdt330x-check-callback.patch"

- FIX: check if the callback is set, before calling it.
- Clean up whitespace / indentation.

Signed-off-by: Patrick Boettcher <pb@linuxtv.org>
Signed-off-by: Michael Krufky <mkrufky@m1k.net>
---
 linux/drivers/media/dvb/frontends/lgdt330x.c |   50 +++++++++----------
 1 files changed, 25 insertions(+), 25 deletions(-)

diff -u linux-2.6.13-rc6-git8/drivers/media/dvb/frontends/lgdt330x.c linux/drivers/media/dvb/frontends/lgdt330x.c
--- linux-2.6.13-rc6-git8/drivers/media/dvb/frontends/lgdt330x.c	2005-08-17 00:34:03.000000000 +0000
+++ linux/drivers/media/dvb/frontends/lgdt330x.c	2005-08-17 22:31:30.000000000 +0000
@@ -69,8 +69,8 @@
 };
 
 static int i2c_write_demod_bytes (struct lgdt330x_state* state,
-			   u8 *buf, /* data bytes to send */
-			   int len  /* number of bytes to send */ )
+				  u8 *buf, /* data bytes to send */
+				  int len  /* number of bytes to send */ )
 {
 	struct i2c_msg msg =
 		{ .addr = state->config->demod_address,
@@ -129,13 +129,13 @@
 	};
 
 	ret = i2c_write_demod_bytes(state,
-			     reset, sizeof(reset));
+				    reset, sizeof(reset));
 	if (ret == 0) {
 
 		/* force reset high (inactive) and unmask interrupts */
 		reset[1] = 0x7f;
 		ret = i2c_write_demod_bytes(state,
-				     reset, sizeof(reset));
+					    reset, sizeof(reset));
 	}
 	return ret;
 }
@@ -149,13 +149,13 @@
 	};
 
 	ret = i2c_write_demod_bytes(state,
-			     reset, sizeof(reset));
+				    reset, sizeof(reset));
 	if (ret == 0) {
 
 		/* force reset high (inactive) */
 		reset[1] = 0x01;
 		ret = i2c_write_demod_bytes(state,
-				     reset, sizeof(reset));
+					    reset, sizeof(reset));
 	}
 	return ret;
 }
@@ -172,7 +172,6 @@
 	}
 }
 
-
 static int lgdt330x_init(struct dvb_frontend* fe)
 {
 	/* Hardware reset is done using gpio[0] of cx23880x chip.
@@ -229,13 +228,13 @@
 	case LGDT3302:
 		chip_name = "LGDT3302";
 		err = i2c_write_demod_bytes(state, lgdt3302_init_data,
-									sizeof(lgdt3302_init_data));
-  		break;
+					    sizeof(lgdt3302_init_data));
+		break;
 	case LGDT3303:
 		chip_name = "LGDT3303";
 		err = i2c_write_demod_bytes(state, lgdt3303_init_data,
-									sizeof(lgdt3303_init_data));
-  		break;
+					    sizeof(lgdt3303_init_data));
+		break;
 	default:
 		chip_name = "undefined";
 		printk (KERN_WARNING "Only LGDT3302 and LGDT3303 are supported chips.\n");
@@ -262,15 +261,15 @@
 	switch (state->config->demod_chip) {
 	case LGDT3302:
 		err = i2c_read_demod_bytes(state, LGDT3302_PACKET_ERR_COUNTER1,
-								  buf, sizeof(buf));
-  		break;
+					   buf, sizeof(buf));
+		break;
 	case LGDT3303:
 		err = i2c_read_demod_bytes(state, LGDT3303_PACKET_ERR_COUNTER1,
-								  buf, sizeof(buf));
-  		break;
+					   buf, sizeof(buf));
+		break;
 	default:
 		printk(KERN_WARNING
-			   "Only LGDT3302 and LGDT3303 are supported chips.\n");
+		       "Only LGDT3302 and LGDT3303 are supported chips.\n");
 		err = -ENODEV;
 	}
 
@@ -330,7 +329,7 @@
 
 			if (state->config->demod_chip == LGDT3303) {
 				err = i2c_write_demod_bytes(state, lgdt3303_8vsb_44_data,
-											sizeof(lgdt3303_8vsb_44_data));
+							    sizeof(lgdt3303_8vsb_44_data));
 			}
 			break;
 
@@ -378,18 +377,19 @@
 
 		/* Select the requested mode */
 		i2c_write_demod_bytes(state, top_ctrl_cfg,
-							  sizeof(top_ctrl_cfg));
-		state->config->set_ts_params(fe, 0);
+				      sizeof(top_ctrl_cfg));
+		if (state->config->set_ts_params)
+			state->config->set_ts_params(fe, 0);
 		state->current_modulation = param->u.vsb.modulation;
 	}
 
-	/* Change only if we are actually changing the channel */
-	if (state->current_frequency != param->frequency) {
-		/* Tune to the new frequency */
+	/* Tune to the specified frequency */
+	if (state->config->pll_set)
 		state->config->pll_set(fe, param);
-		/* Keep track of the new frequency */
-		state->current_frequency = param->frequency;
-	}
+
+	/* Keep track of the new frequency */
+	state->current_frequency = param->frequency;
+
 	lgdt330x_SwReset(state);
 	return 0;
 }

--------------090305010309060201010402--
