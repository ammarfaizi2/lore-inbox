Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261557AbSJAKx2>; Tue, 1 Oct 2002 06:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261558AbSJAKx2>; Tue, 1 Oct 2002 06:53:28 -0400
Received: from 213-187-164-2.dd.nextgentel.com ([213.187.164.2]:8578 "EHLO
	mail.pronto.tv") by vger.kernel.org with ESMTP id <S261557AbSJAKxY> convert rfc822-to-8bit;
	Tue, 1 Oct 2002 06:53:24 -0400
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Panic in 2.5.39
Date: Tue, 1 Oct 2002 13:07:55 +0200
User-Agent: KMail/1.4.1
References: <200209291856.28828.roy@karlsbakk.net>
In-Reply-To: <200209291856.28828.roy@karlsbakk.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210011307.55570.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

did anyone see this?


On Sunday 29 September 2002 18:56, Roy Sigurd Karlsbakk wrote:
> hi all
>
> Trying out 2.5.39 on an intel D845GLLY (or ws it D845GLAD) board, I get
> this cute little panic. Attached are lspci -vvv and .config.
>
> roy
>
> Unable to handle kernel paging request at virtual address 56112e2c
> dec84f28
> *pde = 00000000
> Oops: 0002
> CPU:    0
> EIP:    0060:[<dec84f28>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010207
> eax: dec84f60   ebx: dec86820   ecx: dec86904   edx: dec86820
> esi: 00000000   edi: c0302850   ebp: 00000001   esp: deedde1c
> ds: 0068   es: 0068   ss: 0068
> Stack: c014ed99 dec86820 0000002d 00000000 0000002d c039c5c0 dec86820
> c014f6f4 dec86820 dec86820 dec86820 c014f784 dec86820 dec80220 c014d866
> dec86820 00002e87 c0118bff 00002e87 00002e87 deeed3a0 decc8c00 c0150ca2
> dec80220 [<c014ed99>]clear_inode+0x69/0xb0
>  [<c014f6f4>]generic_forget_inode+0xe4/0x100
>  [<c014f784>]iput+0x54/0x60
>  [<c014d866>]dput+0xf6/0x150
>  [<c0118bff>]call_console_drivers+0xdf/0xf0
>  [<c0150ca2>]__mntput+0x12/0xe0
>  [<c0255c12>]usb_get_sb+0xe2/0xf0
>  [<c0118d83>]printk+0x103/0x110
>  [<c0255d48>]create_special_files+0x128/0x140
>  [<c0255e06>]usbfs_add_bus+0x16/0xe0
>  [<c024fd24>]usb_register_bus+0xf4/0x110
>  [<c0252ad2>]usb_hcd_pci_probe+0x372/0x3a0
>  [<c01aaf5d>]pci_device_probe+0x3d/0x60
>  [<c01e8c28>]probe+0x18/0x30
>  [<c01e8c94>]found_match+0x24/0x50
>  [<c01e8da5>]do_driver_attach+0x35/0x40
>  [<c01e953a>]bus_for_each_dev+0x4a/0x90
>  [<c01e8dc3>]driver_attach+0x13/0x20
>  [<c01e8d70>]do_driver_attach+0x0/0x40
>  [<c01e981a>]driver_register+0x5a/0x70
>  [<c01ab066>]pci_register_driver+0x36/0x50
>  [<c0246595>]cdrom_sysctl_register+0x15/0x70
>  [<c0105030>]init+0x0/0x160
>  [<c0105051>]init+0x21/0x160
>  [<c0105030>]init+0x0/0x160
>  [<c0107015>]kernel_thread_helper+0x5/0x10
> Code: 00 88 cc de 48 77 7e c1 48 77 7e c1 00 a4 c8 de 80 81 40 40
>
> -----------------------------------------------------------------
> bash-2.05# lspci -vvv
> 00:00.0 Class 0600: 8086:2560 (rev 01)
>         Subsystem: 8086:2560
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Step
> ping- SERR+ FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
> <TAbort-
> <MAbort+ >SERR- <PERR-
>         Latency: 0
>         Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
>         Capabilities: [e4] #09 [1105]
>
> 00:02.0 Class 0300: 8086:2562 (rev 01)
>         Subsystem: 8086:4c59
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Step
> ping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
> <TAbort-
> <MAbort- >SERR- <PERR-
>         Latency: 0
>         Interrupt: pin A routed to IRQ 11
>         Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
>         Region 1: Memory at ffa80000 (32-bit, non-prefetchable) [size=512K]
>         Capabilities: [d0] Power Management version 1
>                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot
> -,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> 00:1d.0 Class 0c03: 8086:24c2 (rev 01)
>         Subsystem: 8086:4c59
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Step
> ping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort
> - <MAbort- >SERR- <PERR-
>         Latency: 0
>         Interrupt: pin A routed to IRQ 11
>         Region 4: I/O ports at e800 [size=32]
>
> 00:1d.1 Class 0c03: 8086:24c4 (rev 01)
>         Subsystem: 8086:4c59
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Step
> ping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort
> - <MAbort- >SERR- <PERR-
>         Latency: 0
>         Interrupt: pin B routed to IRQ 11
>         Region 4: I/O ports at e880 [size=32]
>
> 00:1d.2 Class 0c03: 8086:24c7 (rev 01)
>         Subsystem: 8086:4c59
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Step
> ping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort
> - <MAbort- >SERR- <PERR-
>         Latency: 0
>         Interrupt: pin C routed to IRQ 5
>         Region 4: I/O ports at ec00 [size=32]
>
> 00:1d.7 Class 0c03: 8086:24cd (rev 01) (prog-if 20)
>         Subsystem: 8086:4c59
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Step
> ping- SERR+ FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort
> - <MAbort- >SERR- <PERR-
>         Latency: 0
>         Interrupt: pin D routed to IRQ 9
>         Region 0: Memory at ffa7fc00 (32-bit, non-prefetchable) [size=1K]
>         Capabilities: [50] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
> PME(D0+,D1-,D2-,D3h
> ot+,D3cold+)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>         Capabilities: [58] #0a [2080]
>
> 00:1e.0 Class 0604: 8086:244e (rev 81)
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Step
> ping- SERR+ FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
> <TAbort-
> <MAbort- >SERR- <PERR+
>         Latency: 0
>         Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
>         I/O behind bridge: 0000d000-0000dfff
>         Memory behind bridge: ff800000-ff8fffff
>         Prefetchable memory behind bridge: e6a00000-e6afffff
>         BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
>
> 00:1f.0 Class 0601: 8086:24c0 (rev 01)
>         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
> Step
> ping- SERR+ FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort
> - <MAbort- >SERR- <PERR-
>         Latency: 0
>
> 00:1f.1 Class 0101: 8086:24cb (rev 01) (prog-if 8a [Master SecP PriP])
>         Subsystem: 8086:4c59
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Step
> ping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort
> - <MAbort- >SERR- <PERR-
>         Latency: 0
>         Interrupt: pin A routed to IRQ 5
>         Region 0: I/O ports at <unassigned> [size=8]
>         Region 1: I/O ports at <unassigned> [size=4]
>         Region 2: I/O ports at <unassigned> [size=8]
>         Region 3: I/O ports at <unassigned> [size=4]
>         Region 4: I/O ports at ffa0 [size=16]
>         Region 5: Memory at 1ff00000 (32-bit, non-prefetchable) [disabled]
> [size
> =1K]
>
> 00:1f.3 Class 0c05: 8086:24c3 (rev 01)
>         Subsystem: 8086:4c59
>         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
> Step
> ping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort
> - <MAbort- >SERR- <PERR-
>         Interrupt: pin B routed to IRQ 11
>         Region 4: I/O ports at e000 [size=32]
>
> 00:1f.5 Class 0401: 8086:24c5 (rev 01)
>         Subsystem: 8086:0302
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Step
> ping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort
> - <MAbort- >SERR- <PERR-
>         Latency: 0
>         Interrupt: pin B routed to IRQ 11
>         Region 0: I/O ports at e400 [size=256]
>         Region 1: I/O ports at e080 [size=64]
>         Region 2: Memory at ffa7f800 (32-bit, non-prefetchable) [size=512]
>         Region 3: Memory at ffa7f400 (32-bit, non-prefetchable) [size=256]
>         Capabilities: [50] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
> PME(D0+,D1-,D2-,D3h
> ot+,D3cold+)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> 01:00.0 Class 0180: 105a:4d68 (rev 02) (prog-if 85)
>         Subsystem: 105a:4d68
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Step
> ping- SERR- FastB2B-
>         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
> <TAbort-
> <MAbort- >SERR- <PERR-
>         Latency: 32 (1000ns min, 4500ns max), cache line size 08
>         Interrupt: pin A routed to IRQ 10
>         Region 0: I/O ports at dc00 [size=8]
>         Region 1: I/O ports at d880 [size=4]
>         Region 2: I/O ports at d800 [size=8]
>         Region 3: I/O ports at d480 [size=4]
>         Region 4: I/O ports at d400 [size=16]
>         Region 5: Memory at ff8fc000 (32-bit, non-prefetchable) [size=16K]
>         Expansion ROM at ff8f8000 [disabled] [size=16K]
>         Capabilities: [60] Power Management version 1
>                 Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot
> -,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> 01:01.0 Class 0180: 105a:4d68 (rev 02) (prog-if 85)
>         Subsystem: 105a:4d68
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Step
> ping- SERR- FastB2B-
>         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
> <TAbort-
> <MAbort- >SERR- <PERR-
>         Latency: 32 (1000ns min, 4500ns max), cache line size 08
>         Interrupt: pin A routed to IRQ 11
>         Region 0: I/O ports at d080 [size=8]
>         Region 1: I/O ports at d000 [size=4]
>         Region 2: I/O ports at df00 [size=8]
>         Region 3: I/O ports at de80 [size=4]
>         Region 4: I/O ports at de00 [size=16]
>         Region 5: Memory at ff8f4000 (32-bit, non-prefetchable) [size=16K]
>         Expansion ROM at ff8f0000 [disabled] [size=16K]
>         Capabilities: [60] Power Management version 1
>                 Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot
> -,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> 01:02.0 Class 0200: 8086:100e (rev 02)
>         Subsystem: 8086:002e
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
> Step
> ping- SERR+ FastB2B-
>         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort
> - <MAbort- >SERR- <PERR-
>         Latency: 32 (63750ns min), cache line size 08
>         Interrupt: pin A routed to IRQ 5
>         Region 0: Memory at ff8c0000 (32-bit, non-prefetchable) [size=128K]
>         Region 1: Memory at ff8a0000 (32-bit, non-prefetchable) [size=128K]
>         Region 2: I/O ports at dd80 [size=64]
>         Expansion ROM at ff880000 [disabled] [size=128K]
>         Capabilities: [dc] Power Management version 2
>                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot
> +,D3cold+)
>                 Status: D0 PME-Enable- DSel=0 DScale=1 PME-
>         Capabilities: [e4] PCI-X non-bridge device.
>                 Command: DPERE- ERO+ RBC=0 OST=0
>                 Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-,
> DC=simple,
> DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
>         Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0
> Enable
> -
>                 Address: 0000000000000000  Data: 0000
>
> 01:08.0 Class 0200: 8086:1039 (rev 81)
>         Subsystem: 8086:3013
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
> Step
> ping- SERR+ FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort
> - <MAbort- >SERR- <PERR-
>         Latency: 32 (2000ns min, 14000ns max), cache line size 08
>         Interrupt: pin A routed to IRQ 11
>         Region 0: Memory at ff8ef000 (32-bit, non-prefetchable) [size=4K]
>         Region 1: I/O ports at dd00 [size=64]
>         Capabilities: [dc] Power Management version 2
>                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
> PME(D0+,D1+,D2+,D3hot
> +,D3cold+)
>                 Status: D0 PME-Enable- DSel=0 DScale=2 PME-
>
> bash-2.05#

-- 
Roy Sigurd Karlsbakk, Datavaktmester
ProntoTV AS - http://www.pronto.tv/
Tel: +47 9801 3356

Computers are like air conditioners.
They stop working when you open Windows.

