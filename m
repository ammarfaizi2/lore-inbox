Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281910AbRLLUnH>; Wed, 12 Dec 2001 15:43:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282062AbRLLUmr>; Wed, 12 Dec 2001 15:42:47 -0500
Received: from balu.sch.bme.hu ([152.66.208.40]:9361 "EHLO balu.sch.bme.hu")
	by vger.kernel.org with ESMTP id <S281910AbRLLUmi>;
	Wed, 12 Dec 2001 15:42:38 -0500
Date: Wed, 12 Dec 2001 21:42:27 +0100 (MET)
From: Pozsar Balazs <pozsy@sch.bme.hu>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: FBdev remains in unusable state
In-Reply-To: <BCF1AF35606@vcnet.vc.cvut.cz>
Message-ID: <Pine.GSO.4.30.0112122137360.17543-100000@balu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 12 Dec 2001, Petr Vandrovec wrote:

> On 12 Dec 01 at 21:14, Pozsar Balazs wrote:
> > > No. vesafb does not work together with mga driver in X (although
> > > I believe that vesafb works with XFree mga driver, only Matrox driver
> > > is binary bad citizen).
> >
> > I don't clearly understand you. I am using mga driver which is in the
> > official xfrr86 release.
>
> In that case even xfree mga driver cannot return hardware back to previous
> state. It is expected and documented.

Sorry I didn't know that. Btw, where is it documented?

> > Why isn't it done by the vesafb driver?
>
> vesafb is VBE2.0 based. It does not know how to touch hardware, it uses
> LILO to do all this dirty work.

I think got the point, but I don't really understand how lilo comes here,
because I boot using grub or syslinux.

> Linux vga=769 video=matrox:vesa:769
>
> on computers with Matrox inside you'll have /dev/fb0 accelerated fb,
> and /dev/fb1 VESAFB 'do not use' (maybe vesafb even will not load
> as framebuffer will be already acquired by matroxfb, but I never tested
> it). On computers without Matrox you'll have /dev/fb0 VESAFB and
> /dev/fb1 will not exist at all.

Thanks for this. Are there similar issues with other cards?
Which fb drivers should I compile in?

> P.S.: Also try 'Option "UseFBDev"' in /etc/X11/XF86Config-4 driver
> section. I think that with this option X11 mga driver will not stomp
> on your hardware, and instead it will refuse any videmode != vesafb
> one.

I need 'real' X running, not X using fbdev...


Much thanks for you help,
-- 
Balazs Pozsar

