Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262124AbVCUXGm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262124AbVCUXGm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 18:06:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262187AbVCUXDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 18:03:46 -0500
Received: from fire.osdl.org ([65.172.181.4]:17617 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262124AbVCUW7q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 17:59:46 -0500
Date: Mon, 21 Mar 2005 14:59:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org, jim.hague@acm.org,
       linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [2.6.11 Permedia-2 Framebuffer] driver broken (?).
Message-Id: <20050321145936.6f742d89.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.60.0503052355320.12643@poirot.grange>
References: <Pine.LNX.4.60.0503052355320.12643@poirot.grange>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
>
> Hi
> 
> Worked on 2.6.10-rc2. With 2.6.11 during boot upon switching to fb, text 
> becomes orange, penguins look sick (not sharp). X starts and runs normal 
> (doesn't use fb), switching to vt not possible any more. Disabling 
> fb-console in kernel config fixes VTs. Reverting pm2fb.c fixes the 
> problem.

Guennadi, could you please confirm that

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc1/2.6.12-rc1-mm1/broken-out/pm2fb-x-and-vt-switching-crash-fix.patch

fixes this one?

Thanks.

> No unusual output in dmesg.
> 
> System: Compaq AP400 with a TI card:
> 
> 01:00.0 VGA compatible controller: Texas Instruments TVP4020 [Permedia 2] (rev 11) (prog-if 00 [VGA])
> 	Subsystem: Elsa AG GLoria Synergy
> 	Flags: bus master, 66Mhz, medium devsel, latency 66, IRQ 22
> 	Memory at 51000000 (32-bit, non-prefetchable) [size=128K]
> 	Memory at 50000000 (32-bit, non-prefetchable) [size=8M]
> 	Memory at 50800000 (32-bit, non-prefetchable) [size=8M]
> 	Expansion ROM at <unassigned> [disabled] [size=64K]
> 	Capabilities: [4c] Power Management version 1
> 	Capabilities: [40] AGP version 1.0
> 
> CPUs: 2 * Pentium II 400MHz full cpuinfo available on request)
> 
> .config (fb / video):
> 
> CONFIG_FB=y
> CONFIG_FB_MODE_HELPERS=y
> # CONFIG_FB_TILEBLITTING is not set
> # CONFIG_FB_CIRRUS is not set
> CONFIG_FB_PM2=y
> CONFIG_FB_PM2_FIFO_DISCONNECT=y
> # CONFIG_FB_CYBER2000 is not set
> # CONFIG_FB_ASILIANT is not set
> # CONFIG_FB_IMSTT is not set
> # CONFIG_FB_VGA16 is not set
> # CONFIG_FB_VESA is not set
> CONFIG_VIDEO_SELECT=y
> # CONFIG_FB_HGA is not set
> # CONFIG_FB_RIVA is not set
> # CONFIG_FB_I810 is not set
> # CONFIG_FB_INTEL is not set
> # CONFIG_FB_MATROX is not set
> # CONFIG_FB_RADEON_OLD is not set
> # CONFIG_FB_RADEON is not set
> # CONFIG_FB_ATY128 is not set
> # CONFIG_FB_ATY is not set
> # CONFIG_FB_SAVAGE is not set
> # CONFIG_FB_SIS is not set
> # CONFIG_FB_NEOMAGIC is not set
> # CONFIG_FB_KYRO is not set
> # CONFIG_FB_3DFX is not set
> # CONFIG_FB_VOODOO1 is not set
> # CONFIG_FB_TRIDENT is not set
> # CONFIG_FB_VIRTUAL is not set
> 
> #
> # Console display driver support
> #
> CONFIG_VGA_CONSOLE=y
> # CONFIG_MDA_CONSOLE is not set
> CONFIG_DUMMY_CONSOLE=y
> CONFIG_FRAMEBUFFER_CONSOLE=y
> # CONFIG_FONTS is not set
> CONFIG_FONT_8x8=y
> CONFIG_FONT_8x16=y
> 
> #
> # Logo configuration
> #
> CONFIG_LOGO=y
> # CONFIG_LOGO_LINUX_MONO is not set
> # CONFIG_LOGO_LINUX_VGA16 is not set
> CONFIG_LOGO_LINUX_CLUT224=y
> # CONFIG_BACKLIGHT_LCD_SUPPORT is not set
> 
> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
