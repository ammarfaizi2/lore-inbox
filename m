Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262810AbVBZBNl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262810AbVBZBNl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 20:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262809AbVBZBMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 20:12:35 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:14049 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262816AbVBZBFR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 20:05:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=oakKoJR8fW93rLg2bJcgC+Sj8VZdhainwWtvlfOKki7RUdZamdFsn5P+nmRtxgGb7DatArdZ3I6DNLC48+PB0U2yrH2TLBNCdJQ4dwpBdc+0jwyRA6IX3WINlSBy/O8rXUeEfHZVxrz8ztbfgD2VgeutGjT6mJzXRvdETKDFKdM=
Message-ID: <e16ac85e050225170545ceceb7@mail.gmail.com>
Date: Fri, 25 Feb 2005 18:05:13 -0700
From: Greg Felix <gregfelixlkml@gmail.com>
Reply-To: Greg Felix <gregfelixlkml@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: PROBLEM: ICH7 SATA drive not detected.
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <e16ac85e05022517024beb5b38@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <e16ac85e050225153649939bed@mail.gmail.com>
	 <421FBC0B.5070004@pobox.com>
	 <e16ac85e05022517024beb5b38@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff,

I forgot: in dmesg I see the following:

ata_piix: probe of 0000:00:1f.2 failed with error -5

Greg Felix


