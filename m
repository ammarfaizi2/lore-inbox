Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262037AbTFOJOj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 05:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261182AbTFOJOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 05:14:39 -0400
Received: from dsl-62-3-122-163.zen.co.uk ([62.3.122.163]:15232 "EHLO
	tor.trudheim.com") by vger.kernel.org with ESMTP id S262037AbTFOJNx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 05:13:53 -0400
Subject: Oopses, 2.4.21rc7ac1 with cpufreq update
From: Anders Karlsson <anders@trudheim.com>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ovbssCxiyVioKVYQXDv9"
Organization: Trudheim Technology Limited
Message-Id: <1055669261.2283.6.camel@tor.trudheim.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 Rubber Turnip www.usr-local-bin.org 
Date: 15 Jun 2003 10:27:41 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ovbssCxiyVioKVYQXDv9
Content-Type: multipart/mixed; boundary="=-m9YzwQXdD9A+G10tDT8D"


--=-m9YzwQXdD9A+G10tDT8D
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

Machine is a IBM Thinkpad X31 running SuSE 8.2 Professional. Please find
attached output from lspci, ver_linux, the actual oopses and the oopses
decoded with ksymoops as well as the kernel configuration.

Machine was logged in to Gnome 2.2, left with XLock running overnight,
and had two oopses, one rxvt and one syslogd. Machine was still running,
but was having severe problems. Running commands as root via sudo would
not work, and a reboot would just hang and not do anything. After
reboot, all seems okay. I have all the latest updates available from
SuSE for the installed packages.

If there is any other information that would help debugging this, let me
know and I'll get it. Contact me off list for that though.

Regards,

--=20
Anders Karlsson <anders@trudheim.com>
Trudheim Technology Limited

--=-m9YzwQXdD9A+G10tDT8D
Content-Disposition: attachment; filename=lspci.txt
Content-Type: text/plain; name=lspci.txt; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

00:00.0 Host bridge: Intel Corp.: Unknown device 3340 (rev 03)
	Subsystem: IBM: Unknown device 0529
	Flags: bus master, fast devsel, latency 0
	Memory at d0000000 (32-bit, prefetchable) [size=3D256M]
	Capabilities: [e4] #09 [f104]
	Capabilities: [a0] AGP version 2.0

00:01.0 PCI bridge: Intel Corp.: Unknown device 3341 (rev 03) (prog-if 00 [=
Normal decode])
	Flags: bus master, 66Mhz, fast devsel, latency 96
	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D64
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: c0100000-c01fffff
	Prefetchable memory behind bridge: e0000000-e7ffffff

00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 01) (prog-if =
00 [UHCI])
	Subsystem: IBM: Unknown device 052d
	Flags: bus master, medium devsel, latency 0, IRQ 11
	I/O ports at 1800 [size=3D32]

00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 01) (prog-if =
00 [UHCI])
	Subsystem: IBM: Unknown device 052d
	Flags: bus master, medium devsel, latency 0, IRQ 11
	I/O ports at 1820 [size=3D32]

00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 01) (prog-if =
00 [UHCI])
	Subsystem: IBM: Unknown device 052d
	Flags: bus master, medium devsel, latency 0, IRQ 11
	I/O ports at 1840 [size=3D32]

00:1d.7 USB Controller: Intel Corp. 82801DB USB EHCI Controller (rev 01) (p=
rog-if 20 [EHCI])
	Subsystem: IBM: Unknown device 052e
	Flags: bus master, medium devsel, latency 0, IRQ 11
	Memory at c0000000 (32-bit, non-prefetchable) [size=3D1K]
	Capabilities: [50] Power Management version 2
	Capabilities: [58] #0a [2080]

00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 81) (prog-if 0=
0 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=3D00, secondary=3D02, subordinate=3D08, sec-latency=3D64
	I/O behind bridge: 00004000-00008fff
	Memory behind bridge: c0200000-cfffffff
	Prefetchable memory behind bridge: e8000000-efffffff

00:1f.0 ISA bridge: Intel Corp.: Unknown device 24cc (rev 01)
	Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corp.: Unknown device 24ca (rev 01) (prog-if 8=
a [Master SecP PriP])
	Subsystem: IBM: Unknown device 052d
	Flags: bus master, medium devsel, latency 0, IRQ 11
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at 1860 [size=3D16]
	Memory at 30000000 (32-bit, non-prefetchable) [size=3D1K]

00:1f.3 SMBus: Intel Corp. 82801DB SMBus (rev 01)
	Subsystem: IBM: Unknown device 052d
	Flags: medium devsel, IRQ 5
	I/O ports at 1880 [size=3D32]

00:1f.5 Multimedia audio controller: Intel Corp. 82801DB AC'97 Audio (rev 0=
1)
	Subsystem: IBM: Unknown device 0534
	Flags: bus master, medium devsel, latency 0, IRQ 5
	I/O ports at 1c00 [size=3D256]
	I/O ports at 18c0 [size=3D64]
	Memory at c0000c00 (32-bit, non-prefetchable) [size=3D512]
	Memory at c0000800 (32-bit, non-prefetchable) [size=3D256]
	Capabilities: [50] Power Management version 2

00:1f.6 Modem: Intel Corp. 82801DB AC'97 Modem (rev 01) (prog-if 00 [Generi=
c])
	Subsystem: IBM: Unknown device 0525
	Flags: bus master, medium devsel, latency 0, IRQ 5
	I/O ports at 2400 [size=3D256]
	I/O ports at 2000 [size=3D128]
	Capabilities: [50] Power Management version 2

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M6 =
LY (prog-if 00 [VGA])
	Subsystem: IBM: Unknown device 052f
	Flags: bus master, stepping, fast Back2Back, 66Mhz, medium devsel, latency=
 66, IRQ 11
	Memory at e0000000 (32-bit, prefetchable) [size=3D128M]
	I/O ports at 3000 [size=3D256]
	Memory at c0100000 (32-bit, non-prefetchable) [size=3D64K]
	Expansion ROM at <unassigned> [disabled] [size=3D128K]
	Capabilities: [58] AGP version 2.0
	Capabilities: [50] Power Management version 2

02:00.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev aa)
	Subsystem: IBM: Unknown device 0532
	Flags: bus master, medium devsel, latency 168, IRQ 11
	Memory at 50000000 (32-bit, non-prefetchable) [size=3D4K]
	Bus: primary=3D02, secondary=3D03, subordinate=3D05, sec-latency=3D176
	Memory window 0: 30400000-307ff000 (prefetchable)
	Memory window 1: 30800000-30bff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	16-bit legacy interface ports at 0001

02:00.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev aa)
	Subsystem: IBM: Unknown device 0532
	Flags: bus master, medium devsel, latency 168, IRQ 5
	Memory at 50100000 (32-bit, non-prefetchable) [size=3D4K]
	Bus: primary=3D02, secondary=3D06, subordinate=3D08, sec-latency=3D176
	Memory window 0: 30c00000-30fff000 (prefetchable)
	Memory window 1: 31000000-313ff000
	I/O window 0: 00004800-000048ff
	I/O window 1: 00004c00-00004cff
	16-bit legacy interface ports at 0001

02:00.2 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394 Controller (rev=
 02) (prog-if 10 [OHCI])
	Subsystem: IBM: Unknown device 0533
	Flags: bus master, medium devsel, latency 64, IRQ 11
	Memory at c0202000 (32-bit, non-prefetchable) [size=3D2K]
	Capabilities: [dc] Power Management version 2

02:02.0 Network controller: Intel Corp.: Unknown device 1043 (rev 04)
	Subsystem: Intel Corp.: Unknown device 2551
	Flags: bus master, medium devsel, latency 64, IRQ 11
	Memory at c0200000 (32-bit, non-prefetchable) [size=3D4K]
	Capabilities: [dc] Power Management version 2

02:08.0 Ethernet controller: Intel Corp. 82801BD PRO/100 VE (MOB) Ethernet =
Controller (rev 81)
	Subsystem: IBM: Unknown device 0522
	Flags: bus master, medium devsel, latency 66, IRQ 11
	Memory at c0201000 (32-bit, non-prefetchable) [size=3D4K]
	I/O ports at 8000 [size=3D64]
	Capabilities: [dc] Power Management version 2


