Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269091AbUISBiB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269091AbUISBiB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 21:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269688AbUISBiB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 21:38:01 -0400
Received: from simmts6.bellnexxia.net ([206.47.199.164]:28671 "EHLO
	simmts6-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S269091AbUISBh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 21:37:57 -0400
Message-ID: <008601c49de9$cf8817c0$1b00a8c0@cruncher>
Reply-To: "Mike Kirk" <mike.kirk@sympatico.ca>
From: "Mike Kirk" <mike.kirk@sympatico.ca>
To: <linux-kernel@vger.kernel.org>
Subject: 2.6.9-rc2: "kernel BUG at mm/rmap.c:473!"
Date: Sat, 18 Sep 2004 21:41:36 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not sure what this means: but the system kept running and I only lost a
bzip2 process: 2.6.9-rc2 w/preempt AMD 2700+ on A7N8X motherboard, 1GB
DDR400:

==============================
kernel BUG at mm/rmap.c:473!
invalid operand: 0000 [#1]
PREEMPT
Modules linked in:
CPU: 0
EIP: 0060:[<c014a8f9>] Not tainted VLI
EFLAGS: 00010286 (2.6.8.1N)
EIP is at page_remove_rmap+0x29/0x40
eax: ffffffff ebx: 00005000 ecx: c1017a18 edx: c1017a00
esi: fffedffc edi: 00006000 ebp: c1017a00 esp: f6c99e84
ds: 007b es: 007b ss: 0068
Process bzip2 (pid: 11701, threadinfo=f6c98000 task=c0ec8560)
Stack: c0143f21 c1017a00 00000007 c0ecab7c c0ecab7c 00bd0067 00000000
bfffa000
c04f9c94 c03fa000 c0ecac00 c0000000 00000000 c0144087 c04f9c94 c0ecabfc
bfffa000 00006000 00000000 c04f9c94 bfffa000 c0ecac00 c0000000 00000000
Call Trace:
[<c0143f21>] zap_pte_range+0x161/0x270
[<c0144087>] zap_pmd_range+0x57/0x80
[<c01440fb>] unmap_page_range+0x4b/0x80
[<c014422d>] unmap_vmas+0xfd/0x1c0
[<c0148a53>] exit_mmap+0x83/0x160
[<c011abb4>] mmput+0x64/0xa0
[<c011ef42>] do_exit+0x152/0x420
[<c011f29a>] do_group_exit+0x3a/0xb0
[<c0105c07>] syscall_call+0x7/0xb
Code: 26 00 8b 54 24 04 8b 02 f6 c4 08 75 28 83 42 08 ff 0f 98 c0 84 c0 74
11 8b 42 08 40 78 0d 9c 58 fa ff 0d 90 7e 50 c0 50 9d 90 c3 <0f> 0b d9 01 6d
eb 3c c0 eb e9 0f 0b d6 01 6d eb 3c c0 eb ce 8d
<6>note: bzip2[11701] exited with preempt_count 2
bad: scheduling while atomic!
[<c03aac06>] schedule+0x4c6/0x4d0
[<c0155773>] wake_up_buffer+0x13/0x40
[<c01558e3>] unlock_buffer+0x13/0x20
[<c015903f>] ll_rw_block+0x4f/0x80
[<c01a8212>] search_by_key+0xfc2/0x1030
[<c0268550>] pty_write+0x130/0x140
[<c02b8897>] ppp_async_push+0x97/0x170
[<c02b87f2>] ppp_async_send+0x42/0x50
[<c02b3e68>] ppp_push+0x98/0x100
[<c0124983>] __mod_timer+0x123/0x170
[<c0328e09>] htb_delay_by+0x49/0xb0
[<c032903f>] htb_dequeue+0x1cf/0x260
[<c01a8331>] search_for_position_by_key+0xb1/0x3e0
[<c031fa77>] qdisc_restart+0x17/0x1d0
[<c0314c61>] net_tx_action+0xa1/0xd0
[<c0191629>] make_cpu_key+0x59/0x70
[<c01aa2f6>] reiserfs_do_truncate+0xc6/0x5a0
[<c019529d>] reiserfs_truncate_file+0xed/0x240
[<c0196de6>] reiserfs_file_release+0x266/0x470
[<c016bba4>] dput+0x24/0x210
[<c01554e0>] __fput+0x110/0x130
[<c0153c09>] filp_close+0x59/0x90
[<c011e23a>] put_files_struct+0x5a/0xc0
[<c011ef7d>] do_exit+0x18d/0x420
[<c0107220>] do_invalid_op+0x0/0x120
[<c0106e68>] die+0x188/0x190
[<c014a8f9>] page_remove_rmap+0x29/0x40
[<c0115676>] fixup_exception+0x16/0x60
[<c0107332>] do_invalid_op+0x112/0x120
[<c014a8f9>] page_remove_rmap+0x29/0x40
[<c0124eeb>] update_wall_time+0xb/0x40
[<c012535f>] do_timer+0xdf/0xf0
[<c01212bd>] __do_softirq+0x7d/0x90
[<c0106611>] error_code+0x2d/0x38
[<c014a8f9>] page_remove_rmap+0x29/0x40
[<c0143f21>] zap_pte_range+0x161/0x270
[<c0144087>] zap_pmd_range+0x57/0x80
[<c01440fb>] unmap_page_range+0x4b/0x80
[<c014422d>] unmap_vmas+0xfd/0x1c0
[<c0148a53>] exit_mmap+0x83/0x160
[<c011abb4>] mmput+0x64/0xa0
[<c011ef42>] do_exit+0x152/0x420
[<c011f29a>] do_group_exit+0x3a/0xb0
[<c0105c07>] syscall_call+0x7/0xb
==============================

Regards,

Mike

