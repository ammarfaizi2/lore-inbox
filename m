Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270503AbTGSFsG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 01:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270498AbTGSFsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 01:48:06 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:62477 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id S270503AbTGSFsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 01:48:01 -0400
Date: Sat, 19 Jul 2003 08:02:27 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: "Michel Eyckmans \(MCE\)" <mce@pi.be>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test1 + matroxfb = unuusable VC
Message-ID: <20030719060227.GA5227@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
References: <200307182239.h6IMdhM6008840@jebril.pi.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307182239.h6IMdhM6008840@jebril.pi.be>
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michel Eyckmans (MCE) <mce@pi.be>
Date: Sat, Jul 19, 2003 at 12:39:43AM +0200
> 
> Greetz,
> 
> I'm using (or rather: trying to use) matroxfb on 2.6.0-test1 (2.5.72 had 
> the same problems) and am seeing the following:
> 
>  - The initial boot console works fine, but all other consoles have 
>    scrolling problems. The area to the right of any scrolled text is 
>    most often coloured white, whereas it should be black. When using vi, 
>    it's even worse: white rectangles all over the place.
> 
>  - Right after switching from X to a text console, the fill color is not
>    white, but sort of a folded ghost image of part of my X display;
> 
>  - Scrolling is not continuous: keep <enter> pushed down, and every so 
>    often a jump of about 1/3 of the hight of the screen occurs, combined
>    with a few lines that do use the correct black background;
> 
>  - Backspacing only works when the cursor is positioned at the end of the 
>    command line. Anywhere else the positions to the right of the cursor 
>    are not repainted.
> 
> I'm using these settings: video=matroxfb:vesa:0x11A,fh:92k,fv:160"
> 
I can't say that I see any of that.

I'm using a G450 (AGP) on a KT400 chipset, XP-2600 cpu.

This is my kernel boot line:

kernel /boot/vmlinuz-260test1ac2 root=/dev/hda1 video=matroxfb:xres:1600,yres:1280,depth:16,pixclock:4116,left:304,right:64,upper:46,lower:1,hslen:192,vslen:3,fv:85 hdb=scsi apm=power-off ide0=ata66

Consoles, X, Xv for watching videos in X - it all works fine.

CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_AGP=y
CONFIG_AGP_VIA=y
CONFIG_DRM=y
CONFIG_DRM_MGA=y
CONFIG_RAW_DRIVER=y

CONFIG_FB=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB_MATROX=y
CONFIG_FB_MATROX_G450=y
CONFIG_FB_MATROX_G100=y
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_PCI_CONSOLE=y
CONFIG_FONTS=y
CONFIG_FONT_SUN12x22=y
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y

This works for me.

Kind regards,
Jurriaan
-- 
management n.
1. Corporate power elites distinguished primarily by their distance from
actual productive work and their chronic failure to manage (see also suit).
Spoken derisively, as in "Management decided that ...". 2. Mythically, a
vast bureaucracy responsible for all the world's minor irritations.
Hackers' satirical public notices are often signed `The Mgt'; this derives
from the "Illuminatus" novels (see the Bibliography in Appendix C).
Debian (Unstable) GNU/Linux 2.5.75 4112 bogomips load av: 1.59 2.09 1.47
