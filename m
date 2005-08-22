Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751363AbVHVWiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbVHVWiM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbVHVWiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:38:11 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:32651 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751463AbVHVWiE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:38:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:reply-to:mail-followup-to:mime-version:content-type:content-disposition;
        b=rpB+tDlb9fWv9Z8caGqposh27bAF2pvGI5lTO2zjJ5c6aS+IdGeMvIrgwy0sFNYYUrBVFkVKu9vICdyOItw9/b230885KWTPEeh4D3Qvi+thpuo4cJZdFukUMsYDwFMwA52c+QA/3DvoLsTuP+d/tZRkAJLNNLogbzXnziBYAvQ=
Date: Mon, 22 Aug 2005 09:05:20 +0200
From: Mateusz Berezecki <mateuszb@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.13-rc6 JFS Oops trace
Message-ID: <20050822070520.GA5011@oepkgtn.mshome.net>
Reply-To: Mateusz Berezecki <mateuszb@gmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello list readers,

I attach the oops trace for 2.6.13-rc6 kernel. I believe the bug is 100%
reproducible but I don't know what triggers it yet. It appears that
kernel crashes when dealing with large amount of small files (possible
fs issue - i.e. jfs ?) 

I attach oops trace and config for my kernel

-- 
  @..@   Mateusz Berezecki 
 (----)  mateuszb@gmail.com http://mateusz.agrest.org
( >__< ) PGP: 5F1C 86DF 89DB BFE9 899E 8CBE EB60 B7A7 43F9 5808 
^^ ~~ ^^

--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="oops.txt"

