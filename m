Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261291AbSKBQNj>; Sat, 2 Nov 2002 11:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261292AbSKBQNj>; Sat, 2 Nov 2002 11:13:39 -0500
Received: from smtp.skrzynka.pl ([217.11.143.226]:14036 "HELO
	hello.skrzynka.pl") by vger.kernel.org with SMTP id <S261291AbSKBQNh>;
	Sat, 2 Nov 2002 11:13:37 -0500
Message-ID: <3DC3FB2B.9000208@skrzynka.pl>
Date: Sat, 02 Nov 2002 17:19:55 +0100
From: "Krzysztof \"Filo\" Gorgolewski" <kgorgolewski@skrzynka.pl>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: pl, en-gb, en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: System hangs while Partition check:  with 2.4.20-rc1 kernel
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. System hangs while Partition check:  with 2.4.20-rc1 kernel
2. In the first stages of kernel loading compure hangs just after
viewing "Partition check:" + the  symbilic name of the disk (like hde)
message. It occurs only with disks connected to HighPoint 370 disk
controller (octually built in Abit BE6-II v. 1.2 mainboard). Changing
the channels doesn't solve the problem.
3. IDE, HPT370, kernel, Partition check:
4. 2.4.20-rc1 as well as 2.4.19, 2.4.20-pre8 and 2.4.20-pre8-ac2 (in
2.4.18 and earlylier everything was OK - I have not checked all
development versions of 2.4.19 and 2.4.20).
5. No Oops.
7.1 gcc 2.96(the RedHat edition)
7.2 Pentium III 866Mhz
7.3 No modules (I have not even built in kmod)
7.6 No SCSI (no support built in or any hardware)
7.7 HighPoint 370 disk controller built in Abit BE6-II v. 1.2 mainboard
8. I'm ready to help in any way. I can test patches, sent additional
debug info and more. This bug is very crucial - I can't use new kernels
without it.
Here is the log:

"...
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with ide bus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
HPT370: IDE controller on PCI bus 00 dev 98
PCI: Found IRQ11 for device 00:13.0
HPT370: chipset revision 3
HPT370: not 100% native mode will probe irqs later
HPT370: using 33MHz PCI clock
     ide2: BM-DMA at 0xc000-0xc007, BIOS settings: hde:pio, hdf:pio
     ide3: BM-DMA at 0xc008-0xc00f, BIOS settings: hdg:DMA, hdh:pio
hdc: Pioneer DVD-ROM ATAPIModel DVD-105S 013, ATAPI CD/DVD-ROM drive
hdg: ST320420A, ATA disk drive
ide1 at 0x170-0x177, 0x376 on irq 15
ide3 at 0xb800-0xb807, 0xbc02 on irq 11
blk: queue c0350890, I/O limit 4095 Mb(mask 0xffffffff)
hdg: 398851760 sectors (20404 MB) w/2048 KiB cache, CHS=39535/16/63,
UDMA(66)
hdc: ATAPI 40x DVD-ROM drive, 512 kb cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
     hdg:
"

I hope debugging wont be complicated in this case.

Chris Gorgolewski

