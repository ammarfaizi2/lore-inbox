Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313267AbSDUOZ3>; Sun, 21 Apr 2002 10:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313313AbSDUOZ2>; Sun, 21 Apr 2002 10:25:28 -0400
Received: from hera.cwi.nl ([192.16.191.8]:51667 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S313267AbSDUOZ2>;
	Sun, 21 Apr 2002 10:25:28 -0400
From: Andries.Brouwer@cwi.nl
Date: Sun, 21 Apr 2002 16:25:08 +0200 (MEST)
Message-Id: <UTC200204211425.g3LEP8Q25419.aeb@smtp.cwi.nl>
To: torvalds@transmeta.com, viro@math.psu.edu
Subject: Re: BK, deltas, snapshots and fate of -pre...
Cc: adilger@clusterfs.com, akpm@zip.com.au, linux-kernel@vger.kernel.org,
        spyro@armlinux.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> FWIW, I doubt that dropping -pre completely in favour of dayly snapshots
> is a good idea - "2.5.N-preM oopses when ..." is preferable to
> "snapshot YY/MM/DD oopses when..." simply because it's easier to match
> bug reports that way.

: Dailies (nice) would need some distinguishing feature in EXTRAVERSION,
: please.  "-20Apr02" would suit.

= Well, hopefully it will be "-pre020420" so that increasing kernel
= versions can be sorted...  Also, skip releasing snapshots on days
= when no new deltas have been applied...

In the good old days we had frequent releases.
For example, the 1.3 series went from 1.3.1 to 1.3.100
in eleven months, an average of one patch every three days.

These days we have pre-patches (15 since Feb 1), and patches
(5 since Feb 1) showing an average of one patch every four days.
So, maybe there is a small slow-down, or maybe the testintervals
were chosen unfortunately.

If it is possible to increase the fequency with which patches are
released, then that is very good. There is no need to invent new
numbering schemes. Indeed, I would be in favour of collapsing
the present scheme (for 2.5), and call everything patch-2.5.N,
no reason to panic when N reaches into the hundreds.

The reason I object to "-20Apr02" or "-pre020420" is that it
makes it difficult to see whether there are missing patches
in a given archive. Sequential numbering is better.
(Moreover, there might be two patches on one day, there is a
handful of examples already.)

Concerning the collapsing of patches and prepatches:
For a stable series like 2.4 one needs pre-patches to have a
test-period. For an unstable series like 2.5 pre-patches only
cause a small amount of hassle (the naming is different, they
live in different directories, the patches are not incremental,
incremental patches again have a different naming scheme)
and as far as I can see the presumed advantage, namely that the
result of a patch is more stable than that of a pre-patch, is
absent so far in the 2.5 series. Maybe prepatches should first
be reinvented again shortly before the release of 2.6.

Andries

