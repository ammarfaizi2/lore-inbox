Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290223AbSA3RVG>; Wed, 30 Jan 2002 12:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290234AbSA3RTo>; Wed, 30 Jan 2002 12:19:44 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:60832
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S290079AbSA3QpG>; Wed, 30 Jan 2002 11:45:06 -0500
Date: Wed, 30 Jan 2002 09:43:36 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Larry McVoy <lm@work.bitmover.com>, Rik van Riel <riel@conectiva.com.br>,
        Larry McVoy <lm@bitmover.com>, Linus Torvalds <torvalds@transmeta.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Alexander Viro <viro@math.psu.edu>, Ingo Molnar <mingo@elte.hu>,
        Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020130164336.GO25973@opus.bloom.county>
In-Reply-To: <20020130080308.D18381@work.bitmover.com> <Pine.LNX.4.33L.0201301408540.11594-100000@imladris.surriel.com> <20020130083254.H23269@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020130083254.H23269@work.bitmover.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 08:32:54AM -0800, Larry McVoy wrote:
> On Wed, Jan 30, 2002 at 02:14:52PM -0200, Rik van Riel wrote:
[snip]
> > 2) the ability to send individual changes (for example, the
> >    foo_net.c fixes from 1.324 and 1.350) in one nice unidiff
> 
> That's possible now but not a really good idea.

How is it possible and what can go wrong?  This will be a common thing I
think, so it'd be a good thing to know (and have reliable and be a good
idea in some form).

> > 3) the ability for Linus to apply patches that are slightly
> >    "out of order" - a direct consequence of (2)
> 
> This is really the main point.  There are two issues, one is out of order
> and the other is what we call "false dependencies".  I think it is the 
> latter that bites you most of the time.  The reason you want out of order
> is because of the false dependencies, at least that is my belief, let
> me tell you what they are and you tell me.

I think that sounds about right.  If changeset 1.123 and 1.124 are only
related in that one got commited first (and for the sake of argument,
isn't done just yet) and the other is ready to go, the second one is
stuck.

> Suppose that you make 3 changes, a driver change, a vm change, and a 
> networking change.  Suppose that you want to send the networking change
> to Linus.  With patch, you just diff 'em and send and hope that patch
> can put it together on the other end.  With BK as it stands today, there
> is a linear dependency between all three changes and if you want to send
> the networking change, you also have to send the other 2.
> 
> How much of the out order stuff goes away if you could send changes out
> of order as long as they did not overlap (touch the same files)?

I think that'd help a good deal of the cases.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
