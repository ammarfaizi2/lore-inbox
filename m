Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129295AbQKWWBx>; Thu, 23 Nov 2000 17:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130420AbQKWWBn>; Thu, 23 Nov 2000 17:01:43 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:29413 "EHLO math.psu.edu")
        by vger.kernel.org with ESMTP id <S129295AbQKWWBb>;
        Thu, 23 Nov 2000 17:01:31 -0500
Date: Thu, 23 Nov 2000 16:31:28 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Matti Aarnio <matti.aarnio@zmailer.org>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: {PATCH} isofs stuff
In-Reply-To: <20001123225900.E28963@mea-ext.zmailer.org>
Message-ID: <Pine.GSO.4.21.0011231618120.11491-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 23 Nov 2000, Matti Aarnio wrote:

> On Thu, Nov 23, 2000 at 12:38:55PM -0800, Linus Torvalds wrote:
> ... 
> > In fact, almost all filesystems do this at some point. ext2 does it for
> > directories too, for some very similar reasons that isofs does. See
> > fs/ext2/dir.c:
> > 
> > 	blk = (filp->f_pos) >> EXT2_BLOCK_SIZE_BITS(sb);
> > 
> > (and don't ask me about the extraneous parenthesis. I bet some LISP
> > programmer felt alone and decided to make it a bit more homey).
> > 
> > 		Linus
> 
>    Propably some programmer has been bitten once too many times with
>    C's operator precedence rules, which only affect more complicated
>    expressions -- and thus are used rarely, and not remembered well.

Come again?  Precedence or not, how in hell could anything be stronger than
-> or . on the _right_ side? Field names are atoms, you can't have an
expression there...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
