Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289056AbSAUFa4>; Mon, 21 Jan 2002 00:30:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289047AbSAUFaq>; Mon, 21 Jan 2002 00:30:46 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:6025 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S289046AbSAUFab>; Mon, 21 Jan 2002 00:30:31 -0500
Date: Sun, 20 Jan 2002 22:30:26 -0700
Message-Id: <200201210530.g0L5UQu20723@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: ebiederm@xmission.com (Eric W. Biederman),
        Rik van Riel <riel@conectiva.com.br>,
        Adam Kropelin <akropel1@rochester.rr.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.18pre3-ac1
In-Reply-To: <E16SVPU-0001dp-00@starship.berlin>
In-Reply-To: <Pine.LNX.4.33L.0201140409260.32617-100000@imladris.surriel.com>
	<m1y9j1pf6r.fsf@frodo.biederman.org>
	<E16SVPU-0001dp-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips writes:
> The way I see it, the purpose of lazy page table instantiation is to
> overcome objections to the reverse pte mapping vm technique that
> have been expressed in the past, namely the slowdown in dup_mmap
> inside fork.  I.e., if rmap slows down fork then Linus and Davem are
> going to veto it, as they've done in the past, because they feel
> that the as-yet-unproven advantages of physically-based vm scanning
> doesn't outweigh the easily measurable fork overhead.  Personally, I
> think that's debatable, but by eliminating the overhead we eliminate
> the objection, and as far as I know, it's the only serious
> objection.

Will lazy page table instantiation speed up fork(2) without rmap?
If so, then you've got a problem, because rmap will still be slower
than non-rmap. Linus will happily grab any speedup and make that the
new baseline against which new schemes are compared :-)

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
