Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266448AbUBEDDO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 22:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266461AbUBEDDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 22:03:14 -0500
Received: from mx1.elte.hu ([157.181.1.137]:11980 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266448AbUBEDCc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 22:02:32 -0500
To: akpm@osdl.org, linux-kernel@vger.kernel.org, thomas@winischhofer.net
Subject: [BUG 2.6.2-rc2-mm1] Maybe in new sisfb driver.
Message-Id: <20040205030226.D9A941693E@draconis.elte.hu>
Date: Thu,  5 Feb 2004 04:02:26 +0100 (CET)
From: andrej@draconis.elte.hu (Meszaros Andras)
X-ELTE-SpamVersion: MailScanner-4.26.8-itk2 SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.8, required 5.9, BAYES_00 -4.90,
	HTML_MESSAGE 0.10
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To: linux-kernel@vger.kernel.org,thomas@winischhofer.net,akpm@osdl.org
Subject: [BUG 2.6.2-rc2-mm1] Maybe in new sisfb driver.

Hi!

Feb  5 06:34:04 opata kernel: ------------[ cut here ]------------
Feb  5 06:34:04 opata kernel: kernel BUG at include/linux/list.h:148!
Feb  5 06:34:04 opata kernel: invalid operand: 0000 [#1]
Feb  5 06:34:04 opata kernel: PREEMPT
Feb  5 06:34:04 opata kernel: CPU:    0
Feb  5 06:34:04 opata kernel: EIP:    0060:[generic_forget_inode+369/382]    Not tainted VLI
Feb  5 06:34:04 opata kernel: EFLAGS: 00010213
Feb  5 06:34:04 opata kernel: EIP is at generic_forget_inode+0x171/0x17e
Feb  5 06:34:04 opata kernel: eax: c137360c   ebx: c151240c   ecx: c0006914   edx: c1512414
Feb  5 06:34:04 opata kernel: esi: c151240c   edi: c1390400   ebp: 00000068   esp: c13e3e4c
Feb  5 06:34:04 opata kernel: ds: 007b   es: 007b   ss: 0068
Feb  5 06:34:04 opata kernel: Process kswapd0 (pid: 7, threadinfo=c13e2000 task=c13e7310)
Feb  5 06:34:04 opata kernel: Stack: c016dfbb cf06a38c c1519a80 c151240c c151240c c13e2000 c016f003 c151240c
Feb  5 06:34:04 opata kernel:        c039d740 c1513980 c016c4fe c151240c c13e3e78 00000080 c13e2000 00000246
Feb  5 06:34:04 opata kernel:        cf7eeb20 c016c9ff 00000080 c0144e0a 00000080 000000d0 000088da 0204b270
Feb  5 06:34:04 opata kernel: Call Trace:
Feb  5 06:34:04 opata kernel:  [dispose_list+90/199] dispose_list+0x5a/0xc7
Feb  5 06:34:04 opata kernel:  [iput+98/124] iput+0x62/0x7c
Feb  5 06:34:04 opata kernel:  [prune_dcache+369/489] prune_dcache+0x171/0x1e9
Feb  5 06:34:04 opata kernel:  [shrink_dcache_memory+35/37] shrink_dcache_memory+0x23/0x25
Feb  5 06:34:04 opata kernel:  [shrink_slab+283/350] shrink_slab+0x11b/0x15e
Feb  5 06:34:04 opata kernel:  [balance_pgdat+510/542] balance_pgdat+0x1fe/0x21e
Feb  5 06:34:04 opata kernel:  [kswapd+274/290] kswapd+0x112/0x122
Feb  5 06:34:04 opata kernel:  [autoremove_wake_function+0/79] autoremove_wake_function+0x0/0x4f
Feb  5 06:34:04 opata kernel:  [ret_from_fork+6/20] ret_from_fork+0x6/0x14
Feb  5 06:34:04 opata kernel:  [autoremove_wake_function+0/79] autoremove_wake_function+0x0/0x4f
Feb  5 06:34:04 opata kernel:  [kswapd+0/290] kswapd+0x0/0x122
Feb  5 06:34:04 opata kernel:  [kernel_thread_helper+5/11] kernel_thread_helper+0x5/0xb
Feb  5 06:34:04 opata kernel:
Feb  5 06:34:04 opata kernel: Code: 00 00 00 89 04 24 e8 ea 56 fd ff eb c9 e8 1b fa fa ff eb b8 e8 14 fa fa ff e9 1b ff ff ff 0f 0b 95 00 dd 93 2b c0 e9 cd fe ff ff <0f> 0b 94 00 dd 93 2b c0 e9 b4 fe ff ff 8b 44 24 04 8b 50 2c 85
Feb  5 06:34:04 opata kernel:  <6>note: kswapd0[7] exited with preempt_count 1
Feb  5 06:34:18 opata init: Id "1" respawning too fast: disabled for 5 minutes
Feb  5 06:34:52 opata kernel: SysRq : Emergency Sync
Feb  5 06:34:52 opata kernel: Emergency Sync complete
Feb  5 06:35:02 opata kernel: SysRq : Emergency Sync
Feb  5 06:35:02 opata kernel: Emergency Sync complete
Feb  5 06:35:05 opata init: Id "5" respawning too fast: disabled for 5 minutes
Feb  5 06:35:11 opata kernel: SysRq : HELP : loglevel0-8 reBoot tErm kIll saK showMem powerOff showPc unRaw Sync showTasks Unmount
Feb  5 06:35:12 opata kernel: SysRq : Emergency Sync
Feb  5 06:35:12 opata kernel: Emergency Sync complete
Feb  5 06:35:14 opata kernel: SysRq : Emergency Remount R/O
Feb  5 06:35:14 opata kernel: ------------[ cut here ]------------
Feb  5 06:35:14 opata kernel: kernel BUG at include/linux/list.h:149!
Feb  5 06:35:14 opata kernel: invalid operand: 0000 [#2]
Feb  5 06:35:14 opata kernel: PREEMPT
Feb  5 06:35:14 opata kernel: CPU:    0
Feb  5 06:35:14 opata kernel: EIP:    0060:[shrink_dcache_sb+550/570]    Not tainted VLI
Feb  5 06:35:14 opata kernel: EFLAGS: 00010217
Feb  5 06:35:14 opata kernel: EIP is at shrink_dcache_sb+0x226/0x23a
Feb  5 06:35:14 opata kernel: eax: c0049b8c   ebx: c0049b8c   ecx: c7ff708c   edx: c2fe7a8c
Feb  5 06:35:14 opata kernel: esi: c1390400   edi: c13e8000   ebp: ffffe000   esp: c13e9f58
Feb  5 06:35:14 opata kernel: ds: 007b   es: 007b   ss: 0068
Feb  5 06:35:14 opata kernel: Process pdflush (pid: 5, threadinfo=c13e8000 task=c127a080)
Feb  5 06:35:14 opata kernel: Stack: c127a0a0 c127df48 c1390400 c1390400 c1390400 c13e8000 ffffe000 c015c82c
Feb  5 06:35:14 opata kernel:        c1390400 c127ace0 d6090fc0 c1390400 c13e8000 c015c96c c1390400 00000001
Feb  5 06:35:14 opata kernel:        00000000 00000001 c13e8000 c13e9fdc c13e8000 c13e9fd0 c0140ecc 00000000
Feb  5 06:35:14 opata kernel: Call Trace:
Feb  5 06:35:14 opata kernel:  [do_remount_sb+53/216] do_remount_sb+0x35/0xd8
Feb  5 06:35:14 opata kernel:  [do_emergency_remount+157/291] do_emergency_remount+0x9d/0x123
Feb  5 06:35:14 opata kernel:  [__pdflush+252/477] __pdflush+0xfc/0x1dd
Feb  5 06:35:14 opata kernel:  [pdflush+0/19] pdflush+0x0/0x13
Feb  5 06:35:14 opata kernel:  [pdflush+15/19] pdflush+0xf/0x13
Feb  5 06:35:14 opata kernel:  [do_emergency_remount+0/291] do_emergency_remount+0x0/0x123
Feb  5 06:35:14 opata kernel:  [kernel_thread_helper+0/11] kernel_thread_helper+0x0/0xb
Feb  5 06:35:14 opata kernel:  [kernel_thread_helper+5/11] kernel_thread_helper+0x5/0xb
Feb  5 06:35:14 opata kernel:
Feb  5 06:35:14 opata kernel: Code: 48 04 75 27 89 02 89 50 04 c7 01 00 01 10 00 a1 b0 ce 2e c0 89 48 04 89 01 c7 41 04 b0 ce 2e c0 89 0d b0 ce 2e c0 e9 13 fe ff ff <0f> 0b 95 00 dd 93 2b c0 eb cf 0f 0b 94 00 dd 93 2b c0 eb be 57
Feb  5 06:35:14 opata kernel:  <6>note: pdflush[5] exited with preempt_count 2
Feb  5 06:35:17 opata kernel: SysRq : Emergency Sync
Feb  5 06:35:17 opata kernel: Emergency Sync complete
Feb  5 06:35:19 opata kernel: SysRq : Emergency Remount R/O
Feb  5 06:35:19 opata kernel: ------------[ cut here ]------------
Feb  5 06:35:19 opata kernel: kernel BUG at include/linux/list.h:149!
Feb  5 06:35:19 opata kernel: invalid operand: 0000 [#3]
Feb  5 06:35:19 opata kernel: PREEMPT
Feb  5 06:35:19 opata kernel: CPU:    0
Feb  5 06:35:19 opata kernel: EIP:    0060:[shrink_dcache_sb+550/570]    Not tainted VLI
Feb  5 06:35:19 opata kernel: EFLAGS: 00010217
Feb  5 06:35:19 opata kernel: EIP is at shrink_dcache_sb+0x226/0x23a
Feb  5 06:35:19 opata kernel: eax: c0049b8c   ebx: c0049b8c   ecx: c7ff708c   edx: c2fe7a8c
Feb  5 06:35:19 opata kernel: esi: c1390400   edi: c13e4000   ebp: ffffe000   esp: c13e5f58
Feb  5 06:35:19 opata kernel: ds: 007b   es: 007b   ss: 0068
Feb  5 06:35:19 opata kernel: Process pdflush (pid: 6, threadinfo=c13e4000 task=c13e7940)
Feb  5 06:35:19 opata kernel: Stack: c13e7960 c127df48 c1390400 c1390400 c1390400 c13e4000 ffffe000 c015c82c
Feb  5 06:35:19 opata kernel:        c1390400 c127ace0 fdc34e17 c1390400 c13e4000 c015c96c c1390400 00000001
Feb  5 06:35:19 opata kernel:        00000000 00000001 c13e4000 c13e5fdc c13e4000 c13e5fd0 c0140ecc 00000000
Feb  5 06:35:19 opata kernel: Call Trace:
Feb  5 06:35:19 opata kernel:  [do_remount_sb+53/216] do_remount_sb+0x35/0xd8
Feb  5 06:35:19 opata kernel:  [do_emergency_remount+157/291] do_emergency_remount+0x9d/0x123
Feb  5 06:35:19 opata kernel:  [__pdflush+252/477] __pdflush+0xfc/0x1dd
Feb  5 06:35:19 opata kernel:  [pdflush+0/19] pdflush+0x0/0x13
Feb  5 06:35:19 opata kernel:  [pdflush+15/19] pdflush+0xf/0x13
Feb  5 06:35:19 opata kernel:  [do_emergency_remount+0/291] do_emergency_remount+0x0/0x123
Feb  5 06:35:19 opata kernel:  [kernel_thread_helper+0/11] kernel_thread_helper+0x0/0xb
Feb  5 06:35:19 opata kernel:  [kernel_thread_helper+5/11] kernel_thread_helper+0x5/0xb
Feb  5 06:35:19 opata kernel:
Feb  5 06:35:19 opata kernel: Code: 48 04 75 27 89 02 89 50 04 c7 01 00 01 10 00 a1 b0 ce 2e c0 89 48 04 89 01 c7 41 04 b0 ce 2e c0 89 0d b0 ce 2e c0 e9 13 fe ff ff <0f> 0b 95 00 dd 93 2b c0 eb cf 0f 0b 94 00 dd 93 2b c0 eb be 57
Feb  5 06:35:19 opata kernel:  <6>note: pdflush[6] exited with preempt_count 2
Feb  5 06:35:20 opata kernel: SysRq : Emergency Remount R/O

Before this:
1. I play some avi in console whith this:
mplayer -vo fbdev2 beach.avi
http://www.mplayerhq.hu
andrej@opata:sis$ mplayer -v
MPlayer 1.0pre3-3.3.1 (C) 2000-2003 MPlayer Team

CPU: Intel Pentium 4/Xeon/Celeron Northwood 2006 MHz (Family: 8, Stepping: 9)
Detected cache-line size is 64 bytes
CPUflags:  MMX: 1 MMX2: 1 3DNow: 0 3DNow2: 0 SSE: 1 SSE2: 1
Compiled for x86 CPU with extensions: MMX MMX2 SSE SSE2

2. and see some pictures(jpg), whith fbi 
andrej@opata:sis$ fbi --version
fbi version 1.26 (c) 1999-2001 Gerd Knorr; compiled on Feb  7 2003.

3. _After_ 1-2 second has a crash. Only SysRq working.


In my laptop have debian/sarge. Installed 2003.09.22 and not upgraded. All program officinal debian version, except the kernel, and mplayer.

andrej@opata:sis$ uname -a
Linux opata 2.6.2-rc2-mm1 #37 Thu Jan 29 18:33:52 CIT 2004 i686 GNU/Linux
opata:~# grep -A1 2.6.2-rc2-mm1 /etc/lilo.conf
image=/boot/vmlinuz-2.6.2-rc2-mm1
        append="devfs=mount max_scsi_luns=2 video=sisfb:1024x768x32-60"
        label=2.6.2-rc2-mm1

andrej@opata:bali$ grep "ACPI\|SIS" /boot/config-2.6.2-rc2-mm1
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_FAN=m
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_THERMAL=m
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
CONFIG_ACPI_RELAXED_AML=y
CONFIG_X86_ACPI_CPUFREQ=m
# CONFIG_X86_ACPI_CPUFREQ_PROC_INTF is not set
CONFIG_HOTPLUG_PCI_ACPI=m
CONFIG_BLK_DEV_SIS5513=m
CONFIG_SIS900=m
# CONFIG_SIS190 is not set
CONFIG_SERIAL_8250_ACPI=y
CONFIG_AGP_SIS=m
CONFIG_DRM_SIS=m
CONFIG_I2C_SIS5595=m
CONFIG_I2C_SIS630=m
CONFIG_I2C_SIS96X=m
CONFIG_FB_SIS=y
CONFIG_FB_SIS_300=y
CONFIG_FB_SIS_315=y
All acpi modul "insmod"-ed.

andrej@opata:bali$ lspci -vvv 
00:00.0 Host bridge: Silicon Integrated Systems [SiS] 650 Host (rev 11)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32
	Region 0: Memory at e0000000 (32-bit, non-prefetchable) [size=64M]
	Capabilities: [c0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Silicon Integrated Systems [SiS] SiS 530 Virtual PCI-to-PCI bridge (AGP) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000a000-0000afff
	Memory behind bridge: dfe00000-dfefffff
	Prefetchable memory behind bridge: cfc00000-dfcfffff
	BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

00:02.0 ISA bridge: Silicon Integrated Systems [SiS] SiS962 [MuTIOL Media IO] (rev 04)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:02.1 SMBus: Silicon Integrated Systems [SiS]: Unknown device 0016
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 5
	Region 4: I/O ports at 0c00 [size=32]

00:02.3 FireWire (IEEE 1394): Silicon Integrated Systems [SiS] FireWire Controller (prog-if 10 [OHCI])
	Subsystem: Uniwill Computer Corp: Unknown device 5300
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1000ns min, 3000ns max)
	Interrupt: pin B routed to IRQ 5
	Region 0: Memory at dfffb000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at dffc0000 [disabled] [size=128K]
	Capabilities: [64] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=55mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (prog-if 80 [Master])
	Subsystem: Uniwill Computer Corp: Unknown device 5513
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 128
	Region 4: I/O ports at ff00 [size=16]

00:02.6 Modem: Silicon Integrated Systems [SiS] Intel 537 [56k Winmodem] (rev a0) (prog-if 00 [Generic])
	Subsystem: Uniwill Computer Corp: Unknown device 4003
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (13000ns min, 2750ns max)
	Interrupt: pin C routed to IRQ 10
	Region 0: I/O ports at d400 [size=256]
	Region 1: I/O ports at d000 [size=128]
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] SiS7012 PCI Audio Accelerator (rev a0)
	Subsystem: Uniwill Computer Corp: Unknown device 5101
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (13000ns min, 2750ns max)
	Interrupt: pin C routed to IRQ 10
	Region 0: I/O ports at dc00 [size=256]
	Region 1: I/O ports at d800 [size=128]
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:03.0 USB Controller: Silicon Integrated Systems [SiS] SiS7001 USB Controller (rev 0f) (prog-if 10 [OHCI])
	Subsystem: Uniwill Computer Corp: Unknown device 7001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (20000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at dfff7000 (32-bit, non-prefetchable) [size=4K]

00:03.1 USB Controller: Silicon Integrated Systems [SiS] SiS7001 USB Controller (rev 0f) (prog-if 10 [OHCI])
	Subsystem: Uniwill Computer Corp: Unknown device 7001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (20000ns max), cache line size 08
	Interrupt: pin B routed to IRQ 10
	Region 0: Memory at dfff8000 (32-bit, non-prefetchable) [size=4K]

00:03.2 USB Controller: Silicon Integrated Systems [SiS] SiS7001 USB Controller (rev 0f) (prog-if 10 [OHCI])
	Subsystem: Uniwill Computer Corp: Unknown device 7001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (20000ns max), cache line size 08
	Interrupt: pin C routed to IRQ 10
	Region 0: Memory at dfff9000 (32-bit, non-prefetchable) [size=4K]

00:03.3 USB Controller: Silicon Integrated Systems [SiS] SiS7002 USB 2.0 (prog-if 20 [EHCI])
	Subsystem: Uniwill Computer Corp: Unknown device 5300
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (20000ns max), cache line size 08
	Interrupt: pin D routed to IRQ 5
	Region 0: Memory at dfffa000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 10/100 Ethernet (rev 91)
	Subsystem: Uniwill Computer Corp: Unknown device 5100
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (13000ns min, 2750ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at cc00 [size=256]
	Region 1: Memory at dfff6000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at dffa0000 [disabled] [size=128K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.0 CardBus bridge: O2 Micro, Inc. OZ6912 Cardbus Controller
	Subsystem: Uniwill Computer Corp: Unknown device 3000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 00000000-00000000 (prefetchable)
	Memory window 1: 00000000-00000000 (prefetchable)
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite-
	16-bit legacy interface ports at 0001

01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] SiS650/651/M650/740 PCI/AGP VGA Display Adapter (prog-if 00 [VGA])
	Subsystem: Uniwill Computer Corp: Unknown device 5100
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop+ ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	BIST result: 00
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
	Region 1: Memory at dfee0000 (32-bit, non-prefetchable) [size=128K]
	Region 2: I/O ports at ac00 [size=128]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] AGP version 2.0
		Status: RQ=16 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>



Thx Andrej

ps: I am offlist, private mail please
ps2: I am in holiday. I check my emails only every 2 days. Sorry.
<P>
bye<br/>
Andrej
</P><P ALIGN="CENTER">
Emlékezz!! <a href=http://draconis.elte.hu/~andrej/writings/guillotine.html>Guillotine!</a><br/>
This work is licensed under a <a href=http://creativecommons.org/licenses/by-nc-sa/1.0>Creative Commons License.</a>
</P>
