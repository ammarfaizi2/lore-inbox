Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266022AbUFDWEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266022AbUFDWEa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 18:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266023AbUFDWEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 18:04:30 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:56260 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S266022AbUFDWC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 18:02:27 -0400
From: "R. J. Wysocki" <rjwysocki@sisk.pl>
Organization: SiSK
To: linux-kernel@vger.kernel.org
Subject: [BUG] 2.6.7-rc2-mm2: system reboot at kernel init on a dual Opteron
Date: Sat, 5 Jun 2004 00:00:07 +0200
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_nDPwA+zAOyeYz7I"
Message-Id: <200406050000.07302.rjwysocki@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_nDPwA+zAOyeYz7I
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

The 2.6.7-rc2-mm2 reboots my dual Opteron system as soon as it's loaded.  
There's no any serial console output available, and the hardware environment 
log is attached.

Yours,
rjw

--Boundary-00=_nDPwA+zAOyeYz7I
Content-Type: text/x-log;
  charset="iso-8859-2";
  name="hardware.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="hardware.log"

chimera:~ # cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 5
model name      : AMD Opteron(tm) Processor 240
stepping        : 1
cpu MHz         : 1386.744
cache size      : 1024 KB
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext lm 3dnowext 3dnow
bogomips        : 2727.93
TLB size        : 1088 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts ttp

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 5
model name      : AMD Opteron(tm) Processor 240
stepping        : 1
cpu MHz         : 1386.744
cache size      : 1024 KB
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext lm 3dnowext 3dnow
bogomips        : 2768.89
TLB size        : 1088 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts ttp

chimera:~ # cat /proc/modules
snd_seq 62848 1 - Live 0xffffffffa01a7000
ipt_TCPMSS 4736 1 - Live 0xffffffffa01a4000
ipt_TOS 3008 18 - Live 0xffffffffa01a2000
usbserial 30900 0 - Live 0xffffffffa0199000
ipt_MASQUERADE 5376 1 - Live 0xffffffffa0196000
ipt_LOG 7040 87 - Live 0xffffffffa0193000
ipt_state 2560 75 - Live 0xffffffffa0191000
parport_pc 40128 1 - Live 0xffffffffa0186000
lp 12392 0 - Live 0xffffffffa017f000
parport 46220 2 parport_pc,lp, Live 0xffffffffa0172000
ppp_generic 29728 0 - Live 0xffffffffa0169000
slhc 8256 1 ppp_generic, Live 0xffffffffa0165000
snd_pcm_oss 66024 0 - Live 0xffffffffa0153000
snd_mixer_oss 21504 1 snd_pcm_oss, Live 0xffffffffa014c000
snd_ioctl32 17984 0 - Live 0xffffffffa0146000
snd_intel8x0 39956 5 - Live 0xffffffffa013b000
snd_ac97_codec 78724 1 snd_intel8x0, Live 0xffffffffa0126000
snd_pcm 116896 4 snd_pcm_oss,snd_ioctl32,snd_intel8x0, Live 0xffffffffa0108000
snd_timer 28680 2 snd_seq,snd_pcm, Live 0xffffffffa00ff000
snd_page_alloc 14160 2 snd_intel8x0,snd_pcm, Live 0xffffffffa00fa000
gameport 5184 1 snd_intel8x0, Live 0xffffffffa00f7000
snd_mpu401_uart 9536 1 snd_intel8x0, Live 0xffffffffa00f3000
snd_rawmidi 29440 1 snd_mpu401_uart, Live 0xffffffffa00ea000
snd_seq_device 9804 2 snd_seq,snd_rawmidi, Live 0xffffffffa00e6000
snd 70184 21 snd_seq,snd_pcm_oss,snd_mixer_oss,snd_ioctl32,snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device, Live 0xffffffffa00d3000
soundcore 11168 1 snd, Live 0xffffffffa00cf000
eth1394 22352 0 - Live 0xffffffffa00c8000
usblp 14080 0 - Live 0xffffffffa00c3000
ohci_hcd 21828 0 - Live 0xffffffffa00bc000
ehci_hcd 29636 0 - Live 0xffffffffa00b3000
usbcore 121656 6 usbserial,usblp,ohci_hcd,ehci_hcd, Live 0xffffffffa0094000
raw1394 28312 0 - Live 0xffffffffa008c000
ohci1394 34180 0 - Live 0xffffffffa0082000
ieee1394 116472 3 eth1394,raw1394,ohci1394, Live 0xffffffffa0064000
tg3 82692 0 - Live 0xffffffffa004e000
ipt_REJECT 7232 3 - Live 0xffffffffa004b000
iptable_mangle 3520 1 - Live 0xffffffffa0049000
iptable_filter 3456 1 - Live 0xffffffffa0047000
ip_nat_ftp 6672 0 - Live 0xffffffffa0044000
iptable_nat 32572 3 ipt_MASQUERADE,ip_nat_ftp, Live 0xffffffffa003b000
ip_tables 21952 9 ipt_TCPMSS,ipt_TOS,ipt_MASQUERADE,ipt_LOG,ipt_state,ipt_REJECT,iptable_mangle,iptable_filter,iptable_nat, Live 0xffffffffa0034000
floppy 64984 0 - Live 0xffffffffa0023000
sg 41464 0 - Live 0xffffffffa0017000
sr_mod 19684 0 - Live 0xffffffffa0011000
cdrom 39016 1 sr_mod, Live 0xffffffffa0006000
ide_scsi 18628 0 - Live 0xffffffffa0000000
chimera:~ # cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
5008-500b : ACPI timer
5010-5015 : ACPI CPU throttle
8000-8fff : PCI Bus #02
  8800-88ff : 0000:02:07.0
    8800-88ff : sym53c8xx
  8c00-8c0f : 0000:02:08.0
    8c00-8c0f : 3ware Storage Controller
