Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130018AbQKLDYN>; Sat, 11 Nov 2000 22:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130021AbQKLDYD>; Sat, 11 Nov 2000 22:24:03 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:14077 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130018AbQKLDXu>;
	Sat, 11 Nov 2000 22:23:50 -0500
Date: Sat, 11 Nov 2000 22:23:48 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] show_task() and thread_saved_pc() fix for x86
In-Reply-To: <Pine.GSO.4.21.0011112207230.24250-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0011112220010.24250-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 11 Nov 2000, Alexander Viro wrote:

> I would probably turn it into
> 	unsigned long *ebp = *((unsigned long **)t->esp);

	ebp++;	/* We want return address, not the previous frame pointer */

> 	/* Bits 0,1 and 13..31 must be shared with the stack base */
> 	if (((unsigned long)ebp ^ (unsigned long)t) & ~(2*PAGE_SIZE-4))
> 		return 0;
> 
> 	return *ebp;

Sorry.
								Cheers,
									Al

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
