Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964944AbWAWU25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964944AbWAWU25 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 15:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964938AbWAWU2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 15:28:24 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:42437 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964944AbWAWU2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 15:28:16 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       akpm@osdl.org, Mike Isely <isely@pobox.com>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 11/16] Cause tda9887 to use I2C_DRIVERID_TDA9887
Date: Mon, 23 Jan 2006 18:24:45 -0200
Message-id: <20060123202445.PS00543300011@infradead.org>
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

From: Mike Isely <isely@pobox.com>

- The tda9887 has an I2C id reserved for it, but it hasn't been using
it.  Probably an oversight.  Fixed with this patch.

Signed-off-by: Mike Isely <isely@pobox.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/tda9887.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/media/video/tda9887.c b/drivers/media/video/tda9887.c
index 5815649..7c71422 100644
--- a/drivers/media/video/tda9887.c
+++ b/drivers/media/video/tda9887.c
@@ -876,7 +876,7 @@ static int tda9887_resume(struct device 
 /* ----------------------------------------------------------------------- */
 
 static struct i2c_driver driver = {
-	.id             = -1, /* FIXME */
+	.id             = I2C_DRIVERID_TDA9887,
 	.attach_adapter = tda9887_probe,
 	.detach_client  = tda9887_detach,
 	.command        = tda9887_command,

