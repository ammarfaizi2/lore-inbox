Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316832AbSE3VzR>; Thu, 30 May 2002 17:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316861AbSE3VzR>; Thu, 30 May 2002 17:55:17 -0400
Received: from bgp401130bgs.jersyc01.nj.comcast.net ([68.36.96.125]:2066 "EHLO
	buggy.badula.org") by vger.kernel.org with ESMTP id <S316832AbSE3VzQ>;
	Thu, 30 May 2002 17:55:16 -0400
Date: Thu, 30 May 2002 17:55:14 -0400
Message-Id: <200205302155.g4ULtEb09500@buggy.badula.org>
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Keith Owens <kaos@ocs.com.au>, Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel@vger.kernel.org
Subject: Re: KBuild 2.5 Impressions
In-Reply-To: <E17DMUd-0007dJ-00@starship>
User-Agent: tin/1.5.11-20020130 ("Toxicity") (UNIX) (Linux/2.4.18 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 May 2002 11:45:14 +0200, Daniel Phillips <phillips@bonn-fries.net> wrote:

> I have only one point on the curve, but it confirms what Keith has
> been saying.  The incremental build speed is especially important to
> me.  If I were working all the time on 2.5 - sadly, I'm not - I would
> without question be using kbuild 2.5 simply by reason of the fast
> incremental builds.

There _are_ good things in kbuild25, no question about it, but that's
not a good enough reason to import it wholesale. Especially since Kai
has proven (and continues to do so) that it's possible to improve the
existing build system, to cherry-pick good features from kbuild2.5 
and add them to kbuild24.

> There is no Python anywhere to be seen in kbuild 2.5, for those who
> worry about that.  It is coded in C, about 10,000 lines it seems.
> It has a simple built in database which I suppose accounts for some
> of that.  For what it does, it seems quite reasonable.

Are YOU willing to maintain it if Keith abandons it, though?

That's the biggest problem of kbuild25: maintainability of the
configure+make replacement that Keith is using. Enough people know
make and makefiles that the existing system can be fixed or at least
made to work reasonably well. Not the same thing can be said about
the 10000-line brand-new make augmenter in kbuild25.

> The output that kbuild 2.5 generates is a vast improvment over old
> make.  It's enough to see the progress of the make, while not
> obscuring the warnings.  This by itself should help in cleaning up
> the tree.

If you read Kai's mail, he was actually asking whether this is a
desirable feature to add to kbuild. You don't need kbuild25 for it.

Everything that kbuild25 can be done with regular makefiles. You can
get out-of-tree builds, you can get correct dependencies, you can get
a non-recursive make process. At that point, timings will be _better_
than those of kbuild25.

Also, for those who can't read between the lines: Linus is taking 
(lots of) patches for kbuild24 and is ignoring kbuild25. This should
signal something to people, methinks...

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
