Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130805AbQKSCKT>; Sat, 18 Nov 2000 21:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131444AbQKSCKK>; Sat, 18 Nov 2000 21:10:10 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:65416 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130805AbQKSCJ5>;
	Sat, 18 Nov 2000 21:09:57 -0500
Date: Sat, 18 Nov 2000 20:39:56 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andrea Arcangeli <andrea@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext2 largefile fixes + [f]truncate() error value fix
In-Reply-To: <Pine.GSO.4.21.0011182033200.21893-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0011182037170.21893-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 18 Nov 2000, Alexander Viro wrote:

> On Sun, 19 Nov 2000, Alan Cox wrote:
> 
> > > is probably in order. Alan? Place in question is the check for notify_change()
> > > growing the file past 4Gb - it should check for size >> 32, obviously.
> > 
> > The 2.2 limit is 2Gbytes
> 
> <slaps the forehead> Sorry.

Erm... (size >> 33) is equivalent to size >= (1<<33), and that's 8Gb, not 2Gb.
So unless I've gone completely crazy it should be (size >> 31)...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
