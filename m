Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132318AbREFDQJ>; Sat, 5 May 2001 23:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132395AbREFDP6>; Sat, 5 May 2001 23:15:58 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:32390 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S132318AbREFDPt>;
	Sat, 5 May 2001 23:15:49 -0400
Date: Sat, 5 May 2001 23:15:47 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Chris Wedgwood <cw@f00f.org>
cc: Andrea Arcangeli <andrea@suse.de>, Jens Axboe <axboe@suse.de>,
        Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, volodya@mindspring.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
In-Reply-To: <20010506150058.A31393@metastasis.f00f.org>
Message-ID: <Pine.GSO.4.21.0105052313040.26799-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 6 May 2001, Chris Wedgwood wrote:

> On Sun, May 06, 2001 at 04:50:01AM +0200, Andrea Arcangeli wrote:
 
>     About a kernel based fsck Alexander told me he likes it, I
>     personally don't care about it that much because I believe...
> 
> As I said, I'm not takling about kernel based fsck, although for
> _VERY_ large filesystems even with journalling I suspect it will be
> required one day (so it can run in the background and do consistency
> checking when the machine is idle).

It's not exactly "kernel-based fsck". What I've been talking about is
secondary filesystem providing coherent access to primary fs metadata.
I.e. mount -t ext2meta -o master=/usr none /mnt and then access through
/mnt/super, /mnt/block_bitmap, etc.