--=-m9YzwQXdD9A+G10tDT8D
Content-Disposition: attachment; filename=oops.txt
Content-Type: text/plain; name=oops.txt; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Unable to handle kernel NULL pointer dereference at virtual address 0000000=
0
 printing eip:
c010f332
*pde =3D 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c010f332>]    Not tainted
EFLAGS: 00010046
eax: 00000000   ebx: cd700270   ecx: 00000000   edx: e1040000
esi: e1040270   edi: cd700000   ebp: e1041f0c   esp: cd701e9c
ds: 0018   es: 0018   ss: 0018
Process rxvt (pid: 8935, stackpage=3Dcd701000)
Stack: c010761a e1040000 c02f3fd4 000001ff cd700000 eaf0f480 e1040000 c011b=
124=20
       cd701ee0 cd700000 dc5a3080 00000000 cff3cf80 00200296 0138c27b cd701=
ef4=20
       cff3c680 00000010 c0126e22 cd701ef4 c01bc4f4 de182000 00000000 00000=
000=20
Call Trace:    [<c010761a>] [<c011b124>] [<c0126e22>] [<c01bc4f4>] [<c0126d=
c2>]
  [<c015008e>] [<c01503db>] [<c0108d87>]

Code: dd 00 b0 02 00 00 9b eb e6 00 00 e0 ff ff 21 e2 8b 00 04 f7=20
 <1>Unable to handle kernel NULL pointer dereference at virtual address 000=
00000
 printing eip:
c010f332
*pde =3D 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c010f332>]    Not tainted
EFLAGS: 00010046
eax: 00000000   ebx: ed692270   ecx: 00000000   edx: e1040000
esi: e1040270   edi: ed692000   ebp: e1041f0c   esp: ed693e9c
ds: 0018   es: 0018   ss: 0018
Process syslogd (pid: 519, stackpage=3Ded693000)
Stack: c010761a e1040000 c02f3fd4 000001ff ed692000 eaf0f480 e1040000 c011b=
124=20
       ed693ee0 ed692000 efe3ca80 00000000 ef0be700 ed693f3c 00000000 7ffff=
fff=20
       ecf7cb00 00020000 c0126e6c ef179100 ed693f3c c0234b4c ecf7cb00 ecdec=
1b0=20
Call Trace:    [<c010761a>] [<c011b124>] [<c0126e6c>] [<c0234b4c>] [<c022ee=
00>]
  [<c015008e>] [<c01503db>] [<c0121ff3>] [<c0108d87>]

Code: dd 00 b0 02 00 00 9b eb e6 00 00 e0 ff ff 21 e2 8b 00 04 f7=20
=20


--=-m9YzwQXdD9A+G10tDT8D
Content-Disposition: attachment; filename=oops_decoded.txt
Content-Type: text/plain; name=oops_decoded.txt; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

ksymoops 2.4.8 on i686 2.4.21-rc7-ac1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21-rc7-ac1/ (default)
     -m /boot/System.map-2.4.21-rc7-ac1 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel NULL pointer dereference at virtual address 0000000=
0
c010f332
*pde =3D 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c010f332>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010046
eax: 00000000   ebx: cd700270   ecx: 00000000   edx: e1040000
esi: e1040270   edi: cd700000   ebp: e1041f0c   esp: cd701e9c
ds: 0018   es: 0018   ss: 0018
Process rxvt (pid: 8935, stackpage=3Dcd701000)
Stack: c010761a e1040000 c02f3fd4 000001ff cd700000 eaf0f480 e1040000 c011b=
124=20
       cd701ee0 cd700000 dc5a3080 00000000 cff3cf80 00200296 0138c27b cd701=
ef4=20
       cff3c680 00000010 c0126e22 cd701ef4 c01bc4f4 de182000 00000000 00000=
000=20
Call Trace:    [<c010761a>] [<c011b124>] [<c0126e22>] [<c01bc4f4>] [<c0126d=
c2>]
  [<c015008e>] [<c01503db>] [<c0108d87>]
Code: dd 00 b0 02 00 00 9b eb e6 00 00 e0 ff ff 21 e2 8b 00 04 f7=20


>>EIP; c010f332 <save_init_fpu+2a/33>   <=3D=3D=3D=3D=3D

>>ebx; cd700270 <_end+d357fac/3146ad9c>
>>edx; e1040000 <_end+20c97d3c/3146ad9c>
>>esi; e1040270 <_end+20c97fac/3146ad9c>
>>edi; cd700000 <_end+d357d3c/3146ad9c>
>>ebp; e1041f0c <_end+20c99c48/3146ad9c>
>>esp; cd701e9c <_end+d359bd8/3146ad9c>

Trace; c010761a <__switch_to+c8/fe>
Trace; c011b124 <schedule+b9/294>
Trace; c0126e22 <schedule_timeout+57/a3>
Trace; c01bc4f4 <normal_poll+160/17a>
Trace; c0126dc2 <process_timeout+0/9>
Trace; c015008e <do_select+1bf/212>
Trace; c01503db <sys_select+2d5/4d4>
Trace; c0108d87 <system_call+33/38>

Code;  c010f332 <save_init_fpu+2a/33>
00000000 <_EIP>:
Code;  c010f332 <save_init_fpu+2a/33>   <=3D=3D=3D=3D=3D
   0:   dd 00                     fldl   (%eax)   <=3D=3D=3D=3D=3D
Code;  c010f334 <save_init_fpu+2c/33>
   2:   b0 02                     mov    $0x2,%al
Code;  c010f336 <save_init_fpu+2e/33>
   4:   00 00                     add    %al,(%eax)
Code;  c010f338 <save_init_fpu+30/33>
   6:   9b                        fwait
Code;  c010f339 <save_init_fpu+31/33>
   7:   eb e6                     jmp    ffffffef <_EIP+0xffffffef>
Code;  c010f33b <kernel_fpu_begin+0/45>
   9:   00 00                     add    %al,(%eax)
Code;  c010f33d <kernel_fpu_begin+2/45>
   b:   e0 ff                     loopne c <_EIP+0xc>
Code;  c010f33f <kernel_fpu_begin+4/45>
   d:   ff 21                     jmp    *(%ecx)
Code;  c010f341 <kernel_fpu_begin+6/45>
   f:   e2 8b                     loop   ffffff9c <_EIP+0xffffff9c>
Code;  c010f343 <kernel_fpu_begin+8/45>
  11:   00 04 f7                  add    %al,(%edi,%esi,8)

 <1>Unable to handle kernel NULL pointer dereference at virtual address 000=
00000
c010f332
*pde =3D 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c010f332>]    Not tainted
EFLAGS: 00010046
eax: 00000000   ebx: ed692270   ecx: 00000000   edx: e1040000
esi: e1040270   edi: ed692000   ebp: e1041f0c   esp: ed693e9c
ds: 0018   es: 0018   ss: 0018
Process syslogd (pid: 519, stackpage=3Ded693000)
Stack: c010761a e1040000 c02f3fd4 000001ff ed692000 eaf0f480 e1040000 c011b=
124=20
       ed693ee0 ed692000 efe3ca80 00000000 ef0be700 ed693f3c 00000000 7ffff=
fff=20
       ecf7cb00 00020000 c0126e6c ef179100 ed693f3c c0234b4c ecf7cb00 ecdec=
1b0=20
Call Trace:    [<c010761a>] [<c011b124>] [<c0126e6c>] [<c0234b4c>] [<c022ee=
00>]
  [<c015008e>] [<c01503db>] [<c0121ff3>] [<c0108d87>]
Code: dd 00 b0 02 00 00 9b eb e6 00 00 e0 ff ff 21 e2 8b 00 04 f7=20


>>EIP; c010f332 <save_init_fpu+2a/33>   <=3D=3D=3D=3D=3D

>>ebx; ed692270 <_end+2d2e9fac/3146ad9c>
>>edx; e1040000 <_end+20c97d3c/3146ad9c>
>>esi; e1040270 <_end+20c97fac/3146ad9c>
>>edi; ed692000 <_end+2d2e9d3c/3146ad9c>
>>ebp; e1041f0c <_end+20c99c48/3146ad9c>
>>esp; ed693e9c <_end+2d2ebbd8/3146ad9c>

