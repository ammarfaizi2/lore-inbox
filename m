Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbWAaNNf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbWAaNNf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 08:13:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbWAaNNf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 08:13:35 -0500
Received: from www.eclis.ch ([144.85.15.72]:51888 "EHLO mail.eclis.ch")
	by vger.kernel.org with ESMTP id S1750797AbWAaNNe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 08:13:34 -0500
Message-ID: <43DF6279.2070908@eclis.ch>
Date: Tue, 31 Jan 2006 14:13:29 +0100
From: Jean-Christian de Rivaz <jc@eclis.ch>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Strange Oops in serie on 2.6.13.4
Content-Type: multipart/mixed;
 boundary="------------090208070100020208080809"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090208070100020208080809
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This serie of 8 Oops happens in a production server using vanilla 
2.6.13.4 from kernel.org, config file attached. The workload was normal 
at this time, and 'cyrmaster' process don't show any unusual log before 
and just after the first double Oops. Uptime was more than 3 months at 
this time.

The machine is a K7 processor with 512M of RAM and a 'md' mirror of two 
IDE disks with 6 raid1 autodetect partitions, one of them used as swap. 
The machine never show any glitch since many years and sucesfully pass 
memtest86+ test. It work well since it has been rebooted.

I don't know if this event can be linked to something going wrong in the 
kernel.

