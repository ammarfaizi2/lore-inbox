Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290081AbSA3QpI>; Wed, 30 Jan 2002 11:45:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290103AbSA3Qnw>; Wed, 30 Jan 2002 11:43:52 -0500
Received: from bitmover.com ([192.132.92.2]:61093 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S290105AbSA3Qnc>;
	Wed, 30 Jan 2002 11:43:32 -0500
Date: Wed, 30 Jan 2002 08:43:31 -0800
From: Larry McVoy <lm@bitmover.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Larry McVoy <lm@bitmover.com>, Rik van Riel <riel@conectiva.com.br>,
        Tom Rini <trini@kernel.crashing.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Alexander Viro <viro@math.psu.edu>,
        Rob Landley <landley@trommello.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020130084331.K23269@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Ingo Molnar <mingo@elte.hu>, Larry McVoy <lm@bitmover.com>,
	Rik van Riel <riel@conectiva.com.br>,
	Tom Rini <trini@kernel.crashing.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Alexander Viro <viro@math.psu.edu>,
	Rob Landley <landley@trommello.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020130083254.H23269@work.bitmover.com> <Pine.LNX.4.33.0201301933390.11022-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0201301933390.11022-100000@localhost.localdomain>; from mingo@elte.hu on Wed, Jan 30, 2002 at 07:35:03PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 07:35:03PM +0100, Ingo Molnar wrote:
> 
> On Wed, 30 Jan 2002, Larry McVoy wrote:
> 
> > How much of the out order stuff goes away if you could send changes
> > out of order as long as they did not overlap (touch the same files)?
> 
> could this be made: 'as long as they do not touch the same lines of code,
> taking 3 lines of context into account'? (ie. unified diff definition of
> 'collisions' context.)

No.  What you described is diff/patch.  We have that already and if it
really worked in all the cases there would be no need for BitKeeper to
exist.  I'll be the first to admit that BK is too pedantic about change
ordering and atomicity, but you need to see that there is a spectrum and
if we slid BK over to what you described it would be a meaningless tool,
it would basically be a lot of code implementing what people already do
with diff/patch.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
