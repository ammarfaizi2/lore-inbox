Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129069AbQKPSiN>; Thu, 16 Nov 2000 13:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129091AbQKPSiE>; Thu, 16 Nov 2000 13:38:04 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:64783 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129069AbQKPShn>; Thu, 16 Nov 2000 13:37:43 -0500
Date: Thu, 16 Nov 2000 10:07:11 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: schwidefsky@de.ibm.com, mingo@chiara.elte.hu, linux-kernel@vger.kernel.org
Subject: Re: Memory management bug
In-Reply-To: <20001116184512.A6622@athlon.random>
Message-ID: <Pine.LNX.4.10.10011161000330.2513-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 16 Nov 2000, Andrea Arcangeli wrote:
> 
> If they absolutely needs 4 pages for pmd pagetables due hardware constraints
> I'd recommend to use _four_ hardware pages for each softpage, not two.

Yes.

However, it definitely is an issue of making trade-offs. Most 64-bit MMU
models tend to have some flexibility in how you set up the page tables,
and it may be possible to just move bits around too (ie making both the
pmd and the pgd twice as large, and getting the expansion of 4 by doing
two expand-by-two's, for example, if the hardware has support for doing
things like that).

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
