Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273938AbRIRV1l>; Tue, 18 Sep 2001 17:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273940AbRIRV1b>; Tue, 18 Sep 2001 17:27:31 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:9691 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S273938AbRIRV1R>;
	Tue, 18 Sep 2001 17:27:17 -0400
Date: Tue, 18 Sep 2001 17:27:40 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: Andreas Dilger <adilger@turbolabs.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
In-Reply-To: <200109182106.f8IL6Js14650@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.GSO.4.21.0109181710400.27538-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 18 Sep 2001, Richard Gooch wrote:

> Actually, many times I fed Linus smaller patches. I tried to get the
> FS core itself in separately from the drivers, which was 100% safe
> (since no existing code was touched), but he wasn't interested. If the
> devfs core *had* been accepted on it's own, I could then have
> reasonably split up the driver patches.
> 
> However, I disagree with your "long history of problems" comment. You
> make it sound like devfs hasn't performed reliably, whereas in real
> life (i.e. normal use, not constructed exploits) it's done quite well.
> 
> In any case, if your "I can't be arsed to split my patch" comment is
> directed at me, I take offense. I did actually take the trouble to
> split up my patch.

Sheesh... Statement: "non-priveleged user can crash any released version
of kernel if devfs is compiled in and mounted".  Provably true.  It _does_
qualify as a problem and yes, I would say that 20 months _is_ long.

Regardless of the reasons why the thing went in once chunk, presence of
these problems is a direct result.  Anyone who wants to push a large
patch into the tree is inviting the same result.

BTW, potentially useful observation: if a preliminary chunk of patch
makes sense on its own, it gets much better chance to get applied.
Accepting devfs core in one step would be completely useless - it's
still too large (~100Kb) and if it would be applied first, it would
get zero testing until the rest went in.

Anyway, Zen And Art Of Feeding Patches Into Tree is a topic for a different
thread...  AFAICS devfs could be split in meaningful steps (ones that
would get testing immediately and would add functionality by pieces),
but by now it's hardly interesting.  If you want details - let's take
it to private mail, preferably when I'll have some spare time.

