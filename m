Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264418AbTLQOVT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 09:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264419AbTLQOVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 09:21:19 -0500
Received: from web41104.mail.yahoo.com ([66.218.93.20]:23343 "HELO
	web41104.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264418AbTLQOVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 09:21:14 -0500
Message-ID: <20031217142113.65682.qmail@web41104.mail.yahoo.com>
Date: Wed, 17 Dec 2003 06:21:13 -0800 (PST)
From: Kent Hunt <kenthunt@yahoo.com>
Subject: 2.4.23 atyfb doesn't work on Presario 1700
To: lk <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1717168656-1071670873=:64788"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-1717168656-1071670873=:64788
Content-Type: text/plain; charset=us-ascii
Content-Id: 
Content-Disposition: inline

Hi,

        I had atyfb working perfectly with stock
kernel 2.4.21 and
perhaps earlier kernels. The reason I don't recall if
it worked with
earlier kernels is because my HD crashed. I cannot
even find out what
was the configuration that made it work.
        I cannot make it work with the new atyfb in
2.4.23 either.


#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y

#
# Frame-buffer support
#
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB_ATY=y
CONFIG_FB_ATY_CT=y
CONFIG_FB_ATY_GENERIC_LCD=y
CONFIG_FBCON_ADVANCED=y
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB24=y
CONFIG_FBCON_CFB32=y
CONFIG_FBCON_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

My laptop is a Presario 1700.

01:00.0 VGA compatible controller: ATI Technologies
Inc Rage Mobility P/M AGP 2x (rev 64)
01:00.0 Class 0300: 1002:4c4d (rev 64)


In addition, should this patch be applied? lspci says
I have an AGP and
the id code is 4c4d.

--- linux-2.4.23-acpi/drivers/video/aty/atyfb_base.c  
 2003-12-14 12:09:09.000000000 -0500
+++
linux-2.4.23-fb/drivers/video/aty/atyfb_base_orig.c
2003-12-13 19:04:06.000000000 -0500
@@ -376,8 +376,8 @@
     { 0x4c50, 0x4c50, 0x00, 0x00, m64n_ltp_p,   230,
100, 100, M64F_GT | M64F_INTEGRATED | M64F_RESET
_3D | M64F_GTB_DSP | M64F_EXTRA_BRIGHT},
 
     /* 3D RAGE Mobility */
-    { 0x4c4d, 0x4c4d, 0x00, 0x00, m64n_mob_p,   230, 
83, 125, M64F_GT | M64F_INTEGRATED | M64F_RESET
_3D | M64F_GTB_DSP | M64F_MOBIL_BUS |
M64F_EXTRA_BRIGHT},
-    { 0x4c4e, 0x4c4e, 0x00, 0x00, m64n_mob_a,   230, 
83, 125, M64F_GT | M64F_INTEGRATED | M64F_RESET
_3D | M64F_GTB_DSP | M64F_MOBIL_BUS |
M64F_EXTRA_BRIGHT},
+    { 0x4c4d, 0x4c4d, 0x00, 0x00, m64n_mob_a,   230, 
83, 125, M64F_GT | M64F_INTEGRATED | M64F_RESET
_3D | M64F_GTB_DSP | M64F_MOBIL_BUS |
M64F_EXTRA_BRIGHT},
+    { 0x4c4e, 0x4c4e, 0x00, 0x00, m64n_mob_p,   230, 
83, 125, M64F_GT | M64F_INTEGRATED | M64F_RESET
_3D | M64F_GTB_DSP | M64F_MOBIL_BUS |
M64F_EXTRA_BRIGHT},
 #endif /* CONFIG_FB_ATY_CT */
 };

Kent

__________________________________
Do you Yahoo!?
New Yahoo! Photos - easier uploading and sharing.
http://photos.yahoo.com/
--0-1717168656-1071670873=:64788
Content-Type: text/plain; name="atyfb.txt"
Content-Description: atyfb.txt
Content-Disposition: inline; filename="atyfb.txt"

Hi,

	I had atyfb working perfectly with stock kernel 2.4.21 and
perhaps earlier kernels. The reason I don't recall if it worked with
earlier kernels is because my HD crashed. I cannot even find out what
was the configuration that made it work.
	I cannot make it work with the new atyfb in 2.4.23 either.


#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y

#
# Frame-buffer support
#
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB_ATY=y
CONFIG_FB_ATY_CT=y
CONFIG_FB_ATY_GENERIC_LCD=y
CONFIG_FBCON_ADVANCED=y
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB24=y
CONFIG_FBCON_CFB32=y
CONFIG_FBCON_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

My laptop is a Presario 1700.

01:00.0 VGA compatible controller: ATI Technologies Inc Rage Mobility P/M AGP 2x (rev 64)
01:00.0 Class 0300: 1002:4c4d (rev 64)


In addition, should this patch be applied? lspci says I have an AGP and
the id code is 4c4d.

--- linux-2.4.23-acpi/drivers/video/aty/atyfb_base.c	2003-12-14 12:09:09.000000000 -0500
+++ linux-2.4.23-fb/drivers/video/aty/atyfb_base_orig.c	2003-12-13 19:04:06.000000000 -0500
@@ -376,8 +376,8 @@
     { 0x4c50, 0x4c50, 0x00, 0x00, m64n_ltp_p,   230, 100, 100, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_EXTRA_BRIGHT},
 
     /* 3D RAGE Mobility */
-    { 0x4c4d, 0x4c4d, 0x00, 0x00, m64n_mob_p,   230,  83, 125, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_MOBIL_BUS | M64F_EXTRA_BRIGHT},
-    { 0x4c4e, 0x4c4e, 0x00, 0x00, m64n_mob_a,   230,  83, 125, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_MOBIL_BUS | M64F_EXTRA_BRIGHT},
+    { 0x4c4d, 0x4c4d, 0x00, 0x00, m64n_mob_a,   230,  83, 125, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_MOBIL_BUS | M64F_EXTRA_BRIGHT},
+    { 0x4c4e, 0x4c4e, 0x00, 0x00, m64n_mob_p,   230,  83, 125, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_MOBIL_BUS | M64F_EXTRA_BRIGHT},
 #endif /* CONFIG_FB_ATY_CT */
 };
 

--0-1717168656-1071670873=:64788--
