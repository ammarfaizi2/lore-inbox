Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966799AbWCTPVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966799AbWCTPVF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966807AbWCTPVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:21:05 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:41954 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S966798AbWCTPVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:21:02 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Markus Rechberger <mrechberger@gmail.com>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 027/141] V4L/DVB (3429): Missing break statement on
	tuner-core
Date: Mon, 20 Mar 2006 12:08:41 -0300
Message-id: <20060320150841.PS527439000027@infradead.org>
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

From: Markus Rechberger <mrechberger@gmail.com>
Date: 1138043469 -0200

- default_tuner_init was called twice due to a missing break statement.

Signed-off-by: Markus Rechberger <mrechberger@gmail.com>
Acked-by: Michael Krufky <mkrufky@m1k.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/tuner-core.c b/drivers/media/video/tuner-core.c
diff --git a/drivers/media/video/tuner-core.c b/drivers/media/video/tuner-core.c
index af3e7bb..cd2d5a7 100644
--- a/drivers/media/video/tuner-core.c
+++ b/drivers/media/video/tuner-core.c
@@ -216,6 +216,7 @@ static void set_type(struct i2c_client *
 		buffer[3] = 0xa4;
 		i2c_master_send(c,buffer,4);
 		default_tuner_init(c);
+		break;
 	default:
 		default_tuner_init(c);
 		break;

