Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293119AbSCOSra>; Fri, 15 Mar 2002 13:47:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293109AbSCOSrY>; Fri, 15 Mar 2002 13:47:24 -0500
Received: from bitmover.com ([192.132.92.2]:20177 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S293129AbSCOSrG>;
	Fri, 15 Mar 2002 13:47:06 -0500
Date: Fri, 15 Mar 2002 10:47:05 -0800
From: Larry McVoy <lm@bitmover.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 and BitKeeper
Message-ID: <20020315104705.N29887@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3C90E994.2030702@candelatech.com> <20020315080408.D11940@work.bitmover.com> <a6tcnf$shg$1@penguin.transmeta.com> <3C923A6A.2030905@mandrakesoft.com> <a6teec$sis$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <a6teec$sis$1@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Mar 15, 2002 at 06:27:24PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2002 at 06:27:24PM +0000, Linus Torvalds wrote:
> (It should be noted that this design mistake is also one of the
> stumbling blocks for ever improving the BK databases. It limits your
> viability in the long run, which is why I'm trying to prod Larry into
> fixing it).

Here's the deal.  I know you guys all think that I'm a genius and
everything, but I'm actually dumb as a board.  The "design mistake"
was made so that I could have BK generate pure SCCS files and test that
I did the same thing as a known working tool, ATT SCCS.  By doing that,
I easily saved myself a year of design.  Making interleaved deltas work
is hard for me (we have Rick here now and he's forgotten more about this
stuff than I'll ever know, but we didn't have him when I wrote the SCCS
compat weave).

At this point, I trust our implementation of the weave more than I trust
the ATT one, and ours handles several cases that theirs doesn't, so I'm
a lot less concerned about that compatibility.

And we know that we can get better performance, and dramatically reduce
fragmentation, by sticking all the files in one big file, and we've known
this for a long time.  We're gonna do it, you're gonna love, it's less
filling, it tastes great.  There is only so many things that we can do at
once and this is on our short list, but it isn't at the top.  Keep that
in mind as you push us to make enhancements, there is no free lunch, so
prioritize.

I'm gonna hack at least make & patch to know about the new format and
work the way they do now.  So I can have your cake and eat it too.
If I can't get the FSF to take the changes, we'll just ship 'em,
we ship diff & patch already, so it's not so hard to alias make='bk make'.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
