Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbRACWW2>; Wed, 3 Jan 2001 17:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131203AbRACWWT>; Wed, 3 Jan 2001 17:22:19 -0500
Received: from hood.tvd.be ([195.162.196.21]:308 "EHLO hood.tvd.be")
	by vger.kernel.org with ESMTP id <S129226AbRACWWK>;
	Wed, 3 Jan 2001 17:22:10 -0500
Date: Wed, 3 Jan 2001 23:21:40 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Tom Rini <trini@kernel.crashing.org>
cc: Petr Vandrovec <vandrove@vc.cvut.cz>, linux-fbdev@vuser.vu.union.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [linux-fbdev] [PATCH] matroxfb as a module (PPC)
In-Reply-To: <20010103105452.X26653@opus.bloom.county>
Message-ID: <Pine.LNX.4.05.10101032319490.611-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jan 2001, Tom Rini wrote:
> On Wed, Jan 03, 2001 at 06:44:59PM +0100, Geert Uytterhoeven wrote:
> > On Wed, 3 Jan 2001, Tom Rini wrote:
> > > Third, the nvram_read_byte needs to be protected by CONFIG_NVRAM.
> > 
> > I'd really like to move the nvram part to mac_fb_find_mode() in macmodes.c, so
> > it will work automagically for all drivers on PowerMac.
> > 
> > I'd also like to remove the `vmode' and `cmode' `video=' arguments, in favor of
> > the archictecture-neutral `<xres>x<yres>[-<bpp>][@<refresh>]' and
> > `<name>[-<bpp>][@<refresh>]' arguments (which already work on mac, BTW).
> 
> Quite wonderfully, almost.  My monitor (ViewSonic G810) claims it can do
> 1280x1024@90, but when i boot with that on my x86 box, it comes up at 87.5
> or so (and shifted to the left ~1 penguin).  But anyways..
> 
> > You can already use `mac<vmode>' instead of `vmode:<vmode>'.
> 
> Ah, is this documented anywhere?  I'm sure it'd make some peoples life
> easier.

It's not documented, but read macmodes.c and modedb.c. The Mac modes have names
`mac1' to `mac20', so they can be specified using the `<name>[-<bpp>]' syntax.

> > IMHO, the less PowerMac-specific code in _each_ driver, the better.
> 
> I agree this sounds good.  I just think it's too late to do it now. :)
> 
> The vmode/cmode/vesa number stuff should stick around in 2.4 (it's too late
> now to remove it) but documented as obsolete, and removed in 2.5.

Yep, too late for 2.4.0.

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
