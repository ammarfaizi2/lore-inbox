Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265221AbTLFRut (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 12:50:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265222AbTLFRut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 12:50:49 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:25301 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S265221AbTLFRun
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 12:50:43 -0500
Date: Sat, 6 Dec 2003 09:50:41 -0800
From: Larry McVoy <lm@bitmover.com>
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Larry McVoy <lm@bitmover.com>, Erik Andersen <andersen@codepoet.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Paul Adams <padamsdev@yahoo.com>
Subject: Re: Linux GPL and binary module exception clause?
Message-ID: <20031206175041.GD28765@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
	Larry McVoy <lm@bitmover.com>,
	Erik Andersen <andersen@codepoet.org>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Paul Adams <padamsdev@yahoo.com>
References: <20031204235055.62846.qmail@web21503.mail.yahoo.com> <20031205004653.GA7385@codepoet.org> <Pine.LNX.4.58.0312041956530.27578@montezuma.fsmlabs.com> <20031205010349.GA9745@codepoet.org> <20031205012124.GB15799@work.bitmover.com> <Pine.LNX.4.58.0312041750270.6638@home.osdl.org> <20031206030037.GB28765@work.bitmover.com> <20031206141300.GA13372@pimlott.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031206141300.GA13372@pimlott.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 06, 2003 at 09:13:00AM -0500, Andrew Pimlott wrote:
> On Fri, Dec 05, 2003 at 07:00:37PM -0800, Larry McVoy wrote:
> This last is unfounded.  It may be true to say that Sun could only
> release Solaris+XYZ under the GPL, but it is fantasy to imagine that
> this makes Solaris now GPLed.  

Right you are, my apologies.  My brain was in contract space, not
copyright space.  

>     and--where appropriate--attorneys' fees. A defendant found to
>     have wrongfully included GPL'd code in its own proprietary work
>     can be mulcted in damages for the distribution that has already
>     occurred, and prevented from distributing its product further.
>     That's a sufficient disincentive to make wrongful use of GPL'd
>     program code. And it is all that the Copyright Act permits.
> 
> (At first, I had hoped that "mulcted" was a typo for "mulched", but
> then I looked it up.)

I did too, for those who didn't, it's an old word with two meanings and 
the meaning here (I am pretty sure) is "punished with a fine".  Leave it
to a lawyer to know that one :)

> It might be true that Sun's misdeed perpetually voids their license
> to XYZ.  

That's a good question, it's not clear what the answer to that is.  I reread
the GPL and I don't see where it spells out what happens if you try and cheat.

> > Roll forward a bit and see how this plays out in court.  Suppose there is
> > code in Linux that is derived from Unix.  Remember, if Unix licenses had
> > the same viral effect as the GPL, all it takes is a function or two and
> > the rest of the code is GPL-ed (or in this case, Unix-ed).  If you are
> > arguing that an API isn't a boundary for the GPL you are going to look
> > bloody two faced when you go and argue that an API is a boundary for Unix.
> 
> Your comparisons to the SCO case are far-fetched.  In part because
> of what I said above (your idea of "viral" is divorced from
> reality)

In copyright law, yes.  Contract law is a bit different.  Linus and
you yanked me back into copyright law and you're right that SCO can't
claim rights to Linux, they don't own it.  But isn't it true that if
the Unix license they have with IBM (actually more likely Sequent) is a
contract then that contract could extend to anything that was originally
written in the context of Unix, even if 100% of was written by Sequent
and removed from Unix and ported to Linux?

If I wrote a contract that gave you rights to use and extend some program
I wrote and I put into that contract that you may not distribute any code
that was written as part of the program to a third party that did not have
a license, isn't that legal?

And if it is, which I believe to be true, and if you wrote a new widget
that was originally done in the context of that program but now wanted
to put that widget someplace else and the widget removed all references
to the original program, do I still have any contractially based rights
to that widget?  This is the crucial question for SCO.  I doubt that
the answer is really simple but I think that the answer has a lot to do 
with the concept of a boundary which is why I keep harping on that.

> You seem to think that this boundary thing is black and white.  "If
> the GPL crosses the kernel-module boundary, any license can cross
> any boundary."  I think you have to do better than that.

Nothing in law is black and white, it's all sorted out in caselaw
typically.  But as far as I can tell there has to be some way to limit
the influence of a contract or a license or otherwise everything that
ran on a GPLed kernel would be GPLed (the HURD is a GPLed kernel, right?
How much you want to bet that the FSF is not going to try and make the
claim that userland has to be GPLed?)

My guess is that at some point there will be a court case that clarifies
fair use for code and the clarification will be focussed on the concept
of a boundary with the definition of the boundary being the ability to
replace one section of the program with a different work, said work not
be derived from the program, and have the program continue to operate
as it did before.  I.e., a different userland implementation of "cat"
shows that the kernel can't infect userland, a different implementation
of libc.so shows that libc can't infect user programs.

The sticky one is the one where we started, kernel modules.  Linus is
saying that kernel modules are covered by the GPL because they are
combined with the kernel.  I think his reasoning is weak and unlikely
to be upheld by the courts.  If we remove the issue of inline functions
for a moment then we are talking about pure API's and there is no way
that the courts are going to uphold that a copyright license can cross a
pure API (famous last words).  Well, no way if both sides of the dispute
have equally good lawyers, without that who knows.  Let's just suppose
that things work out reasonably and the courts say that using an API
is "fair use".  That leaves the inline functions.  If they are small I
believe there is a lot of precedent for ignoring them.  Even the FSF says
that one liner patches don't need copyright assignment to the FSF.  And if
the module doesn't use those functions or provides their own version of
those functions then I doubt that the inline functions have any bearing.
Comments?
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
