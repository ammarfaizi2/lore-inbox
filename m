Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964931AbWHHOS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964931AbWHHOS5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 10:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964910AbWHHOSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 10:18:55 -0400
Received: from elvis.nosignal.org ([85.234.132.110]:61635 "EHLO
	elvis.nosignal.org") by vger.kernel.org with ESMTP id S964907AbWHHOSy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 10:18:54 -0400
Message-ID: <44D89D5D.1000808@nosignal.org>
Date: Tue, 08 Aug 2006 15:19:09 +0100
From: Andy Davidson <andy@nosignal.org>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 194.73.16.246
X-SA-Exim-Mail-From: andy@nosignal.org
Subject: 3ware 9550 using 3w-9xxx driver lockups ?
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on elvis.nosignal.org)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi,

One of our servers locked up (no kernel panic, but no response to 
console/network) with the following output on console :

Aug  8 14:10:34 how-mail-1 kernel: 3w-9xxx: scsi0: AEN: WARNING 
(0x04:0x0023): Sector repair completed:port=1,LBA=0x4383A7F.
Aug  8 14:10:39 how-mail-1 kernel: 3w-9xxx: scsi0: AEN: WARNING 
(0x04:0x0023): Sector repair completed:port=1,LBA=0x438C4D9.
Aug  8 14:10:41 how-mail-1 kernel: 3w-9xxx: scsi0: AEN: WARNING 
(0x04:0x0023): Sector repair completed:port=1,LBA=0x438C4DC.
Aug  8 14:10:47 how-mail-1 kernel: 3w-9xxx: scsi0: AEN: WARNING 
(0x04:0x0023): Sector repair completed:port=1,LBA=0x438FB34.
Aug  8 14:10:49 how-mail-1 kernel: 3w-9xxx: scsi0: AEN: WARNING 
(0x04:0x0023): Sector repair completed:port=1,LBA=0x438FB36.
Aug  8 14:10:52 how-mail-1 kernel: 3w-9xxx: scsi0: AEN: WARNING 
(0x04:0x0023): Sector repair completed:port=1,LBA=0x439051D.
Aug  8 14:11:08 how-mail-1 kernel: 3w-9xxx: scsi0: AEN: WARNING 
(0x04:0x0023): Sector repair completed:port=1,LBA=0x4378D8A.

I'd put this down to bad hardware until an identically spec'd machine 
(with fresh disks) did the same thing.


Anyone else noticed any issues using the newer 3-ware 9550S cards with 
the 3w-9xxx driver ?


Other details :
Linux how-mail-1 2.6.16-2-686-smp #1 SMP Sat Jul 15 22:33:00 UTC 2006 i686

from lspci:
03:03.0 RAID bus controller: 3ware Inc 9550SX SATA-RAID


3ware 9000 Storage Controller device driver for Linux v2.26.02.007.
ACPI: PCI Interrupt 0000:03:03.0[A] -> GSI 24 (level, low) -> IRQ 177
scsi0 : 3ware 9000 Storage Controller
3w-9xxx: scsi0: Found a 3ware 9000 Storage Controller at 0xda300000, 
IRQ: 177.
3w-9xxx: scsi0: Firmware FE9X 3.01.01.028, BIOS BE9X 3.01.00.024, Ports: 
4. Vendor: AMCC      Model: 9550SX-4LP DISK
Rev: 3.01 Type:   Direct-Access                      ANSI SCSI revision: 03f


We'd welcome any help ?

Thanks,
Andy
