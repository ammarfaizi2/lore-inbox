Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131995AbQLNEzp>; Wed, 13 Dec 2000 23:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131968AbQLNEze>; Wed, 13 Dec 2000 23:55:34 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:24262 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131132AbQLNEzX>;
	Wed, 13 Dec 2000 23:55:23 -0500
Date: Wed, 13 Dec 2000 23:24:54 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Chris Lattner <sabre@nondot.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        korbit-cvs@lists.sourceforge.net
Subject: Re: [Korbit-cvs] Re: ANNOUNCE: Linux Kernel ORB: kORBit
In-Reply-To: <Pine.LNX.4.21.0012132148100.24765-100000@www.nondot.org>
Message-ID: <Pine.GSO.4.21.0012132308440.6300-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Dec 2000, Chris Lattner wrote:

> 
> > > either.  Oops, wasn't interoperability an important part of the Linux
> > > kernel design?  Didn't we want to use and follow and define _real_
> > > standards? 
> > Erm... 9P stub exists for Linux. It exists for FreeBSD. I suspect that
> > it exists for other *BSD too - never checked that.
> 
> Okay, so there are _stubs_ for these platforms.  How many languages are
> there bindings for?

Grr... Let's define the terms, OK? What is available: kernel code that
represents the client side of RPC as a filesystem. Userland clients do
not know (or care) about the mechanisms involved.
 
> > You mentioned OOP, didn't you? Encapsulation is a good thing and what you
> > are talking about is "layering violations made Real Easy(tm)".
> > I simply don't see why _that_ is a good goal.
> 
> I completely fail to see how I'm breaking encapsulation or making layering
> violations easy.  Why I'm talking about is the fact that CORBA doesn't
> care how you ship bytes around: it's a higher level protocol that cares
> about shipping "things" around.  Bytes are old school, "stuff" is the wave
> of the future.  ;)  heh.

	And files with structure are things of dreadful past. BTDT.
You really need to... work with an OS that would have and enforce
"structured files" <spit> to appreciate the beauty of ASCII streams.

	However, that's a different story. What I _really_ don't understand
is the need to export anything structured from kernel to userland.

	IOW, I would really like to see a description of use of your
mechanism. If it's something along the lines of "let's take a network
card driver, implement it in userland and preserve the current API" -
see the comment about layering violations. You've taken an internal
API and exposed it to userland in all gory details. See also your own
comment about internal APIs being not convenient for such operations.
If it's something else - I wonder what kind of objects you are talking
about and why opaque stuff (== file descriptors) would not be sufficient.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
