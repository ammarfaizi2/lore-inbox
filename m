Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266472AbUHIKtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266472AbUHIKtK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 06:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266473AbUHIKtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 06:49:10 -0400
Received: from [194.243.27.136] ([194.243.27.136]:59407 "HELO
	venere.pandoraonline.it") by vger.kernel.org with SMTP
	id S266472AbUHIKrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 06:47:13 -0400
X-Qmail-Scanner-Mail-From: devel@integra-sc.it via venere.pandoraonline.it
X-Qmail-Scanner-Rcpt-To: linux-kernel@vger.kernel.org
X-Qmail-Scanner: 1.22 (Clear:RC:1(213.140.22.76):. Processed in 0.100997 secs)
Date: Mon, 9 Aug 2004 12:52:35 +0200
From: Devel <devel@integra-sc.it>
To: linux-kernel@vger.kernel.org
Subject: oops and kernel panic in kernel 2.6.7
Message-Id: <20040809125235.31d27327.devel@integra-sc.it>
Organization: Integra Solutions
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I have an oops in kernel 2.6.7 with gcc 3.4.0 and swap disabled (/sbin/swapoff -a).
My linux box is a Red Hat 7.3 with new kernel nex gcc new mofutils and new binutils.



Aug  8 22:00:03 makina kernel: Unable to handle kernel paging request at virtual address 23232327
Aug  8 22:00:03 makina kernel:  printing eip:
Aug  8 22:00:03 makina kernel: c0140faf
Aug  8 22:00:03 makina kernel: *pde = 00000000
Aug  8 22:00:03 makina kernel: Oops: 0002 [#1]
Aug  8 22:00:03 makina kernel: PREEMPT
Aug  8 22:00:03 makina kernel: Modules linked in: bttv video_buf i2c_algo_bit v4l2_common btcx_risc i2c_core videodev
Aug  8 22:00:03 makina kernel: CPU:    0
Aug  8 22:00:03 makina kernel: EIP:    0060:[<c0140faf>]    Not tainted
Aug  8 22:00:03 makina kernel: EFLAGS: 00010012   (2.6.7)
Aug  8 22:00:03 makina kernel: EIP is at free_block+0x6f/0xe0
Aug  8 22:00:03 makina kernel: eax: 23232323   ebx: dfb42000   ecx: dfb42d14   edx: dfb29000
Aug  8 22:00:03 makina kernel: esi: f7fd2c60   edi: 00000009   ebp: f7fd2c6c   esp: f7d42dac
Aug  8 22:00:03 makina kernel: ds: 007b   es: 007b   ss: 0068
Aug  8 22:00:03 makina kernel: Process kswapd0 (pid: 69, threadinfo=f7d42000 task=f7da6050)
Aug  8 22:00:03 makina kernel: Stack: 00000000 00000000 f7fd2c7c f7fcb010 00000282 dfb297cc f7ffeae8 c014107c
Aug  8 22:00:03 makina kernel:        f7fd2c60 f7fcb010 0000003c f7d42ddc 0000003c f7fcb000 00000282 dfb297cc
Aug  8 22:00:03 makina kernel:        f7d42ee0 c0141547 f7fd2c60 f7fcb000 f7d42000 c13ccf60 00000001 c015c4e8
Aug  8 22:00:03 makina kernel: Call Trace:
Aug  8 22:00:03 makina kernel:  [<c014107c>] cache_flusharray+0x5c/0x190
Aug  8 22:00:03 makina kernel:  [<c0141547>] kmem_cache_free+0x47/0x50
Aug  8 22:00:03 makina kernel:  [<c015c4e8>] free_buffer_head+0x28/0x60
Aug  8 22:00:03 makina kernel:  [<c015c2fe>] try_to_free_buffers+0x6e/0xc0
Aug  8 22:00:03 makina kernel:  [<c0143c11>] shrink_list+0x3c1/0x510
Aug  8 22:00:03 makina kernel:  [<c0143eb1>] shrink_cache+0x151/0x360
Aug  8 22:00:03 makina kernel:  [<c0144706>] shrink_zone+0xf6/0x100
Aug  8 22:00:03 makina kernel:  [<c0144a86>] balance_pgdat+0x186/0x230
Aug  8 22:00:03 makina kernel:  [<c0144bf1>] kswapd+0xc1/0xe0
Aug  8 22:00:03 makina kernel:  [<c0118c40>] autoremove_wake_function+0x0/0x60
Aug  8 22:00:03 makina kernel:  [<c0106032>] ret_from_fork+0x6/0x14
Aug  8 22:00:03 makina kernel:  [<c0118c40>] autoremove_wake_function+0x0/0x60
Aug  8 22:00:03 makina kernel:  [<c0144b30>] kswapd+0x0/0xe0
Aug  8 22:00:03 makina kernel:  [<c01042a5>] kernel_thread_helper+0x5/0x10
Aug  8 22:00:03 makina kernel:
Aug  8 22:00:03 makina kernel: Code: 89 50 04 89 02 31 d2 2b 4b 0c c7 03 00 01 10 00 c7 43 04 00
Aug  8 22:00:03 makina kernel:  <6>note: kswapd0[69] exited with preempt_count 1
Aug  8 22:00:07 makina kernel: Unable to handle kernel paging request at virtual address 23232327
Aug  8 22:00:07 makina kernel:  printing eip:
Aug  8 22:00:07 makina kernel: c0140faf
Aug  8 22:00:07 makina kernel: *pde = 00000000
Aug  8 22:00:07 makina kernel: Oops: 0002 [#2]
Aug  8 22:00:07 makina kernel: PREEMPT
Aug  8 22:00:07 makina kernel: Modules linked in: bttv video_buf i2c_algo_bit v4l2_common btcx_risc i2c_core videodev
Aug  8 22:00:07 makina kernel: CPU:    0
Aug  8 22:00:07 makina kernel: EIP:    0060:[<c0140faf>]    Not tainted
Aug  8 22:00:07 makina kernel: EFLAGS: 00010012   (2.6.7)
Aug  8 22:00:07 makina kernel: EIP is at free_block+0x6f/0xe0
Aug  8 22:00:07 makina kernel: eax: 23232323   ebx: dfb42000   ecx: dfb42d14   edx: dfb29000
Aug  8 22:00:07 makina kernel: esi: f7fd2c60   edi: 00000009   ebp: f7fd2c6c   esp: f4e63e08
Aug  8 22:00:07 makina kernel: ds: 007b   es: 007b   ss: 0068
Aug  8 22:00:07 makina kernel: Process mysqld (pid: 8247, threadinfo=f4e63000 task=f1b4c450)
Aug  8 22:00:07 makina kernel: Stack: e2ff05bc 00000000 f7fd2c7c f7fcb010 00000286 c0ae7938 f7ffeae8 c014107c
Aug  8 22:00:07 makina kernel:        f7fd2c60 f7fcb010 0000003c f4e63e60 0000003c f7fcb000 00000286 c0ae7938
Aug  8 22:00:07 makina kernel:        c0ae7938 c0141547 f7fd2c60 f7fcb000 f4e63000 c1670860 00000001 c015c4e8
Aug  8 22:00:07 makina kernel: Call Trace:
Aug  8 22:00:07 makina kernel:  [<c014107c>] cache_flusharray+0x5c/0x190
Aug  8 22:00:07 makina kernel:  [<c0141547>] kmem_cache_free+0x47/0x50
Aug  8 22:00:07 makina kernel:  [<c015c4e8>] free_buffer_head+0x28/0x60
Aug  8 22:00:07 makina kernel:  [<c015c2fe>] try_to_free_buffers+0x6e/0xc0
Aug  8 22:00:07 makina kernel:  [<c01d2da1>] journal_invalidatepage+0xb1/0x120
Aug  8 22:00:07 makina kernel:  [<c01c476a>] ext3_invalidatepage+0x3a/0x40
Aug  8 22:00:07 makina kernel:  [<c0142d88>] truncate_complete_page+0x68/0x80
Aug  8 22:00:07 makina kernel:  [<c0142fc3>] truncate_inode_pages+0x143/0x2c0
Aug  8 22:00:07 makina kernel:  [<c017286c>] iput+0x3c/0x90
Aug  8 22:00:07 makina kernel:  [<c017265e>] generic_delete_inode+0xfe/0x120
Aug  8 22:00:07 makina kernel:  [<c0167d11>] sys_unlink+0xa1/0x180
Aug  8 22:00:07 makina kernel:  [<c01565f8>] sys_close+0x58/0xb0
Aug  8 22:00:07 makina kernel:  [<c010615b>] syscall_call+0x7/0xb
Aug  8 22:00:07 makina kernel:
Aug  8 22:00:07 makina kernel: Code: 89 50 04 89 02 31 d2 2b 4b 0c c7 03 00 01 10 00 c7 43 04 00
Aug  8 22:00:07 makina kernel:  <6>note: mysqld[8247] exited with preempt_count 1
Aug  8 22:00:07 makina kernel: Debug: sleeping function called from invalid context at include/linux/rwsem.h:43
Aug  8 22:00:07 makina kernel: in_atomic():1, irqs_disabled():0
Aug  8 22:00:07 makina kernel:  [<c011882b>] __might_sleep+0xbb/0xd0
Aug  8 22:00:07 makina kernel:  [<c011d297>] do_exit+0xa7/0x440
Aug  8 22:00:07 makina kernel:  [<c0115bb0>] do_page_fault+0x0/0x55c
Aug  8 22:00:07 makina kernel:  [<c0106a2b>] die+0xfb/0x100
Aug  8 22:00:07 makina kernel:  [<c0115f37>] do_page_fault+0x387/0x55c
Aug  8 22:00:07 makina kernel:  [<c0159f57>] __getblk+0x37/0x70
Aug  8 22:00:07 makina kernel:  [<c01c636d>] ext3_do_update_inode+0x1dd/0x3b0
Aug  8 22:00:07 makina kernel:  [<c01d1813>] journal_get_write_access+0x43/0x60
Aug  8 22:00:07 makina kernel:  [<c01c335f>] ext3_get_block_handle+0xbf/0x370
Aug  8 22:00:07 makina kernel:  [<c0115bb0>] do_page_fault+0x0/0x55c
Aug  8 22:00:07 makina kernel:  [<c0106305>] error_code+0x2d/0x38
Aug  8 22:00:07 makina kernel:  [<c0140faf>] free_block+0x6f/0xe0
Aug  8 22:00:07 makina kernel:  [<c014107c>] cache_flusharray+0x5c/0x190
Aug  8 22:00:07 makina kernel:  [<c0141547>] kmem_cache_free+0x47/0x50
Aug  8 22:00:07 makina kernel:  [<c015c4e8>] free_buffer_head+0x28/0x60
Aug  8 22:00:07 makina kernel:  [<c015c2fe>] try_to_free_buffers+0x6e/0xc0
Aug  8 22:00:07 makina kernel:  [<c01d2da1>] journal_invalidatepage+0xb1/0x120
Aug  8 22:00:07 makina kernel:  [<c01c476a>] ext3_invalidatepage+0x3a/0x40
Aug  8 22:00:07 makina kernel:  [<c0142d88>] truncate_complete_page+0x68/0x80
Aug  8 22:00:07 makina kernel:  [<c0142fc3>] truncate_inode_pages+0x143/0x2c0
Aug  8 22:00:07 makina kernel:  [<c017286c>] iput+0x3c/0x90
Aug  8 22:00:07 makina kernel:  [<c017265e>] generic_delete_inode+0xfe/0x120
Aug  8 22:00:07 makina kernel:  [<c0167d11>] sys_unlink+0xa1/0x180
Aug  8 22:00:07 makina kernel:  [<c01565f8>] sys_close+0x58/0xb0
Aug  8 22:00:07 makina kernel:  [<c010615b>] syscall_call+0x7/0xb
Aug  8 22:00:07 makina kernel:

[root@makina log]# lspci -vv | more
00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 3189 (rev 80)
        Subsystem: Giga-byte Technology: Unknown device 5000
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
        Latency: 8
        Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [80] AGP version 3.5
                Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device b198 (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: e0000000-e1ffffff
        Prefetchable memory behind bridge: d8000000-dfffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:0a.0 PCI bridge: Hint Corp HB1-SE33 PCI-PCI Bridge (rev 15) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
        Prefetchable memory behind bridge: 00000000e2000000-00000000e2000000
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [90] #06 [0080]
        Capabilities: [a0] Vital Product Data
 
00:0b.0 PCI bridge: Hint Corp HB1-SE33 PCI-PCI Bridge (rev 15) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=32
        Prefetchable memory behind bridge: 00000000e2100000-00000000e2100000
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [90] #06 [0080]
        Capabilities: [a0] Vital Product Data
 
00:0c.0 PCI bridge: Hint Corp HB1-SE33 PCI-PCI Bridge (rev 15) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Bus: primary=00, secondary=04, subordinate=04, sec-latency=32
        Prefetchable memory behind bridge: 00000000e2200000-00000000e2200000
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [90] #06 [0080]
        Capabilities: [a0] Vital Product Data
 
00:0d.0 PCI bridge: Hint Corp HB1-SE33 PCI-PCI Bridge (rev 15) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Bus: primary=00, secondary=05, subordinate=05, sec-latency=32
        Prefetchable memory behind bridge: 00000000e2300000-00000000e2300000
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [90] #06 [0080]
        Capabilities: [a0] Vital Product Data
 
00:11.0 ISA bridge: VIA Technologies, Inc.: Unknown device 3177
        Subsystem: Giga-byte Technology: Unknown device 5001
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:11.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
        Subsystem: Giga-byte Technology: Unknown device 5002
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 11
        Region 4: I/O ports at e000 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 74)
        Subsystem: Giga-byte Technology: Unknown device e000
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (750ns min, 2000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at e400 [size=256]
        Region 1: Memory at e2400000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon VE QY (prog-if 00 [VGA])
        Subsystem: Palit Microsystems Inc.: Unknown device 5159
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at d8000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at d000 [size=256]
        Region 2: Memory at e1000000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [58] AGP version 2.0
                Status: RQ=47 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA+ AGP- 64bit- FW- Rate=<none>
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
02:04.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4000ns min, 10000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at e2000000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
02:04.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at e2001000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
02:05.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
        Subsystem: Unknown device 0001:a155
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4000ns min, 10000ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at e2002000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
02:05.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
        Subsystem: Unknown device 0001:a155
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at e2003000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
02:06.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
        Subsystem: Unknown device 0002:a155
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4000ns min, 10000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e2004000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
02:06.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
        Subsystem: Unknown device 0002:a155
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e2005000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
02:07.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
        Subsystem: Unknown device 0003:a155
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 6
        Region 0: Memory at e2007000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
03:04.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
        Subsystem: Ncipher Corp Ltd: Unknown device a155
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4000ns min, 10000ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at e2100000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
03:04.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
        Subsystem: Ncipher Corp Ltd: Unknown device a155
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at e2101000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
03:05.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)

02:07.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
        Subsystem: Unknown device 0003:a155
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4000ns min, 10000ns max)
        Interrupt: pin A routed to IRQ 6
        Region 0: Memory at e2006000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
03:05.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
        Subsystem: Unknown device 0101:a155
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4000ns min, 10000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e2102000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
03:05.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
        Subsystem: Unknown device 0101:a155
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e2103000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
03:06.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
        Subsystem: Unknown device 0102:a155
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4000ns min, 10000ns max)
        Interrupt: pin A routed to IRQ 6
        Region 0: Memory at e2104000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
03:06.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
        Subsystem: Unknown device 0102:a155
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 6
        Region 0: Memory at e2105000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
03:07.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
        Subsystem: Unknown device 0103:a155
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4000ns min, 10000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at e2106000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
03:07.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
        Subsystem: Unknown device 0103:a155
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at e2107000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
04:04.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
        Subsystem: Unknown device 0200:a155
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4000ns min, 10000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e2200000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
                                                                                                                             
04:04.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
        Subsystem: Unknown device 0200:a155
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e2201000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
04:05.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
        Subsystem: Unknown device 0201:a155
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4000ns min, 10000ns max)
        Interrupt: pin A routed to IRQ 6
        Region 0: Memory at e2202000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
