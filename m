Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263608AbRFFQ6k>; Wed, 6 Jun 2001 12:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263607AbRFFQ6a>; Wed, 6 Jun 2001 12:58:30 -0400
Received: from twinlark.arctic.org ([204.107.140.52]:10771 "HELO
	twinlark.arctic.org") by vger.kernel.org with SMTP
	id <S263608AbRFFQ6T>; Wed, 6 Jun 2001 12:58:19 -0400
Date: Wed, 6 Jun 2001 09:58:18 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Alexander Viro <viro@math.psu.edu>
cc: Sean Hunter <sean@dev.sportingbet.com>,
        "Dr S.M. Huen" <smh1008@cus.cam.ac.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: Break 2.4 VM in five easy steps
In-Reply-To: <Pine.GSO.4.21.0106060637580.7264-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33.0106060949200.21294-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jun 2001, Alexander Viro wrote:

> On Wed, 6 Jun 2001, Sean Hunter wrote:
>
> > This is completely bogus. I am not saying that I can't afford the swap.
> > What I am saying is that it is completely broken to require this amount
> > of swap given the boundaries of efficient use.
>
> Funny. I can count many ways in which 4.3BSD, SunOS{3,4} and post-4.4 BSD
> systems I've used were broken, but I've never thought that swap==2*RAM rule
> was one of them.
>
> Not that being more kind on swap would be a bad thing, but that rule for
> amount of swap is pretty common. ISTR similar for (very old) SCO, so it's
> not just BSD world. How are modern Missed'em'V variants in that respect, BTW?

frequently when building out a solaris web farm you have to just bite it
and throw away half your disk for swap that will never be used.  it's got
pessimistic memory allocation by default.

you can do something with mmap() to get an optimistic allocation, but i
didn't trust making this change to apache when i was involved with a farm
like this... i didn't want to be debugging any potential low memory
problems.

-dean

