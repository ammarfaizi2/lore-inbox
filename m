Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261469AbVALViE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261469AbVALViE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 16:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbVALVgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 16:36:45 -0500
Received: from smtp805.mail.sc5.yahoo.com ([66.163.168.184]:47247 "HELO
	smtp805.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261329AbVALVac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 16:30:32 -0500
Message-ID: <41E597EA.2040309@sbcglobal.net>
Date: Wed, 12 Jan 2005 13:34:34 -0800
From: Steve <s.egbert@sbcglobal.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050109)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.10-r1 MTRR bug
References: <41E595E9.8040805@sbcglobal.net>
In-Reply-To: <41E595E9.8040805@sbcglobal.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve wrote:

> For the Athlon 2100, I get the following outputs and then the VGA 
> console is frozen from further output (but it doesn't prevent the full 
> bootup into X windows session of which I am able to resume normal 
> Linux/X session, but not able to regain any virtual console session.)
>
> The virtual console (locked) shows the following outputs:
>
> vesafb: scrolling: redraw:
> mtrr: size and base must be multiples of 4kiB  (<<-- this line is 
> repeated 20 times).


Oh, yes... the details...  Elitegroup PC (Fry's special with Linspire 
removed in favor of Gentoo 2.6.10-r1)

/proc/version
Linux version 2.6.10-gentoo-r4 (root@holy) (gcc version 3.3.4 20040623 
(Gentoo Linux 3.3.4-r1, ssp-3.3.2-2, pie-8.7.6)) #2 Tue Jan 11 19:23:58 
PST 2005


/proc/cpuinfo

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(tm) XP 2600+
stepping        : 1
cpu MHz         : 2068.272
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 mmx fxsr sse pni syscall mmxext 3dnowext 3dnow
bogomips        : 4104.19


/proc/modules
it87 21284 0 - Live 0xe7a45000
i2c_sensor 3072 1 it87, Live 0xe781e000
i2c_isa 1920 0 - Live 0xe787c000
parport_pc 29636 1 - Live 0xe7a50000
lp 8872 0 - Live 0xe79ba000
parport 32200 2 parport_pc,lp, Live 0xe7a3c000
usbhid 29888 0 - Live 0xe7a33000
sis900 17284 0 - Live 0xe7a2d000
ehci_hcd 29572 0 - Live 0xe7a16000
ohci_hcd 19208 0 - Live 0xe7a10000
snd_pcm_oss 48548 0 - Live 0xe7a20000
snd_mixer_oss 17664 3 snd_pcm_oss, Live 0xe7a0a000
snd_seq_oss 31872 0 - Live 0xe79c6000
snd_seq_midi_event 6400 1 snd_seq_oss, Live 0xe7838000
snd_seq 49424 4 snd_seq_oss,snd_seq_midi_event, Live 0xe79fc000
snd_seq_device 7052 2 snd_seq_oss,snd_seq, Live 0xe7835000
snd_intel8x0 28192 3 - Live 0xe79a4000
snd_ac97_codec 72160 1 snd_intel8x0, Live 0xe79e9000
snd_pcm 84616 3 snd_pcm_oss,snd_intel8x0,snd_ac97_codec, Live 0xe79d3000
snd_timer 21380 2 snd_seq,snd_pcm, Live 0xe799d000
snd 47844 11 
snd_pcm_oss,snd_mixer_oss,snd_seq_oss,snd_seq,snd_seq_device,snd_in
tel8x0,snd_ac97_codec,snd_pcm,snd_timer, Live 0xe79ad000
soundcore 7648 3 snd, Live 0xe7825000
snd_page_alloc 7684 2 snd_intel8x0,snd_pcm, Live 0xe7822000
usbcore 104056 4 usbhid,ehci_hcd,ohci_hcd, Live 0xe7861000
ide_cd 36868 0 - Live 0xe782a000


/proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0290-0297 :
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
  03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial
1000-1003 : PM1a_EVT_BLK
1004-1005 : PM1a_CNT_BLK
1008-100b : PM_TMR
1016-1016 : PM2_CNT_BLK
1020-1023 : GPE0_BLK
1030-1033 : GPE1_BLK
4000-400f : 0000:00:02.5
  4000-4007 : ide0
  4008-400f : ide1
c000-cfff : PCI Bus #01
  c000-c07f : 0000:01:00.0
d000-d0ff : 0000:00:02.6
d400-d47f : 0000:00:02.6
d800-d8ff : 0000:00:02.7
  d800-d8ff : SiS SI7012
dc00-dc7f : 0000:00:02.7
  dc00-dc7f : SiS SI7012
e000-e0ff : 0000:00:04.0
  e000-e0ff : sis900

/proc/iomem
00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-26feffff : System RAM
  00100000-003b806d : Kernel code
  003b806e-004a5bff : Kernel data
26ff0000-26ff2fff : ACPI Non-volatile Storage
26ff3000-26ffffff : ACPI Tables
d0000000-d7ffffff : 0000:00:00.0
d8000000-dfffffff : PCI Bus #01
  d8000000-dfffffff : 0000:01:00.0
e0000000-e3ffffff : 0000:00:0a.0
e5000000-e50fffff : PCI Bus #01
  e5000000-e501ffff : 0000:01:00.0
e5100000-e5100fff : 0000:00:03.2
  e5100000-e5100fff : ohci_hcd
e5101000-e5101fff : 0000:00:03.3
  e5101000-e5101fff : ehci_hcd
