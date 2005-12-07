Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030445AbVLGWRo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030445AbVLGWRo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 17:17:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030449AbVLGWRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 17:17:44 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:65411 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030445AbVLGWRm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 17:17:42 -0500
Subject: 2.6.15-rc4 Oops in show_smaps()
From: Badari Pulavarty <pbadari@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 07 Dec 2005 14:18:00 -0800
Message-Id: <1133993880.21841.49.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am getting Oops while doing 

cat /proc/<pid>/smaps

Known issue ? 

Thanks,
Badari

Unable to handle kernel paging request for data at address
0xc0000001006d3698
Faulting instruction address: 0xc0000000001083a8
Oops: Kernel access of bad area, sig: 11 [#1]
SMP NR_CPUS=128 NUMA PSERIES LPAR
Modules linked in: evdev joydev st usbserial ehci_hcd ohci_hcd ipv6
usbcore dm_mod
NIP: C0000000001083A8 LR: C0000000001082A8 CTR: 0000000000000000
REGS: c0000000da7ff860 TRAP: 0300   Not tainted  (2.6.15-rc4)
MSR: 8000000000009032 <EE,ME,IR,DR>  CR: 24000424  XER: 20000010
DAR: C0000001006D3698, DSISR: 0000000040010000
TASK = c0000000e6937040[11420] 'cat' THREAD: c0000000da7fc000 CPU: 2
GPR00: 0000004000000600 C0000000DA7FFAE0 C000000000635AF8
C0000000DA7FFB50
GPR04: 0000000000000000 0000000000000000 C0000000DA7FFB78
0000000000000000
GPR08: 0004000000600000 0000000100000018 0000000600000793
C0000000006D3680
GPR12: 0000000022000428 C0000000004DE000 000001003FFFFFFF
C00000000F5FECC0
GPR16: C0000000EB22FC00 0000010040000000 000001003FFFFFFF
C0000000D984E100
GPR20: 0000000000000038 0000010040000000 000001000FFFFFFF
C0000000E2A68000
GPR24: 000000001001740A 0000010010000000 C0000000DA7FFB50
C0000000E2A68400
GPR28: 0000010000200000 0000010000000000 C00000000055ED50
0000010000000000
NIP [C0000000001083A8] .show_smap+0x170/0x39c
LR [C0000000001082A8] .show_smap+0x70/0x39c
Call Trace:
[C0000000DA7FFAE0] [C000000000108544] .show_smap+0x30c/0x39c
(unreliable)
[C0000000DA7FFC10] [C0000000000EC2BC] .seq_read+0x4bc/0x510
[C0000000DA7FFCF0] [C0000000000BB400] .vfs_read+0x174/0x254
[C0000000DA7FFD90] [C0000000000BB5F0] .sys_read+0x54/0x9c
[C0000000DA7FFE30] [C000000000008600] syscall_exit+0x0/0x18
Instruction dump:
2faa0000 419e0188 3c004000 e97e8038 7fbfeb78 38e00000 780007c6 7c0a0214
7809f860 7808a302 78004602 79291f24 <7d69582a> 2fab0000 419e000c
78001d28