Aug 21 23:28:14 oepkgtn CPU 0 irqstacks, hard=c0575000 soft=c0574000
Aug 21 23:28:14 oepkgtn Machine check exception polling timer started.
Aug 21 23:28:14 oepkgtn cs: IO port probe 0xd000-0xefff: clean.
Aug 21 23:28:14 oepkgtn ehci_hcd 0000:00:1d.7: debug port 1
Aug 22 08:45:53 oepkgtn [<c04111f6>] schedule+0x596/0x654
Aug 22 08:45:53 oepkgtn [<c0117f32>] __wake_up+0x4f/0x71
Aug 22 08:45:53 oepkgtn [<c04113f5>] wait_for_completion+0x91/0xf3
Aug 22 08:45:53 oepkgtn [<c0117e75>] default_wake_function+0x0/0x12
Aug 22 08:45:53 oepkgtn [<c012b8f7>] call_usermodehelper_keys+0xb7/0xd0
Aug 22 08:45:53 oepkgtn [<c012b7d4>] __call_usermodehelper+0x0/0x6c
Aug 22 08:45:53 oepkgtn [<c0242ff4>] kobject_hotplug+0x2e8/0x2f9
Aug 22 08:45:53 oepkgtn [<c02c2fb2>] class_device_del+0xbe/0xe2
Aug 22 08:45:53 oepkgtn [<c02c2fe6>] class_device_unregister+0x10/0x1d
Aug 22 08:45:53 oepkgtn [<c02940f4>] vcs_remove_devfs+0x24/0x47
Aug 22 08:45:53 oepkgtn [<c029ac36>] con_close+0x67/0x78
Aug 22 08:45:53 oepkgtn [<c028b683>] release_dev+0x159/0x78b
Aug 22 08:45:53 oepkgtn [<c01442a7>] free_hot_cold_page+0xb2/0x12b
Aug 22 08:45:53 oepkgtn [<c01442a7>] free_hot_cold_page+0xb2/0x12b
Aug 22 08:45:53 oepkgtn [<c0175ea3>] dput+0x114/0x2ad
Aug 22 08:45:53 oepkgtn [<c018615a>] inotify_dentry_parent_queue_event+0x8b/0xb8
Aug 22 08:45:53 oepkgtn [<c0175ea3>] dput+0x114/0x2ad
Aug 22 08:45:53 oepkgtn [<c028c197>] tty_release+0x14/0x1f
Aug 22 08:45:53 oepkgtn [<c015f7b4>] __fput+0xa7/0x1a8
Aug 22 08:45:53 oepkgtn [<c015decc>] filp_close+0x49/0x6d
Aug 22 08:45:53 oepkgtn [<c011d40f>] put_files_struct+0x73/0xfd
Aug 22 08:45:53 oepkgtn [<c011e1d1>] do_exit+0x127/0x49b
Aug 22 08:45:53 oepkgtn [<c0104365>] do_trap+0x0/0xd1
Aug 22 08:45:53 oepkgtn [<c0115fe6>] do_page_fault+0x389/0x66a
Aug 22 08:45:53 oepkgtn [<c0117f32>] __wake_up+0x4f/0x71
Aug 22 08:45:53 oepkgtn [<c022e040>] release_metapage+0x9c/0x159
Aug 22 08:45:53 oepkgtn [<c021bc3e>] diRead+0x24b/0x2ce
Aug 22 08:45:53 oepkgtn [<c013fc6a>] find_get_page+0x43/0x64
Aug 22 08:45:53 oepkgtn [<c0115c5d>] do_page_fault+0x0/0x66a
Aug 22 08:45:53 oepkgtn [<c0103b17>] error_code+0x4f/0x54
Aug 22 08:45:53 oepkgtn [<c01483dd>] cache_alloc_refill+0x86/0x270
Aug 22 08:45:53 oepkgtn [<c01487c2>] kmem_cache_alloc+0x42/0x44
Aug 22 08:45:53 oepkgtn [<c020fc13>] jfs_alloc_inode+0x18/0x2b
Aug 22 08:45:53 oepkgtn [<c0177f9b>] alloc_inode+0x1b/0x144
Aug 22 08:45:53 oepkgtn [<c0178b59>] get_new_inode_fast+0x17/0x138
Aug 22 08:45:53 oepkgtn [<c01791d7>] iget_locked+0xe5/0x105
Aug 22 08:45:53 oepkgtn [<c0213cab>] jfs_lookup+0x62/0x221
Aug 22 08:45:53 oepkgtn [<c0175ea3>] dput+0x114/0x2ad
Aug 22 08:45:53 oepkgtn [<c016d4bf>] __link_path_walk+0xbed/0x1063
Aug 22 08:45:53 oepkgtn [<c017723c>] __d_lookup+0x9f/0x17f
Aug 22 08:45:53 oepkgtn [<c0175ea3>] dput+0x114/0x2ad
Aug 22 08:45:53 oepkgtn [<c016c5dd>] real_lookup+0xb7/0xd7
Aug 22 08:45:53 oepkgtn [<c016c8c7>] do_lookup+0x85/0x90
Aug 22 08:45:53 oepkgtn [<c016d183>] __link_path_walk+0x8b1/0x1063
Aug 22 08:45:53 oepkgtn [<c016d980>] link_path_walk+0x4b/0xed
Aug 22 08:45:53 oepkgtn [<c016dcbd>] path_lookup+0x98/0x1aa
Aug 22 08:45:53 oepkgtn [<c016df69>] __user_walk+0x27/0x3b
Aug 22 08:45:53 oepkgtn [<c0167f7d>] vfs_stat+0x19/0x4d
Aug 22 08:45:53 oepkgtn [<c01685a0>] sys_stat64+0x18/0x36
Aug 22 08:45:53 oepkgtn [<c01781ed>] inode_init_once+0xe3/0x10f
Aug 22 08:45:53 oepkgtn [<c0103013>] sysenter_past_esp+0x54/0x75
Aug 22 08:45:54 oepkgtn [<c04111f6>] schedule+0x596/0x654
Aug 22 08:45:54 oepkgtn [<c0117f32>] __wake_up+0x4f/0x71
Aug 22 08:45:54 oepkgtn [<c04113f5>] wait_for_completion+0x91/0xf3
Aug 22 08:45:54 oepkgtn [<c0117e75>] default_wake_function+0x0/0x12
Aug 22 08:45:54 oepkgtn [<c012b8f7>] call_usermodehelper_keys+0xb7/0xd0
Aug 22 08:45:54 oepkgtn [<c012b7d4>] __call_usermodehelper+0x0/0x6c
Aug 22 08:45:54 oepkgtn [<c0242ff4>] kobject_hotplug+0x2e8/0x2f9
Aug 22 08:45:54 oepkgtn [<c02c2fb2>] class_device_del+0xbe/0xe2
Aug 22 08:45:54 oepkgtn [<c02c2fe6>] class_device_unregister+0x10/0x1d
Aug 22 08:45:54 oepkgtn [<c0294112>] vcs_remove_devfs+0x42/0x47
Aug 22 08:45:54 oepkgtn [<c029ac36>] con_close+0x67/0x78
Aug 22 08:45:54 oepkgtn [<c028b683>] release_dev+0x159/0x78b
Aug 22 08:45:54 oepkgtn [<c01442a7>] free_hot_cold_page+0xb2/0x12b
Aug 22 08:45:54 oepkgtn [<c01442a7>] free_hot_cold_page+0xb2/0x12b
Aug 22 08:45:54 oepkgtn [<c0175ea3>] dput+0x114/0x2ad
Aug 22 08:45:54 oepkgtn [<c018615a>] inotify_dentry_parent_queue_event+0x8b/0xb8
Aug 22 08:45:54 oepkgtn [<c0175ea3>] dput+0x114/0x2ad
Aug 22 08:45:54 oepkgtn [<c028c197>] tty_release+0x14/0x1f
Aug 22 08:45:54 oepkgtn [<c015f7b4>] __fput+0xa7/0x1a8
Aug 22 08:45:54 oepkgtn [<c015decc>] filp_close+0x49/0x6d
Aug 22 08:45:54 oepkgtn [<c011d40f>] put_files_struct+0x73/0xfd
Aug 22 08:45:54 oepkgtn [<c011e1d1>] do_exit+0x127/0x49b
Aug 22 08:45:54 oepkgtn [<c0104365>] do_trap+0x0/0xd1
Aug 22 08:45:54 oepkgtn [<c0115fe6>] do_page_fault+0x389/0x66a
Aug 22 08:45:54 oepkgtn [<c0117f32>] __wake_up+0x4f/0x71
Aug 22 08:45:54 oepkgtn [<c022e040>] release_metapage+0x9c/0x159
Aug 22 08:45:54 oepkgtn [<c021bc3e>] diRead+0x24b/0x2ce
Aug 22 08:45:54 oepkgtn [<c013fc6a>] find_get_page+0x43/0x64
Aug 22 08:45:54 oepkgtn [<c0115c5d>] do_page_fault+0x0/0x66a
Aug 22 08:45:54 oepkgtn [<c0103b17>] error_code+0x4f/0x54
Aug 22 08:45:54 oepkgtn [<c01483dd>] cache_alloc_refill+0x86/0x270
Aug 22 08:45:54 oepkgtn [<c01487c2>] kmem_cache_alloc+0x42/0x44
Aug 22 08:45:54 oepkgtn [<c020fc13>] jfs_alloc_inode+0x18/0x2b
Aug 22 08:45:54 oepkgtn [<c0177f9b>] alloc_inode+0x1b/0x144
Aug 22 08:45:54 oepkgtn [<c0178b59>] get_new_inode_fast+0x17/0x138
Aug 22 08:45:54 oepkgtn [<c01791d7>] iget_locked+0xe5/0x105
Aug 22 08:45:54 oepkgtn [<c0213cab>] jfs_lookup+0x62/0x221
Aug 22 08:45:54 oepkgtn [<c0175ea3>] dput+0x114/0x2ad
Aug 22 08:45:54 oepkgtn [<c016d4bf>] __link_path_walk+0xbed/0x1063
Aug 22 08:45:54 oepkgtn [<c017723c>] __d_lookup+0x9f/0x17f
Aug 22 08:45:54 oepkgtn [<c0175ea3>] dput+0x114/0x2ad
Aug 22 08:45:54 oepkgtn [<c016c5dd>] real_lookup+0xb7/0xd7
Aug 22 08:45:54 oepkgtn [<c016c8c7>] do_lookup+0x85/0x90
Aug 22 08:45:54 oepkgtn [<c016d183>] __link_path_walk+0x8b1/0x1063
Aug 22 08:45:54 oepkgtn [<c016d980>] link_path_walk+0x4b/0xed
Aug 22 08:45:54 oepkgtn [<c016dcbd>] path_lookup+0x98/0x1aa
Aug 22 08:45:54 oepkgtn [<c016df69>] __user_walk+0x27/0x3b
Aug 22 08:45:54 oepkgtn [<c0167f7d>] vfs_stat+0x19/0x4d
Aug 22 08:45:54 oepkgtn [<c01685a0>] sys_stat64+0x18/0x36
Aug 22 08:45:54 oepkgtn [<c01781ed>] inode_init_once+0xe3/0x10f
Aug 22 08:45:54 oepkgtn [<c0103013>] sysenter_past_esp+0x54/0x75
Aug 22 08:46:02 oepkgtn Unable to handle kernel paging request at virtual address a995a213
Aug 22 08:46:02 oepkgtn c01483dd
Aug 22 08:46:02 oepkgtn *pde = 00000000
Aug 22 08:46:02 oepkgtn Oops: 0002 [#2]
Aug 22 08:46:02 oepkgtn CPU:    0
Aug 22 08:46:02 oepkgtn EIP:    0060:[<c01483dd>]    Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
Aug 22 08:46:02 oepkgtn EFLAGS: 00010017   (2.6.13-rc6) 
Aug 22 08:46:02 oepkgtn eax: cf6fed0c   ebx: c79f8100   ecx: cf6fed00   edx: a995a20f
Aug 22 08:46:02 oepkgtn esi: cf6fed00   edi: 0000001b   ebp: cf6ffc80   esp: c075ed58
Aug 22 08:46:02 oepkgtn ds: 007b   es: 007b   ss: 0068
Aug 22 08:46:02 oepkgtn Stack: cf59dcc8 00301ddf c10bd1e0 cf6fed0c 00000046 00000000 00000286 cf6fed00 
Aug 22 08:46:02 oepkgtn c4c2ac8c c1bba434 c01487c2 cf6fed00 00000050 00000000 cf568800 c020fc13 
Aug 22 08:46:02 oepkgtn cf6fed00 00000050 c0177f9b cf568800 fffffffe 00000000 cf568800 c0178921 
Aug 22 08:46:02 oepkgtn Call Trace:
Aug 22 08:46:02 oepkgtn [<c01487c2>] kmem_cache_alloc+0x42/0x44
Aug 22 08:46:02 oepkgtn [<c020fc13>] jfs_alloc_inode+0x18/0x2b
Aug 22 08:46:02 oepkgtn [<c0177f9b>] alloc_inode+0x1b/0x144
Aug 22 08:46:02 oepkgtn [<c0178921>] new_inode+0x1a/0xa2
Aug 22 08:46:02 oepkgtn [<c022c492>] ialloc+0x26/0x224
Aug 22 08:46:02 oepkgtn [<c0211488>] jfs_create+0x78/0x36c
Aug 22 08:46:02 oepkgtn [<c0177600>] d_rehash+0x7b/0x99
Aug 22 08:46:02 oepkgtn [<c0213e63>] jfs_lookup+0x21a/0x221
Aug 22 08:46:02 oepkgtn [<c0175ea3>] dput+0x114/0x2ad
Aug 22 08:46:02 oepkgtn [<c017723c>] __d_lookup+0x9f/0x17f
Aug 22 08:46:02 oepkgtn [<c016d98f>] link_path_walk+0x5a/0xed
Aug 22 08:46:02 oepkgtn [<c016e0e1>] vfs_create+0x8a/0xcd
Aug 22 08:46:02 oepkgtn [<c016e895>] open_namei+0x56b/0x61b
Aug 22 08:46:02 oepkgtn [<c015d96b>] filp_open+0x3b/0x61
Aug 22 08:46:02 oepkgtn [<c015dcc3>] get_unused_fd+0xae/0xd4
Aug 22 08:46:02 oepkgtn [<c015ddcf>] sys_open+0x49/0xda
Aug 22 08:46:02 oepkgtn [<c0103013>] sysenter_past_esp+0x54/0x75
Aug 22 08:46:02 oepkgtn Code: 6d 01 00 00 85 ff 7e 54 8b 54 24 0c 8b 1a 39 d3 0f 84 3f 01 00 00 8b 4c 24 2c 8b 41 3c 3b 43 10 0f 87 83 00 00 00 8b 13 8b 43 04 <89> 42 04 89 10 c7 03 00 01 10 00 c7 43 04 00 02 20 00 66 83 7b 


>>EIP; c01483dd <cache_alloc_refill+86/270>   <=====

>>eax; cf6fed0c <__crc_skb_clone_fraglist+11ba2d/1586c7>
>>ebx; c79f8100 <__crc_dm_vcalloc+3b3ca/92eb7>
>>ecx; cf6fed00 <__crc_skb_clone_fraglist+11ba21/1586c7>
>>edx; a995a20f <__crc_schedule_delayed_work_on+263ec5/63d13f>
>>esi; cf6fed00 <__crc_skb_clone_fraglist+11ba21/1586c7>
>>ebp; cf6ffc80 <__crc_skb_clone_fraglist+11c9a1/1586c7>
>>esp; c075ed58 <__crc_ps2_handle_ack+11902/235f2e>

Trace; c01487c2 <kmem_cache_alloc+42/44>
Trace; c020fc13 <jfs_alloc_inode+18/2b>
Trace; c0177f9b <alloc_inode+1b/144>
Trace; c0178921 <new_inode+1a/a2>
Trace; c022c492 <ialloc+26/224>
Trace; c0211488 <jfs_create+78/36c>
Trace; c0177600 <d_rehash+7b/99>
Trace; c0213e63 <jfs_lookup+21a/221>
Trace; c0175ea3 <dput+114/2ad>
Trace; c017723c <__d_lookup+9f/17f>
Trace; c016d98f <link_path_walk+5a/ed>
Trace; c016e0e1 <vfs_create+8a/cd>
Trace; c016e895 <open_namei+56b/61b>
Trace; c015d96b <filp_open+3b/61>
Trace; c015dcc3 <get_unused_fd+ae/d4>
Trace; c015ddcf <sys_open+49/da>
Trace; c0103013 <sysenter_past_esp+54/75>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  c01483b2 <cache_alloc_refill+5b/270>
00000000 <_EIP>:
Code;  c01483b2 <cache_alloc_refill+5b/270>
   0:   6d                        insl   (%dx),%es:(%edi)
Code;  c01483b3 <cache_alloc_refill+5c/270>
   1:   01 00                     add    %eax,(%eax)
Code;  c01483b5 <cache_alloc_refill+5e/270>
   3:   00 85 ff 7e 54 8b         add    %al,0x8b547eff(%ebp)
Code;  c01483bb <cache_alloc_refill+64/270>
   9:   54                        push   %esp
Code;  c01483bc <cache_alloc_refill+65/270>
   a:   24 0c                     and    $0xc,%al
Code;  c01483be <cache_alloc_refill+67/270>
   c:   8b 1a                     mov    (%edx),%ebx
Code;  c01483c0 <cache_alloc_refill+69/270>
   e:   39 d3                     cmp    %edx,%ebx
Code;  c01483c2 <cache_alloc_refill+6b/270>
  10:   0f 84 3f 01 00 00         je     155 <_EIP+0x155>
Code;  c01483c8 <cache_alloc_refill+71/270>
  16:   8b 4c 24 2c               mov    0x2c(%esp),%ecx
Code;  c01483cc <cache_alloc_refill+75/270>
  1a:   8b 41 3c                  mov    0x3c(%ecx),%eax
Code;  c01483cf <cache_alloc_refill+78/270>
  1d:   3b 43 10                  cmp    0x10(%ebx),%eax
Code;  c01483d2 <cache_alloc_refill+7b/270>
  20:   0f 87 83 00 00 00         ja     a9 <_EIP+0xa9>
Code;  c01483d8 <cache_alloc_refill+81/270>
  26:   8b 13                     mov    (%ebx),%edx
Code;  c01483da <cache_alloc_refill+83/270>
  28:   8b 43 04                  mov    0x4(%ebx),%eax

This decode from eip onwards should be reliable

Code;  c01483dd <cache_alloc_refill+86/270>
00000000 <_EIP>:
Code;  c01483dd <cache_alloc_refill+86/270>   <=====
   0:   89 42 04                  mov    %eax,0x4(%edx)   <=====
Code;  c01483e0 <cache_alloc_refill+89/270>
   3:   89 10                     mov    %edx,(%eax)
Code;  c01483e2 <cache_alloc_refill+8b/270>
   5:   c7 03 00 01 10 00         movl   $0x100100,(%ebx)
Code;  c01483e8 <cache_alloc_refill+91/270>
   b:   c7 43 04 00 02 20 00      movl   $0x200200,0x4(%ebx)
Code;  c01483ef <cache_alloc_refill+98/270>
  12:   66                        data16
Code;  c01483f0 <cache_alloc_refill+99/270>
  13:   83                        .byte 0x83
Code;  c01483f1 <cache_alloc_refill+9a/270>
  14:   7b                        .byte 0x7b

Aug 22 08:46:02 oepkgtn Unable to handle kernel paging request at virtual address a995a213
Aug 22 08:46:02 oepkgtn c01483dd
Aug 22 08:46:02 oepkgtn *pde = 00000000
Aug 22 08:46:02 oepkgtn Oops: 0002 [#3]
Aug 22 08:46:02 oepkgtn CPU:    0
Aug 22 08:46:02 oepkgtn EIP:    0060:[<c01483dd>]    Not tainted VLI
Aug 22 08:46:02 oepkgtn EFLAGS: 00010017   (2.6.13-rc6) 
Aug 22 08:46:02 oepkgtn eax: cf6fed0c   ebx: c79f8100   ecx: cf6fed00   edx: a995a20f
Aug 22 08:46:02 oepkgtn esi: cf6fed00   edi: 0000001b   ebp: cf6ffc80   esp: ca6b2d58
Aug 22 08:46:02 oepkgtn ds: 007b   es: 007b   ss: 0068
Aug 22 08:46:02 oepkgtn Stack: c0175ea3 cf52695c c058d6d4 cf6fed0c 00000046 c295c684 00000286 cf6fed00 
Aug 22 08:46:02 oepkgtn cc9d17c4 c7867334 c01487c2 cf6fed00 00000050 00000000 cf568800 c020fc13 
Aug 22 08:46:02 oepkgtn cf6fed00 00000050 c0177f9b cf568800 c0175ea3 00000000 cf568800 c0178921 
Aug 22 08:46:02 oepkgtn Call Trace:
Aug 22 08:46:02 oepkgtn [<c0175ea3>] dput+0x114/0x2ad
Aug 22 08:46:02 oepkgtn [<c01487c2>] kmem_cache_alloc+0x42/0x44
Aug 22 08:46:02 oepkgtn [<c020fc13>] jfs_alloc_inode+0x18/0x2b
Aug 22 08:46:02 oepkgtn [<c0177f9b>] alloc_inode+0x1b/0x144
Aug 22 08:46:02 oepkgtn [<c0175ea3>] dput+0x114/0x2ad
Aug 22 08:46:02 oepkgtn [<c0178921>] new_inode+0x1a/0xa2
Aug 22 08:46:02 oepkgtn [<c022c492>] ialloc+0x26/0x224
Aug 22 08:46:02 oepkgtn [<c0211488>] jfs_create+0x78/0x36c
Aug 22 08:46:02 oepkgtn [<c0213c49>] jfs_lookup+0x0/0x221
Aug 22 08:46:02 oepkgtn [<c016c2ff>] permission+0x5a/0xb1
Aug 22 08:46:02 oepkgtn [<c02386ec>] jfs_check_acl+0x0/0x7d
Aug 22 08:46:02 oepkgtn [<c0238769>] jfs_permission+0x0/0xd
Aug 22 08:46:02 oepkgtn [<c016c962>] __link_path_walk+0x90/0x1063
Aug 22 08:46:02 oepkgtn [<c0175ea3>] dput+0x114/0x2ad
Aug 22 08:46:02 oepkgtn [<c016d98f>] link_path_walk+0x5a/0xed
Aug 22 08:46:02 oepkgtn [<c017723c>] __d_lookup+0x9f/0x17f
Aug 22 08:46:02 oepkgtn [<c016e0e1>] vfs_create+0x8a/0xcd
Aug 22 08:46:02 oepkgtn [<c016e895>] open_namei+0x56b/0x61b
Aug 22 08:46:02 oepkgtn [<c015d96b>] filp_open+0x3b/0x61
Aug 22 08:46:02 oepkgtn [<c015dcc3>] get_unused_fd+0xae/0xd4
Aug 22 08:46:02 oepkgtn [<c015ddcf>] sys_open+0x49/0xda
Aug 22 08:46:02 oepkgtn [<c0103013>] sysenter_past_esp+0x54/0x75
Aug 22 08:46:02 oepkgtn Code: 6d 01 00 00 85 ff 7e 54 8b 54 24 0c 8b 1a 39 d3 0f 84 3f 01 00 00 8b 4c 24 2c 8b 41 3c 3b 43 10 0f 87 83 00 00 00 8b 13 8b 43 04 <89> 42 04 89 10 c7 03 00 01 10 00 c7 43 04 00 02 20 00 66 83 7b 


>>EIP; c01483dd <cache_alloc_refill+86/270>   <=====

>>eax; cf6fed0c <__crc_skb_clone_fraglist+11ba2d/1586c7>
>>ebx; c79f8100 <__crc_dm_vcalloc+3b3ca/92eb7>
>>ecx; cf6fed00 <__crc_skb_clone_fraglist+11ba21/1586c7>
>>edx; a995a20f <__crc_schedule_delayed_work_on+263ec5/63d13f>
>>esi; cf6fed00 <__crc_skb_clone_fraglist+11ba21/1586c7>
>>ebp; cf6ffc80 <__crc_skb_clone_fraglist+11c9a1/1586c7>
>>esp; ca6b2d58 <__crc_mii_nway_restart+3f60f4/3f7843>

Trace; c0175ea3 <dput+114/2ad>
Trace; c01487c2 <kmem_cache_alloc+42/44>
Trace; c020fc13 <jfs_alloc_inode+18/2b>
Trace; c0177f9b <alloc_inode+1b/144>
Trace; c0175ea3 <dput+114/2ad>
Trace; c0178921 <new_inode+1a/a2>
Trace; c022c492 <ialloc+26/224>
Trace; c0211488 <jfs_create+78/36c>
Trace; c0213c49 <jfs_lookup+0/221>
Trace; c016c2ff <permission+5a/b1>
Trace; c02386ec <jfs_check_acl+0/7d>
Trace; c0238769 <jfs_permission+0/d>
Trace; c016c962 <__link_path_walk+90/1063>
Trace; c0175ea3 <dput+114/2ad>
Trace; c016d98f <link_path_walk+5a/ed>
Trace; c017723c <__d_lookup+9f/17f>
Trace; c016e0e1 <vfs_create+8a/cd>
Trace; c016e895 <open_namei+56b/61b>
Trace; c015d96b <filp_open+3b/61>
Trace; c015dcc3 <get_unused_fd+ae/d4>
Trace; c015ddcf <sys_open+49/da>
Trace; c0103013 <sysenter_past_esp+54/75>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  c01483b2 <cache_alloc_refill+5b/270>
00000000 <_EIP>:
Code;  c01483b2 <cache_alloc_refill+5b/270>
   0:   6d                        insl   (%dx),%es:(%edi)
Code;  c01483b3 <cache_alloc_refill+5c/270>
   1:   01 00                     add    %eax,(%eax)
Code;  c01483b5 <cache_alloc_refill+5e/270>
   3:   00 85 ff 7e 54 8b         add    %al,0x8b547eff(%ebp)
Code;  c01483bb <cache_alloc_refill+64/270>
   9:   54                        push   %esp
Code;  c01483bc <cache_alloc_refill+65/270>
   a:   24 0c                     and    $0xc,%al
Code;  c01483be <cache_alloc_refill+67/270>
   c:   8b 1a                     mov    (%edx),%ebx
Code;  c01483c0 <cache_alloc_refill+69/270>
   e:   39 d3                     cmp    %edx,%ebx
Code;  c01483c2 <cache_alloc_refill+6b/270>
  10:   0f 84 3f 01 00 00         je     155 <_EIP+0x155>
Code;  c01483c8 <cache_alloc_refill+71/270>
  16:   8b 4c 24 2c               mov    0x2c(%esp),%ecx
Code;  c01483cc <cache_alloc_refill+75/270>
  1a:   8b 41 3c                  mov    0x3c(%ecx),%eax
Code;  c01483cf <cache_alloc_refill+78/270>
  1d:   3b 43 10                  cmp    0x10(%ebx),%eax
Code;  c01483d2 <cache_alloc_refill+7b/270>
  20:   0f 87 83 00 00 00         ja     a9 <_EIP+0xa9>
Code;  c01483d8 <cache_alloc_refill+81/270>
  26:   8b 13                     mov    (%ebx),%edx
Code;  c01483da <cache_alloc_refill+83/270>
  28:   8b 43 04                  mov    0x4(%ebx),%eax

This decode from eip onwards should be reliable

Code;  c01483dd <cache_alloc_refill+86/270>
00000000 <_EIP>:
Code;  c01483dd <cache_alloc_refill+86/270>   <=====
   0:   89 42 04                  mov    %eax,0x4(%edx)   <=====
Code;  c01483e0 <cache_alloc_refill+89/270>
   3:   89 10                     mov    %edx,(%eax)
Code;  c01483e2 <cache_alloc_refill+8b/270>
   5:   c7 03 00 01 10 00         movl   $0x100100,(%ebx)
Code;  c01483e8 <cache_alloc_refill+91/270>
   b:   c7 43 04 00 02 20 00      movl   $0x200200,0x4(%ebx)
Code;  c01483ef <cache_alloc_refill+98/270>
  12:   66                        data16
Code;  c01483f0 <cache_alloc_refill+99/270>
  13:   83                        .byte 0x83
Code;  c01483f1 <cache_alloc_refill+9a/270>
  14:   7b                        .byte 0x7b

Aug 22 08:46:10 oepkgtn Unable to handle kernel paging request at virtual address a995a213
Aug 22 08:46:10 oepkgtn c01483dd
Aug 22 08:46:10 oepkgtn *pde = 00000000
Aug 22 08:46:10 oepkgtn Oops: 0002 [#4]
Aug 22 08:46:10 oepkgtn CPU:    0
Aug 22 08:46:10 oepkgtn EIP:    0060:[<c01483dd>]    Not tainted VLI
Aug 22 08:46:10 oepkgtn EFLAGS: 00010017   (2.6.13-rc6) 
Aug 22 08:46:10 oepkgtn eax: cf6fed0c   ebx: c79f8100   ecx: cf6fed00   edx: a995a20f
Aug 22 08:46:10 oepkgtn esi: cf6fed00   edi: 00000010   ebp: cf6ffc80   esp: cf3f1c94
Aug 22 08:46:10 oepkgtn ds: 007b   es: 007b   ss: 0068
Aug 22 08:46:10 oepkgtn Stack: c4654bdc 00000003 00000001 cf6fed0c 00000046 00000046 00000286 cf6fed00 
Aug 22 08:46:10 oepkgtn cf568800 c12201c4 c01487c2 cf6fed00 00000050 00000000 cf568800 c020fc13 
Aug 22 08:46:10 oepkgtn cf6fed00 00000050 c0177f9b cf568800 c822c000 00000000 c12201c4 c0178b59 
Aug 22 08:46:10 oepkgtn Call Trace:
Aug 22 08:46:10 oepkgtn [<c01487c2>] kmem_cache_alloc+0x42/0x44
Aug 22 08:46:10 oepkgtn [<c020fc13>] jfs_alloc_inode+0x18/0x2b
Aug 22 08:46:10 oepkgtn [<c0177f9b>] alloc_inode+0x1b/0x144
Aug 22 08:46:10 oepkgtn [<c0178b59>] get_new_inode_fast+0x17/0x138
Aug 22 08:46:10 oepkgtn [<c01791d7>] iget_locked+0xe5/0x105
Aug 22 08:46:10 oepkgtn [<c0213cab>] jfs_lookup+0x62/0x221
Aug 22 08:46:10 oepkgtn [<c039d0e2>] sock_def_readable+0x66/0x82
Aug 22 08:46:10 oepkgtn [<c03ca5ef>] tcp_rcv_established+0x6b3/0x86b
Aug 22 08:46:10 oepkgtn [<c0148425>] cache_alloc_refill+0xce/0x270
Aug 22 08:46:10 oepkgtn [<c017723c>] __d_lookup+0x9f/0x17f
Aug 22 08:46:10 oepkgtn [<c016c5dd>] real_lookup+0xb7/0xd7
Aug 22 08:46:10 oepkgtn [<c016c8c7>] do_lookup+0x85/0x90
Aug 22 08:46:10 oepkgtn [<c016d183>] __link_path_walk+0x8b1/0x1063
Aug 22 08:46:10 oepkgtn [<c0175ea3>] dput+0x114/0x2ad
Aug 22 08:46:10 oepkgtn [<c016d980>] link_path_walk+0x4b/0xed
Aug 22 08:46:10 oepkgtn [<c015dcc3>] get_unused_fd+0xae/0xd4
Aug 22 08:46:10 oepkgtn [<c016dcbd>] path_lookup+0x98/0x1aa
Aug 22 08:46:10 oepkgtn [<c016e3a1>] open_namei+0x77/0x61b
Aug 22 08:46:10 oepkgtn [<c015d96b>] filp_open+0x3b/0x61
Aug 22 08:46:10 oepkgtn [<c015dcc3>] get_unused_fd+0xae/0xd4
Aug 22 08:46:10 oepkgtn [<c015ddcf>] sys_open+0x49/0xda
Aug 22 08:46:10 oepkgtn [<c0103013>] sysenter_past_esp+0x54/0x75
Aug 22 08:46:10 oepkgtn Code: 6d 01 00 00 85 ff 7e 54 8b 54 24 0c 8b 1a 39 d3 0f 84 3f 01 00 00 8b 4c 24 2c 8b 41 3c 3b 43 10 0f 87 83 00 00 00 8b 13 8b 43 04 <89> 42 04 89 10 c7 03 00 01 10 00 c7 43 04 00 02 20 00 66 83 7b 


>>EIP; c01483dd <cache_alloc_refill+86/270>   <=====

>>eax; cf6fed0c <__crc_skb_clone_fraglist+11ba2d/1586c7>
>>ebx; c79f8100 <__crc_dm_vcalloc+3b3ca/92eb7>
>>ecx; cf6fed00 <__crc_skb_clone_fraglist+11ba21/1586c7>
>>edx; a995a20f <__crc_schedule_delayed_work_on+263ec5/63d13f>
>>esi; cf6fed00 <__crc_skb_clone_fraglist+11ba21/1586c7>
>>ebp; cf6ffc80 <__crc_skb_clone_fraglist+11c9a1/1586c7>
>>esp; cf3f1c94 <__crc_xfrm_replay_advance+868d7/c7abc>

Trace; c01487c2 <kmem_cache_alloc+42/44>
Trace; c020fc13 <jfs_alloc_inode+18/2b>
Trace; c0177f9b <alloc_inode+1b/144>
Trace; c0178b59 <get_new_inode_fast+17/138>
Trace; c01791d7 <iget_locked+e5/105>
Trace; c0213cab <jfs_lookup+62/221>
Trace; c039d0e2 <sock_def_readable+66/82>
Trace; c03ca5ef <tcp_rcv_established+6b3/86b>
Trace; c0148425 <cache_alloc_refill+ce/270>
Trace; c017723c <__d_lookup+9f/17f>
Trace; c016c5dd <real_lookup+b7/d7>
Trace; c016c8c7 <do_lookup+85/90>
Trace; c016d183 <__link_path_walk+8b1/1063>
Trace; c0175ea3 <dput+114/2ad>
Trace; c016d980 <link_path_walk+4b/ed>
Trace; c015dcc3 <get_unused_fd+ae/d4>
Trace; c016dcbd <path_lookup+98/1aa>
Trace; c016e3a1 <open_namei+77/61b>
Trace; c015d96b <filp_open+3b/61>
Trace; c015dcc3 <get_unused_fd+ae/d4>
Trace; c015ddcf <sys_open+49/da>
Trace; c0103013 <sysenter_past_esp+54/75>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  c01483b2 <cache_alloc_refill+5b/270>
00000000 <_EIP>:
Code;  c01483b2 <cache_alloc_refill+5b/270>
   0:   6d                        insl   (%dx),%es:(%edi)
Code;  c01483b3 <cache_alloc_refill+5c/270>
   1:   01 00                     add    %eax,(%eax)
Code;  c01483b5 <cache_alloc_refill+5e/270>
   3:   00 85 ff 7e 54 8b         add    %al,0x8b547eff(%ebp)
Code;  c01483bb <cache_alloc_refill+64/270>
   9:   54                        push   %esp
Code;  c01483bc <cache_alloc_refill+65/270>
   a:   24 0c                     and    $0xc,%al
Code;  c01483be <cache_alloc_refill+67/270>
   c:   8b 1a                     mov    (%edx),%ebx
Code;  c01483c0 <cache_alloc_refill+69/270>
   e:   39 d3                     cmp    %edx,%ebx
Code;  c01483c2 <cache_alloc_refill+6b/270>
  10:   0f 84 3f 01 00 00         je     155 <_EIP+0x155>
Code;  c01483c8 <cache_alloc_refill+71/270>
  16:   8b 4c 24 2c               mov    0x2c(%esp),%ecx
Code;  c01483cc <cache_alloc_refill+75/270>
  1a:   8b 41 3c                  mov    0x3c(%ecx),%eax
Code;  c01483cf <cache_alloc_refill+78/270>
  1d:   3b 43 10                  cmp    0x10(%ebx),%eax
Code;  c01483d2 <cache_alloc_refill+7b/270>
  20:   0f 87 83 00 00 00         ja     a9 <_EIP+0xa9>
Code;  c01483d8 <cache_alloc_refill+81/270>
  26:   8b 13                     mov    (%ebx),%edx
Code;  c01483da <cache_alloc_refill+83/270>
  28:   8b 43 04                  mov    0x4(%ebx),%eax

This decode from eip onwards should be reliable

Code;  c01483dd <cache_alloc_refill+86/270>
00000000 <_EIP>:
Code;  c01483dd <cache_alloc_refill+86/270>   <=====
   0:   89 42 04                  mov    %eax,0x4(%edx)   <=====
Code;  c01483e0 <cache_alloc_refill+89/270>
   3:   89 10                     mov    %edx,(%eax)
Code;  c01483e2 <cache_alloc_refill+8b/270>
   5:   c7 03 00 01 10 00         movl   $0x100100,(%ebx)
Code;  c01483e8 <cache_alloc_refill+91/270>
   b:   c7 43 04 00 02 20 00      movl   $0x200200,0x4(%ebx)
Code;  c01483ef <cache_alloc_refill+98/270>
  12:   66                        data16
Code;  c01483f0 <cache_alloc_refill+99/270>
  13:   83                        .byte 0x83
Code;  c01483f1 <cache_alloc_refill+9a/270>
  14:   7b                        .byte 0x7b

Aug 22 08:46:12 oepkgtn Unable to handle kernel paging request at virtual address a995a213
Aug 22 08:46:12 oepkgtn c01483dd
Aug 22 08:46:12 oepkgtn *pde = 00000000
Aug 22 08:46:12 oepkgtn Oops: 0002 [#5]
Aug 22 08:46:12 oepkgtn CPU:    0
Aug 22 08:46:12 oepkgtn EIP:    0060:[<c01483dd>]    Not tainted VLI
Aug 22 08:46:12 oepkgtn EFLAGS: 00010017   (2.6.13-rc6) 
Aug 22 08:46:12 oepkgtn eax: cf6fed0c   ebx: c79f8100   ecx: cf6fed00   edx: a995a20f
Aug 22 08:46:12 oepkgtn esi: cf6fed00   edi: 00000010   ebp: cf6ffc80   esp: cf3f1cbc
Aug 22 08:46:12 oepkgtn ds: 007b   es: 007b   ss: 0068
Aug 22 08:46:12 oepkgtn Stack: c3839208 00000003 00000001 cf6fed0c 00000046 00000046 00000296 cf6fed00 
Aug 22 08:46:12 oepkgtn cf568800 c12197bc c01487c2 cf6fed00 00000050 00000000 cf568800 c020fc13 
Aug 22 08:46:12 oepkgtn cf6fed00 00000050 c0177f9b cf568800 cec2d000 00000000 c12197bc c0178b59 
Aug 22 08:46:12 oepkgtn Call Trace:
Aug 22 08:46:12 oepkgtn [<c01487c2>] kmem_cache_alloc+0x42/0x44
Aug 22 08:46:12 oepkgtn [<c020fc13>] jfs_alloc_inode+0x18/0x2b
Aug 22 08:46:12 oepkgtn [<c0177f9b>] alloc_inode+0x1b/0x144
Aug 22 08:46:12 oepkgtn [<c0178b59>] get_new_inode_fast+0x17/0x138
Aug 22 08:46:12 oepkgtn [<c01791d7>] iget_locked+0xe5/0x105
Aug 22 08:46:12 oepkgtn [<c0213cab>] jfs_lookup+0x62/0x221
Aug 22 08:46:12 oepkgtn [<c03ca5ef>] tcp_rcv_established+0x6b3/0x86b
Aug 22 08:46:12 oepkgtn [<c0148425>] cache_alloc_refill+0xce/0x270
Aug 22 08:46:12 oepkgtn [<c017723c>] __d_lookup+0x9f/0x17f
Aug 22 08:46:12 oepkgtn [<c017723c>] __d_lookup+0x9f/0x17f
Aug 22 08:46:12 oepkgtn [<c017723c>] __d_lookup+0x9f/0x17f
Aug 22 08:46:12 oepkgtn [<c016c5dd>] real_lookup+0xb7/0xd7
Aug 22 08:46:12 oepkgtn [<c016c8c7>] do_lookup+0x85/0x90
Aug 22 08:46:12 oepkgtn [<c016d183>] __link_path_walk+0x8b1/0x1063
Aug 22 08:46:12 oepkgtn [<c016d98f>] link_path_walk+0x5a/0xed
Aug 22 08:46:12 oepkgtn [<c016d980>] link_path_walk+0x4b/0xed
Aug 22 08:46:12 oepkgtn [<c015d98c>] filp_open+0x5c/0x61
Aug 22 08:46:12 oepkgtn [<c016dcbd>] path_lookup+0x98/0x1aa
Aug 22 08:46:12 oepkgtn [<c01690be>] open_exec+0x21/0xd3
Aug 22 08:46:12 oepkgtn [<c015d98c>] filp_open+0x5c/0x61
Aug 22 08:46:12 oepkgtn [<c016a2a7>] do_execve+0x42/0x220
Aug 22 08:46:12 oepkgtn [<c0101c83>] sys_execve+0x3d/0x8c
Aug 22 08:46:12 oepkgtn [<c0103013>] sysenter_past_esp+0x54/0x75
Aug 22 08:46:12 oepkgtn Code: 6d 01 00 00 85 ff 7e 54 8b 54 24 0c 8b 1a 39 d3 0f 84 3f 01 00 00 8b 4c 24 2c 8b 41 3c 3b 43 10 0f 87 83 00 00 00 8b 13 8b 43 04 <89> 42 04 89 10 c7 03 00 01 10 00 c7 43 04 00 02 20 00 66 83 7b 


>>EIP; c01483dd <cache_alloc_refill+86/270>   <=====

>>eax; cf6fed0c <__crc_skb_clone_fraglist+11ba2d/1586c7>
>>ebx; c79f8100 <__crc_dm_vcalloc+3b3ca/92eb7>
>>ecx; cf6fed00 <__crc_skb_clone_fraglist+11ba21/1586c7>
>>edx; a995a20f <__crc_schedule_delayed_work_on+263ec5/63d13f>
>>esi; cf6fed00 <__crc_skb_clone_fraglist+11ba21/1586c7>
>>ebp; cf6ffc80 <__crc_skb_clone_fraglist+11c9a1/1586c7>
>>esp; cf3f1cbc <__crc_xfrm_replay_advance+868ff/c7abc>

Trace; c01487c2 <kmem_cache_alloc+42/44>
Trace; c020fc13 <jfs_alloc_inode+18/2b>
Trace; c0177f9b <alloc_inode+1b/144>
Trace; c0178b59 <get_new_inode_fast+17/138>
Trace; c01791d7 <iget_locked+e5/105>
Trace; c0213cab <jfs_lookup+62/221>
Trace; c03ca5ef <tcp_rcv_established+6b3/86b>
Trace; c0148425 <cache_alloc_refill+ce/270>
Trace; c017723c <__d_lookup+9f/17f>
Trace; c017723c <__d_lookup+9f/17f>
Trace; c017723c <__d_lookup+9f/17f>
Trace; c016c5dd <real_lookup+b7/d7>
Trace; c016c8c7 <do_lookup+85/90>
Trace; c016d183 <__link_path_walk+8b1/1063>
Trace; c016d98f <link_path_walk+5a/ed>
Trace; c016d980 <link_path_walk+4b/ed>
Trace; c015d98c <filp_open+5c/61>
Trace; c016dcbd <path_lookup+98/1aa>
Trace; c01690be <open_exec+21/d3>
Trace; c015d98c <filp_open+5c/61>
Trace; c016a2a7 <do_execve+42/220>
Trace; c0101c83 <sys_execve+3d/8c>
Trace; c0103013 <sysenter_past_esp+54/75>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  c01483b2 <cache_alloc_refill+5b/270>
00000000 <_EIP>:
Code;  c01483b2 <cache_alloc_refill+5b/270>
   0:   6d                        insl   (%dx),%es:(%edi)
Code;  c01483b3 <cache_alloc_refill+5c/270>
   1:   01 00                     add    %eax,(%eax)
Code;  c01483b5 <cache_alloc_refill+5e/270>
   3:   00 85 ff 7e 54 8b         add    %al,0x8b547eff(%ebp)
Code;  c01483bb <cache_alloc_refill+64/270>
   9:   54                        push   %esp
Code;  c01483bc <cache_alloc_refill+65/270>
   a:   24 0c                     and    $0xc,%al
Code;  c01483be <cache_alloc_refill+67/270>
   c:   8b 1a                     mov    (%edx),%ebx
Code;  c01483c0 <cache_alloc_refill+69/270>
   e:   39 d3                     cmp    %edx,%ebx
Code;  c01483c2 <cache_alloc_refill+6b/270>
  10:   0f 84 3f 01 00 00         je     155 <_EIP+0x155>
Code;  c01483c8 <cache_alloc_refill+71/270>
  16:   8b 4c 24 2c               mov    0x2c(%esp),%ecx
Code;  c01483cc <cache_alloc_refill+75/270>
  1a:   8b 41 3c                  mov    0x3c(%ecx),%eax
Code;  c01483cf <cache_alloc_refill+78/270>
  1d:   3b 43 10                  cmp    0x10(%ebx),%eax
Code;  c01483d2 <cache_alloc_refill+7b/270>
  20:   0f 87 83 00 00 00         ja     a9 <_EIP+0xa9>
Code;  c01483d8 <cache_alloc_refill+81/270>
  26:   8b 13                     mov    (%ebx),%edx
Code;  c01483da <cache_alloc_refill+83/270>
  28:   8b 43 04                  mov    0x4(%ebx),%eax

This decode from eip onwards should be reliable

Code;  c01483dd <cache_alloc_refill+86/270>
00000000 <_EIP>:
Code;  c01483dd <cache_alloc_refill+86/270>   <=====
   0:   89 42 04                  mov    %eax,0x4(%edx)   <=====
Code;  c01483e0 <cache_alloc_refill+89/270>
   3:   89 10                     mov    %edx,(%eax)
Code;  c01483e2 <cache_alloc_refill+8b/270>
   5:   c7 03 00 01 10 00         movl   $0x100100,(%ebx)
Code;  c01483e8 <cache_alloc_refill+91/270>
   b:   c7 43 04 00 02 20 00      movl   $0x200200,0x4(%ebx)
Code;  c01483ef <cache_alloc_refill+98/270>
  12:   66                        data16
Code;  c01483f0 <cache_alloc_refill+99/270>
  13:   83                        .byte 0x83
Code;  c01483f1 <cache_alloc_refill+9a/270>
  14:   7b                        .byte 0x7b

Aug 22 08:47:23 oepkgtn CPU 0 irqstacks, hard=c0575000 soft=c0574000
Aug 22 08:47:23 oepkgtn Machine check exception polling timer started.
Aug 22 08:47:23 oepkgtn cs: IO port probe 0xd000-0xefff: clean.
Aug 22 08:47:23 oepkgtn ehci_hcd 0000:00:1d.7: debug port 1

--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=".config"

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.13-rc6
# Sun Aug 21 21:16:33 2005
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
# CONFIG_CLEAN_COMPILE is not set
CONFIG_BROKEN=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_LOCK_KERNEL=y
CONFIG_INIT_ENV_ARG_LIMIT=32

#
# General setup
#
CONFIG_LOCALVERSION=""
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_SYSCTL=y
CONFIG_AUDIT=y
CONFIG_AUDITSYSCALL=y
CONFIG_HOTPLUG=y
CONFIG_KOBJECT_UEVENT=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_EMBEDDED=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SHMEM=y
CONFIG_CC_ALIGN_FUNCTIONS=0
CONFIG_CC_ALIGN_LABELS=0
CONFIG_CC_ALIGN_LOOPS=0
CONFIG_CC_ALIGN_JUMPS=0
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
CONFIG_MODULE_SRCVERSION_ALL=y
CONFIG_KMOD=y

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_ELAN is not set
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
CONFIG_MPENTIUM4=y
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
# CONFIG_SMP is not set
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_BKL=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_X86_MCE_P4THERMAL=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_X86_REBOOTFIXUPS is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y

#
# Firmware Drivers
#
# CONFIG_EDD is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_EFI is not set
CONFIG_HAVE_DEC_LOCK=y
# CONFIG_REGPARM is not set
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_PHYSICAL_START=0x100000
# CONFIG_KEXEC is not set

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_SOFTWARE_SUSPEND=y
CONFIG_PM_STD_PARTITION=""

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
# CONFIG_ACPI_SLEEP_PROC_SLEEP is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_HOTKEY=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_IBM is not set
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_ACPI_BLACKLIST_YEAR=0
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
# CONFIG_X86_PM_TIMER is not set
# CONFIG_ACPI_CONTAINER is not set

#
# APM (Advanced Power Management) BIOS Support
#
# CONFIG_APM is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
# CONFIG_PCIEPORTBUS is not set
# CONFIG_PCI_MSI is not set
CONFIG_PCI_LEGACY_PROC=y
CONFIG_PCI_NAMES=y
# CONFIG_PCI_DEBUG is not set
CONFIG_ISA_DMA_API=y
CONFIG_ISA=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set

#
# PCCARD (PCMCIA/CardBus) support
#
CONFIG_PCCARD=y
# CONFIG_PCMCIA_DEBUG is not set
CONFIG_PCMCIA=y
CONFIG_PCMCIA_LOAD_CIS=y
CONFIG_PCMCIA_IOCTL=y
CONFIG_CARDBUS=y

#
# PC-card bridges
#
CONFIG_YENTA=y
# CONFIG_PD6729 is not set
# CONFIG_I82092 is not set
# CONFIG_I82365 is not set
# CONFIG_TCIC is not set
CONFIG_PCMCIA_PROBE=y
CONFIG_PCCARD_NONSTATIC=y

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_AOUT is not set
# CONFIG_BINFMT_MISC is not set

#
# Networking
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=y
CONFIG_XFRM=y
# CONFIG_XFRM_USER is not set
CONFIG_NET_KEY=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_FIB_HASH=y
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_TUNNEL is not set
CONFIG_IP_TCPDIAG=y
# CONFIG_IP_TCPDIAG_IPV6 is not set
CONFIG_TCP_CONG_ADVANCED=y

#
# TCP congestion control
#
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
CONFIG_TCP_CONG_SCALABLE=m

#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
# CONFIG_IPV6 is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=y
# CONFIG_IP_NF_CT_ACCT is not set
# CONFIG_IP_NF_CONNTRACK_MARK is not set
# CONFIG_IP_NF_CT_PROTO_SCTP is not set
# CONFIG_IP_NF_FTP is not set
# CONFIG_IP_NF_IRC is not set
# CONFIG_IP_NF_TFTP is not set
# CONFIG_IP_NF_AMANDA is not set
CONFIG_IP_NF_QUEUE=y
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_LIMIT=y
CONFIG_IP_NF_MATCH_IPRANGE=y
CONFIG_IP_NF_MATCH_MAC=y
CONFIG_IP_NF_MATCH_PKTTYPE=y
CONFIG_IP_NF_MATCH_MARK=y
CONFIG_IP_NF_MATCH_MULTIPORT=y
CONFIG_IP_NF_MATCH_TOS=y
CONFIG_IP_NF_MATCH_RECENT=y
CONFIG_IP_NF_MATCH_ECN=y
CONFIG_IP_NF_MATCH_DSCP=y
CONFIG_IP_NF_MATCH_AH_ESP=y
CONFIG_IP_NF_MATCH_LENGTH=y
CONFIG_IP_NF_MATCH_TTL=y
CONFIG_IP_NF_MATCH_TCPMSS=y
CONFIG_IP_NF_MATCH_HELPER=y
CONFIG_IP_NF_MATCH_STATE=y
CONFIG_IP_NF_MATCH_CONNTRACK=y
CONFIG_IP_NF_MATCH_OWNER=y
# CONFIG_IP_NF_MATCH_ADDRTYPE is not set
# CONFIG_IP_NF_MATCH_REALM is not set
# CONFIG_IP_NF_MATCH_SCTP is not set
# CONFIG_IP_NF_MATCH_COMMENT is not set
# CONFIG_IP_NF_MATCH_HASHLIMIT is not set
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=y
CONFIG_IP_NF_TARGET_LOG=y
CONFIG_IP_NF_TARGET_ULOG=y
CONFIG_IP_NF_TARGET_TCPMSS=y
CONFIG_IP_NF_NAT=y
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=y
CONFIG_IP_NF_TARGET_REDIRECT=y
CONFIG_IP_NF_TARGET_NETMAP=y
CONFIG_IP_NF_TARGET_SAME=y
# CONFIG_IP_NF_NAT_SNMP_BASIC is not set
CONFIG_IP_NF_MANGLE=y
CONFIG_IP_NF_TARGET_TOS=y
CONFIG_IP_NF_TARGET_ECN=y
CONFIG_IP_NF_TARGET_DSCP=y
CONFIG_IP_NF_TARGET_MARK=y
CONFIG_IP_NF_TARGET_CLASSIFY=y
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_TARGET_NOTRACK=m
CONFIG_IP_NF_ARPTABLES=y
CONFIG_IP_NF_ARPFILTER=y
CONFIG_IP_NF_ARP_MANGLE=y

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_SCHED is not set
# CONFIG_NET_CLS_ROUTE is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=y
# CONFIG_DEBUG_DRIVER is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play support
#
CONFIG_PNP=y
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
# CONFIG_ISAPNP is not set
# CONFIG_PNPBIOS is not set
CONFIG_PNPACPI=y

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_DEV_XD is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_CRYPTOLOOP=y
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_UB is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_LBD=y
CONFIG_CDROM_PKTCDVD=y
CONFIG_CDROM_PKTCDVD_BUFFERS=8
CONFIG_CDROM_PKTCDVD_WCACHE=y

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
# CONFIG_ATA_OVER_ETH is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_IT821X is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_ARM is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=y
# CONFIG_CHR_DEV_SCH is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI Transport Attributes
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
CONFIG_SCSI_DPT_I2O=m
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
CONFIG_SCSI_SATA=y
# CONFIG_SCSI_SATA_AHCI is not set
# CONFIG_SCSI_SATA_SVW is not set
CONFIG_SCSI_ATA_PIIX=y
# CONFIG_SCSI_SATA_NV is not set
# CONFIG_SCSI_SATA_PROMISE is not set
# CONFIG_SCSI_SATA_QSTOR is not set
CONFIG_SCSI_SATA_SX4=m
# CONFIG_SCSI_SATA_SIL is not set
CONFIG_SCSI_SATA_SIS=m
# CONFIG_SCSI_SATA_ULI is not set
# CONFIG_SCSI_SATA_VIA is not set
# CONFIG_SCSI_SATA_VITESSE is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
CONFIG_SCSI_IPR=m
# CONFIG_SCSI_IPR_TRACE is not set
# CONFIG_SCSI_IPR_DUMP is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA2XXX=y
# CONFIG_SCSI_QLA21XX is not set
# CONFIG_SCSI_QLA22XX is not set
# CONFIG_SCSI_QLA2300 is not set
# CONFIG_SCSI_QLA2322 is not set
# CONFIG_SCSI_QLA6312 is not set
# CONFIG_SCSI_QLA24XX is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_SEAGATE is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# PCMCIA SCSI adapter support
#
# CONFIG_PCMCIA_AHA152X is not set
# CONFIG_PCMCIA_FDOMAIN is not set
# CONFIG_PCMCIA_NINJA_SCSI is not set
# CONFIG_PCMCIA_QLOGIC is not set
# CONFIG_PCMCIA_SYM53C500 is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
# CONFIG_BLK_DEV_MD is not set
CONFIG_BLK_DEV_DM=y
CONFIG_DM_CRYPT=y
# CONFIG_DM_SNAPSHOT is not set
# CONFIG_DM_MIRROR is not set
# CONFIG_DM_ZERO is not set
# CONFIG_DM_MULTIPATH is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_SPI is not set
# CONFIG_FUSION_FC is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Network device support
#
CONFIG_NETDEVICES=y
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_NET_SB1000 is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
CONFIG_B44=y
# CONFIG_FORCEDETH is not set
# CONFIG_CS89x0 is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
# CONFIG_E100 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SKGE is not set
# CONFIG_SK98LIN is not set
# CONFIG_VIA_VELOCITY is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
CONFIG_NET_RADIO=y

#
# Obsolete Wireless cards support (pre-802.11)
#
# CONFIG_STRIP is not set
# CONFIG_ARLAN is not set
# CONFIG_WAVELAN is not set
# CONFIG_PCMCIA_WAVELAN is not set
# CONFIG_PCMCIA_NETWAVE is not set

#
# Wireless 802.11 Frequency Hopping cards support
#
# CONFIG_PCMCIA_RAYCS is not set

#
# Wireless 802.11b ISA/PCI cards support
#
# CONFIG_AIRO is not set
# CONFIG_HERMES is not set
# CONFIG_ATMEL is not set

#
# Wireless 802.11b Pcmcia/Cardbus cards support
#
# CONFIG_AIRO_CS is not set
# CONFIG_PCMCIA_WL3501 is not set

#
# Prism GT/Duette 802.11(a/b/g) PCI/Cardbus support
#
# CONFIG_PRISM54 is not set
CONFIG_NET_WIRELESS=y

#
# PCMCIA network device support
#
# CONFIG_NET_PCMCIA is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_PCSPKR is not set
# CONFIG_INPUT_UINPUT is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
CONFIG_SERIO_CT82C710=y
CONFIG_SERIO_PCIPS2=y
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_CONSOLE is not set
# CONFIG_SERIAL_8250_CS is not set
# CONFIG_SERIAL_8250_ACPI is not set
CONFIG_SERIAL_8250_NR_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
# CONFIG_SERIAL_JSM is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
CONFIG_WATCHDOG=y
# CONFIG_WATCHDOG_NOWAYOUT is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_ALIM1535_WDT is not set
# CONFIG_ALIM7101_WDT is not set
# CONFIG_SC520_WDT is not set
# CONFIG_EUROTECH_WDT is not set
# CONFIG_IB700_WDT is not set
# CONFIG_WAFER_WDT is not set
# CONFIG_I8XX_TCO is not set
# CONFIG_SC1200_WDT is not set
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
# CONFIG_W83627HF_WDT is not set
# CONFIG_W83877F_WDT is not set
# CONFIG_MACHZ_WDT is not set

#
# ISA-based Watchdog Cards
#
# CONFIG_PCWATCHDOG is not set
# CONFIG_MIXCOMWD is not set
# CONFIG_WDT is not set

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
# CONFIG_WDTPCI is not set

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_HW_RANDOM=y
CONFIG_NVRAM=y
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=y
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD64 is not set
CONFIG_AGP_INTEL=y
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_EFFICEON is not set
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_GAMMA is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_I810 is not set
# CONFIG_DRM_I830 is not set
CONFIG_DRM_I915=y
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set
# CONFIG_DRM_VIA is not set

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
CONFIG_HPET=y
# CONFIG_HPET_RTC_IRQ is not set
CONFIG_HPET_MMAP=y
# CONFIG_HANGCHECK_TIMER is not set

#
# TPM devices
#
# CONFIG_TCG_TPM is not set

#
# I2C support
#
# CONFIG_I2C is not set
# CONFIG_I2C_SENSOR is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Hardware Monitoring support
#
CONFIG_HWMON=y
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
CONFIG_FB=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SOFT_CURSOR=y
# CONFIG_FB_MACMODES is not set
CONFIG_FB_MODE_HELPERS=y
# CONFIG_FB_TILEBLITTING is not set
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_HGA is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I810 is not set
CONFIG_FB_INTEL=y
# CONFIG_FB_INTEL_DEBUG is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON_OLD is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_GEODE is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

#
# Logo configuration
#
CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set

#
# Sound
#
CONFIG_SOUND=y

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_SEQUENCER=y
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# ISA devices
#
# CONFIG_SND_AD1848 is not set
# CONFIG_SND_CS4231 is not set
# CONFIG_SND_CS4232 is not set
# CONFIG_SND_CS4236 is not set
# CONFIG_SND_ES1688 is not set
# CONFIG_SND_ES18XX is not set
# CONFIG_SND_GUSCLASSIC is not set
# CONFIG_SND_GUSEXTREME is not set
# CONFIG_SND_GUSMAX is not set
# CONFIG_SND_INTERWAVE is not set
# CONFIG_SND_INTERWAVE_STB is not set
# CONFIG_SND_OPTI92X_AD1848 is not set
# CONFIG_SND_OPTI92X_CS4231 is not set
# CONFIG_SND_OPTI93X is not set
# CONFIG_SND_SB8 is not set
# CONFIG_SND_SB16 is not set
# CONFIG_SND_SBAWE is not set
# CONFIG_SND_WAVEFRONT is not set
# CONFIG_SND_CMI8330 is not set
# CONFIG_SND_OPL3SA2 is not set
# CONFIG_SND_SGALAXY is not set
# CONFIG_SND_SSCAPE is not set

#
# PCI devices
#
CONFIG_SND_AC97_CODEC=y
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
CONFIG_SND_INTEL8X0=y
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_HDA_INTEL is not set

#
# USB devices
#
# CONFIG_SND_USB_AUDIO is not set
# CONFIG_SND_USB_USX2Y is not set

#
# PCMCIA devices
#
# CONFIG_SND_VXPOCKET is not set
# CONFIG_SND_PDAUDIOCF is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
CONFIG_USB_BANDWIDTH=y
CONFIG_USB_DYNAMIC_MINORS=y
CONFIG_USB_SUSPEND=y
# CONFIG_USB_OTG is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_SPLIT_ISO=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
# CONFIG_USB_ISP116X_HCD is not set
CONFIG_USB_OHCI_HCD=y
# CONFIG_USB_OHCI_BIG_ENDIAN is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set

#
# USB Device Class drivers
#
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH_TTY is not set
# CONFIG_USB_MIDI is not set
# CONFIG_USB_ACM is not set
CONFIG_USB_PRINTER=y

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
#
CONFIG_USB_STORAGE=y
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set

#
# USB Input Devices
#
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
# CONFIG_HID_FF is not set
# CONFIG_USB_HIDDEV is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_ACECAD is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_MTOUCH is not set
# CONFIG_USB_ITMTOUCH is not set
# CONFIG_USB_EGALAX is not set
# CONFIG_USB_XPAD is not set
# CONFIG_USB_ATI_REMOTE is not set
# CONFIG_USB_KEYSPAN_REMOTE is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set

#
# Video4Linux support is needed for USB Multimedia device support
#

#
# USB Network Adapters
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_ZD1201 is not set
# CONFIG_USB_MON is not set

#
# USB port drivers
#

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_PHIDGETKIT is not set
# CONFIG_USB_PHIDGETSERVO is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TEST is not set

#
# USB DSL modem support
#

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# MMC/SD Card support
#
# CONFIG_MMC is not set

#
# InfiniBand support
#
# CONFIG_INFINIBAND is not set

#
# SN Devices
#

#
# File systems
#
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT2_FS_XIP is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
# CONFIG_EXT3_FS_POSIX_ACL is not set
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
CONFIG_JFS_FS=y
CONFIG_JFS_POSIX_ACL=y
CONFIG_JFS_SECURITY=y
CONFIG_JFS_DEBUG=y
CONFIG_JFS_STATISTICS=y
CONFIG_FS_POSIX_ACL=y

#
# XFS support
#
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_INOTIFY=y
# CONFIG_QUOTA is not set
CONFIG_DNOTIFY=y
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=y

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=y
CONFIG_UDF_FS=y
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=852
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-2"
CONFIG_NTFS_FS=y
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
CONFIG_DEVPTS_FS_XATTR=y
# CONFIG_DEVPTS_FS_SECURITY is not set
CONFIG_TMPFS=y
# CONFIG_TMPFS_XATTR is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
# CONFIG_NFS_FS is not set
# CONFIG_NFSD is not set
# CONFIG_SMB_FS is not set
CONFIG_CIFS=y
CONFIG_CIFS_STATS=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_EXPERIMENTAL=y
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="UTF8"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_CODEPAGE_852=y
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_CODEPAGE_1251=y
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=y
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=y

#
# Profiling support
#
CONFIG_PROFILING=y
CONFIG_OPROFILE=y

#
# Kernel hacking
#
# CONFIG_PRINTK_TIME is not set
CONFIG_DEBUG_KERNEL=y
# CONFIG_MAGIC_SYSRQ is not set
CONFIG_LOG_BUF_SHIFT=14
# CONFIG_SCHEDSTATS is not set
# CONFIG_DEBUG_SLAB is not set
CONFIG_DEBUG_PREEMPT=y
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_BUGVERBOSE is not set
# CONFIG_DEBUG_INFO is not set
# CONFIG_DEBUG_FS is not set
# CONFIG_FRAME_POINTER is not set
CONFIG_EARLY_PRINTK=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_KPROBES is not set
# CONFIG_DEBUG_STACK_USAGE is not set

#
# Page alloc debug is incompatible with Software Suspend on i386
#
CONFIG_4KSTACKS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
# CONFIG_CRYPTO_HMAC is not set
# CONFIG_CRYPTO_NULL is not set
# CONFIG_CRYPTO_MD4 is not set
# CONFIG_CRYPTO_MD5 is not set
# CONFIG_CRYPTO_SHA1 is not set
# CONFIG_CRYPTO_SHA256 is not set
# CONFIG_CRYPTO_SHA512 is not set
# CONFIG_CRYPTO_WP512 is not set
# CONFIG_CRYPTO_TGR192 is not set
# CONFIG_CRYPTO_DES is not set
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_TWOFISH is not set
# CONFIG_CRYPTO_SERPENT is not set
# CONFIG_CRYPTO_AES_586 is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_TEA is not set
# CONFIG_CRYPTO_ARC4 is not set
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_ANUBIS is not set
# CONFIG_CRYPTO_DEFLATE is not set
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_CRC32C is not set
# CONFIG_CRYPTO_TEST is not set

#
# Hardware crypto devices
#
# CONFIG_CRYPTO_DEV_PADLOCK is not set

#
# Library routines
#
# CONFIG_CRC_CCITT is not set
CONFIG_CRC32=y
CONFIG_LIBCRC32C=m
CONFIG_ZLIB_INFLATE=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_X86_BIOS_REBOOT=y

--r5Pyd7+fXNt84Ff3--

