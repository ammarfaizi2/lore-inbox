Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267252AbTBIN1C>; Sun, 9 Feb 2003 08:27:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267253AbTBIN1C>; Sun, 9 Feb 2003 08:27:02 -0500
Received: from CPE-203-45-94-165.nsw.bigpond.net.au ([203.45.94.165]:41090
	"EHLO office-gw.conexim.com.au") by vger.kernel.org with ESMTP
	id <S267252AbTBIN07>; Sun, 9 Feb 2003 08:26:59 -0500
Message-Id: <5.2.0.9.0.20030210002623.03c68ba0@144.135.24.13>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Mon, 10 Feb 2003 00:33:55 +1100
To: linux-kernel@vger.kernel.org
From: Lucian Daniel Kafka <luci@conexim.com.au>
Subject: Kernel assertion failures
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

One of our servers started getting repeated errors like the one below:

Feb  7 02:39:03 xxx kernel: KERNEL: assertion (newsk->state != 
TCP_SYN_RECV) failed at tcp.c(2229)
Feb  7 02:39:03 xxx kernel: KERNEL: assertion 
((1<<sk2->state)&(TCPF_ESTABLISHED|TCPF_CLOSE_WAIT|TCPF_CLOSE)) failed at 
af_inet.c(689)


Any ideas why? Please cc response to my address.

Sys info below.


Kind regards,

Lucian Kafka
www.conexim.com.au


Linux version 2.4.20 (root@xxx) (gcc version 2.96 20000731 (Red Hat Linux 
7.1 2.96-85)) #1 Tue Dec 3 13:03:44 EST 2002
i686 unknown

Gnu C                  2.96
Gnu make               3.79.1
binutils               2.10.91.0.2
util-linux             2.11f
mount                  2.11b
modutils               2.4.18
e2fsprogs              1.26
isdn4k-utils           3.1pre1
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.57
Console-tools          0.3.3
Sh-utils               2.0

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
4000-403f : Intel Corp. 82371AB/EB/MB PIIX4 ACPI
5000-501f : Intel Corp. 82371AB/EB/MB PIIX4 ACPI
d000-dfff : PCI Bus #01
e000-e01f : Intel Corp. 82371AB/EB/MB PIIX4 USB
e400-e43f : Intel Corp. 82557/8/9 [Ethernet Pro 100]
   e400-e43f : eepro100
f000-f00f : Intel Corp. 82371AB/EB/MB PIIX4 IDE
   f000-f007 : ide0
   f008-f00f : ide1

00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c8fff : Extension ROM
000f0000-000fffff : System ROM
00100000-17feffff : System RAM
   00100000-001dd191 : Kernel code
   001dd192-0021685f : Kernel data
17ff0000-17ff2fff : ACPI Non-volatile Storage
17ff3000-17ffffff : ACPI Tables
d8000000-dbffffff : Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge
dc000000-dfffffff : PCI Bus #01
   dd000000-dd7fffff : Texas Instruments TVP4010 [Permedia]
   dd800000-ddffffff : Texas Instruments TVP4010 [Permedia]
   de000000-de01ffff : Texas Instruments TVP4010 [Permedia]
e1000000-e10fffff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
e1100000-e1100fff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
   e1100000-e1100fff : eepro100
ffff0000-ffffffff : reserved

lspci -vvv
00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge 
(rev 02)
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
         Latency: 64
         Region 0: Memory at d8000000 (32-bit, prefetchable) [size=64M]
         Capabilities: [a0] AGP version 1.0
                 Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                 Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 
02) (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 64
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
         I/O behind bridge: 0000d000-0000dfff
         Memory behind bridge: dc000000-dfffffff
         Prefetchable memory behind bridge: fff00000-000fffff
         BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) 
(prog-if 80 [Master])
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 64
         Region 4: I/O ports at f000 [size=16]

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) 
(prog-if 00 [UHCI])
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 64
         Interrupt: pin D routed to IRQ 10
         Region 4: I/O ports at e000 [size=32]

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
         Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin ? routed to IRQ 9

00:0b.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] 
(rev 08)
         Subsystem: Intel Corporation EtherExpress PRO/100+ Management Adapter
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (2000ns min, 14000ns max), cache line size 08
         Interrupt: pin A routed to IRQ 10
         Region 0: Memory at e1100000 (32-bit, non-prefetchable) [size=4K]
         Region 1: I/O ports at e400 [size=64]
         Region 2: Memory at e1000000 (32-bit, non-prefetchable) [size=1M]
         Expansion ROM at e0000000 [disabled] [size=1M]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=2 PME-

01:00.0 VGA compatible controller: Texas Instruments TVP4010 [Permedia] 
(rev 01) (prog-if 00 [VGA])
         Subsystem: 3DLabs: Unknown device 0096
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 64
         Interrupt: pin A routed to IRQ 11
         Region 0: Memory at de000000 (32-bit, non-prefetchable) [size=128K]
         Region 1: Memory at dd800000 (32-bit, non-prefetchable) [size=8M]
         Region 2: Memory at dd000000 (32-bit, non-prefetchable) [size=8M]
         Expansion ROM at <unassigned> [disabled] [size=64K]


