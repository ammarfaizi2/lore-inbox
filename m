Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262644AbVCCWG0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262644AbVCCWG0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 17:06:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbVCCWDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 17:03:13 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:53426 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262644AbVCCWAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 17:00:36 -0500
Subject: Re: RFD: Kernel release numbering
From: Steven Rostedt <rostedt@goodmis.org>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050303133857.779e5f68@dxpl.pdx.osdl.net>
References: <42265A6F.8030609@pobox.com>
	 <20050302165830.0a74b85c.davem@davemloft.net> <422674A4.9080209@pobox.com>
	 <Pine.LNX.4.58.0503021932530.25732@ppc970.osdl.org>
	 <42268749.4010504@pobox.com> <20050302200214.3e4f0015.davem@davemloft.net>
	 <42268F93.6060504@pobox.com> <4226969E.5020101@pobox.com>
	 <20050302205826.523b9144.davem@davemloft.net> <4226C235.1070609@pobox.com>
	 <20050303080459.GA29235@kroah.com> <4226CA7E.4090905@pobox.com>
	 <Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org>
	 <422751C1.7030607@pobox.com>
	 <Pine.LNX.4.58.0503031022100.25732@ppc970.osdl.org>
	 <1109883750.591.47.camel@localhost.localdomain>
	 <20050303133857.779e5f68@dxpl.pdx.osdl.net>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 03 Mar 2005 17:00:26 -0500
Message-Id: <1109887226.591.74.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-03 at 13:38 -0800, Stephen Hemminger wrote:
> In all this discussion, I see a couple of underlying problems. The first
> is what is the definition of stability.  To many (mostly kernel developers)
> the definition of stability "S" depends on number of bug reports "B":
> 
> 	S(infinite) = B(0)
> 	S(X) > S(Y) iff B(X) < B(Y)
> 
> The problem is that the kernel community never sees many problems (filtered
> through distro's), and the severity and importance of problem reports
> is confused. Bug tracking could help, but it would have to be universal
> and painless; bugzilla doesn't cut it.
> 
> But many end-user's and IT types seem to feel that the definition 
> of stability is based on rate of change, ie patches (P) over time.
> 	
> 	S(X) > S(Y) iff P(X)/t > P(Y)/t
> 
> These are the people who can't believe 2.6 is stable because they see so
> much change. Having 2.6.x.y may make this group happy, but probably only
> after such a long period that the the mainline kernel is 6 months ahead.
> 

As I see it, there's those that would join in at different times. If the
point was to get as many people moving to newer kernels, then this would
make the most people comfortable to try a newer kernel. Maybe not the
latest and greatest, but at least one that is closer to the newest one.

Some might join 6 months behind, others 1 month and even those at 1
week. I've talked to different people, and there are many at the 1 week
point (the ones with the most critical systems would be at the 6 month,
but the 1 weekers are the ones that would put it on a more non essential
machine). 

> The whole point of the continuous 2.6 process, 
> was to avoid having the 
> multiple tree backporting mess that 2.5/2.4 had, especially the distro kernels
> were all some hodge-podge of 2.5 and 2.4 stuff. Fixing the same bug on multiple
> branches is a fundamentally flawed process that is sure to allow some bug fixes
> to be missed.
> 

Truth be told... don't worry about backporting fixes. This is the Open
Source world, many eyes, and many developers.  When a bug is reported,
say to 2.6.x.y, then let some new kernel developer try to fix it, or
whoever. Maybe even the one who reported the problem can fix it. But for
that branch only. If this bug is in a earlier branch, then don't worry
about it until someone else hits it, or say the one who fixed it, then
goes back and checks other branches only if they want to. 

I'm saying, just have the branches available, with no guarantee that
they have all the backported bugs, since no one is going to do it. But
if someone wants it, then they can have a go at it. Maybe even a distro
might add to it.  This might just give people a central repository to
all the fixes applied to a specific branch.  Again, only bug fixes and
nothing more.

> The third group are those that install release 2.6.X and have some problem;
> nobody wants to believe their problem is unique. So often, the user says makes
> the fallacious argument that "if I had a problem, then all users will have the
> problem, therefore it is unstable." These people will never be happy, they can
> stay on 2.2.

If there problem is truly a problem and if these people are capable of
fixing it themselves or finding someone else to fix it. Then again, you
have the fix at some point available for all.

-- Steve


