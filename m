Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129859AbRACSQY>; Wed, 3 Jan 2001 13:16:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129860AbRACSQO>; Wed, 3 Jan 2001 13:16:14 -0500
Received: from hood.tvd.be ([195.162.196.21]:6351 "EHLO hood.tvd.be")
	by vger.kernel.org with ESMTP id <S129859AbRACSQC>;
	Wed, 3 Jan 2001 13:16:02 -0500
Date: Wed, 3 Jan 2001 18:44:59 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Tom Rini <trini@kernel.crashing.org>
cc: Petr Vandrovec <vandrove@vc.cvut.cz>, linux-fbdev@vuser.vu.union.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [linux-fbdev] [PATCH] matroxfb as a module (PPC)
In-Reply-To: <20010103091613.Q26653@opus.bloom.county>
Message-ID: <Pine.LNX.4.05.10101031840410.611-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jan 2001, Tom Rini wrote:
> Third, the nvram_read_byte needs to be protected by CONFIG_NVRAM.

I'd really like to move the nvram part to mac_fb_find_mode() in macmodes.c, so
it will work automagically for all drivers on PowerMac.

I'd also like to remove the `vmode' and `cmode' `video=' arguments, in favor of
the archictecture-neutral `<xres>x<yres>[-<bpp>][@<refresh>]' and
`<name>[-<bpp>][@<refresh>]' arguments (which already work on mac, BTW).
You can already use `mac<vmode>' instead of `vmode:<vmode>'.

IMHO, the less PowerMac-specific code in _each_ driver, the better.

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
