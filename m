Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264973AbUEYRFz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264973AbUEYRFz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 13:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264980AbUEYRFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 13:05:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:31643 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264973AbUEYRF3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 13:05:29 -0400
Date: Tue, 25 May 2004 10:05:26 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "J. Bruce Fields" <bfields@fieldses.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFD] Explicitly documenting patch submission
In-Reply-To: <20040525164232.GD28169@fieldses.org>
Message-ID: <Pine.LNX.4.58.0405250948530.9951@ppc970.osdl.org>
References: <Pine.LNX.4.58.0405222341380.18601@ppc970.osdl.org>
 <20040525164232.GD28169@fieldses.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 25 May 2004, J. Bruce Fields wrote:
> 
> The patch-submission process can be more complicated than a simple path
> up a heirarchy of maintainers--patches get bounced around a lot
> sometimes.

Yes. And documenting the complex relationships obviously can't be sanely 
done. The best we can do is a "it went through these people".

Perfect is the enemy of good. If we tried to be perfect, we'd never get 
anything done.

> If you're trying to document who contributes "intellectual property" to
> the kernel

No, that's not what it is either.  At least to me, equally important as 
the actual author is how it got reviewed, and what path it took. Because 
when problems happen (say a simple bug), I want the whole path to know.

Think of it this way (purely technical to avoid any emotional arguments):  
we've hunted down a change that results in strange behaviour, and what we
want to do is get the problem explained and resolved. Maybe the thing to 
do is to just revert the whole change, but usually we just want to fix it, 
and regardless of whether we want to undo it or fix it, what we want to do 
is get the people who were involved with not just writing the code, but 
approving it too to look at the issue.

And the people who approved it literally _are_ as important as the people 
who wrote it (forget any copyright issues), since (a) they need to know to 
avoid the problem in the first place and (b) they usually know why the 
code was added and what problems _they_ saw (or didn't see) when they 
approved it.

See? That's why to me, the set of people who have been involved in the
whole patch "lifetime" is actually _more_ important than the original
author. The original author is obviously special in some respects, but
from a problem solving perspective he's not necessarily even the person to
go to.

> I gues I'm still a little vague as to exactly what sort of questions we
> expect to be able to answer using this new documentation.

See above. I explicitly picked a _technical_ reason for tracking who has
been involved with a patch, but let's say that somebody raises concerns
over any _other_ issues about the code - the fact is that the same logic 
applies. The original author is a bit special, but the path it took is 
still equally important.

> A couple examples (which I think aren't too farfetched):
> 	* Developer A submits a patch which is dropped by maintainer B.
> 	  I later notice this and resubmit A's patch to B.  I don't
> 	  change the patch at all, and the resubmission is my only
> 	  contribution to the process.  Do I need to tag on my own
> 	  "Signed-off-by" line?

Yup. And part of it is simply credit: trust me when I say to you that
"maintenance" of patches is a job that it at _least_ as important as
writing them in most cases.

That's not always true, of course - there are pieces of code that are just
stunning works of art, and very important, and as programmers we like to 
think of those really fundamental contributions. But in real life, it's 
definitely the old case of "1% inspiration, 99% persiration", and we 
should just accept that.

For example, look at the kernel developers out there, and ask yourself who 
stands out. There's a couple of great coders, but I think the people who 
really stand out are people like Andrew, who mostly really "organize" and 
act as managers. Right?

So when you save a patch from oblivion by passing it on to the right 
person, and get it submitted when it was originally dropped by some 
reason, you're actually doing a fundamentally important job. Maybe it's 
just one small piece of the puzzle, but hey, you'd only get one small line 
in the changeset, so the credit (or blame ;) really is appropriate.

> 	* I write a patch.  Developers X and Y suggest significant
> 	  changes.  I make the changes before I submit them to maintainer
> 	  Z.  Suppose the changes are significant enough that I no longer
> 	  feel comfortable representing myself as the sole author of the
> 	  patch.  Should I also be asking developer X  and Y to add their
> 	  own "Signed-off-by" lines?

That, my friend, is a matter of your own taste and conscience. My answer
is that if you wrote it all, you clearly don't _need_ to. At the same
time, I think that it's certainly in good taste to at least _ask_ them. 
Wouldn't you agree?

		Linus
