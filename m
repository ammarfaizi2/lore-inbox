Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315479AbSE2UoD>; Wed, 29 May 2002 16:44:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315481AbSE2UoC>; Wed, 29 May 2002 16:44:02 -0400
Received: from unet2-84.univie.ac.at ([131.130.232.84]:18560 "EHLO server.lan")
	by vger.kernel.org with ESMTP id <S315479AbSE2UoA>;
	Wed, 29 May 2002 16:44:00 -0400
From: Melchior FRANZ <a8603365@unet.univie.ac.at>
To: linux-kernel@vger.kernel.org
Subject: 2.5.19: tdfxfb broken
Date: Wed, 29 May 2002 22:43:09 +0200
User-Agent: KMail/1.4.5
X-PGP: http://www.unet.univie.ac.at/~a8603365/melchior.franz
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200205292243.11106@pflug3.gphy.univie.ac.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using the framebuffer on a 3dfx V3-3000 using the tdfxfb driver and
the following setup:

  append = "3 video=tdfx:1280x1024-8,nomtrr,font:SUN12x22"

This worked well for all 2.4.* kernels and all working 2.5.* kernels
so far. It doesn't work with 2.5.19. The screen remains all black
without any text being shown. Just the logo is shown in its original size
at the right position, but in wrong colors (e.g. the normally black
background around Tux is blue).

Graphics: Voodoo3 3000
Platform: Intel 80686
Compiler: gcc 2.95.2


  CONFIG_AGP=y
  CONFIG_AGP_VIA=y
  CONFIG_DRM=y
  CONFIG_DRM_TDFX=y
  CONFIG_VGA_CONSOLE=y
  CONFIG_VIDEO_SELECT=y
  CONFIG_FB=y
  CONFIG_DUMMY_CONSOLE=y
  CONFIG_VIDEO_SELECT=y
  CONFIG_FB_3DFX=y
  CONFIG_FBCON_ADVANCED=y
  CONFIG_FBCON_CFB8=y
  CONFIG_FBCON_CFB16=y
  CONFIG_FBCON_CFB24=y
  CONFIG_FBCON_CFB32=y
  # CONFIG_FBCON_ACCEL is not set    <===== [1]
  CONFIG_FBCON_FONTS=y
  CONFIG_FONT_SUN12x22=y


[1] changing hardware acceleration had no effect

m.
