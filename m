Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312575AbSDJLHR>; Wed, 10 Apr 2002 07:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312579AbSDJLHQ>; Wed, 10 Apr 2002 07:07:16 -0400
Received: from mail.sonytel.be ([193.74.243.200]:42989 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S312575AbSDJLHP>;
	Wed, 10 Apr 2002 07:07:15 -0400
Date: Wed, 10 Apr 2002 13:06:09 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Peter Horton <pdh@berserk.demon.co.uk>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Radeon frame buffer driver
In-Reply-To: <20020410101913.GA975@berserk.demon.co.uk>
Message-ID: <Pine.GSO.4.21.0204101305210.24941-100000@trillium.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Apr 2002, Peter Horton wrote:
> On Wed, Apr 10, 2002 at 11:57:31AM +0100, benh@kernel.crashing.org wrote:
> > 
> > Fine, though I noticed the get_cmap_len got changed to
> > +	return var->bits_per_pixel == 8 ? 256 : 16;
> > 
> 
> The colour map is only used by the kernel and the kernel only uses 16
> entries so there isn't any reason to waste memory by making it any
> larger. I checked a few other drivers and they do the same (aty128fb for
> one).

However, this change will make the driver not save/restore all color map
entries on VC switch in graphics mode.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

