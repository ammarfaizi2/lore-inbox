Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262482AbTFBPhn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 11:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262483AbTFBPhm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 11:37:42 -0400
Received: from kogut2.o2.pl ([212.126.20.58]:36552 "EHLO kogut2.o2.pl")
	by vger.kernel.org with ESMTP id S262482AbTFBPhU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 11:37:20 -0400
From: "Fryderyk Mazurek" <dedyk@go2.pl>
To: <linux-kernel@vger.kernel.org>
Subject: Kernel(2.4.21-rc6) BUG on slab.c
Date: Mon, 2 Jun 2003 17:50:35 +0200
Message-ID: <MCBBKNJEDBEANFAMJPFPMECGCBAA.dedyk@go2.pl>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 1 (Highest)
X-MSMail-Priority: High
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: High
Sensitivity: Private
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I'm using 2.4.21-rc6 sometimes I get message:

Jun  2 00:32:12 frycek kernel: kernel BUG at slab.c:1439!
Jun  2 00:32:13 frycek kernel: invalid operand: 0000
Jun  2 00:32:13 frycek kernel: CPU:    0
Jun  2 00:32:13 frycek kernel: EIP:    0010:[<c0132390>]    Tainted: PF
Jun  2 00:32:13 frycek kernel: EFLAGS: 00210016
Jun  2 00:32:13 frycek kernel: eax: c25f678c   ebx: 00068648   ecx: 01000108
edx: c10b50a0
Jun  2 00:32:13 frycek kernel: esi: c25f6000   edi: 5a2cf071   ebp: c0e4bf3c
esp: c0e4bf2c
Jun  2 00:32:13 frycek kernel: ds: 0018   es: 0018   ss: 0018
Jun  2 00:32:13 frycek kernel: Process mc (pid: 3076, stackpage=c0e4b000)
Jun  2 00:32:13 frycek kernel: Stack: 00200282 00068648 c25f6794 00200282
c0e4bf58 c0131aa9 c10b50a0 c25f678c
Jun  2 00:32:13 frycek kernel:        00000001 c25f67a8 bfffd0d4 c0e4bfbc
c014cb9b c25f6794 00000001 00000004
Jun  2 00:32:13 frycek kernel:        00000024 c0e4bf98 c01bcdf9 c01c0ec0
00000001 00000001 c0e4a000 c25f6794
Jun  2 00:32:13 frycek kernel: Call Trace:    [<c0131aa9>] [<c014cb9b>]
[<c01bcdf9>] [<c01c0ec0>] [<c0107343>]
Jun  2 00:32:13 frycek kernel:
Jun  2 00:32:13 frycek kernel: Code: 0f 0b 9f 05 fe 45 2c c0 8b 4d 08 bb 71
f0 2c 5a 8b 7d 0c 03
Jun  2 00:33:01 frycek kernel:  kernel BUG at slab.c:1439!
Jun  2 00:33:01 frycek kernel: invalid operand: 0000
Jun  2 00:33:01 frycek kernel: CPU:    0
Jun  2 00:33:01 frycek kernel: EIP:    0010:[<c0132390>]    Tainted: PF
Jun  2 00:33:01 frycek kernel: EFLAGS: 00010016
Jun  2 00:33:01 frycek kernel: eax: c30e778c   ebx: 000867b4   ecx: 01000100
edx: c10b50a0
Jun  2 00:33:01 frycek kernel: esi: c30e7000   edi: 5a2cf071   ebp: c2371f3c
esp: c2371f2c
Jun  2 00:33:01 frycek kernel: ds: 0018   es: 0018   ss: 0018
Jun  2 00:33:01 frycek kernel: Process kdeinit (pid: 2818,
stackpage=c2371000)
Jun  2 00:33:01 frycek kernel: Stack: 00000282 000867b4 c30e7794 00000282
c2371f58 c0131aa9 c10b50a0 c30e778c
Jun  2 00:33:01 frycek kernel:        00000000 c30e77ac 08133a04 c2371fbc
c014cb9b c30e7794 00000000 00000004
Jun  2 00:33:01 frycek kernel:        00000001 00000001 00000001 c1b9be54
00000001 00000001 c2370000 c30e7794
Jun  2 00:33:01 frycek kernel: Call Trace:    [<c0131aa9>] [<c014cb9b>]
[<c0107343>]
Jun  2 00:33:01 frycek kernel:
Jun  2 00:33:01 frycek kernel: Code: 0f 0b 9f 05 fe 45 2c c0 8b 4d 08 bb 71
f0 2c 5a 8b 7d 0c 03
Jun  2 00:39:24 frycek kernel:  kernel BUG at slab.c:1443!
Jun  2 00:39:24 frycek kernel: invalid operand: 0000
Jun  2 00:39:24 frycek kernel: CPU:    0
Jun  2 00:39:24 frycek kernel: EIP:    0010:[<c01323b5>]    Tainted: PF
Jun  2 00:39:24 frycek kernel: EFLAGS: 00210082
Jun  2 00:39:24 frycek kernel: eax: c3f7d2dc   ebx: a55a5a5a   ecx: c10b50a0
edx: c10b50a0
Jun  2 00:39:24 frycek kernel: esi: c3f7d000   edi: c3f7d304   ebp: c12fff60
esp: c12fff50
Jun  2 00:39:24 frycek kernel: ds: 0018   es: 0018   ss: 0018
Jun  2 00:39:24 frycek kernel: Process httpd (pid: 1072, stackpage=c12ff000)
Jun  2 00:39:24 frycek kernel: Stack: 00200286 000ae97c c3f7d2e4 00200286
c12fff7c c0131aa9 c10b50a0 c3f7d2dc
Jun  2 00:39:24 frycek kernel:        00000000 00000001 c3f7d2e4 c12fffbc
c014d05c c3f7d2e4 c011c6cc 00000001
Jun  2 00:39:24 frycek kernel:        00000000 c12fffa8 c3f7d2e4 00000000
00000000 00000000 00000000 c27b2000
Jun  2 00:39:24 frycek kernel: Call Trace:    [<c0131aa9>] [<c014d05c>]
[<c011c6cc>] [<c0107343>]
Jun  2 00:39:24 frycek kernel:
Jun  2 00:39:24 frycek kernel: Code: 0f 0b a3 05 fe 45 2c c0 8b 41 1c f6 c4
08 74 34 8b 7d 08 f6

