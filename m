Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317251AbSHQBAx>; Fri, 16 Aug 2002 21:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317829AbSHQBAx>; Fri, 16 Aug 2002 21:00:53 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:60668 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S317251AbSHQBAw>;
	Fri, 16 Aug 2002 21:00:52 -0400
Date: Fri, 16 Aug 2002 21:04:49 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Larry McVoy <lm@bitmover.com>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       linux-kernel@vger.kernel.org
Subject: Re: IDE?
In-Reply-To: <Pine.LNX.4.44.0208161702370.1674-100000@home.transmeta.com>
Message-ID: <Pine.GSO.4.21.0208162057550.14493-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 16 Aug 2002, Linus Torvalds wrote:

> 
> On Fri, 16 Aug 2002, Linus Torvalds wrote:
> > 
> > I actually don't think it's the people as much as it is the ridiculous 
> > linkages inside ide.c and the hugely complicated rules. The code is messy.
> 
> Note: it _is_ the people too, don't get me wrong. But in other areas we 
> have people like Al Viro, who can drive grown men to cry (and drink) with 
> his not-very-polite postings. And in those areas it hasn't been a huge 
> problem, even though some people probably take a valium or two before they 
> dare open emails from Al.
> 
> So the messiness and interconnectedness of the IDE layer just seems to
> bring the people problem to a sharp and ugly point. The absolute lack of
> communication skills wrt IDE among the people who have worked on it has
> been stunning, and that probably _is_ because the code is so hard to even 
> talk about.

Sigh...  What we need with IDE is
	a) translator/bogon filter between hardware folks and the rest of
us.  If Jens or Alan are willing to do that for a while - wonderful.
	b) review of code structure in existing code.  Doing that.
	c) careful massage (as opposed to grand rewrite) of said structure
into something sane.  With series of small provable equivalent transformations.
And whoever does that is in serious risk of burnout - current spaghetty in
there is a fscking mess.  I'll try to help with that - I know how to do such
work, but I don't promise to get it all the way to sanity.

When we will have sane structure and sane interfaces, the life will get easier.
Until then full-time maintainership of drivers/ide/* is a one-way ticket to
Bedlam.

