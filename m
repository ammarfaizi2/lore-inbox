Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264852AbSJOVGY>; Tue, 15 Oct 2002 17:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264849AbSJOVFi>; Tue, 15 Oct 2002 17:05:38 -0400
Received: from ulima.unil.ch ([130.223.144.143]:32386 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S264852AbSJOVFW>;
	Tue, 15 Oct 2002 17:05:22 -0400
Date: Tue, 15 Oct 2002 23:11:16 +0200
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: What's wrong with my IDE CD-ROM with 2.5.42-ac1?
Message-ID: <20021015211116.GA27915@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

with 2.5.42-ac1 and ide-scsi, devfs:
cdrecord -scanbus
Cdrecord 1.11a26 (i586-mandrake-linux-gnu) Copyright (C) 1995-2002 Jörg
Schilling
Linux sg driver version: 3.5.27
Using libscg version 'schily-0.6'
scsibus0:
0,0,0	  0) 'LG      ' 'CD-ROM CRD-8400B' '1.03' Removable CD-ROM
cdrecord: Warning: controller returns wrong size for CD capabilities page.
0,1,0	  1) 'PIONEER ' 'DVD-ROM DVD-103 ' '1.16' Removable CD-ROM

Oct 14 16:54:39 ulima kernel: phy=0, phyx=24, mii_status=0x786d
Oct 14 16:54:39 ulima kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Oct 14 16:54:39 ulima kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Oct 14 16:54:39 ulima kernel: PIIX4: IDE controller at PCI slot 00:07.1
Oct 14 16:54:39 ulima kernel: PIIX4: chipset revision 1
Oct 14 16:54:39 ulima kernel: PIIX4: not 100%% native mode: will probe irqs later
Oct 14 16:54:39 ulima kernel:     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:DMA
Oct 14 16:54:39 ulima kernel:     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:DMA
Oct 14 16:54:39 ulima kernel: hda: QUANTUM FIREBALL CX13.6A, ATA DISK drive
Oct 14 16:54:39 ulima kernel: hdb: CRD-8400B, ATAPI CD/DVD-ROM drive
Oct 14 16:54:39 ulima kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Oct 14 16:54:39 ulima kernel: hdc: Pioneer DVD-ROM ATAPIModel DVD-103S 011, ATAPI CD/DVD-ROM drive
Oct 14 16:54:39 ulima kernel: hdd: IOMEGA ZIP 250 ATAPI, ATAPI FLOPPY drive
Oct 14 16:54:39 ulima kernel: ide1 at 0x170-0x177,0x376 on irq 15
Oct 14 16:54:39 ulima kernel: hda: host protected area => 1
Oct 14 16:54:39 ulima kernel: hda: 26760384 sectors (13701 MB) w/418KiB Cache, CHS=1665/255/63, UDMA(33)
Oct 14 16:54:39 ulima kernel:  /dev/ide/host0/bus0/target0/lun0: p1 p2
Oct 14 16:54:39 ulima kernel: ide-floppy driver 0.99.newide
Oct 14 16:54:39 ulima kernel: hdd: 244766kB, 489532 blocks, 512 sector size
Oct 14 16:54:39 ulima kernel: hdd: 244736kB, 239/64/32 CHS, 4096 kBps, 512 sector size, 2941 rpm
Oct 14 16:54:39 ulima kernel: hdd: The disk reports a capacity of 250640384 bytes, but the drive only handles 250609664
Oct 14 16:54:39 ulima kernel: hdd: The disk reports a capacity of 250640384 bytes, but the drive only handles 250609664
Oct 14 16:54:39 ulima kernel:  /dev/ide/host0/bus1/target1/lun0: unknown partition tableOct 14 16:54:39 ulima kernel:  /dev/ide/host0/bus1/target1/lun0: unknown partition tableOct 14 16:54:39 ulima kernel: SCSI subsystem driver Revision: 1.00
Oct 14 16:54:39 ulima kernel: scsi0 : SCSI host adapter emulation for IDE ATAPI devices
Oct 14 16:54:39 ulima kernel:   Vendor: LG        Model: CD-ROM CRD-8400B  Rev: 1.03
Oct 14 16:54:39 ulima kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02
Oct 14 16:54:39 ulima kernel: ide-scsi: The scsi wants to send us more data than expected - discarding data
Oct 14 16:54:39 ulima kernel: ide-scsi: transferred 47 of 48 bytes
Oct 14 16:54:39 ulima kernel:   Vendor: PIONEER   Model: DVD-ROM DVD-103   Rev: 1.16
Oct 14 16:54:39 ulima kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02
Oct 14 16:54:39 ulima kernel: Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
Oct 14 16:54:39 ulima kernel: Attached scsi CD-ROM sr1 at scsi0, channel 0, id 1, lun 0
Oct 14 16:54:39 ulima kernel: sr0: scsi3-mmc drive: 40x/40x cd/rw xa/form2 cdda tray
Oct 14 16:54:39 ulima kernel: Uniform CD-ROM driver Revision: 3.12
Oct 14 16:54:39 ulima kernel: sr1: scsi3-mmc drive: 0x/0x cd/rw xa/form2 cdda tray

And:

ls -al cdrom*
lr-xr-xr-x    1 root     root           13 Oct 14 16:54 cdrom -> cdroms/cdrom0
lr-xr-xr-x    1 root     root           31 Oct 14 16:54 cdrom0 -> scsi/host0/bus0/target2/lun0/cd
lr-xr-xr-x    1 root     root           13 Oct 14 16:54 cdrom1 -> cdroms/cdrom1

cdroms:
total 0
drw-rw----    1 root     cdrom           0 Jan  1  1970 .
drwxr-xr-x    1 root     root            0 Jan  1  1970 ..
lr-xr-xr-x    1 root     root           34 Jan  1  1970 cdrom0 -> ../scsi/host0/bus0/target0/lun0/cd
lr-xr-xr-x    1 root     root           34 Jan  1  1970 cdrom1 -> ../scsi/host0/bus0/target1/lun0/cd

But when I try to `mount -t iso9660 scsi/host0/bus0/target0/lun0/cd /mnt/cdrom/`:
mount: block device scsi/host0/bus0/target0/lun0/cd is write-protected, mounting read-only
mount: wrong fs type, bad option, bad superblock on scsi/host0/bus0/target0/lun0/cd,
       or too many mounted file systems

The same CD mount perfectly on the DVD (and on other CD-ROM devices...).

Is there something I should try?

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
