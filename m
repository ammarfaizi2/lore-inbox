Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264975AbTGGNYU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 09:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264981AbTGGNYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 09:24:20 -0400
Received: from dns.toxicfilms.tv ([150.254.37.24]:58766 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S264975AbTGGNYL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 09:24:11 -0400
Date: Mon, 7 Jul 2003 15:38:43 +0200 (CEST)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: OOPS: 2.5.74-mm2
In-Reply-To: <20030703023714.55d13934.akpm@osdl.org>
Message-ID: <Pine.LNX.4.51.0307071536340.5102@dns.toxicfilms.tv>
References: <20030703023714.55d13934.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

2.5.74-mm2 oopses here just after booting. I get these dumps.
Once they stoped, i pressed alt+ctl+del (noted in the dump below) and they
started again, and the computer stopeed rebooting.

Regards,
Maciej

Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c0118d2d
*pde = 00000000
Oops: 0002 [#1]
PREEMPT
CPU:    0
EIP:    0060:[schedule+143/1022]    Not tainted VLI
EFLAGS: 00010097
EIP is at schedule+0x8f/0x3fe
eax: 00000001   ebx: d9bcb940   ecx: d9bcb960   edx: ffffffff
esi: 00000000   edi: c04558a0   ebp: d9b39ee0   esp: d9b39eb8
ds: 007b   es: 007b   ss: 0068
Process bash (pid: 462, threadinfo=d9b38000 task=d9bcb940)
Stack: d9ebd980 c1403dc8 c1403dc8 00000000 40174560 d9ebd980 d9bec3c0 d9c06e6c
       d9c06e00 d9b39f08 00000001 c015a837 00000000 d9bcb940 c011a7f9 d9b39f14
       d9b39f14 d9ebd980 d9ebd9a0 d9bec3c0 00000000 d9bcb940 c011a7f9 d9b80f40
Call Trace:
 [pipe_wait+123/154] pipe_wait+0x7b/0x9a
 [autoremove_wake_function+0/79] autoremove_wake_function+0x0/0x4f
 [autoremove_wake_function+0/79] autoremove_wake_function+0x0/0x4f
 [pipe_read+319/573] pipe_read+0x13f/0x23d
 [update_process_times+70/82] update_process_times+0x46/0x52
 [vfs_read+176/281] vfs_read+0xb0/0x119
 [sys_read+66/99] sys_read+0x42/0x63
 [syscall_call+7/11] syscall_call+0x7/0xb

Code: 17 04 75 6d 8b 03 85 c0 74 67 83 f8 01 0f 84 3f 03 00 00 83 2d a0 58 45 c0 01 8b 03 83 f8 02 0f 84 1d 03 00 00 8b 73 28 8d 4b 20 <83> 2e 01 8b 51 04 39 0a 0f 85 fc 02 00 00 8b 43 20 39 48 04 0f
 <6>note: bash[462] exited with preempt_count 2
bad: scheduling while atomic!
Call Trace:
 [schedule+1017/1022] schedule+0x3f9/0x3fe
 [generic_file_aio_write_nolock+1574/2931] generic_file_aio_write_nolock+0x626/0xb73
 [buffered_rmqueue+229/434] buffered_rmqueue+0xe5/0x1b2
 [vgacon_cursor+236/478] vgacon_cursor+0xec/0x1de
 [set_cursor+117/142] set_cursor+0x75/0x8e
 [vt_console_print+491/747] vt_console_print+0x1eb/0x2eb
 [generic_file_aio_write+137/253] generic_file_aio_write+0x89/0xfd
 [ext3_file_write+68/194] ext3_file_write+0x44/0xc2
 [do_sync_write+182/227] do_sync_write+0xb6/0xe3
 [mempool_free+81/177] mempool_free+0x51/0xb1
 [autoremove_wake_function+0/79] autoremove_wake_function+0x0/0x4f
 [check_free_space+225/364] check_free_space+0xe1/0x16c
 [poke_blanked_console+92/111] poke_blanked_console+0x5c/0x6f
 [vt_console_print+521/747] vt_console_print+0x209/0x2eb
 [try_to_wake_up+160/410] try_to_wake_up+0xa0/0x19a
 [do_acct_process+637/653] do_acct_process+0x27d/0x28d
 [do_page_fault+0/1113] do_page_fault+0x0/0x459
 [acct_process+72/132] acct_process+0x48/0x84
 [do_exit+135/1102] do_exit+0x87/0x44e
 [do_page_fault+0/1113] do_page_fault+0x0/0x459
 [do_divide_error+0/250] do_divide_error+0x0/0xfa
 [do_page_fault+300/1113] do_page_fault+0x12c/0x459
 [__rmqueue+204/305] __rmqueue+0xcc/0x131
 [buffered_rmqueue+229/434] buffered_rmqueue+0xe5/0x1b2
 [do_page_fault+0/1113] do_page_fault+0x0/0x459
 [error_code+45/56] error_code+0x2d/0x38
 [check_version+120/216] check_version+0x78/0xd8
 [schedule+143/1022] schedule+0x8f/0x3fe
 [pipe_wait+123/154] pipe_wait+0x7b/0x9a
 [autoremove_wake_function+0/79] autoremove_wake_function+0x0/0x4f
 [autoremove_wake_function+0/79] autoremove_wake_function+0x0/0x4f
 [pipe_read+319/573] pipe_read+0x13f/0x23d
 [update_process_times+70/82] update_process_times+0x46/0x52
 [vfs_read+176/281] vfs_read+0xb0/0x119
 [sys_read+66/99] sys_read+0x42/0x63
 [syscall_call+7/11] syscall_call+0x7/0xb

Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c0118d2d
*pde = 00000000
Oops: 0002 [#2]
PREEMPT
CPU:    0
EIP:    0060:[schedule+143/1022]    Not tainted VLI
EFLAGS: 00010006
EIP is at schedule+0x8f/0x3fe
eax: 00000008   ebx: d9bcb940   ecx: d9bcb960   edx: ffffffff
esi: 00000000   edi: c04558a0   ebp: d9b39d88   esp: d9b39d60
ds: 007b   es: 007b   ss: 0068
Process bash (pid: 462, threadinfo=d9b38000 task=d9bcb940)
Stack: 00000020 00000009 d9bcb990 dbdc7b80 d9bcb9e0 00000286 dbdc7b80 dbfeea60
       00000002 00000000 d9bcb940 c011e785 d9bcb940 dbcdaae0 000001ce 00000002
       d9b39e84 d9b38000 c0116b5c d9bcb940 c010a006 0000000b c034e105 00000002
Call Trace:
 [do_exit+625/1102] do_exit+0x271/0x44e
 [do_page_fault+0/1113] do_page_fault+0x0/0x459
 [do_divide_error+0/250] do_divide_error+0x0/0xfa
 [do_page_fault+300/1113] do_page_fault+0x12c/0x459
 [__rmqueue+204/305] __rmqueue+0xcc/0x131
 [buffered_rmqueue+229/434] buffered_rmqueue+0xe5/0x1b2
 [do_page_fault+0/1113] do_page_fault+0x0/0x459
 [error_code+45/56] error_code+0x2d/0x38
 [check_version+120/216] check_version+0x78/0xd8
 [schedule+143/1022] schedule+0x8f/0x3fe
 [pipe_wait+123/154] pipe_wait+0x7b/0x9a
 [autoremove_wake_function+0/79] autoremove_wake_function+0x0/0x4f
 [autoremove_wake_function+0/79] autoremove_wake_function+0x0/0x4f
 [pipe_read+319/573] pipe_read+0x13f/0x23d
 [update_process_times+70/82] update_process_times+0x46/0x52
 [vfs_read+176/281] vfs_read+0xb0/0x119
 [sys_read+66/99] sys_read+0x42/0x63
 [syscall_call+7/11] syscall_call+0x7/0xb

Code: 17 04 75 6d 8b 03 85 c0 74 67 83 f8 01 0f 84 3f 03 00 00 83 2d a0 58 45 c0 01 8b 03 83 f8 02 0f 84 1d 03 00 00 8b 73 28 8d 4b 20 <83> 2e 01 8b 51 04 39 0a 0f 85 fc 02 00 00 8b 43 20 39 48 04 0f
 <6>note: bash[462] exited with preempt_count 4
bad: scheduling while atomic!
Call Trace:
 [schedule+1017/1022] schedule+0x3f9/0x3fe
 [generic_file_aio_write_nolock+1574/2931] generic_file_aio_write_nolock+0x626/0xb73
 [vgacon_cursor+236/478] vgacon_cursor+0xec/0x1de
 [set_cursor+117/142] set_cursor+0x75/0x8e
 [vt_console_print+491/747] vt_console_print+0x1eb/0x2eb
 [generic_file_aio_write+137/253] generic_file_aio_write+0x89/0xfd
 [ext3_file_write+68/194] ext3_file_write+0x44/0xc2
 [do_sync_write+182/227] do_sync_write+0xb6/0xe3
 [vgacon_scroll+386/555] vgacon_scroll+0x182/0x22b
 [autoremove_wake_function+0/79] autoremove_wake_function+0x0/0x4f
 [check_free_space+225/364] check_free_space+0xe1/0x16c
 [poke_blanked_console+92/111] poke_blanked_console+0x5c/0x6f
 [vt_console_print+521/747] vt_console_print+0x209/0x2eb
 [try_to_wake_up+160/410] try_to_wake_up+0xa0/0x19a
 [do_acct_process+637/653] do_acct_process+0x27d/0x28d
 [do_page_fault+0/1113] do_page_fault+0x0/0x459
 [acct_process+72/132] acct_process+0x48/0x84
 [do_exit+135/1102] do_exit+0x87/0x44e
 [do_page_fault+0/1113] do_page_fault+0x0/0x459
 [do_divide_error+0/250] do_divide_error+0x0/0xfa
 [do_page_fault+300/1113] do_page_fault+0x12c/0x459
 [do_notify_parent+329/1279] do_notify_parent+0x149/0x4ff
 [kill_fasync+48/82] kill_fasync+0x30/0x52
 [pipe_release+153/203] pipe_release+0x99/0xcb
 [do_page_fault+0/1113] do_page_fault+0x0/0x459
 [error_code+45/56] error_code+0x2d/0x38
 [schedule+143/1022] schedule+0x8f/0x3fe
 [do_exit+625/1102] do_exit+0x271/0x44e
 [do_page_fault+0/1113] do_page_fault+0x0/0x459
 [do_divide_error+0/250] do_divide_error+0x0/0xfa
 [do_page_fault+300/1113] do_page_fault+0x12c/0x459
 [__rmqueue+204/305] __rmqueue+0xcc/0x131
 [buffered_rmqueue+229/434] buffered_rmqueue+0xe5/0x1b2
 [do_page_fault+0/1113] do_page_fault+0x0/0x459
 [error_code+45/56] error_code+0x2d/0x38
 [check_version+120/216] check_version+0x78/0xd8
 [schedule+143/1022] schedule+0x8f/0x3fe
 [pipe_wait+123/154] pipe_wait+0x7b/0x9a
 [autoremove_wake_function+0/79] autoremove_wake_function+0x0/0x4f
 [autoremove_wake_function+0/79] autoremove_wake_function+0x0/0x4f
 [pipe_read+319/573] pipe_read+0x13f/0x23d
 [update_process_times+70/82] update_process_times+0x46/0x52
 [vfs_read+176/281] vfs_read+0xb0/0x119
 [sys_read+66/99] sys_read+0x42/0x63
 [syscall_call+7/11] syscall_call+0x7/0xb

Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c0118d2d
*pde = 00000000
Oops: 0002 [#3]
PREEMPT
CPU:    0
EIP:    0060:[schedule+143/1022]    Not tainted VLI
EFLAGS: 00010006
EIP is at schedule+0x8f/0x3fe
eax: 00000008   ebx: d9bcb940   ecx: d9bcb960   edx: ffffffff
esi: 00000000   edi: c04558a0   ebp: d9b39c30   esp: d9b39c08
ds: 007b   es: 007b   ss: 0068
Process bash (pid: 462, threadinfo=d9b38000 task=d9bcb940)
Stack: 00000000 00000000 d9bcb990 0000000b d9bcb9e0 d9bcb940 c0132844 00000000
       00000004 00000000 d9bcb940 c011e785 d9bcb940 00000000 000001ce 00000004
       d9b39d2c d9b38000 c0116b5c d9bcb940 c010a006 0000000b c034e105 00000002
Call Trace:
 [acct_process+79/132] acct_process+0x4f/0x84
 [do_exit+625/1102] do_exit+0x271/0x44e
 [do_page_fault+0/1113] do_page_fault+0x0/0x459
 [do_divide_error+0/250] do_divide_error+0x0/0xfa
 [do_page_fault+300/1113] do_page_fault+0x12c/0x459
 [do_notify_parent+329/1279] do_notify_parent+0x149/0x4ff
 [kill_fasync+48/82] kill_fasync+0x30/0x52
 [pipe_release+153/203] pipe_release+0x99/0xcb
 [do_page_fault+0/1113] do_page_fault+0x0/0x459
 [error_code+45/56] error_code+0x2d/0x38
 [schedule+143/1022] schedule+0x8f/0x3fe
 [do_exit+625/1102] do_exit+0x271/0x44e
 [do_page_fault+0/1113] do_page_fault+0x0/0x459
 [do_divide_error+0/250] do_divide_error+0x0/0xfa
 [do_page_fault+300/1113] do_page_fault+0x12c/0x459
 [__rmqueue+204/305] __rmqueue+0xcc/0x131
 [buffered_rmqueue+229/434] buffered_rmqueue+0xe5/0x1b2
 [do_page_fault+0/1113] do_page_fault+0x0/0x459
 [error_code+45/56] error_code+0x2d/0x38
 [check_version+120/216] check_version+0x78/0xd8
 [schedule+143/1022] schedule+0x8f/0x3fe
 [pipe_wait+123/154] pipe_wait+0x7b/0x9a
 [autoremove_wake_function+0/79] autoremove_wake_function+0x0/0x4f
 [autoremove_wake_function+0/79] autoremove_wake_function+0x0/0x4f
 [pipe_read+319/573] pipe_read+0x13f/0x23d
 [update_process_times+70/82] update_process_times+0x46/0x52
 [vfs_read+176/281] vfs_read+0xb0/0x119
 [sys_read+66/99] sys_read+0x42/0x63
 [syscall_call+7/11] syscall_call+0x7/0xb

Code: 17 04 75 6d 8b 03 85 c0 74 67 83 f8 01 0f 84 3f 03 00 00 83 2d a0 58 45 c0 01 8b 03 83 f8 02 0f 84 1d 03 00 00 8b 73 28 8d 4b 20 <83> 2e 01 8b 51 04 39 0a 0f 85 fc 02 00 00 8b 43 20 39 48 04 0f
 <6>note: bash[462] exited with preempt_count 6
bad: scheduling while atomic!
Call Trace:
 [schedule+1017/1022] schedule+0x3f9/0x3fe
 [generic_file_aio_write_nolock+1574/2931] generic_file_aio_write_nolock+0x626/0xb73
 [try_to_wake_up+160/410] try_to_wake_up+0xa0/0x19a
 [__down+268/290] __down+0x10c/0x122
 [default_wake_function+0/46] default_wake_function+0x0/0x2e
 [vt_console_print+491/747] vt_console_print+0x1eb/0x2eb
 [generic_file_aio_write+137/253] generic_file_aio_write+0x89/0xfd
 [ext3_file_write+68/194] ext3_file_write+0x44/0xc2
 [do_sync_write+182/227] do_sync_write+0xb6/0xe3
 [mempool_free+81/177] mempool_free+0x51/0xb1
 [autoremove_wake_function+0/79] autoremove_wake_function+0x0/0x4f
 [check_free_space+225/364] check_free_space+0xe1/0x16c
 [poke_blanked_console+92/111] poke_blanked_console+0x5c/0x6f
 [vt_console_print+521/747] vt_console_print+0x209/0x2eb
 [try_to_wake_up+160/410] try_to_wake_up+0xa0/0x19a
 [do_acct_process+637/653] do_acct_process+0x27d/0x28d
 [do_page_fault+0/1113] do_page_fault+0x0/0x459
 [acct_process+72/132] acct_process+0x48/0x84
 [do_exit+135/1102] do_exit+0x87/0x44e
 [do_page_fault+0/1113] do_page_fault+0x0/0x459
 [do_divide_error+0/250] do_divide_error+0x0/0xfa
 [do_page_fault+300/1113] do_page_fault+0x12c/0x459
 [do_notify_parent+329/1279] do_notify_parent+0x149/0x4ff
 [try_to_wake_up+160/410] try_to_wake_up+0xa0/0x19a
 [do_page_fault+0/1113] do_page_fault+0x0/0x459
 [error_code+45/56] error_code+0x2d/0x38
 [schedule+143/1022] schedule+0x8f/0x3fe
 [acct_process+79/132] acct_process+0x4f/0x84
 [do_exit+625/1102] do_exit+0x271/0x44e
 [do_page_fault+0/1113] do_page_fault+0x0/0x459
 [do_divide_error+0/250] do_divide_error+0x0/0xfa
 [do_page_fault+300/1113] do_page_fault+0x12c/0x459
 [do_notify_parent+329/1279] do_notify_parent+0x149/0x4ff
 [kill_fasync+48/82] kill_fasync+0x30/0x52
 [pipe_release+153/203] pipe_release+0x99/0xcb
 [do_page_fault+0/1113] do_page_fault+0x0/0x459
 [error_code+45/56] error_code+0x2d/0x38
 [schedule+143/1022] schedule+0x8f/0x3fe
 [do_exit+625/1102] do_exit+0x271/0x44e
 [do_page_fault+0/1113] do_page_fault+0x0/0x459
 [do_divide_error+0/250] do_divide_error+0x0/0xfa
 [do_page_fault+300/1113] do_page_fault+0x12c/0x459
 [__rmqueue+204/305] __rmqueue+0xcc/0x131
 [buffered_rmqueue+229/434] buffered_rmqueue+0xe5/0x1b2
 [do_page_fault+0/1113] do_page_fault+0x0/0x459
 [error_code+45/56] error_code+0x2d/0x38
 [check_version+120/216] check_version+0x78/0xd8
 [schedule+143/1022] schedule+0x8f/0x3fe
 [pipe_wait+123/154] pipe_wait+0x7b/0x9a
 [autoremove_wake_function+0/79] autoremove_wake_function+0x0/0x4f
 [autoremove_wake_function+0/79] autoremove_wake_function+0x0/0x4f
 [pipe_read+319/573] pipe_read+0x13f/0x23d
 [update_process_times+70/82] update_process_times+0x46/0x52
 [vfs_read+176/281] vfs_read+0xb0/0x119
 [sys_read+66/99] sys_read+0x42/0x63
 [syscall_call+7/11] syscall_call+0x7/0xb

I pressed alt_ctl+del here:

Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c0118d2d
*pde = 00000000
Oops: 0002 [#4]
PREEMPT
CPU:    0
EIP:    0060:[schedule+143/1022]    Not tainted VLI
EFLAGS: 00010006
EIP is at schedule+0x8f/0x3fe
eax: 00000008   ebx: d9bcb940   ecx: d9bcb960   edx: ffffffff
esi: 00000000   edi: c04558a0   ebp: d9b39ad8   esp: d9b39ab0
ds: 007b   es: 007b   ss: 0068
Process bash (pid: 462, threadinfo=d9b38000 task=d9bcb940)
Stack: 00000000 00000000 d9bcb990 0000000b d9bcb9e0 d9bcb940 c0132844 00000000
       00000006 00000000 d9bcb940 c011e785 d9bcb940 00000000 000001ce 00000006
       d9b39bd4 d9b38000 c0116b5c d9bcb940 c010a006 0000000b c034e105 00000002
Call Trace:
 [acct_process+79/132] acct_process+0x4f/0x84
 [do_exit+625/1102] do_exit+0x271/0x44e
 [do_page_fault+0/1113] do_page_fault+0x0/0x459
 [do_divide_error+0/250] do_divide_error+0x0/0xfa
 [do_page_fault+300/1113] do_page_fault+0x12c/0x459
 [do_notify_parent+329/1279] do_notify_parent+0x149/0x4ff
 [try_to_wake_up+160/410] try_to_wake_up+0xa0/0x19a
 [do_page_fault+0/1113] do_page_fault+0x0/0x459
 [error_code+45/56] error_code+0x2d/0x38
 [schedule+143/1022] schedule+0x8f/0x3fe
 [acct_process+79/132] acct_process+0x4f/0x84
 [do_exit+625/1102] do_exit+0x271/0x44e
 [do_page_fault+0/1113] do_page_fault+0x0/0x459
 [do_divide_error+0/250] do_divide_error+0x0/0xfa
 [do_page_fault+300/1113] do_page_fault+0x12c/0x459
 [do_notify_parent+329/1279] do_notify_parent+0x149/0x4ff
 [kill_fasync+48/82] kill_fasync+0x30/0x52
 [pipe_release+153/203] pipe_release+0x99/0xcb
 [do_page_fault+0/1113] do_page_fault+0x0/0x459
 [error_code+45/56] error_code+0x2d/0x38
 [schedule+143/1022] schedule+0x8f/0x3fe
 [do_exit+625/1102] do_exit+0x271/0x44e
 [do_page_fault+0/1113] do_page_fault+0x0/0x459
 [do_divide_error+0/250] do_divide_error+0x0/0xfa
 [do_page_fault+300/1113] do_page_fault+0x12c/0x459
 [__rmqueue+204/305] __rmqueue+0xcc/0x131
 [buffered_rmqueue+229/434] buffered_rmqueue+0xe5/0x1b2
 [do_page_fault+0/1113] do_page_fault+0x0/0x459
 [error_code+45/56] error_code+0x2d/0x38
 [check_version+120/216] check_version+0x78/0xd8
 [schedule+143/1022] schedule+0x8f/0x3fe
 [pipe_wait+123/154] pipe_wait+0x7b/0x9a
 [autoremove_wake_function+0/79] autoremove_wake_function+0x0/0x4f
 [autoremove_wake_function+0/79] autoremove_wake_function+0x0/0x4f
 [pipe_read+319/573] pipe_read+0x13f/0x23d
 [update_process_times+70/82] update_process_times+0x46/0x52
 [vfs_read+176/281] vfs_read+0xb0/0x119
 [sys_read+66/99] sys_read+0x42/0x63
 [syscall_call+7/11] syscall_call+0x7/0xb

Code: 17 04 75 6d 8b 03 85 c0 74 67 83 f8 01 0f 84 3f 03 00 00 83 2d a0 58 45 c0 01 8b 03 83 f8 02 0f 84 1d 03 00 00 8b 73 28 8d 4b 20 <83> 2e 01 8b 51 04 39 0a 0f 85 fc 02 00 00 8b 43 20 39 48 04 0f
 <6>note: bash[462] exited with preempt_count 8
bad: scheduling while atomic!
Call Trace:
 [schedule+1017/1022] schedule+0x3f9/0x3fe
 [generic_file_aio_write_nolock+1574/2931] generic_file_aio_write_nolock+0x626/0xb73
 [try_to_wake_up+160/410] try_to_wake_up+0xa0/0x19a
 [__down+268/290] __down+0x10c/0x122
 [default_wake_function+0/46] default_wake_function+0x0/0x2e
 [vt_console_print+491/747] vt_console_print+0x1eb/0x2eb
 [generic_file_aio_write+137/253] generic_file_aio_write+0x89/0xfd
 [ext3_file_write+68/194] ext3_file_write+0x44/0xc2
 [do_sync_write+182/227] do_sync_write+0xb6/0xe3
 [vgacon_scroll+386/555] vgacon_scroll+0x182/0x22b
 [autoremove_wake_function+0/79] autoremove_wake_function+0x0/0x4f
 [check_free_space+225/364] check_free_space+0xe1/0x16c
 [poke_blanked_console+92/111] poke_blanked_console+0x5c/0x6f
 [vt_console_print+521/747] vt_console_print+0x209/0x2eb
 [try_to_wake_up+160/410] try_to_wake_up+0xa0/0x19a
 [do_acct_process+637/653] do_acct_process+0x27d/0x28d
 [do_page_fault+0/1113] do_page_fault+0x0/0x459
 [acct_process+72/132] acct_process+0x48/0x84
 [do_exit+135/1102] do_exit+0x87/0x44e
 [do_page_fault+0/1113] do_page_fault+0x0/0x459
 [do_divide_error+0/250] do_divide_error+0x0/0xfa
 [do_page_fault+300/1113] do_page_fault+0x12c/0x459
 [do_notify_parent+329/1279] do_notify_parent+0x149/0x4ff
 [try_to_wake_up+160/410] try_to_wake_up+0xa0/0x19a
 [do_page_fault+0/1113] do_page_fault+0x0/0x459
 [error_code+45/56] error_code+0x2d/0x38
 [schedule+143/1022] schedule+0x8f/0x3fe
 [acct_process+79/132] acct_process+0x4f/0x84
 [do_exit+625/1102] do_exit+0x271/0x44e
 [do_page_fault+0/1113] do_page_fault+0x0/0x459
 [do_divide_error+0/250] do_divide_error+0x0/0xfa
 [do_page_fault+300/1113] do_page_fault+0x12c/0x459
 [do_notify_parent+329/1279] do_notify_parent+0x149/0x4ff
 [try_to_wake_up+160/410] try_to_wake_up+0xa0/0x19a
 [do_page_fault+0/1113] do_page_fault+0x0/0x459
 [error_code+45/56] error_code+0x2d/0x38
 [schedule+143/1022] schedule+0x8f/0x3fe
 [acct_process+79/132] acct_process+0x4f/0x84
 [do_exit+625/1102] do_exit+0x271/0x44e
 [do_page_fault+0/1113] do_page_fault+0x0/0x459
 [do_divide_error+0/250] do_divide_error+0x0/0xfa
 [do_page_fault+300/1113] do_page_fault+0x12c/0x459
 [do_notify_parent+329/1279] do_notify_parent+0x149/0x4ff
 [kill_fasync+48/82] kill_fasync+0x30/0x52
 [pipe_release+153/203] pipe_release+0x99/0xcb
 [do_page_fault+0/1113] do_page_fault+0x0/0x459
 [error_code+45/56] error_code+0x2d/0x38
 [schedule+143/1022] schedule+0x8f/0x3fe
 [do_exit+625/1102] do_exit+0x271/0x44e
 [do_page_fault+0/1113] do_page_fault+0x0/0x459
 [do_divide_error+0/250] do_divide_error+0x0/0xfa
 [do_page_fault+300/1113] do_page_fault+0x12c/0x459
 [__rmqueue+204/305] __rmqueue+0xcc/0x131
 [buffered_rmqueue+229/434] buffered_rmqueue+0xe5/0x1b2
 [do_page_fault+0/1113] do_page_fault+0x0/0x459
 [error_code+45/56] error_code+0x2d/0x38
 [check_version+120/216] check_version+0x78/0xd8
 [schedule+143/1022] schedule+0x8f/0x3fe
 [pipe_wait+123/154] pipe_wait+0x7b/0x9a
 [autoremove_wake_function+0/79] autoremove_wake_function+0x0/0x4f
 [autoremove_wake_function+0/79] autoremove_wake_function+0x0/0x4f
 [pipe_read+319/573] pipe_read+0x13f/0x23d
 [update_process_times+70/82] update_process_times+0x46/0x52
 [vfs_read+176/281] vfs_read+0xb0/0x119
 [sys_read+66/99] sys_read+0x42/0x63
 [syscall_call+7/11] syscall_call+0x7/0xb
