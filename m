Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261611AbVAMNOb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbVAMNOb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 08:14:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261623AbVAMNOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 08:14:30 -0500
Received: from [203.88.135.194] ([203.88.135.194]:58758 "EHLO elitecore.com")
	by vger.kernel.org with ESMTP id S261611AbVAMNON (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 08:14:13 -0500
From: "Sumit Pandya" <sumit@elitecore.com>
To: <linux-kernel@vger.kernel.org>
Subject: vfs and paging error
Date: Thu, 13 Jan 2005 18:43:18 +0530
Message-ID: <HGEFKOBCHAIJDIEJLAKDKEPGCAAA.sumit@elitecore.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
In-Reply-To: <1105029639.24187.225.camel@localhost.localdomain>
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
X-imss-version: 2.0
X-imss-result: Passed
X-imss-scores: Clean:35.49410 C:20 M:1 S:5 R:5
X-imss-settings: Baseline:1 C:1 M:1 S:1 R:1 (0.0000 0.0000)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	After few days(5-6) of running my IBM-NETVISTA system with Kernel-2.4.26, I
get following errors

[sumit@linux139 sumit]$ cut -d" " -f5- /tmp/messages
kernel:  <1>Unable to handle kernel paging request at virtual address
57e34010
kernel:  printing eip:
kernel: c014b236
kernel: *pde = 00000000
kernel: Oops: 0000
kernel: CPU:    0
kernel: EIP:    0010:[expand_fdset+198/480]    Not tainted
kernel: EFLAGS: 00010207
kernel: eax: 57e34010   ebx: 57e34000   ecx: 0000ffff   edx: 01cb142c
kernel: esi: cf898328   edi: c8b9bf84   ebp: c8b9be8c   esp: c8b9be64
kernel: ds: 0018   es: 0018   ss: 0018
kernel: Process ifconfig (pid: 15052, stackpage=c8b9b000)
kernel: Stack: 00000000 c0125ed1 57e34010 dfe34010 c7e0500a 01cb142c
00000004 c8b9bf04
kernel:        cf898328 c8b9bf84 c8b9beac c0141f34 cf898328 c8b9bf04
cfd342f8 ffffffec
kernel:        dca0b66c c8b9bf04 c8b9bf2c c0142838 cf898328 c8b9bf04
00000000 00000246
kernel: Call Trace:    [get_unmapped_area+145/288] [vfs_rename_dir+180/1312]
[sys_rename+184/480] [__change_page_attr+172/368] [vfs_link+48/272]
kernel:   [page_follow_link+113/397] [.text.lock.namei+336/531]
[fput+76/240] [invalidate_bdev+11/320] [device_not_available_emulate+15/16]
kernel:
kernel: Code: 8b 00 89 45 e0 39 53 44 75 78 8b 45 08 39 43 0c 75 70 8b 40
kernel:  <1>Unable to handle kernel paging request at virtual address
57e34010
kernel:  printing eip:
kernel: c014b236
kernel: *pde = 00000000
kernel: Oops: 0000
kernel: CPU:    0
kernel: EIP:    0010:[expand_fdset+198/480]    Not tainted
kernel: EFLAGS: 00010207
kernel: eax: 57e34010   ebx: 57e34000   ecx: 0000ffff   edx: 01cb142c
kernel: esi: cf898328   edi: c8b9bf84   ebp: c8b9be8c   esp: c8b9be64
kernel: ds: 0018   es: 0018   ss: 0018
kernel: Process ifconfig (pid: 15054, stackpage=c8b9b000)
kernel: Stack: 00000000 c0125ed1 57e34010 dfe34010 d957c00a 01cb142c
00000004 c8b9bf04
kernel:        cf898328 c8b9bf84 c8b9beac c0141f34 cf898328 c8b9bf04
cda262f8 ffffffec
ifup: SIOCADDRT: Network is unreachable
kernel:        dca0b66c c8b9bf04 c8b9bf2c c0142838 cf898328 c8b9bf04
00000000 00000246
kernel: Call Trace:    [get_unmapped_area+145/288] [vfs_rename_dir+180/1312]
[sys_rename+184/480] [__change_page_attr+172/368] [vfs_link+48/272]
kernel:   [page_follow_link+113/397] [.text.lock.namei+336/531]
[fput+76/240] [device_not_available_emulate+15/16]
kernel:
kernel: Code: 8b 00 89 45 e0 39 53 44 75 78 8b 45 08 39 43 0c 75 70 8b 40
kernel:  <1>Unable to handle kernel paging request at virtual address
57e34010
kernel:  printing eip:
kernel: c014b236
kernel: *pde = 00000000
kernel: Oops: 0000
kernel: CPU:    0
kernel: EIP:    0010:[expand_fdset+198/480]    Not tainted
kernel: EFLAGS: 00010207
kernel: eax: 57e34010   ebx: 57e34000   ecx: 0000ffff   edx: 01cb142c
kernel: esi: cf898328   edi: c8b3bf84   ebp: c8b3be8c   esp: c8b3be64
kernel: ds: 0018   es: 0018   ss: 0018
kernel: Process ifconfig (pid: 15082, stackpage=c8b3b000)
kernel: Stack: 00000000 c0125ed1 57e34010 dfe34010 c404800a 01cb142c
00000004 c8b3bf04
kernel:        cf898328 c8b3bf84 c8b3beac c0141f34 cf898328 c8b3bf04
cfd342f8 ffffffec
kernel:        dca0b66c c8b3bf04 c8b3bf2c c0142838 cf898328 c8b3bf04
00000000 00000246
kernel: Call Trace:    [get_unmapped_area+145/288] [vfs_rename_dir+180/1312]
[sys_rename+184/480] [__change_page_attr+172/368] [vfs_link+48/272]
kernel:   [page_follow_link+113/397] [.text.lock.namei+336/531]
[fput+76/240] [probe_irq_off+130/144] [device_not_available_emulate+15/16]
kernel:
kernel: Code: 8b 00 89 45 e0 39 53 44 75 78 8b 45 08 39 43 0c 75 70 8b 40
network: Bringing up interface lo succeeded
kernel:  <1>Unable to handle kernel paging request at virtual address
57e34010
kernel:  printing eip:
kernel: c014b236
kernel: *pde = 00000000
kernel: Oops: 0000
kernel: CPU:    0
kernel: EIP:    0010:[expand_fdset+198/480]    Not tainted
kernel: EFLAGS: 00010207
kernel: eax: 57e34010   ebx: 57e34000   ecx: 0000ffff   edx: 01cb142c
kernel: esi: cf898328   edi: c8b9bf84   ebp: c8b9be8c   esp: c8b9be64
kernel: ds: 0018   es: 0018   ss: 0018
kernel: Process ifconfig (pid: 15114, stackpage=c8b9b000)
kernel: Stack: 00000000 c0125ed1 57e34010 dfe34010 d576b00a 01cb142c
00000004 c8b9bf04
kernel:        cf898328 c8b9bf84 c8b9beac c0141f34 cf898328 c8b9bf04
cda262f8 ffffffec
kernel:        dca0b66c c8b9bf04 c8b9bf2c c0142838 cf898328 c8b9bf04
00000000 00000246
kernel: Call Trace:    [get_unmapped_area+145/288] [vfs_rename_dir+180/1312]
[sys_rename+184/480] [__change_page_attr+172/368] [vfs_link+48/272]
kernel:   [page_follow_link+113/397] [.text.lock.namei+336/531]
[fput+76/240] [invalidate_bdev+11/320] [device_not_available_emulate+15/16]
kernel:
kernel: Code: 8b 00 89 45 e0 39 53 44 75 78 8b 45 08 39 43 0c 75 70 8b 40
kernel:  <1>Unable to handle kernel paging request at virtual address
57e34010
kernel:  printing eip:
kernel: c014b236
kernel: *pde = 00000000
kernel: Oops: 0000
kernel: CPU:    0
kernel: EIP:    0010:[expand_fdset+198/480]    Not tainted
kernel: EFLAGS: 00010207
kernel: eax: 57e34010   ebx: 57e34000   ecx: 0000ffff   edx: 01cb142c
kernel: esi: cf898328   edi: c8b9bf84   ebp: c8b9be8c   esp: c8b9be64
kernel: ds: 0018   es: 0018   ss: 0018
kernel: Process ifconfig (pid: 15120, stackpage=c8b9b000)
kernel: Stack: 00000000 0000000e 57e34010 dfe34010 c83bc00a 01cb142c
00000004 c8b9bf04
kernel:        cf898328 c8b9bf84 c8b9beac c0141f34 cf898328 c8b9bf04
c76032f8 ffffffec
kernel:        dca0b66c c8b9bf04 c8b9bf2c c0142838 cf898328 c8b9bf04
00000000 00000246
kernel: Call Trace:    [vfs_rename_dir+180/1312] [sys_rename+184/480]
[__change_page_attr+172/368] [vfs_link+48/272] [page_follow_link+113/397]
kernel:   [.text.lock.namei+336/531] [fput+76/240]
[device_not_available_emulate+15/16]
kernel:
kernel: Code: 8b 00 89 45 e0 39 53 44 75 78 8b 45 08 39 43 0c 75 70 8b 40
ifup: SIOCADDRT: Network is down
ifup: SIOCADDRT: Network is unreachable
kernel:  <1>Unable to handle kernel paging request at virtual address
57e34010
kernel:  printing eip:
kernel: c014b236
kernel: *pde = 00000000
kernel: Oops: 0000
kernel: CPU:    0
kernel: EIP:    0010:[expand_fdset+198/480]    Not tainted
kernel: EFLAGS: 00010207
kernel: eax: 57e34010   ebx: 57e34000   ecx: 0000ffff   edx: 01cb142c
kernel: esi: cf898328   edi: c84d1f84   ebp: c84d1e8c   esp: c84d1e64
kernel: ds: 0018   es: 0018   ss: 0018
kernel: Process ifconfig (pid: 15148, stackpage=c84d1000)
kernel: Stack: 00000000 c0125ed1 57e34010 dfe34010 d926200a 01cb142c
00000004 c84d1f04
kernel:        cf898328 c84d1f84 c84d1eac c0141f34 cf898328 c84d1f04
d000e2f8 ffffffec
kernel:        dca0b66c c84d1f04 c84d1f2c c0142838 cf898328 c84d1f04
00000000 00000246
kernel: Call Trace:    [get_unmapped_area+145/288] [vfs_rename_dir+180/1312]
[sys_rename+184/480] [__change_page_attr+172/368] [vfs_link+48/272]
kernel:   [page_follow_link+113/397] [.text.lock.namei+336/531]
[fput+76/240] [invalidate_bdev+11/320] [device_not_available_emulate+15/16]
kernel:
kernel: Code: 8b 00 89 45 e0 39 53 44 75 78 8b 45 08 39 43 0c 75 70 8b 40


[sumit@linux139 sumit]$ cat /proc/cmdline
BOOT_IMAGE=linux-up ro root=305 BOOT_FILE=/boot/vmlinuz-2.4.26-3
console=ttyS0 acpi=off pci=noacpi acpi=noirq noapic

	I've to run this system without ACPI and APIC because suddenly after some
2-3 days of uptime my system clock run in very unsyncronized way; sometimes
even upto 3 times faster. I reported this timer issue before but couldn't
manage to implement the suggession of verifying this with 2.4.27 or even
2.4.28.
	 Thus finally workaround of disabling all acpi and apic issues worked
against timer issue but then this another problem stucks.

Thanks for your time,
-- Sumit

