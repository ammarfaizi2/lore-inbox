Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131127AbQLOU22>; Fri, 15 Dec 2000 15:28:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131132AbQLOU2S>; Fri, 15 Dec 2000 15:28:18 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:22612 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S131127AbQLOU2F>; Fri, 15 Dec 2000 15:28:05 -0500
Date: Fri, 15 Dec 2000 20:57:21 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Ulrich Drepper <drepper@cygnus.com>
Cc: "linux-kernel@vger.kernel.or" <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.18 signal.h
Message-ID: <20001215205721.I17781@inspiron.random>
In-Reply-To: <Pine.LNX.3.95.1001215120537.1093A-100000@chaos.analogic.com> <20001215175632.A17781@inspiron.random> <Pine.LNX.3.95.1001215120537.1093A-100000@chaos.analogic.com> <20001215184325.B17781@inspiron.random> <4.3.2.7.2.20001215185622.025f8740@mail.lauterbach.com> <20001215195433.G17781@inspiron.random> <m3hf45ze5w.fsf@otr.mynet.cygnus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3hf45ze5w.fsf@otr.mynet.cygnus.com>; from drepper@redhat.com on Fri, Dec 15, 2000 at 11:18:35AM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 15, 2000 at 11:18:35AM -0800, Ulrich Drepper wrote:
> Andrea Arcangeli <andrea@suse.de> writes:
> 
> > x()
> > {
> > 
> > 	switch (1) {
> > 	case 0:
> > 	case 1:
> > 	case 2:
> > 	case 3:
> > 	;
> > 	}
> > }
> > 
> > Why am I required to put a `;' only in the last case and not in all
> > the previous ones? Or maybe gcc-latest is forgetting to complain about
> > the previous ones ;)
> 
> Your C language knowledge seems to have holes.  It must be possible to
> have more than one label for a statement.  Look through the kernel
> sources, there are definitely cases where this is needed.

I don't understand what you're talking about. Who ever talked about "more than
one label"?

The only issue here is having 1 random label at the end of a compound
statement. Nothing else.

And yes I can see that the whole point of the change is that they want
to also forbids this:

x()
{
	goto out;
out:
}

and I dislike not being allowed to do the above as well infact ;).

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
