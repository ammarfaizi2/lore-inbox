Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130657AbQLRAZo>; Sun, 17 Dec 2000 19:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131812AbQLRAZZ>; Sun, 17 Dec 2000 19:25:25 -0500
Received: from ifaedi.insa-lyon.fr ([134.214.104.16]:1292 "EHLO
	ifaedi.insa-lyon.fr") by vger.kernel.org with ESMTP
	id <S130657AbQLRAZV>; Sun, 17 Dec 2000 19:25:21 -0500
Message-ID: <3A3D52C2.2260F6D2@insa-lyon.fr>
Date: Mon, 18 Dec 2000 00:56:50 +0100
From: Zanetti Arnaud <Arnaud.Zanetti@insa-lyon.fr>
Reply-To: Arnaud.Zanetti@insa-lyon.fr
Organization: INSA de Lyon
X-Mailer: Mozilla 4.75 [fr] (X11; U; Linux 2.4.0-test11-zatto i686)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM : Networking stops working with kernel 2.4.0-test11
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary
After an undetermined amount of download, eth0 just stop
receiving/transmitting bytes

Description:
After working perfectly for an undetermined time /  volume of download,
eth0 just stop working (i.e. : it won'n receive/transmit anymore bytes).
I just can see the 'drop' field in /proc/net/dev increasing, all other
fields just remaining the same.
I tried to bring eth0 down and up again and it doesn't work.
Ad it happens only during intensive download (>100Ko/s) I suspected a
security mecanism could have seen it as an attack, but I couldn't figure
out what mecanism it could have been. Comparing /proc/sys/net both in
working and stopped situation with a
more $(find net/ -type f) >~/sys.net.ok
and a
more $(find net/ -type f) >~/sys.net.stopped
I found strictly no differences (i.e. the 'diff' command found no
differences)

Keywords:
networking

Kernel version:
Linux version 2.4.0-test11-zatto (root@zatto.resI.insa-lyon.fr) (gcc
version egcs-2.91.66.1 19990314/Linux (egcs-1.1.2 release)) #3 SMP mer
déc 6 15:40:04 CET 2000


-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux zatto.resI.insa-lyon.fr 2.4.0-test11-zatto #3 SMP mer déc 6
15:40:04 CET 2000 i686 unknown
Kernel modules         2.3.18
Gnu C                  2.95.3
Gnu Make               3.79.1
Binutils               2.10.0.24
Linux C Library        2.1.3
Dynamic linker         ldd (GNU libc) 2.1.3
Procps                 2.0.7
Mount                  2.10o
Net-tools              1.57
Console-tools          0.2.3
Sh-utils               2.0
Modules Loaded         ne2k-pci 8390 nls_iso8859-1 nls_cp437 loop tuner
bttv videodev sr_mod cdrom


CPU:
processor : 0
vendor_id : GenuineIntel
cpu family : 6
model  : 6
model name : Celeron (Mendocino)
stepping : 5
cpu MHz  : 400.000918
cache size : 128 KB
fdiv_bug : no
hlt_bug  : no
f00f_bug : no
coma_bug : no
fpu  : yes
fpu_exception : yes
cpuid level : 2
wp  : yes
features : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 mmx fxsr
bogomips : 799.54

processor : 1
vendor_id : GenuineIntel
cpu family : 6
model  : 6
model name : Celeron (Mendocino)
stepping : 5
cpu MHz  : 400.000918
cache size : 128 KB
fdiv_bug : no
hlt_bug  : no
f00f_bug : no
coma_bug : no
fpu  : yes
fpu_exception : yes
cpuid level : 2
wp  : yes
features : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 mmx fxsr
bogomips : 801.18

Modules loaded:
ne2k-pci                4896   1
8390                    6784   0 [ne2k-pci]
nls_iso8859-1           2848   1 (autoclean)
nls_cp437               4368   1 (autoclean)
loop                    7744   0 (unused)
tuner                   3264   1 (autoclean)
bttv                   57584   0 (unused)
videodev                4832   2 [bttv]
sr_mod                 12160   2
cdrom                  27648   0 [sr_mod]

/proc/ioports
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
02f8-02ff : serial(auto)
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
4000-403f : Intel Corporation 82371AB PIIX4 ACPI
  4000-4003 : acpi
  4004-4005 : acpi
  4008-400b : acpi
  400c-400f : acpi
5000-501f : Intel Corporation 82371AB PIIX4 ACPI
c000-c01f : Intel Corporation 82371AB PIIX4 USB
c400-c43f : Ensoniq 5880 AudioPCI
  c400-c43f : es1371
c800-c81f : Realtek Semiconductor Co., Ltd. RTL-8029(AS)
  c800-c81f : ne2k-pci
cc00-ccff : 3Dfx Interactive, Inc. Voodoo 3
d000-d007 : Triones Technologies, Inc. HPT366
d400-d403 : Triones Technologies, Inc. HPT366
d800-d8ff : Triones Technologies, Inc. HPT366
  d800-d807 : ide2
  d810-d8ff : HPT366
dc00-dc07 : Triones Technologies, Inc. HPT366 (#2)
e000-e003 : Triones Technologies, Inc. HPT366 (#2)
e400-e4ff : Triones Technologies, Inc. HPT366 (#2)
  e400-e407 : ide3
  e410-e4ff : HPT366
f000-f00f : Intel Corporation 82371AB PIIX4 IDE
  f000-f007 : ide0
  f008-f00f : ide1

/proc/iomem

00000000-0009efff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-13ffffff : System RAM
  00100000-0025ad97 : Kernel code
  0025ad98-00270f9f : Kernel data
d0000000-d3ffffff : Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
d4000000-d5ffffff : 3Dfx Interactive, Inc. Voodoo 3
d6000000-d7ffffff : 3Dfx Interactive, Inc. Voodoo 3
d9000000-d9000fff : Brooktree Corporation Bt848 TV with DMA push
  d9000000-d9000fff : bttv

lspci -vvv

00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
(rev 03)
 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
 Latency: 32
 Region 0: Memory at d0000000 (32-bit, prefetchable) [size=64M]
 Capabilities: <available only to root>

00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge
(rev 03) (prog-if 00 [Normal decode])
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
 Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
 Latency: 64
 Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
 I/O behind bridge: 0000f000-00000fff
 Memory behind bridge: fff00000-000fffff
 Prefetchable memory behind bridge: fff00000-000fffff
 BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
 Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
 Latency: 0

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
(prog-if 80 [Master])
 Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
 Latency: 32
 Region 4: I/O ports at f000 [size=16]

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
(prog-if 00 [UHCI])
 Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
 Latency: 32
 Interrupt: pin D routed to IRQ 19
 Region 4: I/O ports at c000 [size=32]

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
 Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:09.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
 Subsystem: Ensoniq Creative Sound Blaster AudioPCI128
 Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
 Latency: 32 (3000ns min, 32000ns max)
 Interrupt: pin A routed to IRQ 19
 Region 0: I/O ports at c400 [size=64]
 Capabilities: <available only to root>

00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8029(AS)
 Subsystem: Realtek Semiconductor Co., Ltd. RT8029(AS)
 Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
 Interrupt: pin A routed to IRQ 18
 Region 0: I/O ports at c800 [size=32]

00:0f.0 Multimedia video controller: Brooktree Corporation Bt848 TV with
DMA push (rev 12)
 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
 Latency: 32 (4000ns min, 10000ns max)
 Interrupt: pin A routed to IRQ 16
 Region 0: Memory at d9000000 (32-bit, prefetchable) [size=4K]

00:11.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 3 (rev
01) (prog-if 00 [VGA])
 Subsystem: 3Dfx Interactive, Inc. Voodoo3
 Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR+
 Interrupt: pin A routed to IRQ 19
 Region 0: Memory at d4000000 (32-bit, non-prefetchable) [size=32M]
 Region 1: Memory at d6000000 (32-bit, prefetchable) [size=32M]
 Region 2: I/O ports at cc00 [size=256]
 Expansion ROM at <unassigned> [disabled] [size=64K]
 Capabilities: <available only to root>

00:13.0 Unknown mass storage controller: Triones Technologies, Inc.
HPT366 (rev 01)
 Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
 Latency: 120 (2000ns min, 2000ns max), cache line size 08
 Interrupt: pin A routed to IRQ 18
 Region 0: I/O ports at d000 [size=8]
 Region 1: I/O ports at d400 [size=4]
 Region 4: I/O ports at d800 [size=256]
 Expansion ROM at <unassigned> [disabled] [size=128K]

00:13.1 Unknown mass storage controller: Triones Technologies, Inc.
HPT366 (rev 01)
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
 Latency: 120 (2000ns min, 2000ns max), cache line size 08
 Interrupt: pin B routed to IRQ 18
 Region 0: I/O ports at dc00 [size=8]
 Region 1: I/O ports at e000 [size=4]
 Region 4: I/O ports at e400 [size=256]

/proc/scsi/scsi

Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IDE-CD   Model: R/RW 4x4x24      Rev: 1.04
  Type:   CD-ROM                           ANSI SCSI revision: 02

/proc/interrupts

           CPU0       CPU1
  0:     122862     121853    IO-APIC-edge  timer
  1:       4209       3950    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  9:          0          0    IO-APIC-edge  acpi
 12:      31518      30952    IO-APIC-edge  PS/2 Mouse
 14:      10744      10757    IO-APIC-edge  ide0
 15:      48575      49118    IO-APIC-edge  ide1
 16:          4          1   IO-APIC-level  bttv
 18:      12283      11918   IO-APIC-level  eth0
 19:          0          0   IO-APIC-level  es1371
NMI:     244639     244639
LOC:     244049     243832
ERR:          0

Note : I have a problem with my NIC : it has its MAC address set to
00:00:00:00:00:00 by default and I have to force it to its real MAC
address specified in /etc/sysconfig/network-scripts/ifcfg-eth0.

I hope this report might be of any use for you (and for me ;-)
Thanx

-- Nono
e-mail : azanetti@ifaedi.insa-lyon.fr
ICQ    : 23137282
tel    : 06.84.05.03.51 (un petit message, ca fait tjs plaisir)


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
