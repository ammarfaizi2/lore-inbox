Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932117AbVIDXrt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbVIDXrt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 19:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbVIDXrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 19:47:48 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:44161 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932131AbVIDXam
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 19:30:42 -0400
Message-Id: <20050904232332.097949000@abc>
References: <20050904232259.777473000@abc>
Date: Mon, 05 Sep 2005 01:23:40 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Manu Abraham <manu@linuxtv.org>
Content-Disposition: inline; filename=dvb-bt8xx-dst-fix-dvb-c-tuning.patch
X-SA-Exim-Connect-IP: 84.189.198.88
Subject: [DVB patch 41/54] dst: fix DVB-C tuning
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manu Abraham <manu@linuxtv.org>

Fix BUG in DVB-C frequency setting.
Thanks to Peng Cao <caopeng75@gmail.com>

Signed-off-by: Manu Abraham <manu@linuxtv.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/bt8xx/dst.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.13-git4.orig/drivers/media/dvb/bt8xx/dst.c	2005-09-04 22:28:35.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/bt8xx/dst.c	2005-09-04 22:28:37.000000000 +0200
@@ -359,6 +359,7 @@ static int dst_set_freq(struct dst_state
 		state->tx_tuna[3] = (freq >> 8) & 0xff;
 		state->tx_tuna[4] = (u8) freq;
 	} else if (state->dst_type == DST_TYPE_IS_CABLE) {
+		freq = freq / 1000;
 		state->tx_tuna[2] = (freq >> 16) & 0xff;
 		state->tx_tuna[3] = (freq >> 8) & 0xff;
 		state->tx_tuna[4] = (u8) freq;

--

