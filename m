Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130209AbRCLNz3>; Mon, 12 Mar 2001 08:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130216AbRCLNzT>; Mon, 12 Mar 2001 08:55:19 -0500
Received: from web4406.mail.yahoo.com ([216.115.105.37]:57872 "HELO
	web4406.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S130209AbRCLNzH>; Mon, 12 Mar 2001 08:55:07 -0500
Message-ID: <20010312135426.27108.qmail@web4406.mail.yahoo.com>
Date: Mon, 12 Mar 2001 05:54:26 -0800 (PST)
From: Brian Stempien <stempbm@yahoo.com>
Subject: Lockup after IDE setup
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have the following problem that has completely
stumped me. I have tried searching the Mailing list
archives, but have found nothing. I am not subscribed
to the list, so I would ask that I be CCed
(stempbm@yahoo.com) on the responses to this message.

I have a Dell Dimension XPS Pro200n Pentium Pro 200Mhz
computer with a Promise PDC 20246 (Ultra/33) PCI card
running a Quantum FireBall LP 13Gig drive. Everything
was running fine under 2.2.13 Mandrake 6.0. I decided
to upgrade to Mandrake 7.2 and the Kernel locks up as
soon as the IDE stuff is initialized. So, I tried 7.1
which booted, upgraded, and then I had the same
problem
on reboot with the new kernel from the CD-ROM. I next
downloaded the 2.4.0 kernel and recompiled from
scratch. I have tried to keep most anything "strange"
out of the IDE settings. I do have an IDE tape and IDE
CD-RW on the 2 internal IDE controller ports. I also
made sure support for the Promise card was compiled
in. So, here is the output from the screen. Once the
last line is displayed nothing more happens. I have
tried disabling the internal IDE controller, but that
does not help.

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus
PIIX3: IDE controller on PCI bus 00 dev 39 ChipSet
Revision 0
PIIX3: Not 100% native mode: Will probe irqs later.

ide0: BM-DMA at 0xff50 - 0xff57, BIOS settings: hda:
pio hdb: pio
ide1: BM-DMA at 0xff58 - 0xff5f, BIOS settings: hdc:
pio hdd: pio

PDC20246: IDE controller on PCI bus 00 dev 58 chipset
rev 1
PDC20246: not 100% native mode: Will probe irqs later.
PDC20246: (U)DMA Burst Bit Enabled Primary PCI mode
Secondary PCI mode

ide2: BM-DMA at 0xff80-0xff87 BIOS settings: hde: DMA
hdef: pio
ide3: BM-DMA at 0xff88-0xff8f BIOS settings: hdg: pio
hdh: pio

hda: Seagate STT8000A, ATAPI Tape Drive
hdc: CD-RW CRX100E, ATAPI CDROM drive
hde: Quantum FireBallP KA13.6, ATA Disk drive
ide0: at 0x1f0-0x1f7, 0x3f6 on irq 14
ide1: at 0x170-0x177, 0x376 on irq 15
ide2: at 0xfff0-oxfff7, 0xffe6 on irq 10

During the upgrade I switched to a console and used
fdisk to lookup my partitions. Here are the results of
the partition table list. 

Partition 1 does not end on a cylinder boundary
phys = (2,254,63) should be (2,15,63)
Partition 2 does not end on a cylinder boundary
phys = (264,254,63) should be (264,15,63)
Partition 3 does not end on a cylinder boundary
phys = (1023,254,63) should be (1023,15,63)

Partitions 1 and 2 are primary, 16Meg and 2Gig
respectively. Partition 3 is my extended partition
that contains all my Linux Logical partitions (expect
/boot with is Partition 1). 

When I use fdisk after booting with my old 2.2.13
kernel, I do not get these messages. I suspect the
partition problem to be related to, if not the cause
of, the problem. Since I will have to re-install
everything to fix it, I would like to know if I am
correct, or if something else is wrong.

Thanks!

Brian Stempien
stempbm@yahoo.com

__________________________________________________
Do You Yahoo!?
Yahoo! Auctions - Buy the things you want at great prices.
http://auctions.yahoo.com/
