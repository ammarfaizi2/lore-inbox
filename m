Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131050AbQLNEM5>; Wed, 13 Dec 2000 23:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132249AbQLNEMs>; Wed, 13 Dec 2000 23:12:48 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:13953 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131050AbQLNEMa>;
	Wed, 13 Dec 2000 23:12:30 -0500
Date: Wed, 13 Dec 2000 22:42:01 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Chris Lattner <sabre@nondot.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        korbit-cvs@lists.sourceforge.net
Subject: Re: [Korbit-cvs] Re: ANNOUNCE: Linux Kernel ORB: kORBit
In-Reply-To: <Pine.LNX.4.21.0012132113020.24665-100000@www.nondot.org>
Message-ID: <Pine.GSO.4.21.0012132234280.6300-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Dec 2000, Chris Lattner wrote:

> 
> /me trims down CC list...
> 
> > 	Local? Funny. It lives atop of TCP or IL quite fine. What's
> > even funnier, I can use it to export /proc from CPU server to workstation
> > and use _that_ for remote debugging. Ditto for window system. Ditto for
> > DNS. Ditto for plumber. No, not on Linux...
> 
> No not on linux.  No definately not on Windows, no not on the BSD's
> either.  Oops, wasn't interoperability an important part of the Linux
> kernel design?  Didn't we want to use and follow and define _real_
> standards? 

Erm... 9P stub exists for Linux. It exists for FreeBSD. I suspect that
it exists for other *BSD too - never checked that.

> > 	What you do is mapping your RPC to hierarchical namespace. After
> > that... What extensibility do you need? You can use every utility written
> > for core UNIX API (open()/read()/write()/close()) as a client. No need
> > to reinvent the wheel...
> 
> Heh, that's interesting.  _getting_ the data isn't hard in 9P, actually
> using it or displaying it in a meaningful way commonly requires something
> more than cat.  :)

Same for any other RPC mechanism.
 
> The overriding problem with a simplistic 9P port is that linux kernel
> functionality is not very well modularized.  In fact, this prevents
> wonderful CORBA integration as well: An agressive filesystem (for
> example) often likes to touch the buffer cache or even the VM layer
> (*cough*) directly.  Some don't use the prescribed interfaces, because
> nothing enforces it.  9P works wonderfully for Plan9 because they had the
> luxery of redefining/rewriting the whole OS, and the whole interaction
> with user space processes.  We, unfortunately, don't have that
> possibility.  :)

Notice that they _don't_ export random internal APIs to userland.
 
> Please don't get me wrong.  I'm not opposed to other ideas, and 9P may in
> fact turn out to be a very nice protocol that would be able to support 
> much kORBit level functionality).  I do maintain that by writing a custom
> user->kernel marshalling library, you could obtain better peformance than
> 9P though, because you could take advantage of lots of machine specific
> optimizations.  Hell you could even pass things in register if you'd have
> <= 4 args.  :)

You mentioned OOP, didn't you? Encapsulation is a good thing and what you
are talking about is "layering violations made Real Easy(tm)".

I simply don't see why _that_ is a good goal.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
