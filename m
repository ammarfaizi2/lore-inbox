Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbVCFQ4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbVCFQ4F (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 11:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261429AbVCFQ4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 11:56:04 -0500
Received: from xantronkunden2.de ([81.209.165.33]:32820 "EHLO
	kunden.xantronkunden2.de") by vger.kernel.org with ESMTP
	id S261426AbVCFQzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 11:55:55 -0500
Date: Sun, 6 Mar 2005 17:55:45 +0100
To: Gerd Knorr <kraxel@bytesex.org>
Cc: linux-kernel@vger.kernel.org, Kai Volkmar <kai.volkmar@nexgo.de>,
       Greg KH <greg@kroah.com>
Subject: Videotext: use I2C_CLIENT_INSMOD macro
Message-ID: <20050306165545.GA1534@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: linux@MichaelGeng.de (Michael Geng)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the patch below simplifies the videotext drivers saa5246a and saa5249 by using the
I2C_CLIENT_INSMOD macro.

Thanks to Kai Volkmar.

Michael

Signed-off-by: Michael Geng <linux@michaelgeng.de>

Common subdirectories: linux-2.6.11/drivers/media/video/cx88 and linux/drivers/media/video/cx88
Common subdirectories: linux-2.6.11/drivers/media/video/ovcamchip and linux/drivers/media/video/ovcamchip
diff -u linux-2.6.11/drivers/media/video/saa5246a.c linux/drivers/media/video/saa5246a.c
--- linux-2.6.11/drivers/media/video/saa5246a.c	Wed Mar  2 08:38:08 2005
+++ linux/drivers/media/video/saa5246a.c	Sun Mar  6 17:00:35 2005
@@ -65,18 +65,7 @@
 /* Addresses to scan */
 static unsigned short normal_i2c[]	 = { I2C_ADDRESS, I2C_CLIENT_END };
 static unsigned short normal_i2c_range[] = { I2C_CLIENT_END };
-static unsigned short probe[2]		 = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short probe_range[2]	 = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short ignore[2]		 = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short ignore_range[2]	 = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short force[2]		 = { I2C_CLIENT_END, I2C_CLIENT_END };
-
-static struct i2c_client_address_data addr_data = {
-	normal_i2c, normal_i2c_range,
-	probe, probe_range,
-	ignore, ignore_range,
-	force
-};
+I2C_CLIENT_INSMOD;
 
 static struct i2c_client client_template;
 
diff -u linux-2.6.11/drivers/media/video/saa5249.c linux/drivers/media/video/saa5249.c
--- linux-2.6.11/drivers/media/video/saa5249.c	Wed Mar  2 08:38:17 2005
+++ linux/drivers/media/video/saa5249.c	Sun Mar  6 17:01:35 2005
@@ -133,18 +133,7 @@
 /* Addresses to scan */
 static unsigned short normal_i2c[] = {34>>1,I2C_CLIENT_END};
 static unsigned short normal_i2c_range[] = {I2C_CLIENT_END};
-static unsigned short probe[2]        = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short probe_range[2]  = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short ignore[2]       = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short ignore_range[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short force[2]        = { I2C_CLIENT_END, I2C_CLIENT_END };
-
-static struct i2c_client_address_data addr_data = {
-	normal_i2c, normal_i2c_range, 
-	probe, probe_range, 
-	ignore, ignore_range, 
-	force
-};
+I2C_CLIENT_INSMOD;
 
 static struct i2c_client client_template;
 
Common subdirectories: linux-2.6.11/drivers/media/video/saa7134 and linux/drivers/media/video/saa7134
