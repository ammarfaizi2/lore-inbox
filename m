Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129753AbQJ3XPY>; Mon, 30 Oct 2000 18:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129714AbQJ3XPO>; Mon, 30 Oct 2000 18:15:14 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:13762 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129659AbQJ3XPB>;
	Mon, 30 Oct 2000 18:15:01 -0500
Date: Mon, 30 Oct 2000 18:14:58 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: test10-pre7
In-Reply-To: <Pine.LNX.4.10.10010301459250.1085-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0010301810170.1177-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 30 Oct 2000, Linus Torvalds wrote:

> Ok, sync_page() looks like a broken design, but I suspect that for
> expediency the simplest fix is to just make the NFS sync_page() (re-)check
> for "mapping == NULL", and let it be at that. Avoid the NULL pointer
> dereference (very small window already).

Fine with me. Just let's remember that it should be revisited in 2.5.
What about filemap_swapout()? If you agree with checking ->mapping
there... looks like we are done with that crap for the time being.
If it's OK with you I'll send such patch against vanilla -pre7.
							Cheers,
								Al

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
