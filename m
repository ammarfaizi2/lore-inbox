Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129318AbQKLCav>; Sat, 11 Nov 2000 21:30:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129407AbQKLCal>; Sat, 11 Nov 2000 21:30:41 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:43023 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129318AbQKLCaV>; Sat, 11 Nov 2000 21:30:21 -0500
Date: Sat, 11 Nov 2000 18:30:07 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ying Chen/Almaden/IBM <ying@almaden.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] wakeup_bdflush related fixes and nfsd optimizations for
 test10
In-Reply-To: <OF36001054.FDE8E20E-ON88256994.00619404@LocalDomain>
Message-ID: <Pine.LNX.4.10.10011111827490.3611-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 11 Nov 2000, Ying Chen/Almaden/IBM wrote:
> 
> This patch includes two sets of things against test10:
> First, there are several places where schedule() is called after
> wakeup_bdflush(1) is called. This is completely unnecessary

Fair enough.

> Second, (I have posted this to the kernel mailing list, but I forgot to cc
> to Linus.) I made some optimizations on racache in nfsd in test10.

..but this would need a lot more testing/feedback, especially from the nfs
client maintainers (I see that Neil Brown did some querying already, I
think more is in order). 

Also, I'd _really_ like those lists to be real <linux/list.h> lists
instead of duplicating code.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
