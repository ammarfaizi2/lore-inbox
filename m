Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130129AbRCGEtw>; Tue, 6 Mar 2001 23:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130130AbRCGEtm>; Tue, 6 Mar 2001 23:49:42 -0500
Received: from zooty.lancs.ac.uk ([148.88.16.231]:45231 "EHLO
	zooty.lancs.ac.uk") by vger.kernel.org with ESMTP
	id <S130129AbRCGEtW>; Tue, 6 Mar 2001 23:49:22 -0500
Message-Id: <l03130314b6cb68d824fd@[192.168.239.101]>
In-Reply-To: <3AA57268.3070603@devries.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 7 Mar 2001 04:30:10 +0000
To: Peter DeVries <peter@devries.tv>, linux-kernel@vger.kernel.org
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: Drive corruption with VIA VT82C686A (ABIT KT7-RAID) - Still -
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>VP_IDE: IDE controller on PCI bus 00 dev 39
>VP_IDE: chipset revision 16
>VP_IDE: not 100% native mode: will probe irqs later
>ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
>VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci00:07.1
>    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
>    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:pio
>hda: WDC WD205BA, ATA DISK drive
>hdc: TOSHIBA DVD-ROM SD-M1202, ATAPI CD/DVD-ROM drive
>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
>ide1 at 0x170-0x177,0x376 on irq 15
>hda: 40088160 sectors (20525 MB) w/2048KiB Cache, CHS=2495/255/63, UDMA(33)
>hdc: ATAPI 32X DVD-ROM drive, 256kB Cache, DMA

...

>PCI: Found IRQ 10 for device 00:08.0
>PCI: The same IRQ used for device 00:07.2
>PCI: The same IRQ used for device 00:07.3
>3c59x.c:LK1.1.12 06 Jan 2000  Donald Becker and others.
>http://www.scyld.com/network/vortex.html $Revision: 1.102.2.46 $
>See Documentation/networking/vortex.txt
>eth0: 3Com PCI 3c905C Tornado at 0xdc00,  00:01:03:30:0f:3a, IRQ 10
>  product code 'HN' rev 00.3 date 11-03-00
>  8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
>  MII transceiver found at address 24, status 782d.
>  Enabling bus-master transmits and whole-frame receives.

...

>PCI: Found IRQ 10 for device 00:07.2
>PCI: The same IRQ used for device 00:07.3
>PCI: The same IRQ used for device 00:08.0
>uhci.c: USB UHCI at I/O 0xd400, IRQ 10
>uhci.c: detected 2 ports
>usb.c: new USB bus registered, assigned bus number 1
>hub.c: USB hub found
>hub.c: 2 ports detected
>PCI: Found IRQ 10 for device 00:07.3
>PCI: The same IRQ used for device 00:07.2
>PCI: The same IRQ used for device 00:08.0
>uhci.c: USB UHCI at I/O 0xd800, IRQ 10
>uhci.c: detected 2 ports
>usb.c: new USB bus registered, assigned bus number 2
>hub.c: USB hub found
>hub.c: 2 ports detected

...

>eth0: using NWAY autonegotiation
>eth0: command 0x2800 took 33590 usecs! Please tell andrewm@uow.edu.au
>hda: DMA disabled
>VFS: Disk change detected on device ide1(22,0)
>hdc: DMA disabled

I suggest moving your network card to a different PCI slot, which should
partially resolve those IRQ conflicts and may improve reliability.

--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
big-mail: chromatix@penguinpowered.com
uni-mail: j.d.morton@lancaster.ac.uk

The key to knowledge is not to rely on people to teach you it.

Get VNC Server for Macintosh from http://www.chromatix.uklinux.net/vnc/

-----BEGIN GEEK CODE BLOCK-----
Version 3.12
GCS$/E/S dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$ V? PS
PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r- y+
-----END GEEK CODE BLOCK-----


