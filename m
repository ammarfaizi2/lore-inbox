Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265382AbSJaT1r>; Thu, 31 Oct 2002 14:27:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265383AbSJaT1r>; Thu, 31 Oct 2002 14:27:47 -0500
Received: from dsl-sj-66-219-79-98.broadviewnet.net ([66.219.79.98]:11468 "EHLO
	mail.3pardata.com") by vger.kernel.org with ESMTP
	id <S265382AbSJaT1p>; Thu, 31 Oct 2002 14:27:45 -0500
Date: Thu, 31 Oct 2002 11:33:37 -0800 (PST)
From: Castor Fu <castor@3pardata.com>
X-X-Sender: <castor@marais>
To: Linus Torvalds <torvalds@transmeta.com>
cc: "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>,
       <lkcd-general@lists.sourceforge.net>,
       <lkcd-devel@lists.sourceforge.net>
Subject: Re: [lkcd-devel] Re: What's left over.
In-Reply-To: <Pine.LNX.4.44.0210310737170.2035-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.33.0210310809510.21679-100000@marais>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Oct 2002, Linus Torvalds wrote:

>
> On Wed, 30 Oct 2002, Matt D. Robinson wrote:
>
> > Linus Torvalds wrote:
> > > > Crash Dumping (LKCD)
> > >
> > > This is definitely a vendor-driven thing. I don't believe it has any
> > > relevance unless vendors actively support it.
> >
> > There are people within IBM in Germany, India and England, as well as
> > a number of companies (Intel, NEC, Hitachi, Fujitsu), as well as SGI
> > that are PAID to support this.

Add 3PAR and probably a number of other small companies given the traffic
on the lists.    Anyone building a new product on Linux and mucking
around inside the kernel, and having more than a handful of developers
is going to want LKCD, or Mission Critical's mcore,  or netdump, or
something like it.

It's a shame that right out of the gate they'll have to spend time
figuring out which of these solutions work for them.  I spent at least
a month of my life just looking at what's out there, and trying to make
each of them work with our product.  It'd be nice if that time were
spent on making new "cool stuff".

Since then, we've put significant amounts of work into making LKCD
reliable on our system, and it's been incredibly useful in our
development.  It's going to prove invaluable supporting our stuff in
the field.

> What I'm saying by "vendor driven" is that it has no relevance for the
> standard kernel, and since it has no relevance to that, then I have no
> incentives to merge it. The crash dump is only useful with people who
> actively look at the dumps, and I don't know _anybody_ outside of the
> specialized vendors you mention who actually do that.
>
> I will merge it when there are real users who want it - usually as a
> result of having gotten used to it through a vendor who supports it. (And
> by "support" I do not mean "maintain the patches", but "actively uses it"
> to work out the users problems or whatever).

If you asked me if 3PAR is a "vendor" or a "user" I'd have to say "yes".
As a vendor we sell our system to customers.  They could not care less
that LKCD is in the linux kernel distribution.  All they care about is
that we fix their problems as fast as possible.  They probably have
no idea that this is the underlying technology, so you will never
hear from them about us.

However, we also use linux for desktops, build servers, database servers, etc.
When we have problems with these systems, we'd LOVE to be able to use the
same expertise and technology which we've developed for our system, but
all too often we find that someone just grabbed a Redhat 7.x disk or
standard debian distro to build the system.

So as a "user" I'm asking the distribution vendors, please make it easy
for me to use the same damn tools everywhere by providing some sort
of common crash dump mechanism.  It'll make it easier for me to consider new
hardware, new software, etc.  One thing that's awesome is Dave Anderson's
"crash" tool.  It works with LKCD dumps, netdump dumps, etc.  It's an example
of a tool which has leveraged all the different dump communities.

As a "vendor" please put LKCD or something like it into the main line
kernel.   LKCD works.  It has an active developer community which has
been extending it to work over networks, onto disks, developing new
analysis tools, etc.  If we can settle on one such tool, we'll get
more cool stuff like lock analyzers, etc.  Until then, we WILL keep
re-inventing the wheel because this is one of the first steps to
collect significant amounts of real data.

    -castor

