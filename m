Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263064AbVGIA54@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263064AbVGIA54 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 20:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263057AbVGIAzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 20:55:46 -0400
Received: from smtp1.brturbo.com.br ([200.199.201.163]:35811 "EHLO
	smtp1.brturbo.com.br") by vger.kernel.org with ESMTP
	id S263060AbVGIAyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 20:54:51 -0400
Message-ID: <42CF2058.6060101@brturbo.com.br>
Date: Fri, 08 Jul 2005 21:54:48 -0300
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
User-Agent: Mozilla Thunderbird 1.0.2-3mdk (X11/20050322)
X-Accept-Language: pt-br, pt, es, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: LKML <linux-kernel@vger.kernel.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>
Subject: [PATCH 14/14 2.6.13-rc2-mm1] V4L TV EEPROM
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/mixed;
 boundary="------------060209040206030202020008"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060209040206030202020008
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


--------------060209040206030202020008
Content-Type: text/x-patch;
 name="v4l_tveeprom.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="v4l_tveeprom.diff"

- Eliminated unused code.

Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

 linux/drivers/media/video/tveeprom.c |    9 +--------
 1 files changed, 1 insertion(+), 8 deletions(-)

diff -u linux-2.6.13/drivers/media/video/tveeprom.c linux/drivers/media/video/tveeprom.c
--- linux-2.6.13/drivers/media/video/tveeprom.c	2005-07-06 00:46:33.000000000 -0300
+++ linux/drivers/media/video/tveeprom.c	2005-07-07 21:18:03.000000000 -0300
@@ -400,14 +400,6 @@
 		}
 	}
 
-#if 0
-	if (t_format < sizeof(hauppauge_tuner_fmt)/sizeof(struct HAUPPAUGE_TUNER_FMT)) {
-		tvee->tuner_formats = hauppauge_tuner_fmt[t_format].id;
-		t_fmt_name = hauppauge_tuner_fmt[t_format].name;
-	} else {
-		t_fmt_name = "<unknown>";
-	}
-#endif
 
 	TVEEPROM_KERN_INFO("Hauppauge: model = %d, rev = %s, serial# = %d\n",
 		   tvee->model,
@@ -482,6 +474,7 @@
 	0xa0 >> 1,
 	I2C_CLIENT_END,
 };
+
 I2C_CLIENT_INSMOD;
 
 struct i2c_driver i2c_driver_tveeprom;

--------------060209040206030202020008--