or

Jun  2 16:12:06 frycek kernel: kernel BUG at slab.c:1443!
Jun  2 16:12:06 frycek kernel: invalid operand: 0000
Jun  2 16:12:06 frycek kernel: CPU:    0
Jun  2 16:12:06 frycek kernel: EIP:    0010:[<c01323b5>]    Tainted: PF
Jun  2 16:12:06 frycek kernel: EFLAGS: 00010082
Jun  2 16:12:06 frycek kernel: eax: c3cd0c8c   ebx: a55a5a5a   ecx: c10b50a0
edx: c10b50a0
Jun  2 16:12:06 frycek kernel: esi: c3cd0000   edi: c3cd0cb4   ebp: c3fd5f3c
esp: c3fd5f2c
Jun  2 16:12:06 frycek kernel: ds: 0018   es: 0018   ss: 0018
Jun  2 16:12:06 frycek kernel: Process init (pid: 1, stackpage=c3fd5000)
Jun  2 16:12:06 frycek kernel: Stack: 00000282 000a73c0 c3cd0c94 00000282
c3fd5f58 c0131aa9 c10b50a0 c3cd0c8c
Jun  2 16:12:06 frycek kernel:        00000000 c3cd0ca8 bffffb44 c3fd5fbc
c014cb9b c3cd0c94 00000000 00000004
Jun  2 16:12:06 frycek kernel:        0000002a c3fd5f94 c3fd5f94 c3fd5f88
00000001 00000001 c3fd4000 c3cd0c94
Jun  2 16:12:06 frycek kernel: Call Trace:    [<c0131aa9>] [<c014cb9b>]
[<c0107343>]
Jun  2 16:12:06 frycek kernel:
Jun  2 16:12:06 frycek kernel: Code: 0f 0b a3 05 fe 45 2c c0 8b 41 1c f6 c4
08 74 34 8b 7d 08 f6
Jun  2 16:12:06 frycek kernel:  <0>Kernel panic: Attempted to kill init!
Jun  2 16:12:11 frycek kernel: kernel BUG at slab.c:1443!
Jun  2 16:12:11 frycek kernel: invalid operand: 0000
Jun  2 16:12:11 frycek kernel: CPU:    0
Jun  2 16:12:11 frycek kernel: EIP:    0010:[<c01323b5>]    Tainted: PF
Jun  2 16:12:11 frycek kernel: EFLAGS: 00010016
Jun  2 16:12:11 frycek kernel: eax: c3cd0c68   ebx: 5a2cf071   ecx: c10b50a0
edx: c10b50a0
Jun  2 16:12:11 frycek kernel: esi: c3cd0000   edi: c3cd0c90   ebp: c3fb1f54
esp: c3fb1f44
Jun  2 16:12:11 frycek kernel: ds: 0018   es: 0018   ss: 0018
Jun  2 16:12:11 frycek kernel: Process kswapd (pid: 4, stackpage=c3fb1000)
Jun  2 16:12:11 frycek kernel: Stack: c10b50a0 00000246 c3cd0c6c c10b50a0
c3fb1f70 c0131a13 c10b50a0 c3cd0c68
Jun  2 16:12:11 frycek kernel:        c3cd049c 00000000 c10b59e8 c3fb1fa0
c0131cc2 c10b50a0 c3cd0c6c 00000000
Jun  2 16:12:11 frycek kernel:        c10b54c0 00000000 00000002 00000009
c0306970 00000020 00000006 c3fb1fc4
Jun  2 16:12:11 frycek kernel: Call Trace:    [<c0131a13>] [<c0131cc2>]
[<c013356c>] [<c0132f55>] [<c0105000>]
Jun  2 16:12:11 frycek kernel:   [<c0105a63>] [<c0132e80>]
Jun  2 16:12:11 frycek kernel:
Jun  2 16:12:11 frycek kernel: Code: 0f 0b a3 05 fe 45 2c c0 8b 41 1c f6 c4
08 74 34 8b 7d 08 f6

