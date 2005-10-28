Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965189AbVJ1JDW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965189AbVJ1JDW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 05:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965193AbVJ1JDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 05:03:22 -0400
Received: from math.ut.ee ([193.40.36.2]:7373 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S965189AbVJ1JDV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 05:03:21 -0400
Date: Fri, 28 Oct 2005 12:03:12 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: 2.6.14: aic7xxx broken with blktool
Message-ID: <Pine.SOC.4.61.0510281145420.27567@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using blktool to find info about installed disks. With Debian's 
2.6.8, "blktool /dev/sda id" worked fine. With 2.6.14 it's broken (see 
below). Adaptec 2940UW with a 4.5G Quantum Viking II disk.

It outputs random data from memory as a response to the scsi command, 
different recent strings different times.

Otherwise the disk works OK.

blktools is from Debian Sarge, package version 4-2, and works fine with 
2.6.8-2-686-smp kernel from Debian.

dmesg:

[...]
SCSI subsystem initialized
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:0f.0[A] -> Link [LNKB] -> GSI 11 (level, low) -> IRQ 11
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
         <Adaptec 2940 Ultra SCSI adapter>
         aic7880: Ultra Wide Channel A, SCSI Id=7, 16/253 SCBs

   Vendor: QUANTUM   Model: VIKING II 4.5WLS  Rev: 3506
   Type:   Direct-Access                      ANSI SCSI revision: 02
scsi0:A:6:0: Tagged Queuing enabled.  Depth 8
  target0:0:6: Beginning Domain Validation
  target0:0:6: wide asynchronous.
  target0:0:6: Domain Validation skipping write tests
  target0:0:6: FAST-10 WIDE SCSI 20.0 MB/s ST (100 ns, offset 8)
  target0:0:6: Ending Domain Validation
  target0:0:6: FAST-10 WIDE SCSI 20.0 MB/s ST (100 ns, offset 8)
SCSI device sda: 8910423 512-byte hdwr sectors (4562 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 8910423 512-byte hdwr sectors (4562 MB)
SCSI device sda: drive cache: write back
  sda: sda1 sda2 sda4 < sda5 sda6 >
Attached scsi disk sda at scsi0, channel 0, id 6, lun 0
[...]
(scsi0:A:6:0): No or incomplete CDB sent to device.
(scsi0:A:6:0): Protocol violation in Message-in phase.  Attempting to abort.
(scsi0:A:6:0): Abort Tag Message Sent
(scsi0:A:6:0): SCB 3 - Abort Tag Completed.
(scsi0:A:6:0): No or incomplete CDB sent to device.
(scsi0:A:6:0): Protocol violation in Message-in phase.  Attempting to abort.
(scsi0:A:6:0): Abort Tag Message Sent
(scsi0:A:6:0): SCB 2 - Abort Tag Completed.

-- 
Meelis Roos (mroos@linux.ee)
