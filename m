Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132537AbRDUJJE>; Sat, 21 Apr 2001 05:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132539AbRDUJIz>; Sat, 21 Apr 2001 05:08:55 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:43529 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S132537AbRDUJIp>; Sat, 21 Apr 2001 05:08:45 -0400
Date: Sat, 21 Apr 2001 11:08:31 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Dennis <dennis@etinc.com>, Matti Aarnio <matti.aarnio@zmailer.org>,
        linux-kernel@vger.kernel.org
Subject: Re: SMP in 2.4
In-Reply-To: <E14ql4I-0002Yh-00@the-village.bc.nu>
Message-ID: <Pine.LNX.3.96.1010421110704.25023A-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 	testb %al, intr_pending
> > 	jnz somewhere_away_to_handle_defered_interrupt
> > 
> > And - of course - interrupt checks intr_lock in its entry and if it is
> > zero, sets intr_pending and exits immediatelly.
> 
> And immediately gets called again. You have to mask the irq which is non trivial
> especially if you want to do it right on the BX. But you can do this and rtlinux
> does

There is already desc->handler->ack(irq) in do_IRQ which does that. Is any
more special handling needed? 

Mikulas

