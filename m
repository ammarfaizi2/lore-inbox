Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261326AbTCYBo2>; Mon, 24 Mar 2003 20:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261351AbTCYB2b>; Mon, 24 Mar 2003 20:28:31 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:12304 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261323AbTCYB2B>;
	Mon, 24 Mar 2003 20:28:01 -0500
Subject: Re: [PATCH] i2c driver changes for 2.5.66
In-reply-to: <10485563161165@kroah.com>
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
From: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Mon, 24 Mar 2003 17:38 -0800
Message-id: <10485563161329@kroah.com>
X-mailer: gregkh_patchbomb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.889.355.16, 2003/03/22 23:29:40-08:00, greg@kroah.com

i2c: fix up drivers/ieee1394/pcilynx.c due to previous i2c changes.


 drivers/ieee1394/pcilynx.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)


diff -Nru a/drivers/ieee1394/pcilynx.c b/drivers/ieee1394/pcilynx.c
--- a/drivers/ieee1394/pcilynx.c	Mon Mar 24 17:27:16 2003
+++ b/drivers/ieee1394/pcilynx.c	Mon Mar 24 17:27:16 2003
@@ -138,10 +138,12 @@
 }; 
 
 static struct i2c_adapter bit_ops = {
-	.name			= "PCILynx I2C adapter",
 	.id 			= 0xAA, //FIXME: probably we should get an id in i2c-id.h
 	.client_register	= bit_reg,
 	.client_unregister	= bit_unreg,
+	.dev			= {
+		.name		= "PCILynx I2C",
+	},
 };
 
 

