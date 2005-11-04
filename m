Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161058AbVKDE7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161058AbVKDE7j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 23:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161061AbVKDE7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 23:59:39 -0500
Received: from hulk.hostingexpert.com ([69.57.134.39]:32933 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S1161058AbVKDE7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 23:59:38 -0500
Message-ID: <436AEAC7.2020905@m1k.net>
Date: Thu, 03 Nov 2005 23:59:51 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org,
       Mac Michaels <wmichaels1@earthlink.net>
Subject: [PATCH 1/3] dvb: lgdt330x: Correct QAM symbol_rate_min for lgdt3302
 and lgdt3303
Content-Type: multipart/mixed;
 boundary="------------040209020002060401050709"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040209020002060401050709
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit




--------------040209020002060401050709
Content-Type: text/x-patch;
 name="dvb-lgdt330x-correct-qam-symbol-rate-min.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dvb-lgdt330x-correct-qam-symbol-rate-min.patch"

Correct QAM symbol_rate_min for lgdt3302 and lgdt3303

Thanks to: Mac Michaels and Steve Malenfant

Signed-off-by: Mac Michaels <wmichaels1@earthlink.net>
Signed-off-by: Michael Krufky <mkrufky@m1k.net>

 drivers/media/dvb/frontends/lgdt330x.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

--- linux-2.6.14-git5.orig/drivers/media/dvb/frontends/lgdt330x.c
+++ linux-2.6.14-git5/drivers/media/dvb/frontends/lgdt330x.c
@@ -756,9 +756,8 @@ static struct dvb_frontend_ops lgdt3302_
 		.frequency_min= 54000000,
 		.frequency_max= 858000000,
 		.frequency_stepsize= 62500,
-		/* Symbol rate is for all VSB modes need to check QAM */
-		.symbol_rate_min    = 10762000,
-		.symbol_rate_max    = 10762000,
+		.symbol_rate_min    = 5056941,	/* QAM 64 */
+		.symbol_rate_max    = 10762000,	/* VSB 8  */
 		.caps = FE_CAN_QAM_64 | FE_CAN_QAM_256 | FE_CAN_8VSB
 	},
 	.init                 = lgdt330x_init,
@@ -780,9 +779,8 @@ static struct dvb_frontend_ops lgdt3303_
 		.frequency_min= 54000000,
 		.frequency_max= 858000000,
 		.frequency_stepsize= 62500,
-		/* Symbol rate is for all VSB modes need to check QAM */
-		.symbol_rate_min    = 10762000,
-		.symbol_rate_max    = 10762000,
+		.symbol_rate_min    = 5056941,	/* QAM 64 */
+		.symbol_rate_max    = 10762000,	/* VSB 8  */
 		.caps = FE_CAN_QAM_64 | FE_CAN_QAM_256 | FE_CAN_8VSB
 	},
 	.init                 = lgdt330x_init,



--------------040209020002060401050709--
