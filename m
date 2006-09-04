Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932124AbWIDW0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbWIDW0Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 18:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbWIDW0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 18:26:16 -0400
Received: from smtp.ono.com ([62.42.230.12]:853 "EHLO resmta03.ono.com")
	by vger.kernel.org with ESMTP id S932124AbWIDW0P convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 18:26:15 -0400
Date: Tue, 5 Sep 2006 00:26:00 +0200
From: "J.A. =?UTF-8?B?TWFnYWxsw7Nu?=" <jamagallon@ono.com>
To: Tejun Heo <htejun@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Lost DVD-RW [Was Re: 2.6.18-rc5-mm1]
Message-ID: <20060905002600.51c5e73b@werewolf.auna.net>
In-Reply-To: <44FB929B.7080405@gmail.com>
References: <20060901015818.42767813.akpm@osdl.org>
	<20060904013443.797ba40b@werewolf.auna.net>
	<20060903181226.58f9ea80.akpm@osdl.org>
	<44FB929B.7080405@gmail.com>
X-Mailer: Sylpheed-Claws 2.4.0cvs139 (GTK+ 2.10.2; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Sep 2006 04:42:35 +0200, Tejun Heo <htejun@gmail.com> wrote:

> Andrew Morton wrote:
> > On Mon, 4 Sep 2006 01:34:43 +0200
> > "J.A. Magallón" <jamagallon@ono.com> wrote:
> > 
> >> On Fri, 1 Sep 2006 01:58:18 -0700, Andrew Morton <akpm@osdl.org> wrote:
> >>
> >>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc5/2.6.18-rc5-mm1/
> >>>
> >> Err, my burner got lost this summer ;).
...
> >> dmesg for rc2-mm1:
> >> scsi0 : ata_piix
> >> ata1.00: ATAPI, max UDMA/33
> >> ata1.01: ATAPI, max MWDMA0, CDB intr
> >> ata1.00: configured for UDMA/33
> >> ata1.01: configured for PIO3
> >>   Vendor: HL-DT-ST  Model: DVDRAM GSA-4120B  Rev: A111
> >>   Type:   CD-ROM                             ANSI SCSI revision: 05
> >>   Vendor: IOMEGA    Model: ZIP 250           Rev: 51.G
> >>   Type:   Direct-Access                      ANSI SCSI revision: 05
> >>
> >> dmesg for rc5-mm1:
> >> ata1.00: failed to IDENTIFY (device reports illegal type, err_mask=0x0)
> 
> Hmmm... Strange.
> 
> The related code hasn't changed much between rc2-mm1 and rc5-mm1.  We're 
> talking about 2.6.18-rc2-mm1 and 2.6.18-rc5-mm1, right?
> 
> Can you try the attached patch and report what the kernel says?
> 
> 

Here it is:

libata version 2.00 loaded.
ata_piix 0000:00:1f.1: version 2.00ac7
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1f.1 to 64
ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14
ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xF008 irq 15
scsi0 : ata_piix
ata1.00: XXX class=3 is_ata=0 is_cfa=1
ata1.00: failed to IDENTIFY (device reports illegal type, err_mask=0x0)
ata1.01: XXX class=3 is_ata=0 is_cfa=0
ata1.01: ATAPI, max MWDMA0, CDB intr
ata1.01: XXX class=3 is_ata=0 is_cfa=0
ata1.01: configured for PIO3
scsi1 : ata_piix
ata2.00: XXX class=1 is_ata=1 is_cfa=0
ata2.00: ATA-6, max UDMA/100, 234441648 sectors: LBA48 
ata2.00: ata2: dev 0 multi count 16
ata2.01: XXX class=3 is_ata=0 is_cfa=0
ata2.01: ATAPI, max UDMA/33
ata2.00: XXX class=1 is_ata=1 is_cfa=0
ata2.00: configured for UDMA/100
ata2.01: XXX class=3 is_ata=0 is_cfa=0
ata2.01: configured for UDMA/33
scsi 0:0:1:0: Direct-Access     IOMEGA   ZIP 250          51.G PQ: 0 ANSI: 5
sd 0:0:1:0: Attached scsi removable disk sda
scsi 1:0:0:0: Direct-Access     ATA      ST3120022A       3.06 PQ: 0 ANSI: 5
SCSI device sdb: 234441648 512-byte hdwr sectors (120034 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 234441648 512-byte hdwr sectors (120034 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: sdb1
sd 1:0:0:0: Attached scsi disk sdb
scsi 1:0:1:0: CD-ROM            TOSHIBA  DVD-ROM SD-M1712 1004 PQ: 0 ANSI: 5
sr0: scsi3-mmc drive: 48x/48x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 1:0:1:0: Attached scsi CD-ROM sr0
ata_piix 0000:00:1f.2: MAP [ P0 -- P1 -- ]
ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata3: SATA max UDMA/133 cmd 0xC000 ctl 0xC402 bmdma 0xD000 irq 16
ata4: SATA max UDMA/133 cmd 0xC800 ctl 0xCC02 bmdma 0xD008 irq 16
scsi2 : ata_piix
ata3.00: XXX class=1 is_ata=1 is_cfa=0
ata3.00: ATA-6, max UDMA/133, 390721968 sectors: LBA48 
ata3.00: ata3: dev 0 multi count 16
ata3.00: XXX class=1 is_ata=1 is_cfa=0
ata3.00: configured for UDMA/133
scsi3 : ata_piix
ATA: abnormal status 0x7F on port 0xC807
scsi 2:0:0:0: Direct-Access     ATA      ST3200822AS      3.01 PQ: 0 ANSI: 5
SCSI device sdc: 390721968 512-byte hdwr sectors (200050 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
SCSI device sdc: 390721968 512-byte hdwr sectors (200050 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
 sdc: sdc1 sdc2 sdc3
sd 2:0:0:0: Attached scsi disk sdc
sata_promise 0000:03:04.0: version 1.04
ACPI: PCI Interrupt 0000:03:04.0[A] -> GSI 23 (level, low) -> IRQ 17
sata_promise PATA port found
ata5: SATA max UDMA/133 cmd 0xF8802200 ctl 0xF8802238 bmdma 0x0 irq 17
ata6: SATA max UDMA/133 cmd 0xF8802280 ctl 0xF88022B8 bmdma 0x0 irq 17
ata7: PATA max UDMA/133 cmd 0xF8802300 ctl 0xF8802338 bmdma 0x0 irq 17
scsi4 : sata_promise
ata5: SATA link down (SStatus 0 SControl 0)
scsi5 : sata_promise
ata6: SATA link down (SStatus 0 SControl 300)
scsi6 : sata_promise
ATA: abnormal status 0x7F on port 0xF880231C
ata7: disabling port


--
J.A. Magallon <jamagallon()ono!com>     \               Software is like sex:
                                         \         It's better when it's free
Mandriva Linux release 2007.0 (Cooker) for i586
Linux 2.6.17-jam08 (gcc 4.1.1 20060724 (prerelease) (4.1.1-3mdk)) #2 SMP PREEMPT
