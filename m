Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131974AbRACNWF>; Wed, 3 Jan 2001 08:22:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131967AbRACNVz>; Wed, 3 Jan 2001 08:21:55 -0500
Received: from aeon.tvd.be ([195.162.196.20]:26559 "EHLO aeon.tvd.be")
	by vger.kernel.org with ESMTP id <S131966AbRACNVm>;
	Wed, 3 Jan 2001 08:21:42 -0500
Date: Wed, 3 Jan 2001 13:50:46 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Tom Rini <trini@kernel.crashing.org>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-fbdev@vuser.vu.union.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [linux-fbdev] [PATCH] clgenfb on PPC
In-Reply-To: <20010102095133.B26653@opus.bloom.county>
Message-ID: <Pine.LNX.4.05.10101031349110.611-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jan 2001, Tom Rini wrote:
> Hey all.  While going through the 2.4 tree and removing dead CONFIG_xxx's for
> PPC stuff, I noticed clgenfb still had CONFIG_PREP stuff (which may have
> partily explained why it no longer worked here).  I've attached a patch, that
> with another patch to fix some PCI issues on certain machines, gives me a
> working (so far, can't test heavily yet tho) framebuffer on my powerstack.
> 
> Comments?

To me it looks like most of them depend on `big endian', not on `PReP'.

BTW, doesn't the Cirrus Logic graphics chip have a big endian aperture? I don't
like things like green.offset = -3, since it will probably break some
applications (did you run X?).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
