Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932195AbWIDBMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbWIDBMn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 21:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbWIDBMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 21:12:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64649 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932195AbWIDBMl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 21:12:41 -0400
Date: Sun, 3 Sep 2006 18:12:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: "J.A. =?ISO-8859-1?B?TWFnYWxs824i?= <jamagallon@ono.com>"@osdl.org
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>
Subject: Re: Lost DVD-RW [Was Re: 2.6.18-rc5-mm1]
Message-Id: <20060903181226.58f9ea80.akpm@osdl.org>
In-Reply-To: <20060904013443.797ba40b@werewolf.auna.net>
References: <20060901015818.42767813.akpm@osdl.org>
	<20060904013443.797ba40b@werewolf.auna.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Sep 2006 01:34:43 +0200
"J.A. Magallón" <jamagallon@ono.com> wrote:

> On Fri, 1 Sep 2006 01:58:18 -0700, Andrew Morton <akpm@osdl.org> wrote:
> 
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc5/2.6.18-rc5-mm1/
> > 
> 
> Err, my burner got lost this summer ;).
> This is really not a bug of _this_ kernel, because I noticed it dissapeared
> with the previous release also, just before going on vacation... But as it
> did not come back with this relase, I report it here.
> 
> Last kernel that I have tried that worked was 2.6.18-rc2-mm1. With this
> relase, it is gone still. dmesg for both kernels is below.
> The only thing I hace noticed is the different IRQ assignment between
> them.
> 
> Any ideas ? TIA.
> 
> dmesg for rc2-mm1:
> 
> libata version 2.00 loaded.
> ata_piix 0000:00:1f.1: version 2.00ac6
> ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 16
> PCI: Setting latency timer of device 0000:00:1f.1 to 64
> ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14
> ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xF008 irq 14
> scsi0 : ata_piix
> ata1.00: ATAPI, max UDMA/33
> ata1.01: ATAPI, max MWDMA0, CDB intr
> ata1.00: configured for UDMA/33
> ata1.01: configured for PIO3
> scsi1 : ata_piix
> ata2.00: ATA-6, max UDMA/100, 234441648 sectors: LBA48
> ata2.00: ata2: dev 0 multi count 16
> ata2.01: ATAPI, max UDMA/33
> ata2.00: configured for UDMA/100
> ata2.01: configured for UDMA/33
>   Vendor: HL-DT-ST  Model: DVDRAM GSA-4120B  Rev: A111
>   Type:   CD-ROM                             ANSI SCSI revision: 05
>   Vendor: IOMEGA    Model: ZIP 250           Rev: 51.G
>   Type:   Direct-Access                      ANSI SCSI revision: 05
>   Vendor: ATA       Model: ST3120022A        Rev: 3.06
>   Type:   Direct-Access                      ANSI SCSI revision: 05
>   Vendor: TOSHIBA   Model: DVD-ROM SD-M1712  Rev: 1004
>   Type:   CD-ROM                             ANSI SCSI revision: 05
> ata_piix 0000:00:1f.2: MAP [ P0 -- P1 -- ]
> ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 16
> PCI: Setting latency timer of device 0000:00:1f.2 to 64
> ata3: SATA max UDMA/133 cmd 0xC000 ctl 0xC402 bmdma 0xD000 irq 16
> ata4: SATA max UDMA/133 cmd 0xC800 ctl 0xCC02 bmdma 0xD008 irq 16
> ...
> 
> dmesg for rc5-mm1:
> 
> libata version 2.00 loaded.
> ata_piix 0000:00:1f.1: version 2.00ac7
> ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 16
> PCI: Setting latency timer of device 0000:00:1f.1 to 64
> ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14
> ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xF008 irq 15
> scsi0 : ata_piix
> ata1.00: failed to IDENTIFY (device reports illegal type, err_mask=0x0)
> ata1.01: ATAPI, max MWDMA0, CDB intr
> ata1.01: configured for PIO3
> scsi1 : ata_piix
> ata2.00: ATA-6, max UDMA/100, 234441648 sectors: LBA48
> ata2.00: ata2: dev 0 multi count 16
> ata2.01: ATAPI, max UDMA/33
> ata2.00: configured for UDMA/100
> ata2.01: configured for UDMA/33
> scsi 0:0:1:0: Direct-Access     IOMEGA   ZIP 250          51.G PQ: 0 ANSI: 5
> sd 0:0:1:0: Attached scsi removable disk sda
> scsi 1:0:0:0: Direct-Access     ATA      ST3120022A       3.06 PQ: 0 ANSI: 5
> SCSI device sdb: 234441648 512-byte hdwr sectors (120034 MB)
> sdb: Write Protect is off
> sdb: Mode Sense: 00 3a 00 00
> SCSI device sdb: drive cache: write back
> SCSI device sdb: 234441648 512-byte hdwr sectors (120034 MB)
> sdb: Write Protect is off
> sdb: Mode Sense: 00 3a 00 00
> SCSI device sdb: drive cache: write back
>  sdb: sdb1
> sd 1:0:0:0: Attached scsi disk sdb
> scsi 1:0:1:0: CD-ROM            TOSHIBA  DVD-ROM SD-M1712 1004 PQ: 0 ANSI: 5
> sr0: scsi3-mmc drive: 48x/48x cd/rw xa/form2 cdda tray
> Uniform CD-ROM driver Revision: 3.20
> sr 1:0:1:0: Attached scsi CD-ROM sr0
> ata_piix 0000:00:1f.2: MAP [ P0 -- P1 -- ]
> ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 16
> PCI: Setting latency timer of device 0000:00:1f.2 to 64
> ata3: SATA max UDMA/133 cmd 0xC000 ctl 0xC402 bmdma 0xD000 irq 16
> ata4: SATA max UDMA/133 cmd 0xC800 ctl 0xCC02 bmdma 0xD008 irq 16
> 

Please, try to cc the relevant developers on bug reports.

Thanks.

-- 
VGER BF report: H 0
