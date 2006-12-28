Return-Path: <linux-kernel-owner+w=401wt.eu-S964965AbWL1VuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964965AbWL1VuY (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 16:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964975AbWL1VuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 16:50:24 -0500
Received: from guri.is.scarlet.be ([193.74.71.22]:37371 "EHLO
	guri.is.scarlet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964965AbWL1VuX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 16:50:23 -0500
Message-ID: <45943C15.4010506@scarlet.be>
Date: Thu, 28 Dec 2006 21:50:13 +0000
From: Joel Soete <soete.joel@scarlet.be>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: Ioan Ionita <opslynx@gmail.com>, Alan <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org, jgarzik@pobox.com, htejun@gmail.com
Subject: Re: 2.6.19-rc5 libata PATA ATAPI CDROM SiS 5513 NOT WORKING
References: <df47b87a0611161522o3ad007f5i8804c876c50e591c@mail.gmail.com> <20061116235048.3cd91beb@localhost.localdomain> <df47b87a0611161730p70e1dd41iad7d27a0bf9283ff@mail.gmail.com> <df47b87a0611161734h818fc4dneaad5eeaa7e3c392@mail.gmail.com> <20061117100559.GA10275@devserv.devel.redhat.com> <459286C2.7080705@scarlet.be>
In-Reply-To: <459286C2.7080705@scarlet.be>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-DCC-scarlet.be-Metrics: guri 2020; Body=7 Fuz1=7 Fuz2=7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alan, Jeff,

Reading a paper on this new libata, I just want to try but failled yet for what said this thread "ATAPI CDROM" ;_(.

I first test the latest stable 2.6.19.1 without luck, so I also want to try latest 2.6.20-rc2 unfortunately without more 
success.

Here it was the test of new libata with 2.6.19.1:
[snip]
ata_piix 0000:00:07.1: version 2.00ac6
ata1: PATA max UDMA/33 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14
ata2: PATA max UDMA/33 cmd 0x170 ctl 0x376 bmdma 0xF008 irq 15
scsi3 : ata_piix
ata1.00: ATA-4, max UDMA/66, 29336832 sectors: LBA
ata1.00: ata1: dev 0 multi count 16
ata1.01: ATAPI, max MWDMA1
ata1.00: configured for UDMA/33
ata1.01: qc timeout (cmd 0xa1)
ata1.01: failed to IDENTIFY (I/O error, err_mask=0x4)
ata1.01: revalidation failed (errno=-5)
ata1.01: limiting speed to PIO3
ata1: failed to recover some devices, retrying in 5 secs
ata1: port is slow to respond, please be patient (Status 0xd0)
ata1: port failed to respond (30 secs, Status 0xd0)
ata1.01: qc timeout (cmd 0xa1)
ata1.01: failed to IDENTIFY (I/O error, err_mask=0x4)
ata1.01: revalidation failed (errno=-5)
ata1: failed to recover some devices, retrying in 5 secs
ata1: port is slow to respond, please be patient (Status 0xd0)
ata1: port failed to respond (30 secs, Status 0xd0)
ata1.01: qc timeout (cmd 0xa1)
ata1.01: failed to IDENTIFY (I/O error, err_mask=0x4)
ata1.01: revalidation failed (errno=-5)
ata1.01: disabled
ata1: failed to recover some devices, retrying in 5 secs
ata1.00: failed to set xfermode (err_mask=0x40)
ata1.00: limiting speed to UDMA/25
ata1: failed to recover some devices, retrying in 5 secs
ata1: port is slow to respond, please be patient (Status 0xd0)
ata1: port failed to respond (30 secs, Status 0xd0)
ata1.00: configured for UDMA/25
scsi4 : ata_piix
scsi 3:0:0:0: Direct-Access     ATA      QUANTUM FIREBALL A03. PQ: 0 ANSI: 5
SCSI device sdc: 29336832 512-byte hdwr sectors (15020 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
SCSI device sdc: 29336832 512-byte hdwr sectors (15020 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
  sdc: sdc1 sdc2 < sdc5 sdc6 sdc7 sdc8 sdc9 sdc10 sdc11 sdc12 sdc13 sdc14 sdc15 >
sd 3:0:0:0: Attached scsi disk sdc
sd 3:0:0:0: Attached scsi generic sg2 type 0
[snip]

And today with 2.6.20-rc2:
ata_piix 0000:00:07.1: version 2.00ac7
ata1: PATA max UDMA/33 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14
ata2: PATA max UDMA/33 cmd 0x170 ctl 0x376 bmdma 0xF008 irq 15
scsi3 : ata_piix
ata1.00: ATA-4, max UDMA/66, 29336832 sectors: LBA
ata1.00: ata1: dev 0 multi count 16
ata1.01: ATAPI, max MWDMA1
ata1.00: configured for UDMA/33
ata1.01: qc timeout (cmd 0xa1)
ata1.01: failed to IDENTIFY (I/O error, err_mask=0x4)
ata1.01: revalidation failed (errno=-5)
ata1.01: limiting speed to PIO3
ata1: failed to recover some devices, retrying in 5 secs
ata1: port is slow to respond, please be patient (Status 0xd0)
ata1: port failed to respond (30 secs, Status 0xd0)
ata1.01: qc timeout (cmd 0xa1)
ata1.01: failed to IDENTIFY (I/O error, err_mask=0x4)
ata1.01: revalidation failed (errno=-5)
ata1: failed to recover some devices, retrying in 5 secs
ata1: port is slow to respond, please be patient (Status 0xd0)
ata1: port failed to respond (30 secs, Status 0xd0)
ata1.01: qc timeout (cmd 0xa1)
ata1.01: failed to IDENTIFY (I/O error, err_mask=0x4)
ata1.01: revalidation failed (errno=-5)
ata1.01: disabled
ata1: failed to recover some devices, retrying in 5 secs
ata1.00: failed to set xfermode (err_mask=0x40)
ata1.00: limiting speed to UDMA/25
ata1: failed to recover some devices, retrying in 5 secs
ata1: port is slow to respond, please be patient (Status 0xd0)
ata1: port failed to respond (30 secs, Status 0xd0)
ata1.00: configured for UDMA/25
scsi4 : ata_piix
scsi 3:0:0:0: Direct-Access     ATA      QUANTUM FIREBALL A03. PQ: 0 ANSI: 5
SCSI device sdc: 29336832 512-byte hdwr sectors (15020 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
SCSI device sdc: 29336832 512-byte hdwr sectors (15020 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
  sdc: sdc1 sdc2 < sdc5 sdc6 sdc7 sdc8 sdc9 sdc10 sdc11 sdc12 sdc13 sdc14 sdc15 >
sd 3:0:0:0: Attached scsi disk sdc
sd 3:0:0:0: Attached scsi generic sg2 type 0
[snip]

seems to look like same kind of pb this thread speak about (i.e. hd seems to works fine but not atapi cdrom (r/w)) but not sure?

Any idea/advise?


Tia,
     Joel

PS0: I check that scsi cdrom was well selected

PS1: with traditional ide support I get (with same 2.6.19.1 kernel):
  [snip]
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 0000:00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: QUANTUM FIREBALLlct10 15, ATA DISK drive
hdb: PHILIPS CDD3610 CD-R/RW, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide1...
hda: max request size: 128KiB
hda: 29336832 sectors (15020 MB) w/418KiB Cache, CHS=29104/16/63, UDMA(33)
hda: cache flushes not supported
  hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 hda12 hda13 hda14 hda15 hda16 hda17 hda18 hda19 hda20 hda21 hda22
hda23 hda24 >
hdb: ATAPI 6X CD-ROM CD-R/RW drive, 768kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
[snip]


Joel Soete wrote:
> Hello Alan, Jeff,
> 
> Reading a paper on this new libata, I just want to try but failled yet 
> for what said this thread "ATAPI CDROM" ;_(.
> 
> I first test the latest stable 2.6.19.1 without luck, so I also want to 
> try latest 2.6.20-rc2 unfortunately without more success.
> 
> Here it was the test of new libata with 2.6.19.1:
> [snip]
> ata_piix 0000:00:07.1: version 2.00ac6
> ata1: PATA max UDMA/33 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14
> ata2: PATA max UDMA/33 cmd 0x170 ctl 0x376 bmdma 0xF008 irq 15
> scsi3 : ata_piix
> ata1.00: ATA-4, max UDMA/66, 29336832 sectors: LBA
> ata1.00: ata1: dev 0 multi count 16
> ata1.01: ATAPI, max MWDMA1
> ata1.00: configured for UDMA/33
> ata1.01: qc timeout (cmd 0xa1)
> ata1.01: failed to IDENTIFY (I/O error, err_mask=0x4)
> ata1.01: revalidation failed (errno=-5)
> ata1.01: limiting speed to PIO3
> ata1: failed to recover some devices, retrying in 5 secs
> ata1: port is slow to respond, please be patient (Status 0xd0)
> ata1: port failed to respond (30 secs, Status 0xd0)
> ata1.01: qc timeout (cmd 0xa1)
> ata1.01: failed to IDENTIFY (I/O error, err_mask=0x4)
> ata1.01: revalidation failed (errno=-5)
> ata1: failed to recover some devices, retrying in 5 secs
> ata1: port is slow to respond, please be patient (Status 0xd0)
> ata1: port failed to respond (30 secs, Status 0xd0)
> ata1.01: qc timeout (cmd 0xa1)
> ata1.01: failed to IDENTIFY (I/O error, err_mask=0x4)
> ata1.01: revalidation failed (errno=-5)
> ata1.01: disabled
> ata1: failed to recover some devices, retrying in 5 secs
> ata1.00: failed to set xfermode (err_mask=0x40)
> ata1.00: limiting speed to UDMA/25
> ata1: failed to recover some devices, retrying in 5 secs
> ata1: port is slow to respond, please be patient (Status 0xd0)
> ata1: port failed to respond (30 secs, Status 0xd0)
> ata1.00: configured for UDMA/25
> scsi4 : ata_piix
> scsi 3:0:0:0: Direct-Access     ATA      QUANTUM FIREBALL A03. PQ: 0 
> ANSI: 5
> SCSI device sdc: 29336832 512-byte hdwr sectors (15020 MB)
> sdc: Write Protect is off
> sdc: Mode Sense: 00 3a 00 00
> SCSI device sdc: drive cache: write back
> SCSI device sdc: 29336832 512-byte hdwr sectors (15020 MB)
> sdc: Write Protect is off
> sdc: Mode Sense: 00 3a 00 00
> SCSI device sdc: drive cache: write back
>  sdc: sdc1 sdc2 < sdc5 sdc6 sdc7 sdc8 sdc9 sdc10 sdc11 sdc12 sdc13 sdc14 
> sdc15 >
> sd 3:0:0:0: Attached scsi disk sdc
> sd 3:0:0:0: Attached scsi generic sg2 type 0
> [snip]
> 
> And today with 2.6.20-rc2:
> ata_piix 0000:00:07.1: version 2.00ac7
> ata1: PATA max UDMA/33 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14
> ata2: PATA max UDMA/33 cmd 0x170 ctl 0x376 bmdma 0xF008 irq 15
> scsi3 : ata_piix
> ata1.00: ATA-4, max UDMA/66, 29336832 sectors: LBA
> ata1.00: ata1: dev 0 multi count 16
> ata1.01: ATAPI, max MWDMA1
> ata1.00: configured for UDMA/33
> ata1.01: qc timeout (cmd 0xa1)
> ata1.01: failed to IDENTIFY (I/O error, err_mask=0x4)
> ata1.01: revalidation failed (errno=-5)
> ata1.01: limiting speed to PIO3
> ata1: failed to recover some devices, retrying in 5 secs
> ata1: port is slow to respond, please be patient (Status 0xd0)
> ata1: port failed to respond (30 secs, Status 0xd0)
> ata1.01: qc timeout (cmd 0xa1)
> ata1.01: failed to IDENTIFY (I/O error, err_mask=0x4)
> ata1.01: revalidation failed (errno=-5)
> ata1: failed to recover some devices, retrying in 5 secs
> ata1: port is slow to respond, please be patient (Status 0xd0)
> ata1: port failed to respond (30 secs, Status 0xd0)
> ata1.01: qc timeout (cmd 0xa1)
> ata1.01: failed to IDENTIFY (I/O error, err_mask=0x4)
> ata1.01: revalidation failed (errno=-5)
> ata1.01: disabled
> ata1: failed to recover some devices, retrying in 5 secs
> ata1.00: failed to set xfermode (err_mask=0x40)
> ata1.00: limiting speed to UDMA/25
> ata1: failed to recover some devices, retrying in 5 secs
> ata1: port is slow to respond, please be patient (Status 0xd0)
> ata1: port failed to respond (30 secs, Status 0xd0)
> ata1.00: configured for UDMA/25
> scsi4 : ata_piix
> scsi 3:0:0:0: Direct-Access     ATA      QUANTUM FIREBALL A03. PQ: 0 
> ANSI: 5
> SCSI device sdc: 29336832 512-byte hdwr sectors (15020 MB)
> sdc: Write Protect is off
> sdc: Mode Sense: 00 3a 00 00
> SCSI device sdc: write cache: enabled, read cache: enabled, doesn't 
> support DPO or FUA
> SCSI device sdc: 29336832 512-byte hdwr sectors (15020 MB)
> sdc: Write Protect is off
> sdc: Mode Sense: 00 3a 00 00
> SCSI device sdc: write cache: enabled, read cache: enabled, doesn't 
> support DPO or FUA
>  sdc: sdc1 sdc2 < sdc5 sdc6 sdc7 sdc8 sdc9 sdc10 sdc11 sdc12 sdc13 sdc14 
> sdc15 >
> sd 3:0:0:0: Attached scsi disk sdc
> sd 3:0:0:0: Attached scsi generic sg2 type 0
> [snip]
> 
> seems to look like same kind of pb this thread speak about (i.e. hd 
> seems to works fine but not atapi cdrom (r/w)) but not sure?
> 
> Any idea/advise?
> 
> 
> Tia,
>     Joel
> 
> PS0: I check that scsi cdrom was well selected
> 
> PS1: with traditional ide support I get (with same 2.6.19.1 kernel):
>  [snip]
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> PIIX4: IDE controller at PCI slot 0000:00:07.1
> PIIX4: chipset revision 1
> PIIX4: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
>     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
> Probing IDE interface ide0...
> hda: QUANTUM FIREBALLlct10 15, ATA DISK drive
> hdb: PHILIPS CDD3610 CD-R/RW, ATAPI CD/DVD-ROM drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> Probing IDE interface ide1...
> Probing IDE interface ide1...
> hda: max request size: 128KiB
> hda: 29336832 sectors (15020 MB) w/418KiB Cache, CHS=29104/16/63, UDMA(33)
> hda: cache flushes not supported
>  hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 hda12 hda13 hda14 
> hda15 hda16 hda17 hda18 hda19 hda20 hda21 hda22
> hda23 hda24 >
> hdb: ATAPI 6X CD-ROM CD-R/RW drive, 768kB Cache, DMA
> Uniform CD-ROM driver Revision: 3.20
> [snip]
> 
> Alan Cox wrote:
>> On Thu, Nov 16, 2006 at 08:34:03PM -0500, Ioan Ionita wrote:
>>>> ata2.00: limiting speed to UDMA/25
>>>> ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
>>>> ata2.00: (BMDMA stat 0x20)
>>>> ata2.00: tag 0 cmd 0xa0 Emask 0x5 stat 0x51 err 0x51 (timeout)
>>
>> etc.. - yes known. Something in the core code but not yet fixed (and I've
>> not had time to look at this).
>>
>> -
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
>>
>>
> 
> 
