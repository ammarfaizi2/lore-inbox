Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129811AbRALStp>; Fri, 12 Jan 2001 13:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130072AbRALStf>; Fri, 12 Jan 2001 13:49:35 -0500
Received: from chiara.elte.hu ([157.181.150.200]:45582 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S129811AbRALStQ>;
	Fri, 12 Jan 2001 13:49:16 -0500
Date: Fri, 12 Jan 2001 19:48:52 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <dwmw2@infradead.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>, <frank@unternet.org>
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardware
In-Reply-To: <3A5F50B0.ACD5ADB1@colorfullife.com>
Message-ID: <Pine.LNX.4.30.0101121946120.1810-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 12 Jan 2001, Manfred Spraul wrote:

> 2.4 spreads the vectors for the external (hardware, from io apic)
> interrupts, but 5 ipi vectors have the same priority: reschedule, call
> function, tlb invalidate, apic error, spurious interrupt.

my reading of the errata is that the lost APIC timer IRQ happens only if
the APIC timer IRQ vector's priority level has more than 2 active vectors.
It's a very limited case, which does not happen in recent CPUs anyway
(such as the PIII).

> But that doesn't explain what happens with ne2k cards: neither 2.2 nor
> 2.4 have more than 2 interrupts in class for the hardware interrupt
> 16/19.

yep.

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