On Fri, 25 Feb 2005 18:02:59 -0700, Greg Felix <gregfelixlkml@gmail.com> wrote:
> > Jeff Garzik wrote:
> > See REPORTING-BUGS for the sort of information you should provide.  This
> > is a "it doesn't work" report without much more info.
> >
> > I would suggest doing a "modprobe ata_piix" or "modprobe ahci"
> > (depending on ICH7 mode and hardware) and see what happens in 'dmesg'.
> >
> >         Jeff
> 
> Let me try and do this right.
> Here's the bug report:
> 
> ICH7 SATA drive not detected.
> 
> I have two new OEM machines that are both ICH7 chipsets.  Both
> machines give the same vendor and device PCI ids for their storage
> controllers. 8086:27df and 8086:27c0.  One of the machines' disks is
> being detected correctly (sda).  The other one is not.  I have tried
> modprobing both ata_piix and ahci with negative results.  It is very
> new hardware.  There is also a broadcom NIC that is not being
> detected, but I don't NEED that to work. (I'll file a bug if requested
> of me.)
> 
> keywords: piix, ICH7, SATA, ata_piix, ahci
> 
> I'm running 2.6.11-rc5 in a custom distribution in a ram disk from a
> pxe boot.  I also have a USB memory device inserted into the machine
> being detected as sda for the reports below.
> 
> Here's the output of ver_linux:
> Linux (none) 2.6.11-rc5 #1 Fri Feb 25 12:31:16 MST 2005 i686 unknown
> unknown GNU/Linux
> 
> Gnu C                  18:
> mount                  2.12p
> module-init-tools      3.1
> reiserfsprogs          line
> reiser4progs           line
> Dynamic linker (ldd)   2.3.4
> Procps                 3.2.3
> Net-tools              1.60
> Kbd                    81:
> Sh-utils               5.2.1
> Modules Loaded
> 
> /proc/cpuinfo reads:
> processor       : 0
> vendor_id       : GenuineIntel
> cpu family      : 15
> model           : 4
> model name      : Genuine Intel(R) CPU 3.20GHz
> stepping        : 1
> cpu MHz         : 3193.334
> cache size      : 1024 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 5
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
> mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx
> pni monitor ds_cpl cid xtpr
> bogomips        : 6307.84
> 
> /proc/modules reads:
> ahci 5508 0 - Live 0xe0086000
> nls_cp437 4608 1 - Live 0xe0083000
> msdos 5248 1 - Live 0xe0018000
> fat 27548 1 msdos, Live 0xe008e000
> nls_base 4352 2 nls_cp437,fat, Live 0xe001b000
> sd_mod 11152 2 - Live 0xe0038000
> usb_storage 25216 1 - Live 0xe0065000
> usbhid 21376 0 - Live 0xe0047000
> edd 6496 0 - Live 0xe0007000
> ide_cd 29956 0 - Live 0xe007a000
> cdrom 30112 1 ide_cd, Live 0xe0071000
> ide_disk 11520 0 - Live 0xe0034000
> ata_piix 4228 0 - Live 0xe0031000
> libata 28804 2 ahci,ata_piix, Live 0xe003e000
> piix 6404 0 [permanent], Live 0xe0002000
> generic 2432 0 [permanent], Live 0xe0005000
> ide_core 85676 5 usb_storage,ide_cd,ide_disk,piix,generic, Live 0xe004f000
> ehci_hcd 21000 0 - Live 0xe0011000
> uhci_hcd 22416 0 - Live 0xe000a000
> usbcore 72696 5 usb_storage,usbhid,ehci_hcd,uhci_hcd, Live 0xe001e000
> 
> /proc/ioports reads:
> 0000-001f : dma1
> 0020-0021 : pic1
> 0040-0043 : timer0
> 0050-0053 : timer1
> 0060-006f : keyboard
> 0080-008f : dma page reg
> 00a0-00a1 : pic2
> 00c0-00df : dma2
> 00f0-00ff : fpu
> 01f0-01f7 : ide0
> 03c0-03df : vga+
> 03f6-03f6 : ide0
> 0cf8-0cff : PCI conf1
> 1000-101f : 0000:00:1d.0
>   1000-101f : uhci_hcd
> 1020-103f : 0000:00:1d.1
>   1020-103f : uhci_hcd
> 1040-105f : 0000:00:1d.2
>   1040-105f : uhci_hcd
> 1060-107f : 0000:00:1d.3
>   1060-107f : uhci_hcd
> 10a0-10af : 0000:00:1f.1
>   10a0-10a7 : ide0
>   10a8-10af : ide1
> 10b0-10bf : 0000:00:1f.2
> 10c0-10c7 : 0000:00:02.0
> 10d8-10df : 0000:00:1f.2
> 10e0-10e7 : 0000:00:1f.2
> 10f0-10f3 : 0000:00:1f.2
> 10f4-10f7 : 0000:00:1f.2
> 
> /proc/iomem reads:
> 00000000-0009fbff : System RAM
> 0009fc00-0009ffff : reserved
> 000a0000-000bffff : Video RAM area
> 000c0000-000c7fff : Video ROM
> 000ca800-000cb7ff : Adapter ROM
> 000cb800-000ccfff : Adapter ROM
> 000f0000-000fffff : System ROM
> 00100000-1f7e27ff : System RAM
>   00100000-00210717 : Kernel code
>   00210718-0024c37f : Kernel data
> 1f7e2800-1fffffff : reserved
> d0000000-dfffffff : 0000:00:02.0
> e0400000-e047ffff : 0000:00:02.0
> e0480000-e04bffff : 0000:00:02.0
> e04c0000-e04c3fff : 0000:00:1b.0
> e04c4000-e04c43ff : 0000:00:1d.7
>   e04c4000-e04c43ff : ehci_hcd
> e04c4400-e04c47ff : 0000:00:1f.2
> e0500000-e07fffff : PCI Bus #3f
>   e0500000-e050ffff : 0000:3f:00.0
> f0000000-f3ffffff : reserved
> fec00000-ffffffff : reserved
> 
> lspci -vvv gives:
> 00:00.0 Class 0600: 8086:2770
>         Subsystem: 103c:3011
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR+ FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort+ >SERR- <PERR-
>         Latency: 0
>         Capabilities: [e0] Vendor Specific Information
> 
> 00:02.0 Class 0300: 8086:2772
>         Subsystem: 103c:3011
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Interrupt: pin A routed to IRQ 10
>         Region 0: Memory at e0400000 (32-bit, non-prefetchable) [size=512K]
>         Region 1: I/O ports at 10c0 [size=8]
>         Region 2: Memory at d0000000 (32-bit, prefetchable) [size=256M]
>         Region 3: Memory at e0480000 (32-bit, non-prefetchable) [size=256K]
>         Capabilities: [90] Message Signalled Interrupts: 64bit-
> Queue=0/0 Enable-
>                 Address: 00000000  Data: 0000
>         Capabilities: [d0] Power Management version 2
>                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:1b.0 Class 0403: 8086:27d8
>         Subsystem: 103c:3011
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR+ FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0, Cache Line Size 10
>         Interrupt: pin A routed to IRQ 11
>         Region 0: Memory at e04c0000 (64-bit, non-prefetchable) [size=16K]
>         Capabilities: [50] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>         Capabilities: [60] Message Signalled Interrupts: 64bit+
> Queue=0/0 Enable-
>                 Address: 0000000000000000  Data: 0000
>         Capabilities: [70] Express Unknown type IRQ 0
>                 Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
>                 Device: Latency L0s <64ns, L1 <1us
>                 Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
>                 Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
>                 Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
>                 Link: Supported Speed unknown, Width x0, ASPM unknown, Port 0
>                 Link: Latency L0s <64ns, L1 <1us
>                 Link: ASPM Disabled CommClk- ExtSynch-
>                 Link: Speed unknown, Width x0
> 
> 00:1c.0 Class 0604: 8086:27d0
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR+ FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0, Cache Line Size 10
>         Bus: primary=00, secondary=20, subordinate=20, sec-latency=0
>         I/O behind bridge: 0000f000-00000fff
>         Memory behind bridge: fff00000-000fffff
>         Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
>         Secondary status: 66Mhz- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort+ <SERR- <PERR-
>         BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
>         Capabilities: [40] Express Root Port (Slot+) IRQ 0
>                 Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
>                 Device: Latency L0s unlimited, L1 unlimited
>                 Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
>                 Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>                 Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
>                 Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 1
>                 Link: Latency L0s <1us, L1 <4us
>                 Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
>                 Link: Speed 2.5Gb/s, Width x1
>                 Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug+ Surpise+
>                 Slot: Number 2, PowerLimit 10.000000
>                 Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
>                 Slot: AttnInd Unknown, PwrInd Unknown, Power-
>                 Root: Correctable- Non-Fatal- Fatal- PME-
>         Capabilities: [80] Message Signalled Interrupts: 64bit-
> Queue=0/0 Enable-
>                 Address: 00000000  Data: 0000
>         Capabilities: [90] #0d [0000]
>         Capabilities: [a0] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:1c.1 Class 0604: 8086:27d2
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR+ FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0, Cache Line Size 10
>         Bus: primary=00, secondary=3f, subordinate=3f, sec-latency=0
>         I/O behind bridge: 0000f000-00000fff
>  Memory behind bridge: e0500000-e07fffff
>         Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
>         Secondary status: 66Mhz- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- <SERR- <PERR-
>         BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
>         Capabilities: [40] Express Root Port (Slot+) IRQ 0
>                 Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
>                 Device: Latency L0s unlimited, L1 unlimited
>                 Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
>                 Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>                 Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
>                 Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 2
>                 Link: Latency L0s <256ns, L1 <4us
>                 Link: ASPM Disabled RCB 64 bytes CommClk+ ExtSynch-
>                 Link: Speed 2.5Gb/s, Width x1
>                 Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug+ Surpise+
>                 Slot: Number 3, PowerLimit 10.000000
>                 Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
>                 Slot: AttnInd Unknown, PwrInd Unknown, Power-
>                 Root: Correctable- Non-Fatal- Fatal- PME-
>         Capabilities: [80] Message Signalled Interrupts: 64bit-
> Queue=0/0 Enable-
>                 Address: 00000000  Data: 0000
>         Capabilities: [90] #0d [0000]
>         Capabilities: [a0] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:1d.0 Class 0c03: 8086:27c8
>         Subsystem: 103c:3011
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
> >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Interrupt: pin A routed to IRQ 5
>         Region 4: I/O ports at 1000 [size=32]
> 
> 00:1d.1 Class 0c03: 8086:27c9
>         Subsystem: 103c:3011
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
> >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Interrupt: pin B routed to IRQ 10
>         Region 4: I/O ports at 1020 [size=32]
> 
> 00:1d.2 Class 0c03: 8086:27ca
>         Subsystem: 103c:3011
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
> >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Interrupt: pin C routed to IRQ 11
>         Region 4: I/O ports at 1040 [size=32]
> 
> 00:1d.3 Class 0c03: 8086:27cb
>         Subsystem: 103c:3011
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
> >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Interrupt: pin D routed to IRQ 11
>         Region 4: I/O ports at 1060 [size=32]
> 
> 00:1d.7 Class 0c03: 8086:27cc (prog-if 20)
>         Subsystem: 103c:3011
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR+ FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
> >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Interrupt: pin A routed to IRQ 5
>         Region 0: Memory at e04c4000 (32-bit, non-prefetchable) [size=1K]
>         Capabilities: [50] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>         Capabilities: [58] Debug port
> 
> 00:1e.0 Class 0604: 8086:244e (rev e0) (prog-if 01)
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR+ FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Bus: primary=00, secondary=05, subordinate=05, sec-latency=32
>         I/O behind bridge: 0000f000-00000fff
>         Memory behind bridge: fff00000-000fffff
>         Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
>         Secondary status: 66Mhz- FastB2B+ ParErr- DEVSEL=medium
> >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
>         BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
>         Capabilities: [50] #0d [0000]
> 
> 00:1f.0 Class 0601: 8086:27b0
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR+ FastB2B-
> Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Capabilities: [e0] Vendor Specific Information
> 
> 00:1f.1 Class 0101: 8086:27df (prog-if 8a [Master SecP PriP])
>         Subsystem: 103c:3011
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
> >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Interrupt: pin A routed to IRQ 5
>         Region 0: I/O ports at <ignored>
>         Region 1: I/O ports at <ignored>
>         Region 2: I/O ports at <ignored>
>         Region 3: I/O ports at <ignored>
>         Region 4: I/O ports at 10a0 [size=16]
> 
> 00:1f.2 Class 0101: 8086:27c0 (prog-if 8f [Master SecP SecO PriP PriO])
>         Subsystem: 103c:3011
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium
> >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Interrupt: pin B routed to IRQ 5
>         Region 0: I/O ports at 10d8 [size=8]
>         Region 1: I/O ports at 10f0 [size=4]
>         Region 2: I/O ports at 10e0 [size=8]
>         Region 3: I/O ports at 10f4 [size=4]
>         Region 4: I/O ports at 10b0 [size=16]
>         Region 5: Memory at e04c4400 (32-bit, non-prefetchable)
> [disabled] [size=1K]
>         Capabilities: [80] Message Signalled Interrupts: 64bit-
> Queue=0/2 Enable-
>                 Address: 00000000  Data: 0000
>         Capabilities: [70] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot+,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 3f:00.0 Class 0200: 14e4:1600
>         Subsystem: 103c:3011
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr+ Stepping- SERR+ FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0, Cache Line Size 10
>         Interrupt: pin A routed to IRQ 5
>         Region 0: Memory at e0500000 (64-bit, non-prefetchable) [size=64K]
>         Capabilities: [48] Power Management version 2
> 
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot+,D3cold+)
>                 Status: D0 PME-Enable- DSel=0 DScale=1 PME-
>         Capabilities: [50] Vital Product Data
>         Capabilities: [58] Message Signalled Interrupts: 64bit+
> Queue=0/3 Enable-
>                 Address: 0068d809080002c0  Data: 0000
>         Capabilities: [d0] Express Endpoint IRQ 0
>                 Device: Supported: MaxPayload 512 bytes, PhantFunc 0, ExtTag+
>                 Device: Latency L0s <4us, L1 unlimited
>                 Device: AtnBtn- AtnInd- PwrInd-
>                 Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
>                 Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>                 Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
>                 Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 0
>                 Link: Latency L0s <4us, L1 <64us
>                 Link: ASPM Disabled RCB 64 bytes CommClk+ ExtSynch-
>                 Link: Speed 2.5Gb/s, Width x1
> 
> /proc/devices reads:
> Character devices:
>   1 mem
>   4 /dev/vc/0
>   4 tty
>   5 /dev/tty
>   5 /dev/console
>   7 vcs
>  10 misc
>  13 input
> 180 usb
> 
> Block devices:
>   1 ramdisk
>   3 ide0
>   8 sd
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
>
