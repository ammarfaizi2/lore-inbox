Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291863AbSBHVnQ>; Fri, 8 Feb 2002 16:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291868AbSBHVnH>; Fri, 8 Feb 2002 16:43:07 -0500
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:53117 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S291863AbSBHVm5>; Fri, 8 Feb 2002 16:42:57 -0500
Date: Fri, 8 Feb 2002 22:48:38 +0100
From: Heinz Diehl <hd@cavy.de>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: Re: Warning, 2.5.3 eats filesystems
Message-ID: <20020208214838.GA1129@chiara.cavy.de>
Mail-Followup-To: Pavel Machek <pavel@suse.cz>,
	linux-kernel@vger.kernel.org, viro@math.psu.edu
In-Reply-To: <20020206233051.GA503@chiara.cavy.de> <Pine.GSO.4.21.0202061836450.22680-100000@weyl.math.psu.edu> <20020208105050.GA175@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020208105050.GA175@elf.ucw.cz>
User-Agent: Mutt/1.5.0-hc8-current-20020125i (Linux 2.4.18-pre8-mjc i586)
Organization: private site in Mannheim/Germany
X-PGP-Key: To get my public-key, send mail with subject 'get pgpkey'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Feb 08 2002, Pavel Machek wrote:

> For me, mounted filesystems look like this:
[....]

Yep. I sent the "mount" output already to Alexander Viro, unfortunately I
did not Cc: the mail to lkml.

/dev/hda1 on / type ext2 (rw)
proc on /proc type proc (rw)
/dev/hda6 on /usr type ext2 (rw)
/dev/hda5 on /home type ext2 (rw)
/dev/hdb5 on /var/spool/news type ext2 (rw)
tmpfs on /dev/shm type shm (rw)
tmpfs on /tmp type tmpfs (rw)
tmpfs on /var/tmp type tmpfs (rw)

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev06) 
        (prog-if 8a [Master SecP PriP])
        Flags: bus master, medium devsel, latency 64
	I/O ports at e000 [size=16]

[....]
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c586b (rev 41) IDE UDMA33 controller on pci00:07.1
ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:DMA
ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:DMA
hda: IBM-DHEA-36481, ATA DISK drive
hdb: Conner Peripherals 1275MB - CFS1275A, ATA DISK drive
hdc: CD-540E, ATAPI CD/DVD-ROM drive
hdd: CD-W54E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 12692736 sectors (6499 MB) w/472KiB Cache, CHS=790/255/63, UDMA(33)
hdb: 2496876 sectors (1278 MB) w/64KiB Cache, CHS=2477/16/63, DMA
[....]

chiara:~ # hdparm /dev/hda /dev/hdb
/dev/hda:
multcount    = 16 (on)
I/O support  =  3 (32-bit w/sync)
unmaskirq    =  1 (on)
using_dma    =  1 (on)
keepsettings =  0 (off)
nowerr       =  0 (off)
readonly     =  0 (off)
readahead    =  8 (on)
geometry     = 790/255/63, sectors = 12692736, start = 0

/dev/hdb:
multcount    =  8 (on)
I/O support  =  3 (32-bit w/sync)
unmaskirq    =  1 (on)
using_dma    =  1 (on)
keepsettings =  0 (off)
nowerr       =  0 (off)
readonly     =  0 (off)
readahead    =  8 (on)
geometry     = 619/64/63, sectors = 2496876, start = 0
	 
-- 
# Heinz Diehl, 68259 Mannheim, Germany