Trace; c010761a <__switch_to+c8/fe>
Trace; c011b124 <schedule+b9/294>
Trace; c0126e6c <schedule_timeout+a1/a3>
Trace; c0234b4c <datagram_poll+e5/ed>
Trace; c022ee00 <sock_poll+29/2e>
Trace; c015008e <do_select+1bf/212>
Trace; c01503db <sys_select+2d5/4d4>
Trace; c0121ff3 <do_setitimer+f2/113>
Trace; c0108d87 <system_call+33/38>

Code;  c010f332 <save_init_fpu+2a/33>
00000000 <_EIP>:
Code;  c010f332 <save_init_fpu+2a/33>   <=3D=3D=3D=3D=3D
   0:   dd 00                     fldl   (%eax)   <=3D=3D=3D=3D=3D
Code;  c010f334 <save_init_fpu+2c/33>
   2:   b0 02                     mov    $0x2,%al
Code;  c010f336 <save_init_fpu+2e/33>
   4:   00 00                     add    %al,(%eax)
Code;  c010f338 <save_init_fpu+30/33>
   6:   9b                        fwait
Code;  c010f339 <save_init_fpu+31/33>
   7:   eb e6                     jmp    ffffffef <_EIP+0xffffffef>
Code;  c010f33b <kernel_fpu_begin+0/45>
   9:   00 00                     add    %al,(%eax)
Code;  c010f33d <kernel_fpu_begin+2/45>
   b:   e0 ff                     loopne c <_EIP+0xc>
Code;  c010f33f <kernel_fpu_begin+4/45>
   d:   ff 21                     jmp    *(%ecx)
Code;  c010f341 <kernel_fpu_begin+6/45>
   f:   e2 8b                     loop   ffffff9c <_EIP+0xffffff9c>
Code;  c010f343 <kernel_fpu_begin+8/45>
  11:   00 04 f7                  add    %al,(%edi,%esi,8)


1 warning issued.  Results may not be reliable.

--=-m9YzwQXdD9A+G10tDT8D
Content-Disposition: attachment; filename=ver_linux.txt
Content-Type: text/plain; name=ver_linux.txt; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
=20
Linux tor 2.4.21-rc7-ac1 #2 Thu Jun 12 21:57:29 BST 2003 i686 unknown unkno=
wn GNU/Linux
=20
Gnu C                  3.3
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
modutils               2.4.22
e2fsprogs              1.28
jfsutils               1.1.1
pcmcia-cs              3.2.3
PPP                    2.4.1
Linux C Library        13 23:33 /lib/libc.so.6
Dynamic linker (ldd)   2.3.2
Linux C++ Library      5.0.4
Procps                 3.1.6
Net-tools              1.60
Kbd                    1.06
Sh-utils               4.5.8
Modules Loaded         snd-mixer-oss ipt_MASQUERADE ipt_multiport ipt_LOG i=
pt_state iptable_filter ip_nat_irc ip_conntrack_irc ip_nat_ftp iptable_nat =
ip_tables ip_conntrack_ftp ip_conntrack radeon agpgart usbserial keybdev hi=
d printer snd-intel8x0 snd-pcm snd-timer snd-ac97-codec snd-page-alloc snd-=
mpu401-uart snd-rawmidi snd-seq-device snd soundcore ipv6 ds yenta_socket p=
cmcia_core rfcomm af_packet l2cap bluez st sr_mod sg mousedev joydev evdev =
input usb-uhci ehci-hcd usbcore raw1394 ohci1394 ieee1394 e100 ide-scsi ide=
-cd cdrom ext3 jbd loop reiserfs

--=-m9YzwQXdD9A+G10tDT8D
Content-Disposition: attachment; filename=.config
Content-Type: text/plain; name=.config; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

#
# Automatically generated by make menuconfig: don't edit
#
CONFIG_X86=3Dy
# CONFIG_SBUS is not set
CONFIG_UID16=3Dy

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=3Dy

#
# Loadable module support
#
CONFIG_MODULES=3Dy
CONFIG_MODVERSIONS=3Dy
CONFIG_KMOD=3Dy

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMIII is not set
CONFIG_MPENTIUM4=3Dy
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
CONFIG_X86_WP_WORKS_OK=3Dy
CONFIG_X86_INVLPG=3Dy
CONFIG_X86_CMPXCHG=3Dy
CONFIG_X86_XADD=3Dy
CONFIG_X86_BSWAP=3Dy
CONFIG_X86_POPAD_OK=3Dy
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy
CONFIG_X86_L1_CACHE_SHIFT=3D7
CONFIG_X86_HAS_TSC=3Dy
CONFIG_X86_GOOD_APIC=3Dy
CONFIG_X86_PGE=3Dy
CONFIG_X86_USE_PPRO_CHECKSUM=3Dy
CONFIG_X86_F00F_WORKS_OK=3Dy
CONFIG_X86_MCE=3Dy

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=3Dy
CONFIG_CPU_FREQ_TABLE=3Dy
CONFIG_CPU_FREQ_PROC_INTF=3Dy
CONFIG_CPU_FREQ_GOV_USERSPACE=3Dy
CONFIG_CPU_FREQ_24_API=3Dy
# CONFIG_X86_POWERNOW_K6 is not set
# CONFIG_X86_POWERNOW_K7 is not set
# CONFIG_X86_LONGHAUL is not set
# CONFIG_X86_SPEEDSTEP is not set
# CONFIG_X86_P4_CLOCKMOD is not set
# CONFIG_X86_LONGRUN is not set
# CONFIG_X86_GX_SUSPMOD is not set
CONFIG_X86_ENHANCED_SPEEDSTEP=3Dy
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
CONFIG_MICROCODE=3Dy
CONFIG_X86_MSR=3Dy
CONFIG_X86_CPUID=3Dm
# CONFIG_EDD is not set
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=3Dy
# CONFIG_HIGHMEM64G is not set
CONFIG_HIGHMEM=3Dy
CONFIG_HIGHIO=3Dy
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=3Dy
# CONFIG_SMP is not set
CONFIG_X86_UP_APIC=3Dy
CONFIG_X86_UP_IOAPIC=3Dy
CONFIG_X86_LOCAL_APIC=3Dy
CONFIG_X86_IO_APIC=3Dy
# CONFIG_X86_TSC_DISABLE is not set
CONFIG_X86_TSC=3Dy

#
# General setup
#
CONFIG_NET=3Dy
CONFIG_PCI=3Dy
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=3Dy
CONFIG_PCI_BIOS=3Dy
CONFIG_PCI_DIRECT=3Dy
CONFIG_ISA=3Dy
# CONFIG_SCx200 is not set
CONFIG_PCI_NAMES=3Dy
# CONFIG_EISA is not set
# CONFIG_MCA is not set
CONFIG_HOTPLUG=3Dy

#
# PCMCIA/CardBus support
#
CONFIG_PCMCIA=3Dm
CONFIG_CARDBUS=3Dy
CONFIG_TCIC=3Dy
CONFIG_I82092=3Dy
CONFIG_I82365=3Dy

#
# PCI Hotplug Support
#
CONFIG_HOTPLUG_PCI=3Dy
# CONFIG_HOTPLUG_PCI_ACPI is not set
# CONFIG_HOTPLUG_PCI_COMPAQ is not set
# CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM is not set
CONFIG_HOTPLUG_PCI_IBM=3Dy
# CONFIG_HOTPLUG_PCI_H2999 is not set
CONFIG_SYSVIPC=3Dy
CONFIG_BSD_PROCESS_ACCT=3Dy
CONFIG_SYSCTL=3Dy
CONFIG_KCORE_ELF=3Dy
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=3Dm
CONFIG_BINFMT_ELF=3Dy
CONFIG_BINFMT_MISC=3Dm
CONFIG_IKCONFIG=3Dy
CONFIG_PM=3Dy
CONFIG_APM=3Dy
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
CONFIG_APM_DO_ENABLE=3Dy
# CONFIG_APM_CPU_IDLE is not set
# CONFIG_APM_DISPLAY_BLANK is not set
CONFIG_APM_RTC_IS_GMT=3Dy
CONFIG_APM_ALLOW_INTS=3Dy
CONFIG_APM_REAL_MODE_POWER_OFF=3Dy

