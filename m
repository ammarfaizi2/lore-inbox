Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131189AbRCGVGq>; Wed, 7 Mar 2001 16:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131188AbRCGVGh>; Wed, 7 Mar 2001 16:06:37 -0500
Received: from mail.caramail.com ([195.68.99.70]:18151 "EHLO mail.caramail.com")
	by vger.kernel.org with ESMTP id <S131189AbRCGVG1>;
	Wed, 7 Mar 2001 16:06:27 -0500
Posted-Date: Wed, 7 Mar 2001 11:58:32 GMT
From: pierre.doritch@caramail.com
To: linux-kernel@vger.kernel.org
Message-ID: <983967468007970@caramail.com>
X-Mailer: Caramail - www.caramail.com
X-Originating-IP: [192.70.119.2]
Mime-Version: 1.0
Subject: PROBLEM: crash with linux 2.4.2
Date: Wed, 07 Mar 2001 11:17:48 GMT+1
Content-Type: multipart/mixed; boundary="=_NextPart_Caramail_007970983967468_ID"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

--=_NextPart_Caramail_007970983967468_ID
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,

I ran 2.4.2 under heavy load since 2 days.
I try to decrypt my /etc/passwd files with the program John 
the Ripper on a Pentium133.
This process is very long ;-)

I don't understand the error. Hope it will be useful.

Pierre


you can see the load average and the uptime after crash:
10:09am up 5 days, 21:02, 2 users, load average: 18.68, 
18.07, 16.85



the output of dmesg command after crash :

5e58960 edx: 00000004
esi: c0268a74 edi: 00000001 ebp: 00000000 esp: 
c1945d28
ds: 0018 es: 0018 ss: 0018
Process fvwm95 (pid: 7630, stackpage=3Dc1945000)
Stack: c0225aa5 c0225c33 000000bf c0268a40 c0268cd4 
00000002 00000000 c0dda14f 
 00000286 00000000 c0268a40 c0128872 c0268ccc 
c0268cd8 00000000 00000000 
 000000b8 c01289bc c0268ccc 00000000 00000002 
00000001 00000000 c1945df8 
Call Trace: [<c0128872>] [<c01289bc>] [<c0121843>] 
[<c0121a6f>] [<c01219a8>] [<c01356c0>] [<c0135afd>] 
 [<c0135eca>] [<c010786f>] [<c0108e13>] 

Code: 0f 0b 83 c4 0c 90 8b 03 8b 53 04 89 50 04 89 02 89 d8 
2b 05 
kernel BUG at page_alloc.c:191!
invalid operand: 0000
CPU: 0
EIP: 0010:[<c01285ca>]
EFLAGS: 00010092
eax: 00000020 ebx: c1041c78 ecx: c5e58960 edx: 
00000005
esi: c0268a74 edi: 00000001 ebp: 00000000 esp: 
c1d97e08
ds: 0018 es: 0018 ss: 0018
Process sh (pid: 7631, stackpage=3Dc1d97000)
Stack: c0225aa5 c0225c33 000000bf c0268a40 c0268cd4 
00000002 00000000 000006ab 
 00000286 00000000 c0268a40 c0128872 c0268ccc 
c0268cd8 00000000 00000000 
 000000b8 c01289bc c0268ccc 00000000 00000002 
00000001 c11b2dd8 c51fa420 
Call Trace: [<c0128872>] [<c01289bc>] [<c0121f3c>] 
[<c011ee51>] [<c011efc0>] [<c010fa9b>] [<c010f944>] 
 [<c012039b>] [<c011f54f>] [<c0123c63>] [<c0123d0d>] 
[<c0108f54>] 

Code: 0f 0b 83 c4 0c 90 8b 03 8b 53 04 89 50 04 89 02 89 d8 
2b 05 
kernel BUG at page_alloc.c:191!
invalid operand: 0000
CPU: 0
EIP: 0010:[<c01285ca>]
EFLAGS: 00010086
eax: 00000020 ebx: c1041c78 ecx: c5e58960 edx: 
00000005
esi: c0268a74 edi: 00000001 ebp: 00000000 esp: 
c1d97e1c
ds: 0018 es: 0018 ss: 0018
Process sh (pid: 7632, stackpage=3Dc1d97000)
Stack: c0225aa5 c0225c33 000000bf c0268a40 c0268cd4 
00000002 00000000 c0268ccc 
 00000282 00000000 c0268a40 c0128872 c0268ccc 
