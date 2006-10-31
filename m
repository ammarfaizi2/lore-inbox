Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423772AbWJaS16@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423772AbWJaS16 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 13:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423771AbWJaS15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 13:27:57 -0500
Received: from oceanic.wsisiz.edu.pl ([213.135.44.33]:8285 "EHLO
	oceanic.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id S1423770AbWJaS15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 13:27:57 -0500
Date: Tue, 31 Oct 2006 19:25:36 +0100 (CET)
From: Lukasz Trabinski <lukasz@wsisiz.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: Oops on 2.6.18
Message-ID: <Pine.LNX.4.64.0610311923100.28672@oceanic.wsisiz.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


oceanic:~$ uname -a
Linux oceanic.wsisiz.edu.pl 2.6.18-oceanic #1 SMP Thu Sep 28 22:26:52 CEST 
2006 x86_64 x86_64 x86_64 GNU/Linux

filesystem with ext3/quota/acl

Oct 31 13:30:09 oceanic kernel: Unable to handle kernel paging request at 0000000000100108 RIP: 
Oct 31 13:30:09 oceanic kernel:  [<ffffffff80233387>] free_uid+0x37/0x6c 
Oct 31 13:30:09 oceanic kernel: PGD 0 
Oct 31 13:30:09 oceanic kernel: Oops: 0002 [1] SMP 
Oct 31 13:30:09 oceanic kernel: CPU 1 
Oct 31 13:30:09 oceanic kernel: Modules linked in: loop xt_tcpudp ipt_owner iptable_filter ip_tables x_tables ipv6 nfsd exportfs dm_mirror dm_mod video thermal processor fan button battery asus_acpi ac floppy ohci_hcd sg eepro100 mii ide_cd cdrom usbcore 
Oct 31 13:30:09 oceanic kernel: Pid: 31366, comm: smbd Not tainted 2.6.18-oceanic #1 
Oct 31 13:30:09 oceanic kernel: RIP: 0010:[<ffffffff80233387>]  [<ffffffff80233387>] free_uid+0x37/0x6c 
Oct 31 13:30:09 oceanic kernel: RSP: 0018:ffff81035c05dd28  EFLAGS: 00010002 
Oct 31 13:30:09 oceanic kernel: RAX: 0000000000200200 RBX: 0000000000000082 RCX: ffff8103acb46b68 
Oct 31 13:30:09 oceanic kernel: RDX: 0000000000100100 RSI: 0000000000000082 RDI: ffffffff804b71e0 
Oct 31 13:30:09 oceanic kernel: RBP: ffff8103acb46b40 R08: 00002acd9e3a4260 R09: ffff81035c05df50 
Oct 31 13:30:09 oceanic kernel: R10: 00002acd9f6ef500 R11: 0000000000000202 R12: ffff81035c05de78 
Oct 31 13:30:09 oceanic kernel: R13: 0000000000000000 R14: 0000000000000009 R15: 000000000000000a 
Oct 31 13:30:09 oceanic kernel: FS:  00002acd9f6ef500(0000) GS:ffff8101f8c3a840(0000) knlGS:00000000f49fcba0 
Oct 31 13:30:09 oceanic kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b 
Oct 31 13:30:09 oceanic kernel: CR2: 0000000000100108 CR3: 000000020ee64000 CR4: 00000000000006e0 
Oct 31 13:30:09 oceanic kernel: Process smbd (pid: 31366, threadinfo ffff81035c05c000, task ffff81015e302870) 
Oct 31 13:30:09 oceanic kernel: Stack:  ffff81035c05dd44 ffff8102be4addb0 ffff8102b7ac66a8 ffffffff80233829 
Oct 31 13:30:09 oceanic kernel:  ffff8102be4addb0 ffffffff8023404a ffff81035c05df50 0000000000000000 
Oct 31 13:30:09 oceanic kernel:  ffff81035c05de78 ffff81015e302870 ffff81015e302e08 ffff81035c05def8 
Oct 31 13:30:09 oceanic kernel: Call Trace: 
Oct 31 13:30:09 oceanic kernel:  [<ffffffff80233829>] __sigqueue_free+0x24/0x36 
Oct 31 13:30:09 oceanic kernel:  [<ffffffff8023404a>] __dequeue_signal+0x130/0x19b 
Oct 31 13:30:09 oceanic kernel:  [<ffffffff802352e8>] dequeue_signal+0x3c/0xbc 
Oct 31 13:30:09 oceanic kernel:  [<ffffffff802359b6>] get_signal_to_deliver+0x165/0x49d 
Oct 31 13:30:09 oceanic kernel:  [<ffffffff80208c37>] do_signal+0x55/0x751 
Oct 31 13:30:09 oceanic kernel:  [<ffffffff802c4fd5>] ext3_check_acl+0x1a/0x5d 
Oct 31 13:30:09 oceanic kernel:  [<ffffffff8023c3f8>] autoremove_wake_function+0x0/0x2e 
Oct 31 13:30:09 oceanic kernel:  [<ffffffff8024ef9b>] audit_syscall_entry+0x14d/0x176 
Oct 31 13:30:09 oceanic kernel:  [<ffffffff8028d234>] mntput_no_expire+0x19/0x8b 
Oct 31 13:30:09 oceanic kernel:  [<ffffffff8024f297>] audit_syscall_exit+0x2d3/0x2f1 
Oct 31 13:30:09 oceanic kernel:  [<ffffffff80209a4a>] int_signal+0x12/0x17 
Oct 31 13:30:09 oceanic kernel: 
Oct 31 13:30:09 oceanic kernel: 
Oct 31 13:30:09 oceanic kernel: Code: 48 89 42 08 48 89 10 48 c7 41 08 00 02 20 00 48 c7 45 28 00 
Oct 31 13:30:09 oceanic kernel: RIP  [<ffffffff80233387>] free_uid+0x37/0x6c 
Oct 31 13:30:09 oceanic kernel:  RSP <ffff81035c05dd28> 
Oct 31 13:30:09 oceanic kernel: CR2: 0000000000100108
