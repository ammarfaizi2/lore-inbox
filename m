Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277512AbRJETCl>; Fri, 5 Oct 2001 15:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277550AbRJETCb>; Fri, 5 Oct 2001 15:02:31 -0400
Received: from smtp7.xs4all.nl ([194.109.127.133]:11222 "EHLO smtp7.xs4all.nl")
	by vger.kernel.org with ESMTP id <S277512AbRJETCY>;
	Fri, 5 Oct 2001 15:02:24 -0400
From: thunder7@xs4all.nl
Date: Fri, 5 Oct 2001 20:59:09 +0200
To: linux-kernel@vger.kernel.org
Subject: can I use an udma-pci card on an alpha?
Message-ID: <20011005205909.A6286@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had a spare CMD646 udma-card lying around, and put it in my alpha
(PWS500au). Everything boots fine, but there seems to be no HD
recognized:

block: queued sectors max/low 39013kB/13004kB, 128 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
CMD646: IDE controller on PCI bus 00 dev 20
CMD646: chipset revision 1
CMD646: not 100% native mode: will probe irqs later
CMD646: chipset revision 0x01, MultiWord DMA Limited, IRQ workaround enabled
    ide0: BM-DMA at 0x8080-0x8087, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x8088-0x808f, BIOS settings: hdc:pio, hdd:pio
Floppy drive(s): fd0 is 2.88M

jurriaan@alpha:~$ cat /proc/ide/cmd64x

                                CMD646 Chipset.
--------------- Primary Channel ---------------- Secondary Channel -------------
                 enabled                          enabled
--------------- drive0 --------- drive1 -------- drive0 ---------- drive1 ------
DMA enabled:    no               no              no                no
DMA Mode:        PIO(?)           PIO(?)          PIO(?)            PIO(?)
PIO Mode:       ?                ?               ?                 ?
                polling                          polling
                clear                            clear
                enabled                          enabled
CFR       = 0x00, HI = 0x00, LOW = 0x00
ARTTIM23  = 0x4c, HI = 0x04, LOW = 0x0c
MRDMODE   = 0x00, HI = 0x00, LOW = 0x00

Is the bios (which is x86) strictly necessary to set up the drives? I
tried searching the web for 'udma on alpha' etc. but found nothing.

Thanks,
Jurriaan
