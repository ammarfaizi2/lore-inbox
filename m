Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313084AbSDDBqT>; Wed, 3 Apr 2002 20:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313083AbSDDBqL>; Wed, 3 Apr 2002 20:46:11 -0500
Received: from t1-11.realtime.net ([205.238.131.11]:4570 "EHLO
	bella.auschron.com") by vger.kernel.org with ESMTP
	id <S313084AbSDDBp7>; Wed, 3 Apr 2002 20:45:59 -0500
Date: Wed, 3 Apr 2002 19:45:58 -0600
From: Lindsey Simon <lsimon@auschron.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.18 dies
Message-ID: <20020404014558.GA2069@bella.auschron.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-OS: Linux bella 2.4.18pre1
X-mailer: Mutt 1.3.25i (2002-01-01)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's from the syslog

Apr  3 15:19:46 chief kernel: invalid operand: 0000
Apr  3 15:19:46 chief kernel: CPU:    0
Apr  3 15:19:46 chief kernel: EIP:    0010:[rmqueue+413/464]    Not
tainted
Apr  3 15:19:46 chief kernel: EFLAGS: 00010202
Apr  3 15:19:46 chief kernel: eax: 0000004c   ebx: c02b518c   ecx:
c02b5168   ed
x: 00002f68
Apr  3 15:19:46 chief kernel: esi: c10bda00   edi: 00000001   ebp:
00000002   es
p: c2d7bf30
Apr  3 15:19:46 chief kernel: ds: 0018   es: 0018   ss: 0018
Apr  3 15:19:46 chief kernel: Process master (pid: 2329,
stackpage=c2d7b000)
Apr  3 15:19:46 chief kernel: Stack: c02b52bc 000001c0 00000001
c02b5168 00001f6
8 00000282 00000001 c02b5168
Apr  3 15:19:46 chief kernel:        c012d26f 000001f0 080634e0
08054e17 0000001
1 c02b52b8 000001f0 c6e914c0
Apr  3 15:19:46 chief kernel:        c012d0c2 c2d7a000 c012d3a6
c0114c63 c2d7a00
0 080634e0 08054e17 c2d7bfbc
Apr  3 15:19:46 chief kernel: Call Trace: [__alloc_pages+59/360]
[_alloc_pages+2
2/24] [__get_free_pages+10/24] [do_fork+67/1800] [sys_time+20/84]
Apr  3 15:19:46 chief kernel:    [sys_fork+19/24]
[system_call+51/64]
Apr  3 15:19:46 chief kernel:
Apr  3 15:19:46 chief kernel: Code: 0f 0b 8b 46 18 a8 80 74 02 0f
0b 89 f0 eb 1b
 47 83 c5 0c 83


2.4.18 kernel on a debian potato system
running postfix - here's another:

Apr  3 16:07:03 chief kernel:  invalid operand: 0000
Apr  3 16:07:03 chief kernel: CPU:    0
Apr  3 16:07:03 chief kernel: EIP:    0010:[rmqueue+413/464]    Not
tainted
Apr  3 16:07:03 chief kernel: EFLAGS: 00010202
Apr  3 16:07:03 chief kernel: eax: 000000cc   ebx: c02b518c   ecx:
c02b5168   ed
x: 00002f62
Apr  3 16:07:03 chief kernel: esi: c10bd880   edi: 00000001   ebp:
00000002   es
p: c7735f30
Apr  3 16:07:03 chief kernel: ds: 0018   es: 0018   ss: 0018
Apr  3 16:07:03 chief kernel: Process postfix-script (pid: 7943,
stackpage=c7735
000)
Apr  3 16:07:03 chief kernel: Stack: c02b52bc 000001c0 00000001
c02b5168 00001f6
2 00000282 00000001 c02b5168
Apr  3 16:07:03 chief kernel:        c012d26f 000001f0 bfffe10c
00000000 0000001
1 c02b52b8 000001f0 080d0000
Apr  3 16:07:03 chief kernel:        c012d0c2 c7734000 c012d3a6
c0114c63 c773400
0 bfffe10c 00000000 c7735fbc
Apr  3 16:07:03 chief kernel: Call Trace: [__alloc_pages+59/360]
[_alloc_pages+2
2/24] [__get_free_pages+10/24] [do_fork+67/1800] [sys_fork+19/24]
Apr  3 16:07:03 chief kernel:    [system_call+51/64]
Apr  3 16:07:03 chief kernel:
Apr  3 16:07:03 chief kernel: Code: 0f 0b 8b 46 18 a8 80 74 02 0f
0b 89 f0 eb 1b
 47 83 c5 0c 83

and lastly:

Apr  3 16:07:52 chief kernel:  invalid operand: 0000
Apr  3 16:07:52 chief kernel: CPU:    0
Apr  3 16:07:52 chief kernel: EIP:    0010:[rmqueue+413/464]    Not
tainted
Apr  3 16:07:52 chief kernel: EFLAGS: 00010202
Apr  3 16:07:52 chief kernel: eax: 0000004c   ebx: c02b5180   ecx:
c02b5168   ed
x: 00002f43
Apr  3 16:07:52 chief kernel: esi: c10bd0c0   edi: 00000000   ebp:
00000001   es
p: c3787ea8
Apr  3 16:07:52 chief kernel: ds: 0018   es: 0018   ss: 0018
Apr  3 16:07:52 chief kernel: Process find (pid: 7963,
stackpage=c3787000)
Apr  3 16:07:52 chief kernel: Stack: c02b52dc 000001bf 00000000
c02b5168 00001f4
3 00000286 00000000 c02b5168
Apr  3 16:07:52 chief kernel:        c012d26f 000001d2 c123ea0c
00000000 c4edc6b
0 c02b52d8 000001d2 c0127af5
Apr  3 16:07:52 chief kernel:        c012d0c2 00000000 c0127b0c
00000000 0000000
0 00000000 00000000 c0154b65
Apr  3 16:07:52 chief kernel: Call Trace: [__alloc_pages+59/360]
[read_cache_pag
e+61/288] [_alloc_pages+22/24] [read_cache_page+84/288]
[ext2_get_page+29/112]
Apr  3 16:07:52 chief kernel:    [ext2_readpage+0/20]
[ext2_readdir+222/504] [vf
s_readdir+140/208] [filldir64+0/276] [sys_getdents64+79/179]
[filldir64+0/276]
Apr  3 16:07:52 chief kernel:    [sys_fcntl64+127/136]
[system_call+51/64]
Apr  3 16:07:52 chief kernel:
Apr  3 16:07:52 chief kernel: Code: 0f 0b 8b 46 18 a8 80 74 02 0f
0b 89 f0 eb 1b
 47 83 c5 0c 83
Apr  3 16:07:52 chief kernel:  invalid operand: 0000
Apr  3 16:07:52 chief kernel: CPU:    0
Apr  3 16:07:52 chief kernel: EIP:    0010:[rmqueue+413/464]    Not
tainted
Apr  3 16:07:52 chief kernel: EFLAGS: 00010202
Apr  3 16:07:52 chief kernel: eax: 0000004c   ebx: c02b5180   ecx:
c02b5168   ed
x: 00002f58
Apr  3 16:07:52 chief kernel: esi: c10bd600   edi: 00000000   ebp:
00000001   es
p: c3787eb8
Apr  3 16:07:52 chief kernel: ds: 0018   es: 0018   ss: 0018
Apr  3 16:07:52 chief kernel: Process postfix-script (pid: 7964,
stackpage=c3787
000)
Apr  3 16:07:52 chief kernel: Stack: c02b52bc 000001bf 00000000
c02b5168 00001f5
8 00000282 00000000 c02b5168
Apr  3 16:07:52 chief kernel:        c012d26f 000001f0 bfffc000
bfffc000 c4f45bf
c c02b52b8 000001f0 00000000
Apr  3 16:07:52 chief kernel:        c012d0c2 00000000 c012d3a6
c01237c5 c36b25c
0 c29f3ff0 bfffc000 c76f9a40
Apr  3 16:07:52 chief kernel: Call Trace: [__alloc_pages+59/360]
[_alloc_pages+2
2/24] [__get_free_pages+10/24] [pte_alloc+105/208]
[copy_page_range+221/444]
Apr  3 16:07:52 chief kernel:    [copy_mm+587/740]
[do_fork+1128/1800] [sys_fork
+19/24] [system_call+51/64]
Apr  3 16:07:52 chief kernel:
Apr  3 16:07:52 chief kernel: Code: 0f 0b 8b 46 18 a8 80 74 02 0f
0b 89 f0 eb 1b
 47 83 c5 0c 83

AMD-K6(tm) 3D+ Processor

chief:/home/lsimon# lspci -vvv
00:00.0 Host bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3]
(rev 04)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 16
        Region 0: Memory at f0000000 (32-bit, prefetchable)
[size=64M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=7 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo
MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01,
sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset-
FastB2B-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA
[Apollo VP] (rev 47)
        Subsystem: VIA Technologies, Inc. MVP3 ISA Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev
06) (prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at 6400 [size=16]

00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 02)
(prog-if 00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 5
        Region 4: I/O ports at 6800 [size=32]

00:07.3 Host bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 10)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9

00:0b.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast
Etherlink] (rev 74)
        Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC
Management NIC
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2500ns min, 2500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at 6c00 [size=128]
        Region 1: Memory at f6000000 (32-bit, non-prefetchable)
[size=128]
        Expansion ROM at f5000000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:0c.0 VGA compatible controller: Tseng Labs Inc ET4000/W32p rev C
(prog-if 00 [VGA])
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 12
        Region 0: Memory at f4000000 (32-bit, non-prefetchable)
[size=16M]
        Expansion ROM at e0000000 [disabled] [size=256M]


Thanks!!
-lindsey


