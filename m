Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261729AbVEZUqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261729AbVEZUqI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 16:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261734AbVEZUob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 16:44:31 -0400
Received: from penta.pentaserver.com ([216.74.97.66]:37798 "EHLO
	penta.pentaserver.com") by vger.kernel.org with ESMTP
	id S261729AbVEZUlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 16:41:00 -0400
Message-ID: <42963327.3010604@kromtek.com>
Date: Fri, 27 May 2005 00:35:51 +0400
From: Manu Abraham <manu@kromtek.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Johannes Stezenbach <js@linuxtv.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] Small cleanup
Content-Type: multipart/mixed;
 boundary="------------060007030104070407090400"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - penta.pentaserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - kromtek.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060007030104070407090400
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

o Miscellaneous cleanup

Signed-off-by: Manu Abraham <manu@kromtek.com>

     dst.c |    8 ++++----
     1 files changed, 4 insertions(+), 4 deletions(-)




--------------060007030104070407090400
Content-Type: text/x-patch;
 name="small-cleanups.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="small-cleanups.diff"

--- linux-2.6.12-rc5.orig/drivers/media/dvb/bt8xx/dst.c	2005-05-26 11:16:20.000000000 +0400
+++ linux-2.6.12-rc5/drivers/media/dvb/bt8xx/dst.c	2005-05-26 15:05:37.000000000 +0400
@@ -1041,7 +1041,7 @@ static int dst_set_diseqc(struct dvb_fro
 	struct dst_state* state = fe->demodulator_priv;
 	u8 paket[8] = { 0x00, 0x08, 0x04, 0xe0, 0x10, 0x38, 0xf0, 0xec };
 
-	if (state->dst_type == DST_TYPE_IS_TERR)
+	if (state->dst_type != DST_TYPE_IS_SAT)
 		return 0;
 
 	if (cmd->msg_len == 0 || cmd->msg_len > 4)
@@ -1059,7 +1059,7 @@ static int dst_set_voltage(struct dvb_fr
 
 	state->voltage = voltage;
 
-	if (state->dst_type == DST_TYPE_IS_TERR)
+	if (state->dst_type != DST_TYPE_IS_SAT)
 		return 0;
 
 	need_cmd = 0;
@@ -1093,7 +1093,7 @@ static int dst_set_tone(struct dvb_front
 
 	state->tone = tone;
 
-	if (state->dst_type == DST_TYPE_IS_TERR)
+	if (state->dst_type != DST_TYPE_IS_SAT)
 		return 0;
 
 	switch (tone) {
@@ -1117,7 +1117,7 @@ static int dst_send_burst(struct dvb_fro
 {
 	struct dst_state *state = fe->demodulator_priv;
 
-	if ((state->dst_type == DST_TYPE_IS_TERR) || (state->dst_type == DST_TYPE_IS_CABLE))
+	if (state->dst_type != DST_TYPE_IS_SAT)
 		return 0;
 
 	state->minicmd = minicmd;




--------------060007030104070407090400--
