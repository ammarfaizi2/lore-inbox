Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312898AbSDJMW6>; Wed, 10 Apr 2002 08:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312903AbSDJMW6>; Wed, 10 Apr 2002 08:22:58 -0400
Received: from mail.sonytel.be ([193.74.243.200]:13442 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S312898AbSDJMW4>;
	Wed, 10 Apr 2002 08:22:56 -0400
Date: Wed, 10 Apr 2002 14:22:12 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Peter Horton <pdh@berserk.demon.co.uk>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Radeon frame buffer driver
In-Reply-To: <20020410130106.1191@mailhost.mipsys.com>
Message-ID: <Pine.GSO.4.21.0204101403400.9914-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Apr 2002 benh@kernel.crashing.org wrote:
> >> The colour map is only used by the kernel and the kernel only uses 16
> >> entries so there isn't any reason to waste memory by making it any
> >> larger. I checked a few other drivers and they do the same (aty128fb for
> >> one).
> >
> >However, this change will make the driver not save/restore all color map
> >entries on VC switch in graphics mode.
> 
> Geert, didn't you tell me the fbdev apps were responsible for restoring
> their cmap on console switch ?

Probably not (unless you can quote me on that :-)

The color map is saved/restored in radeonfb_switch().

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

