Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262956AbTCWIFU>; Sun, 23 Mar 2003 03:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262963AbTCWIEM>; Sun, 23 Mar 2003 03:04:12 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:61707 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262962AbTCWIED>;
	Sun, 23 Mar 2003 03:04:03 -0500
Date: Sun, 23 Mar 2003 00:14:57 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Subject: Re: [PATCH] Yet more i2c driver changes for 2.5.65
Message-ID: <20030323081456.GH26145@kroah.com>
References: <20030323080719.GD26145@kroah.com> <20030323081431.GF26145@kroah.com> <20030323081445.GG26145@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030323081445.GG26145@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.889.354.16, 2003/03/22 23:29:40-08:00, greg@kroah.com

i2c: fix up drivers/ieee1394/pcilynx.c due to previous i2c changes.


diff -Nru a/drivers/ieee1394/pcilynx.c b/drivers/ieee1394/pcilynx.c
--- a/drivers/ieee1394/pcilynx.c	Sun Mar 23 00:10:49 2003
+++ b/drivers/ieee1394/pcilynx.c	Sun Mar 23 00:10:49 2003
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
 
 