9000-9fff : PCI Bus #03
  9400-940f : 0000:03:0b.0
    9400-940f : sata_sil
  9480-9483 : 0000:03:0b.0
    9480-9483 : sata_sil
  9800-9807 : 0000:03:0b.0
    9800-9807 : sata_sil
  9880-9883 : 0000:03:0b.0
    9880-9883 : sata_sil
  9c00-9c07 : 0000:03:0b.0
    9c00-9c07 : sata_sil
b480-b49f : 0000:00:07.2
b800-b8ff : 0000:00:07.5
  b800-b8ff : AMD AMD8111 - AC'97
bc00-bc3f : 0000:00:07.5
  bc00-bc3f : AMD AMD8111 - Controller
ffa0-ffaf : 0000:00:07.1
  ffa0-ffa7 : ide0
  ffa8-ffaf : ide1
chimera:~ # cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cf7ff : Video ROM
000cf800-000d07ff : Adapter ROM
000f0000-000fffff : System ROM
00100000-3ffeffff : System RAM
  00100000-0031397c : Kernel code
  0031397d-00424560 : Kernel data
3fff0000-3fffefff : ACPI Tables
3ffff000-3fffffff : ACPI Non-volatile Storage
daf00000-daffffff : PCI Bus #01
db000000-db0fffff : PCI Bus #02
db100000-db1fffff : PCI Bus #03
db300000-eb3fffff : PCI Bus #05
  e0000000-e7ffffff : 0000:05:00.0
    e0000000-e05fffff : vesafb
f0000000-f7ffffff : 0000:04:00.0
  f0000000-f7ffffff : aperture
fb500000-fb5fffff : PCI Bus #01
fb600000-fc6fffff : PCI Bus #02
  fb800000-fbffffff : 0000:02:08.0
  fc6dc000-fc6ddfff : 0000:02:07.0
    fc6dc000-fc6ddfff : sym53c8xx
  fc6df800-fc6dfbff : 0000:02:07.0
    fc6df800-fc6dfbff : sym53c8xx
  fc6dfc00-fc6dfc0f : 0000:02:08.0
  fc6f0000-fc6fffff : 0000:02:09.0
    fc6f0000-fc6fffff : tg3
fc700000-fc8fffff : PCI Bus #03
  fc8f7000-fc8f7fff : 0000:03:00.0
    fc8f7000-fc8f7fff : ohci_hcd
  fc8f8000-fc8fbfff : 0000:03:0c.0
  fc8fc000-fc8fcfff : 0000:03:00.1
    fc8fc000-fc8fcfff : ohci_hcd
  fc8fd000-fc8fdfff : 0000:03:0a.0
    fc8fd000-fc8fdfff : ohci_hcd
  fc8fe000-fc8fefff : 0000:03:0a.1
    fc8fe000-fc8fefff : ohci_hcd
  fc8ff000-fc8ff7ff : 0000:03:0c.0
    fc8ff000-fc8ff7ff : ohci1394
  fc8ff800-fc8ff8ff : 0000:03:0a.2
    fc8ff800-fc8ff8ff : ehci_hcd
  fc8ffc00-fc8fffff : 0000:03:0b.0
    fc8ffc00-fc8fffff : sata_sil
