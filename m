Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273806AbRIRC23>; Mon, 17 Sep 2001 22:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273807AbRIRC2T>; Mon, 17 Sep 2001 22:28:19 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:30728 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S273806AbRIRC2K>; Mon, 17 Sep 2001 22:28:10 -0400
Date: Mon, 17 Sep 2001 19:27:31 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Benjamin LaHaise <bcrl@redhat.com>
cc: Andrea Arcangeli <andrea@suse.de>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
In-Reply-To: <20010917221653.B31693@redhat.com>
Message-ID: <Pine.LNX.4.33.0109171919330.1068-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 17 Sep 2001, Benjamin LaHaise wrote:
>
> __builtin_expect.  It just goes to show that you haven't bothered to get any
> feedback on this patch which is significantly invasive before merging it.
> This is completely unreasonable behaviour for a kernel series which is
> supposed to be stable.

No, it goes to show that I didn't actually apply all of Andrea's patches.
I left out a number of patches that I didn't see the point to, or that I
just plain disagreed with.

And some of the patches had some non-obvious dependencies, especially as I
have a reasonably recent compiler..

> The code in question does not attempt to explain itself at all.  Your release
> notes did not explain what changes you did at all.  Nor are your patches
> split up into reasonable chunks of functionality that can be evaluated based
> on their individual merit.  All or nothing is *not* the approach that should
> be taken at present.  (Hint, stability is acheived gradually.)

Actually, many of them _are_ split up, much more so than Alan's public
patches are (now, Alan in private splits up the patches really well, so
for me it tends to be even easier to apply Alans patches than Andreas, but
as with Alan, my one-liner "merged with xxxx" doesn't go into the detail
that Andrea and others actually do have).

Now, the VM part of the patch was certainly fairly big. I doubt much of it
could have been reasonably split up, though.

> No, what I'm deeply concerned with is the nature of patch merging.  There was
> no obvious public testing of the changes before merging, no warning of it, the
> patch contained obvious bogus chunks and many unrelated changes.  I've never
> seen as invasive a patch merged that ran the risk of completely torpedoing
> stability merged into a STABLE KERNEL SERIES, nor would I ever consider
> submitting such a patch.  There are bug fixes that are outstanding in -ac
> that aren't being merged to -linus, yet this completely untested pile of messy
> code is merged without hesitation?

Without hesitation? Hardly.

The bug fixes in -ac that aren't merged into -linus are that way BECAUSE
NOBODY HAS SENT ME MERGES.

Alan works on it quite intensively, but the fact is, that for the -ac
merge, Alan seems to be able to merge it slower than -ac grows. Which is
why I actually started asking people to merge their parts from -ac into
-linus to help Alan. That's how the other merge in -pre11 happened.

The aa tree has existed for a long time, and is actually mainted in better
chunks than the -ac tree, which makes it easier to merge. Admittedly my
and Alans tastes are often closer than mine and Andreas, which means that
the -aa tree merges are more painful for _me_ ;)

		Linus

