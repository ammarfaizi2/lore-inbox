Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289455AbSA2KYf>; Tue, 29 Jan 2002 05:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286935AbSA2KY1>; Tue, 29 Jan 2002 05:24:27 -0500
Received: from pc-62-30-61-40-mo.blueyonder.co.uk ([62.30.61.40]:2798 "HELO
	gate.mcdee.net") by vger.kernel.org with SMTP id <S289462AbSA2KYL>;
	Tue, 29 Jan 2002 05:24:11 -0500
Subject: Re: A modest proposal -- We need a patch penguin
From: Jim McDonald <Jim@mcdee.net>
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020129095504.GC5485@emma1.emma.line.org>
In-Reply-To: <200201282213.g0SMDcU25653@snark.thyrsus.com> 
	<20020129095504.GC5485@emma1.emma.line.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 29 Jan 2002 10:23:24 +0000
Message-Id: <1012299804.1437.271.camel@lapcat>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-01-29 at 09:55, Matthias Andree wrote:
> On Mon, 28 Jan 2002, Rob Landley wrote:

[...]

> Also, I'm not sure how good Bitkeeper fits here, or whether subversion
> will help in this way (one might consider feeding suggestions to the
> subversion team, http://subversion.tigris.org/, if they do atomic
> commits, one might consider holding them off until blessed by an
> integrator).

I'm not sure that a CVS-type solution is going to fix the problem here. 
>From what I can see, the problems that people are bringing up are as
follows:

   - some patches sent to the list get dropped without comment
   - people are worried about Linus' scalability in handling patches
   - patches time-out quite quickly with the speed of development of
     the kernel, which results in patches not getting applied because
     by the time they get looked they have gone stale
   - people seem to often be unsure about where to send patches
     for unmaintained code, and with no direct maintainer it seems
     that these patches automatically fall outside of Linus'
     trusted kernel people and stand a very small chance of getting
     implemented

I must admit that I agree with Linus' position in most places, but the
result of that is two-fold: a lot of people are left in the dark as to
the state of their patches (ditched, pending, bad style, etc), and a lot
of patch work is duplicated as different people fix the same problem
every couple of months because the fixes are never applied.

We have two solutions - fix the way that all of this works, or try to
patch around the resultant problems.  It looks like number 1 is not
going to happen, so why not do something with 2?  There has been a lot
of talk about putting together a system that re-sends patches every
month or so to lkml, let's write something that does this.  We could get
a number of advantages from this:

   - identification of patches (cleanup, performance improvement, bug 
     fix, new functionality, ...)
   - automatic identification of responsible maintainer (direct from
     patch) to email on submission of patch
   - ability to automatically re-diff patch against latest kernel
     versions and get submitter to re-apply if required
   - simple rejection of patches with minimal effort from maintainers
   - easy way for wannabe-patchers to see what patches are already 
     pending so they can concentrate on other areas and not duplicate
     effort

Note that this isn't that far from SourceForge, but probably too far to
make it worthwhile trying to set it up as an SF project.  If we do this
I figure that at worst it allows for auto-resending of patches that have
slipped through the cracks, and at best it will give people a far more
suitable mechanism for patch submission and tracking than just email.

Comments?  I'm willing to write it if someone is willing to host it.

> Matthias Andree

Cheers,
Jim.
-- 
Jim McDonald - Jim@mcdee.net