fc9fe000-fc9fefff : 0000:00:0a.1
fc9ff000-fc9fffff : 0000:00:0b.1
fca00000-feafffff : PCI Bus #05
  fd000000-fdffffff : 0000:05:00.0
ff7c0000-ffffffff : reserved
chimera:~ # lspci -vvv
00:06.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8111 PCI (rev 07) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=64
        I/O behind bridge: 00009000-00009fff
        Memory behind bridge: fc700000-fc8fffff
        Prefetchable memory behind bridge: db100000-db1fffff
        BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [c0] #08 [0086]
        Capabilities: [f0] #08 [8000]

00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-8111 LPC (rev 05)
        Subsystem: Advanced Micro Devices [AMD] AMD-8111 LPC
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-8111 IDE (rev 03) (prog-if 8a [Master SecP PriP])
        Subsystem: Advanced Micro Devices [AMD] AMD-8111 IDE
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at ffa0 [size=16]

00:07.2 SMBus: Advanced Micro Devices [AMD] AMD-8111 SMBus 2.0 (rev 02)
        Subsystem: Advanced Micro Devices [AMD] AMD-8111 SMBus 2.0
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin D routed to IRQ 19
        Region 0: I/O ports at b480 [size=32]

00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-8111 ACPI (rev 05)
        Subsystem: Advanced Micro Devices [AMD] AMD-8111 ACPI
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:07.5 Multimedia audio controller: Advanced Micro Devices [AMD] AMD-8111 AC97 Audio (rev 03)
        Subsystem: Tyan Computer: Unknown device 2885
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin B routed to IRQ 17
        Region 0: I/O ports at b800 [size=256]
        Region 1: I/O ports at bc00 [size=64]

00:0a.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
        I/O behind bridge: 00008000-00008fff
        Memory behind bridge: fb600000-fc6fffff
        Prefetchable memory behind bridge: 00000000db000000-00000000db000000
        BridgeCtl: Parity+ SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [a0]      Capabilities: [b8] #08 [8000]
        Capabilities: [c0] #08 [004a]

00:0a.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev 01) (prog-if 10 [IO-APIC])
        Subsystem: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 0: Memory at fc9fe000 (64-bit, non-prefetchable) [size=4K]

00:0b.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12) (prog-if 00 [Normal decode])
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fb500000-fb5fffff
        Prefetchable memory behind bridge: 00000000daf00000-00000000daf00000
        BridgeCtl: Parity+ SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [a0]      Capabilities: [b8] #08 [8000]

00:0b.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev 01) (prog-if 10 [IO-APIC])
        Subsystem: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 0: Memory at fc9ff000 (64-bit, non-prefetchable) [size=4K]

00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Capabilities: [80] #08 [2101]
        Capabilities: [a0] #08 [2101]
        Capabilities: [c0] #08 [2101]

00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:19.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Capabilities: [80] #08 [2101]
        Capabilities: [a0] #08 [2101]
        Capabilities: [c0] #08 [2101]

00:19.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:19.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:19.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

02:07.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1010 66MHz  Ultra3 SCSI Adapter (rev 01)
        Subsystem: Intel Corp.: Unknown device 7830
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (4250ns min, 4500ns max), cache line size 10
        Interrupt: pin A routed to IRQ 26
        Region 0: I/O ports at 8800 [size=256]
        Region 1: Memory at fc6df800 (64-bit, non-prefetchable) [size=1K]
        Region 3: Memory at fc6dc000 (64-bit, non-prefetchable) [size=8K]
        Expansion ROM at fc6b0000 [disabled] [size=64K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:08.0 RAID bus controller: 3ware Inc 3ware 7000-series ATA-RAID (rev 01)
        Subsystem: 3ware Inc 3ware 7000-series ATA-RAID
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2250ns min), cache line size 10
        Interrupt: pin A routed to IRQ 27
        Region 0: I/O ports at 8c00 [size=16]
        Region 1: Memory at fc6dfc00 (32-bit, non-prefetchable) [size=16]
        Region 2: Memory at fb800000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at fc6c0000 [disabled] [size=64K]
        Capabilities: [40] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:09.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5703 Gigabit Ethernet (rev 02)
        Subsystem: Tyan Computer: Unknown device 2885
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (16000ns min), cache line size 10
        Interrupt: pin A routed to IRQ 24
        Region 0: Memory at fc6f0000 (64-bit, non-prefetchable) [size=64K]
        Expansion ROM at fc6e0000 [disabled] [size=64K]
        Capabilities: [40] PCI-X non-bridge device.
                Command: DPERE- ERO- RBC=0 OST=0
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-      Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
                Address: 0000400844824000  Data: 0420

03:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB (rev 0b) (prog-if 10 [OHCI])
        Subsystem: Advanced Micro Devices [AMD] AMD-8111 USB
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (20000ns max)
        Interrupt: pin D routed to IRQ 19
        Region 0: Memory at fc8f7000 (32-bit, non-prefetchable) [size=4K]

03:00.1 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB (rev 0b) (prog-if 10 [OHCI])
        Subsystem: Advanced Micro Devices [AMD] AMD-8111 USB
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (20000ns max)
        Interrupt: pin D routed to IRQ 19
        Region 0: Memory at fc8fc000 (32-bit, non-prefetchable) [size=4K]

03:0a.0 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
        Subsystem: Unknown device 2027:0035
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (250ns min, 10500ns max), cache line size 10
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at fc8fd000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

03:0a.1 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
        Subsystem: Unknown device 2027:0035
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (250ns min, 10500ns max), cache line size 10
        Interrupt: pin B routed to IRQ 17
        Region 0: Memory at fc8fe000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

03:0a.2 USB Controller: NEC Corporation USB 2.0 (rev 02) (prog-if 20 [EHCI])
        Subsystem: Unknown device 2027:0032
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (4000ns min, 8500ns max), cache line size 10
        Interrupt: pin C routed to IRQ 18
        Region 0: Memory at fc8ff800 (32-bit, non-prefetchable) [size=256]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

03:0b.0 RAID bus controller: CMD Technology Inc: Unknown device 3114 (rev 02)
        Subsystem: CMD Technology Inc: Unknown device 3114
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 10
        Interrupt: pin A routed to IRQ 17
        Region 0: I/O ports at 9c00 [size=8]
        Region 1: I/O ports at 9880 [size=4]
        Region 2: I/O ports at 9800 [size=8]
        Region 3: I/O ports at 9480 [size=4]
        Region 4: I/O ports at 9400 [size=16]
        Region 5: Memory at fc8ffc00 (32-bit, non-prefetchable) [size=1K]
        Expansion ROM at fc800000 [disabled] [size=512K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

03:0c.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10 [OHCI])
        Subsystem: Tyan Computer: Unknown device 2885
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 1000ns max), cache line size 10
        Interrupt: pin A routed to IRQ 19
        Region 0: Memory at fc8ff000 (32-bit, non-prefetchable) [size=2K]
        Region 1: Memory at fc8f8000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME+

04:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-8151 System Controller (rev 13)
        Subsystem: Advanced Micro Devices [AMD] AMD-8151 System Controller
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [a0] AGP version 3.0
                Status: RQ=32 Iso- ArqSz=0 Cal=2 SBA+ ITACoh+ GART64- HTrans+ 64bit+ FW+ AGP3+ Rate=x4,x8
                Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP- GART64- 64bit- FW- Rate=<none>
        Capabilities: [c0] #08 [0060]

04:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8151 AGP Bridge (rev 13) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=04, secondary=05, subordinate=05, sec-latency=64
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fca00000-feafffff
        Prefetchable memory behind bridge: db300000-eb3fffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

05:00.0 VGA compatible controller: nVidia Corporation NV34 [GeForce FX 5200] (rev a1) (prog-if 00 [VGA])
        Subsystem: LeadTek Research Inc.: Unknown device 2960
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at feae0000 [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 3.0
                Status: RQ=32 Iso- ArqSz=0 Cal=3 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>

chimera:~ # cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: DDYS-T36950N     Rev: S96H
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 10 Lun: 00
  Vendor: IBM      Model: IC35L018UWD210-0 Rev: S5BS
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: 3ware    Model: Logical Disk 0   Rev: 1.2
  Type:   Direct-Access                    ANSI SCSI revision: ffffffff
Host: scsi6 Channel: 00 Id: 00 Lun: 00
  Vendor: JLMS     Model: XJ-HD166S        Rev: DS18
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi7 Channel: 00 Id: 00 Lun: 00
  Vendor: LITE-ON  Model: DVDRW LDW-851S   Rev: GS08
  Type:   CD-ROM                           ANSI SCSI revision: 02
chimera:~ #


--Boundary-00=_nDPwA+zAOyeYz7I--