When I'm used 2.4.21-rc2 I didn't get this message, but I'm used gcc-3.2.3.

Kernel 2.4.21-rc6 is my first kernel which I use gcc-3.3.



software:

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux frycek.com.pl 2.4.21-rc6 #3 nie cze 1 23:22:06 CEST 2003 i586 unknown
unknown GNU/Linux

Gnu C                  3.3
Gnu make               3.80
util-linux             2.11x
mount                  2.11x
modutils               2.4.19
e2fsprogs              1.32
jfsutils               1.0.24
reiserfsprogs          3.6.4
PPP                    2.4.1
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 3.1.6
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               4.5.7
Modules Loaded         vmnet parport_pc parport vmmon ipt_REJECT
iptable_filter ip_tables opl3 reiserfs ntfs nls_cp437 vfat fat ad1816
usb-uhci usbcore rtc unix


/proc/cpuinfo:
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 5
model		: 8
model name	: AMD-K6(tm) 3D processor
stepping	: 12
cpu MHz		: 451.034
cache size	: 64 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr mce cx8 pge mmx syscall 3dnow k6_mtrr
bogomips	: 897.84

/proc/modules:
vmnet                  21152   3
parport_pc             27208   0
parport                25704   0 [parport_pc]
vmmon                  20148   0 (unused)
ipt_REJECT              2904   3 (autoclean)
iptable_filter          1644   1 (autoclean)
ip_tables              14400   2 [ipt_REJECT iptable_filter]
opl3                   13188   0 (unused)
reiserfs              185828   1 (autoclean)
ntfs                   52992   1 (autoclean)
nls_cp437               4380   1 (autoclean)
vfat                   11532   1 (autoclean)
fat                    31704   0 (autoclean) [vfat]
ad1816                 11780   0
usb-uhci               27440   0 (unused)
usbcore                72716   1 [usb-uhci]
rtc                     6504   0 (autoclean)
unix                   15980  96 (autoclean)

lspci -vvv:
00:00.0 Host bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3] (rev 04)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR+
	Latency: 16
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=8 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW-
AGP3- Rate=x1,x2
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo
MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: e4000000-e5ffffff
	Prefetchable memory behind bridge: e6000000-e6ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo
VP] (rev 41)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus
Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at e400 [size=16]

00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 02) (prog-if 00
[UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Interrupt: pin D routed to IRQ 9
	Region 4: I/O ports at e000 [size=32]

00:07.3 PCI bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 10) (prog-if
00 [Normal decode])
	!!! Invalid class 0604 for header type 00
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

00:09.0 Communication controller: Analog Devices SM56 PCI modem
	Subsystem: Analog Devices SM56 PCI modem
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR+
	Latency: 64 (250ns min, 63750ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at e7000000 (32-bit, prefetchable) [size=256]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0+,D1-,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage IIC AGP (rev
3a) (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc: Unknown device 0088
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), cache line size 08
	Region 0: Memory at e6000000 (32-bit, prefetchable) [size=16M]
	Region 1: I/O ports at c000 [size=256]
	Region 2: Memory at e5000000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [5c] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

/proc/iomem:
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-03feffff : System RAM
  00100000-002b27e9 : Kernel code
  002b27ea-0031cba3 : Kernel data
03ff0000-03ff07ff : ACPI Non-volatile Storage
03ff0800-03ffffff : ACPI Tables
e0000000-e3ffffff : VIA Technologies, Inc. VT82C597 [Apollo VP3]
e4000000-e5ffffff : PCI Bus #01
  e5000000-e5000fff : ATI Technologies Inc 3D Rage IIC AGP
e6000000-e6ffffff : PCI Bus #01
  e6000000-e6ffffff : ATI Technologies Inc 3D Rage IIC AGP
e7000000-e70000ff : Analog Devices SM56 PCI modem
ffff0000-ffffffff : reserved

/proc/ioports:
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
02f8-02ff : serial(auto)
0376-0376 : ide1
0378-037a : parport0
0388-038b : Yamaha OPL3
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0500-050f : AD1816 Sound
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
6000-60ff : VIA Technologies, Inc. VT82C586B ACPI
c000-cfff : PCI Bus #01
  c000-c0ff : ATI Technologies Inc 3D Rage IIC AGP
e000-e01f : VIA Technologies, Inc. USB
  e000-e01f : usb-uhci
e400-e40f : VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
  e400-e407 : ide0
  e408-e40f : ide1




                          linux user #254359

