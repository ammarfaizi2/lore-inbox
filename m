Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263557AbTDNQZC (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 12:25:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263559AbTDNQZC (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 12:25:02 -0400
Received: from 60.54.252.64.snet.net ([64.252.54.60]:25232 "EHLO
	hotmale.blue-labs.org") by vger.kernel.org with ESMTP
	id S263557AbTDNQY4 (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 12:24:56 -0400
Message-ID: <3E9AE396.4070907@blue-labs.org>
Date: Mon, 14 Apr 2003 12:36:38 -0400
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030411
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [OOPS] 2.5.66, cache_alloc_refill
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Bmilter: Processing completed, Bmilter version 0.1.1 build 917; timestamp 2003-04-14 12:36:45, message serial number 922984
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'll upgrade to 2.5.67 promptly, but in the meantime -- is this a known bug?

david

Apr 14 00:01:29 Huntington-Beach Unable to handle kernel paging request 
at virtual address fc4d0a50
Apr 14 00:01:29 Huntington-Beach printing eip:
Apr 14 00:01:29 Huntington-Beach c0158d9d
Apr 14 00:01:29 Huntington-Beach *pde = 00000000
Apr 14 00:01:29 Huntington-Beach Oops: 0000 [#2]
Apr 14 00:01:29 Huntington-Beach CPU:    0
Apr 14 00:01:29 Huntington-Beach EIP:    0060:[<c0158d9d>]    Not tainted
Apr 14 00:01:29 Huntington-Beach EFLAGS: 00010097
Apr 14 00:01:29 Huntington-Beach EIP is at cache_alloc_refill+0xfd/0x3d0
Apr 14 00:01:29 Huntington-Beach eax: 8e8d8e8e   ebx: c216d000   ecx: 
00000001   edx: 00000008
Apr 14 00:01:29 Huntington-Beach esi: c216d018   edi: 00000008   ebp: 
c0c5bcb8   esp: c0c5bc7c
Apr 14 00:01:29 Huntington-Beach ds: 007b   es: 007b   ss: 0068
Apr 14 00:01:29 Huntington-Beach Process rsync (pid: 791, 
threadinfo=c0c5a000 task=cf733320)
Apr 14 00:01:29 Huntington-Beach Stack: 00000001 00001000 c0b44de0 
c0b44d00 c0c5bcb8 c024a9dd c0c5bcf0 c138988c
Apr 14 00:01:29 Huntington-Beach c139ec80 c139ec88 c138987c 0000000b 
00000000 c139ec74 00000246 c0c5bce0
Apr 14 00:01:29 Huntington-Beach c015980f c139ec74 000000d0 c0c5bcf0 
00000001 00000000 cfc51800 cfc51800
Apr 14 00:01:29 Huntington-Beach Call Trace:
Apr 14 00:01:29 Huntington-Beach [<c024a9dd>] init_inode+0x12d/0x280
Apr 14 00:01:29 Huntington-Beach [<c015980f>] kmem_cache_alloc+0x13f/0x150
Apr 14 00:01:29 Huntington-Beach [<c025396b>] reiserfs_alloc_inode+0x1b/0x30
Apr 14 00:01:29 Huntington-Beach [<c019865e>] alloc_inode+0x1e/0x150
Apr 14 00:01:29 Huntington-Beach [<c01997b7>] get_new_inode+0x17/0x380
Apr 14 00:01:29 Huntington-Beach [<c024af80>] 
reiserfs_init_locked_inode+0x0/0x20
Apr 14 00:01:29 Huntington-Beach [<c024b100>] reiserfs_find_actor+0x0/0x30
Apr 14 00:01:29 Huntington-Beach [<c024b173>] reiserfs_iget+0x43/0xb0
Apr 14 00:01:29 Huntington-Beach [<c024b100>] reiserfs_find_actor+0x0/0x30
Apr 14 00:01:29 Huntington-Beach [<c024af80>] 
reiserfs_init_locked_inode+0x0/0x20
Apr 14 00:01:29 Huntington-Beach [<c0244776>] reiserfs_lookup+0x2c6/0x400
Apr 14 00:01:29 Huntington-Beach [<c01881e0>] real_lookup+0x190/0x250
Apr 14 00:01:29 Huntington-Beach [<c0188b0d>] do_lookup+0x8d/0xa0
Apr 14 00:01:29 Huntington-Beach [<c0189232>] link_path_walk+0x712/0xdc0
Apr 14 00:01:29 Huntington-Beach [<c015796b>] check_poison_obj+0x3b/0x1b0
Apr 14 00:01:29 Huntington-Beach [<c01597f2>] kmem_cache_alloc+0x122/0x150
Apr 14 00:01:29 Huntington-Beach [<c0189d3e>] __user_walk+0x3e/0x60
Apr 14 00:01:29 Huntington-Beach [<c0182d4b>] vfs_lstat+0x1b/0x60
Apr 14 00:01:29 Huntington-Beach [<c01833ab>] sys_lstat64+0x1b/0x40
Apr 14 00:01:29 Huntington-Beach [<c010b0ab>] syscall_call+0x7/0xb
Apr 14 00:01:29 Huntington-Beach


Apr 14 00:01:29 Huntington-Beach Code: 8b 04 86 83 f8 ff 75 ef 8b 7b 10 
89 d0 29 f8 39 c1 0f 85 11
Apr 14 00:01:29 Huntington-Beach <6>note: rsync[791] exited with 
preempt_count 2
Apr 14 00:01:29 Huntington-Beach mm/slab.c:2255: 
spin_lock(mm/slab.c:c139ecb4) already locked by mm/slab.c/1677
Apr 14 00:04:57 Huntington-Beach Unable to handle kernel paging request 
at virtual address fc4d0a50
Apr 14 00:04:57 Huntington-Beach printing eip:
Apr 14 00:04:57 Huntington-Beach c0158d9d
Apr 14 00:04:57 Huntington-Beach *pde = 00000000
Apr 14 00:04:57 Huntington-Beach Oops: 0000 [#3]
Apr 14 00:04:57 Huntington-Beach CPU:    0
Apr 14 00:04:57 Huntington-Beach EIP:    0060:[<c0158d9d>]    Not tainted
Apr 14 00:04:57 Huntington-Beach EFLAGS: 00010097
Apr 14 00:04:57 Huntington-Beach EIP is at cache_alloc_refill+0xfd/0x3d0
Apr 14 00:04:57 Huntington-Beach eax: 8e8d8e8e   ebx: c216d000   ecx: 
00000001   edx: 00000008
Apr 14 00:04:57 Huntington-Beach esi: c216d018   edi: c139ec74   ebp: 
cecafe2c   esp: cecafdf0
Apr 14 00:04:57 Huntington-Beach ds: 007b   es: 007b   ss: 0068
Apr 14 00:04:57 Huntington-Beach Process ntpd (pid: 3135, 
threadinfo=cecae000 task=cef12000)
Apr 14 00:04:57 Huntington-Beach Stack: c02443f9 cecafe0c cecafea0 
c0fb1514 0000000e 00000003 00000003 0000006d
Apr 14 00:04:57 Huntington-Beach c139ec80 c139ec88 c138987c 00000010 
00000000 c139ec74 00000246 cecafe54
Apr 14 00:04:57 Huntington-Beach c015980f c139ec74 000000d0 c0244706 
c0fb1480 00000000 c0fb1480 cfc51800
Apr 14 00:04:57 Huntington-Beach Call Trace:
Apr 14 00:04:57 Huntington-Beach [<c02443f9>] reiserfs_find_entry+0xb9/0x170
Apr 14 00:04:57 Huntington-Beach [<c015980f>] kmem_cache_alloc+0x13f/0x150
Apr 14 00:04:57 Huntington-Beach [<c0244706>] reiserfs_lookup+0x256/0x400
Apr 14 00:04:57 Huntington-Beach [<c025396b>] reiserfs_alloc_inode+0x1b/0x30
Apr 14 00:04:57 Huntington-Beach [<c019865e>] alloc_inode+0x1e/0x150
Apr 14 00:04:57 Huntington-Beach [<c01995ca>] new_inode+0x1a/0x1d0
Apr 14 00:04:57 Huntington-Beach [<c024522a>] reiserfs_create+0x1a/0x330
Apr 14 00:04:57 Huntington-Beach [<c0189f04>] vfs_create+0x64/0xc0
Apr 14 00:04:57 Huntington-Beach [<c018a6e3>] open_namei+0x5c3/0x630
Apr 14 00:04:57 Huntington-Beach [<c015796b>] check_poison_obj+0x3b/0x1b0
Apr 14 00:04:57 Huntington-Beach [<c0174901>] filp_open+0x41/0x70
Apr 14 00:04:57 Huntington-Beach [<c0174dd3>] sys_open+0x53/0x90
Apr 14 00:04:57 Huntington-Beach [<c010b0ab>] syscall_call+0x7/0xb
Apr 14 00:04:57 Huntington-Beach


Apr 14 00:04:57 Huntington-Beach Code: 8b 04 86 83 f8 ff 75 ef 8b 7b 10 
89 d0 29 f8 39 c1 0f 85 11
Apr 14 00:04:57 Huntington-Beach <6>note: ntpd[3135] exited with 
preempt_count 1
Apr 14 00:04:57 Huntington-Beach bad: scheduling while atomic!
Apr 14 00:04:57 Huntington-Beach Call Trace:
Apr 14 00:04:57 Huntington-Beach [<c0125f24>] schedule+0x6c4/0x6d0
Apr 14 00:04:57 Huntington-Beach [<c01607d1>] unmap_page_range+0x41/0x70
Apr 14 00:04:57 Huntington-Beach [<c01609e6>] unmap_vmas+0x1e6/0x350
Apr 14 00:04:57 Huntington-Beach [<c01662eb>] exit_mmap+0xcb/0x2c0
Apr 14 00:04:57 Huntington-Beach [<c0129185>] mmput+0xa5/0x130
Apr 14 00:04:57 Huntington-Beach [<c012ee3f>] do_exit+0x25f/0xa50
Apr 14 00:04:57 Huntington-Beach [<c010c1c8>] die+0x1c8/0x1d0
Apr 14 00:04:57 Huntington-Beach [<c0123aac>] do_page_fault+0x15c/0x4b3
Apr 14 00:04:57 Huntington-Beach [<c025baa3>] is_tree_node+0x63/0x70
Apr 14 00:04:57 Huntington-Beach [<c025bfd8>] search_by_key+0x528/0xe70
Apr 14 00:04:57 Huntington-Beach [<c04465b1>] __kfree_skb+0xa1/0x130
Apr 14 00:04:57 Huntington-Beach [<c0123950>] do_page_fault+0x0/0x4b3
Apr 14 00:04:57 Huntington-Beach [<c010bab5>] error_code+0x2d/0x38
Apr 14 00:04:57 Huntington-Beach [<c0158d9d>] cache_alloc_refill+0xfd/0x3d0
Apr 14 00:04:57 Huntington-Beach [<c02443f9>] reiserfs_find_entry+0xb9/0x170
Apr 14 00:04:57 Huntington-Beach [<c015980f>] kmem_cache_alloc+0x13f/0x150
Apr 14 00:04:57 Huntington-Beach [<c0244706>] reiserfs_lookup+0x256/0x400
Apr 14 00:04:57 Huntington-Beach [<c025396b>] reiserfs_alloc_inode+0x1b/0x30
Apr 14 00:04:57 Huntington-Beach [<c019865e>] alloc_inode+0x1e/0x150
Apr 14 00:04:57 Huntington-Beach [<c01995ca>] new_inode+0x1a/0x1d0
Apr 14 00:04:57 Huntington-Beach [<c024522a>] reiserfs_create+0x1a/0x330
Apr 14 00:04:57 Huntington-Beach [<c0189f04>] vfs_create+0x64/0xc0
Apr 14 00:04:57 Huntington-Beach [<c018a6e3>] open_namei+0x5c3/0x630
Apr 14 00:04:57 Huntington-Beach [<c015796b>] check_poison_obj+0x3b/0x1b0
Apr 14 00:04:57 Huntington-Beach [<c0174901>] filp_open+0x41/0x70
Apr 14 00:04:57 Huntington-Beach [<c0174dd3>] sys_open+0x53/0x90
Apr 14 00:04:57 Huntington-Beach [<c010b0ab>] syscall_call+0x7/0xb
Apr 14 00:04:57 Huntington-Beach
Apr 14 00:04:57 Huntington-Beach mm/slab.c:2255: 
spin_lock(mm/slab.c:c139ecb4) already locked by mm/slab.c/1677


Apr 14 00:15:01 Huntington-Beach Unable to handle kernel paging request 
at virtual address fc4d0a50
Apr 14 00:15:01 Huntington-Beach printing eip:
Apr 14 00:15:01 Huntington-Beach c0158d9d
Apr 14 00:15:01 Huntington-Beach *pde = 00000000
Apr 14 00:15:01 Huntington-Beach Oops: 0000 [#4]
Apr 14 00:15:01 Huntington-Beach CPU:    0
Apr 14 00:15:01 Huntington-Beach EIP:    0060:[<c0158d9d>]    Not tainted
Apr 14 00:15:01 Huntington-Beach EFLAGS: 00010097
Apr 14 00:15:01 Huntington-Beach EIP is at cache_alloc_refill+0xfd/0x3d0
Apr 14 00:15:01 Huntington-Beach eax: 8e8d8e8e   ebx: c216d000   ecx: 
00000001   edx: 00000008
Apr 14 00:15:01 Huntington-Beach esi: c216d018   edi: c139ec74   ebp: 
cee49e2c   esp: cee49df0
Apr 14 00:15:01 Huntington-Beach ds: 007b   es: 007b   ss: 0068
Apr 14 00:15:01 Huntington-Beach Process crond (pid: 2866, 
threadinfo=cee48000 task=cf71d980)
Apr 14 00:15:01 Huntington-Beach Stack: c02443f9 cee49e0c cee49ea0 
c0fb16ac 0000000e 00000003 00000003 00000002
Apr 14 00:15:01 Huntington-Beach c139ec80 c139ec88 c138987c 00000010 
00000000 c139ec74 00000246 cee49e54
Apr 14 00:15:01 Huntington-Beach c015980f c139ec74 000000d0 c0244706 
c0fb1618 00000000 c0fb1618 cfc51800
Apr 14 00:15:01 Huntington-Beach Call Trace:
Apr 14 00:15:01 Huntington-Beach [<c02443f9>] reiserfs_find_entry+0xb9/0x170
Apr 14 00:15:01 Huntington-Beach [<c015980f>] kmem_cache_alloc+0x13f/0x150
Apr 14 00:15:01 Huntington-Beach [<c0244706>] reiserfs_lookup+0x256/0x400
Apr 14 00:15:01 Huntington-Beach [<c025396b>] reiserfs_alloc_inode+0x1b/0x30
Apr 14 00:15:01 Huntington-Beach [<c019865e>] alloc_inode+0x1e/0x150
Apr 14 00:15:01 Huntington-Beach [<c01995ca>] new_inode+0x1a/0x1d0
Apr 14 00:15:01 Huntington-Beach [<c024522a>] reiserfs_create+0x1a/0x330
Apr 14 00:15:01 Huntington-Beach [<c0189f04>] vfs_create+0x64/0xc0
Apr 14 00:15:01 Huntington-Beach [<c018a6e3>] open_namei+0x5c3/0x630
Apr 14 00:15:01 Huntington-Beach [<c015796b>] check_poison_obj+0x3b/0x1b0
Apr 14 00:15:01 Huntington-Beach [<c013b149>] sigprocmask+0xf9/0x2a0
Apr 14 00:15:01 Huntington-Beach [<c0174901>] filp_open+0x41/0x70
Apr 14 00:15:01 Huntington-Beach [<c0174dd3>] sys_open+0x53/0x90
Apr 14 00:15:01 Huntington-Beach [<c010b0ab>] syscall_call+0x7/0xb
Apr 14 00:15:01 Huntington-Beach


Apr 14 00:15:01 Huntington-Beach Code: 8b 04 86 83 f8 ff 75 ef 8b 7b 10 
89 d0 29 f8 39 c1 0f 85 11
Apr 14 00:15:01 Huntington-Beach <6>note: crond[2866] exited with 
preempt_count 1
Apr 14 00:15:01 Huntington-Beach bad: scheduling while atomic!
Apr 14 00:15:01 Huntington-Beach Call Trace:
Apr 14 00:15:01 Huntington-Beach [<c0125f24>] schedule+0x6c4/0x6d0
Apr 14 00:15:01 Huntington-Beach [<c01607d1>] unmap_page_range+0x41/0x70
Apr 14 00:15:01 Huntington-Beach [<c01609e6>] unmap_vmas+0x1e6/0x350
Apr 14 00:15:01 Huntington-Beach [<c01662eb>] exit_mmap+0xcb/0x2c0
Apr 14 00:15:01 Huntington-Beach [<c0129185>] mmput+0xa5/0x130
Apr 14 00:15:01 Huntington-Beach [<c012ee3f>] do_exit+0x25f/0xa50
Apr 14 00:15:01 Huntington-Beach [<c010c1c8>] mm/slab.c:2255: 
spin_lock(mm/slab.c:c139ecb4) already locked by mm/slab.c/1677
Apr 14 00:15:01 Huntington-Beach die+0x1c8/0x1d0
Apr 14 00:15:01 Huntington-Beach [<c0123aac>] do_page_fault+0x15c/0x4b3
Apr 14 00:15:01 Huntington-Beach [<c025baa3>] is_tree_node+0x63/0x70
Apr 14 00:15:01 Huntington-Beach [<c025bfd8>] search_by_key+0x528/0xe70
Apr 14 00:15:01 Huntington-Beach [<c0123950>] do_page_fault+0x0/0x4b3
Apr 14 00:15:01 Huntington-Beach [<c010bab5>] error_code+0x2d/0x38
Apr 14 00:15:01 Huntington-Beach [<c0158d9d>] cache_alloc_refill+0xfd/0x3d0
Apr 14 00:15:01 Huntington-Beach [<c02443f9>] reiserfs_find_entry+0xb9/0x170
Apr 14 00:15:01 Huntington-Beach [<c015980f>] kmem_cache_alloc+0x13f/0x150
Apr 14 00:15:01 Huntington-Beach [<c0244706>] reiserfs_lookup+0x256/0x400
Apr 14 00:15:01 Huntington-Beach [<c025396b>] reiserfs_alloc_inode+0x1b/0x30
Apr 14 00:15:01 Huntington-Beach [<c019865e>] alloc_inode+0x1e/0x150
Apr 14 00:15:01 Huntington-Beach [<c01995ca>] new_inode+0x1a/0x1d0
Apr 14 00:15:01 Huntington-Beach [<c024522a>] reiserfs_create+0x1a/0x330
Apr 14 00:15:01 Huntington-Beach [<c0189f04>] vfs_create+0x64/0xc0
Apr 14 00:15:01 Huntington-Beach [<c018a6e3>] open_namei+0x5c3/0x630
Apr 14 00:15:01 Huntington-Beach [<c015796b>] check_poison_obj+0x3b/0x1b0
Apr 14 00:15:01 Huntington-Beach [<c013b149>] sigprocmask+0xf9/0x2a0
Apr 14 00:15:01 Huntington-Beach [<c0174901>] filp_open+0x41/0x70
Apr 14 00:15:01 Huntington-Beach [<c0174dd3>] sys_open+0x53/0x90
Apr 14 00:15:01 Huntington-Beach [<c010b0ab>] syscall_call+0x7/0xb
Apr 14 00:15:01 Huntington-Beach


and on and on

-- 
Stupid disclaimer: I am not responsible for any email that you send me nor am I bound to any obligation to deal with any received email in any given fashion.  If you send me spam or a virus, I may in whole or part send you 50,000 return copies of it. I may also publically announce any and all emails and post them to message boards, news sites, and even parody sites.  I may also mark them up, cut and paste, print, and staple them to telephone poles for the enjoyment of people without internet access.  This is not a confidential medium and your assumption that your email can or will be handled confidentially is akin to baring your backside, burying your head in the ground, and thinking nobody can see you butt nekkid and in plain view for miles away.  Don't be a cluebert, buy one from K-mart today.  Don't attach stupid disclaimers to your emails.

When it absolutely, positively, has to be destroyed overnight.
                           AIR FORCE


