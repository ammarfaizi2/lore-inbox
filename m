Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131487AbRALURR>; Fri, 12 Jan 2001 15:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132439AbRALURH>; Fri, 12 Jan 2001 15:17:07 -0500
Received: from e56090.upc-e.chello.nl ([213.93.56.90]:47626 "EHLO unternet.org")
	by vger.kernel.org with ESMTP id <S131487AbRALUQz>;
	Fri, 12 Jan 2001 15:16:55 -0500
Date: Fri, 12 Jan 2001 21:16:38 +0100
From: Frank de Lange <frank@unternet.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, mingo@elte.hu,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardwarerelated?
Message-ID: <20010112211638.C26555@unternet.org>
In-Reply-To: <Pine.LNX.4.10.10101121158050.3010-100000@penguin.transmeta.com> <3A5F64F1.2C4ADDBA@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A5F64F1.2C4ADDBA@colorfullife.com>; from manfred@colorfullife.com on Fri, Jan 12, 2001 at 09:11:29PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2001 at 09:11:29PM +0100, Manfred Spraul wrote:
> Frank, please clarify:
> you still run without disable_irq_nosync() in 8390.c?

I am running with your patched version of 8390.c (so WITHOUT
disable_irq_nosync()).

In addition, I patched apic.c (focus cpu enabled)
In addition, I patched io_apic ((TARGET_CPUS 0xff)

> I have a first idea: we send an EOI to an interrupt that is masked on
> the IO apic, perhaps that causes the problems.

Sound plausible...

> I'm right now typing a patch.

I'll await yours instead of making my own patch this time... :-)

Cheers//Frank
-- 
  WWWWW      _______________________
 ## o o\    /     Frank de Lange     \
 }#   \|   /                          \
  ##---# _/     <Hacker for Hire>      \
   ####   \      +31-320-252965        /
           \    frank@unternet.org    /
            -------------------------
 [ "Omnis enim res, quae dando non deficit, dum habetur
    et non datur, nondum habetur, quomodo habenda est."  ]
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
