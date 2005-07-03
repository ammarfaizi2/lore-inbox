Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbVGCJ4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbVGCJ4J (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 05:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbVGCJ4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 05:56:09 -0400
Received: from unknown.ghostnet.de ([217.69.161.74]:59624 "EHLO nexave.de")
	by vger.kernel.org with ESMTP id S261236AbVGCJ4E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 05:56:04 -0400
Message-ID: <42C7B5F0.40003@cyberoptic.de>
Date: Sun, 03 Jul 2005 11:54:56 +0200
From: CyberOptic <mail@cyberoptic.de>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ppa / kernel 2.6.12.2 / fsck results in kernel error
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan *1Dp1Cf-00089q-00*D.LgJfeJ/xQ*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this error (see blow) occours, if I "fsck -c" (bad cluster test) a
medium in my parallel IOmega ZIP-Drive 100MB.

A complete dd from /dev/zero to the device works like a charm.

- fsck 1.37 (21-Mar-2005)
- e2fsck 1.37 (21-Mar-2005)
- Linux second 2.6.12.2 #7 Sun Jul 3 01:49:46 CEST 2005 i686 GNU/Linux


Regards - Sebastian


---dmesg---
ppa: Version 2.07 (for Linux 2.4.x)
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7, dma 3
[PCSPP,TRISTATE,COMPAT,ECP,DMA]
ppa: Found device at ID 6, Attempting to use EPP 16 bit
ppa: Found device at ID 6, Attempting to use PS/2
ppa: Communication established with ID 6 using PS/2
scsi0 : Iomega VPI0 (ppa) interface
Vendor: IOMEGA    Model: ZIP 100           Rev: D.13
Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sda: 196608 512-byte hdwr sectors (101 MB)
sda: Write Protect is off
sda: Mode Sense: 25 00 00 08
sda: cache data unavailable
sda: assuming drive cache: write through
SCSI device sda: 196608 512-byte hdwr sectors (101 MB)
sda: Write Protect is off
sda: Mode Sense: 25 00 00 08
sda: cache data unavailable
sda: assuming drive cache: write through
sda: sda1
Attached scsi removable disk sda at scsi0, channel 0, id 6, lun 0
Unable to handle kernel NULL pointer dereference at virtual address 00000000
printing eip:
f8875396
*pde = 00000000
Oops: 0002 [#1]
Modules linked in: parport_pc ppa parport 8250 serial_core sd_mod
scsi_mod eeprom i2c_sensor i2c_isa i2c_viapro i2c_core loop
CPU:    0
EIP:    0060:[<f8875396>]    Not tainted VLI
EFLAGS: 00010202   (2.6.12.2)
EIP is at ppa_byte_in+0x26/0x40 [ppa]
eax: 00000200   ebx: 00000200   ecx: 0000037a   edx: 00000378
esi: 00000001   edi: 00000378   ebp: 00000000   esp: c1923e8c
ds: 007b   es: 007b   ss: 0068
Process events/0 (pid: 3, threadinfo=c1922000 task=c18d6020)
Stack: 0000037a 00000379 00000000 00000378 f88756ea 00000378 00000000
00000200
c043cdb0 00000200 00000379 f76ca1a0 f76cdce0 f8875a61 f76cdce0 00000000
00000200 f76ca1d0 f76cdce0 f8875561 00000378 00000001 fffd47cc c18d6020
Call Trace:
[<f88756ea>] ppa_in+0x17a/0x190 [ppa]
[<f8875a61>] ppa_completion+0x151/0x250 [ppa]
[<f8875561>] ppa_out+0x151/0x160 [ppa]
[<f8875ea9>] ppa_engine+0x2a9/0x3f0 [ppa]
[<f8875b60>] ppa_interrupt+0x0/0xa0 [ppa]
[<f8875b82>] ppa_interrupt+0x22/0xa0 [ppa]
[<c012b81d>] worker_thread+0x1ad/0x250
[<c0119bc0>] default_wake_function+0x0/0x20
[<c0119bc0>] default_wake_function+0x0/0x20
[<c012b670>] worker_thread+0x0/0x250
[<c012f78a>] kthread+0xaa/0xb0
[<c012f6e0>] kthread+0x0/0xb0
[<c010132d>] kernel_thread_helper+0x5/0x18
Code: 90 8d 74 26 00 55 57 56 53 8b 5c 24 1c 8b 74 24 18 0f b7 7c 24 14
85 db 74 1f 8d 4f 02 90 8d b4 26 00 00 00 00 89 f5 89 fa 46 ec <88> 45
00 89 ca b0 27 ee b0 25 ee 4b 75 ec 5b b8 01 00 00 00 5e
<6>parport0: ppa already owner
parport0: ppa already owner
scsi: Device offlined - not ready after error recovery: host 0 channel 0
id 6 lun 0
SCSI error : <0 0 6 0> return code = 0x70000
end_request: I/O error, dev sda, sector 32
Buffer I/O error on device sda1, logical block 0
Buffer I/O error on device sda1, logical block 1
Buffer I/O error on device sda1, logical block 2
Buffer I/O error on device sda1, logical block 3
Buffer I/O error on device sda1, logical block 4
Buffer I/O error on device sda1, logical block 5
Buffer I/O error on device sda1, logical block 6
Buffer I/O error on device sda1, logical block 7
Buffer I/O error on device sda1, logical block 8
Buffer I/O error on device sda1, logical block 9
printk: 13698 messages suppressed.
Buffer I/O error on device sda1, logical block 3043
scsi0 (6:0): rejecting I/O to offline device
[...repeats some thousand times...]
---/dmesg---


