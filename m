Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315468AbSEUTcK>; Tue, 21 May 2002 15:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315471AbSEUTcJ>; Tue, 21 May 2002 15:32:09 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:45575 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315468AbSEUTcI>; Tue, 21 May 2002 15:32:08 -0400
Subject: Re: cardbus/pcmcia/pci bridge problems?
To: pbd@op.net (Paul Davis)
Date: Tue, 21 May 2002 20:52:16 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <200205211628.g4LGSZb24258@post2.fast.net> from "Paul Davis" at May 21, 2002 12:30:22 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17AFg8-00004x-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >The $PIR table in the BIOS provided no useful information on what IRQ
> >to use, or we didn't know the IRQ router concerned to set it up.
> 
> alan: let me check what you're saying: despite the fact that lspci -vv
> shows the relevant information, there is still a problem? 
> 
> the problem is either in the BIOS or its an issue with the kernel not
> knowing which IRQ router to use when setting up the interrupt? sorry
> to be repetitive, but i'm just trying to check that i fully understand
> this.

There are two stages to IRQ routing

1.	Knowing how INTA/B/C/D on the slot are wired to the INTA-D lines
	on the PCI bus (its not 1-1)
2.	Knowing how to drive the PCI irq routing hardware to route a
	line to an ISA IRQ or to work out which it already goes to