#
# ACPI Support
#
CONFIG_ACPI=3Dy
# CONFIG_ACPI_HT_ONLY is not set
CONFIG_ACPI_BOOT=3Dy
CONFIG_ACPI_BUS=3Dy
CONFIG_ACPI_INTERPRETER=3Dy
CONFIG_ACPI_EC=3Dy
CONFIG_ACPI_POWER=3Dy
CONFIG_ACPI_PCI=3Dy
CONFIG_ACPI_SLEEP=3Dy
CONFIG_ACPI_SYSTEM=3Dy
CONFIG_ACPI_AC=3Dy
CONFIG_ACPI_BATTERY=3Dy
CONFIG_ACPI_BUTTON=3Dy
CONFIG_ACPI_FAN=3Dy
CONFIG_ACPI_PROCESSOR=3Dy
CONFIG_ACPI_THERMAL=3Dy
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_RELAXED_AML=3Dy

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play configuration
#
CONFIG_PNP=3Dy
CONFIG_ISAPNP=3Dy
CONFIG_PNPBIOS=3Dy

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_CISS_SCSI_TAPE is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=3Dm
CONFIG_BLK_DEV_NBD=3Dm
CONFIG_BLK_DEV_RAM=3Dy
CONFIG_BLK_DEV_RAM_SIZE=3D64000
CONFIG_BLK_DEV_INITRD=3Dy
CONFIG_BLK_STATS=3Dy

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=3Dy
CONFIG_BLK_DEV_MD=3Dy
CONFIG_MD_LINEAR=3Dm
CONFIG_MD_RAID0=3Dm
CONFIG_MD_RAID1=3Dm
CONFIG_MD_RAID5=3Dm
CONFIG_MD_MULTIPATH=3Dm
CONFIG_BLK_DEV_LVM=3Dy
CONFIG_BLK_DEV_DM=3Dm

#
# Networking options
#
CONFIG_PACKET=3Dm
CONFIG_PACKET_MMAP=3Dy
CONFIG_NETLINK_DEV=3Dm
CONFIG_NETFILTER=3Dy
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_FILTER=3Dy
CONFIG_UNIX=3Dy
CONFIG_INET=3Dy
CONFIG_IP_MULTICAST=3Dy
CONFIG_IP_ADVANCED_ROUTER=3Dy
CONFIG_IP_MULTIPLE_TABLES=3Dy
CONFIG_IP_ROUTE_FWMARK=3Dy
CONFIG_IP_ROUTE_NAT=3Dy
CONFIG_IP_ROUTE_MULTIPATH=3Dy
CONFIG_IP_ROUTE_TOS=3Dy
CONFIG_IP_ROUTE_VERBOSE=3Dy
CONFIG_IP_ROUTE_LARGE_TABLES=3Dy
CONFIG_IP_PNP=3Dy
CONFIG_IP_PNP_DHCP=3Dy
CONFIG_IP_PNP_BOOTP=3Dy
CONFIG_IP_PNP_RARP=3Dy
CONFIG_NET_IPIP=3Dm
CONFIG_NET_IPGRE=3Dm
CONFIG_NET_IPGRE_BROADCAST=3Dy
CONFIG_IP_MROUTE=3Dy
CONFIG_IP_PIMSM_V1=3Dy
CONFIG_IP_PIMSM_V2=3Dy
# CONFIG_ARPD is not set
CONFIG_INET_ECN=3Dy
CONFIG_SYN_COOKIES=3Dy

#
#   IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=3Dm
CONFIG_IP_NF_FTP=3Dm
CONFIG_IP_NF_AMANDA=3Dm
CONFIG_IP_NF_TFTP=3Dm
CONFIG_IP_NF_IRC=3Dm
CONFIG_IP_NF_QUEUE=3Dm
CONFIG_IP_NF_IPTABLES=3Dm
CONFIG_IP_NF_MATCH_LIMIT=3Dm
CONFIG_IP_NF_MATCH_MAC=3Dm
CONFIG_IP_NF_MATCH_PKTTYPE=3Dm
CONFIG_IP_NF_MATCH_MARK=3Dm
CONFIG_IP_NF_MATCH_MULTIPORT=3Dm
CONFIG_IP_NF_MATCH_TOS=3Dm
CONFIG_IP_NF_MATCH_ECN=3Dm
CONFIG_IP_NF_MATCH_DSCP=3Dm
CONFIG_IP_NF_MATCH_AH_ESP=3Dm
CONFIG_IP_NF_MATCH_LENGTH=3Dm
CONFIG_IP_NF_MATCH_TTL=3Dm
CONFIG_IP_NF_MATCH_TCPMSS=3Dm
CONFIG_IP_NF_MATCH_HELPER=3Dm
CONFIG_IP_NF_MATCH_STATE=3Dm
CONFIG_IP_NF_MATCH_CONNTRACK=3Dm
CONFIG_IP_NF_MATCH_UNCLEAN=3Dm
CONFIG_IP_NF_MATCH_OWNER=3Dm
CONFIG_IP_NF_FILTER=3Dm
CONFIG_IP_NF_TARGET_REJECT=3Dm
CONFIG_IP_NF_TARGET_MIRROR=3Dm
CONFIG_IP_NF_NAT=3Dm
CONFIG_IP_NF_NAT_NEEDED=3Dy
CONFIG_IP_NF_TARGET_MASQUERADE=3Dm
CONFIG_IP_NF_TARGET_REDIRECT=3Dm
CONFIG_IP_NF_NAT_AMANDA=3Dm
# CONFIG_IP_NF_NAT_LOCAL is not set
CONFIG_IP_NF_NAT_SNMP_BASIC=3Dm
CONFIG_IP_NF_NAT_IRC=3Dm
CONFIG_IP_NF_NAT_FTP=3Dm
CONFIG_IP_NF_NAT_TFTP=3Dm
CONFIG_IP_NF_MANGLE=3Dm
CONFIG_IP_NF_TARGET_TOS=3Dm
CONFIG_IP_NF_TARGET_ECN=3Dm
CONFIG_IP_NF_TARGET_DSCP=3Dm
CONFIG_IP_NF_TARGET_MARK=3Dm
CONFIG_IP_NF_TARGET_LOG=3Dm
CONFIG_IP_NF_TARGET_ULOG=3Dm
CONFIG_IP_NF_TARGET_TCPMSS=3Dm
CONFIG_IP_NF_ARPTABLES=3Dm
CONFIG_IP_NF_ARPFILTER=3Dm
# CONFIG_IP_NF_COMPAT_IPCHAINS is not set
# CONFIG_IP_NF_COMPAT_IPFWADM is not set
CONFIG_IPV6=3Dm

#
#   IPv6: Netfilter Configuration
#
CONFIG_IP6_NF_QUEUE=3Dm
CONFIG_IP6_NF_IPTABLES=3Dm
CONFIG_IP6_NF_MATCH_LIMIT=3Dm
CONFIG_IP6_NF_MATCH_MAC=3Dm
CONFIG_IP6_NF_MATCH_RT=3Dm
CONFIG_IP6_NF_MATCH_OPTS=3Dm
CONFIG_IP6_NF_MATCH_FRAG=3Dm
CONFIG_IP6_NF_MATCH_HL=3Dm
CONFIG_IP6_NF_MATCH_MULTIPORT=3Dm
CONFIG_IP6_NF_MATCH_OWNER=3Dm
CONFIG_IP6_NF_MATCH_MARK=3Dm
CONFIG_IP6_NF_MATCH_IPV6HEADER=3Dm
CONFIG_IP6_NF_MATCH_AHESP=3Dm
CONFIG_IP6_NF_MATCH_LENGTH=3Dm
CONFIG_IP6_NF_MATCH_EUI64=3Dm
CONFIG_IP6_NF_FILTER=3Dm
CONFIG_IP6_NF_TARGET_LOG=3Dm
CONFIG_IP6_NF_MANGLE=3Dm
CONFIG_IP6_NF_TARGET_MARK=3Dm
CONFIG_KHTTPD=3Dm
CONFIG_ATM=3Dy
CONFIG_ATM_CLIP=3Dy
CONFIG_ATM_CLIP_NO_ICMP=3Dy
# CONFIG_ATM_LANE is not set
# CONFIG_ATM_BR2684 is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set

