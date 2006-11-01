Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946861AbWKAM2D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946861AbWKAM2D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 07:28:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbWKAM2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 07:28:03 -0500
Received: from DENETHOR.UNI-MUENSTER.DE ([128.176.180.180]:62966 "EHLO
	denethor.uni-muenster.de") by vger.kernel.org with ESMTP
	id S1752074AbWKAM2A convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 07:28:00 -0500
Date: Wed, 1 Nov 2006 13:27:35 +0100
From: Borislav Petkov <petkov@math.uni-muenster.de>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Borislav Petkov <petkov@math.uni-muenster.de>,
       David Rientjes <rientjes@cs.washington.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched.c : correct comment for this_rq_lock() routine
Message-ID: <20061101122734.GA5540@gollum.tnic>
Reply-To: petkov@math.uni-muenster.de
References: <Pine.LNX.4.64.0610301600550.12811@localhost.localdomain> <Pine.LNX.4.64N.0610301308290.17544@attu2.cs.washington.edu> <Pine.LNX.4.64.0610301623360.13169@localhost.localdomain> <20061031153021.GA14505@gollum.tnic> <Pine.LNX.4.64.0610311250500.22528@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610311250500.22528@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2006 at 01:11:06PM -0500, Robert P. J. Day wrote:
> On Tue, 31 Oct 2006, Borislav Petkov wrote:
> 
> > In case you're still doubtful about volunteering:
> >
> > http://lkml.org/lkml/2004/12/20/255
> 
> at the risk of being somewhat long-winded, let me explain what i think
> is a fundamental conflict involving patch submission, particularly WRT
> what are called "trivial" patches.

These are all sound arguments but I guess there's litte one can do in a
community development process where every other developer/maintainer has a
different way of classifying and sorting code commits in the order of their
precedence/importance...

> unlike non-trivial patches such as obvious bug fixes, trivial patches
> obviously don't get quite the attention and, because of that, they
> have a tendency to collect until someone decides to, say, apply all of
> them at once.  most of the time, that's not a problem -- if they're
> simply typo fixes or adding comments, then there's no rush.  but
> that's not always the case.
> 
> in some cases, waiting for the application of one trivial patch might
> hold up the submission of another dependent (trivial) patch.  as an
> example, i was just poking around the source for the various
> "atomic.h" files and noticed a couple possible cleanups:
> 
>   1) make sure *everyone* uses "volatile" in the typedef struct (which
> 	i actually submitted recently)
> 
>   2) standardize on "inline", rather than the current messy mixture of
> 	both "inline" and "__inline__" (which i'm guessing exists for
> 	backward compatibility)
> 
> for the sake of argument, let's assume those were two perfectly
> acceptable cleanups and that no one had any objection.  (i'm just
> hypothesizing here, so nobody get their underoos in a bunch. :-)
> 
> personally, i'd prefer to submit them as separate patches, since i
> like my patches to each represent a single logical issue.  so to start
> things off, i submit a patch to fix the "volatile" issue.  that
> *seems* like a trivial patch, so i submit it as such.  and because
> it's marked as trivial, there's no rush to get to it.

... and because of that, the more trivial it is, the faster it becomes obsolete
so when i first read the announcement on the trivial-list that patches submitted
for kernel version 2.x.n are going to be merged probably in version 2.x.n+2 or
something like that, I thought, well, hell, someone has a really nasty desire
for applying patches with fuzziness of <Really Big Number>. Or even worse,
patches which are not even applicable anymore.

But the problem is, IMHO, that the subsystem maintainers are simply swamped
with, let's say with the risk of sounding insensitive, more important work, 
 so that they just don't have the time for the trivial stuff. So, sometimes, 
there can be a situation when a trivial patch gets forgotten but if you try
thinking of an adequate solution for this not happening, you're soon going to
realize that a solution for trivial patches cannot be a trivial one:). Hell, I
don't even think that there will be a sufficient one.

<snip/>
-- 
Regards/Gruﬂ,
    Boris.
