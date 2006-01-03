Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932323AbWACOcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbWACOcO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 09:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751437AbWACOcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 09:32:14 -0500
Received: from tower.bj-ig.de ([194.127.182.2]:16097 "EHLO fs.bj-ig.de")
	by vger.kernel.org with ESMTP id S1751435AbWACOcM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 09:32:12 -0500
Message-ID: <43BA8AEE.8010608@bj-ig.de>
Date: Tue, 03 Jan 2006 15:32:14 +0100
From: =?ISO-8859-15?Q?Ralf_M=FCller?= <ralf@bj-ig.de>
User-Agent: Mozilla Thunderbird 1.0.7 (Macintosh/20050923)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: jgarzik@pobox.com, linux-ide@vger.kernel.org
Subject: Kernel Oops with 2.6.15
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Delivered-For: jgarzik@pobox.com
X-Spambayes-Classification: ham; 0.07
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel oops reported for 2.6.15-rc7 when calling hddtemp on a sata 
drive which is in standby mode is still present in 2.6.15. Maybe someone 
is interested.

Regards
Ralf

Jan  3 15:21:35 DatenGrab kernel: ata1: unknown timeout, cmd 0xb0 stat 0xff
Jan  3 15:21:35 DatenGrab kernel: ata1: translated ATA stat/err 0xff/00 
to SCSI SK/ASC/ASCQ 0xb/47/00
Jan  3 15:21:35 DatenGrab kernel: ata1: status=0xff { Busy }
Jan  3 15:21:35 DatenGrab kernel: Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_block,line=3216
Jan  3 15:21:35 DatenGrab kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 00000014
Jan  3 15:21:35 DatenGrab kernel:  printing eip:
Jan  3 15:21:35 DatenGrab kernel: e02d9a3e
Jan  3 15:21:35 DatenGrab kernel: *pde = 00000000
Jan  3 15:21:35 DatenGrab kernel: Oops: 0000 [#1]
Jan  3 15:21:35 DatenGrab kernel: Modules linked in: edd ipv6 nfsd 
w83627hf hwmon_vid hwmon eeprom i2c_isa button battery ac af_packet xfs 
exportfs reiserfs ohci1394 ieee1394 sk98lin i2c_i801 i2c_core generic 
i8xx_tco shpchp pci_hotplug uhci_hcd intel_agp agpgart raid5 xor 
parport_pc lp parport sata_promise libata dm_mod sg skge ohci_hcd 
ehci_hcd usb_storage usbcore fan thermal processor piix sd_mod scsi_mod 
ide_disk ide_core
Jan  3 15:21:35 DatenGrab kernel: CPU:    0
Jan  3 15:21:35 DatenGrab kernel: EIP:    0060:[<e02d9a3e>]    Not 
tainted VLI
Jan  3 15:21:35 DatenGrab kernel: EFLAGS: 00010292   (2.6.15-default)
Jan  3 15:21:35 DatenGrab kernel: EIP is at ata_pio_block+0xb9/0xfd [libata]
Jan  3 15:21:35 DatenGrab kernel: eax: 00000056   ebx: c14d6284   ecx: 
00000000   edx: 00000000
Jan  3 15:21:35 DatenGrab kernel: esi: 55b17c50   edi: 00000000   ebp: 
c14d6284   esp: def3df70
Jan  3 15:21:35 DatenGrab kernel: ds: 007b   es: 007b   ss: 0068
Jan  3 15:21:35 DatenGrab kernel: Process ata/0 (pid: 2179, 
threadinfo=def3c000 task=deefc580)
Jan  3 15:21:35 DatenGrab kernel: Stack: c14d6284 deefb3c0 00000287 
e02d9b00 c14d683c c01230b6 e02d9ae3 00000001
Jan  3 15:21:35 DatenGrab kernel:        00000000 00000000 00010000 
00000000 00000000 deefc580 c01150bc 00100100
Jan  3 15:21:35 DatenGrab kernel:        00200200 ffffffff ffffffff 
def3c000 de189f54 deefb3c0 c0122f77 c0125c9f
Jan  3 15:21:35 DatenGrab kernel: Call Trace:
Jan  3 15:21:35 DatenGrab kernel:  [<e02d9b00>] ata_pio_task+0x1d/0x54 
[libata]
Jan  3 15:21:35 DatenGrab kernel:  [<c01230b6>] worker_thread+0x13f/0x19d
Jan  3 15:21:35 DatenGrab kernel:  [<e02d9ae3>] ata_pio_task+0x0/0x54 
[libata]
Jan  3 15:21:35 DatenGrab kernel:  [<c01150bc>] 
default_wake_function+0x0/0xc
Jan  3 15:21:35 DatenGrab kernel:  [<c0122f77>] worker_thread+0x0/0x19d
Jan  3 15:21:35 DatenGrab kernel:  [<c0125c9f>] kthread+0x63/0x8f
Jan  3 15:21:35 DatenGrab kernel:  [<c0125c3c>] kthread+0x0/0x8f
Jan  3 15:21:35 DatenGrab kernel:  [<c0101281>] kernel_thread_helper+0x5/0xb
Jan  3 15:21:35 DatenGrab kernel: Code: 89 df 81 c7 d4 04 00 00 75 21 68 
90 0c 00 00 68 fb cd 2d e0 68 ef cf 2d e0 68 b0 d5 2d e0 68 61 d0 2d e0 
e8 19 e1 e3 df 83 c4 14 <8a> 47 14 83 e8 05 3c 02 77 1b 83 e6 08 75 0c 
c7 83 e4 05 00 00

