Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263595AbTL2Qnn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 11:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263606AbTL2Qnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 11:43:43 -0500
Received: from out012pub.verizon.net ([206.46.170.137]:63375 "EHLO
	out012.verizon.net") by vger.kernel.org with ESMTP id S263595AbTL2Qnh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 11:43:37 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
To: Andreas Theofilu <abfall@TheosSoft.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0 with frame buffer problems?
Date: Mon, 29 Dec 2003 11:43:34 -0500
User-Agent: KMail/1.5.1
References: <20031229101745.6261e254.abfall@TheosSoft.net>
In-Reply-To: <20031229101745.6261e254.abfall@TheosSoft.net>
Organization: Organization: None that appears to be detectable by casual observers
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312291143.34500.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out012.verizon.net from [151.205.9.137] at Mon, 29 Dec 2003 10:43:35 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 December 2003 04:17, Andreas Theofilu wrote:
>Hi to all,
>
>Since kernel 2.6.0 I have a strange behavior of the screen in text
> modus as well as in graphic modus. If I scroll in plain old text
> modus for example within VI, some letters are misplaced and text on
> the screen became more and more unreadable. A ^L, that redraws the
> screen, helps and going a whole page down or up is also no problem.
>
>The same kind of problem occures in graphic modus. There, pixels are
>misplaced what makes the screen not only ugly but sometimes also
>unreadable, beside that this is really annoying. Because I
> encountered this in graphic modus first, I thought it was because
> of XFree86 4.3.0. But now, after searching the net and asking
> people I'm almost surely that this belongs to the kernel. I tried
> without frame buffer and tried different settings, but nothing
> changed.
>
>I found out, that the problem with the graphic appeard first with
> kernel 2.4.21. In the first place it was only a sometimes funny
> looking cursor (mouse pointer?) that was gone after switching to
> software cursor. In kernel 2.4.22 random pxiels appeared and in
> 2.4.23 more random pixel appeared. In kernel 2.6.0 the problem is
> now also with text modus.
>
>Although I'm a programer, I'm not a kernel hacker and have really no
> idea where to start to look for this. Any hints where to look or
> patches are welcome.
>
>My hardware:
>Graphics card: Radeon 7000 (known as Radeon VE QY)
>Motherboard  : MSI KT4V
>Chipset      : KT400
>RAM          : 512Mb
>CPU          : AMD 2800+
>
>My .config is attached.
# Graphics support
#
CONFIG_FB=y
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_HGA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_MATROX is not set
CONFIG_FB_RADEON=m
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_VIRTUAL is not set

Way too many frame buffers enabled.  Pick the one that works with your 
card and disable the vesa.  You may have to say y to the usual fonts 
too.

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

