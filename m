Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272374AbTGYXHV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 19:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272375AbTGYXHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 19:07:21 -0400
Received: from smtp-01.inode.at ([62.99.194.3]:44991 "EHLO smtp.inode.at")
	by vger.kernel.org with ESMTP id S272374AbTGYXHS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 19:07:18 -0400
Content-Type: text/plain; charset=US-ASCII
From: Heimo Truhetz <h.truhetz@ecowatt.at>
Reply-To: h.truhetz@ecowatt.at
Organization: ecowatt
To: linux-kernel@vger.kernel.org
Subject: AMD760MP - Troubles with MSI K7D
Date: Sat, 26 Jul 2003 01:22:47 +0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
X-Posting-Agent: Hamster/1.3.23.4
Message-Id: <E19gBtB-0000wJ-00@smtp.inode.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello out there,

I have two Athlon MP's 2600+ mounted on a MSI K7D-Master-L with the famous 
AMD-768 (Opus) chipset (latest BIOS 1.82).
Actually I'm using debian's 'woody' distribution with the kernel 2.4.22-pre8, 
glibc 2.2.5 and gcc 2.95.4.
I have problems with the IDE support:
On the hardisk (Maxtor 6Y120L0 - 120GB) there is a 1.4 GB file, I want to 
copy. But when I try this, the system stops with the error message:

attempt to access beyond end of device
03:09: rw=0, want=976094472, limit=109948828

and I have to push the reset button.

When I switch DMA off by using 'hdparm -d0' everthing works fine, but the 
hole copy-process takes about 8 minutes!

Taking a look at 'lspci' shows the following:
# lspci
00:00.0 Host bridge: Advanced Micro Devices [AMD]: Unknown device 700c (rev 
11)
00:01.0 PCI bridge: Advanced Micro Devices [AMD]: Unknown device 700d
00:07.0 ISA bridge: Advanced Micro Devices [AMD]: Unknown device 7440 (rev 05)
00:07.1 IDE interface: Advanced Micro Devices [AMD]: Unknown device 7441 (rev 
04)
00:07.3 Bridge: Advanced Micro Devices [AMD]: Unknown device 7443 (rev 03)
00:07.5 Multimedia audio controller: Advanced Micro Devices [AMD]: Unknown 
device 7445 (rev 03)
00:10.0 PCI bridge: Advanced Micro Devices [AMD]: Unknown device 7448 (rev 05)
01:05.0 VGA compatible controller: ATI Technologies Inc Radeon VE QY
02:00.0 USB Controller: Advanced Micro Devices [AMD]: Unknown device 7449 
(rev 07)
02:09.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 10)

So, the AMD is 'unknown', although 'dmesg' tells:
# dmesg
Linux version 2.4.22-pre8 (root@WUTZEL) (gcc version 2.95.4 20011002 (Debian 
prerelease)) #2 SMP Fre Jul 25 14:18:18 CEST 2003
...
amd768_rng: AMD768 system management I/O registers at 0x600.
amd768_rng hardware driver 0.1.0 loaded
...
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 942M
agpgart: Detected AMD 760MP chipset
agpgart: AGP aperture is 128M @ 0xe8000000
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD7441: IDE controller at PCI slot 00:07.1
AMD7441: chipset revision 4
AMD7441: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD_IDE: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE (rev 04) UDMA100 
controller on pci00:07.1
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:pio, hdd:pio
hda: Maxtor 6Y120L0, ATA DISK drive
hdb: ASUS CD-S400, ATAPI CD/DVD-ROM drive
blk: queue c035e180, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=14946/255/63, 
UDMA(100)
hdb: attached ide-cdrom driver.
hdb: ATAPI 40X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 >
...

Are there any solutions or workarounds to fix these problems?
Do I have to upgrade the glibc or any other system components?
Does this problem affect any inter-CPU processes like OpenMP?
Do I have to change the motherboard? Which mobo's are said to be reliable?

Kindest regards,
Heimo Truhetz

