Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262295AbUCGSAy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 13:00:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262296AbUCGSAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 13:00:54 -0500
Received: from p15108950.pureserver.info ([217.160.128.7]:62138 "EHLO
	pluto.schiffbauer.net") by vger.kernel.org with ESMTP
	id S262295AbUCGSAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 13:00:45 -0500
Date: Sun, 7 Mar 2004 19:00:23 +0100
From: Marc Schiffbauer <marc@schiffbauer.net>
To: linux-kernel@vger.kernel.org
Subject: Re: KERNEL 2.6.3 and MAXTOR 160 GB
Message-ID: <20040307180023.GB24198@lisa.links2linux.home>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0403071549260.3262-100000@numb.darktech.org> <20040307150807.GA16436@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040307150807.GA16436@pclin040.win.tue.nl>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.20-hpt i686
X-Editor: vim 6.1.018-1
X-Homepage: http://www.links2linux.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andries Brouwer schrieb am 07.03.04 um 16:08 Uhr:
> On Sun, Mar 07, 2004 at 03:57:11PM +0100, Carlo Orecchia wrote:
> 
> > I'm running redhat 9 on an XP 1800 and a ASUS A7A266. I recently buy a new 
> > HD a maxtor Diamond Plus 160 with 8 mega cache. The fact is that the kernel that comes 
> > with REDHAT (2.4.20-8) shows the entire size of the disk (163.7 gb) but 
> > the kernel 2.6.1 or 2.6.3 does not. It only shows 137 gb. I'm getting 
> > crazy trying to understand why this is happening! Please let 
> > me know if theres a patch to fix this. I really  found amazing the 2.6 
> > kernel and i don't want to come back to use the 2.4!
> > What can i do? 
> 
> You can tell us the boot messages that concern your disk.
> You can tell us the CONFIG options that concern IDE.
> For example, did you set CONFIG_IDEDISK_STROKE ?
> 

The disk works for me (TM).


homer:~# uname -a
Linux homer 2.6.3 #2 Thu Feb 26 19:38:13 CET 2004 i686 GNU/Linux
homer:~# hdparm -i /dev/hde

/dev/hde:

 Model=Maxtor 6Y160P0, FwRev=YAR41BW0, SerialNo=Y43V47SE
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=DualPortCache, BuffSize=7936kB, MaxMultSect=16,
MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=268435455
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5 udma6
 AdvancedPM=yes: disabled (255) WriteCache=enabled
 Drive conforms to: (null):

 * signifies the current active mode

homer:~# fdisk -l /dev/hde

Disk /dev/hde: 163.9 GB, 163928604672 bytes
255 heads, 63 sectors/track, 19929 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes


boot messages (ide specific part):

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:04.1
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on
pci0000:00:04.1
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:pio
hda: HL-DT-ST GCE-8400B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: Pioneer DVD-ROM ATAPIModel DVD-105S 011, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
PDC20265: IDE controller at PCI slot 0000:00:11.0
PCI: Found IRQ 10 for device 0000:00:11.0
PCI: Sharing IRQ 10 with 0000:00:0b.0
PDC20265: chipset revision 2
PDC20265: 100% native mode on irq 10
PDC20265: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI
Mode.
    ide2: BM-DMA at 0x8000-0x8007, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0x8008-0x800f, BIOS settings: hdg:pio, hdh:pio
hde: Maxtor 6Y160P0, ATA DISK drive
ide2 at 0x9400-0x9407,0x9002 on irq 10
hde: max request size: 1024KiB
hde: 320173056 sectors (163928 MB) w/7936KiB Cache,
CHS=19929/255/63, UDMA(100)
 /dev/ide/host2/bus0/target0/lun0: p1 p2 < p5 p6 p7 p8 p9 p10 >


config:

homer:~# grep _IDE /usr/src/linux-2.6.3/.config
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
CONFIG_BLK_DEV_IDECD=m
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
CONFIG_BLK_DEV_IDESCSI=m
# CONFIG_IDE_TASK_IOCTL is not set
# CONFIG_IDE_TASKFILE_IO is not set
CONFIG_IDE_GENERIC=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
homer:~#


-Marc

-- 
+-O . . . o . . . O . . . o . . . O . . .  ___  . . . O . . . o .-+
| Ein Service von Links2Linux.de:         /  o\   RPMs for SuSE   |
| --> PackMan! <-- naeheres unter        |   __|   and  others    |
| http://packman.links2linux.de/ . . . O  \__\  . . . O . . . O . |
