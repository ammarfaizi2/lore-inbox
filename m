Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130252AbQLEBzu>; Mon, 4 Dec 2000 20:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130763AbQLEBzk>; Mon, 4 Dec 2000 20:55:40 -0500
Received: from mail.integrityns.com ([216.84.150.235]:48892 "EHLO
	pop3.integrity.com") by vger.kernel.org with ESMTP
	id <S130252AbQLEBzd>; Mon, 4 Dec 2000 20:55:33 -0500
Message-ID: <3A2C436C.3B879D06@integrityns.com>
Date: Mon, 04 Dec 2000 18:22:52 -0700
From: Fred Feirtag <ffeirtag@integrityns.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test12-diskless i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM:  Kernel Oops 10% of diskless boots
Content-Type: multipart/mixed;
 boundary="------------1A07F2A77EA6FE214AF3BE6D"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------1A07F2A77EA6FE214AF3BE6D
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Following the form:

[1.] PROBLEM:  Kernel Oops 10% of diskless boots
[2.] When booting a diskless workstation (etherboot) the boot will fail
with an Oops, roughly 10% of the time.  This has remained the failure
rate for quite some time.  The included Oops if from 2.4.0-test12-pre4.
Similar crashing is seen with Intel, as well as AMD (below).  Maybe
something is uninitialized in the case of root on NFS???
[3.] diskless boot oops nfsroot
[4.] 2.4.0-test12  (pre4)
[5.]
Kernel command line: auto rw root=/dev/nfs nfsroot=/diskless/%s
console=ttyS0,9600 ramdisk
_size=6144 ip=192.168.15.82:192.168.15.55:192.168.15.1:255.255.255.0:
Initializing CPU#0
Detected 901.614 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1795.69 BogoMIPS
Memory: 123820k/131008k available (1872k kernel code, 6800k reserved,
136k data, 220k init
, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
CPU: Before vendor init, caps: 0183f9ff c1c7f9ff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: After generic, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: Common caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: AMD Athlon(tm) Processor stepping 02
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfb260, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unable to handle kernel NULL pointer dereference at virtual address
00000000
 printing eip:
c1236000
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c1236000>]
EFLAGS: 00010246
eax: 00000000   ebx: c1236000   ecx: 00236000   edx: 0000003c
esi: c1236264   edi: c1236284   ebp: 00000000   esp: c123dcb8
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, stackpage=c123d000)
Stack: c1236000 c123dfa4 00000600 c030f819 c1236000 00000000 00000000
c123dd20
       03051106 c030f884 c123dd20 00000000 c123dd20 00000000 00000000
00000000
       00000000 c12374c0 00000000 c030f900 c123dd20 c12374c0 c02d5fc4
c0105000
Call Trace: [<c0105000>] [<c02649a8>] [<c01070df>] [<c0107517>]
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 c0 74 23 c1
Kernel panic: Attempted to kill init!

>>EIP; c1236000 <_end+ed6f6c/84a2f6c>   <=====
Trace; c0105000 <empty_bad_page+0/1000>
Trace; c02649a8 <call_spurious_interrupt+2310/28a0>
Trace; c01070df <init+7/158>
Trace; c0107517 <kernel_thread+23/30>
Code;  c1236000 <_end+ed6f6c/84a2f6c>   <=====
00000000 <_EIP>:   <=====
Code;  c1236010 <_end+ed6f7c/84a2f6c>
  10:   c0                        (bad)
Code;  c1236011 <_end+ed6f7d/84a2f6c>
  11:   74 23                     je     36 <_EIP+0x36> c1236036
<_end+ed6fa2/84a2f6c>
Code;  c1236013 <_end+ed6f7f/84a2f6c>
  13:   c1 00 00                  roll   $0x0,(%eax)

