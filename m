Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261517AbVFZSOR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261517AbVFZSOR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 14:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261534AbVFZSOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 14:14:17 -0400
Received: from mta8.srv.hcvlny.cv.net ([167.206.4.203]:8175 "EHLO
	mta8.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S261517AbVFZSOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 14:14:11 -0400
Date: Sun, 26 Jun 2005 14:14:09 -0400
From: Nick Orlov <bugfixer@list.ru>
Subject: 2.6.12-mm2: 3ware SATA RAID inaccessible
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Mail-followup-to: linux-kernel@vger.kernel.org, akpm@osdl.org
Message-id: <20050626181409.GA4561@nikolas.hn.org>
MIME-version: 1.0
Content-type: text/plain; charset=koi8-r
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

3Ware SATA RAID inaccessible with 2.6.12-mm2:

==================================================

Jun 26 11:49:51 nikolas kernel: 3ware Storage Controller device driver for Linux v1.26.02.001.
Jun 26 11:49:51 nikolas kernel: PCI: Found IRQ 9 for device 0000:00:0f.0
Jun 26 11:49:51 nikolas kernel: IRQ routing conflict for 0000:00:0f.0, have irq 5, want irq 9
Jun 26 11:49:51 nikolas kernel: scsi0 : 3ware Storage Controller
Jun 26 11:49:51 nikolas kernel: 3w-xxxx: scsi0: Found a 3ware Storage Controller at 0xa400, IRQ: 5.
Jun 26 11:49:51 nikolas kernel:   Vendor:           Model:                   Rev:     
Jun 26 11:49:51 nikolas kernel:   Type:   Direct-Access                      ANSI SCSI revision: 00
Jun 26 11:49:51 nikolas kernel: sda : sector size 0 reported, assuming 512.
Jun 26 11:49:51 nikolas kernel: SCSI device sda: 1 512-byte hdwr sectors (0 MB)
Jun 26 11:49:51 nikolas kernel: sda: asking for cache data failed
Jun 26 11:49:51 nikolas kernel: sda: assuming drive cache: write through
Jun 26 11:49:51 nikolas kernel: sda : sector size 0 reported, assuming 512.
Jun 26 11:49:51 nikolas kernel: SCSI device sda: 1 512-byte hdwr sectors (0 MB)
Jun 26 11:49:51 nikolas kernel: sda: asking for cache data failed
Jun 26 11:49:51 nikolas kernel: sda: assuming drive cache: write through
Jun 26 11:49:51 nikolas kernel:  sda: sda1 sda2 sda3
Jun 26 11:49:51 nikolas kernel: Attached scsi disk sda at scsi0, channel 0, id 0, lun 0

..........

Jun 26 11:49:51 nikolas kernel: ReiserFS: sda2: warning: sh-2006: read_super_block: bread failed (dev sda2, block 2, size 4096)
Jun 26 11:49:51 nikolas kernel: ReiserFS: sda2: warning: sh-2006: read_super_block: bread failed (dev sda2, block 16, size 4096)
Jun 26 11:49:51 nikolas kernel: ReiserFS: sda2: warning: sh-2021: reiserfs_fill_super: can not find reiserfs on sda2
Jun 26 11:49:51 nikolas kernel: ReiserFS: sda3: warning: sh-2006: read_super_block: bread failed (dev sda3, block 2, size 4096)
Jun 26 11:49:51 nikolas kernel: ReiserFS: sda3: warning: sh-2006: read_super_block: bread failed (dev sda3, block 16, size 4096)
Jun 26 11:49:51 nikolas kernel: ReiserFS: sda3: warning: sh-2021: reiserfs_fill_super: can not find reiserfs on sda3

==================================================


2.6.12-mm1 works just fine:

==================================================


Jun 26 11:59:07 nikolas kernel: 3ware Storage Controller device driver for Linux v1.26.02.001.
Jun 26 11:59:07 nikolas kernel: PCI: Found IRQ 9 for device 0000:00:0f.0
Jun 26 11:59:07 nikolas kernel: IRQ routing conflict for 0000:00:0f.0, have irq 5, want irq 9
Jun 26 11:59:07 nikolas kernel: scsi0 : 3ware Storage Controller
Jun 26 11:59:07 nikolas kernel: 3w-xxxx: scsi0: Found a 3ware Storage Controller at 0xa400, IRQ: 5.
Jun 26 11:59:07 nikolas kernel:   Vendor: 3ware     Model: Logical Disk 0    Rev: 1.2 
Jun 26 11:59:07 nikolas kernel:   Type:   Direct-Access                      ANSI SCSI revision: 00
Jun 26 11:59:07 nikolas kernel: SCSI device sda: 488395120 512-byte hdwr sectors (250058 MB)
Jun 26 11:59:07 nikolas kernel: SCSI device sda: drive cache: write back
Jun 26 11:59:07 nikolas kernel: SCSI device sda: 488395120 512-byte hdwr sectors (250058 MB)
Jun 26 11:59:07 nikolas kernel: SCSI device sda: drive cache: write back
Jun 26 11:59:07 nikolas kernel:  sda: sda1 sda2 sda3
Jun 26 11:59:07 nikolas kernel: Attached scsi disk sda at scsi0, channel 0, id 0, lun 0

..........


Jun 26 11:59:07 nikolas kernel: ReiserFS: sda2: found reiserfs format "3.6" with standard journal
Jun 26 11:59:07 nikolas kernel: ReiserFS: sda2: using ordered data mode
Jun 26 11:59:07 nikolas kernel: ReiserFS: sda2: journal params: device sda2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
Jun 26 11:59:07 nikolas kernel: ReiserFS: sda2: checking transaction log (sda2)
Jun 26 11:59:07 nikolas kernel: ReiserFS: sda2: Using r5 hash to sort names
Jun 26 11:59:07 nikolas kernel: ReiserFS: sda3: found reiserfs format "3.6" with standard journal
Jun 26 11:59:07 nikolas kernel: ReiserFS: sda3: using ordered data mode
Jun 26 11:59:07 nikolas kernel: ReiserFS: sda3: journal params: device sda3, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
Jun 26 11:59:07 nikolas kernel: ReiserFS: sda3: checking transaction log (sda3)
Jun 26 11:59:07 nikolas kernel: ReiserFS: sda3: Using r5 hash to sort names

==================================================

reverting git-scsi-block-fix.patch git-scsi-block.patch solves the
problem.


Also, please note that some of the info printed twice:

Jun 26 11:59:07 nikolas kernel: SCSI device sda: 488395120 512-byte hdwr
sectors (250058 MB)
Jun 26 11:59:07 nikolas kernel: SCSI device sda: drive cache: write back
Jun 26 11:59:07 nikolas kernel: SCSI device sda: 488395120 512-byte hdwr
sectors (250058 MB)
Jun 26 11:59:07 nikolas kernel: SCSI device sda: drive cache: write back

This glitch was introduced long time ago, somewhere after 2.6.9-mm1.
I have an archive of all the kernels I've built, so if it'll help I can do
a binary search among them to find when exactly it happend.

-- 
With best wishes,
	Nick Orlov.

