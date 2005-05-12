Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261358AbVELJXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbVELJXd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 05:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbVELJXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 05:23:33 -0400
Received: from [81.255.133.185] ([81.255.133.185]:4996 "EHLO
	mail.maccaferri.fr") by vger.kernel.org with ESMTP id S261358AbVELJX0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 05:23:26 -0400
Message-ID: <4283206B.9060300@free.fr>
Date: Thu, 12 May 2005 11:22:51 +0200
From: Essyug <essyug@free.fr>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Call trace
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello (and sorry if this is not the right ml to post to),

I'm running a 2.6.9 kernel on a debian 3.0 Woody based machine. My
kernel config is slightly different from the one used by Woody, but not
too musch (I can post it if necessary). It sometimes crashes, and I
can't understand why. I could upgrade to a newer kernel, but this is a
production machine, so I would better avoid this for now. Some
proprietary software is running and might be the problem (Kasperky for
nstance). Here is a Call Trace ; any help is welcome !

kernel: Unable to handle kernel paging request at virtual address 0001c549
kernel:  printing eip:
kernel: c016112f
kernel: *pde = 00000000
kernel: Oops: 0000 [#1]
kernel: Modules linked in: ehci_hcd usbcore 8250 serial_core
kernel: CPU:    0
kernel: EIP:    0060:[iput+15/96]    Not tainted VLI
kernel: EFLAGS: 00010286   (2.6.9-20041104)
kernel: EIP is at iput+0xf/0x60
kernel: eax: 0001c525   ebx: cbee5a5c   ecx: cbee5aec   edx: cbee5bec
kernel: esi: cbee5a5c   edi: 00000031   ebp: 00000000   esp: c1341ef4
kernel: ds: 007b   es: 007b   ss: 0068
kernel: Process kswapd0 (pid: 31, threadinfo=c1340000 task=cfed65b0)
kernel: Stack: cbee6ef0 c015f016 cbee5a5c 0000023f c1340000 0000068c
c015f36b 00000080
kernel:        c013a997 00000080 000000d0 c051a9e0 00000001 00000006
00000014 001a1300
kernel:        00000000 000003fb cffeea60 00000020 c013bb30 00000020
000000d0 000003fa
kernel: Call Trace:
kernel:  [prune_dcache+246/320] prune_dcache+0xf6/0x140
kernel:  [shrink_dcache_memory+27/80] shrink_dcache_memory+0x1b/0x50
kernel:  [shrink_slab+311/400] shrink_slab+0x137/0x190
kernel:  [balance_pgdat+416/656] balance_pgdat+0x1a0/0x290
kernel:  [kswapd+221/240] kswapd+0xdd/0xf0
kernel:  [kswapd+0/240] kswapd+0x0/0xf0
kernel:  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
kernel:  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
kernel:  [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
kernel: Code: 83 78 24 00 75 0a 50 e8 10 fe ff ff 83 c4 04 c3 50 e8 06
ff ff ff 83 c4 04 c3 89 f6 53 8b 5c 24 08 85 db 74 55 8b 83 98 00 00 00
<8b> 40 24 83 bb 24 01 00 00 20 75 08 0f 0b 4c 04 f1 7e 45 c0 85


