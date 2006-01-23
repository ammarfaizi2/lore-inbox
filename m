Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964938AbWAWU25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964938AbWAWU25 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 15:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964946AbWAWU2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 15:28:21 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:34757 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964936AbWAWU1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 15:27:50 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       akpm@osdl.org, Markus Rechberger <mrechberger@gmail.com>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 13/16] Missing break statement on tuner-core
Date: Mon, 23 Jan 2006 18:24:45 -0200
Message-id: <20060123202445.PS35254700013@infradead.org>
In-Reply-To: <20060123202404.PS66974000000@infradead.org>
References: <20060123202404.PS66974000000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Rechberger <mrechberger@gmail.com>

- default_tuner_init was called twice due to a missing break statement.

Signed-off-by: Markus Rechberger <mrechberger@gmail.com>
Acked-by: Michael Krufky <mkrufky@m1k.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/tuner-core.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/media/video/tuner-core.c b/drivers/media/video/tuner-core.c
index 2995b22..e6bcd4b 100644
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

