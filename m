Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbTFPHcL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 03:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262543AbTFPHcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 03:32:11 -0400
Received: from fep02.superonline.com ([212.252.122.41]:48343 "EHLO
	fep02.superonline.com") by vger.kernel.org with ESMTP
	id S262030AbTFPHcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 03:32:09 -0400
Message-ID: <3EED7547.5070203@superonline.com>
Date: Mon, 16 Jun 2003 10:44:07 +0300
From: "O.Sezer" <sezero@superonline.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: alan@redhat.com
Subject: siimage base clock detection
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alan, all:

With 2.4.21-ac1, my cmd680 is detected with a base clock
o1 100, instead of 133 whict, I think, as it should be.
The card is an ata133 raid card. In my earlier tries with
mandrake's 2.4.21-pre4q13, the base clock was reported
correctly. The hard disk attached to is a udma100 one, yes,
but I think "base clock" is supposed to report the capability
of the controller not the drive (I may be wrong of course).
Lspci reports the card as:

00:0a.0 RAID bus controller: CMD Technology Inc PCI0680 (rev 02)
	Subsystem: CMD Technology Inc: Unknown device 3680
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- 
<PERR-
	Latency: 32, cache line size 01
	Interrupt: pin A routed to IRQ 4
	Region 0: I/O ports at d000 [size=8]
	Region 1: I/O ports at b800 [size=4]
	Region 2: I/O ports at b400 [size=8]
	Region 3: I/O ports at b000 [size=4]
	Region 4: I/O ports at a800 [size=16]
	Region 5: Memory at d5800000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at <unassigned> [disabled] [size=512K]
	Capabilities: <available only to root>


Relevant parts of dmesg:

SiI680: IDE controller at PCI slot 00:0a.0
SiI680: chipset revision 2
SiI680: not 100% native mode: will probe irqs later
SiI680: BASE CLOCK == 100
     ide2: MMIO-DMA , BIOS settings: hde:pio, hdf:pio
     ide3: MMIO-DMA , BIOS settings: hdg:pio, hdh:pio
[...]
hde: ST320014A, ATA DISK drive
blk: queue c0380918, I/O limit 4095Mb (mask 0xffffffff)
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xe09e2080-0xe09e2087,0xe09e208a on irq 4
hde: attached ide-disk driver.
hde: host protected area => 1
hde: 39102336 sectors (20020 MB) w/2048KiB Cache, CHS=38792/16/63, UDMA(100)
Partition check:
  /dev/ide/host2/bus0/target0/lun0: [PTBL] [2434/255/63] p1 p2 < p5 > p3 p4

Thanks in advance,

O. Sezer

