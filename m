Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263176AbTLVTV5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 14:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262848AbTLVTV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 14:21:56 -0500
Received: from [193.138.115.2] ([193.138.115.2]:6158 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S263176AbTLVTVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 14:21:07 -0500
Date: Mon, 22 Dec 2003 20:18:39 +0100 (CET)
From: Jesper Juhl <juhl@dif.dk>
To: linux-kernel@vger.kernel.org
Subject: Re: Badness in pci_find_subsys & sleeping function called from
 invalid context
In-Reply-To: <Pine.LNX.4.56.0312221959460.27724@jju_lnx.backbone.dif.dk>
Message-ID: <Pine.LNX.4.56.0312222016530.27724@jju_lnx.backbone.dif.dk>
References: <Pine.LNX.4.56.0312221959460.27724@jju_lnx.backbone.dif.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Forgot to include the "Badness in pci_find_subsys" bits of the log - here
you are.
Original message below.

ec 22 19:10:45 dragon kernel: Badness in pci_find_subsys at
drivers/pci/search.c:132
Dec 22 19:10:45 dragon kernel: Call Trace:
Dec 22 19:10:45 dragon kernel:  [<c01fcb15>] pci_find_subsys+0xe5/0xf0
Dec 22 19:10:45 dragon kernel:  [<c01fcb4f>] pci_find_device+0x2f/0x40
Dec 22 19:10:45 dragon kernel:  [<c01fca08>] pci_find_slot+0x28/0x50
Dec 22 19:10:45 dragon kernel:  [<e1e7157a>] os_pci_init_handle+0x3a/0x70 [nvidia]
Dec 22 19:10:45 dragon kernel:  [<e1d462af>] __nvsym00057+0x1f/0x24 [nvidia]
Dec 22 19:10:45 dragon kernel:  [<e1e56808>] __nvsym04875+0xf8/0x170 [nvidia]
Dec 22 19:10:45 dragon kernel:  [<e1dd92ed>] __nvsym03749+0x41/0xbc [nvidia]
Dec 22 19:10:45 dragon kernel:  [<e1e565da>] __nvsym00780+0x21a/0x224 [nvidia]
Dec 22 19:10:45 dragon kernel:  [<e1dd9c94>] __nvsym03741+0x74/0x88 [nvidia]
Dec 22 19:10:45 dragon kernel:  [<e1dd8c5a>] __nvsym03751+0x5a2/0x8a4 [nvidia]
Dec 22 19:10:45 dragon kernel:  [<e1e1d233>] __nvsym00688+0x1e3/0x338 [nvidia]
Dec 22 19:10:45 dragon kernel:  [<e1d489b9>] __nvsym00827+0xd/0x1c [nvidia]
Dec 22 19:10:45 dragon kernel:  [<e1d4a054>] rm_isr_bh+0xc/0x10 [nvidia]
Dec 22 19:10:45 dragon kernel:  [<c011f246>] tasklet_action+0x46/0x70
Dec 22 19:10:45 dragon kernel:  [<c011f059>] do_softirq+0x99/0xa0
Dec 22 19:10:45 dragon kernel:  [<c010b217>] do_IRQ+0x117/0x150
Dec 22 19:10:45 dragon kernel:  [<c0109648>] common_interrupt+0x18/0x20
Dec 22 19:10:45 dragon kernel:
Dec 22 19:10:45 dragon kernel: Badness in pci_find_subsys at
drivers/pci/search.c:132
Dec 22 19:10:45 dragon kernel: Call Trace:
Dec 22 19:10:45 dragon kernel:  [<c01fcb15>] pci_find_subsys+0xe5/0xf0
Dec 22 19:10:45 dragon kernel:  [<c01fcb4f>] pci_find_device+0x2f/0x40
Dec 22 19:10:45 dragon kernel:  [<c01fca08>] pci_find_slot+0x28/0x50
Dec 22 19:10:45 dragon kernel:  [<e1e7157a>] os_pci_init_handle+0x3a/0x70 [nvidia]
Dec 22 19:10:45 dragon kernel:  [<e1d462af>] __nvsym00057+0x1f/0x24 [nvidia]
Dec 22 19:10:45 dragon kernel:  [<e1dda8e2>] __nvsym03763+0x72/0xe0 [nvidia]
Dec 22 19:10:45 dragon kernel:  [<e1e1f3f1>] __nvsym04466+0x15/0x78 [nvidia]
Dec 22 19:10:45 dragon kernel:  [<e1e56837>] __nvsym04875+0x127/0x170 [nvidia]
Dec 22 19:10:45 dragon kernel:  [<e1dd92ed>] __nvsym03749+0x41/0xbc [nvidia]
Dec 22 19:10:45 dragon kernel:  [<e1e565da>] __nvsym00780+0x21a/0x224 [nvidia]
Dec 22 19:10:45 dragon kernel:  [<e1dd9c94>] __nvsym03741+0x74/0x88 [nvidia]
Dec 22 19:10:45 dragon kernel:  [<e1dd8c5a>] __nvsym03751+0x5a2/0x8a4 [nvidia]
Dec 22 19:10:45 dragon kernel:  [<e1e1d233>] __nvsym00688+0x1e3/0x338 [nvidia]
Dec 22 19:10:45 dragon kernel:  [<e1d489b9>] __nvsym00827+0xd/0x1c [nvidia]
Dec 22 19:10:45 dragon kernel:  [<e1d4a054>] rm_isr_bh+0xc/0x10 [nvidia]
Dec 22 19:10:45 dragon kernel:  [<c011f246>] tasklet_action+0x46/0x70
Dec 22 19:10:45 dragon kernel:  [<c011f059>] do_softirq+0x99/0xa0
Dec 22 19:10:45 dragon kernel:  [<c010b217>] do_IRQ+0x117/0x150
Dec 22 19:10:45 dragon kernel:  [<c0109648>] common_interrupt+0x18/0x20
Dec 22 19:10:45 dragon kernel:


On Mon, 22 Dec 2003, Jesper Juhl wrote:

>
> After upgrading to 2.6.0 (from 2.4.22)I'm getting a lot of the below
> messages in my logs.
> I'm well aware that this might purely be a problem with the binary Nvidia
> drivers I'm using with my Geforce3, especially since I had to use the patches
> available from http://www.minion.de/ to be able to use those drivers at all,
> but I thought I would report it anyway, in case the nvidia drivers
> are simply exposing a real kernel bug somewhere that can be fixed without
> available nvidia source.
>
> Dec 22 17:30:51 dragon kernel: Debug: sleeping function called from
> invalid context at mm/slab.c:1856
> Dec 22 17:30:51 dragon kernel: in_atomic():1, irqs_disabled():0
> Dec 22 17:30:51 dragon kernel: Call Trace:
> Dec 22 17:30:51 dragon kernel:  [<c0118deb>] __might_sleep+0xab/0xd0
> Dec 22 17:30:51 dragon kernel:  [<c013aff5>] kmem_cache_alloc+0x65/0x70
> Dec 22 17:30:51 dragon kernel:  [<c0149821>] __get_vm_area+0x21/0x100
> Dec 22 17:30:51 dragon kernel:  [<c0149933>] get_vm_area+0x33/0x40
> Dec 22 17:30:51 dragon kernel:  [<c0116193>] __ioremap+0xb3/0x100
> Dec 22 17:30:51 dragon kernel:  [<c0116209>] ioremap_nocache+0x29/0xb0
> Dec 22 17:30:51 dragon kernel:  [<e1e71915>] os_map_kernel_space+0x45/0x70 [nvidia]
> Dec 22 17:30:51 dragon kernel:  [<e1d46377>] __nvsym00568+0x1f/0x2c [nvidia]
> Dec 22 17:30:51 dragon kernel:  [<e1d48496>] __nvsym00775+0x6e/0xe0 [nvidia]
> Dec 22 17:30:51 dragon kernel:  [<e1d48526>] __nvsym00781+0x1e/0x190 [nvidia]
> Dec 22 17:30:51 dragon kernel:  [<e1d49fac>] rm_init_adapter+0xc/0x10 [nvidia]
> Dec 22 17:30:51 dragon kernel:  [<e1e6e3e1>] nv_kern_open+0x121/0x230 [nvidia]
> Dec 22 17:30:51 dragon kernel:  [<c0158334>] chrdev_open+0xf4/0x220
> Dec 22 17:30:51 dragon kernel:  [<c014e39b>] dentry_open+0x14b/0x220
> Dec 22 17:30:51 dragon kernel:  [<c014e240>] filp_open+0x60/0x70
> Dec 22 17:30:51 dragon kernel:  [<c014e6e3>] sys_open+0x53/0x90
> Dec 22 17:30:51 dragon kernel:  [<c01094db>] syscall_call+0x7/0xb
> Dec 22 17:30:51 dragon kernel:
> Dec 22 17:30:52 dragon kernel: Debug: sleeping function called from invalid context at mm/slab.c:1856
> Dec 22 17:30:52 dragon kernel: in_atomic():1, irqs_disabled():0
> Dec 22 17:30:52 dragon kernel: Call Trace:
> Dec 22 17:30:52 dragon kernel:  [<c0118deb>] __might_sleep+0xab/0xd0
> Dec 22 17:30:52 dragon kernel:  [<c013aff5>] kmem_cache_alloc+0x65/0x70
> Dec 22 17:30:52 dragon kernel:  [<c0149821>] __get_vm_area+0x21/0x100
> Dec 22 17:30:52 dragon kernel:  [<c0149933>] get_vm_area+0x33/0x40
> Dec 22 17:30:52 dragon kernel:  [<c0116193>] __ioremap+0xb3/0x100
> Dec 22 17:30:52 dragon kernel:  [<c0116209>] ioremap_nocache+0x29/0xb0
> Dec 22 17:30:52 dragon kernel:  [<e1e71915>] os_map_kernel_space+0x45/0x70 [nvidia]
> Dec 22 17:30:52 dragon kernel:  [<e1d46377>] __nvsym00568+0x1f/0x2c [nvidia]
> Dec 22 17:30:52 dragon kernel:  [<e1d48496>] __nvsym00775+0x6e/0xe0 [nvidia]
> Dec 22 17:30:52 dragon kernel:  [<e1d48526>] __nvsym00781+0x1e/0x190 [nvidia]
> Dec 22 17:30:52 dragon kernel:  [<e1d49fac>] rm_init_adapter+0xc/0x10 [nvidia]
> Dec 22 17:30:52 dragon kernel:  [<e1e6e3e1>] nv_kern_open+0x121/0x230 [nvidia]
> Dec 22 17:30:52 dragon kernel:  [<c0158334>] chrdev_open+0xf4/0x220
> Dec 22 17:30:52 dragon kernel:  [<c014e39b>] dentry_open+0x14b/0x220
> Dec 22 17:30:52 dragon kernel:  [<c014e240>] filp_open+0x60/0x70
> Dec 22 17:30:52 dragon kernel:  [<c014e6e3>] sys_open+0x53/0x90
> Dec 22 17:30:52 dragon kernel:  [<c01094db>] syscall_call+0x7/0xb
> Dec 22 17:30:52 dragon kernel:
>
>
> Some details about my system :
>
>
> Distribution: Slackware Linux 9.1
>
>
> # uname -a
> Linux dragon 2.6.0 #3 Sun Dec 21 01:25:47 CET 2003 i686 unknown unknown GNU/Linux
>
>
> # cat /proc/cpuinfo
> processor       : 0
> vendor_id       : AuthenticAMD
> cpu family      : 6
> model           : 4
> model name      : AMD Athlon(tm) Processor
> stepping        : 4
> cpu MHz         : 1400.400
> cache size      : 256 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 1
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov
> pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
> bogomips        : 2760.70
>
>
> # cat /proc/interrupts
>            CPU0
>   0:    1098995          XT-PIC  timer
>   1:       4195          XT-PIC  i8042
>   2:          0          XT-PIC  cascade
>   5:       4160          XT-PIC  eth0
>  10:      24451          XT-PIC  aic7xxx, CMI8738
>  11:      89551          XT-PIC  nvidia
>  12:      16349          XT-PIC  i8042
>  14:        586          XT-PIC  ide0
> NMI:          0
> ERR:          0
>
>
> # lsmod
> Module                  Size  Used by
> nvidia               1700652  10
>
>
> # lspci -vvv
> 00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] System
> Controller (rev 13)
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort+ >SERR- <PERR-
>         Latency: 32
>         Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
>         Region 1: Memory at f7800000 (32-bit, prefetchable) [size=4K]
>         Region 2: I/O ports at e000 [disabled] [size=4]
>         Capabilities: [a0] AGP version 2.0
>                 Status: RQ=16 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
> HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
>                 Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- FW-
> Rate=x4
>
> 00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] AGP
> Bridge (prog-if 00 [Normal decode])
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
>         I/O behind bridge: 0000e000-0000dfff
>         Memory behind bridge: ee000000-ef5fffff
>         Prefetchable memory behind bridge: ef700000-f77fffff
>         BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
>
> 00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
> (rev 40)
>         Subsystem: Asustek Computer, Inc. A7M266 Mainboard
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping+ SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Capabilities: [c0] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> 00:04.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus
> Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 32
>         Region 4: I/O ports at d800 [size=16]
>         Capabilities: [c0] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> 00:04.3 USB Controller: VIA Technologies, Inc. USB (rev 16) (prog-if 00
> [UHCI])
>         Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 32, cache line size 08
>         Interrupt: pin D routed to IRQ 5
>         Region 4: I/O ports at d000 [size=32]
>         Capabilities: [80] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> 00:04.4 Non-VGA unclassified device: VIA Technologies, Inc. VT82C686
> [Apollo Super ACPI] (rev 40)
>         Subsystem: Asustek Computer, Inc. A7M266 Mainboard
>         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Interrupt: pin ? routed to IRQ 9
>         Capabilities: [68] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> 00:05.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev
> 10)
>         Subsystem: Asustek Computer, Inc. CMI8738 6ch-MX
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping+ SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 32 (500ns min, 6000ns max)
>         Interrupt: pin A routed to IRQ 10
>         Region 0: I/O ports at a400 [size=256]
>         Capabilities: [c0] Power Management version 2
>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> 00:09.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev
> 42)
>         Subsystem: D-Link System Inc DFE-530TX rev B
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
> ParErr- Stepping+ SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 32 (750ns min, 2000ns max), cache line size 08
>         Interrupt: pin A routed to IRQ 5
>         Region 0: I/O ports at a000 [size=256]
>         Region 1: Memory at ed800000 (32-bit, non-prefetchable) [size=256]
>         Expansion ROM at <unassigned> [disabled] [size=64K]
>         Capabilities: [40] Power Management version 2
>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
> PME(D0+,D1+,D2+,D3hot+,D3cold+)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> 00:0b.0 SCSI storage controller: Adaptec AIC-7892A U160/m (rev 02)
>         Subsystem: Adaptec 29160N Ultra160 SCSI Controller
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 32 (10000ns min, 6250ns max), cache line size 08
>         Interrupt: pin A routed to IRQ 10
>         BIST result: 00
>         Region 0: I/O ports at 9800 [disabled] [size=256]
>         Region 1: Memory at ed000000 (64-bit, non-prefetchable) [size=4K]
>         Expansion ROM at <unassigned> [disabled] [size=128K]
>         Capabilities: [dc] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> 01:05.0 VGA compatible controller: nVidia Corporation NV20 [GeForce3] (rev
> a3) (prog-if 00 [VGA])
>         Subsystem: Asustek Computer, Inc. AGP-V8200 DDR
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 248 (1250ns min, 250ns max)
>         Interrupt: pin A routed to IRQ 11
>         Region 0: Memory at ee000000 (32-bit, non-prefetchable) [size=16M]
>         Region 1: Memory at f0000000 (32-bit, prefetchable) [size=64M]
>         Region 2: Memory at ef800000 (32-bit, prefetchable) [size=512K]
>         Expansion ROM at ef7f0000 [disabled] [size=64K]
>         Capabilities: [60] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>         Capabilities: [44] AGP version 2.0
>                 Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64-
> HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
>                 Command: RQ=16 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- FW-
> Rate=x4
>
>
>
> Kind regards,
>
> Jesper Juhl
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
