Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130512AbQLWTeK>; Sat, 23 Dec 2000 14:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130697AbQLWTeB>; Sat, 23 Dec 2000 14:34:01 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:54290 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130512AbQLWTdv>; Sat, 23 Dec 2000 14:33:51 -0500
Date: Sat, 23 Dec 2000 11:02:53 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Chris Mason <mason@suse.com>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Andreas Dilger <adilger@turbolinux.com>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Alexander Viro <viro@math.psu.edu>,
        Russell Cattelan <cattelan@thebarn.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] changes to buffer.c (was Test12 ll_rw_block error)
In-Reply-To: <300720000.977595690@coffee>
Message-ID: <Pine.LNX.4.10.10012231100190.2174-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 23 Dec 2000, Chris Mason wrote:
> 
> I've updated to test13-pre4, and removed the hunk for submit_bh.
> Looks as though pre4 changed the submit_bh callers to clear the dirty
> bit, so my code does the same.

Basically, I wanted to think of "submit_bh()" as a pure IO thing. When we
call submit_bh(), that is basically the same as "statr IO on this thing".
Which implies to me that submit_bh() doesn't care, or know, about why the
higher layers did this.

Which is why I prefer the higher layers handling the dirty/uptodate/xxx
bits. 

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
