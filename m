Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263435AbRFXBkr>; Sat, 23 Jun 2001 21:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265696AbRFXBki>; Sat, 23 Jun 2001 21:40:38 -0400
Received: from mtiwmhc21.worldnet.att.net ([204.127.131.46]:55217 "EHLO
	mtiwmhc21.worldnet.att.net") by vger.kernel.org with ESMTP
	id <S263435AbRFXBkY>; Sat, 23 Jun 2001 21:40:24 -0400
Date: Sat, 23 Jun 2001 21:40:14 -0400
From: khromy <khromy@khromy.ath.cx>
To: linux-kernel@vger.kernel.org
Subject: [OOPS] linux-2.4.6-pre5aa1
Message-ID: <20010623214014.A79307@khromy.lnuxlab.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following oops about 41 minutes after booting into
linux-2.4.6-pre5aa1.  I noticed a lot of programs that were running were
segfaulting so I checked 'dmesg' and found the oops.. I'm now running
linux-2.4.6-pre5aa1 but this time with a more stable compiler(2.95.4) and
havn't had any problems yet.

ver_linux:
Linux vingeren.girl 2.4.6-pre5aa1 #13 Sat Jun 23 19:03:35 EDT 2001 i686 unknown
 
Gnu C                  3.0
Gnu make               3.79.1
binutils               2.11.90.0.7
util-linux             2.11d
mount                  2.11d
modutils               2.4.6
e2fsprogs              1.22
reiserfsprogs          3.x.0
Linux C Library        2.2.3
Dynamic linker (ldd)   2.2.3
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         i2c-piix4 gl518sm sensors i2c-core sr_mod isofs sd_mod
ide-scsi ide-cd cdrom ipt_limit ipt_MASQUERADE ipt_REJECT ipt_state iptable_nat
iptable_filter ip_tables ip_conntrack reiserfs ad1848 sound soundcore imm
scsi_mod parport_pc parport bsd_comp ppp_deflate ppp_async ppp_generic slhc
3c59x tdfx


Jun 23 00:51:26 devel kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000004
Jun 23 00:51:26 devel kernel:  printing eip:
Jun 23 00:51:26 devel kernel: c0134321
Jun 23 00:51:26 devel kernel: *pde = 00000000
Jun 23 00:51:26 devel kernel: Oops: 0002
Jun 23 00:51:26 devel kernel: CPU:    0
Jun 23 00:51:26 devel kernel: EIP:    0010:[__remove_inode_queue+17/32]
Jun 23 00:51:26 devel kernel: EFLAGS: 00010206
Jun 23 00:51:26 devel kernel: eax: 00000000   ebx: c3135900   ecx: 00000017   edx: 00000000
Jun 23 00:51:26 devel kernel: esi: c3135a20   edi: c3135a20   ebp: c12d5dd4   esp: c4eb1c70
Jun 23 00:51:26 devel kernel: ds: 0018   es: 0018   ss: 0018
Jun 23 00:51:26 devel kernel: Process gimp (pid: 1557, stackpage=c4eb1000)
Jun 23 00:51:26 devel kernel: Stack: c0136c0d c3135900 00000001 c01f51f0 00000000 c10cb3a8 00000000 c3135a20 
Jun 23 00:51:26 devel kernel:        00000000 c10b8730 00000000 c012c0e4 c10b8730 00000000 00000000 00000110 
Jun 23 00:51:26 devel kernel:        00000a84 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
Jun 23 00:51:26 devel kernel: Call Trace: [try_to_free_buffers+157/352] [page_launder+1476/2560] [refill_freelist+34/80] [getblk+195/272] [ext2_alloc_branch+148/544] [ext2_get_branch+101/224] [ext2_get_block+374/1168] 
Jun 23 00:51:26 devel kernel:        [handle_IRQ_event+58/128] [reclaim_page+1006/1152] [__alloc_pages_limit+69/160] [__alloc_pages+144/688] [__block_prepare_write+369/624] [add_to_page_cache_unique+168/176] [block_prepare_write+33/64] [ext2_get_block+0/1168] 
Jun 23 00:51:26 devel kernel:        [generic_file_write+1040/1728] [ext2_get_block+0/1168] [sys_write+176/208] [schedule+503/1024] [system_call+51/56] 
Jun 23 00:51:26 devel kernel: 
Jun 23 00:51:26 devel kernel: Code: 89 50 04 89 02 c3 89 f6 8d bc 27 00 00 00 00 8b 54 24 04 31 
Jun 23 00:52:07 devel kernel: Unable to handle kernel paging request at virtual address eeee9b9b
Jun 23 00:52:07 devel kernel:  printing eip:
Jun 23 00:52:07 devel kernel: c012bbeb
Jun 23 00:52:07 devel kernel: *pde = 00000000
Jun 23 00:52:07 devel kernel: Oops: 0002
Jun 23 00:52:07 devel kernel: CPU:    0
Jun 23 00:52:07 devel kernel: EIP:    0010:[page_launder+203/2560]
Jun 23 00:52:07 devel kernel: EFLAGS: 00010202
Jun 23 00:52:07 devel kernel: eax: eeee9b9b   ebx: c4eb1cd4   ecx: 00000000   edx: c12eff80
Jun 23 00:52:07 devel kernel: esi: c4eb1cd4   edi: c4eb1cb8   ebp: 00000000   esp: c12eff54
Jun 23 00:52:07 devel kernel: ds: 0018   es: 0018   ss: 0018
Jun 23 00:52:07 devel kernel: Process kswapd (pid: 4, stackpage=c12ef000)
Jun 23 00:52:07 devel kernel: Stack: 00000000 00000000 00000ba9 00000000 00000000 00000000 00000000 00000000 
Jun 23 00:52:07 devel kernel:        00000000 00000000 00000000 c4eb1cd4 eeee9b9b 00000000 00000000 00000000 
Jun 23 00:52:07 devel kernel:        00000000 00000000 00000000 c12178ec 00000040 00000000 00000000 0008e000 
Jun 23 00:52:07 devel kernel: Call Trace: [do_try_to_free_pages+25/96] [kswapd+86/256] [prepare_namespace+0/16] [prepare_namespace+0/16] [kernel_thread+38/48] [kswapd+0/256] 
Jun 23 00:52:07 devel kernel: 
Jun 23 00:52:07 devel kernel: Code: 89 10 8b 44 24 0c 85 c0 74 0b 8b 1c 24 85 db 0f 88 06 09 00 
Jun 23 00:52:08 devel kernel: VM: page_launder, wrong page on list.
Jun 23 00:52:08 devel kernel: Unable to handle kernel paging request at virtual address 616a6198
Jun 23 00:52:08 devel kernel:  printing eip:
Jun 23 00:52:08 devel kernel: c012c4fe
Jun 23 00:52:08 devel kernel: *pde = 00000000
Jun 23 00:52:08 devel kernel: Oops: 0002
Jun 23 00:52:08 devel kernel: CPU:    0
Jun 23 00:52:08 devel kernel: EIP:    0010:[page_launder+2526/2560]
Jun 23 00:52:08 devel kernel: EFLAGS: 00010206
Jun 23 00:52:08 devel kernel: eax: 616a6190   ebx: c4eb1cd4   ecx: 00000009   edx: c935bde0
Jun 23 00:52:08 devel kernel: esi: c4eb1cd4   edi: c4eb1cb8   ebp: 00000000   esp: c935bdb4
Jun 23 00:52:08 devel kernel: ds: 0018   es: 0018   ss: 0018
Jun 23 00:52:08 devel kernel: Process gimp (pid: 1718, stackpage=c935b000)
Jun 23 00:52:08 devel kernel: Stack: 00000000 00000000 00000bac 00000000 00000000 00000000 00000000 00000000 
Jun 23 00:52:08 devel kernel:        00000000 00000000 00000000 c11bf03c c12eff80 00000000 00000000 00000000 
Jun 23 00:52:08 devel kernel:        00000000 00000000 00000000 c935a000 00000052 00000000 00000000 00000052 
Jun 23 00:52:08 devel kernel: Call Trace: [do_try_to_free_pages+25/96] [try_to_free_pages+40/64] [__alloc_pages+546/688] [do_anonymous_page+82/224] [do_no_page+218/224] [handle_mm_fault+206/224] [send_signal+45/240] 
Jun 23 00:52:08 devel kernel:        [do_page_fault+802/1216] [do_serial_bh+29/32] [do_brk+178/368] [sys_brk+222/240] [do_page_fault+0/1216] [error_code+56/64] 
Jun 23 00:52:08 devel kernel: 
Jun 23 00:52:08 devel kernel: Code: ff 48 08 e9 9a f6 ff ff 8b 0d 1c 55 24 c0 85 c9 0f 84 ec f6 
Jun 23 00:52:34 devel kernel: Unable to handle kernel paging request at virtual address 32cc8181
Jun 23 00:52:34 devel kernel:  printing eip:
Jun 23 00:52:34 devel kernel: c012bbeb
Jun 23 00:52:34 devel kernel: *pde = 00000000
Jun 23 00:52:34 devel kernel: Oops: 0002
Jun 23 00:52:34 devel kernel: CPU:    0
Jun 23 00:52:34 devel kernel: EIP:    0010:[page_launder+203/2560]
Jun 23 00:52:34 devel kernel: EFLAGS: 00010202
Jun 23 00:52:34 devel kernel: eax: 32cc8181   ebx: c935bde0   ecx: 00000000   edx: c4d37e98
Jun 23 00:52:34 devel kernel: esi: c935bde0   edi: c935bdc4   ebp: 00000000   esp: c4d37e6c
Jun 23 00:52:34 devel kernel: ds: 0018   es: 0018   ss: 0018
Jun 23 00:52:34 devel kernel: Process gimp (pid: 1747, stackpage=c4d37000)
Jun 23 00:52:34 devel kernel: Stack: 00000000 00000000 00000bc3 00000000 00000000 00000000 00000000 00000000 
Jun 23 00:52:34 devel kernel:        00000000 00000000 00000000 c935bde0 32cc8181 00000000 00000000 00000000 
Jun 23 00:52:34 devel kernel:        00000000 00000000 00000000 c4d36000 00000052 00000000 00000000 00000052 
Jun 23 00:52:34 devel kernel: Call Trace: [do_try_to_free_pages+25/96] [try_to_free_pages+40/64] [__alloc_pages+546/688] [generic_file_write+1553/1728] [sys_write+176/208] [sys_poll+501/848] [sys_gettimeofday+34/208] 
Jun 23 00:52:34 devel kernel:        [system_call+51/56] 
Jun 23 00:52:34 devel kernel: 
Jun 23 00:52:34 devel kernel: Code: 89 10 8b 44 24 0c 85 c0 74 0b 8b 1c 24 85 db 0f 88 06 09 00 
Jun 23 00:54:29 devel kernel: Unable to handle kernel paging request at virtual address 97979696
Jun 23 00:54:29 devel kernel:  printing eip:
Jun 23 00:54:29 devel kernel: c012bbeb
Jun 23 00:54:29 devel kernel: *pde = 00000000
Jun 23 00:54:29 devel kernel: Oops: 0002
Jun 23 00:54:29 devel kernel: CPU:    0
Jun 23 00:54:29 devel kernel: EIP:    0010:[page_launder+203/2560]
Jun 23 00:54:29 devel kernel: EFLAGS: 00010202
Jun 23 00:54:29 devel kernel: eax: 97979696   ebx: c935bde0   ecx: 00000000   edx: c5d97cd4
Jun 23 00:54:29 devel kernel: esi: c935bde0   edi: c935bdc4   ebp: 00000000   esp: c5d97ca8
Jun 23 00:54:29 devel kernel: ds: 0018   es: 0018   ss: 0018
Jun 23 00:54:29 devel kernel: Process gimp (pid: 1772, stackpage=c5d97000)
Jun 23 00:54:29 devel kernel: Stack: 00000000 00000000 00000c24 00000000 00000000 00000000 00000000 00000000 
Jun 23 00:54:29 devel kernel:        00000000 00000000 00000000 c935bde0 97979696 00000000 00000000 00000000 
Jun 23 00:54:29 devel kernel:        00000000 00000000 00000000 00005c00 00000400 00000007 00002102 00034596 
Jun 23 00:54:29 devel kernel: Call Trace: [refill_freelist+34/80] [getblk+195/272] [ext2_alloc_branch+148/544] [ext2_get_block+374/1168] [__block_commit_write+115/224] [generic_commit_write+51/96] [ext2_commit_chunk+51/96] 
Jun 23 00:54:29 devel kernel:        [create_empty_buffers+25/112] [__block_prepare_write+369/624] [add_to_page_cache_unique+168/176] [block_prepare_write+33/64] [ext2_get_block+0/1168] [generic_file_write+1040/1728] [ext2_get_block+0/1168] [sys_write+176/208] 
Jun 23 00:54:29 devel kernel:        [schedule+503/1024] [system_call+51/56] 
Jun 23 00:54:29 devel kernel: 
Jun 23 00:54:29 devel kernel: Code: 89 10 8b 44 24 0c 85 c0 74 0b 8b 1c 24 85 db 0f 88 06 09 00 
Jun 23 00:57:59 devel kernel: Unable to handle kernel paging request at virtual address 31632942
Jun 23 00:57:59 devel kernel:  printing eip:
Jun 23 00:57:59 devel kernel: c012bbeb
Jun 23 00:57:59 devel kernel: *pde = 00000000
Jun 23 00:57:59 devel kernel: Oops: 0002
Jun 23 00:57:59 devel kernel: CPU:    0
Jun 23 00:57:59 devel kernel: EIP:    0010:[page_launder+203/2560]
Jun 23 00:57:59 devel kernel: EFLAGS: 00010202
Jun 23 00:57:59 devel kernel: eax: 31632942   ebx: c935bde0   ecx: 00000000   edx: c3203de0
Jun 23 00:57:59 devel kernel: esi: c935bde0   edi: c935bdc4   ebp: 00000000   esp: c3203db4
Jun 23 00:57:59 devel kernel: ds: 0018   es: 0018   ss: 0018
Jun 23 00:57:59 devel kernel: Process gimp (pid: 1803, stackpage=c3203000)
Jun 23 00:57:59 devel kernel: Stack: 00000000 00000000 00000cd6 00000000 00000000 00000000 00000000 00000000 
Jun 23 00:57:59 devel kernel:        00000000 00000000 00000000 c935bde0 31632942 00000000 00000000 00000000 
Jun 23 00:57:59 devel kernel:        00000000 00000000 00000000 c3202000 00000052 00000000 00000000 00000052 
Jun 23 00:57:59 devel kernel: Call Trace: [do_try_to_free_pages+25/96] [try_to_free_pages+40/64] [__alloc_pages+546/688] [do_anonymous_page+82/224] [do_no_page+218/224] [handle_mm_fault+206/224] [send_signal+45/240] 
Jun 23 00:57:59 devel kernel:        [do_page_fault+802/1216] [do_brk+178/368] [sys_brk+222/240] [do_page_fault+0/1216] [error_code+56/64] 
Jun 23 00:57:59 devel kernel: 
Jun 23 00:57:59 devel kernel: Code: 89 10 8b 44 24 0c 85 c0 74 0b 8b 1c 24 85 db 0f 88 06 09 00 
Jun 23 01:29:23 devel kernel: Unable to handle kernel paging request at virtual address fffffefe
Jun 23 01:29:23 devel kernel:  printing eip:
Jun 23 01:29:23 devel kernel: c012bbeb
Jun 23 01:29:23 devel kernel: *pde = 00001063
Jun 23 01:29:23 devel kernel: *pte = 00000000
Jun 23 01:29:23 devel kernel: Oops: 0002
Jun 23 01:29:23 devel kernel: CPU:    0
Jun 23 01:29:23 devel kernel: EIP:    0010:[page_launder+203/2560]
Jun 23 01:29:23 devel kernel: EFLAGS: 00010202
Jun 23 01:29:23 devel kernel: eax: fffffefe   ebx: c935bde0   ecx: 00000000   edx: c8687d14
Jun 23 01:29:23 devel kernel: esi: c935bde0   edi: c935bdc4   ebp: 00000000   esp: c8687ce8
Jun 23 01:29:23 devel kernel: ds: 0018   es: 0018   ss: 0018
Jun 23 01:29:23 devel kernel: Process gaim (pid: 341, stackpage=c8687000)
Jun 23 01:29:23 devel kernel: Stack: 00000000 00000000 00001287 00000000 00000000 00000000 00000000 00000000 
Jun 23 01:29:23 devel kernel:        00000000 00000000 00000000 c935bde0 fffffefe 00000000 00000000 00000000 
Jun 23 01:29:23 devel kernel:        00000000 00000000 00000000 00012400 00000400 00000007 00002102 00358015 
Jun 23 01:29:23 devel kernel: Call Trace: [refill_freelist+34/80] [getblk+195/272] [bread+24/112] [add_to_page_cache_unique+168/176] [__lock_page+136/144] [ext2_read_inode+224/1024] [get_new_inode+330/336] 
Jun 23 01:29:23 devel kernel:        [iget4+194/208] [ext2_lookup+62/112] [real_lookup+163/208] [path_walk+953/2416] [sock_recvmsg+49/176] [open_namei+530/1440] [dentry_open+225/384] [__user_walk+64/96] 
Jun 23 01:29:23 devel kernel:        [sys_stat64+19/112] [system_call+51/56] 
Jun 23 01:29:23 devel kernel: 
Jun 23 01:29:23 devel kernel: Code: 89 10 8b 44 24 0c 85 c0 74 0b 8b 1c 24 85 db 0f 88 06 09 00 
Jun 23 01:29:36 devel kernel: Unable to handle kernel paging request at virtual address 97b6db6f
Jun 23 01:29:36 devel kernel:  printing eip:
Jun 23 01:29:36 devel kernel: c012bc3a
Jun 23 01:29:36 devel kernel: *pde = 00000000
Jun 23 01:29:36 devel kernel: Oops: 0002
Jun 23 01:29:36 devel kernel: CPU:    0
Jun 23 01:29:36 devel kernel: EIP:    0010:[page_launder+282/2560]
Jun 23 01:29:36 devel kernel: EFLAGS: 00010203
Jun 23 01:29:36 devel kernel: eax: 97b6db67   ebx: c935bde0   ecx: 00000000   edx: c3c8fbb4
Jun 23 01:29:36 devel kernel: esi: c935bde0   edi: c935bdc4   ebp: 00000000   esp: c3c8fb88
Jun 23 01:29:36 devel kernel: ds: 0018   es: 0018   ss: 0018
Jun 23 01:29:36 devel kernel: Process sawfish (pid: 2010, stackpage=c3c8f000)
Jun 23 01:29:36 devel kernel: Stack: 00000000 00000000 00001287 00000000 00000000 00000000 00000000 00000000 
Jun 23 01:29:36 devel kernel:        00000000 00000000 00000000 c11bf03c c8687d14 00000000 00000000 00000000 
Jun 23 01:29:36 devel kernel:        00000000 00000000 00000000 00016000 00000400 00000007 00002103 006a4032 
Jun 23 01:29:36 devel kernel: Call Trace: [refill_freelist+34/80] [getblk+195/272] [bread+24/112] [ext2_read_inode+224/1024] [get_new_inode+330/336] [iget4+194/208] [ext2_lookup+62/112] 
Jun 23 01:29:36 devel kernel:        [real_lookup+163/208] [path_walk+1977/2416] [open_exec+37/192] [do_execve+30/512] [cached_lookup+16/80] [path_walk+855/2416] [handle_mm_fault+158/224] [deliver_signal+85/96] 
Jun 23 01:29:36 devel kernel:        [send_sig_info+149/160] [do_page_fault+802/1216] [path_release+16/48] [sys_rt_sigaction+142/288] [getname+107/176] [sys_execve+55/96] [system_call+51/56] 
Jun 23 01:29:36 devel kernel: 
Jun 23 01:29:36 devel kernel: Code: ff 48 08 8b 47 18 83 e0 40 0f 84 cb 00 00 00 68 f1 01 00 00 
Jun 23 01:29:51 devel kernel: Unable to handle kernel paging request at virtual address 742f6800
Jun 23 01:29:51 devel kernel:  printing eip:
Jun 23 01:29:51 devel kernel: c012bbeb
Jun 23 01:29:51 devel kernel: *pde = 00000000
Jun 23 01:29:51 devel kernel: Oops: 0002
Jun 23 01:29:51 devel kernel: CPU:    0
Jun 23 01:29:51 devel kernel: EIP:    0010:[page_launder+203/2560]
Jun 23 01:29:51 devel kernel: EFLAGS: 00010202
Jun 23 01:29:51 devel kernel: eax: 742f6800   ebx: c8687d14   ecx: 00000000   edx: c14fddf4
Jun 23 01:29:51 devel kernel: esi: c8687d14   edi: c8687cf8   ebp: 00000000   esp: c14fddc8
Jun 23 01:29:51 devel kernel: ds: 0018   es: 0018   ss: 0018
Jun 23 01:29:51 devel kernel: Process ps (pid: 2019, stackpage=c14fd000)
Jun 23 01:29:51 devel kernel: Stack: 00000000 00000000 00001287 00000000 00000000 00000000 00000000 00000000 
Jun 23 01:29:51 devel kernel:        00000000 00000000 00000000 c8687d14 742f6800 00000000 00000000 00000000 
Jun 23 01:29:51 devel kernel:        00000000 00000000 00000000 c14fc000 00000052 00000000 00000000 00000052 
Jun 23 01:29:51 devel kernel: Call Trace: [do_try_to_free_pages+25/96] [try_to_free_pages+40/64]ee86

-- 
L1:	khromy		;khromy(at)khromy.lnuxlab.net
