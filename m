Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbUB0Kwb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 05:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbUB0Kwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 05:52:31 -0500
Received: from c10053.upc-c.chello.nl ([212.187.10.53]:6540 "EHLO
	smurver.fakenet") by vger.kernel.org with ESMTP id S261785AbUB0Kw1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 05:52:27 -0500
Message-ID: <403F2178.70806@vanE.nl>
Date: Fri, 27 Feb 2004 11:52:40 +0100
From: Erik van Engelen <Info@vanE.nl>
User-Agent: Mozilla Thunderbird 0.5b (Windows/20040201)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Errors on 2th ide channel of promise ultra100 tx2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've got a Proliant 2500 running a 2.4.25 kernel. It has 2 pentium pro 
CPUs and a smart-2/E disk array on EISA bus from which it boots.

I added a promise ultra100 tx2 ide cart and put on 3 disks. During boot 
i get a couple of errors but everything seems to work ok. When 
read/write to a disk on the first ide-channel everything is ok. When i 
read/write to a disk on the second ide-channel everything is ok. But 
when i try to read/write to both disks at once i get these errors:

hdh: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdh: status error: status=0x58 { DriveReady SeekComplete DataRequest }

I read somewhere it helps to add a line in the lilo.conf. I also tried 
that but it doesn't make any diffents. This is the lilo.conf line:
append="mem=128M smart2=0x4000 ide2=serialize  ide3=serialize"

The next thing i tried is to boot from a 2.6.3 kernel but that one ends 
up in a big kernel panic. When i leave out the smart2 (cpqarray) driver 
it boot up to the point where it needs a disk to boot from which isn't 
there naturally.

Can anyone help me with this problem? I like to stay on the 2.4 kernel 
because i want to run debian stable but if thats impossible i want to 
work on the 2.6. If you need any informatie or if i have to run some 
tests on the machine just ask. It is here opend up on the floor and i've 
got my screwdriver ready.

THX...
Erik van Engelen.

This is a part of my 2.4.25 boot messages.
PDC20268: IDE controller at PCI slot 01:0a.0
PDC20268: chipset revision 2
PDC20268: not 100% native mode: will probe irqs later
     ide2: BM-DMA at 0x6410-0x6417, BIOS settings: hde:pio, hdf:pio
     ide3: BM-DMA at 0x6418-0x641f, BIOS settings: hdg:pio, hdh:pio
hda: CD-ROM CDU571-Q, ATAPI CD/DVD-ROM drive
hde: Conner Peripherals 1275MB - CFS1275A, ATA DISK drive
hdg: WDC AC2850F, ATA DISK drive
hdh: QUANTUM FIREBALL1080A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide2 at 0x6420-0x6427,0x6432 on irq 9
ide3 at 0x6428-0x642f,0x643a on irq 9
hde: attached ide-disk driver.
hde: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hde: task_no_data_intr: error=0x04 { DriveStatusError }
hde: 2496876 sectors (1278 MB) w/64KiB Cache, CHS=2477/16/63
hdg: attached ide-disk driver.
hdg: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hdg: task_no_data_intr: error=0x04 { DriveStatusError }
hdg: 1667232 sectors (854 MB) w/64KiB Cache, CHS=1654/16/63
hdh: attached ide-disk driver.
hdh: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hdh: task_no_data_intr: error=0x04 { DriveStatusError }
hdh: 2128896 sectors (1090 MB) w/83KiB Cache, CHS=2112/16/63

