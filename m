Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261250AbVCFAB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbVCFAB4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 19:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbVCFABv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 19:01:51 -0500
Received: from mail.gmx.net ([213.165.64.20]:21997 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261250AbVCEXyo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 18:54:44 -0500
X-Authenticated: #20450766
Date: Sun, 6 Mar 2005 00:53:56 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: linux-kernel@vger.kernel.org, jim.hague@acm.org,
       linux-fbdev-devel@lists.sourceforge.net
Subject: [2.6.11 Permedia-2 Framebuffer] driver broken (?).
Message-ID: <Pine.LNX.4.60.0503052355320.12643@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Worked on 2.6.10-rc2. With 2.6.11 during boot upon switching to fb, text 
becomes orange, penguins look sick (not sharp). X starts and runs normal 
(doesn't use fb), switching to vt not possible any more. Disabling 
fb-console in kernel config fixes VTs. Reverting pm2fb.c fixes the 
problem.

No unusual output in dmesg.

System: Compaq AP400 with a TI card:

01:00.0 VGA compatible controller: Texas Instruments TVP4020 [Permedia 2] (rev 11) (prog-if 00 [VGA])
	Subsystem: Elsa AG GLoria Synergy
	Flags: bus master, 66Mhz, medium devsel, latency 66, IRQ 22
	Memory at 51000000 (32-bit, non-prefetchable) [size=128K]
	Memory at 50000000 (32-bit, non-prefetchable) [size=8M]
	Memory at 50800000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [4c] Power Management version 1
	Capabilities: [40] AGP version 1.0

CPUs: 2 * Pentium II 400MHz full cpuinfo available on request)

.config (fb / video):

CONFIG_FB=y
CONFIG_FB_MODE_HELPERS=y
# CONFIG_FB_TILEBLITTING is not set
# CONFIG_FB_CIRRUS is not set
CONFIG_FB_PM2=y
CONFIG_FB_PM2_FIFO_DISCONNECT=y
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_VESA is not set
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_HGA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I810 is not set
# CONFIG_FB_INTEL is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON_OLD is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SAVAGE is not set
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
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

#
# Logo configuration
#
CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set

Thanks
Guennadi
---
Guennadi Liakhovetski