c0268cd8 00000000 00000000 
 000000b8 c01289bc c0268ccc 00000000 00000002 
00000001 c0ec9be0 c5e58960 
Call Trace: [<c0128872>] [<c01289bc>] [<c011ed96>] 
[<c011ee30>] [<c011efc0>] [<c010fa9b>] [<c010f944>] 
 [<c011fad7>] [<c011fead>] [<c011fee6>] [<c0108f54>] 

Code: 0f 0b 83 c4 0c 90 8b 03 8b 53 04 89 50 04 89 02 89 d8 
2b 05 
kernel BUG at page_alloc.c:191!
invalid operand: 0000
CPU: 0
EIP: 0010:[<c01285ca>]
EFLAGS: 00010086
eax: 00000020 ebx: c1041c78 ecx: c5e58b40 edx: 
00000005
esi: c0268a74 edi: 00000001 ebp: 00000000 esp: 
c215fd40
ds: 0018 es: 0018 ss: 0018
Process gdmlogin (pid: 7658, stackpage=3Dc215f000)
Stack: c0225aa5 c0225c33 000000bf c0268a40 c0268cd4 
00000002 00000000 000004ae 
 00000286 00000000 c0268a40 c0128872 c0268ccc 
c0268cd8 00000000 00000000 
 000000b8 c01289bc c0268ccc 00000000 00000002 
00000001 c206ca60 c5e58b40 
Call Trace: [<c0128872>] [<c01289bc>] [<c014d268>] 
[<c011ed96>] [<c014d3a6>] [<c011ee30>] [<c011efc0>] 
 [<c010fa9b>] [<c010f944>] [<c0139ebb>] [<c0108f54>] 
[<c01219db>] [<c01219a8>] [<c012166a>] [<c0121a6f>] 
 [<c01219a8>] [<c012d48e>] [<c0108e13>] 

Code: 0f 0b 83 c4 0c 90 8b 03 8b 53 04 89 50 04 89 02 89 d8 
2b 05 
kernel BUG at page_alloc.c:191!
invalid operand: 0000
CPU: 0
EIP: 0010:[<c01285ca>]
EFLAGS: 00010086
eax: 00000020 ebx: c1041c78 ecx: c5e58b40 edx: 
00000005
esi: c0268a74 edi: 00000001 ebp: 00000000 esp: 
c19c3d40
ds: 0018 es: 0018 ss: 0018
Process gdmlogin (pid: 7662, stackpage=3Dc19c3000)
Stack: c0225aa5 c0225c33 000000bf c0268a40 c0268cd4 
00000002 00000000 000004ae 
 00000286 00000000 c0268a40 c0128872 c0268ccc 
c0268cd8 00000000 00000000 
 000000b8 c01289bc c0268ccc 00000000 00000002 
00000001 c0ec9f60 c5e58b40 
Call Trace: [<c0128872>] [<c01289bc>] [<c014d268>] 
[<c011ed96>] [<c014d3a6>] [<c011ee30>] [<c011efc0>] 
 [<c010fa9b>] [<c010f944>] [<c0139ebb>] [<c0108f54>] 
[<c01219db>] [<c01219a8>] [<c012166a>] [<c0121a6f>] 
 [<c01219a8>] [<c012d48e>] [<c0108e13>] 

Code: 0f 0b 83 c4 0c 90 8b 03 8b 53 04 89 50 04 89 02 89 d8 
2b 05 
kernel BUG at page_alloc.c:191!
invalid operand: 0000
CPU: 0
EIP: 0010:[<c01285ca>]
EFLAGS: 00010082
eax: 00000020 ebx: c1041c78 ecx: c5e58960 edx: 
00000007
esi: c0268a74 edi: 00000001 ebp: 00000000 esp: 
c19c3e3c
ds: 0018 es: 0018 ss: 0018
Process bash (pid: 7665, stackpage=3Dc19c3000)
Stack: c0225aa5 c0225c33 000000bf c0268a40 c0268cd4 
00000002 00000000 00000ff8 
 00000282 00000000 c0268a40 c0128872 c0268ccc 
c0268cd8 00000000 00000000 
 000000b8 c01289bc c0268ccc 00000000 00000002 
00000001 c10682dc c5e58960 
Call Trace: [<c0128872>] [<c01289bc>] [<c011e8a8>] 
[<c011effb>] [<c010fa9b>] [<c010f944>] [<c01121ef>] 
 [<c01077f4>] [<c0108f54>] 

