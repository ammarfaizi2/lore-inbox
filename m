Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261747AbUKPBUv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261747AbUKPBUv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 20:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbUKPBTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 20:19:44 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:14349 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261748AbUKPBTF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 20:19:05 -0500
Date: Tue, 16 Nov 2004 02:18:34 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: video4linux-list@redhat.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] move EXPORT_SYMBOL(bttv_i2c_call)
Message-ID: <20041116011834.GF4946@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below moves the EXPORT_SYMBOL(bttv_i2c_call) to the file where 
the actual function is.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm5-full/drivers/media/video/bttv-i2c.c.old	2004-11-16 01:38:11.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/media/video/bttv-i2c.c	2004-11-16 01:38:23.000000000 +0100
@@ -333,6 +333,7 @@
 		return;
 	bttv_call_i2c_clients(&bttvs[card], cmd, arg);
 }
+EXPORT_SYMBOL(bttv_i2c_call);
 
 static struct i2c_client bttv_i2c_client_template = {
 	I2C_DEVNAME("bttv internal"),
--- linux-2.6.10-rc1-mm5-full/drivers/media/video/bttv-if.c.old	2004-11-16 01:37:56.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/media/video/bttv-if.c	2004-11-16 01:38:05.000000000 +0100
@@ -41,7 +41,6 @@
 EXPORT_SYMBOL(bttv_read_gpio);
 EXPORT_SYMBOL(bttv_write_gpio);
 EXPORT_SYMBOL(bttv_get_gpio_queue);
-EXPORT_SYMBOL(bttv_i2c_call);
 
 /* ----------------------------------------------------------------------- */
 /* Exported functions - for other modules which want to access the         */

