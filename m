Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132444AbRALUw1>; Fri, 12 Jan 2001 15:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132559AbRALUwR>; Fri, 12 Jan 2001 15:52:17 -0500
Received: from chiara.elte.hu ([157.181.150.200]:59406 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S132444AbRALUv7>;
	Fri, 12 Jan 2001 15:51:59 -0500
Date: Fri, 12 Jan 2001 21:51:36 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Frank de Lange <frank@unternet.org>
Cc: Manfred Spraul <manfred@colorfullife.com>,
        Linus Torvalds <torvalds@transmeta.com>, <dwmw2@infradead.org>,
        <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardwarerelated?
In-Reply-To: <20010112214642.A27809@unternet.org>
Message-ID: <Pine.LNX.4.30.0101122150260.3128-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 12 Jan 2001, Frank de Lange wrote:

> PATCHED 8390.c (using irq_safe spinlocks instead of disable_irq)
> PATCHED apic.c (focus cpu ENABLED)
> STOCK io_apic.c
>
> No problems under heavy network load.
>
> Gentleman, this (the patch to 8390.c) seems to fix the problem.

great. Back when i had the same problem, flood pinging another host (on
the local network) was the quickest way to reproduce the hang:

	ping -f -s 10 otherhost

this produced an IOAPIC-hang within seconds.

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
