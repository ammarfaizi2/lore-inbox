Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbVDRCIy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbVDRCIy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 22:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261599AbVDRCIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 22:08:54 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:53766 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261602AbVDRCIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 22:08:50 -0400
Date: Mon, 18 Apr 2005 04:08:48 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Luca Risolia <luca.risolia@studio.unibo.it>
Cc: linux-usb-devel@lists.sourceforge.net, gregkh@suse.de,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/usb/media/sn9c102_core.c: make 2 functions static
Message-ID: <20050418020848.GC3625@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes two needlessly global functions static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/usb/media/sn9c102_core.c   |    4 ++--
 drivers/usb/media/sn9c102_sensor.h |    2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

--- linux-2.6.12-rc2-mm3-full/drivers/usb/media/sn9c102_sensor.h.old	2005-04-18 03:14:54.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/usb/media/sn9c102_sensor.h	2005-04-18 03:15:05.000000000 +0200
@@ -145,8 +145,6 @@
 */
 
 /* The "try" I2C I/O versions are used when probing the sensor */
-extern int sn9c102_i2c_try_write(struct sn9c102_device*,struct sn9c102_sensor*,
-                                 u8 address, u8 value);
 extern int sn9c102_i2c_try_read(struct sn9c102_device*,struct sn9c102_sensor*,
                                 u8 address);
 
--- linux-2.6.12-rc2-mm3-full/drivers/usb/media/sn9c102_core.c.old	2005-04-18 03:15:13.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/usb/media/sn9c102_core.c	2005-04-18 03:15:50.000000000 +0200
@@ -429,7 +429,7 @@
 }
 
 
-int 
+static int 
 sn9c102_i2c_try_write(struct sn9c102_device* cam,
                       struct sn9c102_sensor* sensor, u8 address, u8 value)
 {
@@ -785,7 +785,7 @@
 }
 
 
-int sn9c102_stream_interrupt(struct sn9c102_device* cam)
+static int sn9c102_stream_interrupt(struct sn9c102_device* cam)
 {
 	int err = 0;
 

