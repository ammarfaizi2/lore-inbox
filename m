Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319125AbSH2HQi>; Thu, 29 Aug 2002 03:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319128AbSH2HQi>; Thu, 29 Aug 2002 03:16:38 -0400
Received: from ibm-1.MPA-Garching.MPG.DE ([130.183.83.31]:24253 "EHLO
	ibm-1.MPA-Garching.MPG.DE") by vger.kernel.org with ESMTP
	id <S319125AbSH2HQh>; Thu, 29 Aug 2002 03:16:37 -0400
Date: Thu, 29 Aug 2002 09:20:57 +0200
From: Sebastian Hanigk <shanigk@physik.tu-muenchen.de>
To: linux-kernel@vger.kernel.org
Subject: [radeonfb.c] little patch for cfb24 problem
Message-Id: <20020829092057.564f8251.shanigk@physik.tu-muenchen.de>
Organization: TU Muenchen
X-Mailer: Sylpheed version 0.8.2claws (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm using the radeonfb on my notebook and for some reason the last
kernel releases had a small typo in the radeonfb.c source. I've
included a small patch which I've used for the last releases.

Please cc: me in replies, I'm not subscribed to this list!

Regards,

Sebastian

--- linux-2.4.20-pre5/drivers/video/radeonfb.c~	2002-08-29 08:58:04.000000000 +0200
+++ linux-2.4.20-pre5/drivers/video/radeonfb.c	2002-08-29 09:12:40.000000000 +0200
@@ -1716,7 +1716,7 @@
                         disp->line_length = disp->var.xres_virtual * 2;
                         break;
 #endif  
-#ifdef FBCON_HAS_CFB32       
+#ifdef FBCON_HAS_CFB24
                 case 24:
                         disp->dispsw = &fbcon_cfb24;
                         disp->dispsw_data = &rinfo->con_cmap.cfb24;
