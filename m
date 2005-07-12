Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261307AbVGLJeH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261307AbVGLJeH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 05:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbVGLJcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 05:32:22 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:10382 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S261290AbVGLJba
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 05:31:30 -0400
Message-Id: <20050712010132.437878000@abc>
References: <20050712005934.981758000@abc>
Date: Tue, 12 Jul 2005 02:59:38 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-twinhan-dst-printk-fix.patch
X-SA-Exim-Connect-IP: 84.189.244.201
Subject: [DVB patch 3/3] dst: printk -> dprintk
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Stezenbach <js@linuxtv.org>
- stop log spamming when running femon (printk -> dprintk)

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/bt8xx/dst.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.13-rc2-mm1/drivers/media/dvb/bt8xx/dst.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/media/dvb/bt8xx/dst.c	2005-07-11 21:29:46.000000000 +0200
+++ linux-2.6.13-rc2-mm1/drivers/media/dvb/bt8xx/dst.c	2005-07-12 02:53:21.000000000 +0200
@@ -928,7 +928,7 @@ static int dst_get_signal(struct dst_sta
 {
 	int retval;
 	u8 get_signal[] = { 0x00, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0xfb };
-	printk("%s: Getting Signal strength and other parameters !!!!!!!!\n", __FUNCTION__);
+	dprintk("%s: Getting Signal strength and other parameters\n", __FUNCTION__);
 	if ((state->diseq_flags & ATTEMPT_TUNE) == 0) {
 		state->decode_lock = state->decode_strength = state->decode_snr = 0;
 		return 0;

--

