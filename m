Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263370AbUBCDii (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 22:38:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263462AbUBCDii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 22:38:38 -0500
Received: from webhost1.sirion.net.au ([203.63.163.20]:26383 "EHLO
	webhost1.sirion.net.au") by vger.kernel.org with ESMTP
	id S263370AbUBCDig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 22:38:36 -0500
Mime-Version: 1.0 (Apple Message framework v612)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6FF5C83C-55FA-11D8-AC00-000A95CEEE4E@computeraddictions.com.au>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Ryan Verner <xfesty@computeraddictions.com.au>
Subject: Promise PDC20269 (Ultra133 TX2) + Software RAID
Date: Tue, 3 Feb 2004 14:08:31 +1030
To: LinuxSA ML <linuxsa@linuxsa.org.au>
X-Mailer: Apple Mail (2.612)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howdy,

I did an upgrade on a system the other day; we went from 2 * 8G drives 
in software RAID1, running off the motherboard's IDE chipset, to 2 * 
80G drives in software RAID1, running off a Promise Ultra133 TX2 card.

I upgraded the kernel at the same time to 2.4.24 w/ grsec patches.  The 
drives are detected fine:

PDC20269: IDE controller at PCI slot 00:0d.0
PCI: Found IRQ 10 for device 00:0d.0
PDC20269: chipset revision 2
PDC20269: not 100% native mode: will probe irqs later
PDC20269: ROM enabled at 0xe5000000
     ide2: BM-DMA at 0xe400-0xe407, BIOS settings: hde:pio, hdf:pio
     ide3: BM-DMA at 0xe408-0xe40f, BIOS settings: hdg:pio, hdh:pio
hde: WDC WD800JB-00ETA0, ATA DISK drive
blk: queue c01a2db8, I/O limit 4095Mb (mask 0xffffffff)
hdg: WDC WD800JB-00ETA0, ATA DISK drive
blk: queue c01a3224, I/O limit 4095Mb (mask 0xffffffff)
ide2 at 0xd400-0xd407,0xd802 on irq 10
ide3 at 0xdc00-0xdc07,0xe002 on irq 10
hde: attached ide-disk driver.
hde: host protected area => 1
hde: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=9729/255/63, 
UDMA(100)
hdg: attached ide-disk driver.
hdg: host protected area => 1
hdg: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=9729/255/63, 
UDMA(100)

However, we get these sorts of errors often:

hdg: dma_timer_expiry: dma status == 0x22
hdg: error waiting for DMA
hdg: dma timeout retry: status=0x58 { DriveReady SeekComplete 
DataRequest }
hdg: status timeout: status=0xd0 { Busy }
PDC202XX: Secondary channel reset.
hdg: drive not ready for command
ide3: reset: success

And the machine is randomly locking up, and of course, on reboot, the 
raid array is rebuilt.  Ouch.  Any clues as to why?  I'm sure the hard 
drive hasn't failed as it's brand new; I suspect a chipset 
compatibility problem or something.

R

--

Signature space for rent.

