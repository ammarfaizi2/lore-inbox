Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263018AbTJaFHK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 00:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263024AbTJaFHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 00:07:10 -0500
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:8840 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S263018AbTJaFHE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 00:07:04 -0500
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="Big5"
MIME-Version: 1.0
X-Mailer: MIME::Lite 1.2  (F2.71; T1.001; A1.51; B2.12; Q2.03)
From: "CN" <cnliou9@fastmail.fm>
To: linux-kernel@vger.kernel.org
Date: Thu, 30 Oct 2003 21:04:39 -0800
X-Epoch: 1067576679
X-Sasl-enc: k8AMlAd9gRHTGCg7wkCTOw
Subject: Re: kernel: i8253 counting too high! resetting..
References: <20031029075010.596C57A6C6@smtp.us2.messagingengine.com> <20031030171235.GA59683@teraz.cwru.edu>
In-Reply-To: <20031030171235.GA59683@teraz.cwru.edu>
Message-Id: <20031031050439.E03B17E2B8@smtp.us2.messagingengine.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you a lot!

> > entries in syslog from kernel 2.4.22 upgraded from Debian woody (gcc
> > 2.95.4) running on AMD K6II 450MHz with 64MB RAM. I don't have such
> > problem in kernel 2.4.20 upgraded from Slackware (gcc 2.95.3) running on
> > another box with the identical CPU and main board (but with 192MB RAM).
> > Does this message hurt anything?
> 
> Can you please provide additional details about your hardware?
> What kind of main board are you using, and what southbridge?

Now I found that the two boards are slightly different. The printings on
the biggest 2 chips on the problematic board are:

ALi
M1542 A1
100MHz
9949 TS05

ALi
M1543C B1
9947 TM07

respectively. While the board having no i8253 messages has the chips:

ALi
M1542 A1
100MHz
9937 TS05

ALi
M1543C B1
0002 TM05

> What is the reported latency of your IDE interface?

Sorry! I don't quite understand the meanings! I am trying to report all I
know about. dmesg on the problematic box shows:

Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
hda: FUJITSU MPE3064AT, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: attached ide-disk driver.
hda: 12672450 sectors (6488 MB) w/512KiB Cache, CHS=13410/15/63
Partition check:
 hda: [PTBL] [788/255/63] hda1

One thing I want to mention here is that this disk supports 66MHz DMA
access according to Fjuitsu's whitepaper. OTOH, the board running kernel
2.4.20 reports:

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
ALI15X3: IDE controller on PCI bus 00 dev 78
PCI: Assigned IRQ 10 for device 00:0f.0
ALI15X3: chipset revision 194
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 91021U2, ATA DISK drive
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
hdc: Maxtor 91021U2, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
blk: queue c02c60a4, I/O limit 4095Mb (mask 0xffffffff)
hda: 20010816 sectors (10246 MB) w/512KiB Cache, CHS=1245/255/63,
UDMA(66)
blk: queue c02c6408, I/O limit 4095Mb (mask 0xffffffff)
hdc: 20010816 sectors (10246 MB) w/512KiB Cache, CHS=19852/16/63,
UDMA(66)
Partition check:
 hda: hda1
 hdc: [PTBL] [1245/255/63] hdc1

which looks to me that it supports DMA 66 as expected. I set the bios' of
these 2 boxes to the same parameters related to IDE in menu "Integrated
Peripherals".

Best Regards,

CN

-- 
http://www.fastmail.fm - And now for something completely different…
