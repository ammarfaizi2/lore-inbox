Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285130AbSAEVl3>; Sat, 5 Jan 2002 16:41:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285135AbSAEVlJ>; Sat, 5 Jan 2002 16:41:09 -0500
Received: from asooo.flowerfire.com ([63.254.226.247]:1294 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S285130AbSAEVk7>; Sat, 5 Jan 2002 16:40:59 -0500
Date: Sat, 5 Jan 2002 15:40:53 -0600
From: Ken Brownfield <brownfld@irridia.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020105154053.A18545@asooo.flowerfire.com>
In-Reply-To: <20020103142301.C4759@asooo.flowerfire.com> <200201040019.BAA30736@webserver.ithnet.com> <20020103232601.B12884@asooo.flowerfire.com> <20020104140321.51cb8bf0.skraw@ithnet.com> <20020104175050.A3623@asooo.flowerfire.com> <20020105160833.0800a182.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20020105160833.0800a182.skraw@ithnet.com>; from skraw@ithnet.com on Sat, Jan 05, 2002 at 04:08:33PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 05, 2002 at 04:08:33PM +0100, Stephan von Krawczynski wrote:
| I am pretty impressed by Martins test case where merely all VM patches fail
| with the exception of his own :-) The thing is, this test is not of nature
| "very special" but more like "system driven to limit by normal processes". And
| this is the real interesting part about it.

One problem is that I've never heard of it and don't know where to get
it. ;)

| What exactly do you mean with "high IRQ rate"? Can you show so numbers from
| /proc/interrupts and uptime for clarification?

I did, back in the archives.  I don't have easy access to archives etc,
right now, but I might repost since it's been a while.

| The problem is: you should really use one of your problem machines for at least
| very simple testing. If you don't you possibly cannot expect your problem to be
| solved soon. We would need input from your side. If I were you, I'd start of
| with Martins patch. It is simple (very simple indeed), small and pinned to a
| single procedure. Martins test shows - under "normal" high load (not especially
| IRQ) - good result and no difference in standard load, I cannot see a risk for
| oops or deadlock.

Well, reboots are the problem over possible oopses (or data corruption,
even more fun.)  But on your recommendation I'll give Martin's mod a
try, given a URL.  Does Martin's patch play well with -aa?  How about
Martin+10_vm in -pre2? ;-)

At any rate, right now there are three or four people with different VM
patch sets, probably more.  There is a certain amount of work this group
can do in judging which concepts are cleaner or most suitable to 2.4.x.
It would be cool to give rmap a try, but I don't want to maintain a
2.4.x kernel with speculative features that aren't intented for 2.4.x.

I can see using patches back-ported from 2.5, but I'm a firm believer
that 2.4 should stay stable and that the benefit of 2.4 to admins is the
control by the maintainer and stability -- not the VM of the month.

I can test, but it's slow going with so many patches.  And many of the
patches haven't been properly merged with any kernel (e.g., -aa 10_vm
reverting previously applied 2.4 changes, etc.)

While I've reproduced the issues and explained them here in the past,
it's difficult for me to iterate fast enough in an environment that
easily reproduces tha problem.  I'm iterating as fast as I can, but when
I do iterate I'd prefer some support from the maintainers or other parts
of the community that "Yes, this patch has a good chance of fixing the
specific problems we've been seeing, give it a try."  Right now that
doesn't exist (with the exception of your recommendation of this Martin
patch), and that's one reason I'm hesitant to iterate too much and
effect a lot of people.

Thanks,
-- 
Ken.
brownfld@irridia.com


| 
| Regards,
| Stephan
| 
