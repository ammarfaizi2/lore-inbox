Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267439AbTBXS0z>; Mon, 24 Feb 2003 13:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267482AbTBXSV7>; Mon, 24 Feb 2003 13:21:59 -0500
Received: from 12-252-67-253.client.attbi.com ([12.252.67.253]:53888 "EHLO
	morningstar.nowhere.lie") by vger.kernel.org with ESMTP
	id <S267346AbTBXSL7>; Mon, 24 Feb 2003 13:11:59 -0500
From: "John W. M. Stevens" <john@betelgeuse.us>
Date: Mon, 24 Feb 2003 11:22:10 -0700
To: Larry McVoy <lm@work.bitmover.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030224182210.GA9444@morningstar.nowhere.lie>
References: <1510000.1045942974@[10.10.2.4]> <20030222195642.GI1407@work.bitmover.com> <2080000.1045947731@[10.10.2.4]> <20030222231552.GA31268@work.bitmover.com> <3610000.1045957443@[10.10.2.4]> <20030224045616.GB4215@work.bitmover.com> <48940000.1046063797@[10.10.2.4]> <20030224065826.GA5665@work.bitmover.com> <1630000.1046072374@[10.10.2.4]> <20030224161716.GC5665@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030224161716.GC5665@work.bitmover.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2003 at 08:17:16AM -0800, Larry McVoy wrote:
> On Sun, Feb 23, 2003 at 11:39:34PM -0800, Martin J. Bligh wrote:
> 
> See other postings on this one.  All engineers in your position have said
> "we're just trying to get to N cpus where N = ~2x where we are today and
> it won't hurt uniprocessor performance".  They *all* say that.  And they
> all end up with a slow uniprocessor OS.  Unlike security and a number of
> other invasive features, the SMP stuff can't be configed out

Heck, you can't even configure it out on so-called UP systems.

The moment you introduce DMA into a system, you have an (admittedly,
constrained) SMP system.

And of course, simple interruption is another, contrained, kind of
"virtual SMP", yes?

Anybody whose done any USB HC programming is horribly aware of this
fact, trust me!  ;-)

> or you end
> up with an #ifdef-ed mess like IRIX.

Why if-def it every where?

#ifdef	SMP

#define	lock( mutex )	smpLock( lock )

#else

#define	lock( mutex )

#endif

Do that once, use the lock macro, and forget about it (except in
cases where you have to worry about DMA, interruption, or some other
kind of MP, of course).

My (limited, only about 600 machines) experience is that Linux is
inevitably less stable on non-Intel, and on non-UP machines.  Before
worrying about scalability, my opinion is that worrying about getting
the simplest (dual processor) machines as stable as UP machines, first,
would be both a better ROI, and a good basis for higher levels of
scalability.

Mind you, there is a perfectly simple reason (for Linux being less
stable on non-Intel, non-UP machines) that this is true: the
Linux development methodology pretty much makes this an emergent
property.

Interesting discussion, though . . . from my experience, the commercial
Unices use fine grained locking.

Luck,
John S.
