Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S145153AbRA2EaX>; Sun, 28 Jan 2001 23:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S145160AbRA2EaO>; Sun, 28 Jan 2001 23:30:14 -0500
Received: from mailgate.rz.uni-karlsruhe.de ([129.13.64.97]:25101 "EHLO
	mailgate.rz.uni-karlsruhe.de") by vger.kernel.org with ESMTP
	id <S145153AbRA2E36>; Sun, 28 Jan 2001 23:29:58 -0500
To: torvalds@transmeta.com, jgarzik@mandrakesoft.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI IRQ routing problem in 2.4.0
From: Robert Siemer <Robert.Siemer@gmx.de>
In-Reply-To: <200101290323.TAA05252@penguin.transmeta.com>
In-Reply-To: <20010128215812H.siemer@panorama.hadiko.de>
	<200101290323.TAA05252@penguin.transmeta.com>
X-Mailer: Mew version 1.94b25 on Emacs 20.5 / Mule 4.0 (HANANOEN)
Reply-To: Robert Siemer <siemer@panorama.hadiko.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20010129052950H.siemer@panorama.hadiko.de>
Date: Mon, 29 Jan 2001 05:29:50 +0100
X-Dispatcher: imput version 990425(IM115)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@transmeta.com>

> Another one..

> Robert, can you get the dump_pirq script from the pcmcia_cs package
> and send the output to us?

...it seems to reflect my settings in the bios:


Interrupt routing table found at address 0xf0a50:
  Version 1.0, size 0x0080
  Interrupt router is device 00:01.0
  PCI exclusive interrupt mask: 0x0000 []
  Compatible router: vendor 0x1039 device 0x0008

Device 00:0c.0 (slot 1): SCSI storage controller
  INTA: link 0x01, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]
  INTB: link 0x02, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]
  INTC: link 0x03, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]
  INTD: link 0x04, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]

Device 00:0b.0 (slot 2): VGA compatible controller
  INTA: link 0x02, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]
  INTB: link 0x03, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]
  INTC: link 0x04, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]
  INTD: link 0x01, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]

Device 00:0a.0 (slot 3): Ethernet controller
  INTA: link 0x03, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]
  INTB: link 0x04, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]
  INTC: link 0x01, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]
  INTD: link 0x02, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]

Device 00:09.0 (slot 4): Multimedia video controller
  INTA: link 0x04, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]
  INTB: link 0x01, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]
  INTC: link 0x02, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]
  INTD: link 0x03, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]

Device 00:01.0 (slot 0): ISA bridge
  INTA: link 0x01, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]
  INTB: link 0x02, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]
  INTC: link 0x03, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]
  INTD: link 0x04, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]

Device 00:13.0 (slot 0): VGA compatible controller
  INTA: link 0x01, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]
  INTB: link 0x02, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]
  INTC: link 0x03, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]
  INTD: link 0x04, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]

Interrupt router at 00:01.0: SiS 85C503 PCI-to-ISA bridge
  INTA (link 0x41): irq 12
  INTB (link 0x42): irq 14
  INTC (link 0x43): irq 10
  INTD (link 0x44): irq 11
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
