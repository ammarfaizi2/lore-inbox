Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132493AbRDDWIs>; Wed, 4 Apr 2001 18:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132496AbRDDWIi>; Wed, 4 Apr 2001 18:08:38 -0400
Received: from [213.96.124.18] ([213.96.124.18]:34796 "HELO dardhal")
	by vger.kernel.org with SMTP id <S132493AbRDDWI0>;
	Wed, 4 Apr 2001 18:08:26 -0400
Date: Thu, 5 Apr 2001 00:07:21 +0000
From: =?us-ascii?Q?Jos=E9_Luis_Domingo_L=F3pez?= 
	<jldomingo@crosswinds.net>
To: linux-kernel@vger.kernel.org
Subject: 2.2.19 hangs just before "Uncompressing Linux"
Message-ID: <20010405000721.B338@dardhal.mired.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi kernel gurus & testers:

When booting from my recently compiled Linux kernel version 2.2.19, about
90-95% of times the system hangs just after printing:
Loading nameofimage.........

And doesn't get to the point where the kernel uncompresses (that is, no
Uncompressing message). However, booting the same kernel from floppy is OK
and works 100% of times (the same applies for other kernel versions).

With 2.2.18 I've been experiencing the same behavior, but with this
version instead of hanging, the machine reboots itself, and "only" about
50% of times. Also I discovered that pressing some keybpard keys while the
kernel is being loaded makes it more probable to get a succesful boot.

With kernel version 2.2.17-idepci as shipped on Debian Potato, I've never
experienced any kind of problems.

Searching through the mailing list archives I've seen comments about a
possible defective RAM causing this problem. However, the system never
hung up once it is up un runnig, and this machine is nearly always using
all of my RAM and working at high workloads.

Information about related important hardware and software follows:
Debian Woody with gcc 2.95.3-5

cat /proc/cpuinfo (166 MHz Pentium @ 166 MHz)
-----------------
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 5
model		: 2
model name	: Pentium 75 - 200
stepping	: 12
cpu MHz		: 165.793
fdiv_bug	: no
hlt_bug		: no
sep_bug		: no
f00f_bug	: yes
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr mce cx8
bogomips	: 330.95

cat /proc/pci
-------------
00:00.0 Host bridge: Intel Corporation 430HX - 82439HX TXC [Triton II] (rev 03)
	Flags: bus master, medium devsel, latency 32

00:07.0 ISA bridge: Intel Corporation 82371SB PIIX3 ISA [Natoma/Triton II] (rev 01)
	Flags: bus master, medium devsel, latency 0

00:07.1 IDE interface: Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton II] (prog-if 80 [Master])
	Flags: bus master, medium devsel, latency 32
	I/O ports at f000

dmesg
-----
Linux version 2.2.19 (root@dardhal) (gcc version 2.95.3 20010219 (prerelease)) #1 sáb mar 31 23:19:47 UTC 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0009fc00 @ 00000000 (usable)
 BIOS-e820: 00000400 @ 0009fc00 (usable)
 BIOS-e820: 03f00000 @ 00100000 (usable)
Detected 165793 kHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 330.95 BogoMIPS
Memory: 63380k/65536k available (832k kernel code, 416k reserved, 864k data, 44k init)
Dentry hash table entries: 8192 (order 4, 64k)
Buffer cache hash table entries: 65536 (order 6, 256k)
Page cache hash table entries: 16384 (order 4, 64k)
VFS: Diskquotas version dquot_6.4.0 initialized
CPU: Intel Pentium 75 - 200 stepping 0c
Checking 386/387 coupling... OK, FPU using exception 16 error reporting.
Checking 'hlt' instruction... OK.
Intel Pentium with F0 0F bug - workaround enabled.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfb230
PCI: Using configuration type 1
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
TCP: Hash tables configured (ehash 65536 bhash 65536)
Initializing RT netlink socket
Starting kswapd v 1.5 
Serial driver version 4.27 with no serial options enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
pty: 256 Unix98 ptys configured
PIIX3: IDE controller on PCI bus 00 dev 39
PIIX3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
hda: QUANTUM BIGFOOT2550A, ATA DISK drive
hdb: CDA46803I, ATAPI CDROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: QUANTUM BIGFOOT2550A, 2457MB w/87kB Cache, CHS=624/128/63, DMA
hdb: ATAPI 4X CD-ROM drive, 240kB Cache
Uniform CD-ROM driver Revision: 3.11
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 hda10 >

-- 
José Luis Domingo López
Linux Registered User #189436     Debian GNU/Linux Potato (P166 64 MB RAM)
 
jdomingo EN internautas PUNTO org  => ¿ Spam ? Atente a las consecuencias
jdomingo AT internautas DOT   org  => Spam at your own risk