Jan 30 09:08:37 localhost kernel: Unable to handle kernel paging request 
at virtual address 00c87cf8
Jan 30 09:08:37 localhost kernel:  printing eip:
Jan 30 09:08:37 localhost kernel: c01245d5
Jan 30 09:08:37 localhost kernel: *pde = 00000000
Jan 30 09:08:37 localhost kernel: Oops: 0002 [#1]
Jan 30 09:08:37 localhost kernel: Modules linked in: loop af_packet ipv6 
evdev i2c_viapro i2c_core tulip de4x5 crc32 ide_cd cdrom genrtc ext3 jbd 
ide_disk ide_generic via82cxxx trm290 triflex slc90e66 sis5513 siimage 
serverworks sc1200 rz1000 piix pdc202xx_old opt
i621 ns87415 hpt366 hpt34x generic cy82c693 cs5530 cs5520 cmd64x atiixp 
amd74xx alim15x3 aec62xx pdc202xx_new ide_core raid1 md_mod unix
Jan 30 09:08:37 localhost kernel: CPU:    0
Jan 30 09:08:37 localhost kernel: EIP:    0060:[remove_wait_queue+14/38] 
    Not tainted VLI
Jan 30 09:08:37 localhost kernel: EFLAGS: 00010092   (2.6.13.4-3)
Jan 30 09:08:37 localhost kernel: EIP is at remove_wait_queue+0xe/0x26
Jan 30 09:08:37 localhost kernel: eax: 00c87cf4   ebx: c9f45159   ecx: 
80000000   edx: c9f4514d
Jan 30 09:08:37 localhost kernel: esi: 00000292   edi: 00000000   ebp: 
00000080   esp: ce7f9ee0
Jan 30 09:08:37 localhost kernel: ds: 007b   es: 007b   ss: 0068
Jan 30 09:08:37 localhost kernel: Process cyrmaster (pid: 18658, 
threadinfo=ce7f8000 task=df280a80)
Jan 30 09:08:37 localhost kernel: Stack: c9f45149 c9f45000 c0151c4f 
c87cff60 00000002 c015203e ce7f9f44 00000000
Jan 30 09:08:37 localhost kernel:        00000000 0000004d 00000000 
00000000 00000001 00000007 0000004d d7c56338
Jan 30 09:08:37 localhost kernel:        d7c56330 d7c56328 d7c56350 
d7c56348 d7c56340 00000000 00000027 00000000
Jan 30 09:08:37 localhost kernel: Call Trace:
Jan 30 09:08:37 localhost kernel:  [poll_freewait+30/62] 
poll_freewait+0x1e/0x3e
Jan 30 09:08:37 localhost kernel:  [do_select+619/640] do_select+0x26b/0x280
Jan 30 09:08:37 localhost kernel:  [__pollwait+0/154] __pollwait+0x0/0x9a
Jan 30 09:08:37 localhost kernel:  [sys_select+648/935] 
sys_select+0x288/0x3a7
Jan 30 09:08:37 localhost kernel:  [sys_time+15/49] sys_time+0xf/0x31
Jan 30 09:08:37 localhost kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jan 30 09:08:37 localhost kernel: Code: 83 0a 01 53 9c 5e fa 89 42 0c 8b 
58 04 8d 4a 0c 89 48 04 89 0b 89 59 04 56 9d 5b 5e c3 56 53 9c 5e fa 8b 
42 0c 8d 5a 0c 8b 4b 04 <89> 48 04 89 01 c7 43 04 00 02 20 00 c7 42 0c 
00 01 10 00 56 9d
Jan 30 09:08:37 localhost kernel:  <1>Unable to handle kernel paging 
request at virtual address 34000000
Jan 30 09:08:37 localhost kernel:  printing eip:
Jan 30 09:08:37 localhost kernel: 34000000
Jan 30 09:08:37 localhost kernel: *pde = 00000000
Jan 30 09:08:37 localhost kernel: Oops: 0000 [#2]
Jan 30 09:08:37 localhost kernel: Modules linked in: loop af_packet ipv6 
evdev i2c_viapro i2c_core tulip de4x5 crc32 ide_cd cdrom genrtc ext3 jbd 
ide_disk ide_generic via82cxxx trm290 triflex slc90e66 sis5513 siimage 
serverworks sc1200 rz1000 piix pdc202xx_old opt
i621 ns87415 hpt366 hpt34x generic cy82c693 cs5530 cs5520 cmd64x atiixp 
amd74xx alim15x3 aec62xx pdc202xx_new ide_core raid1 md_mod unix
Jan 30 09:08:37 localhost kernel: CPU:    0
Jan 30 09:08:37 localhost kernel: EIP: 
0060:[phys_startup_32+871366656/-1073741824]    Not tainted VLI
Jan 30 09:08:37 localhost kernel: EFLAGS: 00010002   (2.6.13.4-3)
Jan 30 09:08:37 localhost kernel: EIP is at 0x34000000
Jan 30 09:08:37 localhost kernel: eax: d51aa1f5   ebx: 00000001   ecx: 
00000000   edx: d51aa201
Jan 30 09:08:37 localhost kernel: esi: 00000000   edi: d51aa200   ebp: 
ce7f9cf0   esp: ce7f9ccc
Jan 30 09:08:37 localhost kernel: ds: 007b   es: 007b   ss: 0068
Jan 30 09:08:37 localhost kernel: Process cyrmaster (pid: 18658, 
threadinfo=ce7f8000 task=df280a80)
Jan 30 09:08:37 localhost kernel: Stack: c011300d d51aa1f5 00000001 
00000000 00000000 34c9f450 00000202 d53c5880
Jan 30 09:08:37 localhost kernel:        c15e5318 ce7f9d10 c0113044 
d51aa200 00000001 00000001 00000000 00000000
Jan 30 09:08:37 localhost kernel:        c15e5318 dffe0440 c014cb83 
00000000 00000008 c014ccef c15e5318 00000000
Jan 30 09:08:37 localhost kernel: Call Trace:
Jan 30 09:08:37 localhost kernel:  [__wake_up_common+43/78] 
__wake_up_common+0x2b/0x4e
Jan 30 09:08:37 localhost kernel:  [__wake_up+20/30] __wake_up+0x14/0x1e
Jan 30 09:08:37 localhost kernel:  [pipe_release+96/160] 
pipe_release+0x60/0xa0
Jan 30 09:08:37 localhost kernel:  [pipe_write_release+26/30] 
pipe_write_release+0x1a/0x1e
Jan 30 09:08:37 localhost kernel:  [__fput+132/290] __fput+0x84/0x122
Jan 30 09:08:37 localhost kernel:  [filp_close+76/85] filp_close+0x4c/0x55
Jan 30 09:08:37 localhost kernel:  [put_files_struct+84/171] 
put_files_struct+0x54/0xab
Jan 30 09:08:37 localhost kernel:  [do_exit+364/721] do_exit+0x16c/0x2d1
Jan 30 09:08:37 localhost kernel:  [do_trap+0/193] do_trap+0x0/0xc1
Jan 30 09:08:37 localhost kernel:  [do_page_fault+855/1281] 
do_page_fault+0x357/0x501
Jan 30 09:08:37 localhost kernel:  [do_page_fault+940/1281] 
do_page_fault+0x3ac/0x501
Jan 30 09:08:37 localhost kernel:  [mempool_free+75/80] 
mempool_free+0x4b/0x50
Jan 30 09:08:37 localhost kernel:  [prep_new_page+67/71] 
prep_new_page+0x43/0x47
Jan 30 09:08:37 localhost kernel:  [prep_new_page+67/71] 
prep_new_page+0x43/0x47
Jan 30 09:08:37 localhost kernel:  [buffered_rmqueue+246/334] 
buffered_rmqueue+0xf6/0x14e
Jan 30 09:08:37 localhost kernel:  [__alloc_pages+216/894] 
__alloc_pages+0xd8/0x37e
Jan 30 09:08:37 localhost kernel:  [__alloc_pages+882/894] 
__alloc_pages+0x372/0x37e
Jan 30 09:08:37 localhost kernel:  [deactivate_task+21/33] 
deactivate_task+0x15/0x21
Jan 30 09:08:37 localhost kernel:  [schedule+1113/1215] schedule+0x459/0x4bf
Jan 30 09:08:37 localhost kernel:  [do_page_fault+0/1281] 
do_page_fault+0x0/0x501
Jan 30 09:08:37 localhost kernel:  [error_code+79/84] error_code+0x4f/0x54
Jan 30 09:08:37 localhost kernel:  [remove_wait_queue+14/38] 
remove_wait_queue+0xe/0x26
Jan 30 09:08:37 localhost kernel:  [poll_freewait+30/62] 
poll_freewait+0x1e/0x3e
Jan 30 09:08:37 localhost kernel:  [do_select+619/640] do_select+0x26b/0x280
Jan 30 09:08:37 localhost kernel:  [__pollwait+0/154] __pollwait+0x0/0x9a
Jan 30 09:08:37 localhost kernel:  [sys_select+648/935] 
sys_select+0x288/0x3a7
Jan 30 09:08:37 localhost kernel:  [sys_time+15/49] sys_time+0xf/0x31
Jan 30 09:08:37 localhost kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jan 30 09:08:37 localhost kernel: Code:  Bad EIP value.
Jan 30 09:08:37 localhost kernel:  <1>Fixing recursive fault but reboot 
is needed!

Soon after others Oops happens with 'imapd':

Jan 30 09:09:55 localhost kernel: Unable to handle kernel paging request 
at virtual address a4000000
Jan 30 09:09:55 localhost kernel:  printing eip:
Jan 30 09:09:55 localhost kernel: a4000000
Jan 30 09:09:55 localhost kernel: *pde = 00000000
Jan 30 09:09:55 localhost kernel: Oops: 0000 [#3]
Jan 30 09:09:55 localhost kernel: Modules linked in: loop af_packet ipv6 
evdev i2c_viapro i2c_core tulip de4x5 crc32 ide_cd cdrom genrtc ext3 jbd 
ide_disk ide_generic via82cxxx trm290 triflex slc90e66 sis5513 siimage 
serverworks sc1200 rz1000 piix pdc202xx_old opt
i621 ns87415 hpt366 hpt34x generic cy82c693 cs5530 cs5520 cmd64x atiixp 
amd74xx alim15x3 aec62xx pdc202xx_new ide_core raid1 md_mod unix
Jan 30 09:09:55 localhost kernel: CPU:    0
Jan 30 09:09:55 localhost kernel: EIP: 
0060:[phys_startup_32+-1544552448/-1073741824]    Not tainted VLI
Jan 30 09:09:55 localhost kernel: EFLAGS: 00010002   (2.6.13.4-3)
Jan 30 09:09:55 localhost kernel: EIP is at 0xa4000000
Jan 30 09:09:55 localhost kernel: eax: defb09f5   ebx: 00000001   ecx: 
00000000   edx: defb0a01
Jan 30 09:09:55 localhost kernel: esi: 00000000   edi: defb0a00   ebp: 
cb4e5edc   esp: cb4e5eb8
Jan 30 09:09:55 localhost kernel: ds: 007b   es: 007b   ss: 0068
Jan 30 09:09:55 localhost kernel: Process imapd (pid: 24236, 
threadinfo=cb4e4000 task=d5e87a80)
Jan 30 09:09:55 localhost kernel: Stack: c011300d defb09f5 00000001 
00000000 00000000 a4c9f450 00000202 defb0a20
Jan 30 09:09:55 localhost kernel:        00000008 cb4e5efc c0113044 
defb0a00 00000001 00000001 00000000 00000000
Jan 30 09:09:55 localhost kernel:        defb0a00 00000000 c014c9c1 
00000000 cb4e5f48 c0136aaa cb4e5f48 b7efd000
Jan 30 09:09:55 localhost kernel: Call Trace:
Jan 30 09:09:55 localhost kernel:  [__wake_up_common+43/78] 
__wake_up_common+0x2b/0x4e
Jan 30 09:09:55 localhost kernel:  [__wake_up+20/30] __wake_up+0x14/0x1e
Jan 30 09:09:55 localhost kernel:  [pipe_writev+1038/1101] 
pipe_writev+0x40e/0x44d
Jan 30 09:09:55 localhost kernel:  [free_pgtables+92/106] 
free_pgtables+0x5c/0x6a
Jan 30 09:09:55 localhost kernel:  [pipe_write+37/41] pipe_write+0x25/0x29
Jan 30 09:09:55 localhost kernel:  [vfs_write+164/315] vfs_write+0xa4/0x13b
Jan 30 09:09:55 localhost kernel:  [sys_write+59/99] sys_write+0x3b/0x63
Jan 30 09:09:55 localhost kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jan 30 09:09:55 localhost kernel: Code:  Bad EIP value.

Jan 30 09:11:21 localhost kernel:  <1>Unable to handle kernel paging 
request at virtual address a4000000
Jan 30 09:11:21 localhost kernel:  printing eip:
Jan 30 09:11:21 localhost kernel: a4000000
Jan 30 09:11:21 localhost kernel: *pde = 00000000
Jan 30 09:11:21 localhost kernel: Oops: 0000 [#4]
Jan 30 09:11:21 localhost kernel: Modules linked in: loop af_packet ipv6 
evdev i2c_viapro i2c_core tulip de4x5 crc32 ide_cd cdrom genrtc ext3 jbd 
ide_disk ide_generic via82cxxx trm290 triflex slc90e66 sis5513 siimage 
serverworks sc1200 rz1000 piix pdc202xx_old opt
i621 ns87415 hpt366 hpt34x generic cy82c693 cs5530 cs5520 cmd64x atiixp 
amd74xx alim15x3 aec62xx pdc202xx_new ide_core raid1 md_mod unix
Jan 30 09:11:21 localhost kernel: CPU:    0
Jan 30 09:11:21 localhost kernel: EIP: 
0060:[phys_startup_32+-1544552448/-1073741824]    Not tainted VLI
Jan 30 09:11:21 localhost kernel: EFLAGS: 00010002   (2.6.13.4-3)
Jan 30 09:11:21 localhost kernel: EIP is at 0xa4000000
Jan 30 09:11:21 localhost kernel: eax: defb09f5   ebx: 00000001   ecx: 
00000000   edx: defb0a01
Jan 30 09:11:21 localhost kernel: esi: 00000000   edi: defb0a00   ebp: 
c5903edc   esp: c5903eb8
Jan 30 09:11:21 localhost kernel: ds: 007b   es: 007b   ss: 0068
Jan 30 09:11:21 localhost kernel: Process imapd (pid: 24598, 
threadinfo=c5902000 task=deeb4530)
Jan 30 09:11:21 localhost kernel: Stack: c011300d defb09f5 00000001 
00000000 00000000 a4c9f450 00000202 defb0a20
Jan 30 09:11:21 localhost kernel:        00000008 c5903efc c0113044 
defb0a00 00000001 00000001 00000000 00000000
Jan 30 09:11:21 localhost kernel:        defb0a00 00000000 c014c9c1 
00000000 ca928480 00000000 dffe04a0 c01447a1
Jan 30 09:11:21 localhost kernel: Call Trace:
Jan 30 09:11:21 localhost kernel:  [__wake_up_common+43/78] 
__wake_up_common+0x2b/0x4e
Jan 30 09:11:21 localhost kernel:  [__wake_up+20/30] __wake_up+0x14/0x1e
Jan 30 09:11:21 localhost kernel:  [pipe_writev+1038/1101] 
pipe_writev+0x40e/0x44d
Jan 30 09:11:21 localhost kernel:  [invalidate_inode_buffers+12/55] 
invalidate_inode_buffers+0xc/0x37
Jan 30 09:11:21 localhost kernel:  [pipe_write+37/41] pipe_write+0x25/0x29
Jan 30 09:11:21 localhost kernel:  [vfs_write+164/315] vfs_write+0xa4/0x13b
Jan 30 09:11:21 localhost kernel:  [sys_write+59/99] sys_write+0x3b/0x63
Jan 30 09:11:21 localhost kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jan 30 09:11:21 localhost kernel: Code:  Bad EIP value.

Then with 'mysqld' 11 minutes after:

Jan 30 09:32:21 localhost kernel:  <1>Unable to handle kernel NULL 
pointer dereference at virtual address 00000000
Jan 30 09:32:21 localhost kernel:  printing eip:
Jan 30 09:32:21 localhost kernel: c0155630
Jan 30 09:32:21 localhost kernel: *pde = 00000000
Jan 30 09:32:21 localhost kernel: Oops: 0000 [#5]
Jan 30 09:32:21 localhost kernel: Modules linked in: loop af_packet ipv6 
evdev i2c_viapro i2c_core tulip de4x5 crc32 ide_cd cdrom genrtc ext3 jbd 
ide_disk ide_generic via82cxxx trm290 triflex slc90e66 sis5513 siimage 
serverworks sc1200 rz1000 piix pdc202xx_old opt
i621 ns87415 hpt366 hpt34x generic cy82c693 cs5530 cs5520 cmd64x atiixp 
amd74xx alim15x3 aec62xx pdc202xx_new ide_core raid1 md_mod unix
Jan 30 09:32:21 localhost kernel: CPU:    0
Jan 30 09:32:21 localhost kernel: EIP:    0060:[__d_find_alias+26/160] 
   Not tainted VLI
Jan 30 09:32:21 localhost kernel: EFLAGS: 00010217   (2.6.13.4-3)
Jan 30 09:32:21 localhost kernel: EIP is at __d_find_alias+0x1a/0xa0
Jan 30 09:32:21 localhost kernel: eax: 00008000   ebx: 00000000   ecx: 
d9f442d4   edx: 00000000
Jan 30 09:32:21 localhost kernel: esi: d9f44239   edi: 00000000   ebp: 
d9f442ec   esp: d671fe24
Jan 30 09:32:21 localhost kernel: ds: 007b   es: 007b   ss: 0068
Jan 30 09:32:21 localhost kernel: Process mysqld (pid: 31400, 
threadinfo=d671e000 task=deeb4a40)
Jan 30 09:32:21 localhost kernel: Stack: d9f442d4 dd5376b4 00000000 
d671fed0 c0155fa1 d9f442d4 00000001 d9f442d4
Jan 30 09:32:21 localhost kernel:        d9f442d4 dd5376b4 e09042cd 
d9f442d4 dd5376b4 c59233c4 fffffff4 dd5376b4
Jan 30 09:32:21 localhost kernel:        caf5e644 c014d54c caf5e644 
dd5376b4 d671ff6c 00000000 d671ff6c d671fec8
Jan 30 09:32:21 localhost kernel: Call Trace:
Jan 30 09:32:21 localhost kernel:  [d_splice_alias+25/160] 
d_splice_alias+0x19/0xa0
Jan 30 09:32:21 localhost kernel:  [pg0+542937805/1070347264] 
ext3_lookup+0x77/0x93 [ext3]
Jan 30 09:32:21 localhost kernel:  [real_lookup+74/169] 
real_lookup+0x4a/0xa9
Jan 30 09:32:21 localhost kernel:  [do_lookup+74/123] do_lookup+0x4a/0x7b
Jan 30 09:32:21 localhost kernel:  [__link_path_walk+1755/2718] 
__link_path_walk+0x6db/0xa9e
Jan 30 09:32:21 localhost kernel:  [link_path_walk+60/171] 
link_path_walk+0x3c/0xab
Jan 30 09:32:21 localhost kernel:  [sys_read+59/99] sys_read+0x3b/0x63
Jan 30 09:32:21 localhost kernel:  [sys_read+91/99] sys_read+0x5b/0x63
Jan 30 09:32:21 localhost kernel:  [path_lookup+234/242] 
path_lookup+0xea/0xf2
Jan 30 09:32:21 localhost kernel:  [__user_walk+35/58] __user_walk+0x23/0x3a
Jan 30 09:32:21 localhost kernel:  [sys_readlink+32/151] 
sys_readlink+0x20/0x97
Jan 30 09:32:21 localhost kernel:  [sys_read+59/99] sys_read+0x3b/0x63
Jan 30 09:32:21 localhost kernel:  [sys_read+91/99] sys_read+0x5b/0x63
Jan 30 09:32:21 localhost kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jan 30 09:32:21 localhost kernel: Code: 41 1c 89 50 04 89 02 89 5b 04 89 
59 1c 5b 89 c8 c3 55 57 31 ff 56 53 8b 4c 24 14 8b 51 18 8d 69 18 39 ea 
0f 84 81 00 00 00 89 d3 <8b> 12 8d 44 20 00 0f b7 41 28 8d 73 cc 25 00 
f0 00 00 3d 00 40
Jan 30 09:32:28 localhost kernel:  <0>Bad page state at prep_new_page 
(in process 'apache', page c108a4a0)
Jan 30 09:32:28 localhost kernel: flags:0x40000004 mapping:00000000 
mapcount:-1 count:0
Jan 30 09:32:28 localhost kernel: Backtrace:
Jan 30 09:32:28 localhost kernel:  [bad_page+80/129] bad_page+0x50/0x81
Jan 30 09:32:28 localhost kernel:  [prep_new_page+42/71] 
prep_new_page+0x2a/0x47
Jan 30 09:32:28 localhost kernel:  [buffered_rmqueue+246/334] 
buffered_rmqueue+0xf6/0x14e
Jan 30 09:32:28 localhost kernel:  [__alloc_pages+216/894] 
__alloc_pages+0xd8/0x37e
Jan 30 09:32:28 localhost kernel:  [do_anonymous_page+72/239] 
do_anonymous_page+0x48/0xef
Jan 30 09:32:28 localhost kernel:  [do_no_page+69/586] do_no_page+0x45/0x24a
Jan 30 09:32:28 localhost kernel:  [__handle_mm_fault+105/225] 
__handle_mm_fault+0x69/0xe1
Jan 30 09:32:28 localhost kernel:  [do_page_fault+390/1281] 
do_page_fault+0x186/0x501
Jan 30 09:32:28 localhost kernel:  [vma_link+52/148] vma_link+0x34/0x94
Jan 30 09:32:28 localhost kernel:  [autoremove_wake_function+0/58] 
autoremove_wake_function+0x0/0x3a
Jan 30 09:32:28 localhost kernel:  [do_mmap_pgoff+1319/1560] 
do_mmap_pgoff+0x527/0x618
Jan 30 09:32:28 localhost kernel:  [vfs_read+256/315] vfs_read+0x100/0x13b
Jan 30 09:32:28 localhost kernel:  [sys_read+59/99] sys_read+0x3b/0x63
Jan 30 09:32:28 localhost kernel:  [do_page_fault+0/1281] 
do_page_fault+0x0/0x501
Jan 30 09:32:28 localhost kernel:  [error_code+79/84] error_code+0x4f/0x54
Jan 30 09:32:28 localhost kernel: Trying to fix it up, but a reboot is 
needed

9 minutes after this happens with 'kswapd0':

Jan 30 09:41:42 localhost kernel: Unable to handle kernel paging request 
at virtual address ffffff7e
Jan 30 09:41:42 localhost kernel:  printing eip:
Jan 30 09:41:42 localhost kernel: e0906edd
Jan 30 09:41:42 localhost kernel: *pde = 00002067
Jan 30 09:41:42 localhost kernel: *pte = 00000000
Jan 30 09:41:42 localhost kernel: Oops: 0002 [#6]
Jan 30 09:41:42 localhost kernel: Modules linked in: loop af_packet ipv6 
evdev i2c_viapro i2c_core tulip de4x5 crc32 ide_cd cdrom genrtc ext3 jbd 
ide_disk ide_generic via82cxxx trm290 triflex slc90e66 sis5513 siimage 
serverworks sc1200 rz1000 piix pdc202xx_old opt
i621 ns87415 hpt366 hpt34x generic cy82c693 cs5530 cs5520 cmd64x atiixp 
amd74xx alim15x3 aec62xx pdc202xx_new ide_core raid1 md_mod unix
Jan 30 09:41:42 localhost kernel: CPU:    0
Jan 30 09:41:42 localhost kernel: EIP: 
0060:[pg0+542949085/1070347264]    Tainted: G    B VLI
Jan 30 09:41:42 localhost kernel: EFLAGS: 00010286   (2.6.13.4-3)
Jan 30 09:41:42 localhost kernel: EIP is at ext3_clear_inode+0x46/0x76 
[ext3]
Jan 30 09:41:42 localhost kernel: eax: d9f64d70   ebx: d9f64e04   ecx: 
dfc18c60   edx: ffffff7e
Jan 30 09:41:42 localhost kernel: esi: 00000000   edi: dfd01ec0   ebp: 
00000011   esp: dfd01e84
Jan 30 09:41:42 localhost kernel: ds: 007b   es: 007b   ss: 0068
Jan 30 09:41:42 localhost kernel: Process kswapd0 (pid: 78, 
threadinfo=dfd00000 task=dff53aa0)
Jan 30 09:41:42 localhost kernel: Stack: d9f64e04 d9f64f30 c0156c93 
d9f64e04 d9f64e0c d9f64e04 c0156d11 d9f64e04
Jan 30 09:41:42 localhost kernel:        d972646c d9726474 0000003f 
0000007f c0156fd5 dfd01ec0 00000080 c7b0f184
Jan 30 09:41:42 localhost kernel:        c54e035c 0000076c 00000000 
00000080 dffea9e0 c0157021 00000080 c01346a7
Jan 30 09:41:42 localhost kernel: Call Trace:
Jan 30 09:41:42 localhost kernel:  [clear_inode+164/210] 
clear_inode+0xa4/0xd2
Jan 30 09:41:42 localhost kernel:  [dispose_list+80/170] 
dispose_list+0x50/0xaa
Jan 30 09:41:42 localhost kernel:  [prune_icache+287/339] 
prune_icache+0x11f/0x153
Jan 30 09:41:42 localhost kernel:  [shrink_icache_memory+24/48] 
shrink_icache_memory+0x18/0x30
Jan 30 09:41:42 localhost kernel:  [shrink_slab+277/385] 
shrink_slab+0x115/0x181
Jan 30 09:41:42 localhost kernel:  [balance_pgdat+508/786] 
balance_pgdat+0x1fc/0x312
Jan 30 09:41:42 localhost kernel:  [kswapd+226/231] kswapd+0xe2/0xe7
Jan 30 09:41:42 localhost kernel:  [autoremove_wake_function+0/58] 
autoremove_wake_function+0x0/0x3a
Jan 30 09:41:42 localhost kernel:  [autoremove_wake_function+0/58] 
autoremove_wake_function+0x0/0x3a
Jan 30 09:41:42 localhost kernel:  [kswapd+0/231] kswapd+0x0/0xe7
Jan 30 09:41:42 localhost kernel:  [kernel_thread_helper+5/11] 
kernel_thread_helper+0x5/0xb
Jan 30 09:41:42 localhost kernel: Code: 85 d2 74 10 ff 0a 0f 94 c0 84 c0 
74 07 52 e8 f4 c2 82 df 58 c7 43 d4 ff ff ff ff 8b 53 d8 85 d2 74 20 83 
fa ff 74 1b 85 d2 74 10 <ff> 0a 0f 94 c0 84 c0 74 07 52 e8 cd c2 82 df 
58 c7 43 d8 ff ff

And finaly with 'apache' a few minutes after:

Jan 30 09:45:11 localhost kernel:  <1>Unable to handle kernel NULL 
pointer dereference at virtual address 00000000
Jan 30 09:45:11 localhost kernel:  printing eip:
Jan 30 09:45:11 localhost kernel: c0146710
Jan 30 09:45:11 localhost kernel: *pde = 00000000
Jan 30 09:45:11 localhost kernel: Oops: 0000 [#7]
Jan 30 09:45:11 localhost kernel: Modules linked in: loop af_packet ipv6 
evdev i2c_viapro i2c_core tulip de4x5 crc32 ide_cd cdrom genrtc ext3 jbd 
ide_disk ide_generic via82cxxx trm290 triflex slc90e66 sis5513 siimage 
serverworks sc1200 rz1000 piix pdc202xx_old opt
i621 ns87415 hpt366 hpt34x generic cy82c693 cs5530 cs5520 cmd64x atiixp 
amd74xx alim15x3 aec62xx pdc202xx_new ide_core raid1 md_mod unix
Jan 30 09:45:11 localhost kernel: CPU:    0
Jan 30 09:45:11 localhost kernel: EIP:    0060:[drop_buffers+23/121] 
Tainted: G    B VLI
Jan 30 09:45:11 localhost kernel: EFLAGS: 00010213   (2.6.13.4-3)
Jan 30 09:45:11 localhost kernel: EIP is at drop_buffers+0x17/0x79
Jan 30 09:45:11 localhost kernel: eax: 00000000   ebx: 00000000   ecx: 
00000000   edx: 00000000
Jan 30 09:45:11 localhost kernel: esi: c19f3687   edi: dffdcbc4   ebp: 
c1315860   esp: dd219c8c
Jan 30 09:45:11 localhost kernel: ds: 007b   es: 007b   ss: 0068
Jan 30 09:45:11 localhost kernel: Process apache (pid: 32717, 
threadinfo=dd218000 task=d839c020)
Jan 30 09:45:11 localhost kernel: Stack: c1315860 c1315860 dffdcbc4 
dd219df0 c01467ae c1315860 dd219ca8 00000000
Jan 30 09:45:11 localhost kernel:        dffdcbc4 c1315860 c0134b10 
c1315860 000000d2 00000001 00000001 0000001b
Jan 30 09:45:11 localhost kernel:        00000000 dd219cd0 dd219cd0 
0000000d 00000001 c1330ac0 c1335b40 c11e2200
Jan 30 09:45:11 localhost kernel: Call Trace:
Jan 30 09:45:11 localhost kernel:  [try_to_free_buffers+60/107] 
try_to_free_buffers+0x3c/0x6b
Jan 30 09:45:11 localhost kernel:  [shrink_list+603/860] 
shrink_list+0x25b/0x35c
Jan 30 09:45:11 localhost kernel:  [shrink_cache+231/522] 
shrink_cache+0xe7/0x20a
Jan 30 09:45:11 localhost kernel:  [shrink_zone+164/181] 
shrink_zone+0xa4/0xb5
Jan 30 09:45:11 localhost kernel:  [shrink_caches+87/108] 
shrink_caches+0x57/0x6c
Jan 30 09:45:11 localhost kernel:  [try_to_free_pages+191/383] 
try_to_free_pages+0xbf/0x17f
Jan 30 09:45:11 localhost kernel:  [__alloc_pages+522/894] 
__alloc_pages+0x20a/0x37e
Jan 30 09:45:11 localhost kernel:  [do_wp_page+243/594] 
do_wp_page+0xf3/0x252
Jan 30 09:45:11 localhost kernel:  [do_swap_page+399/465] 
do_swap_page+0x18f/0x1d1
Jan 30 09:45:11 localhost kernel:  [__handle_mm_fault+143/225] 
__handle_mm_fault+0x8f/0xe1
Jan 30 09:45:11 localhost kernel:  [do_page_fault+390/1281] 
do_page_fault+0x186/0x501
Jan 30 09:45:11 localhost kernel:  [prep_new_page+67/71] 
prep_new_page+0x43/0x47
Jan 30 09:45:11 localhost kernel:  [buffered_rmqueue+246/334] 
buffered_rmqueue+0xf6/0x14e
Jan 30 09:45:11 localhost kernel:  [__alloc_pages+326/894] 
__alloc_pages+0x146/0x37e
Jan 30 09:45:11 localhost kernel:  [__alloc_pages+882/894] 
__alloc_pages+0x372/0x37e
Jan 30 09:45:11 localhost kernel:  [free_hot_cold_page+33/173] 
free_hot_cold_page+0x21/0xad
Jan 30 09:45:11 localhost kernel:  [sys_getcwd+329/340] 
sys_getcwd+0x149/0x154
Jan 30 09:45:11 localhost kernel:  [do_page_fault+0/1281] 
do_page_fault+0x0/0x501
Jan 30 09:45:11 localhost kernel:  [error_code+79/84] error_code+0x4f/0x54
Jan 30 09:45:11 localhost kernel: Code: 0e be fb ff ff ff eb 07 89 d8 e8 
1c d6 ff ff 5b 89 f0 5e c3 55 57 56 53 8b 6c 24 14 8b 45 00 f6 c4 08 75 
02 0f 0b 8b 75 0c 89 f1 <8b> 01 f6 c4 08 74 0c 8b 45 10 85 c0 74 05 0f 
ba 68 34 14 8b 11

The same minute the machine hanged with the following backtrace on the 
console from the process 'bounce' (transcripted from mobile phone photo):

__find_get_block+0x86/0xa5
__getblk+0x1d/0x35
ext3_getblk+0xa8/0x1d2 [ext3]
ext3_do_update_inode+0x310/0x33b [ext3]
ext3_bread+0x1c/0x74 [ext3]
ext3_add_entry+0xc5/0x10f [ext3]
ext3_add_mondir+0x18/0x47 [ext3]
ext3_create+0xab/0xe2 [ext3]
vfs_create+0xca/0x124
open_namel+0x2c/0x49
sys_open+0x3c/0xb2
syscall_call+0x7/0xb

-- 
Jean-Christian de Rivaz

--------------090208070100020208080809
Content-Type: text/plain;
 name="config-2.6.13.4-3"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="config-2.6.13.4-3"

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.13.4-3
# Sun Oct 16 21:35:25 2005
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
CONFIG_INIT_ENV_ARG_LIMIT=32

#
# General setup
#
CONFIG_LOCALVERSION=""
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
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
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
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
# CONFIG_MODULE_SRCVERSION_ALL is not set
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
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
CONFIG_X86_GENERIC=y
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
CONFIG_X86_USE_3DNOW=y
CONFIG_HPET_TIMER=y
# CONFIG_SMP is not set
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
# CONFIG_X86_MCE is not set
CONFIG_TOSHIBA=y
CONFIG_I8K=y
CONFIG_X86_REBOOTFIXUPS=y
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m

#
# Firmware Drivers
#
CONFIG_EDD=m
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
# CONFIG_REGPARM is not set
CONFIG_SECCOMP=y
CONFIG_HZ_100=y
# CONFIG_HZ_250 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=100
CONFIG_PHYSICAL_START=0x100000
# CONFIG_KEXEC is not set

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
# CONFIG_SOFTWARE_SUSPEND is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
# CONFIG_ACPI_SLEEP_PROC_SLEEP is not set
CONFIG_ACPI_AC=m
# CONFIG_ACPI_BATTERY is not set
# CONFIG_ACPI_BUTTON is not set
CONFIG_ACPI_VIDEO=m
# CONFIG_ACPI_HOTKEY is not set
CONFIG_ACPI_FAN=m
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_THERMAL=m
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
CONFIG_X86_PM_TIMER=y
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
CONFIG_PCI_MSI=y
# CONFIG_PCI_LEGACY_PROC is not set
CONFIG_PCI_NAMES=y
# CONFIG_PCI_DEBUG is not set
CONFIG_ISA_DMA_API=y
# CONFIG_ISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set

#
# PCCARD (PCMCIA/CardBus) support
#
# CONFIG_PCCARD is not set

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
CONFIG_PACKET=m
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=m
CONFIG_XFRM=y
CONFIG_XFRM_USER=m
CONFIG_NET_KEY=m
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_ASK_IP_FIB_HASH=y
# CONFIG_IP_FIB_TRIE is not set
CONFIG_IP_FIB_HASH=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_FWMARK=y
CONFIG_IP_ROUTE_MULTIPATH=y
# CONFIG_IP_ROUTE_MULTIPATH_CACHED is not set
CONFIG_IP_ROUTE_VERBOSE=y
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
# CONFIG_ARPD is not set
CONFIG_SYN_COOKIES=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_IPCOMP=m
CONFIG_INET_TUNNEL=m
CONFIG_IP_TCPDIAG=y
# CONFIG_IP_TCPDIAG_IPV6 is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_BIC=y

#
# IP: Virtual Server Configuration
#
CONFIG_IP_VS=m
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IPV6=m
CONFIG_IPV6_PRIVACY=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_IPCOMP=m
CONFIG_INET6_TUNNEL=m
CONFIG_IPV6_TUNNEL=m
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_BRIDGE_NETFILTER=y

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
# CONFIG_IP_NF_CT_ACCT is not set
# CONFIG_IP_NF_CONNTRACK_MARK is not set
# CONFIG_IP_NF_CT_PROTO_SCTP is not set
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_TFTP=m
CONFIG_IP_NF_AMANDA=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_IPRANGE=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_RECENT=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_MATCH_PHYSDEV=m
CONFIG_IP_NF_MATCH_ADDRTYPE=m
CONFIG_IP_NF_MATCH_REALM=m
# CONFIG_IP_NF_MATCH_SCTP is not set
# CONFIG_IP_NF_MATCH_COMMENT is not set
# CONFIG_IP_NF_MATCH_HASHLIMIT is not set
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_SAME=m
CONFIG_IP_NF_NAT_SNMP_BASIC=m
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_NAT_TFTP=m
CONFIG_IP_NF_NAT_AMANDA=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_CLASSIFY=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_TARGET_NOTRACK=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m

#
# IPv6: Netfilter Configuration (EXPERIMENTAL)
#
CONFIG_IP6_NF_QUEUE=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_LIMIT=m
CONFIG_IP6_NF_MATCH_MAC=m
CONFIG_IP6_NF_MATCH_RT=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_MULTIPORT=m
CONFIG_IP6_NF_MATCH_OWNER=m
CONFIG_IP6_NF_MATCH_MARK=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_AHESP=m
CONFIG_IP6_NF_MATCH_LENGTH=m
CONFIG_IP6_NF_MATCH_EUI64=m
# CONFIG_IP6_NF_MATCH_PHYSDEV is not set
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_LOG=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_TARGET_MARK=m
CONFIG_IP6_NF_RAW=m

#
# Bridge: Netfilter Configuration
#
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
# CONFIG_BRIDGE_EBT_ULOG is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_MSG is not set
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_HMAC_NONE is not set
# CONFIG_SCTP_HMAC_SHA1 is not set
CONFIG_SCTP_HMAC_MD5=y
CONFIG_ATM=y
# CONFIG_ATM_CLIP is not set
# CONFIG_ATM_LANE is not set
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_BRIDGE=m
CONFIG_VLAN_8021Q=m
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
CONFIG_NET_SCHED=y
CONFIG_NET_SCH_CLK_JIFFIES=y
# CONFIG_NET_SCH_CLK_GETTIMEOFDAY is not set
# CONFIG_NET_SCH_CLK_CPU is not set
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_QOS=y
CONFIG_NET_ESTIMATOR=y
CONFIG_NET_CLS=y
# CONFIG_NET_CLS_BASIC is not set
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_ROUTE=y
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
# CONFIG_CLS_U32_PERF is not set
# CONFIG_NET_CLS_IND is not set
# CONFIG_CLS_U32_MARK is not set
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
# CONFIG_NET_EMATCH is not set
# CONFIG_NET_CLS_ACT is not set
CONFIG_NET_CLS_POLICE=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
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
CONFIG_FW_LOADER=m
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
# CONFIG_PNP is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_CRYPTOLOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_SX8=m
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=8192
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_LBD=y
# CONFIG_CDROM_PKTCDVD is not set

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
CONFIG_IDE=m
CONFIG_BLK_DEV_IDE=m

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=m
# CONFIG_IDEDISK_MULTI_MODE is not set
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDETAPE=m
CONFIG_BLK_DEV_IDEFLOPPY=m
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=m
CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=m
CONFIG_BLK_DEV_OPTI621=m
CONFIG_BLK_DEV_RZ1000=m
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_AEC62XX=m
CONFIG_BLK_DEV_ALI15X3=m
# CONFIG_WDC_ALI15X3 is not set
CONFIG_BLK_DEV_AMD74XX=m
CONFIG_BLK_DEV_ATIIXP=m
CONFIG_BLK_DEV_CMD64X=m
CONFIG_BLK_DEV_TRIFLEX=m
CONFIG_BLK_DEV_CY82C693=m
CONFIG_BLK_DEV_CS5520=m
CONFIG_BLK_DEV_CS5530=m
CONFIG_BLK_DEV_HPT34X=m
# CONFIG_HPT34X_AUTODMA is not set
CONFIG_BLK_DEV_HPT366=m
CONFIG_BLK_DEV_SC1200=m
CONFIG_BLK_DEV_PIIX=m
# CONFIG_BLK_DEV_IT821X is not set
CONFIG_BLK_DEV_NS87415=m
CONFIG_BLK_DEV_PDC202XX_OLD=m
CONFIG_PDC202XX_BURST=y
CONFIG_BLK_DEV_PDC202XX_NEW=m
CONFIG_PDC202XX_FORCE=y
CONFIG_BLK_DEV_SVWKS=m
CONFIG_BLK_DEV_SIIMAGE=m
CONFIG_BLK_DEV_SIS5513=m
CONFIG_BLK_DEV_SLC90E66=m
CONFIG_BLK_DEV_TRM290=m
CONFIG_BLK_DEV_VIA82CXXX=m
# CONFIG_IDE_ARM is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
# CONFIG_SCSI is not set

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID5=m
CONFIG_MD_RAID6=m
CONFIG_MD_MULTIPATH=m
# CONFIG_MD_FAULTY is not set
CONFIG_BLK_DEV_DM=m
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_MIRROR=m
CONFIG_DM_ZERO=m
# CONFIG_DM_MULTIPATH is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

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
CONFIG_DUMMY=m
CONFIG_BONDING=m
CONFIG_EQUALIZER=m
CONFIG_TUN=m

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=m
CONFIG_HAPPYMEAL=m
CONFIG_SUNGEM=m
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=m
CONFIG_TYPHOON=m

#
# Tulip family network device support
#
CONFIG_NET_TULIP=y
CONFIG_DE2104X=m
CONFIG_TULIP=m
# CONFIG_TULIP_MWI is not set
# CONFIG_TULIP_MMIO is not set
# CONFIG_TULIP_NAPI is not set
CONFIG_DE4X5=m
CONFIG_WINBOND_840=m
CONFIG_DM9102=m
CONFIG_HP100=m
CONFIG_NET_PCI=y
CONFIG_PCNET32=m
CONFIG_AMD8111_ETH=m
# CONFIG_AMD8111E_NAPI is not set
CONFIG_ADAPTEC_STARFIRE=m
# CONFIG_ADAPTEC_STARFIRE_NAPI is not set
CONFIG_B44=m
CONFIG_FORCEDETH=m
# CONFIG_DGRS is not set
CONFIG_EEPRO100=m
CONFIG_E100=m
CONFIG_FEALNX=m
CONFIG_NATSEMI=m
CONFIG_NE2K_PCI=m
CONFIG_8139CP=m
CONFIG_8139TOO=m
CONFIG_8139TOO_PIO=y
CONFIG_8139TOO_TUNE_TWISTER=y
CONFIG_8139TOO_8129=y
# CONFIG_8139_OLD_RX_RESET is not set
CONFIG_SIS900=m
CONFIG_EPIC100=m
CONFIG_SUNDANCE=m
# CONFIG_SUNDANCE_MMIO is not set
CONFIG_TLAN=m
CONFIG_VIA_RHINE=m
# CONFIG_VIA_RHINE_MMIO is not set

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
# CONFIG_NET_RADIO is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# ATM drivers
#
# CONFIG_ATM_TCP is not set
# CONFIG_ATM_LANAI is not set
# CONFIG_ATM_ENI is not set
# CONFIG_ATM_FIRESTREAM is not set
# CONFIG_ATM_ZATM is not set
# CONFIG_ATM_NICSTAR is not set
# CONFIG_ATM_IDT77252 is not set
# CONFIG_ATM_AMBASSADOR is not set
# CONFIG_ATM_HORIZON is not set
# CONFIG_ATM_IA is not set
# CONFIG_ATM_FORE200E_MAYBE is not set
# CONFIG_ATM_HE is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_SHAPER=m
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
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_TSDEV=m
CONFIG_INPUT_TSDEV_SCREEN_X=240
CONFIG_INPUT_TSDEV_SCREEN_Y=320
CONFIG_INPUT_EVDEV=m
CONFIG_INPUT_EVBUG=m

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_KEYBOARD_SUNKBD=m
CONFIG_KEYBOARD_LKKBD=m
CONFIG_KEYBOARD_XTKBD=m
CONFIG_KEYBOARD_NEWTON=m
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=m
CONFIG_SERIO_CT82C710=m
CONFIG_SERIO_PCIPS2=m
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
CONFIG_GAMEPORT=m
CONFIG_GAMEPORT_NS558=m
CONFIG_GAMEPORT_L4=m
CONFIG_GAMEPORT_EMU10K1=m
CONFIG_GAMEPORT_FM801=m

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_COMPUTONE is not set
# CONFIG_ROCKETPORT is not set
# CONFIG_CYCLADES is not set
# CONFIG_DIGIEPCA is not set
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
# CONFIG_ISI is not set
# CONFIG_SYNCLINK is not set
# CONFIG_SYNCLINKMP is not set
# CONFIG_N_HDLC is not set
# CONFIG_RISCOM8 is not set
# CONFIG_SPECIALIX is not set
# CONFIG_SX is not set
# CONFIG_RIO is not set
# CONFIG_STALDRV is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
# CONFIG_SERIAL_8250_ACPI is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256

#
# IPMI
#
CONFIG_IPMI_HANDLER=m
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_WATCHDOG=m
# CONFIG_IPMI_POWEROFF is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
CONFIG_HW_RANDOM=m
CONFIG_NVRAM=m
CONFIG_RTC=m
CONFIG_GEN_RTC=m
CONFIG_GEN_RTC_X=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
CONFIG_FTAPE=m
CONFIG_ZFTAPE=m
CONFIG_ZFT_DFLT_BLK_SZ=10240

#
# The compressor will be built as a module only!
#
CONFIG_ZFT_COMPRESSOR=m
CONFIG_FT_NR_BUFFERS=3
CONFIG_FT_PROC_FS=y
CONFIG_FT_NORMAL_DEBUG=y
# CONFIG_FT_FULL_DEBUG is not set
# CONFIG_FT_NO_TRACE is not set
# CONFIG_FT_NO_TRACE_AT_ALL is not set

#
# Hardware configuration
#
CONFIG_FT_STD_FDC=y
# CONFIG_FT_MACH2 is not set
# CONFIG_FT_PROBE_FC10 is not set
# CONFIG_FT_ALT_FDC is not set
CONFIG_FT_FDC_THR=8
CONFIG_FT_FDC_MAX_RATE=2000
CONFIG_FT_ALPHA_CLOCK=0
# CONFIG_AGP is not set
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
CONFIG_HPET=y
# CONFIG_HPET_RTC_IRQ is not set
CONFIG_HPET_MMAP=y
CONFIG_HANGCHECK_TIMER=m

#
# TPM devices
#
# CONFIG_TCG_TPM is not set

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
# CONFIG_I2C_ALGOPCA is not set

#
# I2C Hardware Bus support
#
CONFIG_I2C_ALI1535=m
CONFIG_I2C_ALI1563=m
CONFIG_I2C_ALI15X3=m
CONFIG_I2C_AMD756=m
# CONFIG_I2C_AMD756_S4882 is not set
CONFIG_I2C_AMD8111=m
CONFIG_I2C_I801=m
CONFIG_I2C_I810=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_ISA=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_PARPORT_LIGHT=m
CONFIG_I2C_PROSAVAGE=m
CONFIG_I2C_SAVAGE4=m
CONFIG_SCx200_ACB=m
CONFIG_I2C_SIS5595=m
CONFIG_I2C_SIS630=m
CONFIG_I2C_SIS96X=m
# CONFIG_I2C_STUB is not set
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m
CONFIG_I2C_VOODOO3=m
# CONFIG_I2C_PCA_ISA is not set
CONFIG_I2C_SENSOR=m

#
# Miscellaneous I2C Chip support
#
# CONFIG_SENSORS_DS1337 is not set
# CONFIG_SENSORS_DS1374 is not set
CONFIG_SENSORS_EEPROM=m
CONFIG_SENSORS_PCF8574=m
# CONFIG_SENSORS_PCA9539 is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_SENSORS_RTC8564=m
# CONFIG_SENSORS_MAX6875 is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Hardware Monitoring support
#
CONFIG_HWMON=y
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
# CONFIG_SENSORS_ADM1026 is not set
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM9240 is not set
CONFIG_SENSORS_ASB100=m
# CONFIG_SENSORS_ATXP1 is not set
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_FSCHER=m
# CONFIG_SENSORS_FSCPOS is not set
CONFIG_SENSORS_GL518SM=m
# CONFIG_SENSORS_GL520SM is not set
CONFIG_SENSORS_IT87=m
# CONFIG_SENSORS_LM63 is not set
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
# CONFIG_SENSORS_LM87 is not set
CONFIG_SENSORS_LM90=m
# CONFIG_SENSORS_LM92 is not set
CONFIG_SENSORS_MAX1619=m
# CONFIG_SENSORS_PC87360 is not set
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_SMSC47B397 is not set
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83627HF=m
# CONFIG_SENSORS_W83627EHF is not set
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
# CONFIG_FB is not set
CONFIG_VIDEO_SELECT=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
# CONFIG_USB is not set

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
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
# CONFIG_EXT2_FS_XIP is not set
CONFIG_EXT3_FS=m
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
CONFIG_JBD=m
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=y

#
# XFS support
#
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
CONFIG_ROMFS_FS=m
CONFIG_INOTIFY=y
CONFIG_QUOTA=y
CONFIG_QFMT_V1=m
CONFIG_QFMT_V2=m
CONFIG_QUOTACTL=y
CONFIG_DNOTIFY=y
CONFIG_AUTOFS_FS=m
CONFIG_AUTOFS4_FS=m

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
# CONFIG_VFAT_FS is not set
CONFIG_FAT_DEFAULT_CODEPAGE=437
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
CONFIG_DEVPTS_FS_XATTR=y
CONFIG_DEVPTS_FS_SECURITY=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_XATTR is not set
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
CONFIG_CRAMFS=y
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
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
CONFIG_ACORN_PARTITION=y
CONFIG_ACORN_PARTITION_CUMANA=y
# CONFIG_ACORN_PARTITION_EESOX is not set
CONFIG_ACORN_PARTITION_ICS=y
# CONFIG_ACORN_PARTITION_ADFS is not set
# CONFIG_ACORN_PARTITION_POWERTEC is not set
CONFIG_ACORN_PARTITION_RISCIX=y
CONFIG_OSF_PARTITION=y
CONFIG_AMIGA_PARTITION=y
CONFIG_ATARI_PARTITION=y
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
CONFIG_LDM_PARTITION=y
# CONFIG_LDM_DEBUG is not set
CONFIG_SGI_PARTITION=y
CONFIG_ULTRIX_PARTITION=y
CONFIG_SUN_PARTITION=y
# CONFIG_EFI_PARTITION is not set

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="cp437"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_UTF8=m

#
# Profiling support
#
CONFIG_PROFILING=y
CONFIG_OPROFILE=m

#
# Kernel hacking
#
# CONFIG_PRINTK_TIME is not set
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_LOG_BUF_SHIFT=14
# CONFIG_SCHEDSTATS is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_BUGVERBOSE is not set
# CONFIG_DEBUG_INFO is not set
# CONFIG_DEBUG_FS is not set
# CONFIG_FRAME_POINTER is not set
# CONFIG_EARLY_PRINTK is not set
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_KPROBES is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_4KSTACKS is not set
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

#
# Security options
#
# CONFIG_KEYS is not set
CONFIG_SECURITY=y
# CONFIG_SECURITY_NETWORK is not set
CONFIG_SECURITY_CAPABILITIES=m
# CONFIG_SECURITY_SECLVL is not set
# CONFIG_SECURITY_SELINUX is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
# CONFIG_CRYPTO_WP512 is not set
# CONFIG_CRYPTO_TGR192 is not set
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_AES_586=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_KHAZAD=m
# CONFIG_CRYPTO_ANUBIS is not set
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_CRC32C=m
CONFIG_CRYPTO_TEST=m

#
# Hardware crypto devices
#
# CONFIG_CRYPTO_DEV_PADLOCK is not set

#
# Library routines
#
CONFIG_CRC_CCITT=m
CONFIG_CRC32=m
CONFIG_LIBCRC32C=m
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=m
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_X86_BIOS_REBOOT=y

--------------090208070100020208080809--
