Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129819AbQK2JjW>; Wed, 29 Nov 2000 04:39:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129761AbQK2JjM>; Wed, 29 Nov 2000 04:39:12 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:40363 "EHLO math.psu.edu")
        by vger.kernel.org with ESMTP id <S129655AbQK2Ji6>;
        Wed, 29 Nov 2000 04:38:58 -0500
Date: Wed, 29 Nov 2000 04:08:26 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Andries.Brouwer@cwi.nl, Tigran Aivazian <tigran@veritas.com>,
        linux-kernel@vger.kernel.org
Subject: Re: corruption
In-Reply-To: <Pine.LNX.4.10.10011282105040.5871-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0011290351080.14112-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 28 Nov 2000, Linus Torvalds wrote:

> The fact that it is in-core only doesn't mean that much - it could still
> easily be just problems at read-time, and if you have an IDE disk I would
> strongly suggest you try out the patch that Jens Axboe posted,
> re-initializing the "head" pointer when doing a re-merge.
> 
> That said, the VM/ext2 angle should definitely be looked at too. Nothing
> has really changed there in some time - can you give a rough estimate on
> when you suspect you started seeing it? Ie is it new to one of the test11
> pre-kernels, or does it happen so occasionally that you can't tell whether
> it happened much earlier too?

Problem fixed by Jens' patch had been there since March, so if it's a
mix of __make_request() screwing up and something else... Urgh.

I'ld really like to see details on the box with ext2 corruption on SCSI.
Tigran, IIRC you had it on SCSI boxen, right? Could you send me relevant
part of logs?


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
