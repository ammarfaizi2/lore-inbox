Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262205AbUCODU2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 22:20:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262208AbUCODU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 22:20:28 -0500
Received: from jive.SoftHome.net ([66.54.152.27]:43671 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id S262205AbUCODUZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 22:20:25 -0500
From: mahipal@softhome.net
To: linux-kernel@vger.kernel.org
Subject: 2.6.4-rc2mm1 hangs at shutdown
Date: Sun, 14 Mar 2004 20:20:24 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [202.63.96.140]
Message-ID: <courier.405520F8.00002CDA@softhome.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi 

The machine is hangs at shutdown with 2.6.4-rc2mm1. The hangs are not 
consistent on every reboot. One more problem is 2.6.4-mm1 panics at
boot with almost same errors. I couldnot capture those because I dont have 
any serial cable. 

 

Mar 15 04:53:22 ubergeek kernel: klogd 1.4.1#13, log source = /proc/kmsg 
started.
Mar 15 04:53:22 ubergeek kernel: Cannot find map file.
Mar 15 04:53:22 ubergeek kernel: No module symbols loaded - kernel modules 
not enabled.
Mar 15 04:53:22 ubergeek kernel: Linux version 2.6.4-rc2-mm1 (root@ubergeek) 
(gcc version 3.3.3 (Debian)) #3 Sat Mar 13 13:58:35 IST 2004
Mar 15 04:53:22 ubergeek kernel: BIOS-provided physical RAM map: 


Mar 15 04:58:02 ubergeek kernel: ------------[ cut here ]------------
Mar 15 04:58:02 ubergeek kernel: kernel BUG at fs/proc/generic.c:664!
Mar 15 04:58:02 ubergeek kernel: invalid operand: 0000 [#1]
Mar 15 04:58:02 ubergeek kernel: PREEMPT DEBUG_PAGEALLOC
Mar 15 04:58:02 ubergeek kernel: CPU:    0
Mar 15 04:58:02 ubergeek kernel: EIP:    0060:[<c01b8cf0>]    Not tainted 
VLI
Mar 15 04:58:02 ubergeek kernel: EFLAGS: 00010286
Mar 15 04:58:02 ubergeek kernel: EIP is at remove_proc_entry+0xe1/0x11d
Mar 15 04:58:02 ubergeek kernel: eax: c61a28ac   ebx: c67ccdc8   ecx: 
c648c820   edx: c6806f54
Mar 15 04:58:02 ubergeek kernel: esi: 00000005   edi: c648c820   ebp: 
c55ffe54   esp: c55ffe34
Mar 15 04:58:02 ubergeek kernel: ds: 007b   es: 007b   ss: 0068
Mar 15 04:58:02 ubergeek kernel: Process modprobe (pid: 341, 
threadinfo=c55fe000 task=c674a9d0)
Mar 15 04:58:02 ubergeek kernel: Stack: c648c820 c648c868 c648c820 0000000c 
c648c868 ca868440 c648c8ac c67ccd98
Mar 15 04:58:02 ubergeek kernel:        c55ffe70 ca85f355 c648c868 c67ccd98 
c6e54bf8 c6e54bf8 ca8bc244 c55ffe84
Mar 15 04:58:02 ubergeek kernel:        ca85ee50 c648c8ac c67ccd98 c55fe000 
c55ffec0 ca85d248 c6e54bf8 00000002
Mar 15 04:58:02 ubergeek kernel: Call Trace:
Mar 15 04:58:02 ubergeek kernel:  [<ca85f355>] snd_info_unregister+0x52/0x7f 
[snd]
Mar 15 04:58:02 ubergeek kernel:  [<ca85ee50>] snd_info_card_free+0x31/0x5a 
[snd]
Mar 15 04:58:02 ubergeek kernel:  [<ca85d248>] snd_card_free+0xf3/0x229 
[snd]
Mar 15 04:58:02 ubergeek kernel:  [<c018f03e>] dput+0x23/0x761
Mar 15 04:58:02 ubergeek kernel:  [<c019fd45>] simple_unlink+0x4a/0x59
Mar 15 04:58:02 ubergeek kernel:  [<ca8b8dd1>] snd_intel8x0_remove+0x21/0x2f 
[snd_intel8x0]
Mar 15 04:58:02 ubergeek kernel:  [<c0258bab>] pci_device_remove+0x3b/0x3d
Mar 15 04:58:02 ubergeek kernel:  [<c029d322>] 
device_release_driver+0x62/0x64
Mar 15 04:58:02 ubergeek kernel:  [<c029d346>] driver_detach+0x22/0x31
Mar 15 04:58:02 ubergeek kernel:  [<c029d5c3>] bus_remove_driver+0x57/0x8f
Mar 15 04:58:02 ubergeek kernel:  [<c029d9c8>] driver_unregister+0x1a/0x44
Mar 15 04:58:02 ubergeek kernel:  [<c0258d11>] 
pci_unregister_driver+0x14/0x18
Mar 15 04:58:02 ubergeek kernel:  [<ca8b8e52>] 
alsa_card_intel8x0_exit+0x12/0x2e [snd_intel8x0]
Mar 15 04:58:02 ubergeek kernel:  [<c013ef2b>] sys_delete_module+0x12c/0x194
Mar 15 04:58:02 ubergeek kernel:  [<c015d953>] sys_munmap+0x57/0x75
Mar 15 04:58:02 ubergeek kernel:  [<c035ee9b>] syscall_call+0x7/0xb
Mar 15 04:58:02 ubergeek kernel:
Mar 15 04:58:02 ubergeek kernel: Code: 44 01 00 00 00 89 44 24 0c 8b 47 04 
89 44 24 08 8b 45 0c 8b 40 04 c7 04 24 80 cb 37 c0 89 44 24 04 e8 e1 85 f6 
ff e9 77 ff ff ff <0f> 0b 98 02 2c 9d 37 c0 eb b5 8b 45 0c 66 83 68 0a 01 eb 
87 8d
Mar 15 04:58:04 ubergeek kernel: Kernel logging (proc) stopped.
Mar 15 04:58:04 ubergeek kernel: Kernel log daemon terminating.
Mar 15 04:58:04 ubergeek exiting on signal 15 
