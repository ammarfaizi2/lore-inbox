Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263307AbUDWAjj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263307AbUDWAjj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 20:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263364AbUDWAjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 20:39:39 -0400
Received: from 66.159.164.68.adsl.snet.net ([66.159.164.68]:47272 "EHLO
	mail.bscnet.com") by vger.kernel.org with ESMTP id S263307AbUDWAjf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 20:39:35 -0400
Message-ID: <01b801c428cb$737005d0$0900a8c0@bobhitt>
From: "Bobby Hitt" <Bob.Hitt@bscnet.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Graphics Mode Woes
Date: Thu, 22 Apr 2004 20:39:32 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm attempting to get linux 2.6.5 to go into 1024x768x64k mode with my
NVidia GEForce card. Under 2.4.25, it works fine with "vga=791" in my
lilo.conf file. Here's what's in the log:

Apr 22 17:19:09 gateway kernel: vesafb: framebuffer at 0xf0000000, mapped to
0xe080d000, size 3072k
Apr 22 17:19:09 gateway kernel: vesafb: mode is 1024x768x16,
linelength=2048, pages=0
Apr 22 17:19:09 gateway kernel: vesafb: protected mode interface info at
c000:c590
Apr 22 17:19:09 gateway kernel: vesafb: scrolling: redraw
Apr 22 17:19:09 gateway kernel: vesafb: directcolor: size=0:5:6:5,
shift=0:11:5:0
Apr 22 17:19:09 gateway kernel: Console: switching to colour frame buffer
device 128x48
Apr 22 17:19:09 gateway kernel: fb0: VESA VGA frame buffer device

Under 2.6.5:

Apr 22 17:57:58 gateway kernel: rivafb: nVidia device/chipset 10DE0110
Apr 22 17:57:58 gateway kernel: rivafb: Detected CRTC controller 0 being
used
Apr 22 17:57:58 gateway kernel: rivafb: RIVA MTRR set to ON
Apr 22 17:57:58 gateway kernel: rivafb: PCI nVidia NV10 framebuffer ver
0.9.5b (nVidiaGeForce2-M, 32MB @ 0xF0000000)
Apr 22 17:57:58 gateway kernel: vga16fb: initializing
Apr 22 17:57:58 gateway kernel: vga16fb: mapped to 0xc00a0000
Apr 22 17:57:58 gateway kernel: fb1: VGA16 VGA frame buffer device

Totally different output and no references to vesafb. With "vga=791" on
bootup the screen goes blank then switches to the normal graphics mode. Even
when I use "vga=ask" and I put in a valid number, the screen switches to
text mode momentarily then goes back to the normal graphics mode.

Here's the related portion of my .config file:

 #
# Graphics support
#
CONFIG_FB=y
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_IMSTT is not set
CONFIG_FB_VGA16=y
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_HGA is not set
CONFIG_FB_RIVA=y
# CONFIG_FB_I810 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON_OLD is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_PCI_CONSOLE=y
CONFIG_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
# CONFIG_FONT_6x11 is not set
CONFIG_FONT_PEARL_8x8=y
CONFIG_FONT_ACORN_8x8=y
# CONFIG_FONT_MINI_4x6 is not set
# CONFIG_FONT_SUN8x16 is not set
# CONFIG_FONT_SUN12x22 is not set

#
# Logo configuration
#
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y

Any help or suggestions are appreciated,

Bobby

