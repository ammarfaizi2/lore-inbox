Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263250AbTE3EON (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 00:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263258AbTE3EON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 00:14:13 -0400
Received: from web14201.mail.yahoo.com ([216.136.172.143]:34124 "HELO
	web14201.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263250AbTE3EN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 00:13:58 -0400
Message-ID: <20030530042717.3097.qmail@web14201.mail.yahoo.com>
Date: Thu, 29 May 2003 21:27:17 -0700 (PDT)
From: Robert Kulagowski <rkulagow@rocketmail.com>
Subject: Kernel still oopsing (was: Kernel oops on Dell PowerEdge 600SC with 2.4.21-pre7)
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm still getting kernel oopses on this system.  I have no reason to believe
that this has anything to do with the hardware.  System is essentially the
same as it was in the previous message.

May 29 21:15:56 masterbackend kernel: Unable to handle kernel paging request
at virtual address 82828286
May 29 21:15:56 masterbackend kernel:  printing eip:
May 29 21:15:56 masterbackend kernel: c013bdbe
May 29 21:15:56 masterbackend kernel: *pde = 00000000
May 29 21:15:56 masterbackend kernel: Oops: 0002
May 29 21:15:56 masterbackend kernel: sg st sr_mod sd_mod scsi_mod parport_pc
lp parport snd-pcm-oss snd-mixer-oss snd-emu10k1 snd-pcm snd-timer
snd-page-alloc snd-util-mem snd-rawmidi snd-hwdep snd-seq-device
snd-ac97-codec snd nfsd af_packet ide-floppy ide-tape ide-cd cdrom floppy
e1000 supermount tuner tvaudio bttv i2c-algo-bit i2c-core videodev soundcore
loop aes rtc ext3 jbd lvm-mod
May 29 21:15:56 masterbackend kernel: CPU:    0
May 29 21:15:56 masterbackend kernel: EIP:   
0010:[kmem_cache_free_one+94/151]    Not tainted
May 29 21:15:56 masterbackend kernel: EIP:    0010:[<c013bdbe>]    Not
tainted
May 29 21:15:56 masterbackend kernel: EFLAGS: 00010046
May 29 21:15:56 masterbackend kernel: EIP is at kmem_cache_free_one+0x5e/0x97
[kernel]
May 29 21:15:56 masterbackend kernel: eax: 82828282   ebx: d00ab000   ecx:
0000001a   edx: d6d6b000
May 29 21:15:56 masterbackend kernel: esi: c16ebdd4   edi: d00aba80   ebp:
c16f5ee4   esp: c16f5edc
May 29 21:15:56 masterbackend kernel: ds: 0018   es: 0018   ss: 0018
May 29 21:15:56 masterbackend kernel: Process kswapd (pid: 4,
stackpage=c16f5000)
May 29 21:15:56 masterbackend kernel: Stack: 00000202 d00aba80 c16f5ef8
c013b714 c16ebdd4 d00aba80 d00aba80 c16f5f08
May 29 21:15:56 masterbackend kernel:        c014588d c16ebdd4 d00aba80
c16f5f2c c0147762 d00aba80 d00aba80 00000001
May 29 21:15:56 masterbackend kernel:        c13a97d0 000001d0 c13a97d0
c03446ec c16f5f60 c013c45d c13a97d0 000001d0
May 29 21:15:56 masterbackend kernel: Call Trace:
May 29 21:15:56 masterbackend kernel:  [kmem_cache_free+20/32]
kmem_cache_free+0x14/0x20 [kernel]
May 29 21:15:56 masterbackend kernel:  [<c013b714>] kmem_cache_free+0x14/0x20
[kernel]
May 29 21:15:56 masterbackend kernel:  [__put_unused_buffer_head+93/112]
__put_unused_buffer_head+0x5d/0x70 [kernel]
May 29 21:15:56 masterbackend kernel:  [<c014588d>]
__put_unused_buffer_head+0x5d/0x70 [kernel]
May 29 21:15:56 masterbackend kernel:  [try_to_free_buffers+130/304]
try_to_free_buffers+0x82/0x130 [kernel]
May 29 21:15:56 masterbackend kernel:  [<c0147762>]
try_to_free_buffers+0x82/0x130 [kernel]
May 29 21:15:56 masterbackend kernel:  [shrink_cache+413/1024]
shrink_cache+0x19d/0x400 [kernel]
May 29 21:15:56 masterbackend kernel:  [<c013c45d>] shrink_cache+0x19d/0x400
[kernel]
May 29 21:15:56 masterbackend kernel:  [shrink_caches+49/64]
shrink_caches+0x31/0x40 [kernel]
May 29 21:15:56 masterbackend kernel:  [<c013c911>] shrink_caches+0x31/0x40
[kernel]
May 29 21:15:56 masterbackend kernel:  [try_to_free_pages_zone+80/224]
try_to_free_pages_zone+0x50/0xe0 [kernel]
May 29 21:15:56 masterbackend kernel:  [<c013c970>]
try_to_free_pages_zone+0x50/0xe0 [kernel]
May 29 21:15:56 masterbackend kernel:  [kswapd_balance_pgdat+108/176]
kswapd_balance_pgdat+0x6c/0xb0 [kernel]
May 29 21:15:56 masterbackend kernel:  [<c013cb4c>]
kswapd_balance_pgdat+0x6c/0xb0 [kernel]
May 29 21:15:56 masterbackend kernel:  [kswapd_balance+23/48]
kswapd_balance+0x17/0x30 [kernel]
May 29 21:15:56 masterbackend kernel:  [<c013cba7>] kswapd_balance+0x17/0x30
[kernel]
May 29 21:15:56 masterbackend kernel:  [kswapd+174/208] kswapd+0xae/0xd0
[kernel]
May 29 21:15:56 masterbackend kernel:  [<c013ccfe>] kswapd+0xae/0xd0 [kernel]
May 29 21:15:56 masterbackend kernel:  [rest_init+0/48] stext+0x0/0x30
[kernel]
May 29 21:15:56 masterbackend kernel:  [<c0105000>] stext+0x0/0x30 [kernel]
May 29 21:15:56 masterbackend kernel:  [arch_kernel_thread+38/64]
arch_kernel_thread+0x26/0x40 [kernel]
May 29 21:15:56 masterbackend kernel:  [<c0107526>]
arch_kernel_thread+0x26/0x40 [kernel]
May 29 21:15:56 masterbackend kernel:  [kswapd+0/208] kswapd+0x0/0xd0
[kernel]
May 29 21:15:56 masterbackend kernel:  [<c013cc50>] kswapd+0x0/0xd0 [kernel]
May 29 21:15:56 masterbackend kernel:
May 29 21:15:56 masterbackend kernel: Code: 89 50 04 8b 46 08 8d 56 08 89 03
89 58 04 89 5e 08 89 53 04
May 29 21:16:19 masterbackend kernel:  <1>Unable to handle kernel paging
request at virtual address 82828286
May 29 21:16:19 masterbackend kernel:  printing eip:
May 29 21:16:19 masterbackend kernel: c013bdbe
May 29 21:16:19 masterbackend kernel: *pde = 00000000
May 29 21:16:19 masterbackend kernel: Oops: 0002
May 29 21:16:19 masterbackend kernel: sg st sr_mod sd_mod scsi_mod parport_pc
lp parport snd-pcm-oss snd-mixer-oss snd-emu10k1 snd-pcm snd-timer
snd-page-alloc snd-util-mem snd-rawmidi snd-hwdep snd-seq-device
snd-ac97-codec snd nfsd af_packet ide-floppy ide-tape ide-cd cdrom floppy
e1000 supermount tuner tvaudio bttv i2c-algo-bit i2c-core videodev soundcore
loop aes rtc ext3 jbd lvm-mod
May 29 21:16:19 masterbackend kernel: CPU:    0
May 29 21:16:19 masterbackend kernel: EIP:   
0010:[kmem_cache_free_one+94/151]    Not tainted
May 29 21:16:19 masterbackend kernel: EIP:    0010:[<c013bdbe>]    Not
tainted
May 29 21:16:19 masterbackend kernel: EFLAGS: 00010046
May 29 21:16:19 masterbackend kernel: EIP is at kmem_cache_free_one+0x5e/0x97
[kernel]
May 29 21:16:19 masterbackend kernel: eax: 82828282   ebx: d6d6b000   ecx:
00000001   edx: d8ccb020
May 29 21:16:19 masterbackend kernel: esi: c16ebdd4   edi: d6d6b120   ebp:
d0153e00   esp: d0153df8
May 29 21:16:19 masterbackend kernel: ds: 0018   es: 0018   ss: 0018
May 29 21:16:19 masterbackend kernel: Process mythbackend (pid: 4008,
stackpage=d0153000)
May 29 21:16:19 masterbackend kernel: Stack: 00000202 d6d6b120 d0153e14
c013b714 c16ebdd4 d6d6b120 d6d6b120 d0153e24
May 29 21:16:19 masterbackend kernel:        c014588d c16ebdd4 d6d6b120
d0153e48 c0147762 d6d6b120 d6d6b120 00000001
May 29 21:16:19 masterbackend kernel:        c1167dec 000001d2 c1167dec
c03446ec d0153e7c c013c45d c1167dec 000001d2
May 29 21:16:19 masterbackend kernel: Call Trace:
May 29 21:16:19 masterbackend kernel:  [kmem_cache_free+20/32]
kmem_cache_free+0x14/0x20 [kernel]
May 29 21:16:19 masterbackend kernel:  [<c013b714>] kmem_cache_free+0x14/0x20
[kernel]
May 29 21:16:19 masterbackend kernel:  [__put_unused_buffer_head+93/112]
__put_unused_buffer_head+0x5d/0x70 [kernel]
May 29 21:16:19 masterbackend kernel:  [<c014588d>]
__put_unused_buffer_head+0x5d/0x70 [kernel]
May 29 21:16:19 masterbackend kernel:  [try_to_free_buffers+130/304]
try_to_free_buffers+0x82/0x130 [kernel]
May 29 21:16:19 masterbackend kernel:  [<c0147762>]
try_to_free_buffers+0x82/0x130 [kernel]
May 29 21:16:19 masterbackend kernel:  [shrink_cache+413/1024]
shrink_cache+0x19d/0x400 [kernel]
May 29 21:16:19 masterbackend kernel:  [<c013c45d>] shrink_cache+0x19d/0x400
[kernel]
May 29 21:16:19 masterbackend kernel:  [shrink_caches+49/64]
shrink_caches+0x31/0x40 [kernel]
May 29 21:16:19 masterbackend kernel:  [<c013c911>] shrink_caches+0x31/0x40
[kernel]
May 29 21:16:19 masterbackend kernel:  [try_to_free_pages_zone+80/224]
try_to_free_pages_zone+0x50/0xe0 [kernel]
May 29 21:16:19 masterbackend kernel:  [<c013c970>]
try_to_free_pages_zone+0x50/0xe0 [kernel]
May 29 21:16:19 masterbackend kernel:  [balance_classzone+90/416]
balance_classzone+0x5a/0x1a0 [kernel]
May 29 21:16:19 masterbackend kernel:  [<c013db7a>]
balance_classzone+0x5a/0x1a0 [kernel]
May 29 21:16:19 masterbackend kernel:  [__alloc_pages+406/656]
__alloc_pages+0x196/0x290 [kernel]
May 29 21:16:19 masterbackend kernel:  [<c013de56>] __alloc_pages+0x196/0x290
[kernel]
May 29 21:16:19 masterbackend kernel: 
[af_packet:__insmod_af_packet_O/lib/modules/2.4.21-0.2mdk/kernel/net/p+-936420/96]
E journal_blocks_per_page_Ra5010b74+0x8d1c/0xffffb380 [jbd]
May 29 21:16:19 masterbackend kernel:  [<e910961c>] E
journal_blocks_per_page_Ra5010b74+0x8d1c/0xffffb380 [jbd]
May 29 21:16:19 masterbackend kernel:  [generic_file_write_nolock+768/1696]
generic_file_write_nolock+0x300/0x6a0 [kernel]
May 29 21:16:19 masterbackend kernel:  [<c0138580>]
generic_file_write_nolock+0x300/0x6a0 [kernel]
May 29 21:16:19 masterbackend kernel:  [generic_file_write+55/80]
generic_file_write+0x37/0x50 [kernel]
May 29 21:16:19 masterbackend kernel:  [<c0138957>]
generic_file_write+0x37/0x50 [kernel]
May 29 21:16:19 masterbackend kernel: 
[af_packet:__insmod_af_packet_O/lib/modules/2.4.21-0.2mdk/kernel/net/p+-947039/96]
E journal_blocks_per_page_Ra5010b74+0x63a1/0xffffb380 [jbd]
May 29 21:16:19 masterbackend kernel:  [<e9106ca1>] E
journal_blocks_per_page_Ra5010b74+0x63a1/0xffffb380 [jbd]
May 29 21:16:19 masterbackend kernel:  [sys_write+132/256]
sys_write+0x84/0x100 [kernel]
May 29 21:16:19 masterbackend kernel:  [<c0143854>] sys_write+0x84/0x100
[kernel]
May 29 21:16:19 masterbackend kernel:  [system_call+51/64]
system_call+0x33/0x40 [kernel]
May 29 21:16:19 masterbackend kernel:  [<c0109093>] system_call+0x33/0x40
[kernel]
May 29 21:16:19 masterbackend kernel:
May 29 21:16:19 masterbackend kernel: Code: 89 50 04 8b 46 08 8d 56 08 89 03
89 58 04 89 5e 08 89 53 04
May 29 21:16:26 masterbackend kernel:  <1>Unable to handle kernel paging
request at virtual address 82828286
May 29 21:16:26 masterbackend kernel:  printing eip:
May 29 21:16:26 masterbackend kernel: c013bdbe
May 29 21:16:26 masterbackend kernel: *pde = 00000000
May 29 21:16:26 masterbackend kernel: Oops: 0002
May 29 21:16:26 masterbackend kernel: sg st sr_mod sd_mod scsi_mod parport_pc
lp parport snd-pcm-oss snd-mixer-oss snd-emu10k1 snd-pcm snd-timer
snd-page-alloc snd-util-mem snd-rawmidi snd-hwdep snd-seq-device
snd-ac97-codec snd nfsd af_packet ide-floppy ide-tape ide-cd cdrom floppy
e1000 supermount tuner tvaudio bttv i2c-algo-bit i2c-core videodev soundcore
loop aes rtc ext3 jbd lvm-mod
May 29 21:16:26 masterbackend kernel: CPU:    0
May 29 21:16:26 masterbackend kernel: EIP:   
0010:[kmem_cache_free_one+94/151]    Not tainted
May 29 21:16:26 masterbackend kernel: EIP:    0010:[<c013bdbe>]    Not
tainted
May 29 21:16:26 masterbackend kernel: EFLAGS: 00010046
May 29 21:16:26 masterbackend kernel: EIP is at kmem_cache_free_one+0x5e/0x97
[kernel]
May 29 21:16:26 masterbackend kernel: eax: 82828282   ebx: d8ccb020   ecx:
00000000   edx: e0696000
May 29 21:16:26 masterbackend kernel: esi: c16ebdd4   edi: d8ccb0e0   ebp:
e31f5c94   esp: e31f5c8c
May 29 21:16:26 masterbackend kernel: ds: 0018   es: 0018   ss: 0018
May 29 21:16:26 masterbackend kernel: Process nfsd (pid: 1413,
stackpage=e31f5000)
May 29 21:16:26 masterbackend kernel: Stack: 00000202 d8ccb0e0 e31f5ca8
c013b714 c16ebdd4 d8ccb0e0 d8ccb0e0 e31f5cb8
May 29 21:16:26 masterbackend kernel:        c014588d c16ebdd4 d8ccb0e0
e31f5cdc c0147762 d8ccb0e0 d8ccb0e0 00000001
May 29 21:16:26 masterbackend kernel:        c1308844 000001d2 c1308844
c03446ec e31f5d10 c013c45d c1308844 000001d2
May 29 21:16:26 masterbackend kernel: Call Trace:
May 29 21:16:26 masterbackend kernel:  [kmem_cache_free+20/32]
kmem_cache_free+0x14/0x20 [kernel]
May 29 21:16:26 masterbackend kernel:  [<c013b714>] kmem_cache_free+0x14/0x20
[kernel]
May 29 21:16:26 masterbackend kernel:  [__put_unused_buffer_head+93/112]
__put_unused_buffer_head+0x5d/0x70 [kernel]
May 29 21:16:26 masterbackend kernel:  [<c014588d>]
__put_unused_buffer_head+0x5d/0x70 [kernel]
May 29 21:16:26 masterbackend kernel:  [try_to_free_buffers+130/304]
try_to_free_buffers+0x82/0x130 [kernel]
May 29 21:16:26 masterbackend kernel:  [<c0147762>]
try_to_free_buffers+0x82/0x130 [kernel]
May 29 21:16:26 masterbackend kernel:  [shrink_cache+413/1024]
shrink_cache+0x19d/0x400 [kernel]
May 29 21:16:26 masterbackend kernel:  [<c013c45d>] shrink_cache+0x19d/0x400
[kernel]
May 29 21:16:26 masterbackend kernel:  [shrink_caches+49/64]
shrink_caches+0x31/0x40 [kernel]
May 29 21:16:26 masterbackend kernel:  [<c013c911>] shrink_caches+0x31/0x40
[kernel]
May 29 21:16:26 masterbackend kernel:  [try_to_free_pages_zone+80/224]
try_to_free_pages_zone+0x50/0xe0 [kernel]
May 29 21:16:26 masterbackend kernel:  [<c013c970>]
try_to_free_pages_zone+0x50/0xe0 [kernel]
May 29 21:16:26 masterbackend kernel:  [balance_classzone+90/416]
balance_classzone+0x5a/0x1a0 [kernel]
May 29 21:16:26 masterbackend kernel:  [<c013db7a>]
balance_classzone+0x5a/0x1a0 [kernel]
May 29 21:16:26 masterbackend kernel:  [__alloc_pages+406/656]
__alloc_pages+0x196/0x290 [kernel]
May 29 21:16:26 masterbackend kernel:  [<c013de56>] __alloc_pages+0x196/0x290
[kernel]
May 29 21:16:26 masterbackend kernel: 
[af_packet:__insmod_af_packet_O/lib/modules/2.4.21-0.2mdk/kernel/net/p+-936420/96]
E journal_blocks_per_page_Ra5010b74+0x8d1c/0xffffb380 [jbd]
May 29 21:16:26 masterbackend kernel:  [<e910961c>] E
journal_blocks_per_page_Ra5010b74+0x8d1c/0xffffb380 [jbd]
May 29 21:16:26 masterbackend kernel:  [generic_file_write_nolock+768/1696]
generic_file_write_nolock+0x300/0x6a0 [kernel]
May 29 21:16:26 masterbackend kernel:  [<c0138580>]
generic_file_write_nolock+0x300/0x6a0 [kernel]
May 29 21:16:26 masterbackend kernel:  [generic_file_write+55/80]
generic_file_write+0x37/0x50 [kernel]
May 29 21:16:26 masterbackend kernel:  [<c0138957>]
generic_file_write+0x37/0x50 [kernel]
May 29 21:16:26 masterbackend kernel: 
[af_packet:__insmod_af_packet_O/lib/modules/2.4.21-0.2mdk/kernel/net/p+-947039/96]
E journal_blocks_per_page_Ra5010b74+0x63a1/0xffffb380 [jbd]
May 29 21:16:26 masterbackend kernel:  [<e9106ca1>] E
journal_blocks_per_page_Ra5010b74+0x63a1/0xffffb380 [jbd]
May 29 21:16:26 masterbackend kernel:  [<e924a5d1>] nfsd_write+0x111/0x300
[nfsd]
May 29 21:16:26 masterbackend kernel: 
[af_packet:__insmod_af_packet_O/lib/modules/2.4.21-0.2mdk/kernel/net/p+-896544/96]
E journal_blocks_per_page_Ra5010b74+0x128e0/0xffffb380 [jbd]
May 29 21:16:26 masterbackend kernel:  [<e91131e0>] E
journal_blocks_per_page_Ra5010b74+0x128e0/0xffffb380 [jbd]
May 29 21:16:26 masterbackend kernel:  [<e924fd62>]
nfsd3_proc_write+0x92/0x120 [nfsd]
May 29 21:16:26 masterbackend kernel:  [<e925789c>]
nfsd_procedures3+0xfc/0x360 [nfsd]
May 29 21:16:26 masterbackend kernel:  [<e92465b1>] nfsd_dispatch+0xb1/0x1b0
[nfsd]
May 29 21:16:26 masterbackend kernel:  [svc_process+1114/1392]
svc_process+0x45a/0x600 [kernel]
May 29 21:16:26 masterbackend kernel:  [<c025721a>] svc_process+0x45a/0x600
[kernel]
May 29 21:16:26 masterbackend kernel:  [<e925789c>]
nfsd_procedures3+0xfc/0x360 [nfsd]
May 29 21:16:26 masterbackend kernel:  [<e92570f8>] nfsd_program+0x0/0x28
[nfsd]
May 29 21:16:26 masterbackend kernel:  [<e9246398>] nfsd+0x1c8/0x330 [nfsd]
May 29 21:16:26 masterbackend kernel:  [arch_kernel_thread+38/64]
arch_kernel_thread+0x26/0x40 [kernel]
May 29 21:16:26 masterbackend kernel:  [<c0107526>]
arch_kernel_thread+0x26/0x40 [kernel]
May 29 21:16:26 masterbackend kernel:  [<e92461d0>] nfsd+0x0/0x330 [nfsd]
May 29 21:16:26 masterbackend kernel:
May 29 21:16:26 masterbackend kernel: Code: 89 50 04 8b 46 08 8d 56 08 89 03
89 58 04 89 5e 08 89 53 04
May 29 21:16:31 masterbackend kernel:  <1>Unable to handle kernel paging
request at virtual address 82828286
May 29 21:16:31 masterbackend kernel:  printing eip:
May 29 21:16:31 masterbackend kernel: c013bdbe
May 29 21:16:31 masterbackend kernel: *pde = 00000000
May 29 21:16:31 masterbackend kernel: Oops: 0002
May 29 21:16:31 masterbackend kernel: sg st sr_mod sd_mod scsi_mod parport_pc
lp parport snd-pcm-oss snd-mixer-oss snd-emu10k1 snd-pcm snd-timer
snd-page-alloc snd-util-mem snd-rawmidi snd-hwdep snd-seq-device
snd-ac97-codec snd nfsd af_packet ide-floppy ide-tape ide-cd cdrom floppy
e1000 supermount tuner tvaudio bttv i2c-algo-bit i2c-core videodev soundcore
loop aes rtc ext3 jbd lvm-mod
May 29 21:16:31 masterbackend kernel: CPU:    0
May 29 21:16:31 masterbackend kernel: EIP:   
0010:[kmem_cache_free_one+94/151]    Not tainted
May 29 21:16:31 masterbackend kernel: EIP:    0010:[<c013bdbe>]    Not
tainted
May 29 21:16:31 masterbackend kernel: EFLAGS: 00010046
May 29 21:16:31 masterbackend kernel: EIP is at kmem_cache_free_one+0x5e/0x97
[kernel]
May 29 21:16:31 masterbackend kernel: eax: 82828282   ebx: e0696000   ecx:
00000011   edx: cf5c7000
May 29 21:16:31 masterbackend kernel: esi: c16ebdd4   edi: e0696720   ebp:
e2b83c84   esp: e2b83c7c
May 29 21:16:31 masterbackend kernel: ds: 0018   es: 0018   ss: 0018
May 29 21:16:31 masterbackend kernel: Process nfsd (pid: 1417,
stackpage=e2b83000)
May 29 21:16:31 masterbackend kernel: Stack: 00000202 e0696720 e2b83c98
c013b714 c16ebdd4 e0696720 e0696720 e2b83ca8
May 29 21:16:31 masterbackend kernel:        c014588d c16ebdd4 e0696720
e2b83ccc c0147762 e0696720 e0696720 00000001
May 29 21:16:31 masterbackend kernel:        c11d048c 000001d2 c11d048c
c03446ec e2b83d00 c013c45d c11d048c 000001d2
May 29 21:16:31 masterbackend kernel: Call Trace:
May 29 21:16:31 masterbackend kernel:  [kmem_cache_free+20/32]
kmem_cache_free+0x14/0x20 [kernel]
May 29 21:16:31 masterbackend kernel:  [<c013b714>] kmem_cache_free+0x14/0x20
[kernel]
May 29 21:16:31 masterbackend kernel:  [__put_unused_buffer_head+93/112]
__put_unused_buffer_head+0x5d/0x70 [kernel]
May 29 21:16:31 masterbackend kernel:  [<c014588d>]
__put_unused_buffer_head+0x5d/0x70 [kernel]
May 29 21:16:31 masterbackend kernel:  [try_to_free_buffers+130/304]
try_to_free_buffers+0x82/0x130 [kernel]
May 29 21:16:31 masterbackend kernel:  [<c0147762>]
try_to_free_buffers+0x82/0x130 [kernel]
May 29 21:16:31 masterbackend kernel:  [shrink_cache+413/1024]
shrink_cache+0x19d/0x400 [kernel]
May 29 21:16:31 masterbackend kernel:  [<c013c45d>] shrink_cache+0x19d/0x400
[kernel]
May 29 21:16:31 masterbackend kernel:  [shrink_caches+49/64]
shrink_caches+0x31/0x40 [kernel]
May 29 21:16:31 masterbackend kernel:  [<c013c911>] shrink_caches+0x31/0x40
[kernel]
May 29 21:16:31 masterbackend kernel:  [try_to_free_pages_zone+80/224]
try_to_free_pages_zone+0x50/0xe0 [kernel]
May 29 21:16:31 masterbackend kernel:  [<c013c970>]
try_to_free_pages_zone+0x50/0xe0 [kernel]
May 29 21:16:31 masterbackend kernel:  [balance_classzone+90/416]
balance_classzone+0x5a/0x1a0 [kernel]
May 29 21:16:31 masterbackend kernel:  [<c013db7a>]
balance_classzone+0x5a/0x1a0 [kernel]
May 29 21:16:31 masterbackend kernel:  [__alloc_pages+406/656]
__alloc_pages+0x196/0x290 [kernel]
May 29 21:16:31 masterbackend kernel:  [<c013de56>] __alloc_pages+0x196/0x290
[kernel]
May 29 21:16:31 masterbackend kernel:  [lru_cache_add+93/112]
lru_cache_add+0x5d/0x70 [kernel]
May 29 21:16:31 masterbackend kernel:  [<c013bf7d>] lru_cache_add+0x5d/0x70
[kernel]
May 29 21:16:31 masterbackend kernel:  [page_cache_read+109/192]
page_cache_read+0x6d/0xc0 [kernel]
May 29 21:16:31 masterbackend kernel:  [<c0135e7d>] page_cache_read+0x6d/0xc0
[kernel]
May 29 21:16:31 masterbackend kernel:  [generic_file_readahead+199/352]
generic_file_readahead+0xc7/0x160 [kernel]
May 29 21:16:31 masterbackend kernel:  [<c01364d7>]
generic_file_readahead+0xc7/0x160 [kernel]
May 29 21:16:31 masterbackend kernel:  [do_generic_file_read+775/1072]
do_generic_file_read+0x307/0x430 [kernel]
May 29 21:16:31 masterbackend kernel:  [<c01368b7>]
do_generic_file_read+0x307/0x430 [kernel]
May 29 21:16:31 masterbackend kernel:  [file_read_actor+0/160]
file_read_actor+0x0/0xa0 [kernel]
May 29 21:16:31 masterbackend kernel:  [<c0136c40>] file_read_actor+0x0/0xa0
[kernel]
May 29 21:16:31 masterbackend kernel:  [generic_file_read+128/288]
generic_file_read+0x80/0x120 [kernel]
May 29 21:16:31 masterbackend kernel:  [<c0136d60>]
generic_file_read+0x80/0x120 [kernel]
May 29 21:16:31 masterbackend kernel:  [file_read_actor+0/160]
file_read_actor+0x0/0xa0 [kernel]
May 29 21:16:31 masterbackend kernel:  [<c0136c40>] file_read_actor+0x0/0xa0
[kernel]
May 29 21:16:31 masterbackend kernel:  [<e924a427>] nfsd_read+0x107/0x1a0
[nfsd]
May 29 21:16:31 masterbackend kernel: 
[af_packet:__insmod_af_packet_O/lib/modules/2.4.21-0.2mdk/kernel/net/p+-896544/96]
E journal_blocks_per_page_Ra5010b74+0x128e0/0xffffb380 [jbd]
May 29 21:16:31 masterbackend kernel:  [<e91131e0>] E
journal_blocks_per_page_Ra5010b74+0x128e0/0xffffb380 [jbd]
May 29 21:16:31 masterbackend kernel:  [<e924fc1e>]
nfsd3_proc_read+0xce/0x180 [nfsd]
May 29 21:16:31 masterbackend kernel:  [<e9257878>]
nfsd_procedures3+0xd8/0x360 [nfsd]
May 29 21:16:31 masterbackend kernel:  [<e92465b1>] nfsd_dispatch+0xb1/0x1b0
[nfsd]
May 29 21:16:31 masterbackend kernel:  [svc_process+1114/1392]
svc_process+0x45a/0x600 [kernel]
May 29 21:16:31 masterbackend kernel:  [<c025721a>] svc_process+0x45a/0x600
[kernel]
May 29 21:16:31 masterbackend kernel:  [<e9257878>]
nfsd_procedures3+0xd8/0x360 [nfsd]
May 29 21:16:31 masterbackend kernel:  [<e92570f8>] nfsd_program+0x0/0x28
[nfsd]
May 29 21:16:31 masterbackend kernel:  [<e9246398>] nfsd+0x1c8/0x330 [nfsd]
May 29 21:16:31 masterbackend kernel:  [<e92570c0>] nfsd_list+0x0/0x8 [nfsd]
May 29 21:16:31 masterbackend kernel:  [arch_kernel_thread+38/64]
arch_kernel_thread+0x26/0x40 [kernel]
May 29 21:16:31 masterbackend kernel:  [<c0107526>]
arch_kernel_thread+0x26/0x40 [kernel]
May 29 21:16:31 masterbackend kernel:  [<e92461d0>] nfsd+0x0/0x330 [nfsd]
May 29 21:16:31 masterbackend kernel:
May 29 21:16:31 masterbackend kernel: Code: 89 50 04 8b 46 08 8d 56 08 89 03
89 58 04 89 5e 08 89 53 04
May 29 21:16:31 masterbackend kernel:  <1>Unable to handle kernel paging
request at virtual address 82828286
May 29 21:16:31 masterbackend kernel:  printing eip:
May 29 21:16:31 masterbackend kernel: c013bdbe
May 29 21:16:31 masterbackend kernel: *pde = 00000000
May 29 21:16:31 masterbackend kernel: Oops: 0002
May 29 21:16:31 masterbackend kernel: sg st sr_mod sd_mod scsi_mod parport_pc
lp parport snd-pcm-oss snd-mixer-oss snd-emu10k1 snd-pcm snd-timer
snd-page-alloc snd-util-mem snd-rawmidi snd-hwdep snd-seq-device
snd-ac97-codec snd nfsd af_packet ide-floppy ide-tape ide-cd cdrom floppy
e1000 supermount tuner tvaudio bttv i2c-algo-bit i2c-core videodev soundcore
loop aes rtc ext3 jbd lvm-mod
May 29 21:16:31 masterbackend kernel: CPU:    0
May 29 21:16:31 masterbackend kernel: EIP:   
0010:[kmem_cache_free_one+94/151]    Not tainted
May 29 21:16:31 masterbackend kernel: EIP:    0010:[<c013bdbe>]    Not
tainted
May 29 21:16:31 masterbackend kernel: EFLAGS: 00010046
May 29 21:16:31 masterbackend kernel: EIP is at kmem_cache_free_one+0x5e/0x97
[kernel]
May 29 21:16:31 masterbackend kernel: eax: 82828282   ebx: cf5c7000   ecx:
0000000d   edx: cdd98020
May 29 21:16:31 masterbackend kernel: esi: c16ebdd4   edi: cf5c75a0   ebp:
e347dc84   esp: e347dc7c
May 29 21:16:31 masterbackend kernel: ds: 0018   es: 0018   ss: 0018
May 29 21:16:31 masterbackend kernel: Process nfsd (pid: 1412,
stackpage=e347d000)
May 29 21:16:31 masterbackend kernel: Stack: 00000202 cf5c75a0 e347dc98
c013b714 c16ebdd4 cf5c75a0 cf5c75a0 e347dca8
May 29 21:16:31 masterbackend kernel:        c014588d c16ebdd4 cf5c75a0
e347dccc c0147762 cf5c75a0 cf5c75a0 00000001
May 29 21:16:31 masterbackend kernel:        c1371438 000001d2 c1371438
c03446ec e347dd00 c013c45d c1371438 000001d2
May 29 21:16:31 masterbackend kernel: Call Trace:
May 29 21:16:31 masterbackend kernel:  [kmem_cache_free+20/32]
kmem_cache_free+0x14/0x20 [kernel]
May 29 21:16:31 masterbackend kernel:  [<c013b714>] kmem_cache_free+0x14/0x20
[kernel]
May 29 21:16:31 masterbackend kernel:  [__put_unused_buffer_head+93/112]
__put_unused_buffer_head+0x5d/0x70 [kernel]
May 29 21:16:31 masterbackend kernel:  [<c014588d>]
__put_unused_buffer_head+0x5d/0x70 [kernel]
May 29 21:16:31 masterbackend kernel:  [try_to_free_buffers+130/304]
try_to_free_buffers+0x82/0x130 [kernel]
May 29 21:16:31 masterbackend kernel:  [<c0147762>]
try_to_free_buffers+0x82/0x130 [kernel]
May 29 21:16:31 masterbackend kernel:  [shrink_cache+413/1024]
shrink_cache+0x19d/0x400 [kernel]
May 29 21:16:31 masterbackend kernel:  [<c013c45d>] shrink_cache+0x19d/0x400
[kernel]
May 29 21:16:31 masterbackend kernel:  [shrink_caches+49/64]
shrink_caches+0x31/0x40 [kernel]
May 29 21:16:31 masterbackend kernel:  [<c013c911>] shrink_caches+0x31/0x40
[kernel]
May 29 21:16:31 masterbackend kernel:  [try_to_free_pages_zone+80/224]
try_to_free_pages_zone+0x50/0xe0 [kernel]
May 29 21:16:31 masterbackend kernel:  [<c013c970>]
try_to_free_pages_zone+0x50/0xe0 [kernel]
May 29 21:16:31 masterbackend kernel:  [balance_classzone+90/416]
balance_classzone+0x5a/0x1a0 [kernel]
May 29 21:16:31 masterbackend kernel:  [<c013db7a>]
balance_classzone+0x5a/0x1a0 [kernel]
May 29 21:16:31 masterbackend kernel:  [__alloc_pages+406/656]
__alloc_pages+0x196/0x290 [kernel]
May 29 21:16:31 masterbackend kernel:  [lru_cache_add+93/112]
lru_cache_add+0x5d/0x70 [kernel]
May 29 21:16:31 masterbackend kernel:  [<c013bf7d>] lru_cache_add+0x5d/0x70
[kernel]
May 29 21:16:31 masterbackend kernel:  [page_cache_read+109/192]
page_cache_read+0x6d/0xc0 [kernel]
May 29 21:16:31 masterbackend kernel:  [<c0135e7d>] page_cache_read+0x6d/0xc0
[kernel]
May 29 21:16:31 masterbackend kernel:  [generic_file_readahead+199/352]
generic_file_readahead+0xc7/0x160 [kernel]
May 29 21:16:31 masterbackend kernel:  [<c01364d7>]
generic_file_readahead+0xc7/0x160 [kernel]
May 29 21:16:31 masterbackend kernel:  [do_generic_file_read+775/1072]
do_generic_file_read+0x307/0x430 [kernel]
May 29 21:16:31 masterbackend kernel:  [<c01368b7>]
do_generic_file_read+0x307/0x430 [kernel]
May 29 21:16:31 masterbackend kernel:  [file_read_actor+0/160]
file_read_actor+0x0/0xa0 [kernel]
May 29 21:16:31 masterbackend kernel:  [<c0136c40>] file_read_actor+0x0/0xa0
[kernel]
May 29 21:16:31 masterbackend kernel:  [generic_file_read+128/288]
generic_file_read+0x80/0x120 [kernel]
May 29 21:16:31 masterbackend kernel:  [<c0136d60>]
generic_file_read+0x80/0x120 [kernel]
May 29 21:16:31 masterbackend kernel:  [file_read_actor+0/160]
file_read_actor+0x0/0xa0 [kernel]
May 29 21:16:31 masterbackend kernel:  [<c0136c40>] file_read_actor+0x0/0xa0
[kernel]
May 29 21:16:31 masterbackend kernel:  [<e924a427>] nfsd_read+0x107/0x1a0
[nfsd]
May 29 21:16:31 masterbackend kernel: 
[af_packet:__insmod_af_packet_O/lib/modules/2.4.21-0.2mdk/kernel/net/p+-896544/96]
E journal_blocks_per_page_Ra5010b74+0x128e0/0xffffb380 [jbd]
May 29 21:16:31 masterbackend kernel:  [<e91131e0>] E
journal_blocks_per_page_Ra5010b74+0x128e0/0xffffb380 [jbd]
May 29 21:16:31 masterbackend kernel:  [<e924fc1e>]
nfsd3_proc_read+0xce/0x180 [nfsd]
May 29 21:16:31 masterbackend kernel:  [<e9257878>]
nfsd_procedures3+0xd8/0x360 [nfsd]
May 29 21:16:31 masterbackend kernel:  [<e92465b1>] nfsd_dispatch+0xb1/0x1b0
[nfsd]
May 29 21:16:31 masterbackend kernel:  [svc_process+1114/1392]
svc_process+0x45a/0x600 [kernel]
May 29 21:16:31 masterbackend kernel:  [<c025721a>] svc_process+0x45a/0x600
[kernel]
May 29 21:16:31 masterbackend kernel:  [<e9257878>]
nfsd_procedures3+0xd8/0x360 [nfsd]
May 29 21:16:31 masterbackend kernel:  [<e92570f8>] nfsd_program+0x0/0x28
[nfsd]
May 29 21:16:31 masterbackend kernel:  [<e9246398>] nfsd+0x1c8/0x330 [nfsd]
May 29 21:16:31 masterbackend kernel:  [arch_kernel_thread+38/64]
arch_kernel_thread+0x26/0x40 [kernel]
May 29 21:16:31 masterbackend kernel:  [<c0107526>]
arch_kernel_thread+0x26/0x40 [kernel]
May 29 21:16:31 masterbackend kernel:  [<e92461d0>] nfsd+0x0/0x330 [nfsd]
May 29 21:16:31 masterbackend kernel:
May 29 21:16:31 masterbackend kernel: Code: 89 50 04 8b 46 08 8d 56 08 89 03
89 58 04 89 5e 08 89 53 04
May 29 21:16:32 masterbackend kernel:  <1>Unable to handle kernel paging
request at virtual address 82828286
May 29 21:16:32 masterbackend kernel:  printing eip:
May 29 21:16:32 masterbackend kernel: c013bdbe
May 29 21:16:32 masterbackend kernel: *pde = 00000000
May 29 21:16:32 masterbackend kernel: Oops: 0002
May 29 21:16:32 masterbackend kernel: sg st sr_mod sd_mod scsi_mod parport_pc
lp parport snd-pcm-oss snd-mixer-oss snd-emu10k1 snd-pcm snd-timer
snd-page-alloc snd-util-mem snd-rawmidi snd-hwdep snd-seq-device
snd-ac97-codec snd nfsd af_packet ide-floppy ide-tape ide-cd cdrom floppy
e1000 supermount tuner tvaudio bttv i2c-algo-bit i2c-core videodev soundcore
loop aes rtc ext3 jbd lvm-mod
May 29 21:16:32 masterbackend kernel: CPU:    0
May 29 21:16:32 masterbackend kernel: EIP:   
0010:[kmem_cache_free_one+94/151]    Not tainted
May 29 21:16:32 masterbackend kernel: EIP:    0010:[<c013bdbe>]    Not
tainted
May 29 21:16:32 masterbackend kernel: EFLAGS: 00010046
May 29 21:16:32 masterbackend kernel: EIP is at kmem_cache_free_one+0x5e/0x97
[kernel]
May 29 21:16:32 masterbackend kernel: eax: 82828282   ebx: cdd98020   ecx:
00000013   edx: ca4e3020
May 29 21:16:32 masterbackend kernel: esi: c16ebdd4   edi: cdd98800   ebp:
e5dabe00   esp: e5dabdf8
May 29 21:16:32 masterbackend kernel: ds: 0018   es: 0018   ss: 0018
May 29 21:16:32 masterbackend kernel: Process mythbackend (pid: 3986,
stackpage=e5dab000)
May 29 21:16:32 masterbackend kernel: Stack: 00000202 cdd98800 e5dabe14
c013b714 c16ebdd4 cdd98800 cdd98800 e5dabe24
May 29 21:16:32 masterbackend kernel:        c014588d c16ebdd4 cdd98800
e5dabe48 c0147762 cdd98800 cdd98800 00000001
May 29 21:16:32 masterbackend kernel:        c10eca58 000001d2 c10eca58
c03446ec e5dabe7c c013c45d c10eca58 000001d2
May 29 21:16:32 masterbackend kernel: Call Trace:
May 29 21:16:32 masterbackend kernel:  [kmem_cache_free+20/32]
kmem_cache_free+0x14/0x20 [kernel]
May 29 21:16:32 masterbackend kernel:  [<c013b714>] kmem_cache_free+0x14/0x20
[kernel]
May 29 21:16:32 masterbackend kernel:  [__put_unused_buffer_head+93/112]
__put_unused_buffer_head+0x5d/0x70 [kernel]
May 29 21:16:32 masterbackend kernel:  [<c014588d>]
__put_unused_buffer_head+0x5d/0x70 [kernel]
May 29 21:16:32 masterbackend kernel:  [try_to_free_buffers+130/304]
try_to_free_buffers+0x82/0x130 [kernel]
May 29 21:16:32 masterbackend kernel:  [<c0147762>]
try_to_free_buffers+0x82/0x130 [kernel]
May 29 21:16:32 masterbackend kernel:  [shrink_cache+413/1024]
shrink_cache+0x19d/0x400 [kernel]
May 29 21:16:32 masterbackend kernel:  [<c013c45d>] shrink_cache+0x19d/0x400
[kernel]
May 29 21:16:32 masterbackend kernel:  [shrink_caches+49/64]
shrink_caches+0x31/0x40 [kernel]
May 29 21:16:32 masterbackend kernel:  [<c013c911>] shrink_caches+0x31/0x40
[kernel]
May 29 21:16:32 masterbackend kernel:  [try_to_free_pages_zone+80/224]
try_to_free_pages_zone+0x50/0xe0 [kernel]
May 29 21:16:32 masterbackend kernel:  [<c013c970>]
try_to_free_pages_zone+0x50/0xe0 [kernel]
May 29 21:16:32 masterbackend kernel:  [balance_classzone+90/416]
balance_classzone+0x5a/0x1a0 [kernel]
May 29 21:16:32 masterbackend kernel:  [<c013db7a>]
balance_classzone+0x5a/0x1a0 [kernel]
May 29 21:16:32 masterbackend kernel:  [__alloc_pages+406/656]
__alloc_pages+0x196/0x290 [kernel]
May 29 21:16:32 masterbackend kernel:  [<c013de56>] __alloc_pages+0x196/0x290
[kernel]
May 29 21:16:32 masterbackend kernel: 
[af_packet:__insmod_af_packet_O/lib/modules/2.4.21-0.2mdk/kernel/net/p+-936420/96]
E journal_blocks_per_page_Ra5010b74+0x8d1c/0xffffb380 [jbd]
May 29 21:16:32 masterbackend kernel:  [<e910961c>] E
journal_blocks_per_page_Ra5010b74+0x8d1c/0xffffb380 [jbd]
May 29 21:16:32 masterbackend kernel:  [generic_file_write_nolock+768/1696]
generic_file_write_nolock+0x300/0x6a0 [kernel]
May 29 21:16:32 masterbackend kernel:  [<c0138580>]
generic_file_write_nolock+0x300/0x6a0 [kernel]
May 29 21:16:32 masterbackend kernel:  [generic_file_write+55/80]
generic_file_write+0x37/0x50 [kernel]
May 29 21:16:32 masterbackend kernel:  [<c0138957>]
generic_file_write+0x37/0x50 [kernel]
May 29 21:16:32 masterbackend kernel: 
[af_packet:__insmod_af_packet_O/lib/modules/2.4.21-0.2mdk/kernel/net/p+-947039/96]
E journal_blocks_per_page_Ra5010b74+0x63a1/0xffffb380 [jbd]
May 29 21:16:32 masterbackend kernel:  [<e9106ca1>] E
journal_blocks_per_page_Ra5010b74+0x63a1/0xffffb380 [jbd]
May 29 21:16:32 masterbackend kernel:  [sys_write+132/256]
sys_write+0x84/0x100 [kernel]
May 29 21:16:32 masterbackend kernel:  [<c0143854>] sys_write+0x84/0x100
[kernel]
May 29 21:16:32 masterbackend kernel:  [system_call+51/64]
system_call+0x33/0x40 [kernel]
May 29 21:16:32 masterbackend kernel:  [<c0109093>] system_call+0x33/0x40
[kernel]
May 29 21:16:32 masterbackend kernel:
May 29 21:16:32 masterbackend kernel: Code: 89 50 04 8b 46 08 8d 56 08 89 03
89 58 04 89 5e 08 89 53 04
May 29 21:16:42 masterbackend kernel:  <1>Unable to handle kernel paging
request at virtual address 82828286
May 29 21:16:42 masterbackend kernel:  printing eip:
May 29 21:16:42 masterbackend kernel: c013bdbe
May 29 21:16:42 masterbackend kernel: *pde = 00000000
May 29 21:16:42 masterbackend kernel: Oops: 0002
May 29 21:16:42 masterbackend kernel: sg st sr_mod sd_mod scsi_mod parport_pc
lp parport snd-pcm-oss snd-mixer-oss snd-emu10k1 snd-pcm snd-timer
snd-page-alloc snd-util-mem snd-rawmidi snd-hwdep snd-seq-device
snd-ac97-codec snd nfsd af_packet ide-floppy ide-tape ide-cd cdrom floppy
e1000 supermount tuner tvaudio bttv i2c-algo-bit i2c-core videodev soundcore
loop aes rtc ext3 jbd lvm-mod
May 29 21:16:42 masterbackend kernel: CPU:    0
May 29 21:16:42 masterbackend kernel: EIP:   
0010:[kmem_cache_free_one+94/151]    Not tainted
May 29 21:16:42 masterbackend kernel: EIP:    0010:[<c013bdbe>]    Not
tainted
May 29 21:16:42 masterbackend kernel: EFLAGS: 00010046
May 29 21:16:42 masterbackend kernel: EIP is at kmem_cache_free_one+0x5e/0x97
[kernel]
May 29 21:16:42 masterbackend kernel: eax: 82828282   ebx: ca4e3020   ecx:
00000011   edx: d4442000
May 29 21:16:42 masterbackend kernel: esi: c16ebdd4   edi: ca4e3740   ebp:
d4073db8   esp: d4073db0
May 29 21:16:42 masterbackend kernel: ds: 0018   es: 0018   ss: 0018
May 29 21:16:42 masterbackend kernel: Process mythbackend (pid: 3989,
stackpage=d4073000)
May 29 21:16:42 masterbackend kernel: Stack: 00000202 ca4e3740 d4073dcc
c013b714 c16ebdd4 ca4e3740 ca4e3740 d4073ddc
May 29 21:16:42 masterbackend kernel:        c014588d c16ebdd4 ca4e3740
d4073e00 c0147762 ca4e3740 ca4e3740 00000001
May 29 21:16:42 masterbackend kernel:        c1264344 000001d2 c1264344
c03446ec d4073e34 c013c45d c1264344 000001d2
May 29 21:16:42 masterbackend kernel: Call Trace:
May 29 21:16:42 masterbackend kernel:  [kmem_cache_free+20/32]
kmem_cache_free+0x14/0x20 [kernel]
May 29 21:16:42 masterbackend kernel:  [<c013b714>] kmem_cache_free+0x14/0x20
[kernel]
May 29 21:16:42 masterbackend kernel:  [__put_unused_buffer_head+93/112]
__put_unused_buffer_head+0x5d/0x70 [kernel]
May 29 21:16:42 masterbackend kernel:  [<c014588d>]
__put_unused_buffer_head+0x5d/0x70 [kernel]
May 29 21:16:42 masterbackend kernel:  [try_to_free_buffers+130/304]
try_to_free_buffers+0x82/0x130 [kernel]
May 29 21:16:42 masterbackend kernel:  [<c0147762>]
try_to_free_buffers+0x82/0x130 [kernel]
May 29 21:16:42 masterbackend kernel:  [shrink_cache+413/1024]
shrink_cache+0x19d/0x400 [kernel]
May 29 21:16:42 masterbackend kernel:  [<c013c45d>] shrink_cache+0x19d/0x400
[kernel]
May 29 21:16:42 masterbackend kernel:  [shrink_caches+49/64]
shrink_caches+0x31/0x40 [kernel]
May 29 21:16:42 masterbackend kernel:  [<c013c911>] shrink_caches+0x31/0x40
[kernel]
May 29 21:16:42 masterbackend kernel:  [try_to_free_pages_zone+80/224]
try_to_free_pages_zone+0x50/0xe0 [kernel]
May 29 21:16:42 masterbackend kernel:  [<c013c970>]
try_to_free_pages_zone+0x50/0xe0 [kernel]
May 29 21:16:42 masterbackend kernel:  [balance_classzone+90/416]
balance_classzone+0x5a/0x1a0 [kernel]
May 29 21:16:42 masterbackend kernel:  [<c013db7a>]
balance_classzone+0x5a/0x1a0 [kernel]
May 29 21:16:42 masterbackend kernel:  [__alloc_pages+406/656]
__alloc_pages+0x196/0x290 [kernel]
May 29 21:16:42 masterbackend kernel:  [<c013de56>] __alloc_pages+0x196/0x290
[kernel]
May 29 21:16:42 masterbackend kernel:  [lru_cache_add+93/112]
lru_cache_add+0x5d/0x70 [kernel]
May 29 21:16:42 masterbackend kernel:  [<c013bf7d>] lru_cache_add+0x5d/0x70
[kernel]
May 29 21:16:42 masterbackend kernel:  [page_cache_read+109/192]
page_cache_read+0x6d/0xc0 [kernel]
May 29 21:16:42 masterbackend kernel:  [<c0135e7d>] page_cache_read+0x6d/0xc0
[kernel]
May 29 21:16:42 masterbackend kernel:  [generic_file_readahead+199/352]
generic_file_readahead+0xc7/0x160 [kernel]
May 29 21:16:42 masterbackend kernel:  [<c01364d7>]
generic_file_readahead+0xc7/0x160 [kernel]
May 29 21:16:42 masterbackend kernel:  [do_generic_file_read+775/1072]
do_generic_file_read+0x307/0x430 [kernel]
May 29 21:16:42 masterbackend kernel:  [<c01368b7>]
do_generic_file_read+0x307/0x430 [kernel]
May 29 21:16:42 masterbackend kernel:  [file_read_actor+0/160]
file_read_actor+0x0/0xa0 [kernel]
May 29 21:16:42 masterbackend kernel:  [<c0136c40>] file_read_actor+0x0/0xa0
[kernel]
May 29 21:16:42 masterbackend kernel:  [generic_file_read+128/288]
generic_file_read+0x80/0x120 [kernel]
May 29 21:16:42 masterbackend kernel:  [<c0136d60>]
generic_file_read+0x80/0x120 [kernel]
May 29 21:16:42 masterbackend kernel:  [file_read_actor+0/160]
file_read_actor+0x0/0xa0 [kernel]
May 29 21:16:42 masterbackend kernel:  [<c0136c40>] file_read_actor+0x0/0xa0
[kernel]
May 29 21:16:42 masterbackend kernel:  [sys_read+132/256] sys_read+0x84/0x100
[kernel]
May 29 21:16:42 masterbackend kernel:  [<c0143754>] sys_read+0x84/0x100
[kernel]
May 29 21:16:42 masterbackend kernel:  [system_call+51/64]
system_call+0x33/0x40 [kernel]
May 29 21:16:42 masterbackend kernel:  [<c0109093>] system_call+0x33/0x40
[kernel]
May 29 21:16:42 masterbackend kernel:
May 29 21:16:42 masterbackend kernel: Code: 89 50 04 8b 46 08 8d 56 08 89 03
89 58 04 89 5e 08 89 53 04


__________________________________
Do you Yahoo!?
Yahoo! Calendar - Free online calendar with sync to Outlook(TM).
http://calendar.yahoo.com
