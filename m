Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129096AbQKDOjz>; Sat, 4 Nov 2000 09:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129091AbQKDOjo>; Sat, 4 Nov 2000 09:39:44 -0500
Received: from front7m.grolier.fr ([195.36.216.57]:12003 "EHLO
	front7m.grolier.fr") by vger.kernel.org with ESMTP
	id <S129097AbQKDOjf>; Sat, 4 Nov 2000 09:39:35 -0500
From: Christian Casteyde <casteyde.christian@free.fr>
Date: Sat, 4 Nov 2000 15:40:34 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Subject: swapoff crashes swapped applications (2.4.0-test10)
MIME-Version: 1.0
Message-Id: <00110415403400.00419@neptune>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bug description

1. swapoff is broken with 2.4.0-test10 (swapped programs crash)

2. Boot with mem=64M boot parameter (or take a computer with only 64 meg of 
RAM). Use a 64M swap partition. Launch several programs (for instance, start 
StarOffice on KDE 2.0 + an xterm). su root on the xterm and use swapoff to 
remove the swap. All (de)swapped applications crash.

Note : 64M is enough to start KDE 2.0 + StarOffice without swap. If you remove
the swap first, nothing crash: you must fill it before swapping everything 
off.

3. Keywords : kernel, swap, VMM

4. Linux version 2.4.0-test10 (root@neptune) (gcc version 2.95.2 19991024 
(release)) #1 Fri Nov 3 23:23:16 CET 2000

5.

6. 

7. SuSE Linux 6.4

7.1. Ver_linux output :
Linux neptune 2.4.0-test10 #1 Fri Nov 3 23:23:16 CET 2000 i686 unknown
Kernel modules         2.3.15
Gnu C                  2.95.2
Gnu Make               3.78.1
Binutils               2.10.0.24
Linux C Library        2.1.3
Dynamic linker         ldd (GNU libc) 2.1.3
Procps                 2.0.6
Mount                  2.10o
Net-tools              1.54
Kbd                    0.99
Sh-utils               2.0
Modules Loaded

7.2.
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 6
model name      : Celeron (Mendocino)
stepping        : 5
cpu MHz         : 501.000145
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov 
pat pse36 mmx fxsr
bogomips        : 999.42

7.3.

7.4.
/proc/ioports:

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
0213-0213 : isapnp read
0220-022f : soundblaster
02f8-02ff : serial(auto)
0330-0333 : MPU-401 UART
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0620-0623 : sound driver (AWE32)
0778-077a : parport0
0a20-0a23 : sound driver (AWE32)
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
0e20-0e23 : sound driver (AWE32)
4000-403f : Intel Corporation 82371AB PIIX4 ACPI
5000-501f : Intel Corporation 82371AB PIIX4 ACPI
d000-d01f : Intel Corporation 82371AB PIIX4 USB
d400-d407 : Triones Technologies, Inc. HPT366
  d400-d407 : ide2
d800-d803 : Triones Technologies, Inc. HPT366
  d802-d802 : ide2
dc00-dcff : Triones Technologies, Inc. HPT366
  dc00-dc07 : ide2
  dc10-dcff : HPT366
e000-e007 : Triones Technologies, Inc. HPT366 (#2)
e400-e403 : Triones Technologies, Inc. HPT366 (#2)
e800-e8ff : Triones Technologies, Inc. HPT366 (#2)
  e800-e807 : ide3
  e810-e8ff : HPT366
f000-f00f : Intel Corporation 82371AB PIIX4 IDE
  f000-f007 : ide0
  f008-f00f : ide1


/proc/iomem:

00000000-0009efff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c91ff : Extension ROM
000f0000-000fffff : System ROM
00100000-0bffffff : System RAM
  00100000-0028fa7f : Kernel code
  0028fa80-002ae103 : Kernel data
e0000000-e3ffffff : Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
e4000000-e5ffffff : PCI Bus #01
  e5000000-e507ffff : Intel Corporation i740
e6000000-e6ffffff : PCI Bus #01
  e6000000-e6ffffff : Intel Corporation i740
e8000000-e8000fff : Zoran Corporation ZR36057PQC Video cutting chipset

7.5
lspci -vvv :
00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev 
03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32 set
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 
03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 set
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: e4000000-e5ffffff
        Prefetchable memory behind bridge: e6000000-e6ffffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 set

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) (prog-if 
80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 set
        Region 4: I/O ports at f000 [size=16]

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) (prog-if 
00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 set
        Interrupt: pin D routed to IRQ 10
        Region 4: I/O ports at d000 [size=32]

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

00:09.0 Multimedia video controller: Zoran Corporation ZR36057PQC Video 
cutting chipset (rev 01)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 2 min, 16 max, 32 set
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at e8000000 (32-bit, non-prefetchable) [size=4K]

00:13.0 Unknown mass storage controller: Triones Technologies, Inc. HPT366 
(rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 8 min, 8 max, 120 set, cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at d400 [size=8]
        Region 1: I/O ports at d800 [size=4]
        Region 4: I/O ports at dc00 [size=256]
        Expansion ROM at e7000000 [disabled] [size=128K]

00:13.1 Unknown mass storage controller: Triones Technologies, Inc. HPT366 
(rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 8 min, 8 max, 120 set, cache line size 08
        Interrupt: pin B routed to IRQ 11
        Region 0: I/O ports at e000 [size=8]
        Region 1: I/O ports at e400 [size=4]
        Region 4: I/O ports at e800 [size=256]
 
01:00.0 VGA compatible controller: Intel Corporation i740 (rev 21) (prog-if 
00 [VGA])
        Subsystem: Intel Corporation: Unknown device 0000
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 set
        Interrupt: pin A routed to IRQ 0
        Region 0: Memory at e6000000 (32-bit, prefetchable) [size=16M]
        Region 1: Memory at e5000000 (32-bit, non-prefetchable) [size=512K]
        Expansion ROM at <unassigned> [disabled] [size=256K]
        Capabilities: [d0] AGP version 1.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- AuxPwr- DSI+ D1+ D2- PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
                                                       

7.6
/proc/scsi/scsi (idescsi) :

Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: PIONEER  Model: CD-ROM DR-A01S   Rev: 1.02
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: HP       Model: CD-Writer+ 7100  Rev: 3.01
  Type:   CD-ROM                           ANSI SCSI revision: 02

7.7 Other info
/proc/dma :
 1: SoundBlaster8
 4: cascade
 5: SoundBlaster16

/proc/isapnp :
Card 1 'CTL00e4:Creative SB AWE64  PnP' PnP version 1.0 Product version 1.0
  Logical device 0 'CTL0045:Audio'
    Device is active
    Active port 0x220,0x330,0x388
    Active IRQ 5 [0x2]
    Active DMA 1,5
    Resources 0
      Priority preferred
      Port 0x220-0x220, align 0x0, size 0x10, 16-bit address decoding
      Port 0x330-0x330, align 0x0, size 0x2, 16-bit address decoding
      Port 0x388-0x3f8, align 0x0, size 0x4, 16-bit address decoding
      IRQ 5 High-Edge
      DMA 1 8-bit byte-count compatible
      DMA 5 16-bit word-count compatible
      Alternate resources 0:1
        Priority acceptable
        Port 0x220-0x280, align 0x1f, size 0x10, 16-bit address decoding
        Port 0x300-0x330, align 0x2f, size 0x2, 16-bit address decoding
        Port 0x388-0x3f8, align 0x0, size 0x4, 16-bit address decoding
        IRQ 5,7,2/9,10 High-Edge
        DMA 0,1,3 8-bit byte-count compatible
        DMA 5,6,7 16-bit word-count compatible
      Alternate resources 0:2
        Priority acceptable
        Port 0x220-0x280, align 0x1f, size 0x10, 16-bit address decoding
        Port 0x300-0x330, align 0x2f, size 0x2, 16-bit address decoding
        IRQ 5,7,2/9,10 High-Edge
        DMA 0,1,3 8-bit byte-count compatible
        DMA 5,6,7 16-bit word-count compatible
      Alternate resources 0:3
        Priority acceptable
        Port 0x220-0x280, align 0x1f, size 0x10, 16-bit address decoding
        IRQ 5,7,2/9,10 High-Edge
        DMA 0,1,3 8-bit byte-count compatible
        DMA 5,6,7 16-bit word-count compatible
      Alternate resources 0:4
        Priority acceptable
        Port 0x220-0x280, align 0x1f, size 0x10, 16-bit address decoding
        Port 0x300-0x330, align 0x2f, size 0x2, 16-bit address decoding
        Port 0x388-0x3f8, align 0x0, size 0x4, 16-bit address decoding
        IRQ 5,7,2/9,10 High-Edge
        DMA 0,1,3 8-bit byte-count compatible
      Alternate resources 0:5
        Priority acceptable
        Port 0x220-0x280, align 0x1f, size 0x10, 16-bit address decoding
        Port 0x300-0x330, align 0x2f, size 0x2, 16-bit address decoding
        IRQ 5,7,2/9,10 High-Edge
        DMA 0,1,3 8-bit byte-count compatible
      Alternate resources 0:6
        Priority acceptable
        Port 0x220-0x280, align 0x1f, size 0x10, 16-bit address decoding
        IRQ 5,7,2/9,10 High-Edge
        DMA 0,1,3 8-bit byte-count compatible
      Alternate resources 0:7
        Priority functional
        Port 0x220-0x280, align 0x1f, size 0x10, 16-bit address decoding
        Port 0x300-0x330, align 0xf, size 0x2, 16-bit address decoding
        Port 0x388-0x394, align 0x3, size 0x4, 16-bit address decoding
        IRQ 5,7,2/9,10 High-Edge
        DMA 0,1,3 8-bit byte-count compatible
        DMA 5,6,7 16-bit word-count compatible
  Logical device 1 'CTL7002:Game'
    Compatible device PNPb02f
    Device is not active
    Resources 0
      Priority preferred
      Port 0x200-0x200, align 0x0, size 0x8, 16-bit address decoding
      Alternate resources 0:1
        Priority acceptable
        Port 0x200-0x208, align 0x7, size 0x8, 16-bit address decoding
  Logical device 2 'CTL0022:WaveTable'
    Device is active
    Active port 0x620,0xa20,0xe20
    Resources 0
      Priority preferred
      Port 0x620-0x620, align 0x0, size 0x4, 16-bit address decoding
      Port 0xa20-0xa20, align 0x0, size 0x4, 16-bit address decoding
      Port 0xe20-0xe20, align 0x0, size 0x4, 16-bit address decoding
      Alternate resources 0:1
        Priority acceptable
        Port 0x620-0x680, align 0x1f, size 0x4, 16-bit address decoding
        Port 0xa20-0xa80, align 0x1f, size 0x4, 16-bit address decoding
        Port 0xe20-0xe80, align 0x1f, size 0x4, 16-bit address decoding

/proc/mtrr :
reg00: base=0x00000000 (   0MB), size= 128MB: write-back, count=1
reg01: base=0x08000000 ( 128MB), size=  64MB: write-back, count=1

Hardware configuration :
Celeron 500A + 192Mo 100Mhz on BX chipset + HPT366 onborad chipset.
OS on /dev/hda3 (IBM disk on the BX IDE port). Memory stress conditions 
explicitly required with mem=64M on boot param.
Graphics Chaintech i740 Tornado.
dmesg tells some strange informations (never seen berfore 2.4.0-test10) :

...
mtrr: v1.36 (20000221) Richard Gooch (rgooch@atnf.csiro.au)
PCI: PCI BIOS revision 2.10 entry at 0xfb440, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router PIIX [8086/7000] at 00:07.0
PCI: Found IRQ 10 for device 00:07.2
PCI: The same IRQ used for device 00:09.0
Limiting direct PCI/PCI transfers.
isapnp: Scanning for Pnp cards...
isapnp: Calling quirk for 01:00
ISAPnP: SB audio device quirk - increasing port range
isapnp: Calling quirk for 01:02
isapnp: AWE32 quirk - adding two ports
isapnp: Card 'Creative SB AWE64  PnP'
isapnp: 1 Plug & Play card detected total
Linux NET4.0 for Linux 2.4
...
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
