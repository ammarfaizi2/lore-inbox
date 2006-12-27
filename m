Return-Path: <linux-kernel-owner+w=401wt.eu-S932997AbWL0ROG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932997AbWL0ROG (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 12:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964775AbWL0RNk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 12:13:40 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:41480 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933005AbWL0RMK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 12:12:10 -0500
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: V4L-DVB Maintainers <v4l-dvb-maintainer@linuxtv.org>,
       Mario Rossi <mariofutire@googlemail.com>,
       Patrick Boettcher <pb@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 01/28] V4L/DVB (4955): Fix autosearch index
Date: Wed, 27 Dec 2006 14:57:27 -0200
Message-id: <20061227165726.PS94054100001@infradead.org>
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


From: Mario Rossi <mariofutire@googlemail.com>

After rewriting the driver the wrong autosearch index was used when
COFDM-parameter needed to be detected.
Thanks to Mario Rossi who found it.

Signed-off-by: Mario Rossi <mariofutire@googlemail.com>
Signed-off-by: Patrick Boettcher <pb@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/dvb/frontends/dib3000mc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/media/dvb/frontends/dib3000mc.c b/drivers/media/dvb/frontends/dib3000mc.c
index 5da6617..23aa75a 100644
--- a/drivers/media/dvb/frontends/dib3000mc.c
+++ b/drivers/media/dvb/frontends/dib3000mc.c
@@ -515,7 +515,7 @@ static int dib3000mc_autosearch_start(st
 	fchan.vit_alpha = 1; fchan.vit_code_rate_hp = 2; fchan.vit_code_rate_lp = 2;
 	fchan.vit_hrch = 0; fchan.vit_select_hp = 1;
 
-	dib3000mc_set_channel_cfg(state, &fchan, 7);
+	dib3000mc_set_channel_cfg(state, &fchan, 11);
 
 	reg = dib3000mc_read_word(state, 0);
 	dib3000mc_write_word(state, 0, reg | (1 << 8));

