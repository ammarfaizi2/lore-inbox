Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131876AbRALUUr>; Fri, 12 Jan 2001 15:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131884AbRALUU1>; Fri, 12 Jan 2001 15:20:27 -0500
Received: from chiara.elte.hu ([157.181.150.200]:52494 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S131876AbRALUUU>;
	Fri, 12 Jan 2001 15:20:20 -0500
Date: Fri, 12 Jan 2001 21:19:53 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Frank de Lange <frank@unternet.org>
Cc: Manfred Spraul <manfred@colorfullife.com>,
        Linus Torvalds <torvalds@transmeta.com>, <dwmw2@infradead.org>,
        <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardwarerelated?
In-Reply-To: <20010112211638.C26555@unternet.org>
Message-ID: <Pine.LNX.4.30.0101122117540.2772-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 12 Jan 2001, Frank de Lange wrote:

> In addition, I patched apic.c (focus cpu enabled)
> In addition, I patched io_apic ((TARGET_CPUS 0xff)

please try it with the focus CPU enabling change (we want to enable that
feature, i only disabled it due to the stuck-ne2k bug), but with
TARGET_CPUS set to cpu_online_mask. (this later is needed for certain
crappy BIOSes.)

i believe the ne2k driver change is the key.

> > I have a first idea: we send an EOI to an interrupt that is masked on
> > the IO apic, perhaps that causes the problems.
>
> Sound plausible...

does not help. I've tried it (and many other combinations). I did not find
any direct workaround for this problem. (i tried very hard.)

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
