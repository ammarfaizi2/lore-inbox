Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129627AbRAOTOB>; Mon, 15 Jan 2001 14:14:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129953AbRAOTNu>; Mon, 15 Jan 2001 14:13:50 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:4365 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129627AbRAOTNp>; Mon, 15 Jan 2001 14:13:45 -0500
Date: Mon, 15 Jan 2001 11:11:59 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Robert Kaiser <rob@sysgo.de>
cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
        mo6 <sjoos@pandora.be>, Brian Gerst <bgerst@didntduck.org>,
        Miles Lane <miles@megapathdsl.net>,
        Paul Gortmaker <p_gortmaker@yahoo.com>,
        "Tom G. Christensen" <tom.christensen@get2net.dk>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [SOLVED + PATCH] Re: Anybody got 2.4.0 running on a 386 ?
In-Reply-To: <01011520014201.12336@rob>
Message-ID: <Pine.LNX.4.10.10101151108430.6247-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 15 Jan 2001, Robert Kaiser wrote:
> 
> I finally found the reason why 386es have trouble booting the 2.4.0 kernel:

Good job.

> Pentiums are only lucky to not crash because they have a bigger TLB than 386s.

Actually, with the 4M pages, it's not a question of luck any more - they
just don't _have_ this bug, because on a machine with 4M pages the
"cpu_has_pse" case handles this all and the buggy code is never actually
entered.

Which explains why you'd only see this on a 386 (and I suspect your TLB
size explanation is what saved some i486-class machines, although later
i486 machines will have PSE as well).

	Thanks,

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
