Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <168502-27302>; Mon, 1 Feb 1999 18:31:10 -0500
Received: by vger.rutgers.edu id <161785-27300>; Mon, 1 Feb 1999 18:20:28 -0500
Received: from TEQUILA.CS.YALE.EDU ([128.36.229.152]:1463 "EHLO tequila.cs.yale.edu" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <168243-27302>; Mon, 1 Feb 1999 17:58:37 -0500
To: linux-kernel@vger.rutgers.edu
From: Stefan Monnier <monnier+lists/linux/kernel/news/@tequila.cs.yale.edu>
Newsgroups: lists.linux.kernel
Subject: Re: Page coloring HOWTO [ans]
References: <"4S1CG3.0.Tz5.-gvis"@tequila.cs.yale.edu>
Date: 01 Feb 1999 18:11:18 -0500
Message-ID: <5llnihwwh5.fsf@tequila.cs.yale.edu>
X-Newsreader: Gnus v5.5/Emacs 20.3
Path: tequila.cs.yale.edu
NNTP-Posting-Host: tequila.cs.yale.edu
X-Trace: 1 Feb 1999 18:11:18 -0500, tequila.cs.yale.edu
Sender: owner-linux-kernel@vger.rutgers.edu

>>>>> "Richard" == Richard Gooch <rgooch@atnf.csiro.au> writes:
> OK, I was reading points (a) and (b) as though they were, in effect,
> the required specificiations for an algorithm to yield the best
> pages. Are they just comments on how the particular algorithm you
> mentioned works?

I believe the requirement is really something like "make the behavior more
predictable" (not just deterministic).  To reach this goal, you have to somehow
make sure that non-colliding virtual addresses turn into non-colliding physical
addresses and vice-versa (this way the compiler gets a fair chance to
statically figure out how to lay things out to avoid collisions).

Of course, the other possible requirement is just to make things more
deterministic.  It looks like Dave's alg is aiming for determinism rather than
predictability.


	Stefan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
