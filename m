Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129547AbQLEDMw>; Mon, 4 Dec 2000 22:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130252AbQLEDMm>; Mon, 4 Dec 2000 22:12:42 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:18192 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129547AbQLEDMe>; Mon, 4 Dec 2000 22:12:34 -0500
Date: Mon, 4 Dec 2000 18:41:52 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <andrewm@uow.edu.au>
cc: Alexander Viro <viro@math.psu.edu>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] inode dirty blocks
In-Reply-To: <3A2C493C.4A321797@uow.edu.au>
Message-ID: <Pine.LNX.4.10.10012041840240.1904-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 5 Dec 2000, Andrew Morton wrote:
> 
> 	- test12-pre4
> 	- aviro bforget patch 

Is the bforget patch really needed?

If clear_inode() gets rid of dirty buffers, I don't see how new dirty
buffers can magically appear. I may have missed part of the discussion on
all this.

I think that the second patch from Al (the inode dirty meta-data) is the
_real_ fix, and I don't see why the bforget changes should matter.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
