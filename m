Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287386AbSALUBD>; Sat, 12 Jan 2002 15:01:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287388AbSALUAy>; Sat, 12 Jan 2002 15:00:54 -0500
Received: from zero.tech9.net ([209.61.188.187]:47120 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S287386AbSALUAp>;
	Sat, 12 Jan 2002 15:00:45 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
From: Robert Love <rml@tech9.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: arjan@fenrus.demon.nl, Rob Landley <landley@trommello.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <E16PURC-000321-00@the-village.bc.nu>
In-Reply-To: <E16PURC-000321-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.18.08.57 (Preview Release)
Date: 12 Jan 2002 15:03:29 -0500
Message-Id: <1010865810.2152.41.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-01-12 at 15:07, Alan Cox wrote:

> > We don't preempt while IRQ are disabled.
> 
> I must have missed that in the code. I can see you check __cli() status but
> I didn't see anywhere you check disable_irq(). Even if you did it doesnt
> help when I mask the irq on the chip rather than using disable_irq() calls.

Well, if IRQs are disabled we won't have the timer... would not the
system panic anyhow if schedule() was called while in an interrupt
handler?

	Robert Love

