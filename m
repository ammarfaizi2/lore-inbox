Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751110AbWFLIcs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbWFLIcs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 04:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbWFLIcs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 04:32:48 -0400
Received: from z2.cat.iki.fi ([212.16.98.133]:52179 "EHLO z2.cat.iki.fi")
	by vger.kernel.org with ESMTP id S1751056AbWFLIcl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 04:32:41 -0400
Date: Mon, 12 Jun 2006 11:32:39 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VGER does gradual SPF activation  (FAQ matter)
Message-ID: <20060612083239.GA27502@mea-ext.zmailer.org>
References: <20060610222734.GZ27502@mea-ext.zmailer.org> <20060611072223.GA16150@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060611072223.GA16150@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russel wrote to me privately, but I do think this will make sense
also for the whole discussion. 

On Sun, Jun 11, 2006 at 08:22:23AM +0100, Russell King wrote:
> On Sun, Jun 11, 2006 at 01:27:34AM +0300, Matti Aarnio wrote:
> > Very little will break, but one should really consider converting
> > their email sending methodology to one, which uses fewest possible
> > number of servers, publish that data in DNS, and always send all
> > emails thru those servers.
> 
> In which case I'm going to ask those who forward / redirect email
> via my systems or the zen clusters to stop doing so - as David
> says on his web page, SPF (sorry, Internet Mail version 2) prevents
> such things from working, and requires a step "upgrade" of the entire
> internet.

For a very long time (like 20 years or so) I used to think like that.

Doing email services in big ISP environments for about 10 years did
cure me of that thinking.  Ordinary Janes and Joes (and grannies
and granpas) must not be allowed to send email in similar ways that
we used to do in happy 1980es when the internet was engineer playground.

The Internet needs to be segregated into two kinds of users - those that
must not be allowed to do much of anything ( = common man to whom the
internet equals anyway to IE web-browser ) and to first-class citizens
with their own email servers...

Becoming such a first-class citizen should be fairly easy, but most
service providers don't yet sell anything else than that basic bulk
"common man" stuff.  THAT is serious disadvantage, but I do see emergence
of ISPs that do sell things for geeks also and do it without very steep
"business internet" price tag.


My thinking has always also been that "there is something rotten in
the .forward  processing"  -  but for traditional reasons I have not
altered email source addresses (e.g. what they call SRS in SPF
environment) when passing email thru user's  .forward  file.
Even SRS isn't perfect, but it is better than nothing.


With SMTP's EHLO mechanism introduction it has taken nearly 10 years
before it has become really widely used.   Most laggard of all were
not those ancient systems that were feared to be slowest adopting new
things - not at all..  Slowest were Microsoft and many firewall vendors
that want to poke inside the SMTP protocol and behave as "we know what
is safe"..



> > In longer run the amount of irresponsible (incurable) network security
> > holes (known as Windows) shows no sign of becoming extinct at adsl -lines,
> > so there will be increased pressure to demand sender identification
> > (and verification) during email sending - viruses can't do that yet...
> > And when they learn, user with infection can be trivially identified
> > and contacted/blocked.
> 
> Pie in the sky - it's already easy to identify viruses today.  Do the
> offenders get contacted and/or blocked by their ISPs today?  No.  So
> what makes you think that this wonderful SPF will make any difference?

There are some automated tools that can divert all traffic from 
detected (whatever criteria is used) Bad Host to a sandbox host giving
same web-page for all HTTP accesses (and blocking everything else).
They have proven to be quite efficient in some cases, but not always.

Enforcing (on "common man lines") also a policy of: Send nowhere with
SMTP, always send with AUTHENTICATED SUBMISSION will also allow users
to use their email provider's email servers for email sending independent
of where they are at any time, and from whom they have bought the network
connection - thus they can change access ISP:s easily and having email
address independent of their access - of course this is not according
to access provider isp's interests...

Email address is, after all, what people do want to stay unchanged, but
it is also being used as a tie-in to keep them bound to access network
ISP that provides the email service.

In spite of its many percieved faults,  SPF is one of many things that
will change the way of the internet universe.

A bit earlier mentioned "easy to poison DNS caches" is also something
that will become more and more difficult.  Lattest round of things with
DNS in Finland was that no server doing recursive resolving is permitted
to offer the service outside local customer networks.  Indeed I was
surprised that there is not yet a globally assigned "AnyCast" IPv4
address for Recursive DNS resolvers.  Resolving service would be available
from same few addresses where-ever you are. I leave practical implementation
details to the reader.  (It is not very complex, and can be done with
about any server existing today.  I made such a beasts with lattest Bind 9
on Linux, NetBSD, and Solaris.)

We had also "IP source address sanity enforcement" so that hijacked
(virus infested, whatever) PC can not send out IP datagrams with source
address other than its own (or the network that it belongs to, if no
individual verification is possible) 

Most of reasons behind the DNS securing excercise would have been totally
unnecessery with worlds biggest ISPs doing that source IP address sanity
filtering at their internal access edges.

SPF is application level version of this type of source sanity
enforcement, and all that I intend to do is to publish that TXT
entry for VGER.  Analyzing SPF data in incoming SMTP reception
is a thing that I leave for latter phase  (how much latter,
I can't say yet.)


> Sorry, you don't get my vote for any of this.
> -- 
> Russell King
>  Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
>  maintainer of:  2.6 Serial core

  /Matti Aarnio
