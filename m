Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292660AbSBZSZd>; Tue, 26 Feb 2002 13:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292420AbSBZSYA>; Tue, 26 Feb 2002 13:24:00 -0500
Received: from [200.176.121.161] ([200.176.121.161]:4595 "EHLO mail.cbj.g12.br")
	by vger.kernel.org with ESMTP id <S292657AbSBZSXd>;
	Tue, 26 Feb 2002 13:23:33 -0500
Message-ID: <003301c1bef3$156119a0$5600a8c0@c136suporte>
Reply-To: "Suporte RedeBonja" <suporte@cbj.g12.br>
From: "Suporte RedeBonja" <suporte@cbj.g12.br>
To: <linux-kernel@vger.kernel.org>
Subject: kernel oops
Date: Tue, 26 Feb 2002 15:26:15 -0300
Organization: =?iso-8859-1?Q?Col=E9gio_Bom_Jesus?=
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
we are having problems with the kernel (oops). My box is a mail server only
and the problem occurs a thousand times a day . I realize a wierd message on
the boot process: /lib/modules/2.2.16/net/bsd_comp.o _> unresolved symbols,
the same message for: /lib/modules/2.2.16/misc/zft_compressor.o,
 /lib/modules/2.2.16/misc/rio.o,
/lib/modules/2.2.16/misc/dss1_divert.o.

here is my configuration:

Red Hat 6.1 (Cartman)
kernel : 2.2.16

dmesg:
*************************
Linux version 2.2.16 (root@mail.cbj.g12.br) (gcc version egcs-2.91.66
19990314/Linux (egcs-1.1.2 release)) #8 Tue Sep 19 14:27:25 BRT 2000
Detected 451026 kHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 897.84 BogoMIPS
Memory: 257788k/262080k available (1032k kernel code, 408k reserved,
2812k data, 40k init)
Dentry hash table entries: 32768 (order 6, 256k)
Buffer cache hash table entries: 262144 (order 8, 1024k)
Page cache hash table entries: 65536 (order 6, 256k)
CPU: L1 I Cache: 32K L1 D Cache: 32K
CPU: AMD AMD-K6(tm) 3D processor stepping 0c
Checking 386/387 coupling... OK, FPU using exception 16 error reporting.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.35a (19990819) Richard Gooch (rgooch@atnf.csiro.au)
PCI: PCI BIOS revision 2.10 entry at 0xf0720
PCI: Using configuration type 1
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
TCP: Hash tables configured (ehash 262144 bhash 65536)
Starting kswapd v 1.5
Serial driver version 4.27 with no serial options enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
pty: 256 Unix98 ptys configured
loop: registered device at major 7
SIS5513: IDE controller on PCI bus 00 dev 01
SIS5513: not 100% native mode: will probe irqs later
ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:pio, hdd:pio
hda: QUANTUM FIREBALL CX6.4A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: QUANTUM FIREBALL CX6.4A, 6149MB w/418kB Cache, CHS=784/255/63
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
3c59x.c:v0.99H 27May00 Donald Becker
http://cesdis.gsfc.nasa.gov/linux/drivers/vortex.html
eth0: 3Com 3c905B Cyclone 100baseTx at 0xa800, 00:50:da:0d:14:d5, IRQ
11
8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
MII transceiver found at address 24, status 786d.
MII transceiver found at address 0, status 786d.
Enabling bus-master transmits and whole-frame receives.
Partition check:
hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 >
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 40k freed
Adding Swap: 265032k swap-space (priority -1)
***************************************


Ksymoops output:
*****************************************
WARNING: This version of ksymoops is obsolete.
WARNING: The current version can be obtained from
ftp://ftp.ocs.com.au/pub/ksymoops
Options used: -V (default)
-o /lib/modules/2.2.16/ (default)
-k /proc/ksyms (default)
-l /proc/modules (default)
-m /usr/src/linux/System.map (default)
-c 1 (default)

You did not tell me where to find symbol information. I will assume
that the log matches the kernel and modules that are running right now
and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc. ksymoops -h explains the options.

No modules in ksyms, skipping objects
Unable to handle kernel paging request at virtual address 8f2e9fe4
current->tss.cr3 = 09dab000, %cr3 = 09dab000
*pde = 00000000
Oops: 0002
CPU: 0
EIP: 0010:[<c012483c>]
EFLAGS: 00010286
eax: ce2048f0 ebx: cefd9720 ecx: ce204880 edx: cec2b8a0
esi: 00000000 edi: c9a01e80 ebp: bffffb08 esp: cafc1f8c
ds: 0018 es: 0018 ss: 0018
Process inetd (pid: 28677, process nr: 27, stackpage=cafc1000)
Stack: cefd9720 cefd9720 c01238d6 cefd9720 0000000a cefd9720 fffffff7
c012393d
cefd9720 cec2b8a0 cafc0000 0000000a 40106fe0 c0108fbc 0000000a
0000006f
4010648c 0000000a 40106fe0 bffffb08 00000006 0000002b 0000002b
00000006
Call Trace: [<c01238d6>] [<c012393d>] [<c0108fbc>]
Code: c0 83 c4 08 31 c0 5b 5e 5f 5d 59 c3 83 ec 04 55 57 56 b9 16

>>EIP: c012483c <get_empty_filp+124/130>
Trace: c01238d6 <filp_close+52/5c>
Trace: c012393d <sys_close+5d/a08>
Trace: c0108fbc <dump_thread+1280/22fc>
Code: c012483c <get_empty_filp+124/130> 00000000 <_EIP>:
<===
Code: c012483c <get_empty_filp+124/130> 0: c0 83 c4 08 31 c0
5b rolb $0x5b,0xc03108c4(%ebx) <===
Code: c0124843 <get_empty_filp+12b/130> 7: 5e
popl %esi
Code: c0124844 <get_empty_filp+12c/130> 8: 5f
popl %edi
Code: c0124845 <get_empty_filp+12d/130> 9: 5d
popl %ebp
Code: c0124846 <get_empty_filp+12e/130> a: 59
popl %ecx
Code: c0124847 <get_empty_filp+12f/130> b: c3
ret
Code: c0124848 <init_private_file+0/74> c: 83 ec 04
subl $0x4,%esp
Code: c012484b <init_private_file+3/74> f: 55
pushl %ebp
Code: c012484c <init_private_file+4/74> 10: 57
pushl %edi
Code: c012484d <init_private_file+5/74> 11: 56
pushl %esi
Code: c012484e <init_private_file+6/74> 12: b9 16 00 00 00
movl $0x16,%ecx


5 warnings and 1 error issued. Results may not be reliable.
****************************************

I would appreciate your interest in help me to solve this problem.
Thanks in advance,


Andrey Allage
_____________________________
Colégio Bom Jesus / Ielusc
www.cbj.g12.br
Joinville - SC




