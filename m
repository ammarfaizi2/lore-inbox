Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275625AbTHOA1D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 20:27:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275624AbTHOA0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 20:26:53 -0400
Received: from mailhost.NMT.EDU ([129.138.4.52]:60383 "EHLO mailhost.nmt.edu")
	by vger.kernel.org with ESMTP id S275606AbTHOAZl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 20:25:41 -0400
Date: Thu, 14 Aug 2003 18:25:37 -0600
From: Val Henson <val@nmt.edu>
To: Jamie Lokier <jamie@shareable.org>
Cc: David Wagner <daw@mozart.cs.berkeley.edu>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
Message-ID: <20030815002537.GE5333@speare5-1-14>
References: <20030809173329.GU31810@waste.org> <20030813032038.GA1244@think> <20030813040614.GP31810@waste.org> <20030814165320.GA2839@speare5-1-14> <bhgoj9$9ab$1@abraham.cs.berkeley.edu> <20030814213600.GA12420@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030814213600.GA12420@mail.jlokier.co.uk>
User-Agent: Mutt/1.4.1i
X-Favorite-Color: Polka dot
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 14, 2003 at 10:36:00PM +0100, Jamie Lokier wrote:
> David Wagner wrote:
> > Val Henson  wrote:
> > >Throwing away 80 bits of the 160 bit output is much better
> > >than folding the two halves together.  In all the cases we've
> > >discussed where folding might improve matters, throwing away half the
> > >output would be even better.
> > 
> > I don't see where you are getting this from.  Define
> >   F(x) = first80bits(SHA(x))
> >   G(x) = first80bits(SHA(x)) xor last80bits(SHA(x)).
> > What makes you think that F is a better (or worse) hash function than G?
> > 
> > I think there is little basis for discriminating between them.
> > If SHA is cryptographically secure, both F and G are fine.
> > If SHA is insecure, then all bets are off, and both F and G might be weak.
> 
> I still do not see why either F or G are any more secure than SHA.

They aren't, in the sense of cryptographically signing a document.
They do reveal less information about the input than SHA-1.

> F, G and SHA are all supposedly strong hash functions, and I don't see
> why the postulated folks capable of getting useful information about
> the inputs to SHA would have any more difficulty getting useful
> information about the inputs to F or G.
> 
> Unless we're postulating that SHA is deliberately weak, so that the
> designers have a back door, that is not present in F or G.

That's exactly what Ted described as his reason for doing the folding
in the first place.  Matt Mackall simply pointed out that a little bit
of information theory will show you that throwing away half the output
is more effective.

I think Matt's doing an excellent job.  His understanding of the
mathematics involved certainly exceeds that of 99% of the operating
systems developers I've met.

-VAL
