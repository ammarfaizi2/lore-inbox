Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133087AbQL3SOo>; Sat, 30 Dec 2000 13:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135276AbQL3SOf>; Sat, 30 Dec 2000 13:14:35 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:21312 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S133087AbQL3SOS>; Sat, 30 Dec 2000 13:14:18 -0500
Date: Sat, 30 Dec 2000 18:43:08 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Petru Paler <ppetru@ppetru.net>,
        Jure Pecar <pegasus@telemach.net>, linux-kernel@vger.kernel.org,
        thttpd@bomb.acme.com
Subject: Re: linux 2.2.19pre and thttpd (VM-global problem?)
Message-ID: <20001230184308.B9332@athlon.random>
In-Reply-To: <20001229200657.B16261@athlon.random> <Pine.LNX.4.30.0012291958250.7406-100000@twinlark.arctic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0012291958250.7406-100000@twinlark.arctic.org>; from dean-list-linux-kernel@arctic.org on Fri, Dec 29, 2000 at 08:21:12PM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 29, 2000 at 08:21:12PM -0800, dean gaudet wrote:
> On Fri, 29 Dec 2000, Andrea Arcangeli wrote:
> 
> > On Fri, Dec 29, 2000 at 06:50:18PM +0000, Alan Cox wrote:
> > > Your cgi will keep the other CPU occupied, or run two of them. thttpd has
> > > superb scaling properties compared to say apache.
> >
> > I think with 8 CPUs and 8 NICs (usual benchmark setup) you want more than 1 cpu
				    ^^^^^^^^^^^^^^^^^^^^^
> > serving static data and it should be more efficient if it's threaded and
> > sleeping in accept() instead of running eight of them (starting from sharing
> > tlb entries and avoiding flushes probably without the need of CPU binding).
> 
> hey, nobody sane runs an 8 CPU box with 8 NICs for a production webserver.
> 8 single CPU boxes, or 4 dual boxes behind a load balancer.  now that's
> more common, more scalable, more robust.  :)

and it also provides high avaibility that is mandatory in a setup that
needs high performance anyways.

> oh yeah they all run perl, java, or php too :)  i've seen sites with more

and zope+python as well indeed.

> than 100 dynamic front-ends and a pair of 350Mhz x86 boxes in the corner
> handling all the static needs (running apache even!).  a pair only 'cause
> of redundancy reasons, not because of load reasons.

Exactly. I totally agree with you (everybody who talked with me about those
issues or attended my last two talks can confirm I agree ;).

But you're talking about real world. I was only talking about benchmarks.
Don't complain me if usual benchmark setup is done with one server N-way SMP +
N-Gbit-NICs (infact I can't run any usual webserving benchmark at home).

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
