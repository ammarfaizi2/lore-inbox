Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285850AbSBXLMR>; Sun, 24 Feb 2002 06:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286188AbSBXLL6>; Sun, 24 Feb 2002 06:11:58 -0500
Received: from gep73-211.bp01catv.broadband.hu ([213.222.137.66]:27142 "EHLO
	mail.sztalker.hu") by vger.kernel.org with ESMTP id <S285850AbSBXLLs>;
	Sun, 24 Feb 2002 06:11:48 -0500
Date: Sun, 24 Feb 2002 12:10:25 +0100
To: Bongani Hlope <bonganilinux@mweb.co.za>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kdev_t compilation fixes (Framebuffer)
Message-ID: <20020224121023.A31292@sztalker.hu>
In-Reply-To: <1014501626.4293.25.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1014501626.4293.25.camel@localhost.localdomain>; from bonganilinux@mweb.co.za on Sun, Feb 24, 2002 at 12:01:01AM +0200
From: Bakonyi Ferenc <fero@sztalker.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hi!

On Sun, Feb 24, 2002 at 12:01:01AM +0200, Bongani Hlope wrote:
> I thinks these were missed during 2.5.2-pre6, Feren I hope you are
> the right person to send the for the first patch (your name is listed as
> the Maintainer),Gerd yours is listed for the second patch.

Your patch is already included in the dj-tree, but it is missed from
Linus' tree. BTW Ani Joshi is listed as the maintainer, not me. :)

Best regards:
	Ferenc Bakonyi

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


