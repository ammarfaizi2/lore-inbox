Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287835AbSABPHG>; Wed, 2 Jan 2002 10:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287834AbSABPG4>; Wed, 2 Jan 2002 10:06:56 -0500
Received: from mail.sonytel.be ([193.74.243.200]:12699 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S287827AbSABPGl>;
	Wed, 2 Jan 2002 10:06:41 -0500
Date: Wed, 2 Jan 2002 16:06:12 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Dave Jones <davej@suse.de>
cc: Larry McVoy <lm@bitmover.com>, Oliver Xymoron <oxymoron@waste.org>,
        Christer Weinigel <wingel@hog.ctrl-c.liu.se>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: The direction linux is taking
In-Reply-To: <Pine.LNX.4.33.0112292051421.1336-100000@Appserv.suse.de>
Message-ID: <Pine.GSO.4.21.0201021559420.1574-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Dec 2001, Dave Jones wrote:
> On Sat, 29 Dec 2001, Larry McVoy wrote:
> > Anyway, I'm interested to see if there are screams of "all I ever do is
> > merge and I hate it" or "merging?  what's that?".
> 
> I've only been keeping this tree since the beginning of the month,
> so I'm still trying to find my feet a little, but so far merging is
> pretty straightforward and usually painless.
> 
> The procedure when Linus/Marcelo release a new patch usually goes..
> 
>  1. edit the patch to remove any bits that don't make sense
>     (eg, I have newer/better version in my tree)
>  2. cat ../patch-2.5.x | patch -p1 --dry-run
>  3. edit the patch to remove already present hunks.
>  4. manually fix up rejects in my tree, and remove reject hunk
>     from the diff.
>  5. back to (1) until no rejects.
>  6. cat ../patch-2.5.x | patch -p1
>  7. testing..
>  8. Create new diff, and give it a quick readthrough.
> 
> Out of all this the initial patch review (step #1) and the final
> lookover are by far the most time consuming, and I don't think any
> automated tool could speed this up and give me the same level of
> understanding over what I'm merging.

When I was bringing the m68k tree back in sync near the end of 1999, I used the
following approach:
  - keep all trees, use `cp -rl' and `patch' when a new version is released
    (cfr. Al Viro)
  - use `same' to prevent the need for zillions of disk space, and to make the
    creation of diffs between such trees fast
  - merge trees using my home-brew `mergetree' perl script (basically a
    recursive `merge' command), which can replace the destination file by a
    hard link if it's the same as one of the originals

Despite having a real CVS repository for m68k now, I still use mergetree...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

