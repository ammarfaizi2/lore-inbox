Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268989AbUIXR5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268989AbUIXR5Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 13:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268993AbUIXR5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 13:57:16 -0400
Received: from slimnet.xs4all.nl ([194.109.194.192]:61399 "EHLO slimnas.slim")
	by vger.kernel.org with ESMTP id S268991AbUIXRzp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 13:55:45 -0400
Subject: Re: IEEE1394 not working with VT6307 under kernel 2.6.8-1.521
From: Jurgen Kramer <gtm.kramer@inter.nl.net>
To: "David J. Schuller" <djs63@cornell.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1095892775.15408.29.camel@titan>
References: <1095892775.15408.29.camel@titan>
Content-Type: text/plain
Message-Id: <1096048840.3569.7.camel@paragon.slim>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 24 Sep 2004 20:00:40 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-23 at 00:39, David J. Schuller wrote:
> [1]
> Recognition of external IEEE1394 disk fails with Via VT6307 chip under
> kernel 2.6.8-1.521
> 
> [2]
> Motherboard is Soltek SL-B7C-FGR, which has onboard IEEE1394 with a Via
> VT6307 chip. Southbridge is Via VT8237. CPU is Socket A Athlon MP 2800+.
> Kernel is 2.6.8-1.521 under Fedora Core 2. I load the appropriate
> modules with "modprobe ohci1394". Something like this appears in
> /var/log/messages:
> 
> Sep 22 15:14:29 mclib4 kernel: ohci1394: $Rev: 1223 $ Ben Collins
> <bcollins@debian.org>
> Sep 22 15:14:29 mclib4 kernel: ohci1394: fw-host0: OHCI-1394 1.1 (PCI):
> IRQ=[5]  MMIO=[dffff000-dffff7ff]  Max Packet=[2048]
> Sep 22 15:14:34 mclib4 kernel: ohci1394: $Rev: 1223 $ Ben Collins
> <bcollins@debian.org>
> Sep 22 15:14:34 mclib4 ieee1394.agent[2403]: ... no drivers for IEEE1394
> product 0x/0x/0x
> Sep 22 15:14:34 mclib4 kernel: ohci1394: fw-host0: OHCI-1394 1.1 (PCI):
> IRQ=[5]  MMIO=[dffff000-dffff7ff]  Max Packet=[2048]
> Sep 22 15:14:35 mclib4 ieee1394.agent[2673]: ... no drivers for IEEE1394
> product 0x/0x/0x

You might want to try the latest drivers from www.linux1394.org. 2.6.8.1
doesn't seem to be working very well firewire wise. I am currently
running rev 1233 on a plain 2.6.8.1 needed to get my iPod going.

