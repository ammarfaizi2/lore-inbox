Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129511AbRALJoL>; Fri, 12 Jan 2001 04:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130282AbRALJoC>; Fri, 12 Jan 2001 04:44:02 -0500
Received: from gw-nl4.philips.com ([212.153.190.6]:46602 "EHLO
	gw-nl4.philips.com") by vger.kernel.org with ESMTP
	id <S129511AbRALJnx>; Fri, 12 Jan 2001 04:43:53 -0500
Message-Id: <010601c07c7c$271413b0$18949182@ddns.htc.nl.philips.com>
From: "Gerard Postuma" <postuma@bigfoot.com>
To: <linux-kernel@vger.kernel.org>
Subject: PCI: No IRQ known for interrupt pin A of device 00:0f.1
Date: Fri, 12 Jan 2001 10:43:43 +0100
Organization: None
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-Msmail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-Mimeole: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Recently I installed kernel 2.4.0 (nice job!) on a Compaq Deskpro 4000 with
a Pentium 133 Mhz processor. It seems to run fine, but during boot
I get the following message:

PCI: No IRQ known for interrupt pin A of device 00:0f.1. Please try using
pci=biosirq.

If I try that it still gives the error, except for the "Please try using
pci=biosirq" part.

What can cause this, and is there a solution for it?

Thanks in advance,

Gerard


Some system logs:

delphi:~ # uname -a
Linux delphi 2.4.0 #4 Wed Jan 10 21:45:01 CET 2001 i586 unknown

Part of dmesg:
Linux version 2.4.0 (root@delphi) (gcc version egcs-2.91.66 19990314/Linux
(egcs-1.1.2 release)) #4 Wed Jan 10 21:45:01 CET 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)
 BIOS-e820: 0000000000020000 @ 00000000000e0000 (reserved)
 BIOS-e820: 0000000005f00000 @ 0000000000100000 (usable)
 BIOS-e820: 0000000000020000 @ 00000000fffe0000 (reserved)
 BIOS-e820: 0000000000000000 @ 0000000000000000 type 0
On node 0 totalpages: 24576
zone(0): 4096 pages.
zone(1): 20480 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=linux ro root=303
Initializing CPU#0
Detected 133.642 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 266.24 BogoMIPS
Memory: 94940k/98304k available (735k kernel code, 2976k reserved, 230k
data, 172k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
VFS: Diskquotas version dquot_6.4.0 initialized
CPU: Before vendor init, caps: 000001bf 00000000 00000000, vendor = 0
Intel Pentium with F0 0F bug - workaround enabled.
CPU: After vendor init, caps: 000001bf 00000000 00000000 00000000
CPU: After generic, caps: 000001bf 00000000 00000000 00000000
CPU: Common caps: 000001bf 00000000 00000000 00000000
CPU: Intel Pentium 75 - 200 stepping 0c
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xf42b2, last bus=0
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: device 00:00.0 has unknown header type 7f, ignoring.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.1 Flags 0x02 (Driver version 1.14)
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PCI_IDE: unknown IDE controller on PCI bus 00 device 79, VID=0e11, DID=ae33
PCI: No IRQ known for interrupt pin A of device 00:0f.1. Please try using
pci=biosirq.
PCI_IDE: chipset revision 10
PCI_IDE: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1010-0x1017, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1018-0x101f, BIOS settings: hdc:pio, hdd:pio
hda: ST36530A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 12715920 sectors (6511 MB) w/448KiB Cache, CHS=841/240/63
Partition check:
 hda: [PTBL] [791/255/63] hda1 hda2 hda3

delphi:~ # lspci -vvx
00:08.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone]
(rev 30)
        Subsystem: Unknown device 10b7:9055
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 10 min, 10 max, 64 set, cache line size 08
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at 1080
        Region 1: Memory at 40080000 (32-bit, non-prefetchable)
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- AuxPwr- DSI- D1+ D2+ PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: b7 10 55 90 07 00 10 02 30 00 00 02 08 40 00 00
10: 81 10 00 00 00 00 08 40 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 b7 10 55 90
30: 00 00 00 00 dc 00 00 00 00 00 00 00 09 01 0a 0a

00:0a.0 VGA compatible controller: Cirrus Logic GD 5446
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at 41000000 (32-bit, prefetchable)
00: 13 10 b8 00 03 00 00 02 00 00 00 03 00 00 00 00
10: 08 00 00 41 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 00 00

00:0b.0 Network controller: Compaq Computer Corporation Integrated
NetFlex-3/P (rev 10)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF+ FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 set, cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at 1000
        Region 1: Memory at 40000000 (32-bit, non-prefetchable)
00: 11 0e 35 ae 07 00 c0 02 10 00 80 02 08 42 00 00
10: 01 10 00 00 00 00 00 40 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 90 00 00 00 00 00 00 00 0a 01 00 00

00:0f.0 ISA bridge: Compaq Computer Corporation: Unknown device a0f3 (rev
0a)
        Subsystem: Unknown device 0e11:a0f3
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 set
00: 11 0e f3 a0 47 01 00 02 0a 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e f3 a0
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0f.1 IDE interface: Compaq Computer Corporation: Unknown device ae33 (rev
0a) (prog-if fa)
        Subsystem: Unknown device 0e11:ae33
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 set
        Interrupt: pin A routed to IRQ 0
        Region 0: I/O ports at 01f0
        Region 1: I/O ports at 03f4
        Region 2: I/O ports at 0170
        Region 3: I/O ports at 0374
        Region 4: I/O ports at 1010
00: 11 0e 33 ae 05 00 00 02 0a fa 01 01 00 00 80 00
10: f1 01 00 00 f5 03 00 00 71 01 00 00 75 03 00 00
20: 11 10 00 00 00 00 00 00 00 00 00 00 11 0e 33 ae
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
