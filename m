Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271333AbTG2Ipf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 04:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271335AbTG2Ipf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 04:45:35 -0400
Received: from web20504.mail.yahoo.com ([216.136.226.139]:2451 "HELO
	web20504.mail.yahoo.com") by vger.kernel.org with SMTP
	id S271333AbTG2IpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 04:45:09 -0400
Message-ID: <20030729084507.93265.qmail@web20504.mail.yahoo.com>
Date: Tue, 29 Jul 2003 01:45:07 -0700 (PDT)
From: Studying MTD <studying_mtd@yahoo.com>
Subject: kobject_register failed for hda1 in linux-2.6.0-test1
To: linux-kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello all,

I am using linux-2.6.0-test1 on SH7750 with SanDisk 64
MB as my root, but i am getting following messages :-

Linux Kernel Card Services 3.1.22
  options:  none
pty: 256 Unix98 ptys configured
SuperH SCI(F) driver initialized
ttySC0 at 0xffe00000 is a SCI
ttySC1 at 0xffe80000 is a SCIF
Uniform Multi-Platform E-IDE driver Revision:
7.00alpha2
ide: Assuming 50MHz system bus speed for PIO modes;
override with idebus=xx
hda: SanDisk SDCFB-64, CFA DISK drive
anticipatory scheduling elevator
ide0 at 0x1f0-0x1f7,0x3f6 on irq 7
hda: max request size: 128KiB
hda: task_no_data_intr: status=0x51 { DriveReady
SeekComplete Error }
hda: task_no_data_intr: error=0x04 { DriveStatusError
}
hda: 125440 sectors (64 MB) w/1KiB Cache, CHS=490/8/32
 hda: hda1
 hda: hda1
kobject_register failed for hda1 (-17)

Call trace:

[<8c08cc90>] kobject_register+0x50/0x80
[<8c07afc0>] add_partition+0x0/0xc0
[<8c07b1e6>] register_disk+0x106/0x140
[<8c0a7af2>] add_disk+0x32/0x60
[<8c014fe0>] printk+0x0/0x1e0
[<8c0bcdb2>] idedisk_attach+0x112/0x1e0
[<8c0b81ea>] ata_attach+0xaa/0x1c0
[<8c0b8140>] ata_attach+0x0/0x1c0
[<8c0b9524>] ide_register_driver+0xa4/0xe0
[<8c014fe0>] printk+0x0/0x1e0
[<8c014fe0>] printk+0x0/0x1e0
[<8c0020b8>] init+0x18/0x180
[<8c004284>] kernel_thread_helper+0x4/0x20

Intel PCIC probe: not found.
 hda: hda1
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 40k freed


Please let me know , why i am getting these errors :-
1.hda: task_no_data_intr: status=0x51 { DriveReady
SeekComplete Error }
2. hda: task_no_data_intr: error=0x04 {
DriveStatusError }
3. kobject_register failed for hda1 (-17)

how can i get rid of these error messages.

Thanks.


__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com
