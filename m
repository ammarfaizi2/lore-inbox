Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318426AbSHQMMB>; Sat, 17 Aug 2002 08:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318561AbSHQMMB>; Sat, 17 Aug 2002 08:12:01 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:25873
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S318426AbSHQML7>; Sat, 17 Aug 2002 08:11:59 -0400
Date: Sat, 17 Aug 2002 05:06:09 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: IDE?  IDE-TNG driver
In-Reply-To: <20020817115243.GA13771@merlin.emma.line.org>
Message-ID: <Pine.LNX.4.10.10208170455050.23171-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I will hand it to you guys on a silver platter IDE-TNG.

Below yields modular chipsets and channel index registration.
Selectable IOPS for arch independent Taskfile Transport layers.
Now to finish the job with device class link lists to address fully
modular subdrivers.  It also includes 1st generation of device open and
select calls of subdrivers.

You have ide-cd registered on a cdrw and you want to burn a cd?
open(/dev/hdX) transform_subdriver_scsi close(/dev/hdX)
open(/dev/sg) and burn baby burn.
close(/dev/sg) releases transform_subdriver_scsi
open(/dev/hdX) load native atapi transport.

Will do it for TAPE-FLOPPY-DVDCD/RW ...


Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SiI680: IDE controller on PCI bus 00 dev 90
SiI680: chipset revision 1
SiI680: not 100% native mode: will probe irqs later
SiI680: BASE CLOCK == 133
    ide0: MMIO-DMA at 0xe080df00-0xe080df07, BIOS settings: hda:pio, hdb:pio
    ide1: MMIO-DMA at 0xe080df08-0xe080df0f, BIOS settings: hdc:pio, hdd:pio
hda: Maxtor 4G160J8, ATA DISK drive
hdb: Maxtor 4G160J8, ATA DISK drive
ide0 at 0xe080df80-0xe080df87,0xe080df8a on irq 9
hda: host protected area => 1
hda: 320173056 sectors (163929 MB) w/2048KiB Cache, CHS=19929/255/63, UDMA(133)
hdb: host protected area => 1
hdb: 320173056 sectors (163929 MB) w/2048KiB Cache, CHS=19929/255/63, UDMA(133)
hdc: Maxtor 4G160J8, ATA DISK drive
hdd: Maxtor 4G160J8, ATA DISK drive
ide1 at 0xe080dfc0-0xe080dfc7,0xe080dfca on irq 9
hdc: host protected area => 1
hdc: 320173056 sectors (163929 MB) w/2048KiB Cache, CHS=19929/255/63, UDMA(133)
hdd: host protected area => 1
hdd: 320173056 sectors (163929 MB) w/2048KiB Cache, CHS=19929/255/63, UDMA(133)
PIIX3: IDE controller on PCI bus 00 dev 39
PIIX3: chipset revision 0
PIIX3: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0xffa0-0xffa7, BIOS settings: hde:DMA, hdf:DMA
    ide3: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdg:pio, hdh:pio
hde: ATAPI 44X CDROM, ATAPI CD/DVD-ROM drive
hdf: CREATIVEDVD5240E-1, ATAPI CD/DVD-ROM drive
ide2 at 0x1f0-0x1f7,0x3f6 on irq 14
hde: ATAPI 40X CD-ROM drive, 128kB Cache, (U)DMA
Uniform CD-ROM driver Revision: 3.12
hdf: ATAPI 32X DVD-ROM drive, 512kB Cache, DMA
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1
 /dev/ide/host0/bus0/target1/lun0: p1
 /dev/ide/host0/bus1/target0/lun0: p1
 /dev/ide/host0/bus1/target1/lun0: p1


If this is what you want, this is what I have to put on the table.
If you do not I will delete the code.


Regards,

Andre Hedrick
LAD Storage Consulting Group

On Sat, 17 Aug 2002, Matthias Andree wrote:

> On Fri, 16 Aug 2002, Linus Torvalds wrote:
> 
> > In article <2444170000.1029531611@flay>,
> > Martin J. Bligh <Martin.Bligh@us.ibm.com> wrote:
> > >So did Linus get disk corruption or is something else afoot?
> > 
> > Martin gave up the fight he had to do all the time, so..
> 
> Not having seen much of all the work, this sounds like it is a sad day,
> for Martin who contributed a lot of his time to work on the issues,
> while people seemed not to be too grateful, screaming from either end of
> the road, this must wear people out.
> 
> Is there a way how the improvements that parts of the stuff have
> received can be rescued somehow? Or at least the knowledge of which can
> be used somewhat directly for a IDE-TNG driver? I'd find it really sad
> to just let go of so much time that had been invested into the project
> -- but keep in mind I have NO knowledge of the gory details of the last
> 2.5 IDE stuff.
> 
> -- 
> Matthias Andree
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

