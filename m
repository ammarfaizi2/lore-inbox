Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268833AbRHLGmN>; Sun, 12 Aug 2001 02:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268963AbRHLGmE>; Sun, 12 Aug 2001 02:42:04 -0400
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:31875 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S268833AbRHLGl4>;
	Sun, 12 Aug 2001 02:41:56 -0400
Message-ID: <3B76253D.973E3593@pobox.com>
Date: Sat, 11 Aug 2001 23:42:05 -0700
From: J Sloan <jjs@pobox.com>
Organization: J S Concepts
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Garett Spencley <gspen@home.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Q3A segfaults with 2.4.8
In-Reply-To: <Pine.LNX.4.33L2.0108112137350.17803-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Q3a works fine for me, as before.

My current configuration:

Red Hat 7.1 + all updates
Xfree86 4.1 (rawhide rpms)
kernel 2.4.8 + Andrew Morton's low latency patches.
Penium III 933/512 MB RAM/Voooo 3 AGP

cu

jjs

Garett Spencley wrote:

> Hi,
>
> I have no idea how to debug this so some insight would be very helpful.
> Quake3 arena is crashing with 2.4.8 and 2.4.8-ac1.
>
> I'm pretty sure it's related to the emu10k1 changes because the last
> output is:
>
> ...loading 'scripts/sky.shader'
> ...loading 'scripts/test.shader'
> ----- finished R_Init -----
>
> ------- sound initialization -------
> ------------------------------------
> Received signal 11, exiting...
>
> It works fine with 2.4.7 and -ac series.
>
> Here's my system info:
>
> Mandrake 8.0
>
> Linux version 2.4.8-ac1 (root@localhost.localdomain) (gcc version 3.0) #1
> Sat Aug 11 18:16:04 EDT 2001
>
> $ cat /proc/cpuinfo
> processor       : 0
> vendor_id       : AuthenticAMD
> cpu family      : 6
> model           : 2
> model name      : AMD Athlon(tm) Processor
> stepping        : 1
> cpu MHz         : 704.960
> cache size      : 512 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 1
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
> bogomips        : 1405.74
>
> $ cat /proc/ioports
> 0000-001f : dma1
> 0020-003f : pic1
> 0040-005f : timer
> 0060-006f : keyboard
> 0080-008f : dma page reg
> 00a0-00bf : pic2
> 00c0-00df : dma2
> 00f0-00ff : fpu
> 0170-0177 : ide1
> 01f0-01f7 : ide0
> 02f8-02ff : serial(auto)
> 0376-0376 : ide1
> 03c0-03df : vga+
> 03e8-03ef : serial(auto)
> 03f6-03f6 : ide0
> 03f8-03ff : serial(auto)
> 0400-040f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
> 0cf8-0cff : PCI conf1
> 9000-9fff : PCI Bus #01
>   9c00-9cff : 3Dfx Interactive, Inc. Voodoo 3
> c800-c81f : Creative Labs SB Live! EMU10000
>   c800-c81f : EMU10K1
> cc00-ccff : Realtek Semiconductor Co., Ltd. RTL-8139
>   cc00-ccff : 8139too
> d000-d01f : VIA Technologies, Inc. UHCI USB
>   d000-d01f : usb-uhci
> d400-d41f : VIA Technologies, Inc. UHCI USB (#2)
>   d400-d41f : usb-uhci
> d800-d803 : Advanced Micro Devices [AMD] AMD-751 [Irongate] System Controller
> dc00-dc07 : Creative Labs SB Live!
>   dc00-dc07 : emu10k1-gp
> ffa0-ffaf : VIA Technologies, Inc. Bus Master IDE
>   ffa0-ffa7 : ide0
>   ffa8-ffaf : ide1
>
> $ cat /proc/iomem
> 00000000-0009efff : System RAM
> 000a0000-000bffff : Video RAM area
> 000c0000-000c7fff : Video ROM
> 000f0000-000fffff : System ROM
> 00100000-09ffffff : System RAM
>   00100000-0026e5e9 : Kernel code
>   0026e5ea-002db53f : Kernel data
> dfc00000-e3cfffff : PCI Bus #01
>   e0000000-e1ffffff : 3Dfx Interactive, Inc. Voodoo 3
> e4000000-e7ffffff : Advanced Micro Devices [AMD] AMD-751 [Irongate] System Controller
> ebdfd000-ebdfdfff : Brooktree Corporation Bt878
>   ebdfd000-ebdfdfff : bttv
> ebdfe000-ebdfefff : Brooktree Corporation Bt878
> ebdff000-ebdfffff : Advanced Micro Devices [AMD] AMD-751 [Irongate] System Controller
> ebe00000-efefffff : PCI Bus #01
>   ec000000-edffffff : 3Dfx Interactive, Inc. Voodoo 3
> efffff00-efffffff : Realtek Semiconductor Co., Ltd. RTL-8139
>   efffff00-efffffff : 8139too
>
> # lspci -vvv
> 00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-751 [Irongate] System Controller (rev 25)
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
>         Latency: 64
>         Region 0: Memory at e4000000 (32-bit, prefetchable) [size=64M]
>         Region 1: Memory at ebdff000 (32-bit, prefetchable) [size=4K]
>         Region 2: I/O ports at d800 [disabled] [size=4]
>         Capabilities: [a0] AGP version 1.0
>                 Status: RQ=15 SBA+ 64bit- FW- Rate=x1,x2
>                 Command: RQ=0 SBA- AGP+ 64bit- FW- Rate=x1
>
> 00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-751 [Irongate] AGP Bridge (rev 01) (prog-if 00 [Normal decode])
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 64
>         Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
>         I/O behind bridge: 00009000-00009fff
>         Memory behind bridge: ebe00000-efefffff
>         Prefetchable memory behind bridge: dfc00000-e3cfffff
>         BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-
>
> 00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 1b)
>         Subsystem: Asustek Computer, Inc.: Unknown device 800d
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>
> 00:04.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06) (prog-if 8a [Master SecP PriP])
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 32
>         Region 4: I/O ports at ffa0 [size=16]
>         Capabilities: [c0] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> 00:04.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 0e) (prog-if 00 [UHCI])
>         Subsystem: Unknown device 0925:1234
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 64, cache line size 08
>         Interrupt: pin D routed to IRQ 10
>         Region 4: I/O ports at d000 [size=32]
>         Capabilities: [80] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> 00:04.3 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 0e) (prog-if 00 [UHCI])
>         Subsystem: Unknown device 0925:1234
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 64, cache line size 08
>         Interrupt: pin D routed to IRQ 10
>         Region 4: I/O ports at d400 [size=32]
>         Capabilities: [80] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> 00:04.4 SMBus: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 20)
>         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>
> 00:0e.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
>         Subsystem: AOPEN Inc. ALN-325C
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 64 (8000ns min, 16000ns max)
>         Interrupt: pin A routed to IRQ 9
>         Region 0: I/O ports at cc00 [size=256]
>         Region 1: Memory at efffff00 (32-bit, non-prefetchable) [size=256]
>
> 00:0f.0 Multimedia video controller: Brooktree Corporation Bt878 (rev 02)
>         Subsystem: Hauppauge computer works Inc.: Unknown device 13eb
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 64 (4000ns min, 10000ns max)
>         Interrupt: pin A routed to IRQ 5
>         Region 0: Memory at ebdfd000 (32-bit, prefetchable) [size=4K]
>
> 00:0f.1 Multimedia controller: Brooktree Corporation Bt878 (rev 02)
>         Subsystem: Hauppauge computer works Inc.: Unknown device 13eb
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 64 (1000ns min, 63750ns max)
>         Interrupt: pin A routed to IRQ 5
>         Region 0: Memory at ebdfe000 (32-bit, prefetchable) [size=4K]
>
> 00:10.0 Multimedia audio controller: Creative Labs SB Live! EMU10000 (rev 07)
>         Subsystem: Creative Labs CT4832 SBLive! Value
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 64 (500ns min, 5000ns max)
>         Interrupt: pin A routed to IRQ 10
>         Region 0: I/O ports at c800 [size=32]
>         Capabilities: [dc] Power Management version 1
>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> 00:10.1 Input device controller: Creative Labs SB Live! (rev 07)
>         Subsystem: Creative Labs Gameport Joystick
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 64
>         Region 0: I/O ports at dc00 [size=8]
>         Capabilities: [dc] Power Management version 1
>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> 01:05.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 3 (rev 01) (prog-if 00 [VGA])
>         Subsystem: 3Dfx Interactive, Inc. Voodoo3 AGP
>         Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR+
>         Interrupt: pin A routed to IRQ 11
>         Region 0: Memory at ec000000 (32-bit, non-prefetchable) [size=32M]
>         Region 1: Memory at e0000000 (32-bit, prefetchable) [size=32M]
>         Region 2: I/O ports at 9c00 [size=256]
>         Expansion ROM at efef0000 [disabled] [size=64K]
>         Capabilities: [54] AGP version 1.0
>                 Status: RQ=7 SBA+ 64bit+ FW- Rate=x1,x2
>                 Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
>         Capabilities: [60] Power Management version 1
>                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> Thanks in advance for any help,
>
> --
> Garett Spencley
>
> I encourage you to encrypt e-mail sent to me using PGP
> My public key is available on PGP key servers (http://keyservers.net)
> Key fingerprint: 8062 1A46 9719 C929 578C BB4E 7799 EC1A AB12 D3B9
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

