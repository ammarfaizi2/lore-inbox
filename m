Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262634AbUKEJlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262634AbUKEJlm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 04:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262637AbUKEJlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 04:41:42 -0500
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:44434 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S262634AbUKEJl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 04:41:27 -0500
From: Lorenzo Allegrucci <l_allegrucci@yahoo.it>
Organization: -ENOENT
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.10-rc1-mm3
Date: Fri, 5 Nov 2004 10:41:17 +0100
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <20041105001328.3ba97e08.akpm@osdl.org>
In-Reply-To: <20041105001328.3ba97e08.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411051041.17940.l_allegrucci@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 05 November 2004 09:13, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm3/

------------[ cut here ]------------
kernel BUG at mm/memory.c:156!
invalid operand: 0000 [#1]
PREEMPT 
Modules linked in: ipv6 tun dm_mod emu10k1 sound soundcore ac97_codec unix
CPU:    0
EIP:    0060:[clear_page_range+276/304]    Not tainted VLI
EFLAGS: 00010206   (2.6.10-rc1-mm3) 
EIP is at clear_page_range+0x114/0x130
eax: daffc000   ebx: 00483fff   ecx: c03b7088   edx: daffc000
esi: 00000000   edi: 00080000   ebp: dca51ed0   esp: dca51ea8
ds: 007b   es: 007b   ss: 0068
Process shmt04 (pid: 4854, threadinfo=dca51000 task=de374510)
Stack: 00000000 00004000 dca51ef0 c0144fdb daffc000 daffc000 00000000 00483fff 
       00000000 00080000 dca51ef0 c0149131 c03b7088 00000000 00483fff c5eee8e0 
       00084000 00080000 dca51f28 c014928b c03b7088 00000000 00080000 00084000 
Call Trace:
 [show_stack+127/160] show_stack+0x7f/0xa0
 [show_registers+346/448] show_registers+0x15a/0x1c0
 [die+240/400] die+0xf0/0x190
 [do_invalid_op+256/272] do_invalid_op+0x100/0x110
 [error_code+43/48] error_code+0x2b/0x30
 [free_pgtables+129/160] free_pgtables+0x81/0xa0
 [unmap_region+155/224] unmap_region+0x9b/0xe0
 [do_munmap+283/416] do_munmap+0x11b/0x1a0
 [sys_shmdt+199/352] sys_shmdt+0xc7/0x160
 [sys_ipc+521/576] sys_ipc+0x209/0x240
 [syscall_call+7/11] syscall_call+0x7/0xb
Code: 00 eb db 89 54 24 0c c7 44 24 08 70 00 00 00 c7 44 24 04 fc 04 2e c0 c7 04 24 3e d1 2d c0 e8 84 45 fd ff c7 03 00 00 00 00 eb 81 <0f> 0b 9c 00 fc 04 2e c0 e9 22 ff ff ff eb 0d 90 90 90 90 90 90 
 <6>note: shmt04[4854] exited with preempt_count 1
scheduling while atomic: shmt04/0x00000001/4854
 [dump_stack+30/32] dump_stack+0x1e/0x20
 [schedule+1306/1312] schedule+0x51a/0x520
 [rwsem_down_read_failed+146/464] rwsem_down_read_failed+0x92/0x1d0
 [.text.lock.exit+107/231] .text.lock.exit+0x6b/0xe7
 [die+391/400] die+0x187/0x190
 [do_invalid_op+256/272] do_invalid_op+0x100/0x110
 [error_code+43/48] error_code+0x2b/0x30
 [free_pgtables+129/160] free_pgtables+0x81/0xa0
 [unmap_region+155/224] unmap_region+0x9b/0xe0
 [do_munmap+283/416] do_munmap+0x11b/0x1a0
 [sys_shmdt+199/352] sys_shmdt+0xc7/0x160
 [sys_ipc+521/576] sys_ipc+0x209/0x240
 [syscall_call+7/11] syscall_call+0x7/0xb
------------[ cut here ]------------
kernel BUG at mm/memory.c:156!
invalid operand: 0000 [#2]
PREEMPT 
Modules linked in: ipv6 tun dm_mod emu10k1 sound soundcore ac97_codec unix
CPU:    0
EIP:    0060:[clear_page_range+276/304]    Not tainted VLI
EFLAGS: 00010206   (2.6.10-rc1-mm3) 
EIP is at clear_page_range+0x114/0x130
eax: c1849000   ebx: 00483fff   ecx: c03b7088   edx: c1849000
esi: 00000000   edi: 00080000   ebp: dd937ed0   esp: dd937ea8
ds: 007b   es: 007b   ss: 0068
Process shmt06 (pid: 4857, threadinfo=dd937000 task=dd0be0e0)
Stack: 00000000 00004000 dd937ef0 c0144fdb c1849000 c1849000 00000000 00483fff 
       00000000 00080000 dd937ef0 c0149131 c03b7088 00000000 00483fff c5eee4a0 
       00084000 00080000 dd937f28 c014928b c03b7088 00000000 00080000 00084000 
Call Trace:
 [show_stack+127/160] show_stack+0x7f/0xa0
 [show_registers+346/448] show_registers+0x15a/0x1c0
 [die+240/400] die+0xf0/0x190
 [do_invalid_op+256/272] do_invalid_op+0x100/0x110
 [error_code+43/48] error_code+0x2b/0x30
 [free_pgtables+129/160] free_pgtables+0x81/0xa0
 [unmap_region+155/224] unmap_region+0x9b/0xe0
 [do_munmap+283/416] do_munmap+0x11b/0x1a0
 [sys_shmdt+199/352] sys_shmdt+0xc7/0x160
 [sys_ipc+521/576] sys_ipc+0x209/0x240
 [syscall_call+7/11] syscall_call+0x7/0xb
Code: 00 eb db 89 54 24 0c c7 44 24 08 70 00 00 00 c7 44 24 04 fc 04 2e c0 c7 04 24 3e d1 2d c0 e8 84 45 fd ff c7 03 00 00 00 00 eb 81 <0f> 0b 9c 00 fc 04 2e c0 e9 22 ff ff ff eb 0d 90 90 90 90 90 90 
 <6>note: shmt06[4857] exited with preempt_count 1
scheduling while atomic: shmt06/0x00000001/4857
 [dump_stack+30/32] dump_stack+0x1e/0x20
 [schedule+1306/1312] schedule+0x51a/0x520
 [rwsem_down_read_failed+146/464] rwsem_down_read_failed+0x92/0x1d0
 [.text.lock.exit+107/231] .text.lock.exit+0x6b/0xe7
 [die+391/400] die+0x187/0x190
 [do_invalid_op+256/272] do_invalid_op+0x100/0x110
 [error_code+43/48] error_code+0x2b/0x30
 [free_pgtables+129/160] free_pgtables+0x81/0xa0
 [unmap_region+155/224] unmap_region+0x9b/0xe0
 [do_munmap+283/416] do_munmap+0x11b/0x1a0
 [sys_shmdt+199/352] sys_shmdt+0xc7/0x160
 [sys_ipc+521/576] sys_ipc+0x209/0x240
 [syscall_call+7/11] syscall_call+0x7/0xb

-- 
I route therefore you are
