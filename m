Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261545AbTCZKfd>; Wed, 26 Mar 2003 05:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261550AbTCZKfd>; Wed, 26 Mar 2003 05:35:33 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:55690 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S261545AbTCZKfc>;
	Wed, 26 Mar 2003 05:35:32 -0500
Date: Wed, 26 Mar 2003 11:46:38 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Andries.Brouwer@cwi.nl
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux 2.5.66
In-Reply-To: <Pine.GSO.4.21.0303261142390.20738-100000@vervain.sonytel.be>
Message-ID: <Pine.GSO.4.21.0303261145480.20738-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Mar 2003, Geert Uytterhoeven wrote:
> On Tue, 25 Mar 2003 Andries.Brouwer@cwi.nl wrote:
> > Good! But I don't see my compilation fixes. Will resend.
> > Below a new one.
> > 
> > Andries
> > 
> > diff -u --recursive --new-file -X /linux/dontdiff a/fs/partitions/msdos.c b/fs/partitions/msdos.c
> > --- a/fs/partitions/msdos.c	Mon Feb 24 23:02:56 2003
> > +++ b/fs/partitions/msdos.c	Tue Mar 25 06:22:31 2003
> > @@ -219,7 +219,7 @@
> >   * Create devices for BSD partitions listed in a disklabel, under a
> >   * dos-like partition. See parse_extended() for more information.
> >   */
> > -static void
> > +void
> >  parse_bsd(struct parsed_partitions *state, struct block_device *bdev,
> >  		u32 offset, u32 size, int origin, char *flavour,
> >  		int max_partitions)
> 
> Doesn't it make sense to move parse_bsd() to a separate file? Else we have to
> add a dependency on MSDOS_PARTITION to NEC98_PARTITION.

Should have been: ... if BSD_DISKLABEL is set.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

