Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751675AbWIGLNo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751675AbWIGLNo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 07:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751680AbWIGLNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 07:13:44 -0400
Received: from smtp.ono.com ([62.42.230.12]:21329 "EHLO resmta03.ono.com")
	by vger.kernel.org with ESMTP id S1751675AbWIGLNn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 07:13:43 -0400
Date: Thu, 7 Sep 2006 13:13:27 +0200
From: "J.A. =?UTF-8?B?TWFnYWxsw7Nu?=" <jamagallon@ono.com>
To: Tejun Heo <htejun@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Lost DVD-RW [Was Re: 2.6.18-rc5-mm1]
Message-ID: <20060907131327.494fd1c2@werewolf.auna.net>
In-Reply-To: <44FFE7AF.8010808@gmail.com>
References: <20060901015818.42767813.akpm@osdl.org>
	<20060904013443.797ba40b@werewolf.auna.net>
	<20060903181226.58f9ea80.akpm@osdl.org>
	<44FB929B.7080405@gmail.com>
	<20060905002600.51c5e73b@werewolf.auna.net>
	<44FFE7AF.8010808@gmail.com>
X-Mailer: Sylpheed-Claws 2.4.0cvs158 (GTK+ 2.10.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Sep 2006 11:34:39 +0200, Tejun Heo <htejun@gmail.com> wrote:

> J.A. Magallón wrote:
> > libata version 2.00 loaded.
> > ata_piix 0000:00:1f.1: version 2.00ac7
> > ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 16
> > PCI: Setting latency timer of device 0000:00:1f.1 to 64
> > ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14
> > ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xF008 irq 15
> > scsi0 : ata_piix
> > ata1.00: XXX class=3 is_ata=0 is_cfa=1
> > ata1.00: failed to IDENTIFY (device reports illegal type, err_mask=0x0)
> 
> Magallón, does the attached patch fix the problem?
> 

Yes, my burner is back :)

libata version 2.00 loaded.
ata_piix 0000:00:1f.1: version 2.00ac7
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1f.1 to 64
ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14
ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xF008 irq 15
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
scsi 0:0:0:0: CD-ROM            HL-DT-ST DVDRAM GSA-4120B A111 PQ: 0 ANSI: 5
sr0: scsi3-mmc drive: 40x/40x writer dvd-ram cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 0:0:0:0: Attached scsi CD-ROM sr0
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
sr1: scsi3-mmc drive: 48x/48x cd/rw xa/form2 cdda tray
sr 1:0:1:0: Attached scsi CD-ROM sr1


Thanks !!

--
J.A. Magallon <jamagallon()ono!com>     \               Software is like sex:
                                         \         It's better when it's free
Mandriva Linux release 2007.0 (Cooker) for i586
Linux 2.6.17-jam08 (gcc 4.1.1 20060724 (prerelease) (4.1.1-3mdk)) #4 SMP PREEMPT
