Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966835AbWCTPVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966835AbWCTPVp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964939AbWCTPVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:21:44 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:46050 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S966836AbWCTPV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:21:29 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Adrian Bunk <bunk@stusta.de>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 141/141] V4L/DVB (3415): Msp3400-kthreads.c: make 3
	functions static
Date: Mon, 20 Mar 2006 12:09:00 -0300
Message-id: <20060320150900.PS510733000141@infradead.org>
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

From: Adrian Bunk <bunk@stusta.de>
Date: 1141825807 -0300

This patch makes three needlessly global functions static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/msp3400-kthreads.c b/drivers/media/video/msp3400-kthreads.c
diff --git a/drivers/media/video/msp3400-kthreads.c b/drivers/media/video/msp3400-kthreads.c
index c4668f4..852ab6a 100644
--- a/drivers/media/video/msp3400-kthreads.c
+++ b/drivers/media/video/msp3400-kthreads.c
@@ -154,7 +154,7 @@ const char *msp_standard_std_name(int st
 	return "unknown";
 }
 
-void msp_set_source(struct i2c_client *client, u16 src)
+static void msp_set_source(struct i2c_client *client, u16 src)
 {
 	struct msp_state *state = i2c_get_clientdata(client);
 
@@ -217,7 +217,7 @@ void msp3400c_set_mode(struct i2c_client
 
 /* Set audio mode. Note that the pre-'G' models do not support BTSC+SAP,
    nor do they support stereo BTSC. */
-void msp3400c_set_audmode(struct i2c_client *client)
+static void msp3400c_set_audmode(struct i2c_client *client)
 {
 	static char *strmode[] = { "mono", "stereo", "lang2", "lang1" };
 	struct msp_state *state = i2c_get_clientdata(client);
@@ -944,7 +944,7 @@ static void msp34xxg_detect_stereo(struc
 		status, is_stereo, is_bilingual, state->rxsubchans);
 }
 
-void msp34xxg_set_audmode(struct i2c_client *client)
+static void msp34xxg_set_audmode(struct i2c_client *client)
 {
 	struct msp_state *state = i2c_get_clientdata(client);
 	int source;
diff --git a/drivers/media/video/msp3400.h b/drivers/media/video/msp3400.h
diff --git a/drivers/media/video/msp3400.h b/drivers/media/video/msp3400.h
index 4182830..6fb5c8c 100644
--- a/drivers/media/video/msp3400.h
+++ b/drivers/media/video/msp3400.h
@@ -104,7 +104,6 @@ int msp_sleep(struct msp_state *state, i
 
 /* msp3400-kthreads.c */
 const char *msp_standard_std_name(int std);
-void msp_set_source(struct i2c_client *client, u16 src);
 void msp_set_audmode(struct i2c_client *client);
 void msp_detect_stereo(struct i2c_client *client);
 int msp3400c_thread(void *data);

