Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932258AbWAPJV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbWAPJV7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 04:21:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbWAPJV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 04:21:59 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:18923 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932258AbWAPJV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 04:21:58 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       akpm@osdl.org, Michael Krufky <mkrufky@m1k.net>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 18/25] Move tda988x options into tuner_params struct.
Date: Mon, 16 Jan 2006 07:11:24 -0200
Message-id: <20060116091124.PS01953100018@infradead.org>
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

- Tda988x parameters should be defined per tuner_param_type,
for each tuner_params array member.

Signed-off-by: Michael Krufky <mkrufky@m1k.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 include/media/tuner-types.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/media/tuner-types.h b/include/media/tuner-types.h
index 64b16b1..7566931 100644
--- a/include/media/tuner-types.h
+++ b/include/media/tuner-types.h
@@ -19,6 +19,7 @@ struct tuner_range {
 
 struct tuner_params {
 	enum param_type type;
+	unsigned int tda988x;
 	unsigned char config; /* to be moved into struct tuner_range for dvb-pll merge */
 
 	unsigned int count;
@@ -27,7 +28,6 @@ struct tuner_params {
 
 struct tunertype {
 	char *name;
-	unsigned int has_tda988x:1;
 	struct tuner_params *params;
 };
 

