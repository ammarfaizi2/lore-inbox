Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317701AbSHLKMG>; Mon, 12 Aug 2002 06:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317743AbSHLKMG>; Mon, 12 Aug 2002 06:12:06 -0400
Received: from [194.93.78.125] ([194.93.78.125]:46899 "ehlo mail-ext.phion.com")
	by vger.kernel.org with ESMTP id <S317701AbSHLKMA>;
	Mon, 12 Aug 2002 06:12:00 -0400
Subject: PROBLEM: kernel oopses
From: Joe Radinger <j.radinger@phion.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";	boundary="=-zCSigwvDYSB0CvNtYtBc"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-4) 
Date: 12 Aug 2002 12:15:42 +0200
Message-Id: <1029147342.20172.99.camel@yoda.phion>
X-phion-id: 20020812-121541-02700-00
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zCSigwvDYSB0CvNtYtBc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

here comes my first kernel-bug-report.:

[1.] kernel oopses
[2.] my kernel 2.4.19 oopsed today and galeon crashed
[3.] kernel
[4.] Linux version 2.4.19 (root@yoda.phion) (gcc version 2.96 20000731
(Red Hat Linux 7.1 2.96-98)) #2 Wed Aug 7 11:39:04 CEST 2002
[5.] oops:
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0131b10>]    Tainted: PF
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00210286
eax: 00000000   ebx: c12ddd68   ecx: c02a0560   edx: 00000000
esi: 00000000   edi: 00000000   ebp: d266c38c   esp: c6ef3e60
ds: 0018   es: 0018   ss: 0018
Process galeon-bin (pid: 7229, stackpage=3Dc6ef3000)
Stack: 00000000 00000001 c013291b c02a0560 001b8900 c148bd94 00000000
00000000=20
       00000002 00000008 d266c38c c0127d78 00001b89 c6ef2000 00000000
001b8800=20
       c0127de0 001b8800 00000001 408e3204 00000000 ce52dbe0 d754e3e0
c012825f=20
Call Trace:    [<c013291b>] [<c0127d78>] [<c0127de0>] [<c012825f>]
[<d8979836>]
  [<d8979931>] [<d89a5a00>] [<c0115845>] [<d89a5a00>] [<d88cc5c2>]
[<d88bc662>]
  [<c0109e0a>] [<d89a5a00>] [<c010a02d>] [<c01156b0>] [<c0108ad0>]
Code: 0f 0b 5b 00 54 3f 26 c0 8b 15 10 56 30 c0 89 d8 29 d0 69 c0=20

>>EIP; c0131b10 <__free_pages_ok+30/290>   <=3D=3D=3D=3D=3D
Trace; c013291b <read_swap_cache_async+4b/a0>
Trace; c0127d78 <swapin_readahead+28/50>
Trace; c0127de0 <do_swap_page+40/150>
Trace; c012825f <handle_mm_fault+6f/f0>
Trace; d8979836 <[NVdriver]__nvsym00528+102/244>
Trace; d8979931 <[NVdriver]__nvsym00528+1fd/244>
Trace; d89a5a00 <[NVdriver]nv_linux_devices+0/4e0>
Trace; c0115845 <do_page_fault+195/4df>
Trace; d89a5a00 <[NVdriver]nv_linux_devices+0/4e0>
Trace; d88cc5c2 <[NVdriver]RmIsr+2e/4c>
Trace; d88bc662 <[NVdriver]nv_kern_isr+1e/c8>
Trace; c0109e0a <handle_IRQ_event+3a/70>
Trace; d89a5a00 <[NVdriver]nv_linux_devices+0/4e0>
Trace; c010a02d <do_IRQ+bd/f0>
Trace; c01156b0 <do_page_fault+0/4df>
Trace; c0108ad0 <error_code+34/40>
Code;  c0131b10 <__free_pages_ok+30/290>
00000000 <_EIP>:
Code;  c0131b10 <__free_pages_ok+30/290>   <=3D=3D=3D=3D=3D
   0:   0f 0b                     ud2a      <=3D=3D=3D=3D=3D
Code;  c0131b12 <__free_pages_ok+32/290>
   2:   5b                        pop    %ebx
Code;  c0131b13 <__free_pages_ok+33/290>
   3:   00 54 3f 26               add    %dl,0x26(%edi,%edi,1)
Code;  c0131b17 <__free_pages_ok+37/290>
   7:   c0 8b 15 10 56 30 c0      rorb   $0xc0,0x30561015(%ebx)
Code;  c0131b1e <__free_pages_ok+3e/290>
   e:   89 d8                     mov    %ebx,%eax
Code;  c0131b20 <__free_pages_ok+40/290>
  10:   29 d0                     sub    %edx,%eax
Code;  c0131b22 <__free_pages_ok+42/290>
  12:   69 c0 00 00 00 00         imul   $0x0,%eax,%eax


1 warning issued.  Results may not be reliable.

[6.] sorry, don't know how to trigger the bug
[7.] Environment:
[7.1.] Linux yoda.phion 2.4.19 #2 Wed Aug 7 11:39:04 CEST 2002 i686
unknown
=20
Gnu C                  2.96
Gnu make               3.79.1
binutils               2.11.90.0.8
util-linux             2.11f
mount                  2.10r
modutils               2.4.14
e2fsprogs              1.25
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.56
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         nls_cp437 vfat fat sg NVdriver vmnet vmmon
ide-scsi nls_iso8859-1 8139too mii agpgart loop cmpci mousedev hid input
usb-uhci usbcore

[7.2.] processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Celeron (Coppermine)
stepping        : 6
cpu MHz         : 801.850
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr sse
bogomips        : 1599.07

