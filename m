Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965794AbWCTQJY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965794AbWCTQJY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 11:09:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965793AbWCTQJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 11:09:22 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:22680 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S966317AbWCTPOg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:14:36 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Mike Isely <isely@pobox.com>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 019/141] V4L/DVB (3418): Cause tda9887 to use
	I2C_DRIVERID_TDA9887
Date: Mon, 20 Mar 2006 12:08:40 -0300
Message-id: <20060320150840.PS204922000019@infradead.org>
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

From: Mike Isely <isely@pobox.com>
Date: 1138043467 -0200

- The tda9887 has an I2C id reserved for it, but it hasn't been using
it.  Probably an oversight.  Fixed with this patch.

Signed-off-by: Mike Isely <isely@pobox.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/tda9887.c b/drivers/media/video/tda9887.c
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

