Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030452AbWALPYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030452AbWALPYK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 10:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030453AbWALPYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 10:24:10 -0500
Received: from outmx015.isp.belgacom.be ([195.238.4.87]:39865 "EHLO
	outmx015.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1030452AbWALPYJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 10:24:09 -0500
Message-ID: <3096.80.200.243.137.1137079435.squirrel@mail.delodder.be>
Date: Thu, 12 Jan 2006 16:23:55 +0100 (CET)
Subject: bug
From: "Philippe Delodder" <lodder@delodder.be>
To: linux-kernel@vger.kernel.org
Reply-To: lodder@delodder.be
User-Agent: SquirrelMail/1.4.5
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------------[ cut here ]------------
kernel BUG at lib/radix-tree.c:271!
invalid operand: 0000 [#1]
PREEMPT
Modules linked in: af_packet ipv6 floppy analog parport_pc parport evdev
pcspkr 8139cp snd_intel8x0m snd_intel8x0 snd_ac97_codec snd_pcm snd_timer
snd_page_alloc gameport snd_mpu401_uart snd_rawmidi snd_seq_device snd
hw_random pci_hotplug intel_agp uhci_hcd usbcore i810_audio ac97_codec
soundcore 8139too mii agpgart quota_v2 ext3 jbd capability commoncap
psmouse ide_cd cdrom rtc reiserfs ide_generic ide_disk piix ide_core unix
font vesafb cfbcopyarea cfbimgblt cfbfillrect
CPU:    0
EIP:    0060:[<c018d02e>]    Not tainted
EFLAGS: 00010096   (2.6.8-2-386)
EIP is at radix_tree_insert+0xc7/0xdc
eax: ffffffff   ebx: 00000000   ecx: 00000000   edx: 00000014
esi: c6ae3c90   edi: c6ae3ce4   ebp: fffffffa   esp: c534bb2c
ds: 007b   es: 007b   ss: 0068
Process find (pid: 26989, threadinfo=c534a000 task=c78242b0)
Stack: c534a000 00000000 c10594c0 cfa9c13c c012d1ec cfa9c140 000c82d4
c10594c0
       c10594c0 c10594c0 00000050 000c82d4 c012d24d c10594c0 cfa9c13c
000c82d4
       00000050 c10594c0 00000000 c012d658 c10594c0 cfa9c13c 000c82d4
00000050
Call Trace:
 [<c012d1ec>] add_to_page_cache+0x39/0x82
 [<c012d24d>] add_to_page_cache_lru+0x18/0x2d
 [<c012d658>] find_or_create_page+0x4f/0x91
 [<c01468e6>] grow_dev_page+0x28/0x108
 [<c0146a9f>] __getblk_slow+0xd9/0x124
 [<c0146da2>] __getblk+0x2d/0x35
 [<d08f486f>] search_by_key+0x73/0xe22 [reiserfs]
 [<d08ede10>] init_once+0x21/0x32 [reiserfs]
 [<d08f4541>] pathrelse+0x1e/0x2d [reiserfs]
 [<d08e4b5b>] init_inode+0x2d8/0x381 [reiserfs]
 [<d08e5165>] reiserfs_read_locked_inode+0x61/0xe7 [reiserfs]
 [<d08e5258>] reiserfs_iget+0x4a/0x7f [reiserfs]
 [<d08e0a23>] reiserfs_lookup+0xfa/0x1b8 [reiserfs]
 [<c010b003>] timer_interrupt+0x45/0xff
 [<c01586eb>] d_lookup+0x18/0x35
 [<c014f646>] real_lookup+0x51/0xb5
 [<c014f86b>] do_lookup+0x41/0x72
 [<c015008c>] link_path_walk+0x7f0/0xb86
 [<c0107ee5>] do_IRQ+0xe5/0xf9
 [<c010697c>] common_interrupt+0x18/0x20
 [<c014007b>] shmem_file_setup+0x128/0x190
 [<c01506ea>] path_lookup+0x121/0x129
 [<c015081c>] __user_walk+0x23/0x3a
 [<c014c26c>] vfs_lstat+0x12/0x3e
 [<c014c7e8>] sys_lstat64+0x10/0x27
 [<c0105f97>] syscall_call+0x7/0xb
Code: 0f 0b 0f 01 c5 5b 26 c0 8b 44 24 1c 89 07 31 c0 5b 5e 5f 5d
 <6>note: find[26989] exited with preempt_count 3
bad: scheduling while atomic!
 [<c024d5a0>] schedule+0x3c/0x3e6
 [<c01382ad>] unmap_vmas+0xe0/0x1cf
 [<c013832f>] unmap_vmas+0x162/0x1cf
 [<c013b8a3>] exit_mmap+0x6a/0x12a
 [<c01171db>] mmput+0x5e/0x73
 [<c011ab81>] do_exit+0x162/0x34f
 [<c0106fde>] do_divide_error+0x0/0xa7
 [<c0107262>] do_invalid_op+0x8a/0x93
 [<c018d02e>] radix_tree_insert+0xc7/0xdc
 [<d085a48e>] ide_build_sglist+0x30/0x90 [ide_core]
 [<c011eaf0>] __mod_timer+0xe6/0x13d
 [<c018f12c>] __delay+0xc/0xe
 [<d085590b>] ide_execute_command+0x82/0xa3 [ide_core]
 [<d085ab7d>] __ide_dma_begin+0x27/0x38 [ide_core]
 [<c018d02e>] radix_tree_insert+0xc7/0xdc
 [<c011437a>] do_emu+0x409/0x453
 [<d085a82e>] dma_timer_expiry+0x0/0x64 [ide_core]
 [<d0857e1e>] do_rw_taskfile+0x1c7/0x1e1 [ide_core]
 [<c018d02f>] radix_tree_insert+0xc8/0xdc
 [<c0113f71>] do_emu+0x0/0x453
 [<c0106a19>] error_code+0x2d/0x38
 [<c018d02e>] radix_tree_insert+0xc7/0xdc
 [<c012d1ec>] add_to_page_cache+0x39/0x82
 [<c012d24d>] add_to_page_cache_lru+0x18/0x2d
 [<c012d658>] find_or_create_page+0x4f/0x91
 [<c01468e6>] grow_dev_page+0x28/0x108
 [<c0146a9f>] __getblk_slow+0xd9/0x124
 [<c0146da2>] __getblk+0x2d/0x35
 [<d08f486f>] search_by_key+0x73/0xe22 [reiserfs]
 [<d08ede10>] init_once+0x21/0x32 [reiserfs]
 [<d08f4541>] pathrelse+0x1e/0x2d [reiserfs]
 [<d08e4b5b>] init_inode+0x2d8/0x381 [reiserfs]
 [<d08e5165>] reiserfs_read_locked_inode+0x61/0xe7 [reiserfs]
 [<d08e5258>] reiserfs_iget+0x4a/0x7f [reiserfs]
 [<d08e0a23>] reiserfs_lookup+0xfa/0x1b8 [reiserfs]
 [<c010b003>] timer_interrupt+0x45/0xff
 [<c01586eb>] d_lookup+0x18/0x35
 [<c014f646>] real_lookup+0x51/0xb5
 [<c014f86b>] do_lookup+0x41/0x72
 [<c015008c>] link_path_walk+0x7f0/0xb86
 [<c0107ee5>] do_IRQ+0xe5/0xf9
 [<c010697c>] common_interrupt+0x18/0x20
 [<c014007b>] shmem_file_setup+0x128/0x190
 [<c01506ea>] path_lookup+0x121/0x129
 [<c015081c>] __user_walk+0x23/0x3a
 [<c014c26c>] vfs_lstat+0x12/0x3e
 [<c014c7e8>] sys_lstat64+0x10/0x27
 [<c0105f97>] syscall_call+0x7/0xb



-- 
Philippe Delodder
lodder@delodder.be
http://www.delodder.be

