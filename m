Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287429AbSALUhD>; Sat, 12 Jan 2002 15:37:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287432AbSALUgm>; Sat, 12 Jan 2002 15:36:42 -0500
Received: from as3-1-8.ras.s.bonet.se ([217.215.75.181]:46776 "EHLO
	garbo.localnet") by vger.kernel.org with ESMTP id <S287429AbSALUgi>;
	Sat, 12 Jan 2002 15:36:38 -0500
Message-ID: <3C409E3C.A4968CE@canit.se>
Date: Sat, 12 Jan 2002 21:36:12 +0100
From: Kenneth Johansson <ken@canit.se>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Robert Love <rml@tech9.net>, arjan@fenrus.demon.nl,
        Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <E16PURC-000321-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> > > PRE-EMPT:
> > >     We get back and we've missed 300 packets, the serial port sharing
> > >     the IRQ has dropped our internet connection completely.
> >
> > We don't preempt while IRQ are disabled.
>
> I must have missed that in the code. I can see you check __cli() status but
> I didn't see anywhere you check disable_irq(). Even if you did it doesnt
> help when I mask the irq on the chip rather than using disable_irq() calls.
>
> Alan

But you get interrupted by other interrups then so you have the same problem
reagardless of any preemtion patch you hopefully lose the cpu for a much
shorter time but still the same problem.


