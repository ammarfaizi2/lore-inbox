Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129610AbRBLCD4>; Sun, 11 Feb 2001 21:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130007AbRBLCDr>; Sun, 11 Feb 2001 21:03:47 -0500
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:20524 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S129610AbRBLCDh>; Sun, 11 Feb 2001 21:03:37 -0500
Date: Thu, 8 Feb 2001 09:38:54 +0100
From: Christian Ullrich <chris@chrullrich.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.1: Abnormal interrupt from RTL8139
Message-ID: <20010208093854.A1122@christian.chrullrich.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.13i
X-M$-Free-System: since 1999-11-28
X-Current-Uptime: 2 d, 13:35:14 h
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting some of these messages in syslog:

Feb  6 07:38:35 christian kernel: eth0: Abnormal interrupt, status 00000010.
Feb  6 07:38:35 christian kernel: eth0: Abnormal interrupt, status 00000010.
Feb  6 07:38:35 christian kernel: eth0: Abnormal interrupt, status 00000020.
Feb  7 17:32:53 christian kernel: eth0: Abnormal interrupt, status 00000041.
Feb  7 17:55:22 christian kernel: eth0: Abnormal interrupt, status 00000041.
Feb  7 17:59:04 christian kernel: eth0: Abnormal interrupt, status 00000040.
Feb  7 19:39:47 christian kernel: eth0: Abnormal interrupt, status 00000010.
Feb  7 19:39:47 christian kernel: eth0: Abnormal interrupt, status 00000010.

Kernel is 2.4.1, eth0 is an rtl8139. 
MB is an ABIT KT7, with VIA chipset.

I have not observed any effects related to these messages.

I'm including the output of Linus's dump_pirq script, if it is of any use:

Interrupt routing table found at address 0xfddd0:
  Version 1.0, size 0x00b0
  Interrupt router is device 00:07.0
  PCI exclusive interrupt mask: 0x8e00 [9,10,11,15]
  Compatible router: vendor 0x1106 device 0x0596

Device 00:11.0 (slot 1): 
  INTA: link 0x01, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTB: link 0x02, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTC: link 0x03, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTD: link 0x05, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]

Device 00:0f.0 (slot 2): 
  INTA: link 0x02, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTB: link 0x05, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTC: link 0x03, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTD: link 0x01, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]

Device 00:0d.0 (slot 3): SCSI storage controller
  INTA: link 0x02, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTB: link 0x01, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTC: link 0x05, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTD: link 0x03, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]

Device 00:0b.0 (slot 4): Multimedia audio controller
  INTA: link 0x05, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTB: link 0x01, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTC: link 0x02, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTD: link 0x03, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]

Device 00:09.0 (slot 5): Ethernet controller
  INTA: link 0x03, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTB: link 0x05, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTC: link 0x01, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTD: link 0x02, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]

Device 00:08.0 (slot 6): 
  INTA: link 0x05, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTB: link 0x02, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTC: link 0x01, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTD: link 0x02, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]

Device 00:13.0 (slot 7): 
  INTA: link 0x03, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTB: link 0x03, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTC: link 0x01, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTD: link 0x02, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]

Device 00:01.0 (slot 0): PCI bridge
  INTA: link 0x01, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTB: link 0x02, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTC: link 0x03, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTD: link 0x05, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]

Device 00:07.0 (slot 0): ISA bridge
  INTC: link 0x03, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTD: link 0x05, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]

Interrupt router at 00:07.0: VIA 82C686 PCI-to-ISA bridge
  PIRQA (link 0x01): irq 10
  PIRQB (link 0x02): irq 15
  PIRQC (link 0x03): irq 11
  PIRQD (link 0x05): irq 9

-- 
Christian Ullrich		     Registrierter Linux-User #125183

"Sie können nach R'ed'mond fliegen -- aber Sie werden sterben"
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
