Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264546AbTL0SrJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 13:47:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264547AbTL0SrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 13:47:09 -0500
Received: from h255-78-131.BO1.infinito.it ([213.255.78.131]:1408 "EHLO
	athlon.casamia") by vger.kernel.org with ESMTP id S264546AbTL0Sq0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 13:46:26 -0500
From: Stefano Rosellini <steros@infinito.it>
Reply-To: steros@infinito.it
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Kernel 2.6.0 has a compilation error on "fs/proc/array.c"
Date: Sat, 27 Dec 2003 19:46:38 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_QHHKGC8WOX3HU92BLAL2"
Message-Id: <20031227184639.84BD652B35@athlon.casamia>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_QHHKGC8WOX3HU92BLAL2
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit

[1.] Kernel 2.6.0 has a compilation error on "fs/proc/array.c"

[2.] When I compile kernel 2.6.0 with attached configuration, I get this 
error message:
<<
  CC      fs/proc/array.o
fs/proc/array.c: In function `proc_pid_stat':
fs/proc/array.c:398: Unrecognizable insn:
(insn/i 1334 1666 1660 (parallel[
            (set (reg:SI 0 eax)
                (asm_operands ("") ("=a") 0[
                        (reg:DI 1 edx)
                    ]
                    [
                        (asm_input:DI ("A"))
                    ]  ("include/linux/times.h") 38))
            (set (reg:SI 1 edx)
                (asm_operands ("") ("=d") 1[
                        (reg:DI 1 edx)
                    ]
                    [
                        (asm_input:DI ("A"))
                    ]  ("include/linux/times.h") 38))
            (clobber (reg:QI 19 dirflag))
            (clobber (reg:QI 18 fpsr))
            (clobber (reg:QI 17 flags))
        ] ) -1 (insn_list 1328 (nil))
    (nil))
fs/proc/array.c:398: confused by earlier errors, bailing out
make[2]: *** [fs/proc/array.o] Error 1
make[1]: *** [fs/proc] Error 2
make: *** [fs] Error 2
>>

[7.] ----- Environment -----

[7.1.] ver_linux output:
<<
Linux athlon 2.4.23 #9 mer dic 24 18:06:23 CET 2003 i686 unknown

Gnu C                  2.96
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
module-init-tools      2.4.13
e2fsprogs              1.26
reiserfsprogs          3.x.0j
quota-tools            3.01.
PPP                    2.4.1
nfs-utils              0.3.3
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Kbd                    [opzione...]
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         mga agpgart epat paride emu10k1 ac97_codec sound 
soundcore nfsd lockd sunrpc lp parport_pc parport af_packet keybdev mousedev 
hid input w83781d i2c-amd756 i2c-proc i2c-core scanner ipt_MASQUERADE 
ipt_REJECT ipt_state
iptable_filter iptable_nat ip_conntrack ip_tables usb-ohci usbcore ne2k-pci 
8390 crc32 3c509 ext2 nls_iso8859-15 nls_cp850 vfat fat ide-scsi scsi_mod rtc
>>

[7.2.] CPU info:
<<
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 1
model name      : AMD-K7(tm) Processor
stepping        : 2
cpu MHz         : 499.037
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov 
pat mmx syscall mmxext 3dnowext 3dnow
bogomips        : 996.14
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 1
model name      : AMD-K7(tm) Processor
stepping        : 2
cpu MHz         : 499.037
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov 
pat mmx syscall mmxext 3dnowext 3dnow
bogomips        : 996.14
>>

[7.3.] /proc/modules:
<<
mga                    92688   1
agpgart                13856   3
epat                    6656   0
paride                  3520   1 [epat]
emu10k1                54080   2
ac97_codec             11840   0 [emu10k1]
sound                  53836   0 [emu10k1]
soundcore               3588   7 [emu10k1 sound]
nfsd                   68576   8 (autoclean)
lockd                  48256   1 (autoclean) [nfsd]
sunrpc                 62804   1 (autoclean) [nfsd lockd]
lp                      6144   1
parport_pc             21256   1
parport                23040   1 [paride lp parport_pc]
af_packet              12008   1 (autoclean)
keybdev                 1696   0 (unused)
mousedev                3936   0 (unused)
hid                    20640   0 (unused)
input                   3360   0 [keybdev mousedev hid]
w83781d                18336   0 (unused)
i2c-amd756              3108   0 (unused)
i2c-proc                6272   0 [w83781d]
i2c-core               13888   0 [w83781d i2c-amd756 i2c-proc]
scanner                10400   0 (unused)
ipt_MASQUERADE          1376   1 (autoclean)
ipt_REJECT              3200   1 (autoclean)
ipt_state                576   5 (autoclean)
iptable_filter          1664   1 (autoclean)
iptable_nat            15508   1 [ipt_MASQUERADE]
ip_conntrack           18740   2 [ipt_MASQUERADE ipt_state iptable_nat]
ip_tables              11584   7 [ipt_MASQUERADE ipt_REJECT ipt_state 
iptable_filter iptable_nat]
usb-ohci               18048   0 (unused)
usbcore                63552   1 [hid scanner usb-ohci]
ne2k-pci                4576   1 (autoclean)
8390                    6176   0 (autoclean) [ne2k-pci]
crc32                   2912   0 (autoclean) [8390]
3c509                   9504   1 (autoclean)
ext2                   32480   1 (autoclean)
nls_iso8859-15          3328   4 (autoclean)
nls_cp850               3552   4 (autoclean)
vfat                    9660   4 (autoclean)
fat                    29944   0 (autoclean) [vfat]
ide-scsi                9088   0
scsi_mod               92348   1 [ide-scsi]
rtc                     6044   0 (autoclean)
>>

[7.4.] /proc/ioports:
<<
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0213-0213 : isapnp read
0220-022f : 3c509 PnP
02f8-02ff : serial(auto)
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
50e0-50ef : amd756-smbus
e000-e003 : Advanced Micro Devices [AMD] AMD-751 [Irongate] System Controller
e400-e41f : Realtek Semiconductor Co., Ltd. RTL-8029(AS)
  e400-e41f : ne2k-pci
e800-e81f : Creative Labs SB Live! EMU10k1
  e800-e81f : EMU10K1
ec00-ec07 : Creative Labs SB Live! MIDI/Game Port
f000-f00f : Advanced Micro Devices [AMD] AMD-756 [Viper] IDE
  f000-f007 : ide0
  f008-f00f : ide1
>>
/proc/iomem:
<<
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-17feffff : System RAM
  00100000-0022512f : Kernel code
  00225130-00299e1f : Kernel data
17ff0000-17ff2fff : ACPI Non-volatile Storage
17ff3000-17ffffff : ACPI Tables
d8000000-dbffffff : Advanced Micro Devices [AMD] AMD-751 [Irongate] System 
Controller
dc000000-dfffffff : PCI Bus #01
  dc000000-dc003fff : Matrox Graphics, Inc. MGA G400 AGP
  dd000000-dd7fffff : Matrox Graphics, Inc. MGA G400 AGP
e0000000-e1ffffff : PCI Bus #01
  e0000000-e1ffffff : Matrox Graphics, Inc. MGA G400 AGP
e3000000-e3000fff : Advanced Micro Devices [AMD] AMD-756 [Viper] USB
  e3000000-e3000fff : usb-ohci
e3001000-e3001fff : Advanced Micro Devices [AMD] AMD-751 [Irongate] System 
Controller
ffff0000-ffffffff : reserved
>>

[7.5.] lspci -vvv:
<<
00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-751 [Irongate] System 
Controller (rev 23)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort+ >SERR- <PERR-
	Latency: 32
	Region 0: Memory at d8000000 (32-bit, prefetchable) [size=64M]
	Region 1: Memory at e3001000 (32-bit, prefetchable) [size=4K]
	Region 2: I/O ports at e000 [disabled] [size=4]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=15 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=x1

00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-751 [Irongate] AGP 
Bridge (rev 01) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: dc000000-dfffffff
	Prefetchable memory behind bridge: e0000000-e1ffffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-756 [Viper] ISA (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-756 [Viper] IDE (rev 
03) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at f000 [size=16]

00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-756 [Viper] ACPI (rev 03)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-

00:07.4 USB Controller: Advanced Micro Devices [AMD] AMD-756 [Viper] USB (rev 
06) (prog-if 10 [OHCI])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 16 (20000ns max), cache line size 08
	Interrupt: pin D routed to IRQ 9
	Region 0: Memory at e3000000 (32-bit, non-prefetchable) [size=4K]

00:08.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at e400 [size=32]
	Expansion ROM at e2000000 [disabled] [size=16K]

00:09.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 06)
	Subsystem: Creative Labs CT4832 SBLive! Value
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at e800 [size=32]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.1 Input device controller: Creative Labs SB Live! (rev 06)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32
	Region 0: I/O ports at ec00 [size=8]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:05.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 
04) (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc. Millennium G400 16Mb SGRAM
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32 (4000ns min, 8000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=32M]
	Region 1: Memory at dc000000 (32-bit, non-prefetchable) [size=16K]
	Region 2: Memory at dd000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [f0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=15 SBA+ AGP+ 64bit- FW- Rate=x1

>>

[7.6.] /proc/scsi/scsi:
<<
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor:          Model: CRW9420          Rev: 1.40
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: LG       Model: CD-ROM CRD-8521B Rev: 1.03
  Type:   CD-ROM                           ANSI SCSI revision: 02
>>

[x.]
The kernel I used is the standard one: I've applied no patches.


Thanks for your attention.


Stefano Rosellini
steros@infinito.it

--------------Boundary-00=_QHHKGC8WOX3HU92BLAL2
Content-Type: application/x-bzip2;
  name="config.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="config.bz2"

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

--------------Boundary-00=_QHHKGC8WOX3HU92BLAL2--
