Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270695AbTHOSZf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 14:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270713AbTHOSZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 14:25:35 -0400
Received: from mail.kroah.org ([65.200.24.183]:57474 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270695AbTHOSZa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 14:25:30 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10609719494170@kroah.com>
Subject: Re: [PATCH] Driver Core fixes for 2.6.0-test3
In-Reply-To: <10609719484044@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 15 Aug 2003 11:25:49 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1152.2.5, 2003/08/14 16:55:36-07:00, greg@kroah.com

Remove usage of struct device.name from bttv driver

I missed this on the i2c series of patches.


 drivers/media/video/bttv-if.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/media/video/bttv-if.c b/drivers/media/video/bttv-if.c
--- a/drivers/media/video/bttv-if.c	Fri Aug 15 11:15:56 2003
+++ b/drivers/media/video/bttv-if.c	Fri Aug 15 11:15:56 2003
@@ -315,7 +315,7 @@
 	memcpy(&btv->i2c_client, &bttv_i2c_client_template,
 	       sizeof(struct i2c_client));
 
-	sprintf(btv->i2c_adap.dev.name, "bt848 #%d", btv->nr);
+	sprintf(btv->i2c_adap.name, "bt848 #%d", btv->nr);
 	btv->i2c_adap.dev.parent = &btv->dev->dev;
 
         btv->i2c_algo.data = btv;

