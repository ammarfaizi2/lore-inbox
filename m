Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262317AbVCVCNu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262317AbVCVCNu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 21:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262319AbVCVCMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 21:12:51 -0500
Received: from ipx10786.ipxserver.de ([80.190.251.108]:65162 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262318AbVCVBe7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 20:34:59 -0500
Message-Id: <20050322013457.300618000@abc>
References: <20050322013427.919515000@abc>
Date: Tue, 22 Mar 2005 02:23:55 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-frontend-nxt2002-fix.patch
X-SA-Exim-Connect-IP: 217.231.55.169
Subject: [DVB patch 22/48] nxt2002: fix max frequency
X-SA-Exim-Version: 4.2 (built Tue, 25 Jan 2005 19:36:50 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch by Taylor Jacob and Tom Dombrosky: There was a typo in the BBTI/B2C2
specs that stated the upper frequency of the air2pc/nxt2002 was 806Mhz, not
860Mhz.

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 nxt2002.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/nxt2002.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/frontends/nxt2002.c	2005-03-22 00:15:13.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/nxt2002.c	2005-03-22 00:17:45.000000000 +0100
@@ -671,7 +671,7 @@ static struct dvb_frontend_ops nxt2002_o
 		.name = "Nextwave nxt2002 VSB/QAM frontend",
 		.type = FE_ATSC,
 		.frequency_min =  54000000,
-		.frequency_max = 806000000,
+		.frequency_max = 860000000,
                 /* stepsize is just a guess */
 		.frequency_stepsize = 166666,
 		.caps = FE_CAN_FEC_1_2 | FE_CAN_FEC_2_3 | FE_CAN_FEC_3_4 |

--

