Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261976AbVCHK72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbVCHK72 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 05:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261971AbVCHK5h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 05:57:37 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:24043 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262000AbVCHKzb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 05:55:31 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 8 Mar 2005 11:49:15 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch] Videotext: use I2C_CLIENT_INSMOD macro
Message-ID: <20050308104915.GA30971@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the patch below simplifies the videotext drivers saa5246a and saa5249 by
using the I2C_CLIENT_INSMOD macro.

Thanks to Kai Volkmar.

Michael

Signed-off-by: Michael Geng <linux@michaelgeng.de>
Signed-off-by: Gerd Knorr <kraxel@bytesex.org>
---
 drivers/media/video/saa5246a.c |   13 +------------
 drivers/media/video/saa5249.c  |   13 +------------
 2 files changed, 2 insertions(+), 24 deletions(-)

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

-- 
#define printk(args...) fprintf(stderr, ## args)