#
# Appletalk devices
#
# CONFIG_DEV_APPLETALK is not set
# CONFIG_DECNET is not set
CONFIG_BRIDGE=3Dm
# CONFIG_X25 is not set
# CONFIG_EDP2 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
CONFIG_NET_SCHED=3Dy
CONFIG_NET_SCH_CBQ=3Dm
CONFIG_NET_SCH_HTB=3Dm
CONFIG_NET_SCH_CSZ=3Dm
CONFIG_NET_SCH_ATM=3Dy
CONFIG_NET_SCH_PRIO=3Dm
CONFIG_NET_SCH_RED=3Dm
CONFIG_NET_SCH_SFQ=3Dm
CONFIG_NET_SCH_TEQL=3Dm
CONFIG_NET_SCH_TBF=3Dm
CONFIG_NET_SCH_GRED=3Dm
CONFIG_NET_SCH_DSMARK=3Dm
CONFIG_NET_SCH_INGRESS=3Dm
CONFIG_NET_QOS=3Dy
CONFIG_NET_ESTIMATOR=3Dy
CONFIG_NET_CLS=3Dy
CONFIG_NET_CLS_TCINDEX=3Dm
CONFIG_NET_CLS_ROUTE4=3Dm
CONFIG_NET_CLS_ROUTE=3Dy
CONFIG_NET_CLS_FW=3Dm
CONFIG_NET_CLS_U32=3Dm
CONFIG_NET_CLS_RSVP=3Dm
CONFIG_NET_CLS_RSVP6=3Dm
CONFIG_NET_CLS_POLICE=3Dy

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set
# CONFIG_PHONE_IXJ is not set
# CONFIG_PHONE_IXJ_PCMCIA is not set

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=3Dy

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=3Dy
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=3Dy
CONFIG_IDEDISK_MULTI_MODE=3Dy
CONFIG_IDEDISK_STROKE=3Dy
CONFIG_BLK_DEV_IDECS=3Dm
CONFIG_BLK_DEV_IDECD=3Dm
CONFIG_BLK_DEV_IDETAPE=3Dm
CONFIG_BLK_DEV_IDEFLOPPY=3Dy
CONFIG_BLK_DEV_IDESCSI=3Dm
# CONFIG_IDE_TASK_IOCTL is not set
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
CONFIG_BLK_DEV_IDEPCI=3Dy
CONFIG_BLK_DEV_GENERIC=3Dy
CONFIG_IDEPCI_SHARE_IRQ=3Dy
CONFIG_BLK_DEV_IDEDMA_PCI=3Dy
CONFIG_BLK_DEV_OFFBOARD=3Dy
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=3Dy
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=3Dy
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_BLK_DEV_ADMA100 is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_AMD74XX_OVERRIDE is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
CONFIG_BLK_DEV_PIIX=3Dy
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_PDC202XX_BURST is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_RZ1000 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
CONFIG_IDE_CHIPSETS=3Dy
# CONFIG_BLK_DEV_4DRIVES is not set
# CONFIG_BLK_DEV_ALI14XX is not set
# CONFIG_BLK_DEV_DTC2278 is not set
# CONFIG_BLK_DEV_HT6560B is not set
# CONFIG_BLK_DEV_PDC4030 is not set
# CONFIG_BLK_DEV_QD65XX is not set
# CONFIG_BLK_DEV_UMC8672 is not set
CONFIG_IDEDMA_AUTO=3Dy
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=3Dy
# CONFIG_BLK_DEV_ATARAID is not set
# CONFIG_BLK_DEV_ATARAID_PDC is not set
# CONFIG_BLK_DEV_ATARAID_HPT is not set
# CONFIG_BLK_DEV_ATARAID_SII is not set

#
# SCSI support
#
CONFIG_SCSI=3Dy
CONFIG_BLK_DEV_SD=3Dy
CONFIG_SD_EXTRA_DEVS=3D40
CONFIG_CHR_DEV_ST=3Dm
CONFIG_CHR_DEV_OSST=3Dm
CONFIG_BLK_DEV_SR=3Dm
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_SR_EXTRA_DEVS=3D4
CONFIG_CHR_DEV_SG=3Dm
# CONFIG_SCSI_DEBUG_QUEUES is not set
CONFIG_SCSI_MULTI_LUN=3Dy
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AHA1740 is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_MEGARAID2 is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_DMA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_NCR53C7xx is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_NCR53C8XX is not set
# CONFIG_SCSI_SYM53C8XX is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_SEAGATE is not set
# CONFIG_SCSI_SIM710 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# PCMCIA SCSI adapter support
#
# CONFIG_SCSI_PCMCIA is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_BOOT is not set
# CONFIG_FUSION_ISENSE is not set
# CONFIG_FUSION_CTL is not set
# CONFIG_FUSION_LAN is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
CONFIG_IEEE1394=3Dm
CONFIG_IEEE1394_PCILYNX=3Dm
CONFIG_IEEE1394_OHCI1394=3Dm
CONFIG_IEEE1394_VIDEO1394=3Dm
CONFIG_IEEE1394_SBP2=3Dm
# CONFIG_IEEE1394_SBP2_PHYS_DMA is not set
CONFIG_IEEE1394_ETH1394=3Dm
CONFIG_IEEE1394_DV1394=3Dm
CONFIG_IEEE1394_RAWIO=3Dm
CONFIG_IEEE1394_CMP=3Dm
CONFIG_IEEE1394_AMDTP=3Dm
# CONFIG_IEEE1394_VERBOSEDEBUG is not set

#
# I2O device support
#
CONFIG_I2O=3Dm
CONFIG_I2O_PCI=3Dm
CONFIG_I2O_BLOCK=3Dm
CONFIG_I2O_LAN=3Dm
CONFIG_I2O_SCSI=3Dm
CONFIG_I2O_PROC=3Dm

#
# Network device support
#
CONFIG_NETDEVICES=3Dy

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=3Dm
CONFIG_BONDING=3Dm
CONFIG_EQUALIZER=3Dm
CONFIG_TUN=3Dm
# CONFIG_ETHERTAP is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=3Dy
# CONFIG_SUNLANCE is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNBMAC is not set
# CONFIG_SUNQE is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=3Dy
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_CS89x0 is not set
# CONFIG_TULIP is not set
# CONFIG_DE4X5 is not set
# CONFIG_DGRS is not set
# CONFIG_DM9102 is not set
CONFIG_EEPRO100=3Dm
# CONFIG_EEPRO100_PIO is not set
CONFIG_E100=3Dm
# CONFIG_LNE390 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_NE3210 is not set
# CONFIG_ES3210 is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_OLD_RX_RESET is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_SUNDANCE_MMIO is not set
# CONFIG_TLAN is not set
# CONFIG_TC35815 is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_RHINE_MMIO is not set
# CONFIG_WINBOND_840 is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_MYRI_SBUS is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
CONFIG_PPP=3Dm
# CONFIG_PPP_MULTILINK is not set
CONFIG_PPP_FILTER=3Dy
CONFIG_PPP_ASYNC=3Dm
CONFIG_PPP_SYNC_TTY=3Dm
CONFIG_PPP_DEFLATE=3Dm
CONFIG_PPP_BSDCOMP=3Dm
CONFIG_PPPOE=3Dm
CONFIG_PPPOATM=3Dm
CONFIG_SLIP=3Dm
CONFIG_SLIP_COMPRESSED=3Dy
CONFIG_SLIP_SMART=3Dy
CONFIG_SLIP_MODE_SLIP6=3Dy

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
CONFIG_SHAPER=3Dm

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# PCMCIA network device support
#
CONFIG_NET_PCMCIA=3Dy
CONFIG_PCMCIA_3C589=3Dm
CONFIG_PCMCIA_3C574=3Dm
CONFIG_PCMCIA_FMVJ18X=3Dm
CONFIG_PCMCIA_PCNET=3Dm
CONFIG_PCMCIA_AXNET=3Dm
CONFIG_PCMCIA_NMCLAN=3Dm
CONFIG_PCMCIA_SMC91C92=3Dm
CONFIG_PCMCIA_XIRC2PS=3Dm
# CONFIG_ARCNET_COM20020_CS is not set
# CONFIG_PCMCIA_IBMTR is not set
CONFIG_PCMCIA_XIRCOM=3Dm
CONFIG_PCMCIA_XIRTULIP=3Dm
CONFIG_NET_PCMCIA_RADIO=3Dy
CONFIG_PCMCIA_RAYCS=3Dm
CONFIG_PCMCIA_NETWAVE=3Dm
CONFIG_PCMCIA_WAVELAN=3Dm
CONFIG_AIRONET4500_CS=3Dm

