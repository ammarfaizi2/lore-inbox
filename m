Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268324AbUHFV67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268324AbUHFV67 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 17:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268314AbUHFV67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 17:58:59 -0400
Received: from s124.mittwaldmedien.de ([62.216.178.24]:40091 "EHLO
	s124.mittwaldmedien.de") by vger.kernel.org with ESMTP
	id S268324AbUHFV6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 17:58:40 -0400
Message-ID: <4113FF09.6050806@vcd-berlin.de>
Date: Fri, 06 Aug 2004 23:58:33 +0200
From: Elmar Hinz <elmar.hinz@vcd-berlin.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: Add support for IT8212 IDE controllers
References: <2obsK-5Ni-13@gated-at.bofh.it> <4110ECBF.9070000@vcd-berlin.de> <20040805104700.GB11584@devserv.devel.redhat.com>
In-Reply-To: <20040805104700.GB11584@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Wed, Aug 04, 2004 at 04:03:43PM +0200, Elmar Hinz wrote:
> 
>>When I set in the bios RAID 1 there comes an message similar
>>INVALID GEOMETRY: 0 PHYSICAL HEADS?
>>and booting stops.
> 
> 
> At which point
> 
> 
>>but booting continous and I can use the disks.
>>hdparm => 15.70 MB/sec
> 
> 
> A bit slow.. thanks
> 
> 

I am sorry. I can't test the card in the RAID mode anymore, because it
is in use meanwhile with NORMAL mode an a software raid. Maybe the
output of dmesg in NORMAL mode is usefull for you.


Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
IT8212: IDE controller at PCI slot 0000:00:09.0
PCI: Found IRQ 10 for device 0000:00:09.0
PCI: Sharing IRQ 10 with 0000:00:01.2

(Changing the slots IRQ by bios alters both devices 0000:00:01.2 and 
0000:00:09.0, so they seem to belong both to the card/disks)

IT8212: chipset revision 17
IT8212: 100% native mode on irq 10
     ide2: BM-DMA at 0xb000-0xb007, BIOS settings: hde:DMA, hdf:pio
it8212: controller in smart mode.
it8212: BIOS seleted a 66MHz clock.
     ide3: BM-DMA at 0xb008-0xb00f, BIOS settings: hdg:DMA, hdh:pio
it8212: BIOS seleted a 66MHz clock.
hde: WDC WD800JB-00FMA0, ATA DISK drive
ide2 at 0xd400-0xd407,0xd002 on irq 10
hdg: WDC WD800JB-00FMA0, ATA DISK drive
ide3 at 0xb800-0xb807,0xb402 on irq 10
hdc: ATAPI CDROM, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hde: max request size: 128KiB
hde: recal_intr: status=0x51 { DriveReady SeekComplete Error }
hde: recal_intr: error=0x04 { DriveStatusError }
hde: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=65535/16/63, UDMA(33)
hde: irq timeout: status=0xd0 { Busy }

  /dev/ide/host2/bus0/target0/lun0: p1 < p5 p6 p7 p8 >
hdg: max request size: 128KiB
hdg: recal_intr: status=0x51 { DriveReady SeekComplete Error }
hdg: recal_intr: error=0x04 { DriveStatusError }
hdg: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=65535/16/63, UDMA(33)
hdg: irq timeout: status=0xd0 { Busy }

  /dev/ide/host2/bus1/target0/lun0: p1 < p5 p6 p7 p8 >
