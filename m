Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S.rDQHi168980>; Sat, 15 May 1999 15:03:10 -0400
Received: by vger.rutgers.edu id <S.rDNYs169223>; Sat, 15 May 1999 11:56:40 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:61130 "EHLO math.psu.edu") by vger.rutgers.edu with ESMTP id <S.rDNYk155481>; Sat, 15 May 1999 11:56:32 -0400
Date: Sat, 15 May 1999 12:43:21 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Matthew Wilcox <Matthew.Wilcox@genedata.com>
cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Andrea Arcangeli <andrea@e-mind.com>, bvermeul@blackstar.xs4all.nl, Richard Henderson <rth@twiddle.net>, linux-kernel@vger.rutgers.edu
Subject: Re: [2.2.8] undefined reference to `disable_irq_nosync' (+ fix)
In-Reply-To: <19990514194918.C1415@mencheca.ch.genedata.com>
Message-ID: <Pine.GSO.4.10.9905151234430.11400-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu
X-UIDL: 926794985.411400.581



On Fri, 14 May 1999, Matthew Wilcox wrote:

> I had a cunning thought a couple of weeks back which people seem to think
> will work, but no-one's done yet :-)
> 
> The problem is that if the SWP instruction (atomically read-and-write)
> hits in the cache, it will not go through to main memory, unlike earlier
> ARM processors.  Obviously, disabling the cache is going to take a big
> performance hit (particularly for those of us with 33MHz busses, argh).

Grrrmmm... Somewhere I've heard about SMP on a beast with really sucking
cache coherency... Wait a bit... Yup. Processor in question: KL-10.
OS: TOPS-10. They had a nasty time fighting with that problem and there
is a good paper on http://www.inwap.com/pdp10/paper-smp.txt about the
thing they did.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
