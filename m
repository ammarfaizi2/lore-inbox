Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130533AbQJaVAj>; Tue, 31 Oct 2000 16:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130545AbQJaVA3>; Tue, 31 Oct 2000 16:00:29 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:4874 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130533AbQJaVAR>; Tue, 31 Oct 2000 16:00:17 -0500
Date: Tue, 31 Oct 2000 12:59:59 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Russell King <rmk@arm.linux.org.uk>
cc: Keith Owens <kaos@ocs.com.au>, Jeff Garzik <jgarzik@mandrakesoft.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test10-pre7
In-Reply-To: <200010311928.e9VJS2d08641@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.10.10010311257510.22165-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 31 Oct 2000, Russell King wrote:

> Linus Torvalds writes:
> > On Wed, 1 Nov 2000, Keith Owens wrote:
> > > LINK_FIRST is processed in the order it is specified, so a.o will be
> > > linked before z.o when both are present.  See the patch.
> > 
> > So why don't you do the same thing for obj-y, then?
> > 
> > Why can't you do
> > 
> > 	LINK_FIRST=$(obj-y)
> > 
> > and be done with it?
> 
> Hmm, so why don't we just call it obj-y and be done with it? ;)

That was going to be my next question if somebody actually said "sure".

The question was rhetorical, since the way LINK_FIRST is implemented means
that it has all the same problems that $(obj-y) has, and is hard to get
right in the generic case (but you can get it trivially right for the
subset case, like for USB).

			Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
