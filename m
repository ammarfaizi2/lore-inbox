Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132586AbRALUBE>; Fri, 12 Jan 2001 15:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132660AbRALUAy>; Fri, 12 Jan 2001 15:00:54 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:43269 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132586AbRALUAq>; Fri, 12 Jan 2001 15:00:46 -0500
Date: Fri, 12 Jan 2001 11:59:25 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Frank de Lange <frank@unternet.org>
cc: Manfred Spraul <manfred@colorfullife.com>, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, mingo@elte.hu,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardware
 related?
In-Reply-To: <20010112205245.A26555@unternet.org>
Message-ID: <Pine.LNX.4.10.10101121158050.3010-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 12 Jan 2001, Frank de Lange wrote:

> On Fri, Jan 12, 2001 at 08:33:15PM +0100, Manfred Spraul wrote:
> > Frank, the 2.4.0 contains 2 band aids that were added for ne2k smp:
> > 
> > * From Ingo: focus cpu disabled, in arch/i386/kernel/apic.c
> > * From myself: TARGET_CPU = cpu_online_mask, was 0xFF.
> > 
> > Could you disable both bandaids? I disabled them, no problems so far.
> 
> I disabled both (I guess you meant the 'define TARGET_CPUS cpu_online' in
> io_apic.c?), and reverted my own patch, added your patch... Now running with
> the usual heavy network load, no problems so far... Also made USB produce
> interrupts (shares irq with network), no problems...
> 
> Could this really be the solution?

I'd like to know _which_ of the two makes a difference (or does it only
trigger with both of them enabled)? And even then I'm not sure that it is
"the" solution - both changes to io-apic handling had some reason for
them. Ingo, what was the focus-cpu thing?

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
