Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131676AbRCOME6>; Thu, 15 Mar 2001 07:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131677AbRCOMEs>; Thu, 15 Mar 2001 07:04:48 -0500
Received: from mail.sonytel.be ([193.74.243.200]:45285 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S131676AbRCOMEh>;
	Thu, 15 Mar 2001 07:04:37 -0500
Date: Thu, 15 Mar 2001 13:03:35 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: James Simmons <jsimmons@linux-fbdev.org>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] [RFC] fbdev & power management
In-Reply-To: <20010315113137.28820@mailhost.mipsys.com>
Message-ID: <Pine.GSO.4.10.10103151302380.25908-100000@escobaria.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Mar 2001, Benjamin Herrenschmidt wrote:
> One problem I have is that my fbdev sleep routine will restore the mode
> on wakeup,
> but that of course doesn't work with X when not using useFBDev as fbdev
> have no
> knowledge of the current mode or register settings used by X.

That's a bug in X: one must not change the video mode by banging the hardware
when running on a fbdev system.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

