Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030477AbWGaVmB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030477AbWGaVmB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 17:42:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030476AbWGaVmB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 17:42:01 -0400
Received: from smtp.ono.com ([62.42.230.12]:59733 "EHLO resmta04.ono.com")
	by vger.kernel.org with ESMTP id S1030474AbWGaVmA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 17:42:00 -0400
Date: Mon, 31 Jul 2006 23:41:54 +0200
From: "J.A. =?UTF-8?B?TWFnYWxsw7Nu?=" <jamagallon@ono.com>
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Linux-Kernel," <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6.18-rc2-mm1] libata ate one PATA channel
Message-ID: <20060731234154.39419e64@werewolf.auna.net>
In-Reply-To: <20060731165011.GA6659@htj.dyndns.org>
References: <20060728134550.030a0eb8@werewolf.auna.net>
	<44CD0E55.4020206@gmail.com>
	<20060731172452.76a1b6bd@werewolf.auna.net>
	<44CE2908.8080502@gmail.com>
	<1154363489.7230.61.camel@localhost.localdomain>
	<20060731165011.GA6659@htj.dyndns.org>
X-Mailer: Sylpheed-Claws 2.4.0 (GTK+ 2.10.1; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Aug 2006 01:50:11 +0900, Tejun Heo <htejun@gmail.com> wrote:

> On Mon, Jul 31, 2006 at 05:31:29PM +0100, Alan Cox wrote:
> > Ar Maw, 2006-08-01 am 01:00 +0900, ysgrifennodd Tejun Heo:
> > > These are patches #110-112.  Andrew, can you drop those patches for the 
> > > time being?  I'm working on integrating those into libata #upstream now. 
> > 
> > If you drop the host_set and tuning patches please drop all the PATA
> > stuff and my other patches out. I don't have time to field a second
> > batch of hundreds of "why has my drive stopped working, why is the speed
> > wrong" emails. 
> 
> Didn't realize pata stuff relies on it.
> 
> > It'll be easier just to work outside the -mm tree with all this
> > continued in/out random breakage if people are just going to say "drop
> > xyz patch" rather than actually specifying *what is actually wrong* and
> > getting me to fix the merge (Tejun that last one sentence is a hint ;))
> 
> Okay, took the hint.  Magallon, can you please try the following
> patch?
> 

Bingo!! My drives are back again:

libata version 2.00 loaded.
ata_piix 0000:00:1f.1: version 2.00ac6
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 16
ata_piix 0000:00:1f.1: XXX: legacy_mode probe_ent=c2374800
PCI: Setting latency timer of device 0000:00:1f.1 to 64
ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14
ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xF008 irq 14
scsi0 : ata_piix
ata1.00: ATAPI, max UDMA/33
ata1.01: ATAPI, max MWDMA0, CDB intr
ata1.00: configured for UDMA/33
ata1.01: configured for PIO3
scsi1 : ata_piix
ata2.00: ATA-6, max UDMA/100, 234441648 sectors: LBA48
ata2.00: ata2: dev 0 multi count 16
ata2.01: ATAPI, max UDMA/33
ata2.00: configured for UDMA/100
ata2.01: configured for UDMA/33
  Vendor: HL-DT-ST  Model: DVDRAM GSA-4120B  Rev: A111
  Type:   CD-ROM                             ANSI SCSI revision: 05
  Vendor: IOMEGA    Model: ZIP 250           Rev: 51.G
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: ST3120022A        Rev: 3.06
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: TOSHIBA   Model: DVD-ROM SD-M1712  Rev: 1004
  Type:   CD-ROM                             ANSI SCSI revision: 05
ata_piix 0000:00:1f.2: MAP [ P0 -- P1 -- ]
ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 16
ata_piix 0000:00:1f.2: XXX: non_legacy_mode n_ports=2 probe_ent=c2374800
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata3: SATA max UDMA/133 cmd 0xC000 ctl 0xC402 bmdma 0xD000 irq 16
ata4: SATA max UDMA/133 cmd 0xC800 ctl 0xCC02 bmdma 0xD008 irq 16
scsi2 : ata_piix
ata3.00: ATA-6, max UDMA/133, 390721968 sectors: LBA48
ata3.00: ata3: dev 0 multi count 16
ata3.00: configured for UDMA/133
scsi3 : ata_piix
ata4: SATA port has no device.
ATA: abnormal status 0x7F on port 0xC807
  Vendor: ATA       Model: ST3200822AS       Rev: 3.01
  Type:   Direct-Access                      ANSI SCSI revision: 05
sata_promise 0000:03:04.0: version 1.04
ACPI: PCI Interrupt 0000:03:04.0[A] -> GSI 23 (level, low) -> IRQ 17
sata_promise PATA port found
ata5: SATA max UDMA/133 cmd 0xF8804200 ctl 0xF8804238 bmdma 0x0 irq 17
ata6: SATA max UDMA/133 cmd 0xF8804280 ctl 0xF88042B8 bmdma 0x0 irq 17
ata7: PATA max UDMA/133 cmd 0xF8804300 ctl 0xF8804338 bmdma 0x0 irq 17
scsi4 : sata_promise
ata5: SATA link down (SStatus 0 SControl 300)
scsi5 : sata_promise
ata6: SATA link down (SStatus 0 SControl 0)
scsi6 : sata_promise
ATA: abnormal status 0x7F on port 0xF880431C
ata7: disabling port

And CD burning works again at x40 on /dev/sr0 (the LG GSA-4120B drive).
Thanks a lot, and a bug less !!

--
J.A. Magallon <jamagallon()ono!com>     \               Software is like sex:
                                         \         It's better when it's free
Mandriva Linux release 2007.0 (Cooker) for i586
Linux 2.6.17-jam05 (gcc 4.1.1 20060724 (prerelease) (4.1.1-3mdk)) #3 SMP PREEMPT
