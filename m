Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262635AbTCIVmE>; Sun, 9 Mar 2003 16:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262637AbTCIVmE>; Sun, 9 Mar 2003 16:42:04 -0500
Received: from bgp994252bgs.nanarb01.mi.comcast.net ([68.40.41.41]:58037 "EHLO
	kaeding.homelinux.net") by vger.kernel.org with ESMTP
	id <S262635AbTCIVlm>; Sun, 9 Mar 2003 16:41:42 -0500
Date: Sun, 9 Mar 2003 16:52:17 -0500 (EST)
From: Thomas Kaeding <kaeding@kaeding.homelinux.org>
X-X-Sender: kaeding@kaeding.localdomain
To: linux-kernel@vger.kernel.org
Subject: oops
Message-ID: <Pine.LNX.4.44.0303091642330.6010-100000@kaeding.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I don't know if you are the right person for this.  If not, would you
please forward it to the right one?  Thank you.

Recently my Linux box crashed in a bad way.
KDE/X stopped, and all consoles were receiving messages that processes
could not allocate memory (?).  There were also CPU register dumps.  I was
unable to capture the information, since no console would give me a
prompt.  Every second, another process would report the error and give
CPU register dumps.  Some that I remember were DCOP (for KDE), CUPS,
ices (streaming audio).  I don't remember is there was an OOPS message
(I didn't know that I should look for one).

Below is some info that may or may not help.  First are some messages
from /var/log/sys.log and second are some info from /proc/...
At the end are the results of ksymoops.

Thank you.

Thomas

start ------------------------------------------------------------------

Mar  7 18:06:41 kaeding kernel: VFS: Busy inodes after unmount.
Self-destruct in 5 seconds.  Have a nice day...
Mar  7 18:06:42 kaeding modprobe: modprobe: Can't locate module
nls_iso8859-1
Mar  7 18:06:42 kaeding modprobe: modprobe: Can't locate module
nls_iso8859-1
Mar  7 18:06:54 kaeding sudo:  kaeding : TTY=ttyp3 ; PWD=/home/kaeding ;
USER=root ; COMMAND=/bin/umount /floppy
Mar  7 18:06:54 kaeding sudo:  kaeding : TTY=ttyp3 ; PWD=/home/kaeding ;
USER=root ; COMMAND=/bin/umount /floppy
Mar  7 18:06:54 kaeding kernel: VFS: Busy inodes after unmount.
Self-destruct in 5 seconds.  Have a nice day...
Mar  7 18:06:54 kaeding kernel: VFS: Busy inodes after unmount.
Self-destruct in 5 seconds.  Have a nice day...
Mar  7 18:06:56 kaeding sudo:  kaeding : TTY=ttyp3 ; PWD=/home/kaeding ;
USER=root ; COMMAND=/bin/mount /floppy
Mar  7 18:07:02 kaeding modprobe: modprobe: Can't locate module
nls_iso8859-1
Mar  7 18:07:19 kaeding last message repeated 3 times
Mar  7 18:16:27 kaeding kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000000
Mar  7 18:16:27 kaeding kernel:  printing eip:
Mar  7 18:16:27 kaeding kernel: c0112010
Mar  7 18:16:27 kaeding kernel: *pde = 00000000
Mar  7 18:16:27 kaeding kernel: Oops: 0000
Mar  7 18:16:27 kaeding kernel: CPU:    0
Mar  7 18:16:27 kaeding kernel: Oops: 0000
Mar  7 18:16:27 kaeding kernel: CPU:    0
Mar  7 18:16:27 kaeding kernel: EIP:    0010:[__wake_up+32/160]
Tainted: P
Mar  7 18:16:27 kaeding kernel: EFLAGS: 00010086
Mar  7 18:16:27 kaeding kernel: eax: c2bc5f3c   ebx: 00000000   ecx:
00000001   edx: 00000003
Mar  7 18:16:27 kaeding kernel: esi: c2bc5f3c   edi: 00000001   ebp:
cc98fe7c   esp: cc98fe64
Mar  7 18:16:27 kaeding kernel: ds: 0018   es: 0018   ss: 0018
Mar  7 18:16:27 kaeding kernel: Process request.cgi (pid: 22028,
stackpage=cc98f000)
Mar  7 18:16:27 kaeding kernel: Stack: 00000000 c2bc5ea0 cffd8128 c30bb5c0
00000286 00000003 c12e6c00 c014217a
Mar  7 18:16:27 kaeding kernel:        00000000 cffd8128 00026496 c12e6c00
c0142396 c12e6c00 00026496 cffd8128
Mar  7 18:16:27 kaeding kernel:        00000000 00000000 00026496 cfd6a7e0
cfd6a7e0 c4a84660 c01576aa c12e6c00
Mar  7 18:16:27 kaeding kernel:        00000000 00000000 00026496 cfd6a7e0
cfd6a7e0 c4a84660 c01576aa c12e6c00
Mar  7 18:16:27 kaeding kernel: Call Trace:    [get_new_inode+246/376]
[iget4+202/220] [ext3_lookup+86/124] [real_lookup+83/196]
[link_path_walk+1487/2132]
Mar  7 18:16:27 kaeding kernel:   [path_walk+26/28] [path_lookup+27/36]
[open_namei+116/1364] [ide_intr+241/272] [filp_open+59/92]
[sys_open+54/132]
Mar  7 18:16:27 kaeding kernel:   [system_call+51/56]
Mar  7 18:16:27 kaeding kernel:
Mar  7 18:16:27 kaeding kernel: Code: 8b 03 0f 18 00 83 c6 04 89 75 f4 39
f3 74 63 90 8b 4b fc 8b
Mar  7 18:16:39 kaeding kernel:  <1>Unable to handle kernel NULL pointer
dereference at virtual address 00000064
Mar  7 18:16:39 kaeding kernel:  printing eip:
Mar  7 18:16:39 kaeding kernel: c0141e17
Mar  7 18:16:39 kaeding kernel: *pde = 00000000
Mar  7 18:16:39 kaeding kernel: Oops: 0000
Mar  7 18:16:39 kaeding kernel: *pde = 00000000
Mar  7 18:16:39 kaeding kernel: Oops: 0000
Mar  7 18:16:39 kaeding kernel: CPU:    0
Mar  7 18:16:39 kaeding kernel: EIP:    0010:[prune_icache+43/216]
Tainted: P
Mar  7 18:16:39 kaeding kernel: EFLAGS: 00010213
Mar  7 18:16:39 kaeding kernel: eax: 000194a0   ebx: 00000060   ecx:
00000000   edx: cffc44f8
Mar  7 18:16:39 kaeding kernel: esi: cc3f2e80   edi: 00000060   ebp:
c8d7be2c   esp: c8d7be14
Mar  7 18:16:39 kaeding kernel: ds: 0018   es: 0018   ss: 0018
Mar  7 18:16:39 kaeding kernel: Process drkonqi (pid: 22040,
stackpage=c8d7b000)
Mar  7 18:16:39 kaeding kernel: Stack: 00000014 000001d2 00000020 00000006
c0a510e8 cc3c6088 00000006 c0141edf
Mar  7 18:16:39 kaeding kernel:        000000d1 c0129c67 00000006 000001d2
00000006 000001d2 00000006 00000020
Mar  7 18:16:39 kaeding kernel:        000001d2 c02d35b4 c02d35b4 c0129cbc
00000006 000001d2 00000006 00000020
Mar  7 18:16:39 kaeding kernel:        000001d2 c02d35b4 c02d35b4 c0129cbc
00000020 c8d7a000 00000000 00000010
Mar  7 18:16:39 kaeding kernel: Call Trace:
[shrink_icache_memory+27/48] [shrink_caches+111/136]
[try_to_free_pages_zone+60/92] [balance_classzone+80/456]
[filemap_nopage+188/504]
Mar  7 18:16:39 kaeding kernel:   [__alloc_pages+274/352]
[do_no_page+82/380] [_alloc_pages+22/24] [do_no_page+150/380]
[handle_mm_fault+82/176] [do_page_fault+352/1152]
Mar  7 18:16:39 kaeding kernel:   [do_page_fault+0/1152] [bh_action+26/64]
[tasklet_hi_action+74/112] [do_softirq+90/164] [do_IRQ+150/168]
[error_code+52/60]
Mar  7 18:16:39 kaeding kernel:
Mar  7 18:16:39 kaeding kernel: Code: 8b 7f 04 8d 73 f8 8b 86 08 01 00 00
a8 38 75 e6 0b 86 c8 00
Mar  7 18:16:39 kaeding kernel:  <1>Unable to handle kernel NULL pointer
dereference at virtual address 00000064
Mar  7 18:16:39 kaeding kernel:  <1>Unable to handle kernel NULL pointer
dereference at virtual address 00000064
Mar  7 18:16:39 kaeding kernel:  printing eip:
Mar  7 18:16:39 kaeding kernel: c0141e17
Mar  7 18:16:39 kaeding kernel: *pde = 00000000
Mar  7 18:16:39 kaeding kernel: Oops: 0000
Mar  7 18:16:39 kaeding kernel: CPU:    0
Mar  7 18:16:39 kaeding kernel: EIP:    0010:[prune_icache+43/216]
Tainted: P
Mar  7 18:16:39 kaeding kernel: EFLAGS: 00010213
Mar  7 18:16:39 kaeding kernel: eax: 000194a0   ebx: 00000060   ecx:
00000000   edx: cffc45c8
Mar  7 18:16:39 kaeding kernel: esi: cc3f2e80   edi: 00000060   ebp:
ca8b1e2c   esp: ca8b1e14
Mar  7 18:16:39 kaeding kernel: ds: 0018   es: 0018   ss: 0018
Mar  7 18:16:39 kaeding kernel: Process drkonqi (pid: 22033,
stackpage=ca8b1000)
Mar  7 18:16:39 kaeding kernel: Stack: 00000007 000001d2 00000020 00000001
stackpage=ca8b1000)
Mar  7 18:16:39 kaeding kernel: Stack: 00000007 000001d2 00000020 00000001
c70d19c8 c70d19c8 00000006 c0141edf
Mar  7 18:16:39 kaeding kernel:        00000120 c0129c67 00000006 000001d2
00000006 000001d2 00000006 00000020
Mar  7 18:16:39 kaeding kernel:        000001d2 c02d35b4 c02d35b4 c0129cbc
00000020 ca8b0000 00000000 00000010
Mar  7 18:16:39 kaeding kernel: Call Trace:
[shrink_icache_memory+27/48] [shrink_caches+111/136]
[try_to_free_pages_zone+60/92] [balance_classzone+80/456]
[filemap_nopage+188/504]
Mar  7 18:16:39 kaeding kernel:   [__alloc_pages+274/352]
[do_no_page+82/380] [_alloc_pages+22/24] [do_no_page+150/380]
[handle_mm_fault+82/176] [do_page_fault+352/1152]
Mar  7 18:16:39 kaeding kernel:   [do_page_fault+0/1152] [bh_action+26/64]
[tasklet_hi_action+74/112] [do_softirq+90/164] [do_IRQ+150/168]
[error_code+52/60]
Mar  7 18:16:39 kaeding kernel:
[error_code+52/60]
Mar  7 18:16:39 kaeding kernel:
Mar  7 18:16:39 kaeding kernel: Code: 8b 7f 04 8d 73 f8 8b 86 08 01 00 00
a8 38 75 e6 0b 86 c8 00
Mar  7 18:19:40 kaeding kernel:  <1>Unable to handle kernel NULL pointer
dereference at virtual address 00000000
Mar  7 18:19:40 kaeding kernel:  printing eip:
Mar  7 18:19:40 kaeding kernel: c0112010
Mar  7 18:19:40 kaeding kernel: *pde = 00000000
Mar  7 18:19:40 kaeding kernel: Oops: 0000
Mar  7 18:19:40 kaeding kernel: CPU:    0
Mar  7 18:19:40 kaeding kernel: EIP:    0010:[__wake_up+32/160]
Tainted: P
Mar  7 18:19:40 kaeding kernel: EFLAGS: 00013086
Mar  7 18:19:40 kaeding kernel: eax: c25e6f3c   ebx: 00000000   ecx:
00000001   edx: 00000003
Mar  7 18:19:40 kaeding kernel: esi: c25e6f3c   edi: 00000001   ebp:
cc0ffe6c   esp: cc0ffe54
Mar  7 18:19:40 kaeding kernel: esi: c25e6f3c   edi: 00000001   ebp:
cc0ffe6c   esp: cc0ffe54
Mar  7 18:19:40 kaeding kernel: ds: 0018   es: 0018   ss: 0018
Mar  7 18:19:40 kaeding kernel: Process X (pid: 22061, stackpage=cc0ff000)
Mar  7 18:19:40 kaeding kernel: Stack: 00000000 c25e6ea0 cffd80c0 c9fa9f00
00003286 00000003 cfd55c00 c014217a
Mar  7 18:19:40 kaeding kernel:        00000000 cffd80c0 000f6b00 cfd55c00
c0142396 cfd55c00 000f6b00 cffd80c0
Mar  7 18:19:40 kaeding kernel:        00000000 00000000 000f6b00 c2e1c120
c2e1c120 c6d1e3a0 c01576aa cfd55c00
Mar  7 18:19:40 kaeding kernel: Call Trace:    [get_new_inode+246/376]
[iget4+202/220] [ext3_lookup+86/124] [real_lookup+83/196]
[link_path_walk+1487/2132]
Mar  7 18:19:40 kaeding kernel:   [path_walk+26/28] [path_lookup+27/36]
[__user_walk+38/64] [vfs_stat+30/152] [sys_stat64+19/48]
[system_call+51/56]
Mar  7 18:19:40 kaeding kernel:
Mar  7 18:19:40 kaeding kernel: Code: 8b 03 0f 18 00 83 c6 04 89 75 f4 39
Mar  7 18:19:40 kaeding kernel:
Mar  7 18:19:40 kaeding kernel: Code: 8b 03 0f 18 00 83 c6 04 89 75 f4 39
f3 74 63 90 8b 4b fc 8b
Mar  7 18:19:54 kaeding kernel:  <1>Unable to handle kernel paging request
at virtual address 40bff9e1
Mar  7 18:19:54 kaeding kernel:  printing eip:
Mar  7 18:19:54 kaeding kernel: c0112010
Mar  7 18:19:54 kaeding kernel: *pde = 00000000
Mar  7 18:19:54 kaeding kernel: Oops: 0000
Mar  7 18:19:54 kaeding kernel: CPU:    0
Mar  7 18:19:54 kaeding kernel: EIP:    0010:[__wake_up+32/160]
Tainted: P
Mar  7 18:19:54 kaeding kernel: EFLAGS: 00010082
Mar  7 18:19:54 kaeding kernel: eax: ced51f1c   ebx: 40bff9e1   ecx:
00000001   edx: 00000003
Mar  7 18:19:54 kaeding kernel: esi: ced51f1c   edi: 00000001   ebp:
c1373e6c   esp: c1373e54
Mar  7 18:19:54 kaeding kernel: ds: 0018   es: 0018   ss: 0018
c1373e6c   esp: c1373e54
Mar  7 18:19:54 kaeding kernel: ds: 0018   es: 0018   ss: 0018
Mar  7 18:19:54 kaeding kernel: Process bash (pid: 513,
stackpage=c1373000)
Mar  7 18:19:54 kaeding kernel: Stack: 00000000 ced51e80 cffdd968 cab92cc0
00000282 00000003 cfd55c00 c014217a
Mar  7 18:19:54 kaeding kernel:        00000000 cffdd968 000af627 cfd55c00
c0142396 cfd55c00 000af627 cffdd968
Mar  7 18:19:54 kaeding kernel:        00000000 00000000 000af627 c2e1c0a0
c2e1c0a0 c13b4ac0 c01576aa cfd55c00
Mar  7 18:19:54 kaeding kernel: Call Trace:    [get_new_inode+246/376]
[iget4+202/220] [ext3_lookup+86/124] [real_lookup+83/196]
[link_path_walk+1487/2132]
Mar  7 18:19:54 kaeding kernel:   [path_walk+26/28] [path_lookup+27/36]
[__user_walk+38/64] [vfs_stat+30/152] [sys_stat64+19/48]
[system_call+51/56]
Mar  7 18:19:54 kaeding kernel:
Mar  7 18:19:54 kaeding kernel: Code: 8b 03 0f 18 00 83 c6 04 89 75 f4 39
Mar  7 18:19:54 kaeding kernel:
Mar  7 18:19:54 kaeding kernel: Code: 8b 03 0f 18 00 83 c6 04 89 75 f4 39
f3 74 63 90 8b 4b fc 8b
Mar  7 18:19:58 kaeding kernel:  <1>Unable to handle kernel paging request
at virtual address fd5c6a88
Mar  7 18:19:58 kaeding kernel:  printing eip:
Mar  7 18:19:58 kaeding kernel: c0142020
Mar  7 18:19:58 kaeding kernel: *pde = 00000000
Mar  7 18:19:58 kaeding kernel: Oops: 0002
Mar  7 18:19:58 kaeding kernel: CPU:    0
Mar  7 18:19:58 kaeding kernel: EIP:    0010:[get_empty_inode+44/144]
Tainted: P
Mar  7 18:19:58 kaeding kernel: EFLAGS: 00010206
Mar  7 18:19:58 kaeding kernel: eax: fd5c6a88   ebx: fd5c6a80   ecx:
c12c61a0   edx: ca2542a8
Mar  7 18:19:58 kaeding kernel: esi: c9942180   edi: 0821a32c   ebp:
bffff7cc   esp: c3477eec
Mar  7 18:19:58 kaeding kernel: ds: 0018   es: 0018   ss: 0018
bffff7cc   esp: c3477eec
Mar  7 18:19:58 kaeding kernel: ds: 0018   es: 0018   ss: 0018
Mar  7 18:19:58 kaeding kernel: Process streamcast.pl (pid: 22019,
stackpage=c3477000)
Mar  7 18:19:58 kaeding kernel: Stack: 00000004 c023066a 00000004 c023121d
00000004 0821a4dc 0821a32c bffff7dc
Mar  7 18:19:58 kaeding kernel:        00000000 ffffffe8 c3477f2c c0111ca1
c3477f2c c3477f2c 00000000 00000000
Mar  7 18:19:58 kaeding kernel:        00000000 00000000 00000000 00000000
00000000 c013ce18 c3477f6c 00000000
Mar  7 18:19:58 kaeding kernel: Call Trace:    [sock_alloc+6/176]
[sys_accept+61/252] [schedule_timeout+121/148] [do_select+452/476]
[select_bits_free+10/16]
Mar  7 18:19:58 kaeding kernel:   [sys_select+1127/1140]
[sys_socketcall+180/512] [system_call+51/56]
Mar  7 18:19:58 kaeding kernel:
Mar  7 18:19:58 kaeding kernel: Code: 89 53 08 c7 40 04 3c 43 2d c0 a3 3c
43 2d c0 a1 08 0f 34 c0
Mar  7 18:19:58 kaeding kernel: Code: 89 53 08 c7 40 04 3c 43 2d c0 a3 3c
43 2d c0 a1 08 0f 34 c0
Mar  7 18:19:59 kaeding kernel:  <1>Unable to handle kernel paging request
at virtual address fd5c6a88
Mar  7 18:19:59 kaeding kernel:  printing eip:
Mar  7 18:19:59 kaeding kernel: c01411e1
Mar  7 18:19:59 kaeding kernel: *pde = 00000000
Mar  7 18:19:59 kaeding kernel: Oops: 0002
Mar  7 18:19:59 kaeding kernel: CPU:    0
Mar  7 18:19:59 kaeding kernel: EIP:    0010:[__mark_inode_dirty+93/132]
Tainted: P
Mar  7 18:19:59 kaeding kernel: EFLAGS: 00010202
Mar  7 18:19:59 kaeding kernel: eax: c8208048   ebx: ca2542a0   ecx:
fd5c6a88   edx: ca2542a8
Mar  7 18:19:59 kaeding kernel: esi: cfb8a000   edi: 00000001   ebp:
000003e1   esp: cedcdf20
Mar  7 18:19:59 kaeding kernel: ds: 0018   es: 0018   ss: 0018
Mar  7 18:19:59 kaeding kernel: Process ices (pid: 21978,
Mar  7 18:19:59 kaeding kernel: ds: 0018   es: 0018   ss: 0018
Mar  7 18:19:59 kaeding kernel: Process ices (pid: 21978,
stackpage=cedcd000)
Mar  7 18:19:59 kaeding kernel: Stack: 3e69291f 00000400 ca254350 c0142683
ca2542a0 00000001 00000400 c0124523
Mar  7 18:19:59 kaeding kernel:        ca2542a0 00000000 c1504be0 00000000
bfffe7dc 00001000 00000001 00000000
Mar  7 18:19:59 kaeding kernel:        00000400 ca2542a0 c0124854 c1504be0
c1504c00 cedcdf8c c012474c 00000000
Mar  7 18:19:59 kaeding kernel: Call Trace:    [update_atime+75/80]
[do_generic_file_read+1015/1028] [generic_file_read+124/272]
[file_read_actor+0/140] [sys_read+143/232]
Mar  7 18:19:59 kaeding kernel:   [system_call+51/56]
Mar  7 18:19:59 kaeding kernel:
Mar  7 18:19:59 kaeding kernel: Code: 89 01 c7 43 08 00 00 00 00 c7 42 04
00 00 00 00 8b 46 60 89
Mar  7 18:20:18 kaeding kernel:  <1>Unable to handle kernel paging request
at virtual address 15a013c4
Mar  7 18:20:18 kaeding kernel:  <1>Unable to handle kernel paging request
at virtual address 15a013c4
Mar  7 18:20:18 kaeding kernel:  printing eip:
Mar  7 18:20:18 kaeding kernel: c0128aa3
Mar  7 18:20:18 kaeding kernel: *pde = 00000000
Mar  7 18:20:18 kaeding kernel: Oops: 0000
Mar  7 18:20:18 kaeding kernel: CPU:    0
Mar  7 18:20:18 kaeding kernel: EIP:    0010:[kmem_cache_alloc+131/212]
Tainted: P
Mar  7 18:20:18 kaeding kernel: EFLAGS: 00010803
Mar  7 18:20:18 kaeding kernel: eax: 551cec83   ebx: 6060b620   ecx:
c12c61a0   edx: cffc0000
Mar  7 18:20:18 kaeding kernel: esi: c12c61a0   edi: 00000246   ebp:
000001f0   esp: c1373dd8
Mar  7 18:20:18 kaeding kernel: ds: 0018   es: 0018   ss: 0018
Mar  7 18:20:18 kaeding kernel: Process bash (pid: 22063,
stackpage=c1373000)
Mar  7 18:20:18 kaeding kernel: Stack: 00000000 cffcf680 cffcf680 cffe9800
stackpage=c1373000)
Mar  7 18:20:18 kaeding kernel: Stack: 00000000 cffcf680 cffcf680 cffe9800
c01420a0 c12c61a0 000001f0 00000000
Mar  7 18:20:18 kaeding kernel:        cffcf680 00001010 cffe9800 c0142396
cffe9800 00001010 cffcf680 00000000
Mar  7 18:20:18 kaeding kernel:        00000000 c12cd8a0 c88b6982 c12cd8f2
c12cf400 c014c08d cffe9800 00001010
Mar  7 18:20:18 kaeding kernel: Call Trace:    [get_new_inode+28/376]
[iget4+202/220] [proc_get_inode+65/280] [proc_lookup+117/156]
[proc_root_lookup+43/72]
Mar  7 18:20:18 kaeding kernel:   [real_lookup+83/196]
[link_path_walk+1487/2132] [vfs_follow_link+209/316]
[ext3_follow_link+23/28] [link_path_walk+1794/2132] [path_walk+26/28]
Mar  7 18:20:18 kaeding kernel:   [path_lookup+27/36]
[open_namei+116/1364] [do_brk+284/512] [filp_open+59/92] [sys_open+54/132]
[system_call+51/56]
Mar  7 18:20:18 kaeding kernel:
Mar  7 18:20:18 kaeding kernel: Code: 8b 44 81 18 89 41 14 83 f8 ff 75 23
Mar  7 18:20:18 kaeding kernel:
Mar  7 18:20:18 kaeding kernel: Code: 8b 44 81 18 89 41 14 83 f8 ff 75 23
8b 41 04 8b 11 89 42 04
Mar  7 18:20:21 kaeding kernel:  <1>Unable to handle kernel paging request
at virtual address 15a013c4
Mar  7 18:20:21 kaeding kernel:  printing eip:
Mar  7 18:20:21 kaeding kernel: c0128aa3
Mar  7 18:20:21 kaeding kernel: *pde = 00000000
Mar  7 18:20:21 kaeding kernel: Oops: 0000
Mar  7 18:20:21 kaeding kernel: CPU:    0
Mar  7 18:20:21 kaeding kernel: EIP:    0010:[kmem_cache_alloc+131/212]
Tainted: P
Mar  7 18:20:21 kaeding kernel: EFLAGS: 00010803
Mar  7 18:20:21 kaeding kernel: eax: 551cec83   ebx: 6060b620   ecx:
c12c61a0   edx: c0364f40
Mar  7 18:20:21 kaeding kernel: esi: c12c61a0   edi: 00000246   ebp:
000001f0   esp: c1373f1c
Mar  7 18:20:21 kaeding kernel: ds: 0018   es: 0018   ss: 0018
000001f0   esp: c1373f1c
Mar  7 18:20:21 kaeding kernel: ds: 0018   es: 0018   ss: 0018
Mar  7 18:20:21 kaeding kernel: Process login (pid: 22064,
stackpage=c1373000)
Mar  7 18:20:21 kaeding kernel: Stack: 00000001 00000004 c0364f40 00000001
c0142005 c12c61a0 000001f0 00000001
Mar  7 18:20:21 kaeding kernel:        c023066a 00000001 c0230f35 00000001
00000000 401927a0 bfffd99c c01176e8
Mar  7 18:20:21 kaeding kernel:        00000000 c1373fa0 00000000 c1373fa8
00000206 05c133d1 c1372000 c0230fa5
Mar  7 18:20:21 kaeding kernel: Call Trace:    [get_empty_inode+17/144]
[sock_alloc+6/176] [sock_create+173/256] [do_getitimer+156/164]
[sys_socket+29/80]
Mar  7 18:20:21 kaeding kernel:   [sys_socketcall+100/512]
[error_code+52/60] [system_call+51/56]
Mar  7 18:20:21 kaeding kernel:
Mar  7 18:20:21 kaeding kernel: Code: 8b 44 81 18 89 41 14 83 f8 ff 75 23
8b 41 04 8b 11 89 42 04
Mar  7 18:20:21 kaeding kernel: Code: 8b 44 81 18 89 41 14 83 f8 ff 75 23
8b 41 04 8b 11 89 42 04
Mar  7 18:20:24 kaeding kernel:  <1>Unable to handle kernel paging request
at virtual address 15a013c4
Mar  7 18:20:24 kaeding kernel:  printing eip:
Mar  7 18:20:24 kaeding kernel: c0128aa3
Mar  7 18:20:24 kaeding kernel: *pde = 00000000
Mar  7 18:20:24 kaeding kernel: Oops: 0000
Mar  7 18:20:24 kaeding kernel: CPU:    0
Mar  7 18:20:24 kaeding kernel: EIP:    0010:[kmem_cache_alloc+131/212]
Tainted: P
Mar  7 18:20:24 kaeding kernel: EFLAGS: 00010803
Mar  7 18:20:24 kaeding kernel: eax: 551cec83   ebx: 6060b620   ecx:
c12c61a0   edx: c0364f40
Mar  7 18:20:24 kaeding kernel: esi: c12c61a0   edi: 00000246   ebp:
000001f0   esp: c1373f1c
Mar  7 18:20:24 kaeding kernel: ds: 0018   es: 0018   ss: 0018
Mar  7 18:20:24 kaeding kernel: Process login (pid: 22065,
Mar  7 18:20:24 kaeding kernel: ds: 0018   es: 0018   ss: 0018
Mar  7 18:20:24 kaeding kernel: Process login (pid: 22065,
stackpage=c1373000)
Mar  7 18:20:24 kaeding kernel: Stack: 00000001 00000004 c0364f40 00000001
c0142005 c12c61a0 000001f0 00000001
Mar  7 18:20:24 kaeding kernel:        c023066a 00000001 c0230f35 00000001
00000000 401927a0 bfffd99c c01176e8
Mar  7 18:20:24 kaeding kernel:        00000000 c1373fa0 00000000 c1373fa8
00000206 05c134de c1372000 c0230fa5
Mar  7 18:20:24 kaeding kernel: Call Trace:    [get_empty_inode+17/144]
[sock_alloc+6/176] [sock_create+173/256] [do_getitimer+156/164]
[sys_socket+29/80]
Mar  7 18:20:24 kaeding kernel:   [sys_socketcall+100/512]
[error_code+52/60] [system_call+51/56]
Mar  7 18:20:24 kaeding kernel:
Mar  7 18:20:24 kaeding kernel: Code: 8b 44 81 18 89 41 14 83 f8 ff 75 23
8b 41 04 8b 11 89 42 04
Mar  7 18:20:27 kaeding kernel:  <1>Unable to handle kernel paging request
8b 41 04 8b 11 89 42 04
Mar  7 18:20:27 kaeding kernel:  <1>Unable to handle kernel paging request
at virtual address 15a013c4
Mar  7 18:20:27 kaeding kernel:  printing eip:
Mar  7 18:20:27 kaeding kernel: c0128aa3
Mar  7 18:20:27 kaeding kernel: *pde = 00000000
Mar  7 18:20:27 kaeding kernel: Oops: 0000
Mar  7 18:20:27 kaeding kernel: CPU:    0
Mar  7 18:20:27 kaeding kernel: EIP:    0010:[kmem_cache_alloc+131/212]
Tainted: P
Mar  7 18:20:27 kaeding kernel: EFLAGS: 00010803
Mar  7 18:20:27 kaeding kernel: eax: 551cec83   ebx: 6060b620   ecx:
c12c61a0   edx: c0364f40
Mar  7 18:20:27 kaeding kernel: esi: c12c61a0   edi: 00000246   ebp:
000001f0   esp: c8309f1c
Mar  7 18:20:27 kaeding kernel: ds: 0018   es: 0018   ss: 0018
Mar  7 18:20:27 kaeding kernel: Process login (pid: 514,
stackpage=c8309000)
Mar  7 18:20:27 kaeding kernel: Process login (pid: 514,
stackpage=c8309000)
Mar  7 18:20:27 kaeding kernel: Stack: 00000001 00000004 c0364f40 00000001
c0142005 c12c61a0 000001f0 00000001
Mar  7 18:20:27 kaeding kernel:        c023066a 00000001 c0230f35 00000001
00000000 401927a0 bfffd99c c01176e8
Mar  7 18:20:27 kaeding kernel:        00000000 c8309fa0 00000000 c8309fa8
00000202 05c13664 c8308000 c0230fa5
Mar  7 18:20:27 kaeding kernel: Call Trace:    [get_empty_inode+17/144]
[sock_alloc+6/176] [sock_create+173/256] [do_getitimer+156/164]
[sys_socket+29/80]
Mar  7 18:20:27 kaeding kernel:   [sys_socketcall+100/512]
[error_code+52/60] [system_call+51/56]
Mar  7 18:20:27 kaeding kernel:
Mar  7 18:20:27 kaeding kernel: Code: 8b 44 81 18 89 41 14 83 f8 ff 75 23
8b 41 04 8b 11 89 42 04
Mar  7 18:20:35 kaeding kernel:  <1>Unable to handle kernel paging request
at virtual address 15a013c4
Mar  7 18:20:35 kaeding kernel:  <1>Unable to handle kernel paging request
at virtual address 15a013c4
Mar  7 18:20:35 kaeding kernel:  printing eip:
Mar  7 18:20:35 kaeding kernel: c0128aa3
Mar  7 18:20:35 kaeding kernel: *pde = 00000000
Mar  7 18:20:35 kaeding kernel: Oops: 0000
Mar  7 18:20:35 kaeding kernel: CPU:    0
Mar  7 18:20:35 kaeding kernel: EIP:    0010:[kmem_cache_alloc+131/212]
Tainted: P
Mar  7 18:20:35 kaeding kernel: EFLAGS: 00010803
Mar  7 18:20:35 kaeding kernel: eax: 551cec83   ebx: 6060b620   ecx:
c12c61a0   edx: cffc0000
Mar  7 18:20:35 kaeding kernel: esi: c12c61a0   edi: 00000246   ebp:
000001f0   esp: c8a37e68
Mar  7 18:20:35 kaeding kernel: ds: 0018   es: 0018   ss: 0018
Mar  7 18:20:35 kaeding kernel: Process qmgr (pid: 354,
stackpage=c8a37000)
Mar  7 18:20:35 kaeding kernel: Stack: 00000000 cffc4850 cffc4850 c12e6c00
stackpage=c8a37000)
Mar  7 18:20:35 kaeding kernel: Stack: 00000000 cffc4850 cffc4850 c12e6c00
c01420a0 c12c61a0 000001f0 00000000
Mar  7 18:20:35 kaeding kernel:        cffc4850 00003d84 c12e6c00 c0142396
c12e6c00 00003d84 cffc4850 00000000
Mar  7 18:20:35 kaeding kernel:        00000000 00003d84 c88b6a20 c88b6a20
c88b67a0 c01576aa c12e6c00 00003d84
Mar  7 18:20:35 kaeding kernel: Call Trace:    [get_new_inode+28/376]
[iget4+202/220] [ext3_lookup+86/124] [real_lookup+83/196]
[link_path_walk+1487/2132]
Mar  7 18:20:35 kaeding kernel:   [path_walk+26/28] [path_lookup+27/36]
[open_namei+116/1364] [vfs_readdir+91/124] [filldir64+0/364]
[filp_open+59/92]
Mar  7 18:20:35 kaeding kernel:   [sys_open+54/132] [system_call+51/56]
Mar  7 18:20:35 kaeding kernel:
Mar  7 18:20:35 kaeding kernel: Code: 8b 44 81 18 89 41 14 83 f8 ff 75 23
8b 41 04 8b 11 89 42 04
Mar  7 18:20:35 kaeding postfix/master[272]: warning: process
8b 41 04 8b 11 89 42 04
Mar  7 18:20:35 kaeding postfix/master[272]: warning: process
/usr/sbin/qmgr pid 354 killed by signal 11
Mar  7 18:20:44 kaeding kernel:  <1>Unable to handle kernel paging request
at virtual address 15a013c4
Mar  7 18:20:44 kaeding kernel:  printing eip:
Mar  7 18:20:44 kaeding kernel: c0128aa3
Mar  7 18:20:44 kaeding kernel: *pde = 00000000
Mar  7 18:20:44 kaeding kernel: Oops: 0000
Mar  7 18:20:44 kaeding kernel: CPU:    0
Mar  7 18:20:44 kaeding kernel: EIP:    0010:[kmem_cache_alloc+131/212]
Tainted: P
Mar  7 18:20:44 kaeding kernel: EFLAGS: 00010803
Mar  7 18:20:44 kaeding kernel: eax: 551cec83   ebx: 6060b620   ecx:
c12c61a0   edx: cffc0000
Mar  7 18:20:44 kaeding kernel: esi: c12c61a0   edi: 00000246   ebp:
000001f0   esp: c8545eb0
Mar  7 18:20:44 kaeding kernel: ds: 0018   es: 0018   ss: 0018
000001f0   esp: c8545eb0
Mar  7 18:20:44 kaeding kernel: ds: 0018   es: 0018   ss: 0018
Mar  7 18:20:44 kaeding kernel: Process cupsd (pid: 415,
stackpage=c8545000)
Mar  7 18:20:44 kaeding kernel: Stack: 00000000 cffd26f8 cffd26f8 c12e6c00
c01420a0 c12c61a0 000001f0 00000000
Mar  7 18:20:44 kaeding kernel:        cffd26f8 0002d94e c12e6c00 c0142396
c12e6c00 0002d94e cffd26f8 00000000
Mar  7 18:20:44 kaeding kernel:        00000000 0002d94e c88b66a0 c88b66a0
c8aa4d40 c01576aa c12e6c00 0002d94e
Mar  7 18:20:44 kaeding kernel: Call Trace:    [get_new_inode+28/376]
[iget4+202/220] [ext3_lookup+86/124] [real_lookup+83/196]
[link_path_walk+622/2132]
Mar  7 18:20:44 kaeding kernel:   [path_walk+26/28] [path_lookup+27/36]
[sys_unlink+52/268] [system_call+51/56]
Mar  7 18:20:44 kaeding kernel:
Mar  7 18:20:44 kaeding kernel: Code: 8b 44 81 18 89 41 14 83 f8 ff 75 23
8b 41 04 8b 11 89 42 04
Mar  7 18:20:44 kaeding kernel: Code: 8b 44 81 18 89 41 14 83 f8 ff 75 23
8b 41 04 8b 11 89 42 04
Mar  7 18:22:18 kaeding syslogd 1.4.1: restart.

[The restart here is when I pressed the 'reset' button on the box.]

middle -----------------------------------------------------------------

more /proc/version
Linux version 2.4.20 (root@kaeding) (gcc version 2.95.3 20010315
(release)) #2 Thu Feb 13 18:01:18 EST 2003

./ver_linux

Linux kaeding 2.4.20 #2 Thu Feb 13 18:01:18 EST 2003 i686 unknown

Gnu C                  2.95.3
Gnu make               3.79.1
Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.11.2
util-linux             2.11n
mount                  2.11n
modutils               2.4.12
e2fsprogs              1.27
PPP                    2.4.1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0
Modules Loaded         3c59x lirc_i2c lirc_dev NVdriver em8300 bt865
adv717x cmpci btaudio tvmixer es1371 ac97_codec gameport tvaudio bttv
msp3400 tuner i2c-algo-bit soundcore w83781d i2c-proc i2c-dev i2c-i801
i2c-core p4b_smbus usb-uhci usbcore nls_cp437
msp3400 tuner i2c-algo-bit soundcore w83781d i2c-proc i2c-dev i2c-i801
i2c-core p4b_smbus usb-uhci usbcore nls_cp437


more /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 1
model name      : Intel(R) Celeron(R) CPU 1.70GHz
stepping        : 3
cpu MHz         : 1716.941
cache size      : 8 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 3420.97

more /proc/modules
3c59x                  25128   1
lirc_i2c                2596   1
lirc_dev                7648   1 [lirc_i2c]
NVdriver             1065216  18
em8300                 43748   0
bt865                   2816   0 (unused)
adv717x                 2944   0 (unused)
bt865                   2816   0 (unused)
adv717x                 2944   0 (unused)
cmpci                  30064   0
btaudio                10144   0
tvmixer                 3680   1
es1371                 26752   2
ac97_codec             10048   0 [es1371]
gameport                1484   0 [es1371]
tvaudio                11136   1 (autoclean)
bttv                   69184   4
msp3400                14384   1 (autoclean)
tuner                   8644   1 (autoclean)
i2c-algo-bit            8396   3 [em8300 bttv]
soundcore               3492  13 [em8300 cmpci btaudio tvmixer es1371
bttv]
w83781d                19424   0 (unused)
i2c-proc                6624   0 [w83781d]
i2c-dev                 4032   0 (unused)
i2c-proc                6624   0 [w83781d]
i2c-dev                 4032   0 (unused)
i2c-i801                4676   0 (unused)
i2c-core               15144   0 [lirc_i2c bt865 adv717x tvmixer tvaudio
bttv ms
p3400 tuner i2c-algo-bit w83781d i2c-proc i2c-dev i2c-i801]
p4b_smbus               1852   0 (unused)
usb-uhci               21220   0 (unused)
usbcore                55296   1 [usb-uhci]
nls_cp437               4384   1

more /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0330-0331 : cmpci Midi
0376-0376 : ide1
0378-037a : parport0
0388-038b : cmpci FM
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
a800-a807 : US Robotics/3Com 56K FaxModem Model 5610
  a800-a807 : serial(set)
b000-b03f : 3Com Corporation 3c905 100BaseTX [Boomerang]
  b000-b03f : 02:0d.0
b400-b43f : Ensoniq ES1371 [AudioPCI-97]
  b000-b03f : 02:0d.0
b400-b43f : Ensoniq ES1371 [AudioPCI-97]
  b400-b43f : es1371
b800-b8ff : C-Media Electronics Inc CM8738
  b800-b8ff : cmpci
d000-d01f : Intel Corp. 82801DB USB (Hub #3)
  d000-d01f : usb-uhci
d400-d41f : Intel Corp. 82801DB USB (Hub #2)
  d400-d41f : usb-uhci
d800-d81f : Intel Corp. 82801DB USB (Hub #1)
  d800-d81f : usb-uhci
e800-e80f : i801-smbus
f000-f00f : Intel Corp. 82801DB ICH4 IDE
  f000-f007 : ide0
  f008-f00f : ide1

more /proc/iomem
00000000-0009fbff : System RAM
more /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0ffebfff : System RAM
  00100000-0026eb12 : Kernel code
  0026eb13-00303d97 : Kernel data
0ffec000-0ffeefff : ACPI Tables
0ffef000-0fffefff : reserved
0ffff000-0fffffff : ACPI Non-volatile Storage
10000000-100003ff : Intel Corp. 82801DB ICH4 IDE
f6000000-f60fffff : Sigma Designs, Inc. REALmagic Hollywood Plus DVD
Decoder
f6800000-f68003ff : Intel Corp. 82801DB USB EHCI Controller
f7000000-f86fffff : PCI Bus #01
  f7000000-f7ffffff : nVidia Corporation NV5 [Riva TnT2]
f7000000-f86fffff : PCI Bus #01
  f7000000-f7ffffff : nVidia Corporation NV5 [Riva TnT2]
f8800000-f8800fff : Brooktree Corporation Bt878 Audio Capture
  f8800000-f8800fff : btaudio
f9000000-f9000fff : Brooktree Corporation Bt878 Video Capture
  f9000000-f9000fff : bttv
f9f00000-fbffffff : PCI Bus #01
  fa000000-fbffffff : nVidia Corporation NV5 [Riva TnT2]
fc000000-fdffffff : Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

more /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: CREATIVE Model: DVD-ROM DVD6240E Rev: 0101
  Type:   CD-ROM                           ANSI SCSI revision: 02
  Vendor: CREATIVE Model: DVD-ROM DVD6240E Rev: 0101
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: PLEXTOR  Model: CD-R   PX-W1210A Rev: 1.02
  Type:   CD-ROM                           ANSI SCSI revision: 02

ksymoops ------------------------------------------------------------

>>eax; c12a02f4 <_end+f38998/104d76a4>
>>ebx; c109ecc4 <_end+d37368/104d76a4>
>>ecx; c109ece0 <_end+d37384/104d76a4>
>>edx; c02d341c <inactive_list+0/8>
>>esp; ccda1db8 <_end+ca3a45c/104d76a4>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a
Code;  00000002 Before first symbol
   2:   66                        data16
Code;  00000002 Before first symbol
   2:   66                        data16
Code;  00000003 Before first symbol
   3:   00 73 f6                  add    %dh,0xfffffff6(%ebx)
Code;  00000006 Before first symbol
   6:   27                        daa
Code;  00000007 Before first symbol
   7:   c0 89 d8 2b 05 90 f0      rorb   $0xf0,0x90052bd8(%ecx)
Code;  0000000e Before first symbol
   e:   33 c0                     xor    %eax,%eax
Code;  00000010 Before first symbol
  10:   69 c0 a3 8b 00 00         imul   $0x8ba3,%eax,%eax

Mar  7 18:16:27 kaeding kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000000
Mar  7 18:16:27 kaeding kernel: c0112010
Mar  7 18:16:27 kaeding kernel: *pde = 00000000
Mar  7 18:16:27 kaeding kernel: Oops: 0000
Mar  7 18:16:27 kaeding kernel: *pde = 00000000
Mar  7 18:16:27 kaeding kernel: Oops: 0000
Mar  7 18:16:27 kaeding kernel: CPU:    0
Mar  7 18:16:27 kaeding kernel: EIP:    0010:[__wake_up+32/160]
Tainted: P
Mar  7 18:16:27 kaeding kernel: EFLAGS: 00010086
Mar  7 18:16:27 kaeding kernel: eax: c2bc5f3c   ebx: 00000000   ecx:
00000001   edx: 00000003
Mar  7 18:16:27 kaeding kernel: esi: c2bc5f3c   edi: 00000001   ebp:
cc98fe7c   esp: cc98fe64
Mar  7 18:16:27 kaeding kernel: ds: 0018   es: 0018   ss: 0018
Mar  7 18:16:27 kaeding kernel: Process request.cgi (pid: 22028,
stackpage=cc98f000)
Mar  7 18:16:27 kaeding kernel: Stack: 00000000 c2bc5ea0 cffd8128 c30bb5c0
00000286 00000003 c12e6c00 c014217a
Mar  7 18:16:27 kaeding kernel:        00000000 cffd8128 00026496 c12e6c00
c0142396 c12e6c00 00026496 cffd8128
Mar  7 18:16:27 kaeding kernel:        00000000 00000000 00026496 cfd6a7e0
c0142396 c12e6c00 00026496 cffd8128
Mar  7 18:16:27 kaeding kernel:        00000000 00000000 00026496 cfd6a7e0
cfd6a7e0 c4a84660 c01576aa c12e6c00
Mar  7 18:16:27 kaeding kernel: Call Trace:    [get_new_inode+246/376]
[iget4+202/220] [ext3_lookup+86/124] [real_lookup+83/196]
[link_path_walk+1487/2132]
Mar  7 18:16:27 kaeding kernel: Code: 8b 03 0f 18 00 83 c6 04 89 75 f4 39
f3 74 63 90 8b 4b fc 8b


>>eax; c2bc5f3c <_end+285e5e0/104d76a4>
>>esi; c2bc5f3c <_end+285e5e0/104d76a4>
>>ebp; cc98fe7c <_end+c628520/104d76a4>
>>esp; cc98fe64 <_end+c628508/104d76a4>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 03                     mov    (%ebx),%eax
Code;  00000002 Before first symbol
   2:   0f 18 00                  prefetchnta (%eax)
Code;  00000005 Before first symbol
   5:   83 c6 04                  add    $0x4,%esi
Code;  00000008 Before first symbol
   8:   89 75 f4                  mov    %esi,0xfffffff4(%ebp)
Code;  0000000b Before first symbol
   b:   39 f3                     cmp    %esi,%ebx
Code;  0000000d Before first symbol
   d:   74 63                     je     72 <_EIP+0x72> 00000072 Before
first symbol
Code;  0000000f Before first symbol
   f:   90                        nop
Code;  00000010 Before first symbol
  10:   8b 4b fc                  mov    0xfffffffc(%ebx),%ecx
Code;  00000010 Before first symbol
  10:   8b 4b fc                  mov    0xfffffffc(%ebx),%ecx
Code;  00000013 Before first symbol
  13:   8b 00                     mov    (%eax),%eax

Mar  7 18:16:39 kaeding kernel:  <1>Unable to handle kernel NULL pointer
dereference at virtual address 00000064
Mar  7 18:16:39 kaeding kernel: c0141e17
Mar  7 18:16:39 kaeding kernel: *pde = 00000000
Mar  7 18:16:39 kaeding kernel: Oops: 0000
Mar  7 18:16:39 kaeding kernel: CPU:    0
Mar  7 18:16:39 kaeding kernel: EIP:    0010:[prune_icache+43/216]
Tainted: P
Mar  7 18:16:39 kaeding kernel: EFLAGS: 00010213
Mar  7 18:16:39 kaeding kernel: eax: 000194a0   ebx: 00000060   ecx:
00000000   edx: cffc44f8
Mar  7 18:16:39 kaeding kernel: esi: cc3f2e80   edi: 00000060   ebp:
c8d7be2c   esp: c8d7be14
Mar  7 18:16:39 kaeding kernel: esi: cc3f2e80   edi: 00000060   ebp:
c8d7be2c   esp: c8d7be14
Mar  7 18:16:39 kaeding kernel: ds: 0018   es: 0018   ss: 0018
Mar  7 18:16:39 kaeding kernel: Process drkonqi (pid: 22040,
stackpage=c8d7b000)
Mar  7 18:16:39 kaeding kernel: Stack: 00000014 000001d2 00000020 00000006
c0a510e8 cc3c6088 00000006 c0141edf
Mar  7 18:16:39 kaeding kernel:        000000d1 c0129c67 00000006 000001d2
00000006 000001d2 00000006 00000020
Mar  7 18:16:39 kaeding kernel:        000001d2 c02d35b4 c02d35b4 c0129cbc
00000020 c8d7a000 00000000 00000010
Mar  7 18:16:39 kaeding kernel: Call Trace:
[shrink_icache_memory+27/48] [shrink_caches+111/136]
[try_to_free_pages_zone+60/92] [balance_classzone+80/456]
[filemap_nopage+188/504]
Mar  7 18:16:39 kaeding kernel: Code: 8b 7f 04 8d 73 f8 8b 86 08 01 00 00
a8 38 75 e6 0b 86 c8 00
a8 38 75 e6 0b 86 c8 00


>>edx; cffc44f8 <_end+fc5cb9c/104d76a4>
>>esi; cc3f2e80 <_end+c08b524/104d76a4>
>>ebp; c8d7be2c <_end+8a144d0/104d76a4>
>>esp; c8d7be14 <_end+8a144b8/104d76a4>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 7f 04                  mov    0x4(%edi),%edi
Code;  00000003 Before first symbol
   3:   8d 73 f8                  lea    0xfffffff8(%ebx),%esi
Code;  00000006 Before first symbol
   6:   8b 86 08 01 00 00         mov    0x108(%esi),%eax
Code;  0000000c Before first symbol
   c:   a8 38                     test   $0x38,%al
Code;  0000000c Before first symbol
   c:   a8 38                     test   $0x38,%al
Code;  0000000e Before first symbol
   e:   75 e6                     jne    fffffff6 <_EIP+0xfffffff6>
fffffff6 <END_OF_CODE+2f519dcf/????>
Code;  00000010 Before first symbol
  10:   0b 86 c8 00 00 00         or     0xc8(%esi),%eax

Mar  7 18:16:39 kaeding kernel:  <1>Unable to handle kernel NULL pointer
dereference at virtual address 00000064
Mar  7 18:16:39 kaeding kernel: c0141e17
Mar  7 18:16:39 kaeding kernel: *pde = 00000000
Mar  7 18:16:39 kaeding kernel: Oops: 0000
Mar  7 18:16:39 kaeding kernel: CPU:    0
Mar  7 18:16:39 kaeding kernel: EIP:    0010:[prune_icache+43/216]
Tainted: P
Mar  7 18:16:39 kaeding kernel: EFLAGS: 00010213
Mar  7 18:16:39 kaeding kernel: eax: 000194a0   ebx: 00000060   ecx:
00000000   edx: cffc45c8
Mar  7 18:16:39 kaeding kernel: esi: cc3f2e80   edi: 00000060   ebp:
ca8b1e2c   esp: ca8b1e14
Mar  7 18:16:39 kaeding kernel: ds: 0018   es: 0018   ss: 0018
Mar  7 18:16:39 kaeding kernel: Process drkonqi (pid: 22033,
stackpage=ca8b1000)
Mar  7 18:16:39 kaeding kernel: Stack: 00000007 000001d2 00000020 00000001
c70d19c8 c70d19c8 00000006 c0141edf
Mar  7 18:16:39 kaeding kernel:        00000120 c0129c67 00000006 000001d2
00000006 000001d2 00000006 00000020
Mar  7 18:16:39 kaeding kernel:        000001d2 c02d35b4 c02d35b4 c0129cbc
00000020 ca8b0000 00000000 00000010
Mar  7 18:16:39 kaeding kernel: Call Trace:
[shrink_icache_memory+27/48] [shrink_caches+111/136]
[try_to_free_pages_zone+60/92] [balance_classzone+80/456]
[filemap_nopage+188/504]
Mar  7 18:16:39 kaeding kernel: Code: 8b 7f 04 8d 73 f8 8b 86 08 01 00 00
a8 38 75 e6 0b 86 c8 00


>>edx; cffc45c8 <_end+fc5cc6c/104d76a4>
>>esi; cc3f2e80 <_end+c08b524/104d76a4>
>>ebp; ca8b1e2c <_end+a54a4d0/104d76a4>
>>esp; ca8b1e14 <_end+a54a4b8/104d76a4>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 7f 04                  mov    0x4(%edi),%edi
Code;  00000003 Before first symbol
   3:   8d 73 f8                  lea    0xfffffff8(%ebx),%esi
Code;  00000006 Before first symbol
   6:   8b 86 08 01 00 00         mov    0x108(%esi),%eax
Code;  0000000c Before first symbol
   c:   a8 38                     test   $0x38,%al
Code;  0000000e Before first symbol
   e:   75 e6                     jne    fffffff6 <_EIP+0xfffffff6>
fffffff6 <END_OF_CODE+2f519dcf/????>
Code;  00000010 Before first symbol
  10:   0b 86 c8 00 00 00         or     0xc8(%esi),%eax

Mar  7 18:19:40 kaeding kernel:  <1>Unable to handle kernel NULL pointer
dereference at virtual address 00000000
Mar  7 18:19:40 kaeding kernel: c0112010
Mar  7 18:19:40 kaeding kernel: *pde = 00000000
Mar  7 18:19:40 kaeding kernel: Oops: 0000
Mar  7 18:19:40 kaeding kernel: CPU:    0
Mar  7 18:19:40 kaeding kernel: EIP:    0010:[__wake_up+32/160]
Tainted: P
Mar  7 18:19:40 kaeding kernel: EFLAGS: 00013086
Mar  7 18:19:40 kaeding kernel: eax: c25e6f3c   ebx: 00000000   ecx:
00000001   edx: 00000003
Mar  7 18:19:40 kaeding kernel: esi: c25e6f3c   edi: 00000001   ebp:
cc0ffe6c   esp: cc0ffe54
Mar  7 18:19:40 kaeding kernel: ds: 0018   es: 0018   ss: 0018
Mar  7 18:19:40 kaeding kernel: Process X (pid: 22061, stackpage=cc0ff000)
Mar  7 18:19:40 kaeding kernel: Stack: 00000000 c25e6ea0 cffd80c0 c9fa9f00
00003286 00000003 cfd55c00 c014217a
Mar  7 18:19:40 kaeding kernel:        00000000 cffd80c0 000f6b00 cfd55c00
c0142396 cfd55c00 000f6b00 cffd80c0
Mar  7 18:19:40 kaeding kernel:        00000000 00000000 000f6b00 c2e1c120
c2e1c120 c6d1e3a0 c01576aa cfd55c00
Mar  7 18:19:40 kaeding kernel: Call Trace:    [get_new_inode+246/376]
[iget4+202/220] [ext3_lookup+86/124] [real_lookup+83/196]
[link_path_walk+1487/2132]
Mar  7 18:19:40 kaeding kernel: Code: 8b 03 0f 18 00 83 c6 04 89 75 f4 39
f3 74 63 90 8b 4b fc 8b


>>eax; c25e6f3c <_end+227f5e0/104d76a4>
>>esi; c25e6f3c <_end+227f5e0/104d76a4>
>>ebp; cc0ffe6c <_end+bd98510/104d76a4>
>>esp; cc0ffe54 <_end+bd984f8/104d76a4>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 03                     mov    (%ebx),%eax
Code;  00000002 Before first symbol
   2:   0f 18 00                  prefetchnta (%eax)
Code;  00000005 Before first symbol
   5:   83 c6 04                  add    $0x4,%esi
Code;  00000008 Before first symbol
   8:   89 75 f4                  mov    %esi,0xfffffff4(%ebp)
Code;  0000000b Before first symbol
   b:   39 f3                     cmp    %esi,%ebx
Code;  0000000d Before first symbol
   d:   74 63                     je     72 <_EIP+0x72> 00000072 Before
first symbol
Code;  0000000f Before first symbol
   f:   90                        nop
Code;  00000010 Before first symbol
  10:   8b 4b fc                  mov    0xfffffffc(%ebx),%ecx
Code;  00000013 Before first symbol
  13:   8b 00                     mov    (%eax),%eax

Mar  7 18:19:54 kaeding kernel:  <1>Unable to handle kernel paging request
at virtual address 40bff9e1
Mar  7 18:19:54 kaeding kernel: c0112010
Mar  7 18:19:54 kaeding kernel: *pde = 00000000
Mar  7 18:19:54 kaeding kernel: Oops: 0000
Mar  7 18:19:54 kaeding kernel: CPU:    0
Mar  7 18:19:54 kaeding kernel: EIP:    0010:[__wake_up+32/160]
Tainted: P
Mar  7 18:19:54 kaeding kernel: EFLAGS: 00010082
Mar  7 18:19:54 kaeding kernel: eax: ced51f1c   ebx: 40bff9e1   ecx:
00000001   edx: 00000003
Mar  7 18:19:54 kaeding kernel: esi: ced51f1c   edi: 00000001   ebp:
c1373e6c   esp: c1373e54
Mar  7 18:19:54 kaeding kernel: ds: 0018   es: 0018   ss: 0018
Mar  7 18:19:54 kaeding kernel: Process bash (pid: 513,
stackpage=c1373000)
Mar  7 18:19:54 kaeding kernel: Stack: 00000000 ced51e80 cffdd968 cab92cc0
00000282 00000003 cfd55c00 c014217a
Mar  7 18:19:54 kaeding kernel:        00000000 cffdd968 000af627 cfd55c00
c0142396 cfd55c00 000af627 cffdd968
Mar  7 18:19:54 kaeding kernel:        00000000 00000000 000af627 c2e1c0a0
c2e1c0a0 c13b4ac0 c01576aa cfd55c00
Mar  7 18:19:54 kaeding kernel: Call Trace:    [get_new_inode+246/376]
[iget4+202/220] [ext3_lookup+86/124] [real_lookup+83/196]
[link_path_walk+1487/2132]
Mar  7 18:19:54 kaeding kernel: Code: 8b 03 0f 18 00 83 c6 04 89 75 f4 39
f3 74 63 90 8b 4b fc 8b


>>eax; ced51f1c <_end+e9ea5c0/104d76a4>
>>esi; ced51f1c <_end+e9ea5c0/104d76a4>
>>ebp; c1373e6c <_end+100c510/104d76a4>
>>esp; c1373e54 <_end+100c4f8/104d76a4>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 03                     mov    (%ebx),%eax
Code;  00000002 Before first symbol
   2:   0f 18 00                  prefetchnta (%eax)
Code;  00000005 Before first symbol
   5:   83 c6 04                  add    $0x4,%esi
Code;  00000008 Before first symbol
   8:   89 75 f4                  mov    %esi,0xfffffff4(%ebp)
Code;  0000000b Before first symbol
   b:   39 f3                     cmp    %esi,%ebx
Code;  0000000d Before first symbol
   d:   74 63                     je     72 <_EIP+0x72> 00000072 Before
first symbol
Code;  0000000f Before first symbol
   f:   90                        nop
Code;  00000010 Before first symbol
  10:   8b 4b fc                  mov    0xfffffffc(%ebx),%ecx
Code;  00000013 Before first symbol
  13:   8b 00                     mov    (%eax),%eax

Mar  7 18:19:58 kaeding kernel:  <1>Unable to handle kernel paging request
at virtual address fd5c6a88
Mar  7 18:19:58 kaeding kernel: c0142020
Mar  7 18:19:58 kaeding kernel: *pde = 00000000
Mar  7 18:19:58 kaeding kernel: Oops: 0002
Mar  7 18:19:58 kaeding kernel: CPU:    0
Mar  7 18:19:58 kaeding kernel: EIP:    0010:[get_empty_inode+44/144]
Tainted: P
Mar  7 18:19:58 kaeding kernel: EFLAGS: 00010206
Mar  7 18:19:58 kaeding kernel: eax: fd5c6a88   ebx: fd5c6a80   ecx:
c12c61a0   edx: ca2542a8
Mar  7 18:19:58 kaeding kernel: esi: c9942180   edi: 0821a32c   ebp:
bffff7cc   esp: c3477eec
Mar  7 18:19:58 kaeding kernel: ds: 0018   es: 0018   ss: 0018
Mar  7 18:19:58 kaeding kernel: Process streamcast.pl (pid: 22019,
stackpage=c3477000)
Mar  7 18:19:58 kaeding kernel: Stack: 00000004 c023066a 00000004 c023121d
00000004 0821a4dc 0821a32c bffff7dc
Mar  7 18:19:58 kaeding kernel:        00000000 ffffffe8 c3477f2c c0111ca1
c3477f2c c3477f2c 00000000 00000000
Mar  7 18:19:58 kaeding kernel:        00000000 00000000 00000000 00000000
00000000 c013ce18 c3477f6c 00000000
Mar  7 18:19:58 kaeding kernel: Call Trace:    [sock_alloc+6/176]
[sys_accept+61/252] [schedule_timeout+121/148] [do_select+452/476]
[select_bits_free+10/16]
Mar  7 18:19:58 kaeding kernel: Code: 89 53 08 c7 40 04 3c 43 2d c0 a3 3c
43 2d c0 a1 08 0f 34 c0


>>ecx; c12c61a0 <_end+f5e844/104d76a4>
>>edx; ca2542a8 <_end+9eec94c/104d76a4>
>>esi; c9942180 <_end+95da824/104d76a4>
>>esp; c3477eec <_end+3110590/104d76a4>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   89 53 08                  mov    %edx,0x8(%ebx)
Code;  00000003 Before first symbol
   3:   c7 40 04 3c 43 2d c0      movl   $0xc02d433c,0x4(%eax)
Code;  0000000a Before first symbol
   a:   a3 3c 43 2d c0            mov    %eax,0xc02d433c
Code;  0000000f Before first symbol
   f:   a1 08 0f 34 c0            mov    0xc0340f08,%eax

Mar  7 18:19:59 kaeding kernel:  <1>Unable to handle kernel paging request
at virtual address fd5c6a88
Mar  7 18:19:59 kaeding kernel: c01411e1
Mar  7 18:19:59 kaeding kernel: *pde = 00000000
Mar  7 18:19:59 kaeding kernel: Oops: 0002
Mar  7 18:19:59 kaeding kernel: CPU:    0
Mar  7 18:19:59 kaeding kernel: EIP:    0010:[__mark_inode_dirty+93/132]
Tainted: P
Mar  7 18:19:59 kaeding kernel: EFLAGS: 00010202
Mar  7 18:19:59 kaeding kernel: eax: c8208048   ebx: ca2542a0   ecx:
fd5c6a88   edx: ca2542a8
Mar  7 18:19:59 kaeding kernel: esi: cfb8a000   edi: 00000001   ebp:
000003e1   esp: cedcdf20
Mar  7 18:19:59 kaeding kernel: ds: 0018   es: 0018   ss: 0018
Mar  7 18:19:59 kaeding kernel: Process ices (pid: 21978,
stackpage=cedcd000)
Mar  7 18:19:59 kaeding kernel: Stack: 3e69291f 00000400 ca254350 c0142683
ca2542a0 00000001 00000400 c0124523
Mar  7 18:19:59 kaeding kernel:        ca2542a0 00000000 c1504be0 00000000
bfffe7dc 00001000 00000001 00000000
Mar  7 18:19:59 kaeding kernel:        00000400 ca2542a0 c0124854 c1504be0
c1504c00 cedcdf8c c012474c 00000000
Mar  7 18:19:59 kaeding kernel: Call Trace:    [update_atime+75/80]
[do_generic_file_read+1015/1028] [generic_file_read+124/272]
[file_read_actor+0/140] [sys_read+143/232]
Mar  7 18:19:59 kaeding kernel: Code: 89 01 c7 43 08 00 00 00 00 c7 42 04
00 00 00 00 8b 46 60 89


>>eax; c8208048 <_end+7ea06ec/104d76a4>
>>ebx; ca2542a0 <_end+9eec944/104d76a4>
>>edx; ca2542a8 <_end+9eec94c/104d76a4>
>>esi; cfb8a000 <_end+f8226a4/104d76a4>
>>esp; cedcdf20 <_end+ea665c4/104d76a4>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   89 01                     mov    %eax,(%ecx)
Code;  00000002 Before first symbol
   2:   c7 43 08 00 00 00 00      movl   $0x0,0x8(%ebx)
Code;  00000009 Before first symbol
   9:   c7 42 04 00 00 00 00      movl   $0x0,0x4(%edx)
Code;  00000010 Before first symbol
  10:   8b 46 60                  mov    0x60(%esi),%eax
Code;  00000013 Before first symbol
  13:   89 00                     mov    %eax,(%eax)

Mar  7 18:20:18 kaeding kernel:  <1>Unable to handle kernel paging request
at virtual address 15a013c4
Mar  7 18:20:18 kaeding kernel: c0128aa3
Mar  7 18:20:18 kaeding kernel: *pde = 00000000
Mar  7 18:20:18 kaeding kernel: Oops: 0000
Mar  7 18:20:18 kaeding kernel: CPU:    0
Mar  7 18:20:18 kaeding kernel: EIP:    0010:[kmem_cache_alloc+131/212]
Tainted: P
Mar  7 18:20:18 kaeding kernel: EFLAGS: 00010803
Mar  7 18:20:18 kaeding kernel: eax: 551cec83   ebx: 6060b620   ecx:
c12c61a0   edx: cffc0000
Mar  7 18:20:18 kaeding kernel: esi: c12c61a0   edi: 00000246   ebp:
000001f0   esp: c1373dd8
Mar  7 18:20:18 kaeding kernel: ds: 0018   es: 0018   ss: 0018
Mar  7 18:20:18 kaeding kernel: Process bash (pid: 22063,
stackpage=c1373000)
Mar  7 18:20:18 kaeding kernel: Stack: 00000000 cffcf680 cffcf680 cffe9800
c01420a0 c12c61a0 000001f0 00000000
Mar  7 18:20:18 kaeding kernel:        cffcf680 00001010 cffe9800 c0142396
cffe9800 00001010 cffcf680 00000000
Mar  7 18:20:18 kaeding kernel:        00000000 c12cd8a0 c88b6982 c12cd8f2
c12cf400 c014c08d cffe9800 00001010
Mar  7 18:20:18 kaeding kernel: Call Trace:    [get_new_inode+28/376]
[iget4+202/220] [proc_get_inode+65/280] [proc_lookup+117/156]
[proc_root_lookup+43/72]
Mar  7 18:20:18 kaeding kernel: Code: 8b 44 81 18 89 41 14 83 f8 ff 75 23
8b 41 04 8b 11 89 42 04


>>ecx; c12c61a0 <_end+f5e844/104d76a4>
>>edx; cffc0000 <_end+fc586a4/104d76a4>
>>esi; c12c61a0 <_end+f5e844/104d76a4>
>>esp; c1373dd8 <_end+100c47c/104d76a4>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 44 81 18               mov    0x18(%ecx,%eax,4),%eax
Code;  00000004 Before first symbol
   4:   89 41 14                  mov    %eax,0x14(%ecx)
Code;  00000007 Before first symbol
   7:   83 f8 ff                  cmp    $0xffffffff,%eax
Code;  0000000a Before first symbol
   a:   75 23                     jne    2f <_EIP+0x2f> 0000002f Before
first symbol
Code;  0000000c Before first symbol
   c:   8b 41 04                  mov    0x4(%ecx),%eax
Code;  0000000f Before first symbol
   f:   8b 11                     mov    (%ecx),%edx
Code;  00000011 Before first symbol
  11:   89 42 04                  mov    %eax,0x4(%edx)

Mar  7 18:20:21 kaeding kernel:  <1>Unable to handle kernel paging request
at virtual address 15a013c4
Mar  7 18:20:21 kaeding kernel: c0128aa3
Mar  7 18:20:21 kaeding kernel: *pde = 00000000
Mar  7 18:20:21 kaeding kernel: Oops: 0000
Mar  7 18:20:21 kaeding kernel: CPU:    0
Mar  7 18:20:21 kaeding kernel: EIP:    0010:[kmem_cache_alloc+131/212]
Tainted: P
Mar  7 18:20:21 kaeding kernel: EFLAGS: 00010803
Mar  7 18:20:21 kaeding kernel: eax: 551cec83   ebx: 6060b620   ecx:
c12c61a0   edx: c0364f40
Mar  7 18:20:21 kaeding kernel: esi: c12c61a0   edi: 00000246   ebp:
000001f0   esp: c1373f1c
Mar  7 18:20:21 kaeding kernel: ds: 0018   es: 0018   ss: 0018
Mar  7 18:20:21 kaeding kernel: Process login (pid: 22064,
stackpage=c1373000)
Mar  7 18:20:21 kaeding kernel: Stack: 00000001 00000004 c0364f40 00000001
c0142005 c12c61a0 000001f0 00000001
Mar  7 18:20:21 kaeding kernel:        c023066a 00000001 c0230f35 00000001
00000000 401927a0 bfffd99c c01176e8
Mar  7 18:20:21 kaeding kernel:        00000000 c1373fa0 00000000 c1373fa8
00000206 05c133d1 c1372000 c0230fa5
Mar  7 18:20:21 kaeding kernel: Call Trace:    [get_empty_inode+17/144]
[sock_alloc+6/176] [sock_create+173/256] [do_getitimer+156/164]
[sys_socket+29/80]
Mar  7 18:20:21 kaeding kernel: Code: 8b 44 81 18 89 41 14 83 f8 ff 75 23
8b 41 04 8b 11 89 42 04


>>ecx; c12c61a0 <_end+f5e844/104d76a4>
>>edx; c0364f40 <net_families+0/80>
>>esi; c12c61a0 <_end+f5e844/104d76a4>
>>esp; c1373f1c <_end+100c5c0/104d76a4>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 44 81 18               mov    0x18(%ecx,%eax,4),%eax
Code;  00000004 Before first symbol
   4:   89 41 14                  mov    %eax,0x14(%ecx)
Code;  00000007 Before first symbol
   7:   83 f8 ff                  cmp    $0xffffffff,%eax
Code;  0000000a Before first symbol
   a:   75 23                     jne    2f <_EIP+0x2f> 0000002f Before
first symbol
Code;  0000000c Before first symbol
   c:   8b 41 04                  mov    0x4(%ecx),%eax
Code;  0000000f Before first symbol
   f:   8b 11                     mov    (%ecx),%edx
Code;  00000011 Before first symbol
  11:   89 42 04                  mov    %eax,0x4(%edx)

Mar  7 18:20:24 kaeding kernel:  <1>Unable to handle kernel paging request
at virtual address 15a013c4
Mar  7 18:20:24 kaeding kernel: c0128aa3
Mar  7 18:20:24 kaeding kernel: *pde = 00000000
Mar  7 18:20:24 kaeding kernel: Oops: 0000
Mar  7 18:20:24 kaeding kernel: CPU:    0
Mar  7 18:20:24 kaeding kernel: EIP:    0010:[kmem_cache_alloc+131/212]
Tainted: P
Mar  7 18:20:24 kaeding kernel: EFLAGS: 00010803
Mar  7 18:20:24 kaeding kernel: eax: 551cec83   ebx: 6060b620   ecx:
c12c61a0   edx: c0364f40
Mar  7 18:20:24 kaeding kernel: esi: c12c61a0   edi: 00000246   ebp:
000001f0   esp: c1373f1c
Mar  7 18:20:24 kaeding kernel: ds: 0018   es: 0018   ss: 0018
Mar  7 18:20:24 kaeding kernel: Process login (pid: 22065,
stackpage=c1373000)
Mar  7 18:20:24 kaeding kernel: Stack: 00000001 00000004 c0364f40 00000001
c0142005 c12c61a0 000001f0 00000001
Mar  7 18:20:24 kaeding kernel:        c023066a 00000001 c0230f35 00000001
00000000 401927a0 bfffd99c c01176e8
Mar  7 18:20:24 kaeding kernel:        00000000 c1373fa0 00000000 c1373fa8
00000206 05c134de c1372000 c0230fa5
Mar  7 18:20:24 kaeding kernel: Call Trace:    [get_empty_inode+17/144]
[sock_alloc+6/176] [sock_create+173/256] [do_getitimer+156/164]
[sys_socket+29/80]
Mar  7 18:20:24 kaeding kernel: Code: 8b 44 81 18 89 41 14 83 f8 ff 75 23
8b 41 04 8b 11 89 42 04


>>ecx; c12c61a0 <_end+f5e844/104d76a4>
>>edx; c0364f40 <net_families+0/80>
>>esi; c12c61a0 <_end+f5e844/104d76a4>
>>esp; c1373f1c <_end+100c5c0/104d76a4>

Code;  00000000 Before first symbol
Code;  00000000 Before first symbol
   0:   8b 44 81 18               mov    0x18(%ecx,%eax,4),%eax
Code;  00000004 Before first symbol
   4:   89 41 14                  mov    %eax,0x14(%ecx)
Code;  00000007 Before first symbol
   7:   83 f8 ff                  cmp    $0xffffffff,%eax
Code;  0000000a Before first symbol
   a:   75 23                     jne    2f <_EIP+0x2f> 0000002f Before
first symbol
Code;  0000000c Before first symbol
   c:   8b 41 04                  mov    0x4(%ecx),%eax
Code;  0000000f Before first symbol
   f:   8b 11                     mov    (%ecx),%edx
Code;  00000011 Before first symbol
  11:   89 42 04                  mov    %eax,0x4(%edx)

Mar  7 18:20:27 kaeding kernel:  <1>Unable to handle kernel paging request
at virtual address 15a013c4
Mar  7 18:20:27 kaeding kernel: c0128aa3
Mar  7 18:20:27 kaeding kernel: *pde = 00000000
Mar  7 18:20:27 kaeding kernel: Oops: 0000
Mar  7 18:20:27 kaeding kernel: CPU:    0
Mar  7 18:20:27 kaeding kernel: EIP:    0010:[kmem_cache_alloc+131/212]
Tainted: P
Mar  7 18:20:27 kaeding kernel: EFLAGS: 00010803
Mar  7 18:20:27 kaeding kernel: eax: 551cec83   ebx: 6060b620   ecx:
c12c61a0   edx: c0364f40
Mar  7 18:20:27 kaeding kernel: esi: c12c61a0   edi: 00000246   ebp:
000001f0   esp: c8309f1c
Mar  7 18:20:27 kaeding kernel: ds: 0018   es: 0018   ss: 0018
Mar  7 18:20:27 kaeding kernel: Process login (pid: 514,
stackpage=c8309000)
Mar  7 18:20:27 kaeding kernel: Stack: 00000001 00000004 c0364f40 00000001
c0142005 c12c61a0 000001f0 00000001
Mar  7 18:20:27 kaeding kernel:        c023066a 00000001 c0230f35 00000001
00000000 401927a0 bfffd99c c01176e8
Mar  7 18:20:27 kaeding kernel:        00000000 c8309fa0 00000000 c8309fa8
00000202 05c13664 c8308000 c0230fa5
Mar  7 18:20:27 kaeding kernel: Call Trace:    [get_empty_inode+17/144]
[sock_alloc+6/176] [sock_create+173/256] [do_getitimer+156/164]
[sys_socket+29/80]
Mar  7 18:20:27 kaeding kernel: Code: 8b 44 81 18 89 41 14 83 f8 ff 75 23
8b 41 04 8b 11 89 42 04


>>ecx; c12c61a0 <_end+f5e844/104d76a4>
>>edx; c0364f40 <net_families+0/80>
>>esi; c12c61a0 <_end+f5e844/104d76a4>
>>esp; c8309f1c <_end+7fa25c0/104d76a4>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 44 81 18               mov    0x18(%ecx,%eax,4),%eax
Code;  00000004 Before first symbol
   4:   89 41 14                  mov    %eax,0x14(%ecx)
Code;  00000007 Before first symbol
   7:   83 f8 ff                  cmp    $0xffffffff,%eax
Code;  0000000a Before first symbol
   a:   75 23                     jne    2f <_EIP+0x2f> 0000002f Before
first symbol
Code;  0000000c Before first symbol
   c:   8b 41 04                  mov    0x4(%ecx),%eax
Code;  0000000f Before first symbol
   f:   8b 11                     mov    (%ecx),%edx
Code;  00000011 Before first symbol
  11:   89 42 04                  mov    %eax,0x4(%edx)

Mar  7 18:20:35 kaeding kernel:  <1>Unable to handle kernel paging request
at virtual address 15a013c4
Mar  7 18:20:35 kaeding kernel: c0128aa3
Mar  7 18:20:35 kaeding kernel: *pde = 00000000
Mar  7 18:20:35 kaeding kernel: Oops: 0000
Mar  7 18:20:35 kaeding kernel: CPU:    0
Mar  7 18:20:35 kaeding kernel: EIP:    0010:[kmem_cache_alloc+131/212]
Tainted: P
Mar  7 18:20:35 kaeding kernel: EFLAGS: 00010803
Mar  7 18:20:35 kaeding kernel: eax: 551cec83   ebx: 6060b620   ecx:
c12c61a0   edx: cffc0000
Mar  7 18:20:35 kaeding kernel: esi: c12c61a0   edi: 00000246   ebp:
000001f0   esp: c8a37e68
Mar  7 18:20:35 kaeding kernel: ds: 0018   es: 0018   ss: 0018
Mar  7 18:20:35 kaeding kernel: Process qmgr (pid: 354,
stackpage=c8a37000)
Mar  7 18:20:35 kaeding kernel: Stack: 00000000 cffc4850 cffc4850 c12e6c00
c01420a0 c12c61a0 000001f0 00000000
Mar  7 18:20:35 kaeding kernel:        cffc4850 00003d84 c12e6c00 c0142396
c12e6c00 00003d84 cffc4850 00000000
Mar  7 18:20:35 kaeding kernel:        00000000 00003d84 c88b6a20 c88b6a20
c88b67a0 c01576aa c12e6c00 00003d84
Mar  7 18:20:35 kaeding kernel: Call Trace:    [get_new_inode+28/376]
[iget4+202/220] [ext3_lookup+86/124] [real_lookup+83/196]
[link_path_walk+1487/2132]
Mar  7 18:20:35 kaeding kernel: Code: 8b 44 81 18 89 41 14 83 f8 ff 75 23
8b 41 04 8b 11 89 42 04


>>ecx; c12c61a0 <_end+f5e844/104d76a4>
>>edx; cffc0000 <_end+fc586a4/104d76a4>
>>esi; c12c61a0 <_end+f5e844/104d76a4>
>>esp; c8a37e68 <_end+86d050c/104d76a4>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 44 81 18               mov    0x18(%ecx,%eax,4),%eax
Code;  00000004 Before first symbol
   4:   89 41 14                  mov    %eax,0x14(%ecx)
Code;  00000007 Before first symbol
   7:   83 f8 ff                  cmp    $0xffffffff,%eax
Code;  0000000a Before first symbol
   a:   75 23                     jne    2f <_EIP+0x2f> 0000002f Before
first symbol
Code;  0000000c Before first symbol
   c:   8b 41 04                  mov    0x4(%ecx),%eax
Code;  0000000f Before first symbol
   f:   8b 11                     mov    (%ecx),%edx
Code;  00000011 Before first symbol
  11:   89 42 04                  mov    %eax,0x4(%edx)

Mar  7 18:20:44 kaeding kernel:  <1>Unable to handle kernel paging request
at virtual address 15a013c4
Mar  7 18:20:44 kaeding kernel: c0128aa3
Mar  7 18:20:44 kaeding kernel: *pde = 00000000
Mar  7 18:20:44 kaeding kernel: Oops: 0000
Mar  7 18:20:44 kaeding kernel: CPU:    0
Mar  7 18:20:44 kaeding kernel: EIP:    0010:[kmem_cache_alloc+131/212]
Tainted: P
Mar  7 18:20:44 kaeding kernel: EFLAGS: 00010803
Mar  7 18:20:44 kaeding kernel: eax: 551cec83   ebx: 6060b620   ecx:
c12c61a0   edx: cffc0000
Mar  7 18:20:44 kaeding kernel: esi: c12c61a0   edi: 00000246   ebp:
000001f0   esp: c8545eb0
Mar  7 18:20:44 kaeding kernel: ds: 0018   es: 0018   ss: 0018
Mar  7 18:20:44 kaeding kernel: Process cupsd (pid: 415,
stackpage=c8545000)
Mar  7 18:20:44 kaeding kernel: Stack: 00000000 cffd26f8 cffd26f8 c12e6c00
c01420a0 c12c61a0 000001f0 00000000
Mar  7 18:20:44 kaeding kernel:        cffd26f8 0002d94e c12e6c00 c0142396
c12e6c00 0002d94e cffd26f8 00000000
Mar  7 18:20:44 kaeding kernel:        00000000 0002d94e c88b66a0 c88b66a0
c8aa4d40 c01576aa c12e6c00 0002d94e
Mar  7 18:20:44 kaeding kernel: Call Trace:    [get_new_inode+28/376]
[iget4+202/220] [ext3_lookup+86/124] [real_lookup+83/196]
[link_path_walk+622/2132]
Mar  7 18:20:44 kaeding kernel: Code: 8b 44 81 18 89 41 14 83 f8 ff 75 23
8b 41 04 8b 11 89 42 04


>>ecx; c12c61a0 <_end+f5e844/104d76a4>
>>edx; cffc0000 <_end+fc586a4/104d76a4>
>>esi; c12c61a0 <_end+f5e844/104d76a4>
>>esp; c8545eb0 <_end+81de554/104d76a4>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 44 81 18               mov    0x18(%ecx,%eax,4),%eax
Code;  00000004 Before first symbol
   4:   89 41 14                  mov    %eax,0x14(%ecx)
Code;  00000007 Before first symbol
   7:   83 f8 ff                  cmp    $0xffffffff,%eax
Code;  0000000a Before first symbol
   a:   75 23                     jne    2f <_EIP+0x2f> 0000002f Before
first symbol
Code;  0000000c Before first symbol
   c:   8b 41 04                  mov    0x4(%ecx),%eax
Code;  0000000f Before first symbol
   f:   8b 11                     mov    (%ecx),%edx
Code;  00000011 Before first symbol
  11:   89 42 04                  mov    %eax,0x4(%edx)

Mar  7 18:22:18 kaeding kernel: cpu: 0, clocks: 1009891, slice: 504945
Mar  7 18:22:18 kaeding kernel: ds: no socket drivers loaded!
Mar  7 18:22:34 kaeding kernel: ac97_codec: AC97  codec, id: AKM0(Asahi
Kasei AK4540)
Mar  7 18:22:37 kaeding kernel: 3c59x: Donald Becker and others.
www.scyld.com/network/vortex.html

end ------------------------------------------------------------------


