Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265078AbRFUSLY>; Thu, 21 Jun 2001 14:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265080AbRFUSLO>; Thu, 21 Jun 2001 14:11:14 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:49169 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S265078AbRFUSLC>;
	Thu, 21 Jun 2001 14:11:02 -0400
Date: Thu, 21 Jun 2001 14:14:42 -0400
Message-Id: <200106211814.f5LIEgK04880@snark.thyrsus.com>
From: "Eric S. Raymond" <esr@snark.thyrsus.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: Controversy over dynamic linking -- how to end the panic
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As you know, there's been another flap recently about the GPL status
of loadable kernel modules.  You have a note that touches on this in
the kernel COPYING file, but it is not sufficient to resolve the
questions that keep coming up.

Earlier today I was contacted by a principal at a well-known Linux
company who was in a mild panic over recent arguments by Alan Cox and
David Miller.  This company (not VA or Red Hat, BTW) fears that their
customers will run from Linux if they get the idea that linking
drivers to the kernel might force them open.

I wrote back as follows:

>Alan's posting beginning "Linus opinion on this is irrelevant" is not a
>`perspective' that he can be argued out of.  He is not arguing about whether
>allowing proprietary binary modules is good, bad, or indifferent.
>
>Alan is merely stating legal facts as he understands them -- and, in
>fact, I agree with his assessment.  The key question is whether the
>particular kind of linking involved with loading binary modules
>propagates derivative-work status under copyright law.  This is a legal
>question a court may rule on someday.  Until one does, anyone who
>relies on such linking is taking a legal risk.
>
>Alan is not quite right that Linus's opinion is irrelevant.  It is irrelevant
>to the underlying legal question, but not to the associated business risk.
>
>As copyright holder of the Linux kernel, Linus is the only person with
>standing to sue for license violation.  Therefore, when he says
>"binary modules are OK", he is stating a policy intention which your
>customers may include in their evaluation of legal risk.  This means
>that in order for them to lose, a court must rule that module linking
>propagates derivative-work status *and* Linus must reverse himself and
>sue.

So I'm proposing a solution.  We can't resolve the underlying legal
question yet, but you can make your policy clearer.

In the existing kernel COPYING file:

>   NOTE! This copyright does *not* cover user programs that use kernel
> services by normal system calls - this is merely considered normal use
> of the kernel, and does *not* fall under the heading of "derived work".
> Also note that the GPL below is copyrighted by the Free Software
> Foundation, but the instance of code that it refers to (the Linux
> kernel) is copyrighted by me and others who actually wrote it.

I suggest replacing this with something resembling the following:

------------------------------------------------------------------------
The GPL license reproduced below is copyrighted by the Free Software 
Foundation, but the Linux kernel is copyrighted by me and others who 
actually wrote it.

The GPL license requires that derivative works of the Linux kernel
also fall under GPL terms, including the requirement to disclose
source.  The meaning of "derivative work" has been well established
for traditional media, and those precedents can be applied to
inclusion of source code in a straightforward way.  But as of
mid-2001, neither case nor statute law has yet settled under what
circumstances *binary* linkage of code to a kernel makes that code a
derivative work of the kernel.

To calm down the lawyers, I as the principal kernel maintainer and
anthology copyright holder on the code am therefore adding the
following interpretations to the kernel license:

1. Userland programs which request kernel services via normal system
   calls *are not* to be considered derivative works of the kernel.

2. A driver or other kernel component which is statically linked to
   the kernel *is* to be considered a derivative work.

3. A kernel module loaded at runtime, after kernel build, *is not*
   to be considered a derivative work.

These terms are to be considered part of the kernel license, applying
to all code included in the kernel distribution.  They define your
rights to use the code in *this* distribution, however any future court
may rule on the underlying legal question and regardless of how the
license or interpretations attached to future distributions may change.
------------------------------------------------------------------------

I believe this would express the present policy clearly enough to soothe
jittery nerves at a lot of companies that are worried about this issue.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Government: If you refuse to pay unjust taxes, your property will be
confiscated. If you attempt to defend your property, you will be arrested.  If
you resist arrest, you will be clubbed. If you defend yourself against
clubbing, you will be shot dead. These procedures are known as the Rule of
Law.

	-- Edward Abbey
