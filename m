Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293221AbSBWVom>; Sat, 23 Feb 2002 16:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293223AbSBWVoc>; Sat, 23 Feb 2002 16:44:32 -0500
Received: from ubermail.mweb.co.za ([196.2.53.169]:3598 "EHLO
	ubermail.mweb.co.za") by vger.kernel.org with ESMTP
	id <S293222AbSBWVoX>; Sat, 23 Feb 2002 16:44:23 -0500
Subject: [PATH] kdev_t compilation fixes (Framebuffer)
From: Bongani Hlope <bonganilinux@mweb.co.za>
To: linux-kernel@vger.kernel.org
Cc: fero@drama.obuda.kando.hu, kraxel@goldbach.in-berlin.de
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.21mdk 
Date: 23 Feb 2002 23:57:16 +0200
Message-Id: <1014501451.3917.19.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I thinks these were missed during 2.5.2-pre6, Feren I hope you are
the right person to send the for the first patch (your name is listed as
the Maintainer),Gerd yours is listed for the second patch.

	--Bongani

--- linux-2.5/drivers/video/riva/fbdev.c        Thu Nov 15 00:52:20 2001
+++ linux-2.5-dev/drivers/video/riva/fbdev.c    Sat Feb 23 23:35:08 2002
@@ -1811,7 +1811,7 @@
        info = &rinfo->info;

        strcpy(info->modename, rinfo->drvr_name);
-       info->node = -1;
+       info->node = NODEV;
        info->flags = FBINFO_FLAG_DEFAULT;
        info->fbops = &riva_fb_ops;

--- linux-2.5/drivers/video/sis/sis_main.c      Thu Feb 21 23:56:03 2002
+++ linux-2.5-dev/drivers/video/sis/sis_main.c  Sat Feb 23 23:40:22 2002
@@ -2766,7 +2766,7 @@
        sisfb_crtc_to_var (&default_var);

        fb_info.changevar = NULL;
-       fb_info.node = -1;
+       fb_info.node = NODEV;
        fb_info.fbops = &sisfb_ops;
        fb_info.disp = &disp;
        fb_info.switch_con = &sisfb_switch;


