Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750727AbWHTLk0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbWHTLk0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 07:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbWHTLk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 07:40:26 -0400
Received: from mail-a01.ithnet.com ([217.64.83.96]:52894 "HELO ithnet.com")
	by vger.kernel.org with SMTP id S1750727AbWHTLk0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 07:40:26 -0400
X-Sender-Authentication: net64
Date: Sun, 20 Aug 2006 13:40:22 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel@vger.kernel.org
Subject: Bug Report 2.6.17.8
Message-Id: <20060820134022.c1d676d6.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

in case of additional questions feel free to ask. 

-- 
Regards,
Stephan

Aug 20 03:43:11 a01 kernel: BUG: unable to handle kernel paging request at virtual address 02000044
Aug 20 03:43:11 a01 kernel:  printing eip:
Aug 20 03:43:11 a01 kernel: c0176356
Aug 20 03:43:11 a01 kernel: *pde = 00000000
Aug 20 03:43:11 a01 kernel: Oops: 0000 [#1]
Aug 20 03:43:11 a01 kernel: Modules linked in: speedstep_lib freq_table ipv6 intel_agp agpgart hw_random nfs lockd sunrpc e100 mii e1000
Aug 20 03:43:11 a01 kernel: CPU:    0
Aug 20 03:43:11 a01 kernel: EIP:    0060:[dqput+14/338]    Not tainted VLI
Aug 20 03:43:11 a01 kernel: EIP:    0060:[<c0176356>]    Not tainted VLI
Aug 20 03:43:11 a01 kernel: EFLAGS: 00010206   (2.6.17.8 #1)
Aug 20 03:43:11 a01 kernel: EIP is at dqput+0xe/0x152
Aug 20 03:43:11 a01 kernel: eax: 02000000   ebx: 02000000   ecx: f5fd0c00   edx: 00000000
Aug 20 03:43:11 a01 kernel: esi: eb7c15b4   edi: c2175e5c   ebp: 00000056   esp: c2175e38
Aug 20 03:43:12 a01 kernel: ds: 007b   es: 007b   ss: 0068
Aug 20 03:43:12 a01 kernel: Process kswapd0 (pid: 127, threadinfo=c2174000 task=c2161030)
Aug 20 03:43:12 a01 kernel: Stack: c01a6845 00000000 c0149797 00000000 00000000 c0176e09 00000000 eb7c15b4
Aug 20 03:43:12 a01 kernel:        c01983d4 f5fd0c00 00000001 00000000 00000000 00a8040d 00000000 c22288d0
Aug 20 03:43:12 a01 kernel:        c2175e78 c2175e78 c01cedb6 c22288c0 00000282 eb7c15b4 02000000 c2175ec8
Aug 20 03:43:12 a01 kernel: Call Trace:
Aug 20 03:43:12 a01 kernel:  <c01a6845> journal_begin+0x64/0xe9  <c0149797> slab_destroy+0x21/0x4e
Aug 20 03:43:12 a01 kernel:  <c0176e09> dquot_drop+0x5b/0x68  <c01983d4> reiserfs_dquot_drop+0x37/0x74
Aug 20 03:43:12 a01 kernel:  <c01cedb6> memmove+0x20/0x26  <c0162571> clear_inode+0x13d/0x13f
Aug 20 03:43:12 a01 kernel:  <c016258e> dispose_list+0x1b/0xaa  <c0162894> prune_icache+0x127/0x17d
Aug 20 03:43:12 a01 kernel:  <c01628fe> shrink_icache_memory+0x14/0x37  <c0138e8e> shrink_slab+0x14f/0x1cb
Aug 20 03:43:12 a01 kernel:  <c0136e3c> throttle_vm_writeout+0x2f/0x5d  <c013a175> balance_pgdat+0x28d/0x39d
Aug 20 03:43:12 a01 kernel:  <c013a36b> kswapd+0xe6/0x125  <c012755d> autoremove_wake_function+0x0/0x37
Aug 20 03:43:12 a01 kernel:  <c012755d> autoremove_wake_function+0x0/0x37  <c013a285> kswapd+0x0/0x125
Aug 20 03:43:12 a01 kernel:  <c010132d> kernel_thread_helper+0x5/0xb
Aug 20 03:43:12 a01 kernel: Code: ba 1f 85 eb 51 89 c8 f7 ea 89 c8 c1 f8 1f c1 fa 05 29 c2 0f af 15 c4 43 36 c0 89 d0 c3 53 89 c3 83 ec 10 85 c0 0f 84 98 00 00 00 <8b> 40 44 85 c0 0f 84 92 00 00 00 83 05 a4 fa 3a c0 01 eb 35 0f
Aug 20 03:43:12 a01 kernel: EIP: [dqput+14/338] dqput+0xe/0x152 SS:ESP 0068:c2175e38
Aug 20 03:43:12 a01 kernel: EIP: [<c0176356>] dqput+0xe/0x152 SS:ESP 0068:c2175e38
Aug 20 03:43:12 a01 kernel:  BUG: warning at kernel/exit.c:855/do_exit()
Aug 20 03:43:12 a01 kernel:  <c011a3e6> do_exit+0x39d/0x3a2  <c0103e77> do_trap+0x0/0xad
Aug 20 03:43:12 a01 kernel:  <c0113237> do_page_fault+0x0/0x5b4  <c0113237> do_page_fault+0x0/0x5b4
Aug 20 03:43:12 a01 kernel:  <c01135bf> do_page_fault+0x388/0x5b4  <c01a63fd> do_journal_begin_r+0x26/0x2ad
Aug 20 03:43:12 a01 kernel:  <c0113237> do_page_fault+0x0/0x5b4  <c0103687> error_code+0x4f/0x54
Aug 20 03:43:12 a01 kernel:  <c0176356> dqput+0xe/0x152  <c01a6845> journal_begin+0x64/0xe9
Aug 20 03:43:12 a01 kernel:  <c0149797> slab_destroy+0x21/0x4e  <c0176e09> dquot_drop+0x5b/0x68
Aug 20 03:43:12 a01 kernel:  <c01983d4> reiserfs_dquot_drop+0x37/0x74  <c01cedb6> memmove+0x20/0x26
Aug 20 03:43:12 a01 kernel:  <c0162571> clear_inode+0x13d/0x13f  <c016258e> dispose_list+0x1b/0xaa
Aug 20 03:43:12 a01 kernel:  <c0162894> prune_icache+0x127/0x17d  <c01628fe> shrink_icache_memory+0x14/0x37
Aug 20 03:43:12 a01 kernel:  <c0138e8e> shrink_slab+0x14f/0x1cb  <c0136e3c> throttle_vm_writeout+0x2f/0x5d
Aug 20 03:43:12 a01 kernel:  <c013a175> balance_pgdat+0x28d/0x39d  <c013a36b> kswapd+0xe6/0x125
Aug 20 03:43:12 a01 kernel:  <c012755d> autoremove_wake_function+0x0/0x37  <c012755d> autoremove_wake_function+0x0/0x37
Aug 20 03:43:12 a01 kernel:  <c013a285> kswapd+0x0/0x125  <c010132d> kernel_thread_helper+0x5/0xb
Aug 20 03:43:12 a01 kernel: BUG: kswapd0/127, lock held at task exit time!
Aug 20 03:43:12 a01 kernel:  [c0314460] {iprune_mutex}
Aug 20 03:43:12 a01 kernel: .. held by:           kswapd0:  127 [c2161030, 115]
Aug 20 03:43:12 a01 kernel: ... acquired at:               prune_icache+0x30/0x17d


Kernel: Linux a01 2.6.17.8 #1 Fri Aug 11 17:17:30 CEST 2006 i686 i686 i386 GNU/Linux

a01:~ # lspci
0000:00:00.0 Host bridge: Intel Corp. 82875P Memory Controller Hub (rev 02)
0000:00:01.0 PCI bridge: Intel Corp. 82875P Processor to AGP Controller (rev 02)
0000:00:03.0 PCI bridge: Intel Corp. 82875P Processor to PCI to CSA Bridge (rev 02)
0000:00:1d.0 USB Controller: Intel Corp. 82801EB USB (rev 02)
0000:00:1d.1 USB Controller: Intel Corp. 82801EB USB (rev 02)
0000:00:1d.2 USB Controller: Intel Corp. 82801EB USB (rev 02)
0000:00:1d.3 USB Controller: Intel Corp. 82801EB USB (rev 02)
0000:00:1d.7 USB Controller: Intel Corp. 82801EB USB2 (rev 02)
0000:00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB PCI Bridge (rev c2)
0000:00:1f.0 ISA bridge: Intel Corp. 82801EB LPC Interface Controller (rev 02)
0000:00:1f.3 SMBus: Intel Corp. 82801EB SMBus Controller (rev 02)
0000:02:01.0 Ethernet controller: Intel Corp. 82547EI Gigabit Ethernet Controller (LOM)
0000:03:00.0 SCSI storage controller: Adaptec AIC-7892A U160/m (rev 02)
0000:03:02.0 Ethernet controller: Intel Corp. 82541EI Gigabit Ethernet Controller (Copper)
0000:03:07.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
0000:03:08.0 Ethernet controller: Intel Corp.: Unknown device 1051 (rev 02)

a01:~ # cat /proc/meminfo 
MemTotal:      2076832 kB
MemFree:         29308 kB
Buffers:         90920 kB
Cached:        1617120 kB
SwapCached:          0 kB
Active:         307080 kB
Inactive:      1637088 kB
HighTotal:     1179584 kB
HighFree:         1064 kB
LowTotal:       897248 kB
LowFree:         28244 kB
SwapTotal:     2104472 kB
SwapFree:      2104472 kB
Dirty:              84 kB
Writeback:           0 kB
Mapped:         249268 kB
Slab:            92460 kB
CommitLimit:   3142888 kB
Committed_AS:  1017124 kB
PageTables:       3864 kB
VmallocTotal:   114680 kB
VmallocUsed:      3820 kB
VmallocChunk:   110376 kB
HugePages_Total:     0
HugePages_Free:      0
HugePages_Rsvd:      0
Hugepagesize:     4096 kB


