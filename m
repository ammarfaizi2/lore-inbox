Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287895AbSAMBP3>; Sat, 12 Jan 2002 20:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287896AbSAMBPU>; Sat, 12 Jan 2002 20:15:20 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:6404 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287895AbSAMBPL>; Sat, 12 Jan 2002 20:15:11 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
To: zippel@linux-m68k.org (Roman Zippel)
Date: Sun, 13 Jan 2002 01:26:50 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), arjan@fenrus.demon.nl,
        landley@trommello.org (Rob Landley), linux-kernel@vger.kernel.org
In-Reply-To: <3C40A255.EBE646@linux-m68k.org> from "Roman Zippel" at Jan 12, 2002 09:53:41 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16PZQA-0003fl-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > everywhere will just trash performance. They are pure hardware interactions
> > so you can't automatically detect them.
> 
> Why should spin locks trash perfomance, while an expensive disable_irq()
> doesn't?

disable_irq only blocks _one_ interrupt line, spin_lock_irqsave locks the
interrupt off on a uniprocessor, and  50% of the time off on a
dual processor. 

If I use a spin lock you can't run a modem and an NE2000 card together on
Linux 2.4. Thats why I had to do that work on the code. Its one of myriads
of basic obvious cases that the pre-empt patch gets wrong

