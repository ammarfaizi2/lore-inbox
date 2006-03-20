Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966638AbWCTPTR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966638AbWCTPTR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965237AbWCTPTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:19:16 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:22754 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S966636AbWCTPTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:19:12 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Hans Verkuil <hverkuil@xs4all.nl>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 073/141] V4L/DVB (3324): Fix Samsung tuner frequency ranges
Date: Mon, 20 Mar 2006 12:08:49 -0300
Message-id: <20060320150849.PS212275000073@infradead.org>
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

From: Hans Verkuil <hverkuil@xs4all.nl>
Date: 1139262744 +0200

Forgot to take the NTSC frequency offset into account.

Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/tuner-types.c b/drivers/media/video/tuner-types.c
diff --git a/drivers/media/video/tuner-types.c b/drivers/media/video/tuner-types.c
index 9786e59..a90bc04 100644
--- a/drivers/media/video/tuner-types.c
+++ b/drivers/media/video/tuner-types.c
@@ -970,8 +970,8 @@ static struct tuner_params tuner_tnf_533
 /* ------------ TUNER_SAMSUNG_TCPN_2121P30A - Samsung NTSC ------------ */
 
 static struct tuner_range tuner_samsung_tcpn_2121p30a_ntsc_ranges[] = {
-	{ 16 * 175.75 /*MHz*/, 0xce, 0x01, },
-	{ 16 * 410.25 /*MHz*/, 0xce, 0x02, },
+	{ 16 * 130.00 /*MHz*/, 0xce, 0x01, },
+	{ 16 * 364.50 /*MHz*/, 0xce, 0x02, },
 	{ 16 * 999.99        , 0xce, 0x08, },
 };
 