#
# ATM drivers
#
# CONFIG_ATM_TCP is not set
# CONFIG_ATM_LANAI is not set
# CONFIG_ATM_ENI is not set
# CONFIG_ATM_FIRESTREAM is not set
# CONFIG_ATM_ZATM is not set
# CONFIG_ATM_NICSTAR is not set
# CONFIG_ATM_IDT77252 is not set
# CONFIG_ATM_AMBASSADOR is not set
# CONFIG_ATM_HORIZON is not set
# CONFIG_ATM_IA is not set
# CONFIG_ATM_FORE200E_MAYBE is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
CONFIG_IRDA=3Dm
CONFIG_IRLAN=3Dm
CONFIG_IRNET=3Dm
CONFIG_IRCOMM=3Dm
CONFIG_IRDA_ULTRA=3Dy
CONFIG_IRDA_CACHE_LAST_LSAP=3Dy
# CONFIG_IRDA_FAST_RR is not set
# CONFIG_IRDA_DEBUG is not set

#
# Infrared-port device drivers
#
CONFIG_IRTTY_SIR=3Dm
CONFIG_IRPORT_SIR=3Dm
# CONFIG_DONGLE is not set
CONFIG_USB_IRDA=3Dm
CONFIG_NSC_FIR=3Dm
CONFIG_WINBOND_FIR=3Dm
CONFIG_TOSHIBA_OLD=3Dm
CONFIG_TOSHIBA_FIR=3Dm
CONFIG_SMC_IRCC_FIR=3Dm
CONFIG_ALI_FIR=3Dm
CONFIG_VLSI_FIR=3Dm

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Input core support
#
CONFIG_INPUT=3Dm
CONFIG_INPUT_KEYBDEV=3Dm
CONFIG_INPUT_MOUSEDEV=3Dm
CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768
CONFIG_INPUT_JOYDEV=3Dm
CONFIG_INPUT_EVDEV=3Dm

#
# Character devices
#
CONFIG_VT=3Dy
CONFIG_VT_CONSOLE=3Dy
CONFIG_SERIAL=3Dy
CONFIG_SERIAL_CONSOLE=3Dy
CONFIG_SERIAL_EXTENDED=3Dy
CONFIG_SERIAL_MANY_PORTS=3Dy
CONFIG_SERIAL_SHARE_IRQ=3Dy
# CONFIG_SERIAL_DETECT_IRQ is not set
# CONFIG_SERIAL_MULTIPORT is not set
# CONFIG_HUB6 is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=3Dy
CONFIG_UNIX98_PTY_COUNT=3D256

#
# I2C support
#
CONFIG_I2C=3Dm
CONFIG_I2C_ALGOBIT=3Dm
# CONFIG_I2C_PHILIPSPAR is not set
CONFIG_I2C_ELV=3Dm
CONFIG_I2C_VELLEMAN=3Dm
# CONFIG_SCx200_I2C is not set
CONFIG_SCx200_ACB=3Dm
CONFIG_I2C_ALGOPCF=3Dm
CONFIG_I2C_ELEKTOR=3Dm
CONFIG_I2C_CHARDEV=3Dm
CONFIG_I2C_PROC=3Dm

#
# Mice
#
# CONFIG_BUSMOUSE is not set
CONFIG_MOUSE=3Dy
CONFIG_PSMOUSE=3Dy
# CONFIG_82C710_MOUSE is not set
# CONFIG_PC110_PAD is not set
# CONFIG_MK712_MOUSE is not set

#
# Joysticks
#
# CONFIG_INPUT_GAMEPORT is not set
# CONFIG_INPUT_NS558 is not set
# CONFIG_INPUT_LIGHTNING is not set
# CONFIG_INPUT_PCIGAME is not set
# CONFIG_INPUT_CS461X is not set
# CONFIG_INPUT_EMU10K1 is not set
# CONFIG_INPUT_SERIO is not set
# CONFIG_INPUT_SERPORT is not set
# CONFIG_INPUT_ANALOG is not set
# CONFIG_INPUT_A3D is not set
# CONFIG_INPUT_ADI is not set
# CONFIG_INPUT_COBRA is not set
# CONFIG_INPUT_GF2K is not set
# CONFIG_INPUT_GRIP is not set
# CONFIG_INPUT_INTERACT is not set
# CONFIG_INPUT_TMDC is not set
# CONFIG_INPUT_SIDEWINDER is not set
# CONFIG_INPUT_IFORCE_USB is not set
# CONFIG_INPUT_IFORCE_232 is not set
# CONFIG_INPUT_WARRIOR is not set
# CONFIG_INPUT_MAGELLAN is not set
# CONFIG_INPUT_SPACEORB is not set
# CONFIG_INPUT_SPACEBALL is not set
# CONFIG_INPUT_STINGER is not set
# CONFIG_INPUT_DB9 is not set
# CONFIG_INPUT_GAMECON is not set
# CONFIG_INPUT_TURBOGRAFX is not set
# CONFIG_QIC02_TAPE is not set
# CONFIG_IPMI_HANDLER is not set
# CONFIG_IPMI_PANIC_EVENT is not set
# CONFIG_IPMI_DEVICE_INTERFACE is not set
# CONFIG_IPMI_KCS is not set
# CONFIG_IPMI_WATCHDOG is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_SCx200_GPIO is not set
# CONFIG_AMD_RNG is not set
CONFIG_INTEL_RNG=3Dm
# CONFIG_AMD_PM768 is not set
CONFIG_NVRAM=3Dm
# CONFIG_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=3Dm
CONFIG_AGP_INTEL=3Dy
CONFIG_AGP_I810=3Dy
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD_8151 is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_NVIDIA is not set
CONFIG_DRM=3Dy
# CONFIG_DRM_OLD is not set
CONFIG_DRM_NEW=3Dy
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_GAMMA is not set
# CONFIG_DRM_R128 is not set
CONFIG_DRM_RADEON=3Dm
# CONFIG_DRM_I810 is not set
# CONFIG_DRM_I810_XFREE_41 is not set
CONFIG_DRM_I830=3Dm
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set

#
# PCMCIA character devices
#
# CONFIG_PCMCIA_SERIAL_CS is not set
# CONFIG_SYNCLINK_CS is not set
CONFIG_MWAVE=3Dm

#
# Multimedia devices
#
CONFIG_VIDEO_DEV=3Dm

#
# Video For Linux
#
CONFIG_VIDEO_PROC_FS=3Dy
# CONFIG_I2C_PARPORT is not set
CONFIG_VIDEO_BT848=3Dm
CONFIG_VIDEO_PMS=3Dm
CONFIG_VIDEO_CPIA=3Dm
# CONFIG_VIDEO_CPIA_PP is not set
CONFIG_VIDEO_CPIA_USB=3Dm
CONFIG_VIDEO_SAA5249=3Dm
CONFIG_TUNER_3036=3Dm
CONFIG_VIDEO_STRADIS=3Dm
CONFIG_VIDEO_ZORAN=3Dm
CONFIG_VIDEO_ZORAN_BUZ=3Dm
CONFIG_VIDEO_ZORAN_DC10=3Dm
CONFIG_VIDEO_ZORAN_LML33=3Dm
CONFIG_VIDEO_ZR36120=3Dm
# CONFIG_VIDEO_MEYE is not set

#
# Radio Adapters
#
CONFIG_RADIO_CADET=3Dm
CONFIG_RADIO_RTRACK=3Dm
CONFIG_RADIO_RTRACK2=3Dm
CONFIG_RADIO_AZTECH=3Dm
CONFIG_RADIO_GEMTEK=3Dm
CONFIG_RADIO_GEMTEK_PCI=3Dm
CONFIG_RADIO_MAXIRADIO=3Dm
CONFIG_RADIO_MAESTRO=3Dm
CONFIG_RADIO_MIROPCM20=3Dm
CONFIG_RADIO_MIROPCM20_RDS=3Dm
CONFIG_RADIO_SF16FMI=3Dm
CONFIG_RADIO_SF16FMR2=3Dm
CONFIG_RADIO_TERRATEC=3Dm
CONFIG_RADIO_TRUST=3Dm
CONFIG_RADIO_TYPHOON=3Dm
CONFIG_RADIO_TYPHOON_PROC_FS=3Dy
CONFIG_RADIO_ZOLTRIX=3Dm

