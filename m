Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262359AbTIVXha (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 19:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263036AbTIVXh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 19:37:27 -0400
Received: from mail.kroah.org ([65.200.24.183]:1441 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262359AbTIVXae convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 19:30:34 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10642734181751@kroah.com>
Subject: Re: [PATCH] i2c driver fixes for 2.6.0-test5
In-Reply-To: <10642734183644@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 22 Sep 2003 16:30:18 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1153.85.5, 2003/08/27 15:32:59-07:00, hirofumi@mail.parknet.co.jp

[PATCH] DEVICE_NAME_SIZE/_HALF removal (I2C related, but fb stuff)


 drivers/video/matrox/i2c-matroxfb.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/video/matrox/i2c-matroxfb.c b/drivers/video/matrox/i2c-matroxfb.c
--- a/drivers/video/matrox/i2c-matroxfb.c	Mon Sep 22 16:16:30 2003
+++ b/drivers/video/matrox/i2c-matroxfb.c	Mon Sep 22 16:16:30 2003
@@ -111,7 +111,7 @@
 	b->mask.data = data;
 	b->mask.clock = clock;
 	b->adapter = matrox_i2c_adapter_template;
-	snprintf(b->adapter.name, DEVICE_NAME_SIZE, name,
+	snprintf(b->adapter.name, I2C_NAME_SIZE, name,
 		minfo->fbcon.node);
 	i2c_set_adapdata(&b->adapter, b);
 	b->adapter.algo_data = &b->bac;