[7.3.] nls_cp437               5120   0 (autoclean)
vfat                   12604   0 (autoclean)
fat                    38264   0 (autoclean) [vfat]
sg                     31588   0 (autoclean)
NVdriver             1070368  15
vmnet                  22624   5
vmmon                  23060   6
ide-scsi                9824   0
nls_iso8859-1           3520   5 (autoclean)
8139too                17184   1 (autoclean)
mii                     1980   0 (autoclean) [8139too]
agpgart                31136   5
loop                   10544  15 (autoclean)
cmpci                  35832   1
mousedev                5152   2
hid                    21024   0 (unused)
input                   5728   0 [mousedev hid]
usb-uhci               26468   0 (unused)
usbcore                80928   1 [hid usb-uhci]

[7.4.] 00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000d4000-000d47ff : Extension ROM
000f0000-000fffff : System ROM
00100000-17feffff : System RAM
  00100000-0025779e : Kernel code
  0025779f-002d9537 : Kernel data
17ff0000-17ff2fff : ACPI Non-volatile Storage
17ff3000-17ffffff : ACPI Tables
d0000000-d3ffffff : VIA Technologies, Inc. VT82C693A/694x [Apollo
PRO133x]
d4000000-d5ffffff : PCI Bus #01
  d4000000-d4ffffff : nVidia Corporation Vanta [NV6]
d6000000-d7ffffff : PCI Bus #01
  d6000000-d7ffffff : nVidia Corporation Vanta [NV6]
d9000000-d9000fff : Adaptec AHA-2940/2940W / AIC-7871
  d9000000-d9000fff : aic7xxx
d9001000-d90010ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C
  d9001000-d90010ff : 8139too
ffff0000-ffffffff : reserved

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
0330-0331 : cmpci Midi
0376-0376 : ide1
0388-038b : cmpci FM
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
d000-d00f : VIA Technologies, Inc. Bus Master IDE
  d000-d007 : ide0
  d008-d00f : ide1
d400-d41f : VIA Technologies, Inc. UHCI USB
  d400-d41f : usb-uhci
d800-d8ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C
  d800-d8ff : 8139too
dc00-dcff : Adaptec AHA-2940/2940W / AIC-7871
e000-e0ff : C-Media Electronics Inc CM8738
  e000-e0ff : cmpci


[7.5.] 00:00.0 Host bridge: VIA Technologies, Inc. VT82C691 [Apollo PRO]
(rev 44)
        Subsystem: Elitegroup Computer Systems: Unknown device 0954
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- Fast
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort+ >SERR
        Latency: 0
        Region 0: Memory at d0000000 (32-bit, prefetchable) [size=3D64M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=3D7 SBA+ 64bit- FW- Rate=3Dx1,x2
                Command: RQ=3D0 SBA- AGP+ 64bit- FW- Rate=3Dx2

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3 AGP]
(prog-if 00 [Normal decode
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- Fast
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort+ >SERR
        Latency: 0
        Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D=
0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: d4000000-d5ffffff
        Prefetchable memory behind bridge: d6000000-d7ffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C596 ISA [Apollo PRO]
(rev 23)
        Subsystem: VIA Technologies, Inc. VT82C596/A/B PCI to ISA Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- Fast
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR
        Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev
10) (prog-if 8a [Master
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- Fast
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR
        Latency: 32
        Region 4: I/O ports at d000 [size=3D16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 11)
(prog-if 00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- Fast
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 10
        Region 4: I/O ports at d400 [size=3D32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:07.3 Host bridge: VIA Technologies, Inc.: Unknown device 3050 (rev
30)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- Fast
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR

00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139
(rev 10)
        Subsystem: Surecom Technology EP-320X-R
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- Fast
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR
        Latency: 32 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 12
        Region 0: I/O ports at d800 [size=3D256]
        Region 1: Memory at d9001000 (32-bit, non-prefetchable)
[size=3D256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:0c.0 SCSI storage controller: Adaptec AHA-294x / AIC-7871 (rev 03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- Fast
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR
        Latency: 32 (2000ns min, 2000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at dc00 [disabled] [size=3D256]
        Region 1: Memory at d9000000 (32-bit, non-prefetchable)
[size=3D4K]
        Expansion ROM at <unassigned> [disabled] [size=3D64K]

00:0d.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev
10)
        Subsystem: C-Media Electronics Inc CMI8738/C3DX PCI Audio Device
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- Fast
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR
        Latency: 32 (500ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at e000 [size=3D256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

01:00.0 VGA compatible controller: nVidia Corporation Vanta [NV6] (rev
15) (prog-if 00 [VGA])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- Fast
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR
        Latency: 248 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at d4000000 (32-bit, non-prefetchable)
[size=3D16M]
        Region 1: Memory at d6000000 (32-bit, prefetchable) [size=3D32M]
        Expansion ROM at <unassigned> [disabled] [size=3D64K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=3D31 SBA- 64bit- FW- Rate=3Dx1,x2
                Command: RQ=3D7 SBA- AGP+ 64bit- FW- Rate=3Dx2


[7.6.] Attached devices:=20
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: YAMAHA   Model: CRW8824S         Rev: 1.00
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: LITE-ON  Model: LTR-32123S       Rev: XS06
  Type:   CD-ROM                           ANSI SCSI revision: 02

[7.7.] my kernel is a patched one:
i use the preemptive kernel patch and have risen the standard number of
available loop-devices to 250.

yours
josef


--=-zCSigwvDYSB0CvNtYtBc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA9V4rOyOLl//lX6PMRAv9uAJ9QH4WY6sUgYyXpSoGaiTnu3oSELQCffOoV
S8M7I+mKw/7hwBBiLsaSCiQ=
=T52M
-----END PGP SIGNATURE-----

--=-zCSigwvDYSB0CvNtYtBc--