#
# File systems
#
CONFIG_QUOTA=3Dy
CONFIG_QFMT_V1=3Dm
CONFIG_QFMT_V2=3Dm
CONFIG_QIFACE_COMPAT=3Dy
# CONFIG_QIFACE_V1 is not set
CONFIG_QIFACE_V2=3Dy
CONFIG_AUTOFS_FS=3Dm
CONFIG_AUTOFS4_FS=3Dm
CONFIG_REISERFS_FS=3Dm
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
CONFIG_ADFS_FS=3Dm
# CONFIG_ADFS_FS_RW is not set
CONFIG_AFFS_FS=3Dm
CONFIG_HFS_FS=3Dm
CONFIG_BEFS_FS=3Dm
# CONFIG_BEFS_DEBUG is not set
# CONFIG_HFSPLUS_FS is not set
CONFIG_BFS_FS=3Dm
CONFIG_EXT3_FS=3Dm
CONFIG_JBD=3Dm
CONFIG_JBD_DEBUG=3Dy
CONFIG_FAT_FS=3Dm
CONFIG_MSDOS_FS=3Dm
CONFIG_UMSDOS_FS=3Dm
CONFIG_VFAT_FS=3Dm
CONFIG_EFS_FS=3Dm
# CONFIG_JFFS_FS is not set
# CONFIG_JFFS2_FS is not set
CONFIG_CRAMFS=3Dm
CONFIG_TMPFS=3Dy
CONFIG_RAMFS=3Dy
CONFIG_ISO9660_FS=3Dy
CONFIG_JOLIET=3Dy
CONFIG_ZISOFS=3Dy
CONFIG_JFS_FS=3Dm
# CONFIG_JFS_DEBUG is not set
CONFIG_JFS_STATISTICS=3Dy
CONFIG_MINIX_FS=3Dy
CONFIG_VXFS_FS=3Dm
CONFIG_NTFS_FS=3Dm
# CONFIG_NTFS_RW is not set
CONFIG_HPFS_FS=3Dm
CONFIG_PROC_FS=3Dy
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=3Dy
CONFIG_QNX4FS_FS=3Dm
# CONFIG_QNX4FS_RW is not set
CONFIG_ROMFS_FS=3Dm
CONFIG_EXT2_FS=3Dy
CONFIG_SYSV_FS=3Dm
CONFIG_UDF_FS=3Dm
CONFIG_UDF_RW=3Dy
CONFIG_UFS_FS=3Dm
# CONFIG_UFS_FS_WRITE is not set
CONFIG_XFS_FS=3Dm
# CONFIG_XFS_RT is not set
# CONFIG_XFS_QUOTA is not set

#
# Network File Systems
#
CONFIG_CODA_FS=3Dm
CONFIG_INTERMEZZO_FS=3Dm
CONFIG_NFS_FS=3Dy
CONFIG_NFS_V3=3Dy
# CONFIG_NFS_DIRECTIO is not set
CONFIG_ROOT_NFS=3Dy
CONFIG_NFSD=3Dm
CONFIG_NFSD_V3=3Dy
# CONFIG_NFSD_TCP is not set
CONFIG_SUNRPC=3Dy
CONFIG_LOCKD=3Dy
CONFIG_LOCKD_V4=3Dy
CONFIG_SMB_FS=3Dm
CONFIG_SMB_NLS_DEFAULT=3Dy
CONFIG_SMB_NLS_REMOTE=3D"cp437"
CONFIG_NCP_FS=3Dm
CONFIG_NCPFS_PACKET_SIGNING=3Dy
CONFIG_NCPFS_IOCTL_LOCKING=3Dy
CONFIG_NCPFS_STRONG=3Dy
CONFIG_NCPFS_NFS_NS=3Dy
CONFIG_NCPFS_OS2_NS=3Dy
CONFIG_NCPFS_SMALLDOS=3Dy
CONFIG_NCPFS_NLS=3Dy
CONFIG_NCPFS_EXTRAS=3Dy
CONFIG_ZISOFS_FS=3Dy

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=3Dy
# CONFIG_ACORN_PARTITION is not set
CONFIG_OSF_PARTITION=3Dy
# CONFIG_AMIGA_PARTITION is not set
CONFIG_ATARI_PARTITION=3Dy
CONFIG_MAC_PARTITION=3Dy
CONFIG_MSDOS_PARTITION=3Dy
CONFIG_BSD_DISKLABEL=3Dy
# CONFIG_MINIX_SUBPARTITION is not set
CONFIG_SOLARIS_X86_PARTITION=3Dy
CONFIG_UNIXWARE_DISKLABEL=3Dy
# CONFIG_LDM_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
CONFIG_ULTRIX_PARTITION=3Dy
CONFIG_SUN_PARTITION=3Dy
CONFIG_EFI_PARTITION=3Dy
CONFIG_SMB_NLS=3Dy
CONFIG_NLS=3Dy

#
# Native Language Support
#
CONFIG_NLS_DEFAULT=3D"iso8859-1"
CONFIG_NLS_CODEPAGE_437=3Dm
CONFIG_NLS_CODEPAGE_737=3Dm
CONFIG_NLS_CODEPAGE_775=3Dm
CONFIG_NLS_CODEPAGE_850=3Dm
CONFIG_NLS_CODEPAGE_852=3Dm
CONFIG_NLS_CODEPAGE_855=3Dm
CONFIG_NLS_CODEPAGE_857=3Dm
CONFIG_NLS_CODEPAGE_860=3Dm
CONFIG_NLS_CODEPAGE_861=3Dm
CONFIG_NLS_CODEPAGE_862=3Dm
CONFIG_NLS_CODEPAGE_863=3Dm
CONFIG_NLS_CODEPAGE_864=3Dm
CONFIG_NLS_CODEPAGE_865=3Dm
CONFIG_NLS_CODEPAGE_866=3Dm
CONFIG_NLS_CODEPAGE_869=3Dm
CONFIG_NLS_CODEPAGE_936=3Dm
CONFIG_NLS_CODEPAGE_950=3Dm
CONFIG_NLS_CODEPAGE_932=3Dm
CONFIG_NLS_CODEPAGE_949=3Dm
CONFIG_NLS_CODEPAGE_874=3Dm
CONFIG_NLS_ISO8859_8=3Dm
CONFIG_NLS_CODEPAGE_1250=3Dm
CONFIG_NLS_CODEPAGE_1251=3Dm
CONFIG_NLS_ISO8859_1=3Dm
CONFIG_NLS_ISO8859_2=3Dm
CONFIG_NLS_ISO8859_3=3Dm
CONFIG_NLS_ISO8859_4=3Dm
CONFIG_NLS_ISO8859_5=3Dm
CONFIG_NLS_ISO8859_6=3Dm
CONFIG_NLS_ISO8859_7=3Dm
CONFIG_NLS_ISO8859_9=3Dm
CONFIG_NLS_ISO8859_13=3Dm
CONFIG_NLS_ISO8859_14=3Dm
CONFIG_NLS_ISO8859_15=3Dm
CONFIG_NLS_KOI8_R=3Dm
CONFIG_NLS_KOI8_U=3Dm
CONFIG_NLS_UTF8=3Dm

#
# Console drivers
#
CONFIG_VGA_CONSOLE=3Dy
CONFIG_VIDEO_SELECT=3Dy
# CONFIG_MDA_CONSOLE is not set

#
# Frame-buffer support
#
CONFIG_FB=3Dy
CONFIG_DUMMY_CONSOLE=3Dy
# CONFIG_FB_RIVA is not set
# CONFIG_FB_CLGEN is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_VESA is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_HGA is not set
CONFIG_VIDEO_SELECT=3Dy
# CONFIG_FB_MATROX is not set
# CONFIG_FB_ATY is not set
CONFIG_FB_RADEON=3Dy
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_INTEL is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FBCON_ADVANCED is not set
CONFIG_FBCON_CFB8=3Dy
CONFIG_FBCON_CFB16=3Dy
CONFIG_FBCON_CFB24=3Dy
CONFIG_FBCON_CFB32=3Dy
# CONFIG_FBCON_FONTWIDTH8_ONLY is not set
# CONFIG_FBCON_FONTS is not set
CONFIG_FONT_8x8=3Dy
CONFIG_FONT_8x16=3Dy

