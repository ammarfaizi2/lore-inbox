Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130507AbRECShO>; Thu, 3 May 2001 14:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131497AbRECShE>; Thu, 3 May 2001 14:37:04 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:36343 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130507AbRECSg4>;
	Thu, 3 May 2001 14:36:56 -0400
Date: Thu, 3 May 2001 14:36:47 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: "Eric S. Raymond" <esr@thyrsus.com>
cc: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: Why recovering from broken configs is too hard
In-Reply-To: <20010503115551.E31960@thyrsus.com>
Message-ID: <Pine.GSO.4.21.0105031357310.17788-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 3 May 2001, Eric S. Raymond wrote:

> Alexander Viro <viro@math.psu.edu>:
> > I'm not talking about connectedness of the thing. However, I suspect that
> > graph has a small subset such that removing it makes it fall apart.
> 
> Um.  So how does that help?

First of all, it reduces the complexity of finding the best valid
approximation (mind you, I'm not saying that it's the problem you
need to solve, just that you don't need anything close to 3^1976
even for _that_).

And simple variation of the full thing can be used for "find a
valid approximation within given distance".

Full (and dumb) variant first:
	for all combinations of values of core variables
		for each peripherial group
			find the best valid approximation within that group,
			given the values of core variables.
The cost is 3^(size of core) * 3^(size of maximal peripherial group) *
number of peripherial groups * size of maximal periph. group * maximal
number of constraints for periph. group.

Again, I'm _not_ suggesting to do that. However, limited variant of the
problem (find valid approximation within 10 changes from given or complain)
is much easier.

Eric, could you point me to a place where I could grab the current
set of constraints? In any case I have a very strong gut feeling that
separation the variables into core and peripherial is essential part
of data and ignoring it makes problem much harder than it really is.
I'd like to see how large the core actually is and how large periph.
groups are.

