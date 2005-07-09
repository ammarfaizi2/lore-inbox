Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263044AbVGIAql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263044AbVGIAql (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 20:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263030AbVGIAoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 20:44:14 -0400
Received: from smtp4.brturbo.com.br ([200.199.201.180]:18310 "EHLO
	smtp4.brturbo.com.br") by vger.kernel.org with ESMTP
	id S263039AbVGIAm7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 20:42:59 -0400
Message-ID: <42CF1D92.8050503@brturbo.com.br>
Date: Fri, 08 Jul 2005 21:42:58 -0300
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
User-Agent: Mozilla Thunderbird 1.0.2-3mdk (X11/20050322)
X-Accept-Language: pt-br, pt, es, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux and Kernel Video <video4linux-list@redhat.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/14 2.6.13-rc2-mm1] V4L I2C BT832
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/mixed;
 boundary="------------030609020002080306050401"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030609020002080306050401
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


--------------030609020002080306050401
Content-Type: text/x-patch;
 name="v4l_i2c-bt832.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="v4l_i2c-bt832.diff"

- Removed unused structures.

Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

 linux/drivers/media/video/bt832.c |   12 ------------
 1 files changed, 12 deletions(-)

diff -u linux-2.6.13/drivers/media/video/bt832.c linux/drivers/media/video/bt832.c
--- linux-2.6.13/drivers/media/video/bt832.c	2005-07-06 00:46:33.000000000 -0300
+++ linux/drivers/media/video/bt832.c	2005-07-07 19:56:44.000000000 -0300
@@ -138,25 +138,13 @@
 
         bt832_hexdump(i2c_client_s,buf);
 
-#if 0
-	// Full 30/25 Frame rate
-	printk("Full 30/25 Frame rate\n");
-	buf[0]=BT832_VP_CONTROL0; // Reg.39
-        buf[1]= 0x00;
-        if (2 != (rc = i2c_master_send(i2c_client_s,buf,2)))
-                printk("bt832: i2c i/o error FFR: rc == %d (should be 2)\n",rc);
 
-        bt832_hexdump(i2c_client_s,buf);
-#endif
-
-#if 1
 	// for testing (even works when no camera attached)
 	printk("bt832: *** Generate NTSC M Bars *****\n");
 	buf[0]=BT832_VP_TESTCONTROL0; // Reg. 42
 	buf[1]=3; // Generate NTSC System M bars, Generate Frame timing internally
         if (2 != (rc = i2c_master_send(i2c_client_s,buf,2)))
                 printk("bt832: i2c i/o error MBAR: rc == %d (should be 2)\n",rc);
-#endif
 
 	printk("Bt832: Camera Present: %s\n",
 		(buf[1+BT832_CAM_STATUS] & BT832_56_CAMERA_PRESENT) ? "yes":"no");

--------------030609020002080306050401--
