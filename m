Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129525AbQJ1TcR>; Sat, 28 Oct 2000 15:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129654AbQJ1TcI>; Sat, 28 Oct 2000 15:32:08 -0400
Received: from janus.hosting4u.net ([209.15.2.37]:3603 "HELO
	janus.hosting4u.net") by vger.kernel.org with SMTP
	id <S129525AbQJ1Tbz>; Sat, 28 Oct 2000 15:31:55 -0400
Message-ID: <39FB2921.992E6BE8@a2zis.com>
Date: Sat, 28 Oct 2000 21:29:37 +0200
From: Remi Turk <remi@a2zis.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0-test10-pre6 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: No IRQ known for interrupt pin A of device 00:0f.0
In-Reply-To: <39FB024B.220A025C@a2zis.com> <39FB0EAB.C87F816C@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> Remi Turk wrote:
> > Uniform Multi-Platform E-IDE driver Revision: 6.31
> > ide: Assuming 33MHz system bus speed for PIO modes; override with
> > idebus=xx
> > ALI15X3: IDE controller on PCI bus 00 dev 78
> > PCI: No IRQ known for interrupt pin A of device 00:0f.0. Please try
> > using pci=biosirq.
> 
> test10-pre6 gives this warning?
> 
> Can you post the output of dump_pirq, from the pcmcia_cs package?  (if
> you don't have it already, http://pcmcia-cs.sourceforge.net/)
> 
Here it is:

Interrupt routing table found at address 0xf0b40:
  Version 1.0, size 0x00a0
  Interrupt router is device 00:07.0
  PCI exclusive interrupt mask: 0x0000 []
  Compatible router: vendor 0x10b9 device 0x1533

Device 00:0c.0 (slot 1):
  INTA: link 0x01, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]
  INTB: link 0x02, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]
  INTC: link 0x03, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]
  INTD: link 0x04, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]

Device 00:0b.0 (slot 2):
  INTA: link 0x02, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]
  INTB: link 0x03, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]
  INTC: link 0x04, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]
  INTD: link 0x01, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]

Device 00:0a.0 (slot 3):
  INTA: link 0x03, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]
  INTB: link 0x04, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]
  INTC: link 0x01, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]
  INTD: link 0x02, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]

Device 00:09.0 (slot 4): Multimedia audio controller
  INTA: link 0x04, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]
  INTB: link 0x01, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]
  INTC: link 0x02, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]
  INTD: link 0x03, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]

Device 00:0d.0 (slot 5):
  INTA: link 0x04, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]
  INTB: link 0x01, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]
  INTC: link 0x02, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]
  INTD: link 0x03, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]

Device 00:02.0 (slot 0): USB Controller
  INTA: link 0x59, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]

Device 00:01.0 (slot 0): PCI bridge
  INTA: link 0x01, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]
  INTB: link 0x02, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]
  INTC: link 0x03, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]
  INTD: link 0x04, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]

Device 00:06.0 (slot 0):
  INTA: link 0x03, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]
  INTB: link 0x04, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]
  INTC: link 0x01, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]
  INTD: link 0x02, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]

Interrupt router at 00:07.0: AcerLabs Aladdin M1533 PCI-to-ISA bridge
  INT1 (link 1): irq 11
  INT2 (link 2): unrouted
  INT3 (link 3): irq 5
  INT4 (link 4): irq 10
  INT5 (link 5): unrouted
  INT6 (link 6): unrouted
  INT7 (link 7): unrouted
  INT8 (link 8): unrouted
  Serial IRQ: [disabled] [quiet] [frame=21] [pulse=12]


-- 
Linux 2.4.0-test10-pre6 #1 Sat Oct 28 14:15:54 CEST 2000
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
