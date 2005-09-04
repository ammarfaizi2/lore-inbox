Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbVIDXer@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbVIDXer (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 19:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbVIDXbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 19:31:07 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:37249 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932121AbVIDXaZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 19:30:25 -0400
Message-Id: <20050904232328.558882000@abc>
References: <20050904232259.777473000@abc>
Date: Mon, 05 Sep 2005 01:23:31 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-twinhan-dst-remove-debug-print.patch
X-SA-Exim-Connect-IP: 84.189.198.88
Subject: [DVB patch 32/54] remove noisy debug print
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

comment out noisy dprintk in dst_get_signal()
(why are errors only visible with debug on?
this needs to be cleaned up so we can disable debug by default)

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/bt8xx/dst.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.13-git4.orig/drivers/media/dvb/bt8xx/dst.c	2005-09-04 22:24:23.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/bt8xx/dst.c	2005-09-04 22:28:26.000000000 +0200
@@ -928,7 +928,7 @@ static int dst_get_signal(struct dst_sta
 {
 	int retval;
 	u8 get_signal[] = { 0x00, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0xfb };
-	dprintk("%s: Getting Signal strength and other parameters\n", __FUNCTION__);
+	//dprintk("%s: Getting Signal strength and other parameters\n", __FUNCTION__);
 	if ((state->diseq_flags & ATTEMPT_TUNE) == 0) {
 		state->decode_lock = state->decode_strength = state->decode_snr = 0;
 		return 0;

--

