Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287342AbSALT4N>; Sat, 12 Jan 2002 14:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287386AbSALT4E>; Sat, 12 Jan 2002 14:56:04 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:19217 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287342AbSALTz7>; Sat, 12 Jan 2002 14:55:59 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
To: rml@tech9.net (Robert Love)
Date: Sat, 12 Jan 2002 20:07:34 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), arjan@fenrus.demon.nl,
        landley@trommello.org (Rob Landley), linux-kernel@vger.kernel.org
In-Reply-To: <1010863588.2007.34.camel@phantasy> from "Robert Love" at Jan 12, 2002 02:26:27 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16PURC-000321-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > PRE-EMPT:
> > 	We get back and we've missed 300 packets, the serial port sharing
> > 	the IRQ has dropped our internet connection completely.
> 
> We don't preempt while IRQ are disabled.

I must have missed that in the code. I can see you check __cli() status but
I didn't see anywhere you check disable_irq(). Even if you did it doesnt
help when I mask the irq on the chip rather than using disable_irq() calls.

Alan
