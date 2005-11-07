Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932424AbVKGDSp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424AbVKGDSp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 22:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932430AbVKGDSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 22:18:43 -0500
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:42900 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932424AbVKGDSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 22:18:14 -0500
From: mchehab@brturbo.com.br
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, video4linux-list@redhat.com,
       Tyler Trafford <tatrafford@comcast.net>
Subject: [Patch 10/20] V4L(911) Added support for ntsc 4 43 video standard
Date: Mon, 07 Nov 2005 00:58:09 -0200
Message-Id: <1131333341.25215.27.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1-2mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tyler Trafford <tatrafford@comcast.net>

- Added support for NTSC 4.43 video standard.

Signed-off-by: Tyler Trafford <tatrafford@comcast.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

-----------------

 drivers/media/video/saa7134/saa7134-dvb.c |    2 +-
 include/linux/videodev2.h                 |    4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

--- hg.orig/drivers/media/video/saa7134/saa7134-dvb.c
+++ hg/drivers/media/video/saa7134/saa7134-dvb.c
@@ -749,7 +749,7 @@ static void philips_tda827xa_pll_sleep(u
 	struct saa7134_dev *dev = fe->dvb->priv;
 	static u8 tda827xa_sleep[] = { 0x30, 0x90};
 	struct i2c_msg tuner_msg = {.addr = addr,.flags = 0,.buf = tda827xa_sleep,
-			            .len = sizeof(tda827xa_sleep) };
+				    .len = sizeof(tda827xa_sleep) };
 	i2c_transfer(&dev->i2c_adap, &tuner_msg, 1);
 
 }
--- hg.orig/include/linux/videodev2.h
+++ hg/include/linux/videodev2.h
@@ -627,6 +627,7 @@ typedef __u64 v4l2_std_id;
 
 #define V4L2_STD_NTSC_M         ((v4l2_std_id)0x00001000)
 #define V4L2_STD_NTSC_M_JP      ((v4l2_std_id)0x00002000)
+#define V4L2_STD_NTSC_443       ((v4l2_std_id)0x00004000)
 
 #define V4L2_STD_SECAM_B        ((v4l2_std_id)0x00010000)
 #define V4L2_STD_SECAM_D        ((v4l2_std_id)0x00020000)
@@ -664,7 +665,8 @@ typedef __u64 v4l2_std_id;
 
 #define V4L2_STD_525_60		(V4L2_STD_PAL_M		|\
 				 V4L2_STD_PAL_60	|\
-				 V4L2_STD_NTSC)
+				 V4L2_STD_NTSC		|\
+				 V4L2_STD_NTSC_443)
 #define V4L2_STD_625_50		(V4L2_STD_PAL		|\
 				 V4L2_STD_PAL_N		|\
 				 V4L2_STD_PAL_Nc	|\


	

	
		
_______________________________________________________ 
Yahoo! Acesso Grátis: Internet rápida e grátis. 
Instale o discador agora!
http://br.acesso.yahoo.com/