e5102000-e5102fff : 0000:00:04.0
  e5102000-e5102fff : sis900
e5103000-e5103fff : 0000:00:03.0
  e5103000-e5103fff : ohci_hcd
e5104000-e5104fff : 0000:00:03.1
  e5104000-e5104fff : ohci_hcd
f000ef6f-f100ef6e : vesafb
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved


lspci -vvv
0000:00:00.0 Host bridge: Silicon Integrated Systems [SiS] 
741/741GX/M741 Host (rev 03)
        Subsystem: Elitegroup Computer Systems: Unknown device 1b13
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32
        Region 0: Memory at d0000000 (32-bit, non-prefetchable)
        Capabilities: [c0] AGP version 3.5
                Status: RQ=32 Iso- ArqSz=2 Cal=3 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW- AGP3+ Rate=x4,x8
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- 
Rate=<none>

0000:00:01.0 PCI bridge: Silicon Integrated Systems [SiS]: Unknown 
device 0003 (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 99
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: e5000000-e50fffff
        Prefetchable memory behind bridge: d8000000-dfffffff
        Expansion ROM at 0000c000 [disabled] [size=4K]
        BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-

0000:00:02.0 ISA bridge: Silicon Integrated Systems [SiS] SiS964 [MuTIOL 
Media IO] (rev 36)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

0000:00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] 
(rev 01) (prog-if 80 [Master])
        Subsystem: Elitegroup Computer Systems: Unknown device 1b13
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 128
        Interrupt: pin ? routed to IRQ 16
        Region 0: I/O ports at <unassigned>
        Region 1: I/O ports at <unassigned>
        Region 2: I/O ports at <unassigned>
        Region 3: I/O ports at <unassigned>
        Region 4: I/O ports at 4000 [size=16]
        Capabilities: [58] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:02.6 Modem: Silicon Integrated Systems [SiS] AC'97 Modem 
Controller (rev a0) (prog-if 00 [Generic])
        Subsystem: Elitegroup Computer Systems: Unknown device 0c04
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 18
        Region 0: I/O ports at d000
        Region 1: I/O ports at d400 [size=128]
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:02.7 Multimedia audio controller: Silicon Integrated Systems 
[SiS] Sound Controller (rev a0)
        Subsystem: Elitegroup Computer Systems: Unknown device 1b13
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (13000ns min, 2750ns max)
        Interrupt: pin C routed to IRQ 18
        Region 0: I/O ports at d800
        Region 1: I/O ports at dc00 [size=128]
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=55mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:03.0 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 
Controller (rev 0f) (prog-if 10 [OHCI])
        Subsystem: Elitegroup Computer Systems: Unknown device 1b13
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 20
        Region 0: Memory at e5103000 (32-bit, non-prefetchable)

0000:00:03.1 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 
Controller (rev 0f) (prog-if 10 [OHCI])
        Subsystem: Elitegroup Computer Systems: Unknown device 1b13
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), cache line size 08
        Interrupt: pin B routed to IRQ 21
        Region 0: Memory at e5104000 (32-bit, non-prefetchable)

0000:00:03.2 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 
Controller (rev 0f) (prog-if 10 [OHCI])
        Subsystem: Elitegroup Computer Systems: Unknown device 1b13
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), cache line size 08
        Interrupt: pin C routed to IRQ 22
        Region 0: Memory at e5100000 (32-bit, non-prefetchable)

0000:00:03.3 USB Controller: Silicon Integrated Systems [SiS] USB 2.0 
Controller (prog-if 20 [EHCI])
        Subsystem: Elitegroup Computer Systems: Unknown device 1b13
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max)
        Interrupt: pin D routed to IRQ 23
        Region 0: Memory at e5101000 (32-bit, non-prefetchable)
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:04.0 Ethernet controller: Silicon Integrated Systems [SiS] 
SiS900 PCI Fast Ethernet (rev 91)
        Subsystem: Elitegroup Computer Systems: Unknown device 1b13
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (13000ns min, 2750ns max)
        Interrupt: pin A routed to IRQ 19
        Region 0: I/O ports at e000
        Region 1: Memory at e5102000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:0a.0 Multimedia video controller: Internext Compression Inc 
iTVC16 (CX23416) MPEG-2 Encoder (rev 01)
        Subsystem: Hauppauge computer works Inc. WinTV PVR 250
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (32000ns min, 2000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at e0000000 (32-bit, prefetchable)
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] 
661/741/760 PCI/AGP VGA Display Adapter (prog-if 00 [VGA])
        Subsystem: Elitegroup Computer Systems: Unknown device 1b13
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 10
        BIST result: 00
        Region 0: Memory at d8000000 (32-bit, prefetchable)
        Region 1: Memory at e5000000 (32-bit, non-prefetchable) [size=128K]
        Region 2: I/O ports at c000 [size=128]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] AGP version 3.0
                Status: RQ=256 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW- AGP3+ Rate=x4,x8
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- 
Rate=<none>


/proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: CD-ROM   Model: F565E            Rev: 1.07
  Type:   CD-ROM                           ANSI SCSI revision: 02


/proc/acpi/wakeup
Device Sleep state      Status
FUTS     4              *enabled
PCI0     5              disabled
USB0     3              disabled
USB1     3              disabled
USB2     3              disabled
USB3     3              disabled
MAC0     5              disabled
AMR0     4              disabled
UAR1     5              disabled
PS2M     5              disabled
PS2K     4              disabled

