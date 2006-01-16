Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932295AbWAPJZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbWAPJZH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 04:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbWAPJYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 04:24:49 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:55275 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932270AbWAPJYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 04:24:05 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       akpm@osdl.org, Ricardo Cerqueira <v4l@cerqueira.org>,
       Michael Krufky <mkrufky@m1k.net>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 21/25] fix some sound quality & distortion problems.
Date: Mon, 16 Jan 2006 07:11:25 -0200
Message-id: <20060116091124.PS95124500021@infradead.org>
In-Reply-To: <20060116091105.PS83611600000@infradead.org>
References: <20060116091105.PS83611600000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Ricardo Cerqueira <v4l@cerqueira.org>

- Fix some sound quality & distortion problems.

Signed-off-by: Ricardo Cerqueira <v4l@cerqueira.org>
Signed-off-by: Michael Krufky <mkrufky@m1k.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/cx88/cx88-alsa.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/video/cx88/cx88-alsa.c b/drivers/media/video/cx88/cx88-alsa.c
index e649f67..a2e36a1 100644
--- a/drivers/media/video/cx88/cx88-alsa.c
+++ b/drivers/media/video/cx88/cx88-alsa.c
@@ -333,10 +333,10 @@ static snd_pcm_hardware_t snd_cx88_digit
 	.channels_min = 1,
 	.channels_max = 2,
 	.buffer_bytes_max = (2*2048),
-	.period_bytes_min = 256,
+	.period_bytes_min = 2048,
 	.period_bytes_max = 2048,
 	.periods_min = 2,
-	.periods_max = 16,
+	.periods_max = 2,
 };
 
 /*

