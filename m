Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267287AbUBSOzE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 09:55:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267285AbUBSOzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 09:55:04 -0500
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:21146 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S267298AbUBSOxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 09:53:38 -0500
Message-ID: <4034CDF1.4090405@yahoo.de>
Date: Thu, 19 Feb 2004 15:53:37 +0100
From: Art Tevs <arti_tevs@yahoo.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: 
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. Initialisation of hda failes.
2. The compiled 2.6.3 (or 2.6.3-rc3 too) cannnot initialize hda.
Report from hdaprm of my drive:
  Model=FUJITSU MHS2020AT, FwRev=8004, SerialNo=NL42T3113SKH
  Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
  BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
  CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=39070080
  IORDY=yes, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
  PIO modes:  pio0 pio1 pio2 pio3 pio4
  DMA modes:  mdma0 mdma1 mdma2
  UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5
  AdvancedPM=yes: mode=0x80 (128) WriteCache=enabled
  Drive conforms to: ATA/ATAPI-6 T13 1410D revision 3a:

The initialization failes on
hda: max request size:128KiB

after this the kernel hangs.

Report of ver_linux (on other kernel):
Linux mobile.mynetwork.de 2.6.3-rc2-mm1 #1 Fri Feb 13 19:25:44 CET 2004 
i686 GNU/Linux

Gnu C                  3.3.3
Gnu make               3.80
util-linux             2.12
mount                  2.12
module-init-tools      3.0-pre9
e2fsprogs              1.35-WIP
pcmcia-cs              3.2.6
PPP                    2.4.2
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.15
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0.91
Modules Loaded         tun snd_via82xx snd_pcm snd_timer snd_ac97_codec 
snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd atmel_cs 
atmel ip_nat_ftp ip_conntrack_ftp ip_nat_irc ip_conntrack_irc ipt_REJECT 
ipt_LOG ipt_limit ipt_MASQUERADE iptable_nat ipt_state iptable_filter 
ip_conntrack via_rhine soundcore rtc

PCI-Information:
00:00.0 Host bridge: VIA Technologies, Inc. P/KN266 Host Bridge
         Subsystem: Mitac: Unknown device 8375
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
         Latency: 8
         Region 0: Memory at a0000000 (32-bit, prefetchable) [size=64M]
         Capabilities: [a0] AGP version 2.0
                 Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                 Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- 
FW- Rate=x4
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8633 [Apollo Pro266 AGP] 
(prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
         Latency: 0
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
         I/O behind bridge: 0000c000-0000dfff
         Memory behind bridge: e0000000-efffffff
         Prefetchable memory behind bridge: 90000000-9fffffff
         BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 CardBus bridge: ENE Technology Inc CB1410 Cardbus Controller
         Subsystem: Mitac: Unknown device 8375
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 168, Cache Line Size: 0x10 (64 bytes)
         Interrupt: pin A routed to IRQ 11
         Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
         Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
         Memory window 0: 10400000-107ff000 (prefetchable)
         Memory window 1: 10800000-10bff000
         I/O window 0: 00004000-000040ff
         I/O window 1: 00004400-000044ff
         BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt- 
PostWrite+
         16-bit legacy interface ports at 0001

00:0b.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host 
Controller (rev 80) (prog-if 10 [OHCI])
         Subsystem: Mitac: Unknown device 8375
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (8000ns max), Cache Line Size: 0x08 (32 bytes)
         Interrupt: pin A routed to IRQ 5
         Region 0: Memory at fedff800 (32-bit, non-prefetchable) [size=2K]
         Region 1: I/O ports at ff00 [size=128]
         Capabilities: [50] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 
[UHCI])
         Subsystem: Mitac: Unknown device 8375
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32, Cache Line Size: 0x08 (32 bytes)
         Interrupt: pin A routed to IRQ 10
         Region 4: I/O ports at 1200 [size=32]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 
[UHCI])
         Subsystem: Mitac: Unknown device 8375
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32, Cache Line Size: 0x08 (32 bytes)
         Interrupt: pin B routed to IRQ 11
         Region 4: I/O ports at 1300 [size=32]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82) (prog-if 
20 [EHCI])
         Subsystem: Mitac: Unknown device 8375
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32, Cache Line Size: 0x08 (32 bytes)
         Interrupt: pin D routed to IRQ 11
         Region 0: Memory at f0000000 (32-bit, non-prefetchable) [size=256]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
         Subsystem: Mitac: Unknown device 8375
         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06) 
(prog-if 8a [Master SecP PriP])
         Subsystem: Mitac: Unknown device 8375
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64
         Interrupt: pin A routed to IRQ 0
         Region 4: I/O ports at 1100 [size=16]
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.5 Multimedia audio controller: VIA Technologies, Inc. 
VT8233/A/8235 AC97 Audio Controller (rev 50)
         Subsystem: Mitac: Unknown device 8375
         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin C routed to IRQ 5
         Region 0: I/O ports at e100 [size=256]
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.6 Communication controller: VIA Technologies, Inc. Intel 537 [AC97 
Modem] (rev 80)
         Subsystem: Mitac: Unknown device 8375
         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin C routed to IRQ 5
         Region 0: I/O ports at e200 [size=256]
         Capabilities: [d0] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] 
(rev 74)
         Subsystem: Mitac: Unknown device 8375
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (750ns min, 2000ns max), Cache Line Size: 0x08 (32 
bytes)
         Interrupt: pin A routed to IRQ 10
         Region 0: I/O ports at e300 [size=256]
         Region 1: Memory at f0000100 (32-bit, non-prefetchable) [size=256]
         Capabilities: [40] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: S3 Inc. VT8375 [ProSavage8 
KM266/KL266] (prog-if 00 [VGA])
         Subsystem: Mitac: Unknown device 8375
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (1000ns min, 63750ns max), Cache Line Size: 0x08 
(32 bytes)
         Interrupt: pin A routed to IRQ 10
         Region 0: Memory at e0000000 (32-bit, non-prefetchable) [size=512K]
         Region 1: Memory at 90000000 (32-bit, prefetchable) [size=128M]
         Expansion ROM at 000c0000 [disabled] [size=64K]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [80] AGP version 2.0
                 Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64- 
HTrans- 64bit- FW- AGP3- Rate=x4
                 Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- 
FW- Rate=x4