Code: 0f 0b 83 c4 0c 90 8b 03 8b 53 04 89 50 04 89 02 89 d8 
2b 05 
kernel BUG at page_alloc.c:191!
invalid operand: 0000
CPU: 0
EIP: 0010:[<c01285ca>]
EFLAGS: 00010082
eax: 00000020 ebx: c1041c78 ecx: c5e58b40 edx: 
00000008
esi: c0268a74 edi: 00000001 ebp: 00000000 esp: 
c1943e3c
ds: 0018 es: 0018 ss: 0018
Process bash (pid: 7668, stackpage=3Dc1943000)
Stack: c0225aa5 c0225c33 000000bf c0268a40 c0268cd4 
00000002 00000000 00000ff8 
 00000282 00000000 c0268a40 c0128872 c0268ccc 
c0268cd8 00000000 00000000 
 000000b8 c01289bc c0268ccc 00000000 00000002 
00000001 c106c148 c5e58b40 
Call Trace: [<c0128872>] [<c01289bc>] [<c011e8a8>] 
[<c011effb>] [<c010fa9b>] [<c010f944>] [<c01075cf>] 
 [<c01121ef>] [<c01077f4>] [<c0108f54>] 

Code: 0f 0b 83 c4 0c 90 8b 03 8b 53 04 89 50 04 89 02 89 d8 
2b 05 
kernel BUG at page_alloc.c:191!
invalid operand: 0000
CPU: 0
EIP: 0010:[<c01285ca>]
EFLAGS: 00010082
eax: 00000020 ebx: c1041c78 ecx: c5e58b40 edx: 
00000007
esi: c0268a74 edi: 00000001 ebp: 00000000 esp: 
c0f97e3c
ds: 0018 es: 0018 ss: 0018
Process bash (pid: 7672, stackpage=3Dc0f97000)
Stack: c0225aa5 c0225c33 000000bf c0268a40 c0268cd4 
00000002 00000000 00000011 
 00000282 00000000 c0268a40 c0128872 c0268ccc 
c0268cd8 00000000 00000000 
 000000b8 c01289bc c0268ccc 00000000 00000002 
00000001 c10331ec c5e58b40 
Call Trace: [<c0128872>] [<c01289bc>] [<c011e8a8>] 
[<c011effb>] [<c010fa9b>] [<c010f944>] [<c0119e3c>] 
 [<c011ac45>] [<c0108f54>] 

Code: 0f 0b 83 c4 0c 90 8b 03 8b 53 04 89 50 04 89 02 89 d8 
2b 05 
kernel BUG at page_alloc.c:191!
invalid operand: 0000
CPU: 0
EIP: 0010:[<c01285ca>]
EFLAGS: 00010082
eax: 00000020 ebx: c1041c78 ecx: c5e58aa0 edx: 
00000007
esi: c0268a74 edi: 00000001 ebp: 00000000 esp: 
c1c17e3c
ds: 0018 es: 0018 ss: 0018
Process bash (pid: 7671, stackpage=3Dc1c17000)
Stack: c0225aa5 c0225c33 000000bf c0268a40 c0268cd4 
00000002 00000000 00000806 
 00000282 00000000 c0268a40 c0128872 c0268ccc 
c0268cd8 00000000 00000000 
 000000b8 c01289bc c0268ccc 00000000 00000002 
00000001 c1043df0 c5e58aa0 
Call Trace: [<c0128872>] [<c01289bc>] [<c011e8a8>] 
[<c011effb>] [<c010fa9b>] [<c010f944>] [<c01121ef>] 
 [<c01077f4>] [<c0108f54>] 

Code: 0f 0b 83 c4 0c 90 8b 03 8b 53 04 89 50 04 89 02 89 d8 
2b 05 
kernel BUG at page_alloc.c:191!
invalid operand: 0000
CPU: 0
EIP: 0010:[<c01285ca>]
EFLAGS: 00013096
eax: 00000020 ebx: c1041c78 ecx: c67519e0 edx: 
00000003
esi: c0268a74 edi: 00000001 ebp: 00000000 esp: 
c63cfe54
ds: 0018 es: 0018 ss: 0018
Process X (pid: 177, stackpage=3Dc63cf000)
Stack: c0225aa5 c0225c33 000000bf c0268a40 c0268cfc 
00000002 00000000 00000001 
 00003282 00000000 c0268a40 c0128872 c0268cf4 
