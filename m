Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287629AbSALW6u>; Sat, 12 Jan 2002 17:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287632AbSALW6k>; Sat, 12 Jan 2002 17:58:40 -0500
Received: from zero.tech9.net ([209.61.188.187]:59664 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S287630AbSALW6a>;
	Sat, 12 Jan 2002 17:58:30 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
From: Robert Love <rml@tech9.net>
To: Kenneth Johansson <ken@canit.se>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, arjan@fenrus.demon.nl,
        Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org
In-Reply-To: <3C409E3C.A4968CE@canit.se>
In-Reply-To: <E16PURC-000321-00@the-village.bc.nu> 
	<3C409E3C.A4968CE@canit.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.18.08.57 (Preview Release)
Date: 12 Jan 2002 18:01:10 -0500
Message-Id: <1010876470.3560.0.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-01-12 at 15:36, Kenneth Johansson wrote:

> > I must have missed that in the code. I can see you check __cli() status but
> > I didn't see anywhere you check disable_irq(). Even if you did it doesnt
> > help when I mask the irq on the chip rather than using disable_irq() calls.
> >
> > Alan
> 
> But you get interrupted by other interrups then so you have the same problem
> reagardless of any preemtion patch you hopefully lose the cpu for a much
> shorter time but still the same problem.

Agreed.  Further, you can't put _any_ upper bound on the number of
interrupts that could occur, preempt or not.  Sure, preempt can make it
worse, but I don't see it.  I have no bug reports to correlate.

	Robert Love

