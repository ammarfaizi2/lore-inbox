Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751196AbWIMVDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbWIMVDQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 17:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbWIMVDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 17:03:16 -0400
Received: from smtp-out-46.synserver.de ([217.119.50.46]:25759 "HELO
	blue-ld-125.synserver.de") by vger.kernel.org with SMTP
	id S1751196AbWIMVDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 17:03:15 -0400
X-SynServer-RemoteDnsName: port-212-202-34-169.dynamic.qsc.de
X-SynServer-AuthUser: markus@trippelsdorf.de
Date: Wed, 13 Sep 2006 23:03:07 +0200
From: Markus Trippelsdorf <markus@trippelsdorf.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.18-rc7 Unable to handle kernel paging request
Message-ID: <20060913210307.GA6915@gentoox2.trippelsdorf.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't know what to make of these kernel error messages.
This happened an hour ago and the system kept running until I rebooted.

Unable to handle kernel paging request at ffffffff004c82c8 RIP:
 [<ffffffff80222a24>] generic_file_mmap+0x14/0x50
PGD 203027 PUD 0
CPU 0
Modules linked in: tuner bttv video_buf ir_common compat_ioctl32 btcx_risc tveeprom videodev v4l1_compat v4l2_common
Pid: 24497, comm: emake Not tainted 2.6.18-rc7 #1
RIP: 0010:[<ffffffff80222a24>]  [<ffffffff80222a24>] generic_file_mmap+0x14/0x50
RSP: 0018:ffff81005db69e98  EFLAGS: 00010206
RAX: ffffffff004c82c0 RBX: ffff810010252528 RCX: 0000000000000000
RDX: 00000000fffffff8 RSI: ffff810010252528 RDI: ffff810023234bc0
RBP: ffff810023234bc0 R08: 0000000000000000 R09: ffff810010252528
R10: ffff810023c1fde0 R11: ffff810023c1fde0 R12: 00000000ffffffea
R13: ffff81007eb04840 R14: 0000000000000000 R15: 00000000000d7000
FS:  00002acdf4b126d0(0000) GS:ffffffff80610000(0000) knlGS:00000000f73456b0
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: ffffffff004c82c8 CR3: 0000000063292000 CR4: 00000000000006e0
Process emake (pid: 24497, threadinfo ffff81005db68000, task ffff81001b7f6040)
Stack:  ffff810010252528 ffffffff8020de0b 0000000000000000 0000000044fc8613
 0000000000000000 0000000000000071 0000000000000002 ffff8100167b2a70
 0000000000000071 0000000000000000 00000000000000d7 ffffffff8022ca5e
Call Trace:
 [<ffffffff8020de0b>] do_mmap_pgoff+0x4bb/0x790
 [<ffffffff8022ca5e>] sys_newfstat+0x2e/0x50
 [<ffffffff80224965>] sys_mmap+0xa5/0x100
 [<ffffffff8026255e>] system_call+0x7e/0x83
Code: 48 83 78 08 00 74 22 f6 47 2e 04 75 0f 48 8b 77 10 48 8b 7f
RIP  [<ffffffff80222a24>] generic_file_mmap+0x14/0x50
 RSP <ffff81005db69e98>
 [<ffffffff80222a24>] generic_file_mmap+0x14/0x50
PGD 203027 PUD 0
CPU 1
Modules linked in: tuner bttv video_buf ir_common compat_ioctl32 btcx_risc tveeprom videodev v4l1_compat v4l2_common
Pid: 24502, comm: dmesg Not tainted 2.6.18-rc7 #1
RIP: 0010:[<ffffffff80222a24>]  [<ffffffff80222a24>] generic_file_mmap+0x14/0x50
RSP: 0018:ffff810078b8de98  EFLAGS: 00010206
RAX: ffffffff004c82c0 RBX: ffff810042e6cd08 RCX: 0000000000000000
RDX: 00000000fffffff8 RSI: ffff810042e6cd08 RDI: ffff8100232345c0
RBP: ffff8100232345c0 R08: 0000000000000000 R09: ffff810042e6cd08
R10: ffff81006048fa98 R11: ffff81006048fa98 R12: 00000000ffffffea
R13: ffff81001096a0c0 R14: 0000000000000000 R15: 00000000000d7000
FS:  00002ac8357726d0(0000) GS:ffff810002f3a640(0000) knlGS:00000000f73456b0
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: ffffffff004c82c8 CR3: 000000002ba9d000 CR4: 00000000000006e0
Process dmesg (pid: 24502, threadinfo ffff810078b8c000, task ffff81005d104ae0)
Stack:  ffff810042e6cd08 ffffffff8020de0b 0000000000000000 0000000044fc8613
 0000000000000000 0000000000000071 0000000000000002 ffff8100167b2a70
 0000000000000071 0000000000000000 00000000000000d7 ffffffff8022ca5e
Call Trace:
 [<ffffffff8020de0b>] do_mmap_pgoff+0x4bb/0x790
 [<ffffffff8022ca5e>] sys_newfstat+0x2e/0x50
 [<ffffffff80224965>] sys_mmap+0xa5/0x100
 [<ffffffff8026255e>] system_call+0x7e/0x83
Code: 48 83 78 08 00 74 22 f6 47 2e 04 75 0f 48 8b 77 10 48 8b 7f
RIP  [<ffffffff80222a24>] generic_file_mmap+0x14/0x50
 RSP <ffff810078b8de98>
 [<ffffffff80222a24>] generic_file_mmap+0x14/0x50
PGD 203027 PUD 0
CPU 1
Modules linked in: tuner bttv video_buf ir_common compat_ioctl32 btcx_risc tveeprom videodev v4l1_compat v4l2_common
Pid: 24504, comm: grep Not tainted 2.6.18-rc7 #1
RIP: 0010:[<ffffffff80222a24>]  [<ffffffff80222a24>] generic_file_mmap+0x14/0x50
RSP: 0018:ffff810012defe98  EFLAGS: 00010206
RAX: ffffffff004c82c0 RBX: ffff8100581b93d8 RCX: 0000000000000000
RDX: 00000000fffffff8 RSI: ffff8100581b93d8 RDI: ffff8100167ad5c0
R10: ffff81001256e408 R11: ffff81001256e408 R12: 00000000ffffffea
R13: ffff81007e48e580 R14: 0000000000000000 R15: 00000000000d7000
FS:  00002b1048a986d0(0000) GS:ffff810002f3a640(0000) knlGS:00000000f73456b0
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: ffffffff004c82c8 CR3: 000000007ca71000 CR4: 00000000000006e0
Process grep (pid: 24504, threadinfo ffff810012dee000, task ffff81007f71b1c0)
Stack:  ffff8100581b93d8 ffffffff8020de0b 0000000000000000 0000000044fc8613
 0000000000000000 0000000000000071 0000000000000002 ffff8100167b2a70
 0000000000000071 0000000000000000 00000000000000d7 ffffffff8022ca5e
Call Trace:
 [<ffffffff8020de0b>] do_mmap_pgoff+0x4bb/0x790
 [<ffffffff8022ca5e>] sys_newfstat+0x2e/0x50
 [<ffffffff80224965>] sys_mmap+0xa5/0x100
 [<ffffffff8026255e>] system_call+0x7e/0x83
Code: 48 83 78 08 00 74 22 f6 47 2e 04 75 0f 48 8b 77 10 48 8b 7f
RIP  [<ffffffff80222a24>] generic_file_mmap+0x14/0x50
 RSP <ffff810012defe98>
 [<ffffffff80222a24>] generic_file_mmap+0x14/0x50
PGD 203027 PUD 0
CPU 0
Modules linked in: tuner bttv video_buf ir_common compat_ioctl32 btcx_risc tveeprom videodev v4l1_compat v4l2_common
Pid: 24519, comm: rm Not tainted 2.6.18-rc7 #1
RIP: 0010:[<ffffffff80222a24>]  [<ffffffff80222a24>] generic_file_mmap+0x14/0x50
RSP: 0018:ffff810011a17e98  EFLAGS: 00010206
RAX: ffffffff004c82c0 RBX: ffff81007ea703d8 RCX: 0000000000000000
RDX: 00000000fffffff8 RSI: ffff81007ea703d8 RDI: ffff81007cb5ec80
RBP: ffff81007cb5ec80 R08: 0000000000000000 R09: ffff81007ea703d8
R10: ffff81001263d6a8 R11: ffff81001263d6a8 R12: 00000000ffffffea
R13: ffff81007eb09c00 R14: 0000000000000000 R15: 00000000000d7000
FS:  00002b67457686d0(0000) GS:ffffffff80610000(0000) knlGS:00000000f73456b0
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: ffffffff004c82c8 CR3: 000000001372d000 CR4: 00000000000006e0
Process rm (pid: 24519, threadinfo ffff810011a16000, task ffff810061998340)
Stack:  ffff81007ea703d8 ffffffff8020de0b 0000000000000000 0000000044fc8613
 0000000000000000 0000000000000071 0000000000000002 ffff8100167b2a70
 0000000000000071 0000000000000000 00000000000000d7 ffffffff8022ca5e
Call Trace:
 [<ffffffff8020de0b>] do_mmap_pgoff+0x4bb/0x790
 [<ffffffff8022ca5e>] sys_newfstat+0x2e/0x50
 [<ffffffff80224965>] sys_mmap+0xa5/0x100
 [<ffffffff8026255e>] system_call+0x7e/0x83
Code: 48 83 78 08 00 74 22 f6 47 2e 04 75 0f 48 8b 77 10 48 8b 7f
RIP  [<ffffffff80222a24>] generic_file_mmap+0x14/0x50
 RSP <ffff810011a17e98>

-- 
Markus