> I attach an external IEEE1394 hard disk. Nothing else happens. No
> further lines show up in /var/log/messages. No entries show up in
> /proc/scsi/scsi.
> 
> I know the disk and cable are good, I have mounted it on other systems
> (e.g. ASUS A7N8X-E deluxe). I know the procedure is good because those
> other systems had the same version of software. I know it's not a mobo
> hardware problem because the disk can be recognized and mounted
> successfully with a different kernel (Knoppix 3.6 with kernel 2.4.27).
> That leaves me with this: the current 2.6.8-1.521 kernel either has no
> support for the VT6307 chip, or that support is broken.
> 
> [3]
> Keywords: IEEE1394 ,FireWire, Via VT6307, 2.6.8-1
> 
> [4]
> [root@mclib4 root]# cat /proc/version
> Linux version 2.6.8-1.521 (bhcompile@tweety.build.redhat.com) (gcc
> version 3.3.3 20040412 (Red Hat Linux 3.3.3-7)) #1 Mon Aug 16 09:01:18
> EDT 2004
> 
> [7.1]
> [root@mclib4 root]# sh /usr/src/linux-2.6.5-1.358/scripts/ver_linux
> If some fields are empty or look unusual you may have an old version.
> Compare to the current minimal requirements in Documentation/Changes.
>   
> Linux mclib4 2.6.8-1.521 #1 Mon Aug 16 09:01:18 EDT 2004 i686 athlon
> i386 GNU/Linux
>   
> Gnu C                  3.3.3
> Gnu make               3.80
> binutils               2.15.90.0.3
> util-linux             2.12
> mount                  2.12
> module-init-tools      2.4.26
> e2fsprogs              1.35
> jfsutils               1.1.4
> xfsprogs               2.6.13
> pcmcia-cs              3.2.7
> quota-tools            3.10.
> PPP                    2.4.2
> isdn4k-utils           3.3
> nfs-utils              1.0.6
> Linux C Library        2.3.3
> Dynamic linker (ldd)   2.3.3
> Procps                 3.2.0
> Net-tools              1.60
> Kbd                    1.12
> Sh-utils               5.2.1
> Modules Loaded         udf snd_mixer_oss snd_via82xx snd_ac97_codec
> snd_pcm snd_timer snd_page_alloc gameport snd_mpu401_uart snd_rawmidi
> snd_seq_device snd soundcore ohci1394 ieee1394 parport_pc lp parport
> autofs4 via_velocity floppy sg dm_mod joydev uhci_hcd ehci_hcd button
> battery asus_acpi ac md5 ipv6 ext3 jbd sata_via libata sd_mod scsi_mod
> 
> [7.2]
> [root@mclib4 proc]# cat cpuinfo
> processor       : 0
> vendor_id       : AuthenticAMD
> cpu family      : 6
> model           : 10
> model name      : AMD Athlon(tm) MP 2800+
> stepping        : 0
> cpu MHz         : 2125.544
> cache size      : 512 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 1
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca
> cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
> bogomips        : 4169.72
> 
> [7.3]
> [root@mclib4 root]# cat /proc/modules
> udf 79429 0 - Live 0x42ba5000
> snd_mixer_oss 14017 0 - Live 0x42a95000
> snd_via82xx 24165 0 - Live 0x42ae5000
> snd_ac97_codec 58821 1 snd_via82xx, Live 0x42b16000
> snd_pcm 83529 1 snd_via82xx, Live 0x42b00000
> snd_timer 25413 1 snd_pcm, Live 0x42a73000
> snd_page_alloc 8393 2 snd_via82xx,snd_pcm, Live 0x42a64000
> gameport 4033 1 snd_via82xx, Live 0x42a71000
> snd_mpu401_uart 7361 1 snd_via82xx, Live 0x42a6e000
> snd_rawmidi 21733 1 snd_mpu401_uart, Live 0x42a88000
> snd_seq_device 6473 1 snd_rawmidi, Live 0x42a6b000
> snd 45477 8
> snd_mixer_oss,snd_via82xx,snd_ac97_codec,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device, Live 0x42a7b000
> soundcore 7713 1 snd, Live 0x42a68000
> ohci1394 31577 0 - Live 0x42a45000
> ieee1394 285333 1 ohci1394, Live 0x42a9e000
> parport_pc 21249 1 - Live 0x42a3e000
> lp 9133 0 - Live 0x428fa000
> parport 35977 2 parport_pc,lp, Live 0x428a5000
> autofs4 20677 0 - Live 0x428e0000
> via_velocity 28129 0 - Live 0x428d2000
> floppy 54001 0 - Live 0x428e7000
> sg 28513 0 - Live 0x428ca000
> dm_mod 47317 0 - Live 0x42873000
> joydev 7169 0 - Live 0x4284c000
> uhci_hcd 28505 0 - Live 0x4289b000
> ehci_hcd 27973 0 - Live 0x42893000
> button 4825 0 - Live 0x4286a000
> battery 7117 0 - Live 0x4282c000
> asus_acpi 9177 0 - Live 0x4286f000
> ac 3533 0 - Live 0x42838000
> md5 3905 1 - Live 0x4283b000
> ipv6 217349 14 - Live 0x4290c000
> ext3 96937 2 - Live 0x428b1000
> jbd 66521 1 ext3, Live 0x42881000
> sata_via 4805 3 - Live 0x4282f000
> libata 29637 1 sata_via, Live 0x42843000
> sd_mod 17473 4 - Live 0x42832000
> scsi_mod 105360 3 sg,libata,sd_mod, Live 0x4284f000
> 
> [7.4]
> [root@mclib4 proc]# cat /proc/ioports
> 0000-001f : dma1
> 0020-0021 : pic1
> 0040-005f : timer
> 0060-006f : keyboard
> 0070-0077 : rtc
> 0080-008f : dma page reg
> 00a0-00a1 : pic2
> 00c0-00df : dma2
> 00f0-00ff : fpu
> 0170-0177 : ide1
> 02f8-02ff : serial
> 0376-0376 : ide1
> 0378-037a : parport0
> 03c0-03df : vga+
> 03f8-03ff : serial
> 0cf8-0cff : PCI conf1
> a000-afff : PCI Bus #01
>   a800-a8ff : 0000:01:00.0
> bc00-bc7f : 0000:00:09.0
> c000-c0ff : 0000:00:0a.0
>   c000-c0ff : via-velocity
> c400-c41f : 0000:00:10.0
>   c400-c41f : uhci_hcd
> c800-c81f : 0000:00:10.1
>   c800-c81f : uhci_hcd
> cc00-cc1f : 0000:00:10.2
>   cc00-cc1f : uhci_hcd
> d000-d01f : 0000:00:10.3
>   d000-d01f : uhci_hcd
> d400-d4ff : 0000:00:11.5
>   d400-d4ff : VIA8233
> d800-d8ff : 0000:00:0f.0
>   d800-d8ff : sata_via
> dc00-dc0f : 0000:00:0f.0
>   dc00-dc0f : sata_via
> e000-e003 : 0000:00:0f.0
>   e000-e003 : sata_via
> e400-e407 : 0000:00:0f.0
>   e400-e407 : sata_via
> e800-e803 : 0000:00:0f.0
>   e800-e803 : sata_via
> ec00-ec07 : 0000:00:0f.0
>   ec00-ec07 : sata_via
> fc00-fc0f : 0000:00:0f.1
>   fc00-fc07 : ide0
>   fc08-fc0f : ide1
> 
> [root@mclib4 proc]# cat /proc/iomem
> 00000000-0009fbff : System RAM
> 0009fc00-0009ffff : reserved
> 000a0000-000bffff : Video RAM area
> 000c0000-000c7fff : Video ROM
> 000f0000-000fffff : System ROM
> 00100000-3ff3ffff : System RAM
>   00100000-002f6fff : Kernel code
>   002f7000-00399bff : Kernel data
> 3ff40000-3ff4ffff : ACPI Tables
> 3ff50000-3fffffff : ACPI Non-volatile Storage
> cfd00000-dfcfffff : PCI Bus #01
>   d4000000-d7ffffff : 0000:01:00.1
>   d8000000-dbffffff : 0000:01:00.0
> dfe00000-dfefffff : PCI Bus #01
>   dfee0000-dfeeffff : 0000:01:00.1
>   dfef0000-dfefffff : 0000:01:00.0
> dffff000-dffff7ff : 0000:00:09.0
>   dffff000-dffff7ff : ohci1394
> dffff800-dffff8ff : 0000:00:0a.0
>   dffff800-dffff8ff : via-velocity
> dffffc00-dffffcff : 0000:00:10.4
>   dffffc00-dffffcff : ehci_hcd
> e0000000-e3ffffff : 0000:00:00.0
> fff80000-ffffffff : reserved
> 
> [7.5]
> [root@mclib4 proc]# lspci -vvv
> 00:00.0 Host bridge: VIA Technologies, Inc. VT8378 [KM400] Chipset Host
> Bridge
>         Subsystem: VIA Technologies, Inc. VT8378 [KM400] Chipset Host
> Bridge
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort+ >SERR- <PERR-
>         Latency: 8
>         Region 0: Memory at e0000000 (32-bit, prefetchable)
>         Capabilities: [80] AGP version 3.5
>                 Status: RQ=32 Iso- ArqSz=0 Cal=2 SBA+ ITACoh- GART64-
> HTrans- 64bit- FW+ AGP3+ Rate=x8
>                 Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW-
> Rate=<none>
>         Capabilities: [c0] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>  
> 00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge (prog-if 00
> [Normal decode])
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR+ FastB2B-
>         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
>         I/O behind bridge: 0000a000-0000afff
>         Memory behind bridge: dfe00000-dfefffff
>         Prefetchable memory behind bridge: cfd00000-dfcfffff
>         Expansion ROM at 0000a000 [disabled] [size=4K]
>         BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
>         Capabilities: [80] Power Management version 2
>                 Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>  
> 00:09.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host
> Controller (rev 80) (prog-if 10 [OHCI])
>         Subsystem: VIA Technologies, Inc. IEEE 1394 Host Controller
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
> ParErr- Stepping- SERR+ FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 64 (8000ns max), Cache Line Size 08
>         Interrupt: pin A routed to IRQ 5
>         Region 0: Memory at dffff000 (32-bit, non-prefetchable)
>         Region 1: I/O ports at bc00 [size=128]
>         Capabilities: [50] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA
> PME(D0-,D1-,D2+,D3hot+,D3cold+)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>  
> 00:0a.0 Ethernet controller: VIA Technologies, Inc.: Unknown device 3119
> (rev 11)
>         Subsystem: VIA Technologies, Inc.: Unknown device 0110
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
> ParErr- Stepping- SERR+ FastB2B-
>         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 64 (750ns min, 2000ns max), Cache Line Size 08
>         Interrupt: pin A routed to IRQ 10
>         Region 0: I/O ports at c000
>         Region 1: Memory at dffff800 (32-bit, non-prefetchable)
> [size=256]
>         Capabilities: [50] Power Management version 2
>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
> PME(D0+,D1+,D2+,D3hot+,D3cold+)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>  
> 00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RAID
> Controller (rev 80)
>         Subsystem: VIA Technologies, Inc. VIA VT6420 SATA RAID
> Controller
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 64
>         Interrupt: pin B routed to IRQ 10
>         Region 0: I/O ports at ec00
>         Region 1: I/O ports at e800 [size=4]
>         Region 2: I/O ports at e400 [size=8]
>         Region 3: I/O ports at e000 [size=4]
>         Region 4: I/O ports at dc00 [size=16]
>         Region 5: I/O ports at d800 [size=256]
>         Capabilities: [c0] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>  
> 00:0f.1 IDE interface: VIA Technologies, Inc.
> VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
> (prog-if 8a [Master SecP PriP])
>         Subsystem: VIA Technologies, Inc.
> VT82C586/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 32
>         Interrupt: pin A routed to IRQ 5
>         Region 4: I/O ports at fc00 [size=16]
>         Capabilities: [c0] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>  
> 00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
> Controller (rev 81) (prog-if 00 [UHCI])
>         Subsystem: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
> Controller
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 64, Cache Line Size 08
>         Interrupt: pin A routed to IRQ 11
>         Region 4: I/O ports at c400 [size=32]
>         Capabilities: [80] Power Management version 2
>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
> PME(D0+,D1+,D2+,D3hot+,D3cold+)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>  
> 00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
> Controller (rev 81) (prog-if 00 [UHCI])
>         Subsystem: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
> Controller
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 64, Cache Line Size 08
>         Interrupt: pin A routed to IRQ 11
>         Region 4: I/O ports at c800 [size=32]
>         Capabilities: [80] Power Management version 2
>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
> PME(D0+,D1+,D2+,D3hot+,D3cold+)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>  
> 00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
> Controller (rev 81) (prog-if 00 [UHCI])
>         Subsystem: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
> Controller
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 64, Cache Line Size 08
>         Interrupt: pin B routed to IRQ 5
>         Region 4: I/O ports at cc00 [size=32]
>         Capabilities: [80] Power Management version 2
>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
> PME(D0+,D1+,D2+,D3hot+,D3cold+)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>  
> 00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
> Controller (rev 81) (prog-if 00 [UHCI])
>         Subsystem: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
> Controller
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 64, Cache Line Size 08
>         Interrupt: pin B routed to IRQ 5
>         Region 4: I/O ports at d000 [size=32]
>         Capabilities: [80] Power Management version 2
>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
> PME(D0+,D1+,D2+,D3hot+,D3cold+)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>  
> 00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86) (prog-if
> 20 [EHCI])
>         Subsystem: VIA Technologies, Inc. USB 2.0
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 64, Cache Line Size 10
>         Interrupt: pin C routed to IRQ 10
>         Region 0: Memory at dffffc00 (32-bit, non-prefetchable)
>         Capabilities: [80] Power Management version 2
>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
> PME(D0+,D1+,D2+,D3hot+,D3cold+)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>  
> 00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge [K8T800
> South]
>         Subsystem: VIA Technologies, Inc. VT8237 ISA bridge [K8T800
> South]
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
> 00:11.5 Multimedia audio controller: VIA Technologies, Inc.
> VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
>         Subsystem: Avance Logic Inc.: Unknown device 4720
>         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Interrupt: pin C routed to IRQ 10
>         Region 0: I/O ports at d400
>         Capabilities: [c0] Power Management version 2
>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>  
> 01:00.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon
> 9200] (rev 01) (prog-if 00 [VGA])
>         Subsystem: Hightech Information System Ltd.: Unknown device 29a1
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR+ FastB2B-
>         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 64 (2000ns min), Cache Line Size 08
>         Interrupt: pin A routed to IRQ 11
>         Region 0: Memory at d8000000 (32-bit, prefetchable)
> [size=dfec0000]
>         Region 1: I/O ports at a800 [size=256]
>         Region 2: Memory at dfef0000 (32-bit, non-prefetchable)
> [size=64K]
>         Expansion ROM at 00020000 [disabled]
>         Capabilities: [58] AGP version 3.0
>                 Status: RQ=256 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
> HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
>                 Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP- GART64- 64bit- FW-
> Rate=<none>
>         Capabilities: [50] Power Management version 2
>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>  
> 01:00.1 Display controller: ATI Technologies Inc RV280 [Radeon 9200]
> (Secondary) (rev 01)
>         Subsystem: Hightech Information System Ltd.: Unknown device 29a0
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 64 (2000ns min), Cache Line Size 08
>         Region 0: Memory at d4000000 (32-bit, prefetchable)
>         Region 1: Memory at dfee0000 (32-bit, non-prefetchable)
> [size=64K]
>         Capabilities: [50] Power Management version 2
>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>  
> [7.6]
> [root@mclib4 proc]# cat /proc/scsi/scsi
> Attached devices:
> Host: scsi0 Channel: 00 Id: 00 Lun: 00
>   Vendor: ATA      Model: ST380013AS       Rev: 3.18
>   Type:   Direct-Access                    ANSI SCSI revision: 05
> 
> [7.7]
> [root@mclib4 proc]# cat devices
> Character devices:
>   1 mem
>   4 /dev/vc/0
>   4 tty
>   4 ttyS
>   5 /dev/tty
>   5 /dev/console
>   5 /dev/ptmx
>   6 lp
>   7 vcs
>  10 misc
>  13 input
>  14 sound
>  21 sg
>  29 fb
>  36 netlink
> 116 alsa
> 128 ptm
> 136 pts
> 171 ieee1394
> 180 usb
>  
> Block devices:
>   1 ramdisk
>   2 fd
>   8 sd
>   9 md
>  22 ide1
>  65 sd
>  66 sd
>  67 sd
>  68 sd
>  69 sd
>  70 sd
>  71 sd
> 128 sd
> 129 sd
> 130 sd
> 131 sd
> 132 sd
> 133 sd
> 134 sd
> 135 sd
> 253 device-mapper
> 254 mdp
> 
> 
> If you don't have access to a system with a VT6307 chip I am willing to
> run any diagnostics you can provide.
> 
> Cheers,

