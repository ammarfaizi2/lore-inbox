Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264647AbSJTW0E>; Sun, 20 Oct 2002 18:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264649AbSJTW0D>; Sun, 20 Oct 2002 18:26:03 -0400
Received: from starcraft.mweb.co.za ([196.2.45.78]:1454 "EHLO
	starcraft.mweb.co.za") by vger.kernel.org with ESMTP
	id <S264647AbSJTWZ7>; Sun, 20 Oct 2002 18:25:59 -0400
From: Bongani <bhlope@mweb.co.za>
To: kraxel@bytesex.org
Subject: [PATCH RESEND] 2.5.44 bttv-driver.c
Date: Mon, 21 Oct 2002 00:32:54 +0200
User-Agent: KMail/1.4.7
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_W8ys9JejBMWvHrj"
Message-Id: <200210210032.54080.bhlope@mweb.co.za>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_W8ys9JejBMWvHrj
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

Hi Gerd

Sorry it looks like Kmail broke the patch. I have attached it instead

Cheers
--Boundary-00=_W8ys9JejBMWvHrj
Content-Type: text/x-diff;
  charset="us-ascii";
  name="bttv.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="bttv.patch"

--- linux-2.5/drivers/media/video/bttv-driver.c.old	2002-10-21 00:08:50.000000000 +0200
+++ linux-2.5/drivers/media/video/bttv-driver.c	2002-10-21 00:09:17.000000000 +0200
@@ -813,7 +813,7 @@
 	i2c_mux = mux = (btv->audio & AUDIO_MUTE) ? AUDIO_OFF : btv->audio;
 	if (btv->opt_automute && !signal && !btv->radio_user)
 		mux = AUDIO_OFF;
-	printk("bttv%d: amux: mode=%d audio=%d signal=%s mux=%d/%d irq=%s\n",
+	dprintk(KERN_DEBUG "bttv%d: amux: mode=%d audio=%d signal=%s mux=%d/%d irq=%s\n",
 	       btv->nr, mode, btv->audio, signal ? "yes" : "no",
 	       mux, i2c_mux, in_interrupt() ? "yes" : "no");
 

--Boundary-00=_W8ys9JejBMWvHrj--

