Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274582AbRITWUt>; Thu, 20 Sep 2001 18:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274674AbRITWUj>; Thu, 20 Sep 2001 18:20:39 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:44166 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S274582AbRITWUX>;
	Thu, 20 Sep 2001 18:20:23 -0400
Date: Thu, 20 Sep 2001 18:20:39 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
In-Reply-To: <20010921001305.F729@athlon.random>
Message-ID: <Pine.GSO.4.21.0109201817410.5631-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 21 Sep 2001, Andrea Arcangeli wrote:

> It's not that insane: the address space is allocated at open time.
> After you drop it with BLKFLSBUF you will have to open the device again
> to reallocate a new address space. I could just truncate the physical
> address space, there are no other users, but then the inode would remain
> pinned forever, and so until we include your ipinning fix this looked an
> acceptable two liner band-aid I guess (again, real fix is yours, all I'm
> saying is that it can't oops any longer ;).

OK.  Could you resend your patch (or just the page initialization parts
of it)?  I'm getting to the point where I'll start seriously touching
rd.c, so...

