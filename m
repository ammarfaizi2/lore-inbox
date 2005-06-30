Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261177AbVF3NA2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbVF3NA2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 09:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262705AbVF3NA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 09:00:28 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:3754 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S261177AbVF3NAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 09:00:19 -0400
Message-ID: <42C3ECDE.2080102@myrealbox.com>
Date: Thu, 30 Jun 2005 06:00:14 -0700
From: walt <wa1ter@myrealbox.com>
Organization: none
User-Agent: Mail/News Client 1.0+ (X11/20050629)
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [2.13-rc1.git] Oops during boot
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Something checked in by Linus in the last 24 hours is causing an oops 
during boot.
(Yesterday's 2.13-rc1 boots normally.)  This is copied from dmesg -- let 
me know
if you need more information:

<snippage>
usbcore: registered new driver hub
Unable to handle kernel paging request at virtual address 10000008
  printing eip:
c024cbd8
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in: usbcore
CPU:    0
EIP:    0060:[<c024cbd8>]    Not tainted VLI
EFLAGS: 00010202   (2.6.13-rc1)
EIP is at get_blkdev_list+0x58/0xc0
eax: 00000000   ebx: 10000000   ecx: ffffffff   edx: 10000008
esi: 00000010   edi: 10000008   ebp: ffffffff   esp: df5e5ed4
ds: 007b   es: 007b   ss: 0068
Process grep (pid: 5877, threadinfo=df5e4000 task=df5a5ac0)
Stack: d49590bb c031ecc4 c030db6a 000000b4 000000cb 00000000 000000bb 
d4959000
        df5e5f54 00000c00 c0187d68 d49590bb 000000bb 00000010 c03566e4 
00000000
        00000000 00000000 df5e5f58 c0187d20 d4959000 00000c00 00000000 
c01847c5
Call Trace:
  [<c0187d68>] devices_read_proc+0x48/0x90
  [<c0187d20>] devices_read_proc+0x0/0x90
  [<c01847c5>] proc_file_read+0xc5/0x250
  [<c015467f>] vfs_read+0x9f/0x120
  [<c0154981>] sys_read+0x51/0x80
  [<c0102ec1>] syscall_call+0x7/0xb
Code: 00 00 00 00 8b 54 24 14 8b 1c 95 a0 ca 41 c0 85 db 74 55 bd ff ff 
ff ff 8b 7c 24 30 8d 53 08 89 e9 31 c0 01 f7 89 7c 24 10
89 d7 <f2> ae f7 d1 49 8b 7c 24 10 8d 44 39 05 3d ff 0f 00 00 77 37 89
  <6>ohci1394: $Rev: 1250 $ Ben Collins <bcollins@debian.org>
PCI: Enabling device 0000:00:07.0 (0094 -> 0097)
ACPI: PCI Interrupt 0000:00:07.0[A] -> GSI 17 (level, low) -> IRQ 16
PCI: Via IRQ fixup for 0000:00:07.0, from 255 to 0
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[16] 
MMIO=[f7000000-f70007ff]  Max Packet=[2048]
<snippage>
