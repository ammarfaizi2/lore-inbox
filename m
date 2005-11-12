Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964813AbVKLVho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964813AbVKLVho (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 16:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964816AbVKLVho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 16:37:44 -0500
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:32185 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S964813AbVKLVhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 16:37:43 -0500
Date: Sat, 12 Nov 2005 22:37:31 +0100 (CET)
From: Morten Hulden <morten@untamo.net>
To: linux-kernel@vger.kernel.org
Subject: Total freeze with FC4 2.6.1[34]smp [FC4/IBM/ATI]
Message-ID: <Pine.LNX.4.61.0511122225170.6088@htorp2.untamo.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Don't know if this belongs here or some FC4 or ATI list. This /total/ 
freeze has haunted me since 2.6.13:

startx or system-config-display on IBM 84823SG (Internal Radeon 7000M 
graphics subsystem) causes hard freeze with kernel-2.13-1.1532_FC4smp and 
2.6.14-1.1637_FCsmp. No consoles, no network (open ssh connections 
freezing too), no nothing. Uniprocessor kernel is OK.

Please advice if I should provide more info or go whining somewhere else.

Morten

---
This is from 2.6.14-1.1637_FCsmp:

Nov 12 21:54:07 kalahari kernel: [drm] Initialized drm 1.0.0 20040925
Nov 12 21:54:07 kalahari kernel: ACPI: PCI Interrupt 0000:04:02.0[A] -> GSI 16 (level, low) -> IRQ 185
Nov 12 21:54:07 kalahari kernel: [drm] Initialized radeon 1.17.0 20050311 on minor 0: 
Nov 12 21:54:07 kalahari kernel: mtrr: 0xe0000000,0x10000000 overlaps existing 0xe0000000,0x1000000
Nov 12 21:54:12 kalahari kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000001
Nov 12 21:54:12 kalahari kernel:  printing eip:
Nov 12 21:54:12 kalahari kernel: c016f480
Nov 12 21:54:12 kalahari kernel: *pde = 37998001
Nov 12 21:54:12 kalahari kernel: Oops: 0002 [#1]
Nov 12 21:54:12 kalahari kernel: SMP 
Nov 12 21:54:12 kalahari kernel: Modules linked in: radeon drm ipv6 autofs4 dm_mod video button battery ac uhci_hcd ehci_hcd shpchp i6300esb i2c_i801 i2c_core e1000 floppy ext3 jbd raid1 ata_piix libata sd_mod scsi_mod
Nov 12 21:54:12 kalahari kernel: CPU:    0
Nov 12 21:54:12 kalahari kernel: EIP:    0060:[<c016f480>]    Not tainted VLI
Nov 12 21:54:12 kalahari kernel: EFLAGS: 00010217   (2.6.14-1.1637_FC4smp) 
Nov 12 21:54:12 kalahari kernel: EIP is at pipe_writev+0x3b/0x521
Nov 12 21:54:12 kalahari kernel: eax: c23b0f7c   ebx: 00000004   ecx: 00000001   edx: 00000001
Nov 12 21:54:12 kalahari kernel: esi: 00000004   edi: bfa36008   ebp: c016f966   esp: c23b0f24
Nov 12 21:54:12 kalahari kernel: ds: 007b   es: 007b   ss: 0068
Nov 12 21:54:12 kalahari kernel: Process automount (pid: 1856, threadinfo=c23b0000 task=c23f7570)
Nov 12 21:54:12 kalahari kernel: Stack: 00000000 00000000 c23b0f7c f7d29880 f72b9e00 f6e6bc00 c23f7570 c23f7574 
Nov 12 21:54:12 kalahari kernel:        f6e6bc00 f6e6bc00 00000004 00000002 c0142f6f 00000246 f7ea900c 40000003 
Nov 12 21:54:12 kalahari kernel:        f7d29880 00000004 bfa36008 c016f966 c016f986 c23b0fa4 bfa36074 00000004 
Nov 12 21:54:12 kalahari kernel: Call Trace:
Nov 12 21:54:12 kalahari kernel:  [<c0142f6f>] audit_syscall_entry+0x131/0x15f
Nov 12 21:54:12 kalahari kernel:  [<c016f966>] pipe_write+0x0/0x24
Nov 12 21:54:12 kalahari kernel:  [<c016f986>] pipe_write+0x20/0x24
Nov 12 21:54:12 kalahari kernel:  [<c016398f>] vfs_write+0xa2/0x15a
Nov 12 21:54:12 kalahari kernel:  [<c0163af2>] sys_write+0x41/0x6a
Nov 12 21:54:12 kalahari kernel:  [<c01039e1>] syscall_call+0x7/0xb
Nov 12 21:54:12 kalahari kernel: Code: 40 08 8b 40 18 89 44 24 10 85 c9 0f 84 4e 02 00 00 8b 44 24 08 31 d2 00 00 00 00 00 00 00 00 8b 58 04 01 5c 24 1c 83 c2 01 00 00 <08> 39 d1 75 ef 8b 54 24 1c 85 d2 0f 84 23 00 00 00 ba 66 00 00 
Nov 12 21:54:12 kalahari kernel:  <0>Fatal exception: panic in 5 seconds
Nov 12 21:54:16 kalahari kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000001
Nov 12 21:54:16 kalahari kernel:  printing eip:
Nov 12 21:54:16 kalahari kernel: c016f480
Nov 12 21:54:16 kalahari kernel: *pde = 37ef9001
Nov 12 21:54:16 kalahari kernel: Oops: 0002 [#2]
Nov 12 21:54:16 kalahari kernel: SMP 
Nov 12 21:54:16 kalahari kernel: Modules linked in: radeon drm ipv6 autofs4 dm_mod video button battery ac uhci_hcd ehci_hcd shpchp i6300esb i2c_i801 i2c_core e1000 floppy ext3 jbd raid1 ata_piix libata sd_mod scsi_mod
Nov 12 21:54:16 kalahari kernel: CPU:    0
Nov 12 21:54:16 kalahari kernel: EIP:    0060:[<c016f480>]    Not tainted VLI
Nov 12 21:54:16 kalahari kernel: EFLAGS: 00010217   (2.6.14-1.1637_FC4smp) 
Nov 12 21:54:16 kalahari kernel: EIP is at pipe_writev+0x3b/0x521
Nov 12 21:54:16 kalahari kernel: eax: f7d65f7c   ebx: 00000004   ecx: 00000001   edx: 00000001
Nov 12 21:54:16 kalahari kernel: esi: 00000004   edi: bfa57ea8   ebp: c016f966   esp: f7d65f24
Nov 12 21:54:16 kalahari kernel: ds: 007b   es: 007b   ss: 0068
Nov 12 21:54:16 kalahari kernel: Process automount (pid: 1830, threadinfo=f7d65000 task=f798a030)
Nov 12 21:54:16 kalahari kernel: Stack: 00000000 00000000 f7d65f7c f7b4a780 f6e3ac48 f7917400 f798a030 f798a034 
Nov 12 21:54:16 kalahari kernel:        f7917400 f7917400 00000004 00000002 c0142f6f 00000246 f315e00c 40000003 
Nov 12 21:54:16 kalahari kernel:        f7b4a780 00000004 bfa57ea8 c016f966 c016f986 f7d65fa4 bfa57e14 00000004 
Nov 12 21:54:16 kalahari kernel: Call Trace:
Nov 12 21:54:16 kalahari kernel:  [<c0142f6f>] audit_syscall_entry+0x131/0x15f
Nov 12 21:54:16 kalahari kernel:  [<c016f966>] pipe_write+0x0/0x24
Nov 12 21:54:16 kalahari kernel:  [<c016f986>] pipe_write+0x20/0x24
Nov 12 21:54:16 kalahari kernel:  [<c016398f>] vfs_write+0xa2/0x15a
Nov 12 21:54:16 kalahari kernel:  [<c0163af2>] sys_write+0x41/0x6a
Nov 12 21:54:16 kalahari kernel:  [<c01039e1>] syscall_call+0x7/0xb
Nov 12 21:54:16 kalahari kernel: Code: 40 08 8b 40 18 89 44 24 10 85 c9 0f 84 4e 02 00 00 8b 44 24 08 31 d2 00 00 00 00 00 00 00 00 8b 58 04 01 5c 24 1c 83 c2 01 00 00 <08> 39 d1 75 ef 8b 54 24 1c 85 d2 0f 84 23 00 00 00 ba 66 00 00 
Nov 12 21:54:16 kalahari kernel:  <0>Fatal exception: panic in 5 seconds
