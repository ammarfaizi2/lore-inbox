Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130842AbQLPBno>; Fri, 15 Dec 2000 20:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130839AbQLPBne>; Fri, 15 Dec 2000 20:43:34 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:3078 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130153AbQLPBnV>; Fri, 15 Dec 2000 20:43:21 -0500
Date: Fri, 15 Dec 2000 17:12:36 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Chua <jeffchua@silk.corp.fedex.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Test12 ll_rw_block error.
In-Reply-To: <200012160058.eBG0wtr29000@silk.corp.fedex.com>
Message-ID: <Pine.LNX.4.10.10012151711180.1325-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 16 Dec 2000, Jeff Chua wrote:
>
> > Now, I also agree that we should be able to clean this up properly for
> > 2.5.x, and actually do exactly this for the anonymous buffers, so that
> > the VM no longer needs to worry about buffer knowledge, and fs/buffer.c
> > becomes just another user of the writepage functionality.  That is not
> > all that hard to do, it mainly just requires some small changes to how
> 
> Why not incorporate this change into 2.4.x?

It might be 10 lines of change, and obviously correct.

And it might not be. If somebody wants to try out the DirtyPage approach
for buffer handling, please do so. I'll apply it if it _does_ turn out to
be as small as I suspect it might be, and if the code is straightforward
and obvious.

If not, we're better off leaving it for 2.5.x

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