04:05.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
        Subsystem: Unknown device 0201:a155
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 6
        Region 0: Memory at e2203000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
04:06.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
        Subsystem: Unknown device 0202:a155
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4000ns min, 10000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at e2204000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
04:06.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
        Subsystem: Unknown device 0202:a155
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at e2205000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
04:07.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
        Subsystem: Unknown device 0203:a155
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4000ns min, 10000ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at e2206000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
04:07.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
        Subsystem: Unknown device 0203:a155
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at e2207000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
05:04.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4000ns min, 10000ns max)
        Interrupt: pin A routed to IRQ 6
        Region 0: Memory at e2300000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
05:04.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 6
        Region 0: Memory at e2301000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
05:05.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
        Subsystem: Unknown device 0001:a155
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4000ns min, 10000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at e2302000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
05:05.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
        Subsystem: Unknown device 0001:a155
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at e2303000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
05:06.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
        Subsystem: Unknown device 0002:a155
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4000ns min, 10000ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at e2304000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
05:06.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
        Subsystem: Unknown device 0002:a155
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at e2305000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
05:07.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
        Subsystem: Unknown device 0003:a155
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4000ns min, 10000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e2306000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
               Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
05:06.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
        Subsystem: Unknown device 0002:a155
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at e2305000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
05:07.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
        Subsystem: Unknown device 0003:a155
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4000ns min, 10000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e2306000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
05:07.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
        Subsystem: Unknown device 0003:a155
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e2307000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


