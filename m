Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277064AbRJDBWk>; Wed, 3 Oct 2001 21:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277065AbRJDBWV>; Wed, 3 Oct 2001 21:22:21 -0400
Received: from 200-221-84-35.dsl-sp.uol.com.br ([200.221.84.35]:38660 "HELO
	dumont.rtb.ath.cx") by vger.kernel.org with SMTP id <S277064AbRJDBWM>;
	Wed, 3 Oct 2001 21:22:12 -0400
Date: Wed, 3 Oct 2001 22:22:19 -0300
From: =?us-ascii?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: linux-kernel@vger.kernel.org
Cc: debian-powerpc@lists.debian.org
Subject: Panic on PowerPC
Message-ID: <20011003222219.A487@iname.com>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	debian-powerpc@lists.debian.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Dear people,

	(Please CC me as I'm not currently subscribed to linux-kernel)

	I'm trying to compile a new kernel for a PowerMac 9500/180MP
	that I just got on a loan (so that I can learn a tiny bit
	about PowerPCs) and I originally installed Debian's woody on
	it (since this is the distribution with which I feel most
	comfortable).

	Even though MacOS 8.6 runs perfectly (and fast) with it, I was
	having serious problems getting X 4 working with the IMS TT
	video card on it and, searching the web, I found out that it
	was probably because the card was not being listed on the PCI
	devices list (e.g., the card does not show with lspci) and
	that a newer 2.4 kernel would possibly cure the problem
	(Debian's default kernel is a 2.2.19 or something like that).

	After having serious headaches, I tried grabbing benh's kernel
	tree and compiled a brand new kernel for my computer. But I
	couldn't get it booting, since it always Oopsed, even BEFORE
	init was called.

	Then, I tried installing Yellow Dog Linux. Its default kernel
	is also a 2.2.19 that works perfectly, but still I could not
	get X working with the imstt driver (but now I can, at least,
	use the fbdev driver). Then, I tried compiling a new 2.4
	kernel, taken from rsync.peguinppc.org, the bitkeeper "stable"
	2.4 kernel. The precise version that I got was 2.4.10-pre12.

	It still generated an Oops, consistently and with the same
	values for the registers and memory positions. Now, I wrote
	down the Oops (since init was not even started at the time of
	the Oops it was not in the logs) and decoded it with ksymoops.

	So, can anybody help me please compiling a new kernel 2.4 for
	this machine?

	The files taken from /proc were grabbed with kernel 2.2.19-1k
	(from Yellow Dog Linux), since as described above, I couldn't
	get the system to start with 2.4.x.


dmesg output:
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
device tree used 31436 bytes
Total memory = 64MB; using 256kB for hash table (at c03c0000)
Linux version 2.2.19-1k (root@kaelta.terraplex.com) (gcc version 2.95.3 20010111 (prerelease/franzo/20010111)) #1 Thu May 31 14:57:36 MDT 2001
PCI bus 0 controlled by bandit at f2000000
Cache coherency enabled for bandit/PSX at f2000000
PCI bus 1 controlled by bandit at f4000000
Cache coherency enabled for bandit/PSX at f4000000
pmac nvram is core99: 0
System has 32 possible interrupts
GMT Delta read from XPRAM: -180 minutes, DST: off
via_calibrate_decr: decrementer_count = 112500 (675004 ticks)
Console: colour dummy device 80x25
Calibrating delay loop... 359.62 BogoMIPS
Memory: 60676k available (1784k kernel code, 2888k data, 188k init) [c0000000,c4000000]
Dentry hash table entries: 8192 (order 4, 64k)
Buffer cache hash table entries: 65536 (order 6, 256k)
Page cache hash table entries: 16384 (order 4, 64k)
VFS: Diskquotas version dquot_6.4.0 initialized
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
adb devices: [2]: 2 2 [3]: 3 1
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
TCP: Hash tables configured (ehash 65536 bhash 65536)
NET4: AppleTalk 0.18 for Linux NET4.0
Initializing RT netlink socket
Starting kswapd v 1.5 
clgen: Driver for Cirrus Logic based graphic boards, v1.5.2
 Couldn't find PCI device
MacOS display is /bandit/IMS,tt128mbA
Console: switching to colour frame buffer device 104x39
fb0: IMS TT (IBM) frame buffer; 4MB vram; chip version 2
IBM_E15: initializing
IBM_E15: could not find S3 864 in system
input0: Macintosh mouse button emulation
Serial driver version 4.27 with no serial options enabled
PowerMac Z8530 serial driver version 2.0
ttyS0 at 0xf3013020 (irq = 15) is a Z8530 ESCC, port = modem
ttyS1 at 0xf3013000 (irq = 16) is a Z8530 ESCC, port = printer
pty: 256 Unix98 ptys configured
Macintosh non-volatile memory driver v1.0
RAM disk driver initialized:  16 RAM disks of 16384K size
loop: registered device at major 7
fd0: SWIM3 floppy controller 
md driver 0.36.6 MAX_MD_DEV=4, MAX_REAL=8
scsi0 : MESH
scsi1 : 53C94
scsi : 2 hosts.
mesh: target 0 synchronous at 5.0 MB/s
  Vendor: QUANTUM   Model: FIREBALL_TM3200S  Rev: 300N
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
mesh: target 3 synchronous at 5.0 MB/s
  Vendor: MATSHITA  Model: CD-ROM CR-8008    Rev: 8.0h
  Type:   CD-ROM                             ANSI SCSI revision: 02
Detected scsi CD-ROM sr0 at scsi0, channel 0, id 3, lun 0
scsi : detected 1 SCSI cdrom 1 SCSI disk total.
Uniform CD-ROM driver Revision: 3.11
SCSI device sda: hdwr sector= 512 bytes. Sectors= 6281856 [3067 MB] [3.1 GB]
eth0: MACE at 00:05:02:1c:29:41, chip revision 25.64
Partition check:
 sda: sda1 sda2 sda3 sda4 sda5 sda6 sda7 sda8
ADB keyboard at 2, handler set to 3
Detected ADB keyboard, type ANSI.
input1: ADB HID on ID 2:2.02
ADB mouse at 3, handler set to 2
input2: ADB HID on ID 3:3.01
usb.c: registered new driver hid
keybdev.c: Adding keyboard: input1
mouse0: PS/2 mouse device for input2
mouse1: PS/2 mouse device for input0
mice: PS/2 mouse device common for all mice
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 188k init 32k prep
Adding Swap: 257508k swap-space (priority -1)
DMA sound driver core [Ed 19] [4 buffers of 32k for output]
............................. [4 buffers of 32k for  input]
DMA sound driver core called by PowerMac (AWACS rev 2 ) 
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


The oops decoded (the oops was handwritten and may not be accurate):
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
ksymoops 2.4.3 on ppc 2.2.19-1k.  Options used
     -v ../linux/vmlinux (specified)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.4.10-pre12-1/ (specified)
     -m ../linux/System.map (specified)

No modules in ksyms, skipping objects
Machine check in kernel mode.
Oops: machine check, sig 7
NIP: C0005D58  XER: 00000000  LR: C017594C  SP: C04E9FA0  REGS: c04e9ef0 TRAP: 0200
Using defaults from ksymoops -t elf32-powerpc -a powerpc:common
MSR: 00041030  EE: 0  PR: 0  FP: 0  ME: 1 IR/DR: 11
TASK = c04e8000[1] 'swapper'  Last syscall: 120
last math 00000000 last altivec 00000000
GPR00: 00000086 C04E9FA0 C04E8000 00009032 C04E1F40 00000000 C04E1F90 00000000
GPR08: C01BF5EC FD601071 C01D0000 C0160000 82000022 002F90A8 00000000 00000000
GPR16: 00000000 00000000 00000000 00000000 003FF000 00000000 00000000 00000000
GPR24: 00000000 00000000 40000000 002F9000 00000000 C0150000 C008DF14 00000000
Call backtrace:
C01758C8 C016576C C01657B8 C00038A4 C00062A4
Kernel panic: Attempted to kill init!
Warning (Oops_read): Code line not seen, dumping what data is available

>>NIP; c0005d58 <__sti+8/50>   <=====
Trace; c01758c8 <rtc_init+b8/16c>
Trace; c016576c <do_initcalls+30/50>
Trace; c01657b8 <do_basic_setup+2c/3c>
Trace; c00038a4 <init+14/1b0>
Trace; c00062a4 <kernel_thread+34/40>


1 warning issued.  Results may not be reliable.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

	I see that the format of an Oops for PowerPC is different from
	that of x86 and that may be the cause of the warning. Is there
	anything that I can do to make ksymoops output more readable?


Output of lspci -vv:
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
00:0b.0 Host bridge: Apple Computer Inc. Bandit PowerPC host bridge (rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32, cache line size 08

00:10.0 Class ff00: Apple Computer Inc. Grand Central I/O (rev 02)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 32, cache line size 08
	Region 0: Memory at f3000000 (32-bit, non-prefetchable)
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

/proc/cpuinfo:
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
processor	: 0
cpu		: 604e
clock		: 180MHz
revision	: 2.2
bogomips	: 360.12
zero pages	: total 0 (0Kb) current: 0 (0Kb) hits: 0/78 (0%)
machine		: Power Macintosh
motherboard	: AAPL,9500 MacRISC
L2 cache	: 512K unified
memory		: 64MB
pmac-generation	: OldWorld
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

	I have put all information that I think is relevant at
	http://www.ime.usp.br/~rbrito/mac/ , but if something else is
	needed, then please let me know and I'll try my best to help
	with development. Don't hesitate to ask anything.


	Thank you very much for any help or recommendations, Roger...

-- 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  Rogério Brito - rbrito@ime.usp.br - http://www.ime.usp.br/~rbrito/
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
