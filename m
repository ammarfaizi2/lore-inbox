Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129147AbQKQUat>; Fri, 17 Nov 2000 15:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129651AbQKQUak>; Fri, 17 Nov 2000 15:30:40 -0500
Received: from smtp-fwd.valinux.com ([198.186.202.196]:58885 "EHLO
	mail.valinux.com") by vger.kernel.org with ESMTP id <S129147AbQKQUaZ>;
	Fri, 17 Nov 2000 15:30:25 -0500
Date: Fri, 17 Nov 2000 12:01:20 -0800
From: David Hinds <dhinds@valinux.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Russell King <rmk@arm.linux.org.uk>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, tytso@valinux.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcmcia event thread. (fwd)
Message-ID: <20001117120120.M7939@valinux.com>
In-Reply-To: <3A155F6A.28783D4A@mandrakesoft.com> <Pine.LNX.4.10.10011170843050.2272-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.6i
In-Reply-To: <Pine.LNX.4.10.10011170843050.2272-100000@penguin.transmeta.com>; from Linus Torvalds on Fri, Nov 17, 2000 at 08:47:44AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 2. Even when I specify cs_irq=27, it resorts to polling:
> 
>         Intel PCIC probe:
>           Intel i82365sl DF ISA-to-PCMCIA at port 0x8400 ofs 0x00, 2 sockets
>             host opts [0]: none
>             host opts [1]: none
>             ISA irqs (default) = none! polling interval = 1000 ms

The driver means it when it says "ISA irqs".  A value of 27 is not
valid for cs_irq because this is an ISA irq number and must be 0..15;
this is not a property of the host system, this is a property of the
i82365 register specification.  PCI interrupts have to be handled
differently (well, the stripped-down i82365 driver just can't handle
them at all)

-- Dave
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
