Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932296AbWAPJYh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296AbWAPJYh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 04:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbWAPJYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 04:24:10 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:46571 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932266AbWAPJXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 04:23:34 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       akpm@osdl.org, Michael Krufky <mkrufky@m1k.net>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 23/25] tuner_params->tda988x is currently unused, so disable
Date: Mon, 16 Jan 2006 07:11:25 -0200
Message-id: <20060116091125.PS49937100023@infradead.org>
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


From: Michael Krufky <mkrufky@m1k.net>

- Tuner_params->tda988x is unused right now, so let's disable it for 2.6.16
- This is currently happening at the card level, but the plan
  is to move this configuration into the tuner_params configuration.

Signed-off-by: Michael Krufky <mkrufky@m1k.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 include/media/tuner-types.h |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/include/media/tuner-types.h b/include/media/tuner-types.h
index 9f0e9c1..15821ab 100644
--- a/include/media/tuner-types.h
+++ b/include/media/tuner-types.h
@@ -19,7 +19,6 @@ struct tuner_range {
 
 struct tuner_params {
 	enum param_type type;
-	unsigned int tda988x;
 	/* Many Philips based tuners have a comment like this in their
 	 * datasheet:
 	 *
@@ -31,7 +30,7 @@ struct tuner_params {
 	 *   will result in very low tuning voltage which may drive the
 	 *   oscillator to extreme conditions.
 	 *
-	 * Set cb_first_if_lower_freq to 1, if this check is 
+	 * Set cb_first_if_lower_freq to 1, if this check is
 	 * required for this tuner.
 	 *
 	 * I tested this for PAL by first setting the TV frequency to

