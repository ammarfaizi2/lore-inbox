Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135819AbRAMCEr>; Fri, 12 Jan 2001 21:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135975AbRAMCEh>; Fri, 12 Jan 2001 21:04:37 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:60597 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S135799AbRAMCE2>; Fri, 12 Jan 2001 21:04:28 -0500
Message-ID: <3A5FB925.1CE6B229@uow.edu.au>
Date: Sat, 13 Jan 2001 13:10:45 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Manfred Spraul <manfred@colorfullife.com>,
        Frank de Lange <frank@unternet.org>, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, mingo@elte.hu, torvalds@transmeta.com,
        Donald Becker <becker@scyld.com>
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardware
In-Reply-To: <3A5F5BFB.69134DB9@colorfullife.com> from "Manfred Spraul" at Jan 12, 2001 08:33:15 PM <E14HDjY-0005Ei-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > Could you disable both bandaids? I disabled them, no problems so far.
> > Now back to the disable_irq_nosync().
> 
> Ok so it looks like the disable_irq code is buggy. Unfortunately its not
> just used for these drivers they are just the heaviest users.
> 
> Given that we can see the IRQ is still set on the APIC can we fake an IRQ in
> that condition ?

As you think about this problem, please bear in mind that
this loss of APIC interrupts also occurs in 2.2 kernels.

Donald may have more details.

-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
