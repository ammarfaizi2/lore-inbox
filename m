Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132281AbRDCRAK>; Tue, 3 Apr 2001 13:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132326AbRDCRAB>; Tue, 3 Apr 2001 13:00:01 -0400
Received: from [209.125.249.77] ([209.125.249.77]:16391 "EHLO
	mobilix.atnf.CSIRO.AU") by vger.kernel.org with ESMTP
	id <S132281AbRDCQ7r>; Tue, 3 Apr 2001 12:59:47 -0400
Date: Tue, 3 Apr 2001 09:58:11 -0700
Message-Id: <200104031658.f33GwBL05278@mobilix.atnf.CSIRO.AU>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alexander Viro <viro@math.psu.edu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Andries.Brouwer@cwi.nl, torvalds@transmeta.com, hpa@transmeta.com,
        linux-kernel@vger.kernel.org, tytso@MIT.EDU
Subject: Re: Larger dev_t
In-Reply-To: <Pine.GSO.4.21.0104031214270.17127-100000@weyl.math.psu.edu>
In-Reply-To: <200104031605.f33G5D604937@mobilix.atnf.CSIRO.AU>
	<Pine.GSO.4.21.0104031214270.17127-100000@weyl.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
> 
> 
> On Tue, 3 Apr 2001, Richard Gooch wrote:
> 
> > However, a large number of people run devfs on small to large systems,
> > and these "races" aren't causing problems. People tell me it's quite
> > stable. I run devfs on my systems, and not once have I had a problem
> > due to devfs "races". So I feel it's quite unfair to paint such a dire
> > picture (I'm referring to Martin's comments here, not Alan's).
> 
> And _that_ approach is the reason why I absolutely refuse to run
> your code on any of my boxen.  Sorry.  If devfs (without serious
> cleanup) will become mandatory I'll fork the tree - better
> backporting patches to Linus' one than depending on current devfs.

Al, I've told you that the races will be fixed. Calm down. I know you
take a very theoretical and hard-line approach. All I said was that
the races aren't causing problems for people in real life. That's why
some vendors are using it. I never disagreed with you about the
existence of the races.
Peace, OK?

> You've been sitting on known (and easily fixable) bugs and asking to
> leave fixing them to you for what, 10 months already?  Furrfu...

Yeah, 10 months during which I've gone to 7 conferences/workshops,
written 2 papers, moved house twice, took two holidays (sorry, I have
a life), moved/split/unsplit our lab network twice, caught the flu at
least once, and sundry other distractions. Pardon me for being busy.

> You are maintainer of that code.  You keep insisting on having
> everything and a kitchen sink in the devfs and refuse to split the
> functionality into reasonable pieces.  Essentially you are saying
> that it's all or nothing deal.  Fine with me - out of these options
> I certainly prefer the latter.

The claim that splitting it into pieces will be an improvement is just
hand-waving. I've not seen a solid argument that shows how it will
help. Especially not after I remove the FS database code in devfs and
just use the dcache to store my tree. That will trim the code by 50%
or more. I'm going to wait and see how my next versions of devfs turn
out before I make any hard claims.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
