Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285095AbRLFKLg>; Thu, 6 Dec 2001 05:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285092AbRLFKL0>; Thu, 6 Dec 2001 05:11:26 -0500
Received: from warden.digitalinsight.com ([208.29.163.2]:46288 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S285086AbRLFKLS>; Thu, 6 Dec 2001 05:11:18 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Henning Schmiedehausen <hps@intermeta.de>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>, Larry McVoy <lm@bitmover.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Lars Brinkhoff <lars.spam@nocrew.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Date: Thu, 6 Dec 2001 01:46:09 -0800 (PST)
Subject: Re: SMP/cc Cluster description [was Linux/Pro]
In-Reply-To: <1007632244.24677.1.camel@forge>
Message-ID: <Pine.LNX.4.40.0112060136520.3044-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

one other thing to keep in mind on this entire discussion is that there
has not been a big incentive for the chip manufacturers to make a good
locking primitive (after all if 99% of the market is UP boxes why design
in extra stuff for the SMP modes)

This is changing as SMP boxes become mor popular.

has anyone pointed out this problem to the CPU vendors? it may be that
they would be interested in putting in some extra locking operations in a
future chip (for example I can easily see AMD implementing a 1
bit-per-lock set of locks that are arbatrated directly with the CPUs and
the chipset similar to the way cache coherancy works now rather then
the current model of useing a cacheline of memory that has to be moved
back and forth and then checked for status)

the big drawback would be that it would be non-standard commands which
each vendor would do differently, but the potential of implementing a
significant number of locks at the hardware level rather then just in
software is a very interesting thought.

David Lang



 On 6 Dec
2001, Henning Schmiedehausen wrote:

> Date: 06 Dec 2001 10:50:43 +0100
> From: Henning Schmiedehausen <hps@intermeta.de>
> To: Martin J. Bligh <Martin.Bligh@us.ibm.com>
> Cc: Larry McVoy <lm@bitmover.com>, Rik van Riel <riel@conectiva.com.br>,
>      Lars Brinkhoff <lars.spam@nocrew.org>,
>      Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
> Subject: Re: SMP/cc Cluster description [was Linux/Pro]
>
> On Wed, 2001-12-05 at 22:14, Martin J. Bligh wrote:
> > > We don't agree on any of these points.  Scaling to a 16 way SMP pretty much
> > > ruins the source base, even when it is done by very careful people.
> >
> > I'd say that the normal current limit on SMP machines is 8 way.
> > But you're right, we don't agree.  Time will tell who was right.
> > When I say I'm interested in 16 way scalability, I'm not talking about
> > SMP, so perhaps we're talking at slightly cross purposes.
>
> Well I do remember those Sequent Symmetry machines from university which
> scaled to 24 processors and more. If I remember correctly they ran 16x
> 386 and 8x 486 in a single box (under Dynix?)
>
> Wasn't too much interested in that then. I was to busy toying with my
> Amiga. ;-)
>
> 	Regards
> 		Henning
>
> --
> Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
> INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de
>
> Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
> D-91054 Buckenhof     Fax.: 09131 / 50654-20
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
