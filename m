Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267154AbSLaFPb>; Tue, 31 Dec 2002 00:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267155AbSLaFPb>; Tue, 31 Dec 2002 00:15:31 -0500
Received: from mta01ps.bigpond.com ([144.135.25.133]:33767 "EHLO
	mta01ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S267154AbSLaFPa>; Tue, 31 Dec 2002 00:15:30 -0500
Message-ID: <3E1129F8.4000700@csse.uwa.edu.au>
Date: Tue, 31 Dec 2002 13:24:08 +0800
From: David Glance <david@csse.uwa.edu.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM:  2.4.20 on ICH4 : ide-cdrom/ide-scsi problems reading cds
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please cc me directly as I am not subscribed to the list.

I am getting problems (intermittent) trying to play audio CDs using 
2.4.20 with an ICH4 controller (although I don't know if the ICH4 is 
relevant) - the problem is intermittent and I can eventually play the CD 
by ejecting and loading the CD a couple of times. The problem below is 
with the ide-cdrom module but it is exacerbated when I use ide-scsi instead.

I have tried this with 2 different CD RW drives (I went and bought a new 
drive to check that the error was not with the old HP.
I also have applied the latest ACPI patch (to get this machine to power 
off correctly) - but I have tested without the patch and I still get the 
same problem.

Any help would be appreciated. Let me know if you need any further 
information.

 >From /var/log/messages:

Dec 30 14:33:42 bart kernel: hdc: ATAPI 48X CD-ROM CD-R/RW drive, 2048kB 
Cache, UDMA(33)
Dec 30 14:33:42 bart kernel: Uniform CD-ROM driver Revision: 3.12
<-- snip -->
Dec 30 14:41:28 bart kernel: ATAPI device hdc:
Dec 30 14:41:28 bart kernel:   Error: Illegal request -- (Sense key=0x05)
Dec 30 14:41:28 bart kernel:   Logical block address out of range -- 
(asc=0x21, ascq=0x00)
Dec 30 14:41:28 bart kernel:   The failed "Play Audio MSF" packet 
command was:
Dec 30 14:41:28 bart kernel:   "47 00 00 00 02 20 27 0f 28 00 00 00 "
<-- snip -->
Dec 30 14:49:03 bart kernel: hdc: command error: status=0x51 { 
DriveReady SeekComplete Error }
Dec 30 14:49:03 bart kernel: hdc: command error: error=0x50



Boot information:

Dec 30 14:31:53 bart kernel: Uniform Multi-Platform E-IDE driver 
Revision: 6.31
Dec 30 14:31:53 bart kernel: ide: Assuming 33MHz system bus speed for 
PIO modes; override with idebus=xx
Dec 30 14:31:53 bart kernel: ICH4: IDE controller on PCI bus 00 dev f9
Dec 30 14:31:53 bart kernel: PCI: Device 00:1f.1 not available because 
of resource collisions
Dec 30 14:31:53 bart kernel: ICH4: BIOS setup was incomplete.
Dec 30 14:31:53 bart kernel: ICH4: chipset revision 1
Dec 30 14:31:53 bart kernel: ICH4: not 100%% native mode: will probe 
irqs later
Dec 30 14:31:53 bart kernel:     ide0: BM-DMA at 0xffa0-0xffa7, BIOS 
settings: hda:DMA, hdb:pio
Dec 30 14:31:53 bart kernel:     ide1: BM-DMA at 0xffa8-0xffaf, BIOS 
settings: hdc:DMA, hdd:pio
Dec 30 14:31:53 bart kernel: hda: MAXTOR 6L080J4, ATA DISK drive
Dec 30 14:31:53 bart kernel: hdc: MSI CD-RW MS-8348, ATAPI CD/DVD-ROM drive
Dec 30 14:31:53 bart kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Dec 30 14:31:53 bart kernel: ide1 at 0x170-0x177,0x376 on irq 15