[7.1]
Linux linux82.integrity.com 2.4.0-test12-diskless #2 Mon Dec 4 12:03:22
MST 2000 i686 unknown
Kernel modules         found
Gnu C                  2.96
Binutils               2.10.0.18
Linux C Library        ..
ldd: missing file arguments
Try `ldd --help' for more information.
ls: /usr/lib/libg++.so: No such file or directory
Procps                 2.0.7
Mount                  2.10m
Net-tools              (2000-05-21)
Kbd                    [option...]
Sh-utils               2.0
Sh-utils               Parker.
Sh-utils
Sh-utils               Inc.
Sh-utils               NO
Sh-utils               PURPOSE.

[7.2]
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 901.000607
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
features        : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca
cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 1795.69

[7.3]
via82cxxx_audio        15864   0 (unused)
soundcore               4004   2 [via82cxxx_audio]
ac97_codec              7972   0
[via82cxxx_audio]                                                                

[7.4]
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
02f8-02ff : serial(auto)
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
4000-40ff : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
5000-500f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
d000-d00f : VIA Technologies, Inc. Bus Master IDE
  d000-d007 : ide0
  d008-d00f : ide1
d400-d41f : VIA Technologies, Inc. UHCI USB
  d400-d41f : usb-uhci
d800-d81f : VIA Technologies, Inc. UHCI USB (#2)
  d800-d81f : usb-uhci
dc00-dcff : VIA Technologies, Inc. AC97 Audio Controller
  dc00-dcff : via82cxxx
e000-e003 : VIA Technologies, Inc. AC97 Audio Controller
e400-e403 : VIA Technologies, Inc. AC97 Audio Controller
ec00-ec3f : Intel Corporation 82557 [Ethernet Pro 100]
  ec00-ec3f : eepro100


00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000cbfff : Extension ROM
000f0000-000fffff : System ROM
00100000-07feffff : System RAM
  00100000-002d43d7 : Kernel code
  002d43d8-002f67a3 : Kernel data
07ff0000-07ff2fff : ACPI Non-volatile Storage
07ff3000-07ffffff : ACPI Tables
d0000000-d3ffffff : VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
d4000000-d5ffffff : PCI Bus #01
  d4000000-d5ffffff : Matrox Graphics, Inc. MGA G400 AGP
d6000000-d8ffffff : PCI Bus #01
  d6000000-d6003fff : Matrox Graphics, Inc. MGA G400 AGP
  d7000000-d77fffff : Matrox Graphics, Inc. MGA G400 AGP
da000000-da0fffff : Intel Corporation 82557 [Ethernet Pro 100]
da100000-da100fff : Intel Corporation 82557 [Ethernet Pro 100]
  da100000-da100fff : eepro100
ffff0000-ffffffff : reserved

[7.5]
00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0305 (rev
02)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at d0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device 8305 (prog-if
00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: d6000000-d8ffffff
        Prefetchable memory behind bridge: d4000000-d5ffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev
22)
        Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev
10) (prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at d000 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 10)
(prog-if 00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 5
        Region 4: I/O ports at d400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.3 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 10)
(prog-if 00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 5
        Region 4: I/O ports at d800 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
(rev 30)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686
[Apollo Super AC97/Audio] (rev 20)
        Subsystem: Micro-star International Co Ltd: Unknown device 3400
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 11
        Region 0: I/O ports at dc00 [size=256]
        Region 1: I/O ports at e000 [size=4]
        Region 2: I/O ports at e400 [size=4]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:0a.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100]
(rev 08)
        Subsystem: Intel Corporation EtherExpress PRO/100+ Management
Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at da100000 (32-bit, non-prefetchable)
[size=4K]
        Region 1: I/O ports at ec00 [size=64]
        Region 2: Memory at da000000 (32-bit, non-prefetchable)
[size=1M]
        Expansion ROM at <unassigned> [disabled] [size=1M]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable+ DSel=0 DScale=2 PME-
 
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP
(rev 04) (prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc. Millennium G400 16Mb SGRAM
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4000ns min, 8000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at d4000000 (32-bit, prefetchable) [size=32M]
        Region 1: Memory at d6000000 (32-bit, non-prefetchable)
[size=16K]
        Region 2: Memory at d7000000 (32-bit, non-prefetchable)
[size=8M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [f0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=x1
--------------1A07F2A77EA6FE214AF3BE6D
Content-Type: text/x-vcard; charset=us-ascii;
 name="ffeirtag.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for Fred Feirtag
Content-Disposition: attachment;
 filename="ffeirtag.vcf"

begin:vcard 
n:Feirtag;Fred
tel;quoted-printable;work:505 - 294 - 7747=0D=0A
tel;fax:505 - 275 - 1125
x-mozilla-html:TRUE
url:http://www.IntegrityLinux.com
org:Integrity Linux Systems
adr;quoted-printable;quoted-printable:;;1001 Medical Arts Avenue, NE=0D=0A;Albuquerque;NM;87102=0D=0A;
version:2.1
email;internet:ffeirtag@integrityns.com
title:Chief Technologist
x-mozilla-cpt:;480
fn:Fred Feirtag
end:vcard

--------------1A07F2A77EA6FE214AF3BE6D--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
