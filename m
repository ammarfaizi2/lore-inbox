Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130036AbRABDfJ>; Mon, 1 Jan 2001 22:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130277AbRABDfA>; Mon, 1 Jan 2001 22:35:00 -0500
Received: from baldur.fh-brandenburg.de ([195.37.0.5]:45048 "HELO
	baldur.fh-brandenburg.de") by vger.kernel.org with SMTP
	id <S130036AbRABDeq>; Mon, 1 Jan 2001 22:34:46 -0500
Date: Tue, 2 Jan 2001 04:00:16 +0100 (MET)
From: Roman Zippel <zippel@fh-brandenburg.de>
To: Alexander Viro <viro@math.psu.edu>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Daniel Phillips <phillips@innominate.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Generic deferred file writing
In-Reply-To: <Pine.GSO.4.21.0101011006300.10106-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.10.10101020351500.24795-100000@zeus.fh-brandenburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 1 Jan 2001, Alexander Viro wrote:

> But... But with AFFS you _have_ exclusion between block-allocation and
> truncate(). It has no sparse files, so pageout will never allocate
> anything. I.e. all allocations come from write(2). And both write(2) and
> truncate(2) hold i_sem.
> 
> Problem with AFFS is on the directory side of that business and there it's
> really scary. Block allocation is trivial...

Block allocation is not my problem right now (and even directory handling
is not that difficult), but I will post somethings about this on fsdevel
later.
But one question is still open, I'd really like an answer for:
Is it possible to use a per-inode-indirect-block-semaphore?

bye, Roman

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