#
# Sound
#
CONFIG_SOUND=3Dm
# CONFIG_SOUND_ALI5455 is not set
# CONFIG_SOUND_BT878 is not set
# CONFIG_SOUND_CMPCI is not set
# CONFIG_SOUND_EMU10K1 is not set
# CONFIG_MIDI_EMU10K1 is not set
# CONFIG_SOUND_FUSION is not set
# CONFIG_SOUND_CS4281 is not set
# CONFIG_SOUND_ES1370 is not set
# CONFIG_SOUND_ES1371 is not set
# CONFIG_SOUND_ESSSOLO1 is not set
# CONFIG_SOUND_MAESTRO is not set
# CONFIG_SOUND_MAESTRO3 is not set
# CONFIG_SOUND_FORTE is not set
CONFIG_SOUND_ICH=3Dm
# CONFIG_SOUND_RME96XX is not set
# CONFIG_SOUND_SONICVIBES is not set
# CONFIG_SOUND_TRIDENT is not set
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
# CONFIG_SOUND_VIA82CXXX is not set
# CONFIG_MIDI_VIA82CXXX is not set
# CONFIG_SOUND_OSS is not set
# CONFIG_SOUND_TVMIXER is not set

#
# USB support
#
CONFIG_USB=3Dm
CONFIG_USB_DEBUG=3Dy
CONFIG_USB_DEVICEFS=3Dy
CONFIG_USB_BANDWIDTH=3Dy
CONFIG_USB_EHCI_HCD=3Dm
CONFIG_USB_UHCI=3Dm
CONFIG_USB_UHCI_ALT=3Dm
CONFIG_USB_OHCI=3Dm
CONFIG_USB_AUDIO=3Dm
CONFIG_USB_EMI26=3Dm
CONFIG_USB_MIDI=3Dm
CONFIG_USB_STORAGE=3Dm
CONFIG_USB_STORAGE_DEBUG=3Dy
CONFIG_USB_STORAGE_DATAFAB=3Dy
CONFIG_USB_STORAGE_FREECOM=3Dy
CONFIG_USB_STORAGE_ISD200=3Dy
CONFIG_USB_STORAGE_DPCM=3Dy
CONFIG_USB_STORAGE_HP8200e=3Dy
CONFIG_USB_STORAGE_SDDR09=3Dy
CONFIG_USB_STORAGE_SDDR55=3Dy
CONFIG_USB_STORAGE_JUMPSHOT=3Dy
CONFIG_USB_ACM=3Dm
CONFIG_USB_PRINTER=3Dm
CONFIG_USB_HID=3Dm
CONFIG_USB_HIDINPUT=3Dy
CONFIG_USB_HIDDEV=3Dy
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
CONFIG_USB_AIPTEK=3Dm
CONFIG_USB_WACOM=3Dm
CONFIG_USB_KBTAB=3Dm
CONFIG_USB_POWERMATE=3Dm
CONFIG_USB_DC2XX=3Dm
CONFIG_USB_MDC800=3Dm
CONFIG_USB_SCANNER=3Dm
CONFIG_USB_MICROTEK=3Dm
CONFIG_USB_HPUSBSCSI=3Dm
CONFIG_USB_IBMCAM=3Dm
CONFIG_USB_KONICAWC=3Dm
CONFIG_USB_OV511=3Dm
CONFIG_USB_PWC=3Dm
CONFIG_USB_SE401=3Dm
CONFIG_USB_STV680=3Dm
CONFIG_USB_VICAM=3Dm
CONFIG_USB_DSBR=3Dm
CONFIG_USB_DABUSB=3Dm
CONFIG_USB_PEGASUS=3Dm
CONFIG_USB_RTL8150=3Dm
CONFIG_USB_KAWETH=3Dm
CONFIG_USB_CATC=3Dm
CONFIG_USB_CDCETHER=3Dm
CONFIG_USB_USBNET=3Dm
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
CONFIG_USB_SERIAL=3Dm
# CONFIG_USB_SERIAL_DEBUG is not set
CONFIG_USB_SERIAL_GENERIC=3Dy
CONFIG_USB_SERIAL_BELKIN=3Dm
CONFIG_USB_SERIAL_WHITEHEAT=3Dm
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=3Dm
CONFIG_USB_SERIAL_EMPEG=3Dm
CONFIG_USB_SERIAL_FTDI_SIO=3Dm
CONFIG_USB_SERIAL_VISOR=3Dm
CONFIG_USB_SERIAL_IPAQ=3Dm
CONFIG_USB_SERIAL_IR=3Dm
CONFIG_USB_SERIAL_EDGEPORT=3Dm
CONFIG_USB_SERIAL_EDGEPORT_TI=3Dm
CONFIG_USB_SERIAL_KEYSPAN_PDA=3Dm
CONFIG_USB_SERIAL_KEYSPAN=3Dm
CONFIG_USB_SERIAL_KEYSPAN_USA28=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA28X=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA28XA=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA28XB=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA19=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA18X=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA19W=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA19QW=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA19QI=3Dy
CONFIG_USB_SERIAL_KEYSPAN_MPR=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA49W=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA49WLC=3Dy
CONFIG_USB_SERIAL_MCT_U232=3Dm
CONFIG_USB_SERIAL_KLSI=3Dm
CONFIG_USB_SERIAL_KOBIL_SCT=3Dm
CONFIG_USB_SERIAL_PL2303=3Dm
CONFIG_USB_SERIAL_CYBERJACK=3Dm
CONFIG_USB_SERIAL_XIRCOM=3Dm
CONFIG_USB_SERIAL_OMNINET=3Dm
CONFIG_USB_RIO500=3Dm
CONFIG_USB_AUERSWALD=3Dm
CONFIG_USB_TIGL=3Dm
CONFIG_USB_BRLVGER=3Dm
CONFIG_USB_LCD=3Dm

#
# Bluetooth support
#
CONFIG_BLUEZ=3Dm
CONFIG_BLUEZ_L2CAP=3Dm
CONFIG_BLUEZ_SCO=3Dm
CONFIG_BLUEZ_RFCOMM=3Dm
CONFIG_BLUEZ_RFCOMM_TTY=3Dy
CONFIG_BLUEZ_BNEP=3Dm
CONFIG_BLUEZ_BNEP_MC_FILTER=3Dy
CONFIG_BLUEZ_BNEP_PROTO_FILTER=3Dy

#
# Bluetooth device drivers
#
CONFIG_BLUEZ_HCIUSB=3Dm
CONFIG_BLUEZ_USB_SCO=3Dy
CONFIG_BLUEZ_USB_ZERO_PACKET=3Dy
CONFIG_BLUEZ_HCIUART=3Dm
CONFIG_BLUEZ_HCIUART_H4=3Dy
CONFIG_BLUEZ_HCIUART_BCSP=3Dy
CONFIG_BLUEZ_HCIUART_BCSP_TXCRC=3Dy
CONFIG_BLUEZ_HCIDTL1=3Dm
CONFIG_BLUEZ_HCIBT3C=3Dm
CONFIG_BLUEZ_HCIBLUECARD=3Dm
CONFIG_BLUEZ_HCIBTUART=3Dm
CONFIG_BLUEZ_HCIVHCI=3Dm

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=3Dy
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_FRAME_POINTER is not set
# CONFIG_DEBUG_HIGHMEM is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_IOVIRT is not set
CONFIG_MAGIC_SYSRQ=3Dy
CONFIG_PANIC_MORSE=3Dy
# CONFIG_DEBUG_SPINLOCK is not set

#
# Library routines
#
CONFIG_CRC32=3Dy
CONFIG_ZLIB_INFLATE=3Dy
CONFIG_ZLIB_DEFLATE=3Dm

--=-m9YzwQXdD9A+G10tDT8D--

--=-ovbssCxiyVioKVYQXDv9
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2-rc1-SuSE (GNU/Linux)

iD8DBQA+7DwNLYywqksgYBoRAvQVAKDIyVCHjl624t4vRdk7O89VU0NdVwCdFI5L
Mtr5LEXVl6QygdtaLVS+2lI=
=pD6h
-----END PGP SIGNATURE-----

--=-ovbssCxiyVioKVYQXDv9--

