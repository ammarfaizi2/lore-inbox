Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268771AbUH3TbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268771AbUH3TbN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 15:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268742AbUH3Taq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 15:30:46 -0400
Received: from smtp-noscan1.xs4all.nl ([194.109.24.8]:26642 "EHLO
	smtp-noscan1.xs4all.nl") by vger.kernel.org with ESMTP
	id S267352AbUH3T0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 15:26:16 -0400
Message-ID: <41337F5F.7030503@zwanebloem.nl>
Date: Mon, 30 Aug 2004 21:26:23 +0200
From: Tommy Faasen <tommy@zwanebloem.nl>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-fsdevel@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Subject: [2.6.7] ReiserFS borks with preempt
Content-Type: multipart/mixed;
 boundary="------------000004070104090408020502"
X-zwanebloem-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000004070104090408020502
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I have several reiserfs partitions mounted and today I saw an error in 
the logs.
I recently made (2 days ago) a software raid 5 with 3 scsi disks with 
reiserfs 3.6 and another partition with reiserfs 3.6.
However I can find earlier occurrences as well, the first one is the 
most recent. At the bottom you'll find more info regarding the mounts.

I can't find older configs  and/or earlier occurences.

Is there anything I should/can do?

I'm not subscribed so please email directly back.

My .config is attached.

Occurrence 1:

Aug 30 13:04:57 thuis kernel: c019a72c
Aug 30 13:04:57 thuis kernel: PREEMPT
Aug 30 13:04:57 thuis kernel: Modules linked in: parport_pc lp parport 
raid5 xor raid1 raid0 md uhci_hcd usbcore hangcheck_timer nvidia tuner 
tvaudio bttv vi
deo_buf i2c_algo_bit v4l2_common btcx_risc videodev snd_pcm_oss 
snd_mixer_oss snd_bt87x snd_emu10k1 snd_rawmidi snd_pcm snd_timer 
snd_seq_device snd_ac97_cod
ec snd_page_alloc snd_util_mem snd_hwdep snd via686a i2c_sensor i2c_isa 
i2c_core ip_nat_irc ip_nat_ftp ip_conntrack_irc ip_conntrack_ftp ip_gre 
st ipddp appl
etalk psnap llc 8390
Aug 30 13:04:57 thuis kernel: CPU:    0
Aug 30 13:04:57 thuis kernel: EIP:    
0060:[write_ordered_buffers+428/608]    Tainted: P
Aug 30 13:04:57 thuis kernel: EFLAGS: 00010293   (2.6.7)
Aug 30 13:04:57 thuis kernel: EIP is at write_ordered_buffers+0x1ac/0x260
Aug 30 13:04:57 thuis kernel: eax: d8beb7f4   ebx: d096a000   ecx: 
c82893f0   edx: 00000000
Aug 30 13:04:57 thuis kernel: esi: fe3946ec   edi: c4bcbe68   ebp: 
d8b4e434   esp: d096bd70
Aug 30 13:04:58 thuis kernel: ds: 007b   es: 007b   ss: 0068
Aug 30 13:04:58 thuis kernel: Process pdflush (pid: 5909, 
threadinfo=d096a000 task=dd819120)
Aug 30 13:04:58 thuis kernel: Stack: d8b4e434 ffffffff d0ff779c d8b4e3d8 
00000000 c4bcbe70 d8beb7f4 cb3241b4
Aug 30 13:04:58 thuis kernel:        cb3243f0 cb324868 cb324250 cb324b74 
cb324c78 cb324d14 cb324a08 cb3249d4
Aug 30 13:04:58 thuis kernel:        cb324a3c e6687e80 e66879a0 e6687904 
e6687d48 e6687b0c e2d0f3f0 e2d0f764
Aug 30 13:04:58 thuis kernel: Call Trace:
Aug 30 13:04:58 thuis kernel:  [flush_commit_list+286/944] 
flush_commit_list+0x11e/0x3b0
Aug 30 13:04:58 thuis kernel:  [do_journal_end+2783/2832] 
do_journal_end+0xadf/0xb10
Aug 30 13:04:58 thuis kernel:  [journal_end_sync+86/96] 
journal_end_sync+0x56/0x60
Aug 30 13:04:58 thuis kernel:  [reiserfs_sync_fs+61/144] 
reiserfs_sync_fs+0x3d/0x90
Aug 30 13:04:58 thuis kernel:  [reiserfs_write_super+10/16] 
reiserfs_write_super+0xa/0x10
Aug 30 13:04:58 thuis kernel:  [sync_supers+108/192] sync_supers+0x6c/0xc0
Aug 30 13:04:58 thuis kernel:  [wb_kupdate+65/288] wb_kupdate+0x41/0x120
Aug 30 13:04:58 thuis kernel:  [__pdflush+265/432] __pdflush+0x109/0x1b0
Aug 30 13:04:58 thuis kernel:  [pdflush+0/48] pdflush+0x0/0x30
Aug 30 13:04:58 thuis kernel:  [pdflush+30/48] pdflush+0x1e/0x30
Aug 30 13:04:58 thuis kernel:  [wb_kupdate+0/288] wb_kupdate+0x0/0x120
Aug 30 13:04:58 thuis kernel:  [kthread+112/160] kthread+0x70/0xa0
Aug 30 13:04:58 thuis kernel:  [kthread+0/160] kthread+0x0/0xa0
Aug 30 13:04:58 thuis kernel:  [kernel_thread_helper+5/16] 
kernel_thread_helper+0x5/0x10
Aug 30 13:04:58 thuis kernel:
Aug 30 13:04:58 thuis kernel: Code: ff 46 04 56 e8 4b fc ff ff 8b 06 83 
c4 04 a8 04 74 32 ff 4b
Aug 30 13:04:58 thuis kernel:  <6>note: pdflush[5909] exited with 
preempt_count 1

Occurrence 2

Aug  1 20:28:52 thuis kernel: c0165ffe
Aug  1 20:28:52 thuis kernel: PREEMPT
Aug  1 20:28:52 thuis kernel: Modules linked in: usbhid parport_pc lp 
parport raid1 raid0 md uhci_hcd usbcore hangcheck_timer nvidia tuner 
tvaudio bttv video
_buf i2c_algo_bit v4l2_common btcx_risc videodev snd_pcm_oss 
snd_mixer_oss snd_bt87x snd_emu10k1 snd_rawmidi snd_pcm snd_timer 
snd_seq_device snd_ac97_codec
snd_page_alloc snd_util_mem snd_hwdep snd via686a i2c_sensor i2c_isa 
i2c_core ip_nat_irc ip_nat_ftp ip_conntrack_irc ip_conntrack_ftp ip_gre 
st ipddp appleta
lk psnap llc 8390
Aug  1 20:28:52 thuis kernel: CPU:    0
Aug  1 20:28:52 thuis kernel: EIP:    
0060:[do_mpage_readpage+542/1008]    Tainted: P
Aug  1 20:28:52 thuis kernel: EFLAGS: 00010216   (2.6.7)
Aug  1 20:28:52 thuis kernel: EIP is at do_mpage_readpage+0x21e/0x3f0
Aug  1 20:28:52 thuis kernel: eax: 00000000   ebx: 00001000   ecx: 
00000400   edx: feced000
Aug  1 20:28:52 thuis kernel: esi: 00000000   edi: beced000   ebp: 
00000001   esp: d8fd9bec
Aug  1 20:28:52 thuis kernel: ds: 007b   es: 007b   ss: 0068
Aug  1 20:28:52 thuis kernel: Process uudeview (pid: 32321, 
threadinfo=d8fd8000 task=e6c361f0)
Aug  1 20:28:52 thuis kernel: Stack: d8fd9dbc 00000000 00000000 d8fd9cd0 
d0009080 00000000 00000000 00000000
Aug  1 20:28:52 thuis kernel:        00000000 0000009e 00000000 d8fd9dd5 
00000000 00000001 0000000c e0511750
Aug  1 20:28:52 thuis kernel:        00000000 d91740a4 d9174094 d8fd9dbc 
d0009098 e7fcc874 e7fb6088 e7fee8e8
Aug  1 20:28:52 thuis kernel: Call Trace:
Aug  1 20:28:52 thuis kernel:  [kmem_cache_alloc+47/64] 
kmem_cache_alloc+0x2f/0x40
Aug  1 20:28:52 thuis kernel:  [radix_tree_node_alloc+20/80] 
radix_tree_node_alloc+0x14/0x50
Aug  1 20:28:52 thuis kernel:  [radix_tree_insert+111/240] 
radix_tree_insert+0x6f/0xf0
Aug  1 20:28:52 thuis kernel:  [add_to_page_cache+59/144] 
add_to_page_cache+0x3b/0x90
Aug  1 20:28:52 thuis kernel:  [mpage_readpages+157/320] 
mpage_readpages+0x9d/0x140
Aug  1 20:28:52 thuis kernel:  [reiserfs_get_block+0/4880] 
reiserfs_get_block+0x0/0x1310
Aug  1 20:28:52 thuis kernel:  [pathrelse+28/48] pathrelse+0x1c/0x30
Aug  1 20:28:52 thuis kernel:  [autoremove_wake_function+0/64] 
autoremove_wake_function+0x0/0x40
Aug  1 20:28:52 thuis kernel:  [autoremove_wake_function+0/64] 
autoremove_wake_function+0x0/0x40
Aug  1 20:28:52 thuis kernel:  [reiserfs_readpages+25/32] 
reiserfs_readpages+0x19/0x20
Aug  1 20:28:52 thuis kernel:  [reiserfs_get_block+0/4880] 
reiserfs_get_block+0x0/0x1310
Aug  1 20:28:52 thuis kernel:  [read_pages+53/304] read_pages+0x35/0x130
Aug  1 20:28:52 thuis kernel:  [journal_end+142/160] journal_end+0x8e/0xa0
Aug  1 20:28:52 thuis kernel:  [do_page_cache_readahead+385/432] 
do_page_cache_readahead+0x181/0x1b0
Aug  1 20:28:52 thuis kernel:  [page_cache_readahead+298/432] 
page_cache_readahead+0x12a/0x1b0
Aug  1 20:28:52 thuis kernel:  [do_generic_mapping_read+185/896] 
do_generic_mapping_read+0xb9/0x380
Aug  1 20:28:52 thuis kernel:  [__generic_file_aio_read+456/496] 
__generic_file_aio_read+0x1c8/0x1f0
Aug  1 20:28:52 thuis kernel:  [file_read_actor+0/192] 
file_read_actor+0x0/0xc0
Aug  1 20:28:52 thuis kernel:  [generic_file_read+123/160] 
generic_file_read+0x7b/0xa0
Aug  1 20:28:52 thuis kernel:  [do_mmap_pgoff+843/1504] 
do_mmap_pgoff+0x34b/0x5e0
Aug  1 20:28:52 thuis kernel:  [old_mmap+205/272] old_mmap+0xcd/0x110
Aug  1 20:28:52 thuis kernel:  [vfs_read+156/208] vfs_read+0x9c/0xd0
Aug  1 20:28:52 thuis kernel:  [sys_read+49/80] sys_read+0x31/0x50
Aug  1 20:28:52 thuis kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  1 20:28:52 thuis kernel:
Aug  1 20:28:52 thuis kernel: Code: f3 ab f6 c3 02 74 02 66 ab f6 c3 01 
74 01 aa 83 7c 24 20 00
Aug  1 20:29:01 thuis kernel:  <1>Unable to handle kernel paging request 
at virtual address beced000
Aug  1 20:29:01 thuis kernel: c0165ffe
Aug  1 20:29:01 thuis kernel: PREEMPT

Occurence 3+more

Aug  1 20:29:01 thuis kernel:  <1>Unable to handle kernel paging request 
at virtual address beced000
Aug  1 20:29:01 thuis kernel: c0165ffe
Aug  1 20:29:01 thuis kernel: PREEMPT
Aug  1 20:29:01 thuis kernel: Modules linked in: usbhid parport_pc lp 
parport raid1 raid0 md uhci_hcd usbcore hangcheck_timer nvidia tuner 
tvaudio bttv video
_buf i2c_algo_bit v4l2_common btcx_risc videodev snd_pcm_oss 
snd_mixer_oss snd_bt87x snd_emu10k1 snd_rawmidi snd_pcm snd_timer 
snd_seq_device snd_ac97_codec
snd_page_alloc snd_util_mem snd_hwdep snd via686a i2c_sensor i2c_isa 
i2c_core ip_nat_irc ip_nat_ftp ip_conntrack_irc ip_conntrack_ftp ip_gre 
st ipddp appleta
lk psnap llc 8390
Aug  1 20:29:01 thuis kernel: CPU:    0
Aug  1 20:29:01 thuis kernel: EIP:    
0060:[do_mpage_readpage+542/1008]    Tainted: P
Aug  1 20:29:01 thuis kernel: EFLAGS: 00010216   (2.6.7)
Aug  1 20:29:01 thuis kernel: EIP is at do_mpage_readpage+0x21e/0x3f0
Aug  1 20:29:01 thuis kernel: eax: 00000000   ebx: 00001000   ecx: 
00000400   edx: feced000
Aug  1 20:29:01 thuis kernel: esi: 00000000   edi: beced000   ebp: 
00000001   esp: d8fd9bec
Aug  1 20:29:01 thuis kernel: ds: 007b   es: 007b   ss: 0068
Aug  1 20:29:01 thuis kernel: Process uudeview (pid: 32325, 
threadinfo=d8fd8000 task=e6c361f0)
Aug  1 20:29:01 thuis kernel: Stack: d8fd9dbc 00000000 00000000 d8fd9cd0 
00000020 00000000 00000000 00000000
Aug  1 20:29:01 thuis kernel:        00000000 00000030 00000000 d8fd9dd5 
00000000 00000001 0000000c e0511dd0
Aug  1 20:29:01 thuis kernel:        00000000 c01f71b4 e7fcc860 d8fd9dbc 
00000002 c01f7339 e0511e78 d8fd8000
Aug  1 20:29:01 thuis kernel: Call Trace:
Aug  1 20:29:01 thuis kernel:  [radix_tree_node_alloc+20/80] 
radix_tree_node_alloc+0x14/0x50
Aug  1 20:29:01 thuis kernel:  [radix_tree_extend+185/288] 
radix_tree_extend+0xb9/0x120
Aug  1 20:29:01 thuis kernel:  [radix_tree_node_alloc+20/80] 
radix_tree_node_alloc+0x14/0x50
Aug  1 20:29:01 thuis kernel:  [radix_tree_insert+111/240] 
radix_tree_insert+0x6f/0xf0
Aug  1 20:29:01 thuis kernel:  [add_to_page_cache+59/144] 
add_to_page_cache+0x3b/0x90
Aug  1 20:29:01 thuis kernel:  [mpage_readpages+157/320] 
mpage_readpages+0x9d/0x140
Aug  1 20:29:01 thuis kernel:  [reiserfs_get_block+0/4880] 
reiserfs_get_block+0x0/0x1310
Aug  1 20:29:01 thuis kernel:  [pathrelse+28/48] pathrelse+0x1c/0x30
Aug  1 20:29:01 thuis kernel:  [autoremove_wake_function+0/64] 
autoremove_wake_function+0x0/0x40
Aug  1 20:29:01 thuis kernel:  [autoremove_wake_function+0/64] 
autoremove_wake_function+0x0/0x40
Aug  1 20:29:01 thuis kernel:  [reiserfs_readpages+25/32] 
reiserfs_readpages+0x19/0x20
Aug  1 20:29:01 thuis kernel:  [reiserfs_get_block+0/4880] 
reiserfs_get_block+0x0/0x1310
Aug  1 20:29:01 thuis kernel:  [read_pages+53/304] read_pages+0x35/0x130
Aug  1 20:29:01 thuis kernel:  [journal_end+142/160] journal_end+0x8e/0xa0
Aug  1 20:29:01 thuis kernel:  [do_page_cache_readahead+385/432] 
do_page_cache_readahead+0x181/0x1b0
Aug  1 20:29:01 thuis kernel:  [page_cache_readahead+298/432] 
page_cache_readahead+0x12a/0x1b0
Aug  1 20:29:01 thuis kernel:  [do_generic_mapping_read+185/896] 
do_generic_mapping_read+0xb9/0x380
Aug  1 20:29:01 thuis kernel:  [__generic_file_aio_read+456/496] 
__generic_file_aio_read+0x1c8/0x1f0
Aug  1 20:29:01 thuis kernel:  [file_read_actor+0/192] 
file_read_actor+0x0/0xc0
Aug  1 20:29:01 thuis kernel:  [generic_file_read+123/160] 
generic_file_read+0x7b/0xa0
Aug  1 20:29:01 thuis kernel:  [do_mmap_pgoff+843/1504] 
do_mmap_pgoff+0x34b/0x5e0
Aug  1 20:29:01 thuis kernel:  [old_mmap+205/272] old_mmap+0xcd/0x110
Aug  1 20:29:01 thuis kernel:  [vfs_read+156/208] vfs_read+0x9c/0xd0
Aug  1 20:29:01 thuis kernel:  [sys_read+49/80] sys_read+0x31/0x50
Aug  1 20:29:01 thuis kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  1 20:29:01 thuis kernel:
Aug  1 20:29:01 thuis kernel: Code: f3 ab f6 c3 02 74 02 66 ab f6 c3 01 
74 01 aa 83 7c 24 20 00
Aug  1 20:29:05 thuis kernel:  <1>Unable to handle kernel paging request 
at virtual address beced000
Aug  1 20:29:05 thuis kernel: c0165ffe
Aug  1 20:29:05 thuis kernel: PREEMPT
Aug  1 20:29:05 thuis kernel: Modules linked in: usbhid parport_pc lp 
parport raid1 raid0 md uhci_hcd usbcore hangcheck_timer nvidia tuner 
tvaudio bttv video
_buf i2c_algo_bit v4l2_common btcx_risc videodev snd_pcm_oss 
snd_mixer_oss snd_bt87x snd_emu10k1 snd_rawmidi snd_pcm snd_timer 
snd_seq_device snd_ac97_codec
snd_page_alloc snd_util_mem snd_hwdep snd via686a i2c_sensor i2c_isa 
i2c_core ip_nat_irc ip_nat_ftp ip_conntrack_irc ip_conntrack_ftp ip_gre 
st ipddp appleta
lk psnap llc 8390
Aug  1 20:29:05 thuis kernel: CPU:    0
Aug  1 20:29:05 thuis kernel: EIP:    
0060:[do_mpage_readpage+542/1008]    Tainted: P
Aug  1 20:29:05 thuis kernel: EFLAGS: 00010216   (2.6.7)
Aug  1 20:29:05 thuis kernel: EIP is at do_mpage_readpage+0x21e/0x3f0
Aug  1 20:29:05 thuis kernel: eax: 00000000   ebx: 00001000   ecx: 
00000400   edx: feced000
Aug  1 20:29:05 thuis kernel: esi: 00000000   edi: beced000   ebp: 
00000001   esp: d8fd9bec
Aug  1 20:29:05 thuis kernel: ds: 007b   es: 007b   ss: 0068
Aug  1 20:29:05 thuis kernel: Process uudeview (pid: 32327, 
threadinfo=d8fd8000 task=e6c361f0)
Aug  1 20:29:05 thuis kernel: Stack: d8fd9dbc 00000000 00000000 d8fd9cd0 
00000020 00000000 00000000 00000000
Aug  1 20:29:05 thuis kernel:        00000000 00000032 00000000 d8fd9dd5 
00000000 00000001 0000000c da59ee10
Aug  1 20:29:05 thuis kernel:        00000000 c01f71b4 e7fcc860 d8fd9dbc 
00000002 c01f7339 da59eeb8 d8fd8000
Aug  1 20:29:05 thuis kernel: Call Trace:
Aug  1 20:29:05 thuis kernel:  [radix_tree_node_alloc+20/80] 
radix_tree_node_alloc+0x14/0x50
Aug  1 20:29:05 thuis kernel:  [radix_tree_extend+185/288] 
radix_tree_extend+0xb9/0x120
Aug  1 20:29:05 thuis kernel:  [radix_tree_node_alloc+20/80] 
radix_tree_node_alloc+0x14/0x50
Aug  1 20:29:05 thuis kernel:  [radix_tree_insert+111/240] 
radix_tree_insert+0x6f/0xf0
Aug  1 20:29:05 thuis kernel:  [add_to_page_cache+59/144] 
add_to_page_cache+0x3b/0x90
Aug  1 20:29:05 thuis kernel:  [mpage_readpages+157/320] 
mpage_readpages+0x9d/0x140
Aug  1 20:29:05 thuis kernel:  [reiserfs_get_block+0/4880] 
reiserfs_get_block+0x0/0x1310
Aug  1 20:29:05 thuis kernel:  [handle_mm_fault+109/320] 
handle_mm_fault+0x6d/0x140
Aug  1 20:29:05 thuis kernel:  [do_page_fault+319/1200] 
do_page_fault+0x13f/0x4b0
Aug  1 20:29:05 thuis kernel:  [reiserfs_readpages+25/32] 
reiserfs_readpages+0x19/0x20
Aug  1 20:29:05 thuis kernel:  [reiserfs_get_block+0/4880] 
reiserfs_get_block+0x0/0x1310
Aug  1 20:29:05 thuis kernel:  [read_pages+53/304] read_pages+0x35/0x130
Aug  1 20:29:05 thuis kernel:  [journal_end+142/160] journal_end+0x8e/0xa0
Aug  1 20:29:05 thuis kernel:  [do_page_cache_readahead+385/432] 
do_page_cache_readahead+0x181/0x1b0
Aug  1 20:29:05 thuis kernel:  [page_cache_readahead+298/432] 
page_cache_readahead+0x12a/0x1b0
Aug  1 20:29:05 thuis kernel:  [do_generic_mapping_read+185/896] 
do_generic_mapping_read+0xb9/0x380
Aug  1 20:29:05 thuis kernel:  [__generic_file_aio_read+456/496] 
__generic_file_aio_read+0x1c8/0x1f0
Aug  1 20:29:05 thuis kernel:  [file_read_actor+0/192] 
file_read_actor+0x0/0xc0
Aug  1 20:29:05 thuis kernel:  [generic_file_read+123/160] 
generic_file_read+0x7b/0xa0
Aug  1 20:29:05 thuis kernel:  [try_to_wake_up+79/176] 
try_to_wake_up+0x4f/0xb0
Aug  1 20:29:05 thuis kernel:  [try_to_wake_up+155/176] 
try_to_wake_up+0x9b/0xb0
Aug  1 20:29:05 thuis kernel:  [process_timeout+0/16] 
process_timeout+0x0/0x10
Aug  1 20:29:05 thuis kernel:  [recalc_task_prio+292/320] 
recalc_task_prio+0x124/0x140
Aug  1 20:29:05 thuis kernel:  [schedule+569/1072] schedule+0x239/0x430
Aug  1 20:29:05 thuis kernel:  [vfs_read+156/208] vfs_read+0x9c/0xd0
Aug  1 20:29:05 thuis kernel:  [sys_read+49/80] sys_read+0x31/0x50
Aug  1 20:29:05 thuis kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  1 20:29:05 thuis kernel:
Aug  1 20:29:05 thuis kernel: Code: f3 ab f6 c3 02 74 02 66 ab f6 c3 01 
74 01 aa 83 7c 24 20 00
Aug  1 20:29:30 thuis kernel:  <1>Unable to handle kernel paging request 
at virtual address 08f6356c
Aug  1 20:29:30 thuis kernel: c019a72c
Aug  1 20:29:30 thuis kernel: PREEMPT
Aug  1 20:29:30 thuis kernel: Modules linked in: usbhid parport_pc lp 
parport raid1 raid0 md uhci_hcd usbcore hangcheck_timer nvidia tuner 
tvaudio bttv video
_buf i2c_algo_bit v4l2_common btcx_risc videodev snd_pcm_oss 
snd_mixer_oss snd_bt87x snd_emu10k1 snd_rawmidi snd_pcm snd_timer 
snd_seq_device snd_ac97_codec
snd_page_alloc snd_util_mem snd_hwdep snd via686a i2c_sensor i2c_isa 
i2c_core ip_nat_irc ip_nat_ftp ip_conntrack_irc ip_conntrack_ftp ip_gre 
st ipddp appleta
lk psnap llc 8390
Aug  1 20:29:30 thuis kernel: CPU:    0
Aug  1 20:29:30 thuis kernel: EIP:    
0060:[write_ordered_buffers+428/608]    Tainted: P
Aug  1 20:29:30 thuis kernel: EFLAGS: 00010212   (2.6.7)
Aug  1 20:29:30 thuis kernel: EIP is at write_ordered_buffers+0x1ac/0x260
Aug  1 20:29:30 thuis kernel: eax: cbaffd94   ebx: ca83a000   ecx: 
c32e4810   edx: 00000000
Aug  1 20:29:30 thuis kernel: esi: 08f63568   edi: d1efb1a8   ebp: 
c30eed34   esp: ca83bd70
Aug  1 20:29:30 thuis kernel: ds: 007b   es: 007b   ss: 0068
Aug  1 20:29:30 thuis kernel: Process pdflush (pid: 16519, 
threadinfo=ca83a000 task=c936e2b0)
Aug  1 20:29:30 thuis kernel: Stack: c30eed34 ffffffff dc75389c c30eecd8 
00000000 d1efb1b0 cbaffd94 c57d9a70
Aug  1 20:29:30 thuis kernel:        c57d921c c57d9aa4 c57d9800 c57d9eb4 
c57d95c4 c60faad8 db251694 db251b74
Aug  1 20:29:30 thuis kernel:        db251798 db251e4c db2519d4 d5f416fc 
d5f412ec d5f410e4 d5f413bc d5f41c10
Aug  1 20:29:30 thuis kernel: Call Trace:
Aug  1 20:29:30 thuis kernel:  [flush_commit_list+286/944] 
flush_commit_list+0x11e/0x3b0
Aug  1 20:29:30 thuis kernel:  [do_journal_end+2783/2832] 
do_journal_end+0xadf/0xb10
Aug  1 20:29:30 thuis kernel:  [journal_end_sync+86/96] 
journal_end_sync+0x56/0x60
Aug  1 20:29:30 thuis kernel:  [reiserfs_sync_fs+61/144] 
reiserfs_sync_fs+0x3d/0x90
Aug  1 20:29:30 thuis kernel:  [reiserfs_write_super+10/16] 
reiserfs_write_super+0xa/0x10
Aug  1 20:29:30 thuis kernel:  [sync_supers+108/192] sync_supers+0x6c/0xc0
Aug  1 20:29:30 thuis kernel:  [wb_kupdate+65/288] wb_kupdate+0x41/0x120
Aug  1 20:29:30 thuis kernel:  [__pdflush+265/432] __pdflush+0x109/0x1b0
Aug  1 20:29:30 thuis kernel:  [pdflush+0/48] pdflush+0x0/0x30
Aug  1 20:29:30 thuis kernel:  [pdflush+30/48] pdflush+0x1e/0x30
Aug  1 20:29:30 thuis kernel:  [wb_kupdate+0/288] wb_kupdate+0x0/0x120
Aug  1 20:29:30 thuis kernel:  [kthread+112/160] kthread+0x70/0xa0
Aug  1 20:29:30 thuis kernel:  [kthread+0/160] kthread+0x0/0xa0
Aug  1 20:29:30 thuis kernel:  [kernel_thread_helper+5/16] 
kernel_thread_helper+0x5/0x10
Aug  1 20:29:30 thuis kernel:
Aug  1 20:29:30 thuis kernel: Code: ff 46 04 56 e8 4b fc ff ff 8b 06 83 
c4 04 a8 04 74 32 ff 4b
Aug  1 20:29:30 thuis kernel:  <6>note: pdflush[16519] exited with 
preempt_count 1
Aug  1 20:29:38 thuis kernel: ------------[ cut here ]------------
Aug  1 20:29:38 thuis kernel: PREEMPT
Aug  1 20:29:38 thuis kernel: Modules linked in: usbhid parport_pc lp 
parport raid1 raid0 md uhci_hcd usbcore hangcheck_timer nvidia tuner 
tvaudio bttv video
_buf i2c_algo_bit v4l2_common btcx_risc videodev snd_pcm_oss 
snd_mixer_oss snd_bt87x snd_emu10k1 snd_rawmidi snd_pcm snd_timer 
snd_seq_device snd_ac97_codec
snd_page_alloc snd_util_mem snd_hwdep snd via686a i2c_sensor i2c_isa 
i2c_core ip_nat_irc ip_nat_ftp ip_conntrack_irc ip_conntrack_ftp ip_gre 
st ipddp appleta
lk psnap llc 8390
Aug  1 20:29:38 thuis kernel: CPU:    0
Aug  1 20:29:38 thuis kernel: EIP:    0060:[mpage_readpages+281/320]    
Tainted: P
Aug  1 20:29:38 thuis kernel: EFLAGS: 00010213   (2.6.7)
Aug  1 20:29:38 thuis kernel: EIP is at mpage_readpages+0x119/0x140
Aug  1 20:29:38 thuis kernel: eax: ffffff00   ebx: d8fd9dbc   ecx: 
00000000   edx: d8fd9dd4
Aug  1 20:29:38 thuis kernel: esi: 00000001   edi: 00000000   ebp: 
d8fd9cd0   esp: d8fd9cb8
Aug  1 20:29:38 thuis kernel: ds: 007b   es: 007b   ss: 0068
Aug  1 20:29:38 thuis kernel: Process uudeview (pid: 32337, 
threadinfo=d8fd8000 task=e6c361f0)
Aug  1 20:29:38 thuis kernel: Stack: 0000002f d8fd8000 d8fd8000 d8fd9ddc 
00000000 00000000 00000000 00000000
Aug  1 20:29:38 thuis kernel:        d8fd9d24 cfa23d14 c019467c d5dc42b8 
d8fd9d24 d8fd8000 e0511dd0 00000000
Aug  1 20:29:38 thuis kernel:        e6c361f0 c0116bb0 d8fd9d14 d8fd9d14 
00000000 e6c361f0 c0116bb0 d8fd9d14
Aug  1 20:29:38 thuis kernel: Call Trace:
Aug  1 20:29:38 thuis kernel:  [pathrelse+28/48] pathrelse+0x1c/0x30
Aug  1 20:29:38 thuis kernel:  [autoremove_wake_function+0/64] 
autoremove_wake_function+0x0/0x40
Aug  1 20:29:38 thuis kernel:  [autoremove_wake_function+0/64] 
autoremove_wake_function+0x0/0x40
Aug  1 20:29:38 thuis kernel:  [reiserfs_readpages+25/32] 
reiserfs_readpages+0x19/0x20
Aug  1 20:29:38 thuis kernel:  [reiserfs_get_block+0/4880] 
reiserfs_get_block+0x0/0x1310
Aug  1 20:29:38 thuis kernel:  [read_pages+53/304] read_pages+0x35/0x130
Aug  1 20:29:38 thuis kernel:  [journal_end+142/160] journal_end+0x8e/0xa0
Aug  1 20:29:38 thuis kernel:  [do_page_cache_readahead+385/432] 
do_page_cache_readahead+0x181/0x1b0
Aug  1 20:29:38 thuis kernel:  [page_cache_readahead+298/432] 
page_cache_readahead+0x12a/0x1b0
Aug  1 20:29:38 thuis kernel:  [do_generic_mapping_read+185/896] 
do_generic_mapping_read+0xb9/0x380
Aug  1 20:29:38 thuis kernel:  [__generic_file_aio_read+456/496] 
__generic_file_aio_read+0x1c8/0x1f0
Aug  1 20:29:38 thuis kernel:  [file_read_actor+0/192] 
file_read_actor+0x0/0xc0
Aug  1 20:29:38 thuis kernel:  [generic_file_read+123/160] 
generic_file_read+0x7b/0xa0
Aug  1 20:29:38 thuis kernel:  [do_mmap_pgoff+843/1504] 
do_mmap_pgoff+0x34b/0x5e0
Aug  1 20:29:38 thuis kernel:  [old_mmap+205/272] old_mmap+0xcd/0x110
Aug  1 20:29:38 thuis kernel:  [vfs_read+156/208] vfs_read+0x9c/0xd0
Aug  1 20:29:38 thuis kernel:  [sys_read+49/80] sys_read+0x31/0x50
Aug  1 20:29:38 thuis kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  1 20:29:38 thuis kernel:
Aug  1 20:29:38 thuis kernel: Code: 0f 0b 5c 01 25 33 33 c0 85 ff 74 0b 
57 6a 00 e8 b3 f9 ff ff
Aug  1 20:29:50 thuis kernel:  <1>Unable to handle kernel paging request 
at virtual address beced000
Aug  1 20:29:50 thuis kernel: c0165ffe
Aug  1 20:29:50 thuis kernel: PREEMPT
Aug  1 20:29:50 thuis kernel: Modules linked in: usbhid parport_pc lp 
parport raid1 raid0 md uhci_hcd usbcore hangcheck_timer nvidia tuner 
tvaudio bttv video
_buf i2c_algo_bit v4l2_common btcx_risc videodev snd_pcm_oss 
snd_mixer_oss snd_bt87x snd_emu10k1 snd_rawmidi snd_pcm snd_timer 
snd_seq_device snd_ac97_codec
snd_page_alloc snd_util_mem snd_hwdep snd via686a i2c_sensor i2c_isa 
i2c_core ip_nat_irc ip_nat_ftp ip_conntrack_irc ip_conntrack_ftp ip_gre 
st ipddp appleta
lk psnap llc 8390
Aug  1 20:29:50 thuis kernel: CPU:    0
Aug  1 20:29:50 thuis kernel: EIP:    
0060:[do_mpage_readpage+542/1008]    Tainted: P
Aug  1 20:29:50 thuis kernel: EFLAGS: 00010216   (2.6.7)
Aug  1 20:29:50 thuis kernel: EIP is at do_mpage_readpage+0x21e/0x3f0
Aug  1 20:29:50 thuis kernel: eax: 00000000   ebx: 00001000   ecx: 
00000400   edx: feced000
Aug  1 20:29:50 thuis kernel: esi: 00000000   edi: beced000   ebp: 
00000001   esp: d8fd9bec
Aug  1 20:29:50 thuis kernel: ds: 007b   es: 007b   ss: 0068
Aug  1 20:29:50 thuis kernel: Process uudeview (pid: 32341, 
threadinfo=d8fd8000 task=e6c361f0)
Aug  1 20:29:38 thuis kernel:  [old_mmap+205/272] old_mmap+0xcd/0x110
Aug  1 20:29:38 thuis kernel:  [vfs_read+156/208] vfs_read+0x9c/0xd0
Aug  1 20:29:38 thuis kernel:  [sys_read+49/80] sys_read+0x31/0x50
Aug  1 20:29:38 thuis kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  1 20:29:38 thuis kernel:
Aug  1 20:29:38 thuis kernel: Code: 0f 0b 5c 01 25 33 33 c0 85 ff 74 0b 
57 6a 00 e8 b3 f9 ff ff
Aug  1 20:29:50 thuis kernel:  <1>Unable to handle kernel paging request 
at virtual address beced000
Aug  1 20:29:50 thuis kernel: c0165ffe
Aug  1 20:29:50 thuis kernel: PREEMPT
Aug  1 20:29:50 thuis kernel: Modules linked in: usbhid parport_pc lp 
parport raid1 raid0 md uhci_hcd usbcore hangcheck_timer nvidia tuner 
tvaudio bttv video
_buf i2c_algo_bit v4l2_common btcx_risc videodev snd_pcm_oss 
snd_mixer_oss snd_bt87x snd_emu10k1 snd_rawmidi snd_pcm snd_timer 
snd_seq_device snd_ac97_codec
snd_page_alloc snd_util_mem snd_hwdep snd via686a i2c_sensor i2c_isa 
i2c_core ip_nat_irc ip_nat_ftp ip_conntrack_irc ip_conntrack_ftp ip_gre 
st ipddp appleta
lk psnap llc 8390
Aug  1 20:29:50 thuis kernel: CPU:    0
Aug  1 20:29:50 thuis kernel: EIP:    
0060:[do_mpage_readpage+542/1008]    Tainted: P
Aug  1 20:29:50 thuis kernel: EFLAGS: 00010216   (2.6.7)
Aug  1 20:29:50 thuis kernel: EIP is at do_mpage_readpage+0x21e/0x3f0
Aug  1 20:29:50 thuis kernel: eax: 00000000   ebx: 00001000   ecx: 
00000400   edx: feced000
Aug  1 20:29:50 thuis kernel: esi: 00000000   edi: beced000   ebp: 
00000001   esp: d8fd9bec
Aug  1 20:29:50 thuis kernel: ds: 007b   es: 007b   ss: 0068
Aug  1 20:29:50 thuis kernel: Process uudeview (pid: 32341, 
threadinfo=d8fd8000 task=e6c361f0)
Aug  1 20:29:50 thuis kernel: Stack: d8fd9dbc 00000000 00000000 d8fd9cd0 
00000020 00000000 00000000 00000000
Aug  1 20:29:50 thuis kernel:        00000000 0000003e 00000000 d8fd9dd5 
00000000 00000001 0000000c d3728a50
Aug  1 20:29:50 thuis kernel:        00000000 c01f71b4 e7fcc860 d8fd9dbc 
00000002 c01f7339 d3728af8 d8fd8000
Aug  1 20:29:50 thuis kernel: Call Trace:
Aug  1 20:29:50 thuis kernel:  [radix_tree_node_alloc+20/80] 
radix_tree_node_alloc+0x14/0x50
Aug  1 20:29:50 thuis kernel:  [radix_tree_extend+185/288] 
radix_tree_extend+0xb9/0x120
Aug  1 20:29:50 thuis kernel:  [radix_tree_node_alloc+20/80] 
radix_tree_node_alloc+0x14/0x50
Aug  1 20:29:50 thuis kernel:  [radix_tree_insert+111/240] 
radix_tree_insert+0x6f/0xf0
Aug  1 20:29:50 thuis kernel:  [add_to_page_cache+59/144] 
add_to_page_cache+0x3b/0x90
Aug  1 20:29:50 thuis kernel:  [mpage_readpages+157/320] 
mpage_readpages+0x9d/0x140
Aug  1 20:29:50 thuis kernel:  [reiserfs_get_block+0/4880] 
reiserfs_get_block+0x0/0x1310
Aug  1 20:29:50 thuis kernel:  [pathrelse+28/48] pathrelse+0x1c/0x30
Aug  1 20:29:50 thuis kernel:  [autoremove_wake_function+0/64] 
autoremove_wake_function+0x0/0x40
Aug  1 20:29:50 thuis kernel:  [autoremove_wake_function+0/64] 
autoremove_wake_function+0x0/0x40
Aug  1 20:29:50 thuis kernel:  [reiserfs_readpages+25/32] 
reiserfs_readpages+0x19/0x20
Aug  1 20:29:50 thuis kernel:  [reiserfs_get_block+0/4880] 
reiserfs_get_block+0x0/0x1310
Aug  1 20:29:50 thuis kernel:  [read_pages+53/304] read_pages+0x35/0x130
Aug  1 20:29:50 thuis kernel:  [journal_end+142/160] journal_end+0x8e/0xa0
Aug  1 20:29:50 thuis kernel:  [do_page_cache_readahead+385/432] 
do_page_cache_readahead+0x181/0x1b0
Aug  1 20:29:50 thuis kernel:  [page_cache_readahead+298/432] 
page_cache_readahead+0x12a/0x1b0
Aug  1 20:29:50 thuis kernel:  [do_generic_mapping_read+185/896] 
do_generic_mapping_read+0xb9/0x380
Aug  1 20:29:50 thuis kernel:  [__generic_file_aio_read+456/496] 
__generic_file_aio_read+0x1c8/0x1f0
Aug  1 20:29:50 thuis kernel:  [file_read_actor+0/192] 
file_read_actor+0x0/0xc0
Aug  1 20:29:50 thuis kernel:  [generic_file_read+123/160] 
generic_file_read+0x7b/0xa0
Aug  1 20:29:50 thuis kernel:  [do_mmap_pgoff+843/1504] 
do_mmap_pgoff+0x34b/0x5e0
Aug  1 20:29:50 thuis kernel:  [old_mmap+205/272] old_mmap+0xcd/0x110
Aug  1 20:29:50 thuis kernel:  [vfs_read+156/208] vfs_read+0x9c/0xd0
Aug  1 20:29:50 thuis kernel:  [sys_read+49/80] sys_read+0x31/0x50
Aug  1 20:29:50 thuis kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  1 20:29:50 thuis kernel:
Aug  1 20:29:50 thuis kernel: Code: f3 ab f6 c3 02 74 02 66 ab f6 c3 01 
74 01 aa 83 7c 24 20 00


syslog.0:Aug 29 23:11:54 thuis kernel: ReiserFS: sdc1: found reiserfs 
format "3.6" with standard journal
syslog.0:Aug 29 23:11:54 thuis kernel: ReiserFS: sdb1: found reiserfs 
format "3.5" with standard journal
syslog.0:Aug 29 23:11:54 thuis kernel: ReiserFS: md1: found reiserfs 
format "3.6" with standard journal
syslog.0:Aug 29 23:11:54 thuis kernel: ReiserFS: sda6: found reiserfs 
format "3.6" with standard journal

mount
/dev/sda1 on / type ext3 (rw,errors=remount-ro)
proc on /proc type proc (rw)
devpts on /dev/pts type devpts (rw,gid=5,mode=620)
/dev/sda5 on /usr type ext3 (rw)
/dev/sdc1 on /mnt/fast type reiserfs (rw)
/dev/sdb1 on /mnt/myth type reiserfs (rw)
/dev/md1 on /mnt/mirror type reiserfs (rw)
/dev/sda6 on /home type reiserfs (rw)
/dev/hdc1 on /mnt/scratch type ext2 (rw)
/sys on /sys type sysfs (rw)
none on /proc/bus/usb type usbfs (rw)

--------------000004070104090408020502
Content-Type: text/plain;
 name="newsan2.6.7-config"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="newsan2.6.7-config"

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_STANDALONE=y
CONFIG_BROKEN_ON_SMP=y

#
# General setup
#
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
CONFIG_LOG_BUF_SHIFT=14
CONFIG_HOTPLUG=y
# CONFIG_IKCONFIG is not set
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
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
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
CONFIG_MK7=y
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_USE_3DNOW=y
# CONFIG_HPET_TIMER is not set
# CONFIG_HPET_EMULATE_RTC is not set
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
# CONFIG_X86_MCE_P4THERMAL is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
CONFIG_MICROCODE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y

#
# Firmware Drivers
#
# CONFIG_EDD is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y
# CONFIG_REGPARM is not set

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
# CONFIG_SOFTWARE_SUSPEND is not set
# CONFIG_PM_DISK is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
# CONFIG_ACPI is not set
CONFIG_ACPI_BOOT=y

#
# APM (Advanced Power Management) BIOS Support
#
CONFIG_APM=y
CONFIG_APM_IGNORE_USER_SUSPEND=y
CONFIG_APM_DO_ENABLE=y
CONFIG_APM_CPU_IDLE=y
# CONFIG_APM_DISPLAY_BLANK is not set
# CONFIG_APM_RTC_IS_GMT is not set
CONFIG_APM_ALLOW_INTS=y
CONFIG_APM_REAL_MODE_POWER_OFF=y

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
# CONFIG_PCI_USE_VECTOR is not set
CONFIG_PCI_LEGACY_PROC=y
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set

#
# PCMCIA/CardBus support
#
# CONFIG_PCMCIA is not set
CONFIG_PCMCIA_PROBE=y

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_MISC=y

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_FW_LOADER=m

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
# CONFIG_PARPORT_PC_SUPERIO is not set
CONFIG_PARPORT_OTHER=y
CONFIG_PARPORT_1284=y

#
# Plug and Play support
#
CONFIG_PNP=y
CONFIG_PNP_DEBUG=y

#
# Protocols
#
CONFIG_ISAPNP=y
CONFIG_PNPBIOS=y
CONFIG_PNPBIOS_PROC_FS=y

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_CRYPTOLOOP=y
CONFIG_BLK_DEV_NBD=y
# CONFIG_BLK_DEV_CARMEL is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_LBD=y

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=m
# CONFIG_BLK_DEV_IDETAPE is not set
CONFIG_BLK_DEV_IDEFLOPPY=m
CONFIG_BLK_DEV_IDESCSI=m
# CONFIG_IDE_TASK_IOCTL is not set
# CONFIG_IDE_TASKFILE_IO is not set

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
CONFIG_BLK_DEV_ADMA=y
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
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
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
CONFIG_CHR_DEV_ST=m
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=y

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

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AACRAID is not set
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=32
CONFIG_AIC7XXX_RESET_DELAY_MS=1500
# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
# CONFIG_AIC7XXX_DEBUG_ENABLE is not set
CONFIG_AIC7XXX_DEBUG_MASK=0
CONFIG_AIC7XXX_REG_PRETTY_PRINT=y
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_SATA is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
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
# CONFIG_SCSI_QLA6322 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID5=m
CONFIG_MD_RAID6=m
CONFIG_MD_MULTIPATH=m
CONFIG_BLK_DEV_DM=m
CONFIG_DM_CRYPT=m

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_IEEE1394=y

#
# Subsystem Options
#
# CONFIG_IEEE1394_VERBOSEDEBUG is not set
# CONFIG_IEEE1394_OUI_DB is not set
# CONFIG_IEEE1394_EXTRA_CONFIG_ROMS is not set

#
# Device Drivers
#
# CONFIG_IEEE1394_PCILYNX is not set
CONFIG_IEEE1394_OHCI1394=y

#
# Protocol Drivers
#
# CONFIG_IEEE1394_VIDEO1394 is not set
# CONFIG_IEEE1394_SBP2 is not set
# CONFIG_IEEE1394_ETH1394 is not set
# CONFIG_IEEE1394_DV1394 is not set
CONFIG_IEEE1394_RAWIO=y
# CONFIG_IEEE1394_CMP is not set

#
# I2O device support
#
CONFIG_I2O=m
CONFIG_I2O_CONFIG=m
CONFIG_I2O_BLOCK=m
CONFIG_I2O_SCSI=m
CONFIG_I2O_PROC=m

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=m
CONFIG_UNIX=y
CONFIG_NET_KEY=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_FWMARK=y
CONFIG_IP_ROUTE_NAT=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_TOS=y
CONFIG_IP_ROUTE_VERBOSE=y
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_ARPD=y
CONFIG_SYN_COOKIES=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_IPCOMP=m

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
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_TFTP=m
# CONFIG_IP_NF_AMANDA is not set
CONFIG_IP_NF_QUEUE=m
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
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=y
CONFIG_IP_NF_NAT=y
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=y
CONFIG_IP_NF_TARGET_REDIRECT=y
CONFIG_IP_NF_TARGET_NETMAP=y
CONFIG_IP_NF_TARGET_SAME=y
# CONFIG_IP_NF_NAT_LOCAL is not set
# CONFIG_IP_NF_NAT_SNMP_BASIC is not set
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_NAT_TFTP=m
CONFIG_IP_NF_MANGLE=y
CONFIG_IP_NF_TARGET_TOS=y
CONFIG_IP_NF_TARGET_ECN=y
CONFIG_IP_NF_TARGET_DSCP=y
CONFIG_IP_NF_TARGET_MARK=y
CONFIG_IP_NF_TARGET_CLASSIFY=y
CONFIG_IP_NF_TARGET_LOG=y
CONFIG_IP_NF_TARGET_ULOG=y
CONFIG_IP_NF_TARGET_TCPMSS=y
CONFIG_IP_NF_ARPTABLES=y
CONFIG_IP_NF_ARPFILTER=y
CONFIG_IP_NF_ARP_MANGLE=y
# CONFIG_IP_NF_RAW is not set
CONFIG_XFRM=y
CONFIG_XFRM_USER=m

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_MSG is not set
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_HMAC_NONE is not set
# CONFIG_SCTP_HMAC_SHA1 is not set
CONFIG_SCTP_HMAC_MD5=y
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
CONFIG_VLAN_8021Q=m
# CONFIG_DECNET is not set
CONFIG_LLC=m
CONFIG_LLC2=m
# CONFIG_IPX is not set
CONFIG_ATALK=m
CONFIG_DEV_APPLETALK=y
# CONFIG_LTPC is not set
# CONFIG_COPS is not set
CONFIG_IPDDP=m
# CONFIG_IPDDP_ENCAP is not set
CONFIG_IPDDP_DECAP=y
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
CONFIG_NET_SCHED=y
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_CSZ=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_DELAY=m
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_QOS=y
CONFIG_NET_ESTIMATOR=y
CONFIG_NET_CLS=y
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_ROUTE=y
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_NET_CLS_RSVP=m
# CONFIG_NET_CLS_RSVP6 is not set
CONFIG_NET_CLS_POLICE=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_HAMRADIO is not set
CONFIG_IRDA=m

#
# IrDA protocols
#
CONFIG_IRLAN=m
CONFIG_IRNET=m
CONFIG_IRCOMM=m
CONFIG_IRDA_ULTRA=y

#
# IrDA options
#
CONFIG_IRDA_CACHE_LAST_LSAP=y
CONFIG_IRDA_FAST_RR=y
CONFIG_IRDA_DEBUG=y

#
# Infrared-port device drivers
#

#
# SIR device drivers
#
CONFIG_IRTTY_SIR=m

#
# Dongle support
#
CONFIG_DONGLE=y
# CONFIG_ESI_DONGLE is not set
# CONFIG_ACTISYS_DONGLE is not set
CONFIG_TEKRAM_DONGLE=m
# CONFIG_LITELINK_DONGLE is not set
# CONFIG_MA600_DONGLE is not set
# CONFIG_GIRBIL_DONGLE is not set
# CONFIG_MCP2120_DONGLE is not set
# CONFIG_OLD_BELKIN_DONGLE is not set
# CONFIG_ACT200L_DONGLE is not set

#
# Old SIR device drivers
#
CONFIG_IRPORT_SIR=m

#
# Old Serial dongle support
#
# CONFIG_DONGLE_OLD is not set

#
# FIR device drivers
#
CONFIG_USB_IRDA=m
# CONFIG_SIGMATEL_FIR is not set
# CONFIG_NSC_FIR is not set
CONFIG_WINBOND_FIR=m
# CONFIG_TOSHIBA_FIR is not set
# CONFIG_SMC_IRCC_FIR is not set
# CONFIG_ALI_FIR is not set
# CONFIG_VLSI_FIR is not set
CONFIG_VIA_FIR=m
CONFIG_BT=m
CONFIG_BT_L2CAP=m
CONFIG_BT_SCO=m
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y

#
# Bluetooth device drivers
#
CONFIG_BT_HCIUSB=m
CONFIG_BT_HCIUSB_SCO=y
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
# CONFIG_BT_HCIUART_BCSP_TXCRC is not set
CONFIG_BT_HCIBCM203X=m
CONFIG_BT_HCIBFUSB=m
CONFIG_BT_HCIVHCI=m
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
CONFIG_TUN=m
CONFIG_ETHERTAP=m
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
CONFIG_NET_ISA=y
# CONFIG_E2100 is not set
# CONFIG_EWRK3 is not set
# CONFIG_EEXPRESS is not set
CONFIG_EEXPRESS_PRO=m
# CONFIG_HPLAN_PLUS is not set
# CONFIG_HPLAN is not set
# CONFIG_LP486E is not set
# CONFIG_ETH16I is not set
CONFIG_NE2000=m
# CONFIG_ZNET is not set
# CONFIG_SEEQ8005 is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_B44 is not set
# CONFIG_FORCEDETH is not set
# CONFIG_CS89x0 is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
CONFIG_E100=y
# CONFIG_E100_NAPI is not set
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
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set

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

#
# Wireless 802.11b ISA/PCI cards support
#
CONFIG_AIRO=m
CONFIG_HERMES=m
# CONFIG_PLX_HERMES is not set
# CONFIG_TMD_HERMES is not set
CONFIG_PCI_HERMES=m
# CONFIG_ATMEL is not set

#
# Prism GT/Duette 802.11(a/b/g) PCI/Cardbus support
#
# CONFIG_PRISM54 is not set
CONFIG_NET_WIRELESS=y

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
CONFIG_PPP=y
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=y
CONFIG_PPP_SYNC_TTY=y
CONFIG_PPP_DEFLATE=y
CONFIG_PPP_BSDCOMP=y
CONFIG_PPPOE=m
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
CONFIG_SHAPER=m
# CONFIG_NETCONSOLE is not set

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
CONFIG_INPUT_JOYDEV=y
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
CONFIG_GAMEPORT=m
CONFIG_SOUND_GAMEPORT=m
CONFIG_GAMEPORT_NS558=m
# CONFIG_GAMEPORT_L4 is not set
# CONFIG_GAMEPORT_EMU10K1 is not set
# CONFIG_GAMEPORT_VORTEX is not set
# CONFIG_GAMEPORT_FM801 is not set
# CONFIG_GAMEPORT_CS461x is not set
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set

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
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=m
# CONFIG_JOYSTICK_A3D is not set
# CONFIG_JOYSTICK_ADI is not set
# CONFIG_JOYSTICK_COBRA is not set
# CONFIG_JOYSTICK_GF2K is not set
# CONFIG_JOYSTICK_GRIP is not set
# CONFIG_JOYSTICK_GRIP_MP is not set
# CONFIG_JOYSTICK_GUILLEMOT is not set
# CONFIG_JOYSTICK_INTERACT is not set
# CONFIG_JOYSTICK_SIDEWINDER is not set
# CONFIG_JOYSTICK_TMDC is not set
# CONFIG_JOYSTICK_IFORCE is not set
# CONFIG_JOYSTICK_WARRIOR is not set
# CONFIG_JOYSTICK_MAGELLAN is not set
# CONFIG_JOYSTICK_SPACEORB is not set
# CONFIG_JOYSTICK_SPACEBALL is not set
# CONFIG_JOYSTICK_STINGER is not set
# CONFIG_JOYSTICK_TWIDDLER is not set
# CONFIG_JOYSTICK_DB9 is not set
# CONFIG_JOYSTICK_GAMECON is not set
# CONFIG_JOYSTICK_TURBOGRAFX is not set
# CONFIG_INPUT_JOYDUMP is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=y
# CONFIG_INPUT_UINPUT is not set

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
CONFIG_SERIAL_8250_NR_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
# CONFIG_TIPAR is not set
# CONFIG_QIC02_TAPE is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_HW_RANDOM is not set
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
CONFIG_AGP=m
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD64 is not set
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_INTEL_MCH is not set
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
CONFIG_AGP_VIA=m
# CONFIG_AGP_EFFICEON is not set
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
CONFIG_HANGCHECK_TIMER=m

#
# I2C support
#
CONFIG_I2C=m
CONFIG_I2C_CHARDEV=m

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_ALGOPCF=m

#
# I2C Hardware Bus support
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_ELEKTOR is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_I810 is not set
CONFIG_I2C_ISA=m
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_PARPORT is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_PROSAVAGE is not set
# CONFIG_I2C_SAVAGE4 is not set
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m
# CONFIG_I2C_VOODOO3 is not set

#
# Hardware Sensors Chip support
#
CONFIG_I2C_SENSOR=m
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ASB100 is not set
# CONFIG_SENSORS_DS1621 is not set
# CONFIG_SENSORS_FSCHER is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_IT87 is not set
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM90=m
# CONFIG_SENSORS_MAX1619 is not set
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83627HF=m

#
# Other I2C Chip support
#
CONFIG_SENSORS_EEPROM=m
# CONFIG_SENSORS_PCF8574 is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_SENSORS_RTC8564 is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set

#
# Multimedia devices
#
CONFIG_VIDEO_DEV=m

#
# Video For Linux
#

#
# Video Adapters
#
CONFIG_VIDEO_BT848=m
# CONFIG_VIDEO_PMS is not set
# CONFIG_VIDEO_BWQCAM is not set
# CONFIG_VIDEO_CQCAM is not set
# CONFIG_VIDEO_W9966 is not set
# CONFIG_VIDEO_CPIA is not set
CONFIG_VIDEO_SAA5246A=m
CONFIG_VIDEO_SAA5249=m
CONFIG_TUNER_3036=m
# CONFIG_VIDEO_STRADIS is not set
# CONFIG_VIDEO_ZORAN is not set
CONFIG_VIDEO_SAA7134=m
# CONFIG_VIDEO_MXB is not set
# CONFIG_VIDEO_DPC is not set
# CONFIG_VIDEO_HEXIUM_ORION is not set
# CONFIG_VIDEO_HEXIUM_GEMINI is not set
CONFIG_VIDEO_CX88=m

#
# Radio Adapters
#
# CONFIG_RADIO_CADET is not set
# CONFIG_RADIO_RTRACK is not set
# CONFIG_RADIO_RTRACK2 is not set
# CONFIG_RADIO_AZTECH is not set
# CONFIG_RADIO_GEMTEK is not set
# CONFIG_RADIO_GEMTEK_PCI is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_MAESTRO is not set
# CONFIG_RADIO_SF16FMI is not set
# CONFIG_RADIO_SF16FMR2 is not set
# CONFIG_RADIO_TERRATEC is not set
# CONFIG_RADIO_TRUST is not set
# CONFIG_RADIO_TYPHOON is not set
# CONFIG_RADIO_ZOLTRIX is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set
CONFIG_VIDEO_TUNER=m
CONFIG_VIDEO_BUF=m
CONFIG_VIDEO_BTCX=m
CONFIG_VIDEO_IR=m

#
# Graphics support
#
# CONFIG_FB is not set
# CONFIG_VIDEO_SELECT is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y

#
# Sound
#
CONFIG_SOUND=y

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_HWDEP=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_SEQUENCER=m
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
CONFIG_SND_MPU401_UART=m
CONFIG_SND_DUMMY=m
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# ISA devices
#
# CONFIG_SND_AD1816A is not set
# CONFIG_SND_AD1848 is not set
# CONFIG_SND_CS4231 is not set
# CONFIG_SND_CS4232 is not set
# CONFIG_SND_CS4236 is not set
# CONFIG_SND_ES968 is not set
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
# CONFIG_SND_ALS100 is not set
# CONFIG_SND_AZT2320 is not set
# CONFIG_SND_CMI8330 is not set
# CONFIG_SND_DT019X is not set
# CONFIG_SND_OPL3SA2 is not set
# CONFIG_SND_SGALAXY is not set
# CONFIG_SND_SSCAPE is not set

#
# PCI devices
#
CONFIG_SND_AC97_CODEC=m
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AZT3328 is not set
CONFIG_SND_BT87X=m
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
CONFIG_SND_EMU10K1=m
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
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
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_SONICVIBES is not set
CONFIG_SND_VIA82XX=m
# CONFIG_SND_VX222 is not set

#
# ALSA USB devices
#
CONFIG_SND_USB_AUDIO=m

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB=m
CONFIG_USB_DEBUG=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_EHCI_HCD is not set
CONFIG_USB_OHCI_HCD=m
CONFIG_USB_UHCI_HCD=m

#
# USB Device Class drivers
#
CONFIG_USB_AUDIO=m

#
# USB Bluetooth TTY can only be used with disabled Bluetooth subsystem
#
# CONFIG_USB_MIDI is not set
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_HP8200e is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
CONFIG_USB_STORAGE_SDDR55=y
# CONFIG_USB_STORAGE_JUMPSHOT is not set

#
# USB Human Interface Devices (HID)
#
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
# CONFIG_HID_FF is not set
CONFIG_USB_HIDDEV=y

#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_MTOUCH is not set
# CONFIG_USB_EGALAX is not set
# CONFIG_USB_XPAD is not set
# CONFIG_USB_ATI_REMOTE is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set
# CONFIG_USB_VICAM is not set
# CONFIG_USB_DSBR is not set
# CONFIG_USB_IBMCAM is not set
# CONFIG_USB_KONICAWC is not set
# CONFIG_USB_OV511 is not set
CONFIG_USB_PWC=m
# CONFIG_USB_SE401 is not set
# CONFIG_USB_STV680 is not set
# CONFIG_USB_W9968CF is not set

#
# USB Network adaptors
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_TIGL is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_PHIDGETSERVO is not set
# CONFIG_USB_TEST is not set

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# File systems
#
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
# CONFIG_EXT3_FS_POSIX_ACL is not set
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
CONFIG_REISERFS_PROC_INFO=y
# CONFIG_REISERFS_FS_XATTR is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=y

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=m
CONFIG_UDF_FS=m

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_NTFS_FS=m
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVPTS_FS_XATTR is not set
CONFIG_TMPFS=y
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
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
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V4 is not set
# CONFIG_NFS_DIRECTIO is not set
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
# CONFIG_NFSD_V4 is not set
# CONFIG_NFSD_TCP is not set
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=y
CONFIG_SUNRPC=y
# CONFIG_RPCSEC_GSS_KRB5 is not set
CONFIG_SMB_FS=y
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp437"
# CONFIG_CIFS is not set
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
CONFIG_NLS_DEFAULT="iso8859-1"
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
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
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
CONFIG_NLS_ISO8859_15=y
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=y

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
# CONFIG_DEBUG_KERNEL is not set
CONFIG_EARLY_PRINTK=y
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_FRAME_POINTER is not set
# CONFIG_4KSTACKS is not set
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

#
# Security options
#
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_NULL is not set
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_SHA1=m
# CONFIG_CRYPTO_SHA256 is not set
# CONFIG_CRYPTO_SHA512 is not set
CONFIG_CRYPTO_DES=m
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_TWOFISH is not set
# CONFIG_CRYPTO_SERPENT is not set
# CONFIG_CRYPTO_AES is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_ARC4 is not set
CONFIG_CRYPTO_DEFLATE=m
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_CRC32C is not set
# CONFIG_CRYPTO_TEST is not set

#
# Library routines
#
CONFIG_CRC32=y
# CONFIG_LIBCRC32C is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_X86_STD_RESOURCES=y
CONFIG_PC=y

--------------000004070104090408020502--
