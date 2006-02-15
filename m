Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945912AbWBOMLk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945912AbWBOMLk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 07:11:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945914AbWBOMLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 07:11:40 -0500
Received: from coumail01.netbenefit.co.uk ([212.53.64.106]:23233 "EHLO
	coumail01.netbenefit.co.uk") by vger.kernel.org with ESMTP
	id S1945912AbWBOMLk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 07:11:40 -0500
Message-ID: <002a01c63228$abda02f0$0a00a8c0@emachine>
From: "Michael Gilroy" <mgilroy@a2etech.com>
To: <linux-kernel@vger.kernel.org>
Subject: Kernel bug mm/page_alloc.c
Date: Wed, 15 Feb 2006 12:09:28 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2670
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
       I get a repeatable error due to failures in mm/page_alloc.c, errors 
occur during heavy utilisation of the file-system with bonnie++. I'm using 
an experimental driver for the RAID 6 operations however as the error 
message below indicates that the bug is being caused elsewhere I wonder if 
this is a bug in the kernel. If not can anyone suggest a probable cause or 
method to help locate the cause of this bug?
kernel BUG at mm/page_alloc.c:761!

invalid operand: 0000 [#1]

Modules linked in: raid6 xor radeon drm parport_pc lp parport autofs4 
i2c_dev i2 c_core sunrpc ipt_REJECT ipt_state ip_conntrack iptable_filter 
ip_tables dm_mod video button battery ac ipv6 ohci_hcd hw_random sata_sil24 
tg3 floppy ext3 jbd s ata_sil libata sd_mod scsi_mod

CPU: 0

EIP: 0060:[<c0136172>] Not tainted VLI

EFLAGS: 00010202 (2.6.15.2)

EIP is at buffered_rmqueue+0xbd/0x1a3

eax: 00000001 ebx: c0319720 ecx: 00001000 edx: 00000001

esi: c0319720 edi: c0319740 ebp: eb9cfd24 esp: eb9cfcfc

ds: 007b es: 007b ss: 0068

Process bonnie++ (pid: 4548, threadinfo=eb9cf000 task=ecd99030)

Stack: 00001000 00000001 00000000 c1210000 00000246 000200d2 00000000 
c03199ec

00000044 00000000 eb9cfd44 c0136367 00000003 00000000 000200d2 c03199e8

000200d2 eb9cfdb0 eb9cfd74 c01363d8 00000044 00000000 ecd99030 00000010

Call Trace:

[<c0103078>] show_stack+0x76/0x7e

[<c010317f>] show_registers+0xe8/0x150

[<c010331a>] die+0xbe/0x12f

[<c02c5122>] do_trap+0x7c/0x96

[<c010357b>] do_invalid_op+0x95/0x9c

[<c0102d7f>] error_code+0x4f/0x54

[<c0136367>] get_page_from_freelist+0x74/0x8c

[<c01363d8>] __alloc_pages+0x59/0x271

[<c01341cd>] generic_file_buffered_write+0x157/0x4b9

[<c01348d5>] __generic_file_aio_write_nolock+0x3a6/0x3d1

[<c01349f0>] __generic_file_write_nolock+0x74/0x8a

[<c0134b8f>] generic_file_write+0x49/0xaf

[<c014cd73>] vfs_write+0xa9/0x14e

[<c014ceb3>] sys_write+0x3b/0x60

[<c0102afb>] sysenter_past_esp+0x54/0x75

Code: f0 e8 e3 fb ff ff 89 45 e4 8b 55 e8 89 d8 e8 26 ee 18 00 83 7d e4 00 
0f 84 e9 00 00 00 8b 55 e4 89 f0 e8 5c f7 ff ff 85 c0 74 08 <0f> 0b f9 02 f5 
88 2d c0 8b 96 38 01 00 00 bf 28 00 00 00 8d 82




Please CC me on any replies as I'm not subscribed to this list.

thanks
_______________________
Michael Gilroy
Research Engineer
A2E Limited
Adaptive House
Quarrywood Court
Livingston
EH54 6AX
Scotland 


