Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132520AbREEFi1>; Sat, 5 May 2001 01:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132553AbREEFiS>; Sat, 5 May 2001 01:38:18 -0400
Received: from c007-h014.c007.snv.cp.net ([209.228.33.221]:23992 "HELO
	c007.snv.cp.net") by vger.kernel.org with SMTP id <S132520AbREEFiI>;
	Sat, 5 May 2001 01:38:08 -0400
X-Sent: 5 May 2001 05:38:01 GMT
Message-ID: <3AF39332.4BF1FF1A@telocity.com>
Date: Sat, 05 May 2001 00:44:18 -0500
From: paul harris <cph013@telocity.com>
Reply-To: pbharris_359@yahoo.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Bus error - Shortly later kernel lockup, many MTRR registers
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by leeloo.zip.com.au id PAA07914

Hello, I hope I am doing this correctly per the BUG-REPORTING doc.

1.  Bus error - Shortly later kernel lockup MTRR registers

2.  My kernel has locked up 3 times since moving to the 2.4.x kernel.
I am not excaly sure of what triggers it
      but it does always happen while I am actively using it.
Netscape 4.77 ussally has a bus error shortly before the box
      will lock up,  but the netscape bus error can happen and no
messages will get logged or any lock up happen.    The message

 mtrr: no MTRR for e4000000,2000000 found

frequently shows up in my /var/log/message file.

3.   MTRR,  Invalid opernad

4. kernel version: 2.4.4

5.   Opps message (?)Oops: 0000
      Apr 30 19:51:29 bugs kernel: CPU:    0
      Apr 30 19:51:29 bugs kernel: EIP:    0010:[<c01473f8>]
      Apr 30 19:51:29 bugs kernel: EFLAGS: 00010202
      Apr 30 19:51:29 bugs kernel: eax: c49f3efc   ebx: c15bc440   ecx:
00000001   edx: c14e9ec0
      Apr 30 19:51:29 bugs kernel: esi: 41449340   edi: c49f3f9c   ebp:
c544700d   esp: c49f3edc
      Apr 30 19:51:29 bugs kernel: ds: 0018   es: 0018   ss: 0018
      Apr 30 19:51:29 bugs kernel: Process pidof (pid: 11075,
stackpage=c49f3000)
      Apr 30 19:51:29 bugs kernel: Stack: ceeae640 fffffff3 c0147681
ceeae640 c49f3ef8 c49f3efc 00000000 c544700a
      Apr 30 19:51:29 bugs kernel:        c14e9ec0 ceeae640 fffffff3
c49f3f9c c544700d c0147a4f ceeae640 c49f2000
      Apr 30 19:51:29 bugs kernel:        cfd1d140 ceeae640 c01394d9
cfd1d140 c49f3f9c ceeae640 c49f3f40 c49f3f40
      Apr 30 19:51:29 bugs kernel: Call Trace: [<c0147681>] [<c0147a4f>]
[<c01394d9>] [<c0120b92>] [<c01399c8>] [<c0136952>] [<c0120ee2>]
Apr 30 19:51:29 bugs kernel:        [<c0106c1b>]

6.  I know of know program which can dupicate the problem exaclty.

7.0  Environment:
    800 MHz Processor on a Asus A7V MB
    256 MB PC133 memory
    xfree86 4.03
    distributon :RedHat 7.1


7.1.   Out output of ver_linux:
     [root@bugs scripts]# sh ver_linux
    If some fields are empty or look unusual you may have an old
version.
    Compare to the current minimal requirements in
Documentation/Changes.

    Linux bugs.harris.org 2.4.4 #2 Sat Apr 28 21:37:19 CDT 2001 i686
unknown

    Gnu C                  2.96
    Gnu make               3.79.1
    binutils               2.10.91.0.2
    util-linux             2.10s
    mount                  2.10r
    modutils               2.4.2
    e2fsprogs              1.19
    PPP                    2.4.0
    isdn4k-utils           3.1pre1
    Linux C Library        2.2.2
    Dynamic linker (ldd)   2.2.2
    Procps                 2.0.7
    Net-tools              1.57
    Console-tools          0.3.3
    Sh-utils               2.0
    Modules Loaded         loop NVdriver autofs tulip ipchains ide-scsi
scsi_mod ide-cd cdrom vfat fat usbmouse mousedev hid input usb-uhci
usbcore
[root@bugs scripts]#

7.2  cat /proc/cpuinfo
    processor       : 0
    vendor_id       : AuthenticAMD
    cpu family      : 6
    model           : 4
    model name      : AMD Athlon(tm) Processor
    stepping        : 2
    cpu MHz         : 807.194
    cache size      : 256 KB
    fdiv_bug        : no
    hlt_bug         : no
    f00f_bug        : no
    coma_bug        : no
    fpu             : yes
    fpu_exception   : yes
    cpuid level     : 1
    wp              : yes
    flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge
mca cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
    bogomips        : 1608.90

7.3 cat /proc/modules:
    loop                    8080   6 (autoclean)
    NVdriver              629552  12 (autoclean)
    autofs                 10784   1 (autoclean)
    tulip                  36672   1 (autoclean)
    ipchains               33136   0 (unused)
    ide-scsi                8032   0
    scsi_mod               52928   1 [ide-scsi]
    ide-cd                 26400   0
    cdrom                  27296   0 [ide-cd]
    vfat                    9328   1 (autoclean)
    fat                    31392   0 (autoclean) [vfat]
    usbmouse                1888   0 (unused)
    mousedev                4128   1
    hid                    11680   0 (unused)
    input                   3168   0 [usbmouse mousedev hid]
    usb-uhci               21808   0 (unused)
    usbcore                48240   1 [usbmouse hid usb-uhci]

7.4 [pbharris@bugs pbharris]$ cat /proc/ioports
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
8000-803f : Promise Technology, Inc. 20265
  8000-8007 : ide2
  8008-800f : ide3
  8010-803f : PDC20265
8400-8403 : Promise Technology, Inc. 20265
8800-8807 : Promise Technology, Inc. 20265
9000-9003 : Promise T
echnology, Inc. 20265
9400-9407 : Promise Technology, Inc. 20265
9800-987f : Digital Equipment Corporation DECchip 21041 [Tulip Pass 3]
  9800-987f : tulip
a000-a007 : Creative Labs SB Live!
a400-a41f : Creative Labs SB Live! EMU10000
d000-d01f : VIA Technologies, Inc. UHCI USB (#2)
  d000-d01f : usb-uhci
d400-d41f : VIA Technologies, Inc. UHCI USB
  d400-d41f : usb-uhci
d800-d80f : VIA Technologies, Inc. Bus Master IDE
  d800-d807 : ide0
  d808-d80f : ide1
e200-e27f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
e400-e4ff : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
e800-e80f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
[pbharris@bugs pbharris]$


[pbharris@bugs pbharris]$ cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0ffebfff : System RAM
  00100000-001be67f : Kernel code
  001be680-001fa9df : Kernel data
0ffec000-0ffeefff : ACPI Tables
0ffef000-0fffefff : reserved
0ffff000-0fffffff : ACPI Non-volatile Storage
df000000-df01ffff : Promise Technology, Inc. 20265
df800000-df80007f : Digital Equipment Corporation DECchip 21041 [Tulip
Pass 3]
  df800000-df80007f : tulip
e0000000-e1dfffff : PCI Bus #01
  e0000000-e0ffffff : nVidia Corporation Vanta [NV6]
e1f00000-e3ffffff : PCI Bus #01
  e2000000-e3ffffff : nVidia Corporation Vanta [NV6]
e4000000-e7ffffff : VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
ffff0000-ffffffff : reserved
[pbharris@bugs pbharris]$


7.5  Modules Loaded         loop NVdriver autofs tulip ipchains ide-scsi
scsi_mod ide-cd cdrom vfat fat usbmouse mousedev hid input usb-uhci
usbcore
[root@bugs scripts]# /sbin/lspci -vvv
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
(rev 02)
        Subsystem: Asustek Computer, Inc.: Unknown device 8033
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at e4000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP+ 64bit- FW- Rate=<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR+
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000e000-0000dfff
        Memory behind bridge: e0000000-e1dfffff
        Prefetchable memory behind bridge: e1f00000-e3ffffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
(rev 22)
        Subsystem: Asustek Computer, Inc.: Unknown device 8033
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:04.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10)
(prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at d800 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10)
(prog-if 00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 9
        Region 4: I/O ports at d400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00:04.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10)
(prog-if 00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 9
        Region 4: I/O ports at d000 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
(rev 30)
        Subsystem: Asustek Computer, Inc.: Unknown device 8033
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Multimedia audio controller: Creative Labs SB Live! EMU10000
(rev 08)
        Subsystem: Creative Labs CT4832 SBLive! Value
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at a400 [size=32]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.1 Input device controller: Creative Labs SB Live! (rev 08)
        Subsystem: Creative Labs Gameport Joystick
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 0: I/O ports at a000 [size=8]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.0 Ethernet controller: Digital Equipment Corporation DECchip 21041
[Tulip Pass 3] (rev 11)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at 9800 [size=128]
        Region 1: Memory at df800000 (32-bit, non-prefetchable)
[size=128]
        Expansion ROM at <unassigned> [disabled] [size=256K]

00:11.0 Unknown mass storage controller: Promise Technology, Inc. 20265
(rev 02)
        Subsystem: Promise Technology, Inc.: Unknown device 4d33
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at 9400 [size=8]
        Region 1: I/O ports at 9000 [size=4]
        Region 2: I/O ports at 8800 [size=8]
        Region 3: I/O ports at 8400 [size=4]
        Region 4: I/O ports at 8000 [size=64]
        Region 5: Memory at df000000 (32-bit, non-prefetchable)
[size=128K]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [58] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation Vanta [NV6] (rev
15) (prog-if 00 [VGA])
        Subsystem: VISIONTEK: Unknown device 0002
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 248 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e0000000 (32-bit, non-prefetchable)
[size=16M]
        Region 1: Memory at e2000000 (32-bit, prefetchable) [size=32M]
        Expansion ROM at e1ff0000 [disabled] [size=64K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=31 SBA- 64bit- FW- Rate=x1,x2
                Command: RQ=31 SBA- AGP+ 64bit- FW- Rate=<none>

7.6  cat /proc/scsi/scsi
    [pbharris@bugs pbharris]$ cat /proc/scsi/scsi
    Attached devices:
    Host: scsi0 Channel: 00 Id: 00 Lun: 00
      Vendor: MITSUMI  Model: CD-ROM FX4010M!B Rev: AM2A
      Type:   CD-ROM                           ANSI SCSI revision: 02
    Host: scsi0 Channel: 00 Id: 01 Lun: 00
      Vendor: IDE-CD   Model: R/RW 4x4x24      Rev: 1.04
      Type:   CD-ROM                           ANSI SCSI revision: 02
    [pbharris@bugs pbharris]$



X.  GCC2.96 used to compile kernel.
ı:.Ë›±Êâmçë¢kaŠÉb²ßìzwm…ébïîË›±Êâmébìÿ‘êçz_âØ^n‡r¡ö¦zËëh™¨è­Ú&£ûàz¿äz¹Ş—ú+€Ê+zf£¢·hšˆ§~†­†Ûiÿÿïêÿ‘êçz_è®æj:+v‰¨ş)ß£ømšSåy«­æ¶…­†ÛiÿÿğÃí»è®å’i