c0268d00 00000000 00000000 
 000000b8 c01289bc c0268cf4 00000000 00000002 
00000001 00000000 c63cff58 
Call Trace: [<c0128872>] [<c01289bc>] [<c0128b7c>] 
[<c013b333>] [<c01ed7fb>] [<c01dadd7>] [<c013b57f>] 
 [<c013baa7>] [<c0108e13>] 

Code: 0f 0b 83 c4 0c 90 8b 03 8b 53 04 89 50 04 89 02 89 d8 
2b 05 

************************************************

output of /var/log/syslog after crash :

Mar 6 16:40:36 palerme gdm[95]: gdm_xdmcp_decode_packet: 
Unknown opcode from host 160.128.40.83
Mar 6 16:50:15 palerme gdm[95]: gdm_xdmcp_decode_packet: 
Unknown opcode from host 160.128.40.83
Mar 6 17:00:13 palerme kernel: Unable to handle kernel 
NULL pointer dereference at virtual address 00000000
Mar 6 17:00:13 palerme kernel: *pde =3D 00000000
Mar 6 17:02:32 palerme gdm[5663]: 
gdm_slave_windows_kill_ioerror_handler: Fatal X error - 
Restarting pc-ea-bdd.xxx:0
Mar 6 17:07:52 palerme gdm[95]: gdm_xdmcp_decode_packet: 
Unknown opcode from host 160.128.40.83
Mar 6 17:18:54 palerme gdm[95]: gdm_xdmcp_decode_packet: 
Unknown opcode from host 160.128.40.83
Mar 6 17:28:51 palerme gdm[6775]: 
gdm_slave_windows_kill_ioerror_handler: Fatal X error - 
Restarting pc-ea-bdd.xxx:0
Mar 7 04:40:25 palerme kernel: Unable to handle kernel 
paging request at virtual address 006f7575
Mar 7 04:40:25 palerme kernel: *pde =3D 00000000
Mar 7 09:50:34 palerme gdm[95]: gdm_xdmcp_decode_packet: 
Unknown opcode from host 160.128.40.83
Mar 7 09:54:38 palerme kernel: Unable to handle kernel 
paging request at virtual address 0000636c
Mar 7 09:54:38 palerme kernel: *pde =3D 00000000
Mar 7 09:54:43 palerme kernel: Unable to handle kernel 
paging request at virtual address 0000636c
Mar 7 09:54:43 palerme kernel: *pde =3D 00000000
Mar 7 09:54:49 palerme kernel: Unable to handle kernel 
paging request at virtual address 0000636c
Mar 7 09:54:49 palerme kernel: *pde =3D 00000000
Mar 7 09:54:57 palerme kernel: Unable to handle kernel 
paging request at virtual address 0000636c
Mar 7 09:54:57 palerme kernel: *pde =3D 00000000
Mar 7 09:55:01 palerme kernel: Unable to handle kernel 
paging request at virtual address 0000636c
Mar 7 09:55:01 palerme kernel: *pde =3D 00000000
Mar 7 09:55:09 palerme kernel: Unable to handle kernel 
paging request at virtual address 0000636c
Mar 7 09:55:09 palerme kernel: *pde =3D 00000000



here's the output of script/ver_linux :

Linux palerme 2.4.2 #2 Thu Feb 22 10:28:00 CET 2001 i586 
unknown
Kernel modules 2.4.1
Gnu C egcs-2.91.66
Gnu Make 3.79
Binutils 2.9.1.0.25
Linux C Library 2.1.3
Dynamic linker ldd: version 1.9.9
Procps 2.0.6
Mount 2.10l
Net-tools 1.57
Kbd 0.99
Sh-utils 2.0
Modules Loaded 



All the next output are taken after the reboot of the 
system!


/proc/cpuinfo

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 5
model		: 2
model name	: Pentium 75 - 200
stepping	: 11
cpu MHz		: 132.959
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: yes
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr mce cx8 apic
bogomips	: 264.60



/proc/modules
nothing


/proc/ioports

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
02f8-02ff : serial(auto)
03c0-03df : vga+
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
f880-f8ff : Digital Equipment Corporation DECchip 21140 
[FasterNet]
 f880-f8ff : eth0
fc00-fcff : Adaptec AHA-294x / AIC-7870
 fc00-fcfe : aic7xxx
 
 

/proc/iomem

