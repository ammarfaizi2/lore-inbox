Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132313AbRDULli>; Sat, 21 Apr 2001 07:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132562AbRDULl1>; Sat, 21 Apr 2001 07:41:27 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:5389 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S132313AbRDULlP>; Sat, 21 Apr 2001 07:41:15 -0400
Date: Sat, 21 Apr 2001 13:41:00 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Dennis <dennis@etinc.com>, Matti Aarnio <matti.aarnio@zmailer.org>,
        linux-kernel@vger.kernel.org
Subject: Re: SMP in 2.4
In-Reply-To: <E14qu25-0003M3-00@the-village.bc.nu>
Message-ID: <Pine.LNX.3.96.1010421132836.31125A-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 21 Apr 2001, Alan Cox wrote:

> > > especially if you want to do it right on the BX. But you can do this and rtlinux
> > > does
> > 
> > There is already desc->handler->ack(irq) in do_IRQ which does that. Is any
> > more special handling needed? 
> 
> You need to keep the IRQ line masked not just ack it.

desc->handler->ack could be mask_and_ack_8259A, ack_edge_ioapic_irq,
mask_and_ack_level_ioapic_irq or ack_lapic_irq - it does exactly that -
masking and acking an interrupt. 

> The code for handling all
> the BX and other cases is there but its a bit more than 3 clock cycles long

What magic does it have to do? Where is it in kernel?

Mikulas

