Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129724AbQLNEY3>; Wed, 13 Dec 2000 23:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131132AbQLNEYS>; Wed, 13 Dec 2000 23:24:18 -0500
Received: from ip252.uni-com.net ([205.198.252.252]:16390 "HELO www.nondot.org")
	by vger.kernel.org with SMTP id <S129724AbQLNEYN>;
	Wed, 13 Dec 2000 23:24:13 -0500
Date: Wed, 13 Dec 2000 21:52:55 -0600 (CST)
From: Chris Lattner <sabre@nondot.org>
To: Alexander Viro <viro@math.psu.edu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        korbit-cvs@lists.sourceforge.net
Subject: Re: [Korbit-cvs] Re: ANNOUNCE: Linux Kernel ORB: kORBit
In-Reply-To: <Pine.GSO.4.21.0012132234280.6300-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.21.0012132148100.24765-100000@www.nondot.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > either.  Oops, wasn't interoperability an important part of the Linux
> > kernel design?  Didn't we want to use and follow and define _real_
> > standards? 
> Erm... 9P stub exists for Linux. It exists for FreeBSD. I suspect that
> it exists for other *BSD too - never checked that.

Okay, so there are _stubs_ for these platforms.  How many languages are
there bindings for?  What about Win32 (gross I know, but at least for now,
it is important)?  What about OS/2 what about Amiga and palm?  CORBA is
very popular for certain things... even inferno isn't nearly as big...

> > Heh, that's interesting.  _getting_ the data isn't hard in 9P, actually
> > using it or displaying it in a meaningful way commonly requires something
> > more than cat.  :)
> Same for any other RPC mechanism.

Of course.  Which is why CORBA is about putting STRUCTURE in that stream
of random bytes coming over the wire.  Why should I have to rewrite my
marshalling and demarshalling code every time I want to write a
server.  read and write are fine.  But sometimes I want a
structure.  Sometimes, my structures aren't laid out like C struct's
either.  What then?  What if I want to send an "object" to you?

> > nothing enforces it.  9P works wonderfully for Plan9 because they had the
> > luxery of redefining/rewriting the whole OS, and the whole interaction
> > with user space processes.  We, unfortunately, don't have that
> > possibility.  :)
> Notice that they _don't_ export random internal APIs to userland.

And neither do we.  Beautiful isn't it?  :)

> > Please don't get me wrong.  I'm not opposed to other ideas, and 9P may in
> > fact turn out to be a very nice protocol that would be able to support 
> > much kORBit level functionality).  I do maintain that by writing a custom
> > user->kernel marshalling library, you could obtain better peformance than
> > 9P though, because you could take advantage of lots of machine specific
> > optimizations.  Hell you could even pass things in register if you'd have
> > <= 4 args.  :)
> 
> You mentioned OOP, didn't you? Encapsulation is a good thing and what you
> are talking about is "layering violations made Real Easy(tm)".
> I simply don't see why _that_ is a good goal.

I completely fail to see how I'm breaking encapsulation or making layering
violations easy.  Why I'm talking about is the fact that CORBA doesn't
care how you ship bytes around: it's a higher level protocol that cares
about shipping "things" around.  Bytes are old school, "stuff" is the wave
of the future.  ;)  heh.

-Chris

http://www.nondot.org/~sabre/os/
http://www.nondot.org/MagicStats/
http://korbit.sourceforge.net/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