00000000-0009fbff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000ca7ff : Extension ROM
000f0000-000fffff : System ROM
00100000-067fffff : System RAM
 00100000-0021ccb9 : Kernel code
 0021ccba-0027c423 : Kernel data
10000000-100003ff : PCI device 8086:0008 (Intel Corporation)
10000400-100007ff : PCI device 8086:0008 (Intel Corporation)
10000800-10000bff : PCI device 8086:0008 (Intel Corporation)
10000c00-10000fff : PCI device 8086:0008 (Intel Corporation)
10001000-100013ff : PCI device 8086:0008 (Intel Corporation)
fd000000-fdffffff : Cirrus Logic GD 5430/40 [Alpine]
fec00000-fec003ff : reserved
fee00000-fee00fff : reserved
fff7e800-fff7ebff : PCI device 8086:0008 (Intel Corporation)
fff7ec00-fff7ec7f : Digital Equipment Corporation DECchip 
21140 [FasterNet]
 fff7ec00-fff7ec7f : eth0
fff7f000-fff7ffff : Adaptec AHA-294x / AIC-7870
fff80000-ffffffff : reserved


lspci -vvv

00:00.0 Host bridge: Intel Corporation 82434LX 
[Mercury/Neptune] (rev 11)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- 
VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr+ 
DEVSEL=3Dslow >TAbort- <TAbort- <MAbort+ >SERR+ <PERR+
	Latency: 64

00:02.0 Non-VGA unclassified device: Intel Corporation 
82375EB (rev 05)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- 
VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- 
DEVSEL=3Dmedium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 24

00:09.0 VGA compatible controller: Cirrus Logic GD 5430/40 
[Alpine] (rev 4c) (prog-if 00 [VGA])
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- 
VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- 
DEVSEL=3Dfast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at fd000000 (32-bit, prefetchable) 
[size=3D16M]
	Expansion ROM at <unassigned> [disabled] [size=3D16M]

00:0b.0 SCSI storage controller: Adaptec AHA-294x / AIC-
7870 (rev 03)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- 
VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- 
DEVSEL=3Dmedium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 64 (2000ns min, 2000ns max), cache line 
size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at fc00 [size=3D256]
	Region 1: Memory at fff7f000 (32-bit, non-
prefetchable) [size=3D4K]
	Expansion ROM at <unassigned> [disabled] [size=3D64K]

00:0d.0 Ethernet controller: Digital Equipment Corporation 
DECchip 21140 [FasterNet] (rev 12)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- 
VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- 
DEVSEL=3Dmedium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 66
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at f880 [size=3D128]
	Region 1: Memory at fff7ec00 (32-bit, non-
prefetchable) [size=3D128]

00:0e.0 Class ff00: Intel Corporation: Unknown device 0008
	Subsystem: Unknown device e808:fff7
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- 
VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- 
DEVSEL=3Dfast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Region 0: Memory at fff7e800 (32-bit, prefetchable) 
[size=3D1K]
	Region 1: Memory at 10000000 (32-bit, prefetchable) 
[size=3D1K]
	Region 2: Memory at 10000400 (32-bit, prefetchable) 
[size=3D1K]
	Region 3: Memory at 10000800 (32-bit, prefetchable) 
[size=3D1K]
	Region 4: Memory at 10000c00 (32-bit, prefetchable) 
[size=3D1K]
	Region 5: Memory at 10001000 (32-bit, prefetchable) 
[size=3D1K]
	Expansion ROM at fffff800 [disabled] [size=3D2K]


/proc/scsi/scsi

Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
 Vendor: IBM OEM Model: DFHSS2F Rev: 1818
 Type: Direct-Access ANSI SCSI 
revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
 Vendor: IBM OEM Model: DFHSS2F Rev: 1818
 Type: Direct-Access ANSI SCSI 
revision: 02
Host: scsi0 Channel: 00 Id: 04 Lun: 00
 Vendor: TOSHIBA Model: CD-ROM XM-5301TA Rev: 2365
 Type: CD-ROM ANSI SCSI 
revision: 02
Host: scsi0 Channel: 00 Id: 06 Lun: 00
 Vendor: TANDBERG Model: TDC 3800 Rev: =3D04:
 Type: Sequential-Access ANSI SCSI 
revision: 02

_________________________________________________________
Le journal des abonn=E9s Caramail - http://www.carazine.com


--=_NextPart_Caramail_007970983967468_ID--

