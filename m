Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287388AbSALUO5>; Sat, 12 Jan 2002 15:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287401AbSALUOq>; Sat, 12 Jan 2002 15:14:46 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:29201 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287388AbSALUOd>; Sat, 12 Jan 2002 15:14:33 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
To: rml@tech9.net (Robert Love)
Date: Sat, 12 Jan 2002 20:21:13 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), arjan@fenrus.demon.nl,
        landley@trommello.org (Rob Landley), linux-kernel@vger.kernel.org
In-Reply-To: <1010865810.2152.41.camel@phantasy> from "Robert Love" at Jan 12, 2002 03:03:29 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16PUeP-00034K-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I didn't see anywhere you check disable_irq(). Even if you did it doesnt
> > help when I mask the irq on the chip rather than using disable_irq() calls.
> 
> Well, if IRQs are disabled we won't have the timer... would not the
> system panic anyhow if schedule() was called while in an interrupt
> handler?

You completely misunderstand.

	disable_irq(n)

I disable a single specific interrupt, I don't disable the timer interrupt.
Your code doesn't seem to handle that. Its just one of the examples of where
you really need priority handling, and thats a horrible dark and slippery
slope

Alan
