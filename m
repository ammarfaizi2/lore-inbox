Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136822AbREISss>; Wed, 9 May 2001 14:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136823AbREISsi>; Wed, 9 May 2001 14:48:38 -0400
Received: from bitmover.com ([207.181.251.162]:42558 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S136822AbREISsW>;
	Wed, 9 May 2001 14:48:22 -0400
Date: Wed, 9 May 2001 11:48:16 -0700
From: Larry McVoy <lm@bitmover.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: scott@CS.Princeton.EDU, linux-kernel@vger.kernel.org
Subject: Re: Nasty Requirements for non-GPL Linux Kernel Modules?
Message-ID: <20010509114816.K14127@work.bitmover.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	scott@CS.Princeton.EDU, linux-kernel@vger.kernel.org
In-Reply-To: <200105091750.f49HoEg20765@chinstrap.CS.Princeton.EDU> <E14xYMC-0002vn-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3i
In-Reply-To: <E14xYMC-0002vn-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2001 at 07:06:38PM +0100, Alan Cox wrote:
> > As part of our operating system / networking research, we have
> > written a loadable kernel module for Linux.  We would like to
> > distribute the source but we're not sure if our development
> > office will allow us to release it under the GPL (at least
> > initially).  Before meeting with the lawyers, I'm trying to
> > learn what I can about the issue.
> 
> If you want to do binary only then it depends solely how your lawyers intend
> to interpret the concept of 'linking'. Linus comments on the matter have no
> impact since the kernel isnt all his copyright and he has linked in code by
> bodies who are most definitely opposed to binary modules.

The thing to realize is that the there is a concept of a boundary that the 
GPL can not cross.  The GPL itself acknowledges this boundary when it says:

    These requirements apply to the modified work as a whole. If
    identifiable sections of that work are not derived from the Program,
    and can be reasonably considered independent and separate works in
    themselves, then this License, and its terms, do not apply to those
    sections when you distribute them as separate works. 

The point is that there has to be some boundary that the GPL can not
cross otherwise everything in the world would be ``infected'' with the
GPL ``virus.''

For example, suppose I ship you a tarball that has the source & binaries
for both a GPLed program and a non GPLed helper program in it - does the
non GPLed program become GPLed?  I tend to doubt it and so do the lawyers.

Another example: while we all tend to think of the kernel and userland
as different things, from some perspective it's all just code that is
working together to accomplish a task.  Someone could try to interpret
the next sentence in the GPL as saying that because you put the GPLed
kernel on a CD with a non GPLed userland program, the userland 
program is GPLed.  Here's the text:

    But when you distribute the same sections as part of a whole which is
    a work based on the Program, the distribution of the whole must be
    on the terms of this License, whose permissions for other licensees
    extend to the entire whole, and thus to each and every part regardless
    of who wrote it.

Obviously, noone is likely to try and do that because it would instantly
result in a pile of lawsuits that would end up declaring this portion of
the GPL unenforceable and the GPL folks do not want that.

Alan is correct in saying that it is open to interpretation but it is
worth noting that it isn't the concept of 'linking' that is being 
interpreted, it's the concept of a boundary.  This concept is well 
established in the legal world and it has been tested in court.  I don't
have the case in front of me right now, but the conclusion as I understood
it was that a boundary, which is something a license cannot cross, is one
where you can remove the implementation on one side of the boundary and
replace it with a completely different implementation and get identical
or substantially similar results.  Note that this nicely covers the
kernel/libc/user program boundaries.

If the free software community understood and accepted this, by the way,
then I think that it removes the need for the LGPL, it's redundant.

Note that I'm not a lawyer, so my opinion on this is just that,
my opinion.  I have spent a fair amount of time and money trying to
understand the issues and I think I do understand them, but that's still
my opinion and I can still be wrong.  If you really want to know where
you stand, it'll cost you around $15K and that, in my opinion, is fine.
If it isn't worth $15K to protect your code then it is worth so little to
you that there really is no good reason not to just GPL it from the start.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
