Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932125AbWIVCAa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbWIVCAa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 22:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbWIVCAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 22:00:30 -0400
Received: from science.horizon.com ([192.35.100.1]:30773 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S932125AbWIVCA3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 22:00:29 -0400
Date: 21 Sep 2006 22:00:28 -0400
Message-ID: <20060922020028.29827.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: 2.6.19 -mm merge plans
Cc: linux@horizon.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> A suggestion from the department of evil ideas: Call even cycles
>> development odd ones stabilizing. Nothing gets into an odd one without a
>> review and linux-kernel signoff/ack ?
>
> I don't think that's an evil idea, and in fact we've discussed it before. 
> I personally like it - right now we tend to have that "interminable series 
> of -rc<n>" (where <n> is 3..) before release, and I'd almost personally 
> prefer to just have a rule that is more along the lines of
>
> - 2.6.<odd> is "the big initial merges with all the obvious fixes to make 
>   it all work" (ie roughly the current -rc2 or perhaps -rc3).
>
> - 2.6.<even> is "no big merges, just careful fixes" (ie the current "real 
>   release")
>
> Each would be ~3 weeks, leaving us with effectively the same real release 
> schedule, just a naming change.
>
> That said, I think Andrew was of the opinion that it doesn't really _fix_ 
> anything, and he may well be right. What's the point of the odd release, 
> if the weekly snapshots after that are supposed to be strictly better than 
> it anyway?
>
> So I think I may like it just because it _seems_ to combine the good 
> features of both the old naming scheme and the current one, but I suspect 
> Andrew may be right in that it doesn't _really_ change anything, deep 
> down.

Not meaning to re-open old wounds, but this is exactly why people
complained about dropping the "-pre" kernels.  That was a good way to
distinguish between "the features are in, but so are some obvious bugs;
read the changelog" and, in -rc, "this has no *known* bugs, so please
test and report".

If you want to just go back to that (2.6.<odd>-rcX would be -pre, and
2.6.<odd> would be -rc1), I don't think people would need it explained
to them.  And the kernel.org mirror system already understands it.

Although, as you say, its not clear that any of this politically
correct renaming is actually changing anything.


If someone really wants to affect the bug count, figure out a way to
auto-generate a "bugs and regressions in mainline, by contributor" score
and publicize that.  As the various distributed computing projects have
found, people can be competitive about the silliest things if you give
them a score to measure themselves by.

Since kudos would flow from the author of a bug to the finder as well
as the fixer, it could simultaneously encourage testers.

Quantifying all of this hand-waving is, of course, a non-trivial
project (how do you compare a printk spelling fix to a silent
IDE data corruption bug?), but it would be very worthwhile.
