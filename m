Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131272AbRCRVYB>; Sun, 18 Mar 2001 16:24:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131273AbRCRVXw>; Sun, 18 Mar 2001 16:23:52 -0500
Received: from pragmatix.bangor.ac.uk ([147.143.2.14]:39147 "EHLO
	pragmatix.bangor.ac.uk") by vger.kernel.org with ESMTP
	id <S131272AbRCRVXo>; Sun, 18 Mar 2001 16:23:44 -0500
Message-ID: <3AB52731.189524DD@bangor.ac.uk>
Date: Sun, 18 Mar 2001 21:22:57 +0000
From: "C.Backstrom" <chp802@bangor.ac.uk>
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel panic: Aiee, killing interrupt handler!
Content-Type: multipart/mixed;
 boundary="------------0F569A9D85A58830F6AB36B0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------0F569A9D85A58830F6AB36B0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi, 

I got this machine, which I use for my research groups file (samba) and
printing (lpd over samba) needs. This is the second time it has gone down
for me, as shown below. There's really nothing to say about it; it has
worked fine for about two weeks, and then an unprovoked panic. As you might
see, it went down on a saturday, and this is the only thing in the log on
that day; it's been standing idle for the whole day. The spec. is, as I'm
sure you can see from the dmesg+lspci attachment:

Pentium 90MHz
32Mb RAM
SiS  85C501/2
CMD640 IDE
SMC-Ultra 8216C
IBM Deskstar DTLA-305040 41Gb, 128Mb swap, 2Gb ext2, and the rest one big
reiserfs.
linux-2.4.2
RedHat 6.2

I have to use setmax (from LARGE-HDD-HOWTO) in order to get the deskstar to
mount. An oddity is this; We didn't have enough network points in our
office, so I made a bridge (the bridging code is compiled into the kernel),
using a second (SMC-Ultra) network card. And all of a sudden, I didn't have
to use setmax any more. The kernel took care of the disk fine. As we got
new points installed, I stopped using the bridge, and, once again I had to
use setmax. Strange. I must add, I've used this machine for about a year to
run an instrument, without any problems, only with linux-2.2 and a 6Gb
harddrive instead of the deskstar. I've also added an extra ISA card
parport for a second printer. I hope something of this helps. And if
someone could tell me what is wrong here, I would be much obliged. I've had
much resistance within the university for using linux as it is, and, if it
starts going down every now and again, they'll chuck it out without a
doubt. If I can do somthing else, in order to help, plese let me know.
Cheeres,

/Chris

Kernel panic: Aiee, killing interrupt handler!
In interrupt handler not syncing
Unable to handle kernel NULL pointer dereference at virtual address
0000000b
printing eip:
c01104c3
*pde = 00000000
Oops: 0000
CPU: 0
EIP: 0010: [<c01104c3>]
EFLAGS: 00010013
eax: 00000000 epx: 0000000b ecx: c10a6000 edx: c02108dc
esi: c0210c18 edi: 00000003 ebp: c10a5eb0 esp: c10a5e94
Process kreclaimd pid:4, stackpage = c10a5000
Stack:
c02109c0 c0210c18 00000000 c02108dc 00000001 00000286 00000001 00000002
c0128335 00000020 00000002 c10af124 00000002 00000002 00000000 c0210c10
c012850c c012532a c10af124 00000246 00000002 00000021 00000003 c0125467
Call trace: 
[<c0128335>] [<c012850c>] [<c012532a>] [<c01254bf>] [<c019eb02>]
[<c0185719>] [<c018526e>]
[<c0109fdf>] [<c010a13e>] [<c0108e60>] [<c0112270>]
Code: 8b 1b 8b 4f 04 8b 01 85 45 fc 74 51 31 c0 9c 5e fa c7 01 00
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler not syncing



-- 
------------ 
Christer Bäckström

Optoelectronic Materials Chemistry Group
Department of Chemistry
University of Wales, Bangor
Bangor, Gwynedd
LL57 2UW Wales, UK

E-mail			: chp802@bangor.ac.uk 
Telephone Office	: +44(0)1248 388302
Telephone Laboratory	: +44(0)1248 388304
--------------0F569A9D85A58830F6AB36B0
Content-Type: text/plain; charset=us-ascii;
 name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg"

Linux version 2.4.2 (root@omc.bangor.ac.uk) (gcc version 2.95.3 19991030 (prerelease)) #23 Thu Feb 22 22:03:19 GMT 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)
 BIOS-e820: 0000000000018000 @ 00000000000e8000 (reserved)
 BIOS-e820: 0000000001f00000 @ 0000000000100000 (usable)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
On node 0 totalpages: 8192
zone(0): 4096 pages.
zone(1): 4096 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=2 ro root=302 hda=79780,16,63
ide_setup: hda=79780,16,63
Initializing CPU#0
Detected 90.001 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 179.40 BogoMIPS
Memory: 30320k/32768k available (846k kernel code, 2060k reserved, 286k data, 180k init, 0k highmem)
Dentry-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 2048 (order: 2, 16384 bytes)
CPU: Before vendor init, caps: 000001bf 00000000 00000000, vendor = 0
Intel Pentium with F0 0F bug - workaround enabled.
CPU: After vendor init, caps: 000001bf 00000000 00000000 00000000
CPU: After generic, caps: 000001bf 00000000 00000000 00000000
CPU: Common caps: 000001bf 00000000 00000000 00000000
CPU: Intel Pentium 75 - 200 stepping 04
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.00 entry at 0xfc920, last bus=0
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Unable to handle 64-bit address for device 00:00.0
PCI: Unable to handle 64-bit address for device 00:00.0
PCI: Unable to handle 64-bit address for device 00:00.0
PCI: Failed to allocate resource 1 for Silicon Integrated Systems [SiS] 85C501/2
PCI: Failed to allocate resource 3 for Silicon Integrated Systems [SiS] 85C501/2
PCI: Failed to allocate resource 5 for Silicon Integrated Systems [SiS] 85C501/2
isapnp: Scanning for Pnp cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd v1.8
0x378: FIFO is 16 bytes
0x378: writeIntrThreshold is 8
0x378: readIntrThreshold is 1
0x378: PWord is 8 bits
0x378: Interrupts are ISA-Pulses
0x378: ECP port cfgA=0x10 cfgB=0x40
0x378: ECP settings irq=<none or set by other means> dma=<none or set by other means>
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,COMPAT,ECP]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport1: PC-style at 0x278 [PCSPP,TRISTATE,EPP]
parport1: cpp_daisy: aa5500ff(18)
parport1: assign_addrs: aa5500ff(18)
parport1: Printer, EPSON Stylus Photo 750
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
lp0: using parport0 (polling).
lp1: using parport1 (polling).
block: queued sectors max/low 20058kB/6686kB, 64 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
CMD640: ignored by ide_scan_pci_device() (uses own driver)
ide0: buggy cmd640b interface on PCI (type1), config=0x5e
ide1: not serialized, secondary interface not responding
cmd640: drive0 timings/prefetch(on) preserved, clocks=4/16/17
cmd640: drive1 timings/prefetch(on) preserved, clocks=4/16/17
hda: IBM-DTLA-305040, ATA DISK drive
hdb: NEC CD-ROM DRIVE:251, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 66055248 sectors (33820 MB) w/380KiB Cache, CHS=79780/16/63
Partition check:
 hda: hda1 hda2 hda3
smc-ultra.c:v2.02 2/3/98 Donald Becker (becker@cesdis.gsfc.nasa.gov)
eth0: SMC Ultra at 0x300, 00 00 C0 51 FD A2, IRQ 10 memory 0xcc000-0xcffff.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 2048)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
NET4: Ethernet Bridge 008 for NET4.0
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 180k freed
Adding Swap: 136512k swap-space (priority -1)
reiserfs: checking transaction log (device 03:03) ...
reiserfs: replayed 1 transactions in 19 seconds
Using r5 hash to sort names
reiserfs: using 3.5.x disk format
ReiserFS version 3.6.25

--------------0F569A9D85A58830F6AB36B0
Content-Type: text/plain; charset=us-ascii;
 name="ksymoops.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ksymoops.out"

ksymoops 0.7c on i586 2.4.2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.2/ (default)
     -m /boot/System.map (specified)

Mar 17 04:02:34 omc kernel: Unable to handle kernel paging request at virtual address d1143a18 
Mar 17 04:02:34 omc kernel: c0125656 
Mar 17 04:02:34 omc kernel: *pde = 00000000 
Mar 17 04:02:34 omc kernel: Oops: 0002 
Mar 17 04:02:34 omc kernel: CPU:    0 
Mar 17 04:02:34 omc kernel: EIP:    0010:[kfree+66/176] 
Mar 17 04:02:34 omc kernel: EFLAGS: 00010003 
Mar 17 04:02:34 omc kernel: eax: 00000003   ebx: c103aac8   ecx: c103582c   edx: 0000000e 
Mar 17 04:02:34 omc kernel: esi: 04043875   edi: 00000282   ebp: 00000329   esp: c10a7f90 
Mar 17 04:02:34 omc kernel: ds: 0018   es: 0018   ss: 0018 
Mar 17 04:02:34 omc kernel: Process kswapd (pid: 3, stackpage=c10a7000) 
Mar 17 04:02:34 omc kernel: Stack: c0b3c740 c0cab5e0 c03bb440 00000329 c013dba7 c0ca9640 00010f00 00000004  
Mar 17 04:02:34 omc kernel:        00000000 00000000 c013de51 0000042c c0127617 00000006 00000004 00010f00  
Mar 17 04:02:34 omc kernel:        c01dd0d7 c10a6239 0008e000 c012769b 00000004 00000000 c10b7fb8 00000000  
Mar 17 04:02:34 omc kernel: Call Trace: [prune_dcache+279/344] [shrink_dcache_memory+33/48] [do_try_to_free_pages+95/124] [kswapd+103/244] [kernel_thread+40/56]  
Mar 17 04:02:34 omc kernel: Code: 89 44 b1 18 89 71 14 8b 53 14 8b 41 10 ff 49 10 39 d0 74 08  
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   89 44 b1 18               mov    %eax,0x18(%ecx,%esi,4)
Code;  00000004 Before first symbol
   4:   89 71 14                  mov    %esi,0x14(%ecx)
Code;  00000007 Before first symbol
   7:   8b 53 14                  mov    0x14(%ebx),%edx
Code;  0000000a Before first symbol
   a:   8b 41 10                  mov    0x10(%ecx),%eax
Code;  0000000d Before first symbol
   d:   ff 49 10                  decl   0x10(%ecx)
Code;  00000010 Before first symbol
  10:   39 d0                     cmp    %edx,%eax
Code;  00000012 Before first symbol
  12:   74 08                     je     1c <_EIP+0x1c> 0000001c Before first symbol

Mar 17 04:02:35 omc kernel: invalid operand: 0000 
Mar 17 04:02:35 omc kernel: CPU:    0 
Mar 17 04:02:35 omc kernel: EIP:    0010:[do_exit+554/564] 
Mar 17 04:02:35 omc kernel: EFLAGS: 00010286 
Mar 17 04:02:35 omc kernel: eax: 0000001a   ebx: c020d980   ecx: c10a6000   edx: 00000000 
Mar 17 04:02:35 omc kernel: esi: c10a6000   edi: 0000000b   ebp: c10a6000   esp: c10a7e88 
Mar 17 04:02:35 omc kernel: ds: 0018   es: 0018   ss: 0018 
Mar 17 04:02:35 omc kernel: Process kswapd (pid: 3, stackpage=c10a7000) 
Mar 17 04:02:35 omc kernel: Stack: c01d9d2b c01d9e62 000001ca 00000000 00000002 d1143a18 c010930e 0000000b  
Mar 17 04:02:35 omc kernel:        c010fa37 c01d86fe c10a7f5c 00000002 c10a6000 00000002 c010f724 00000329  
Mar 17 04:02:35 omc kernel:        00000100 00000000 00000000 00181c28 c10f9980 c01703dc c0270be0 00000001  

--------------0F569A9D85A58830F6AB36B0
Content-Type: text/plain; charset=us-ascii;
 name="messages"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="messages"

Mar 16 16:55:04 omc pumpd[258]: renewed lease for interface eth0
Mar 16 17:25:06 omc PAM_pwdb[10592]: authentication failure; (uid=0) -> chs806 for samba service
Mar 17 03:25:04 omc pumpd[258]: renewed lease for interface eth0
Mar 17 04:02:34 omc kernel: Unable to handle kernel paging request at virtual address d1143a18 
Mar 17 04:02:34 omc kernel:  printing eip: 
Mar 17 04:02:34 omc kernel: c0125656 
Mar 17 04:02:34 omc kernel: *pde = 00000000 
Mar 17 04:02:34 omc kernel: Oops: 0002 
Mar 17 04:02:34 omc kernel: CPU:    0 
Mar 17 04:02:34 omc kernel: EIP:    0010:[kfree+66/176] 
Mar 17 04:02:34 omc kernel: EFLAGS: 00010003 
Mar 17 04:02:34 omc kernel: eax: 00000003   ebx: c103aac8   ecx: c103582c   edx: 0000000e 
Mar 17 04:02:34 omc kernel: esi: 04043875   edi: 00000282   ebp: 00000329   esp: c10a7f90 
Mar 17 04:02:34 omc kernel: ds: 0018   es: 0018   ss: 0018 
Mar 17 04:02:34 omc kernel: Process kswapd (pid: 3, stackpage=c10a7000) 
Mar 17 04:02:34 omc kernel: Stack: c0b3c740 c0cab5e0 c03bb440 00000329 c013dba7 c0ca9640 00010f00 00000004  
Mar 17 04:02:34 omc kernel:        00000000 00000000 c013de51 0000042c c0127617 00000006 00000004 00010f00  
Mar 17 04:02:34 omc kernel:        c01dd0d7 c10a6239 0008e000 c012769b 00000004 00000000 c10b7fb8 00000000  
Mar 17 04:02:34 omc kernel: Call Trace: [prune_dcache+279/344] [shrink_dcache_memory+33/48] [do_try_to_free_pages+95/124] [kswapd+103/244] [kernel_thread+40/56]  
Mar 17 04:02:34 omc kernel:  
Mar 17 04:02:34 omc kernel: Code: 89 44 b1 18 89 71 14 8b 53 14 8b 41 10 ff 49 10 39 d0 74 08  
Mar 17 04:02:35 omc kernel: kernel BUG at exit.c:458! 
Mar 17 04:02:35 omc kernel: invalid operand: 0000 
Mar 17 04:02:35 omc kernel: CPU:    0 
Mar 17 04:02:35 omc kernel: EIP:    0010:[do_exit+554/564] 
Mar 17 04:02:35 omc kernel: EFLAGS: 00010286 
Mar 17 04:02:35 omc kernel: eax: 0000001a   ebx: c020d980   ecx: c10a6000   edx: 00000000 
Mar 17 04:02:35 omc kernel: esi: c10a6000   edi: 0000000b   ebp: c10a6000   esp: c10a7e88 
Mar 17 04:02:35 omc kernel: ds: 0018   es: 0018   ss: 0018 
Mar 17 04:02:35 omc kernel: Process kswapd (pid: 3, stackpage=c10a7000) 
Mar 17 04:02:35 omc kernel: Stack: c01d9d2b c01d9e62 000001ca 00000000 00000002 d1143a18 c010930e 0000000b  
Mar 17 04:02:35 omc kernel:        c010fa37 c01d86fe c10a7f5c 00000002 c10a6000 00000002 c010f724 00000329  
Mar 17 04:02:35 omc kernel:        00000100 00000000 00000000 00181c28 c10f9980 c01703dc c0270be0 00000001  
Mar 18 18:51:53 omc syslogd 1.3-3: restart.
Mar 18 18:51:53 omc syslog: syslogd startup succeeded

--------------0F569A9D85A58830F6AB36B0
Content-Type: text/plain; charset=us-ascii;
 name="lspci"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci"

00:00.0 Class 0406: Silicon Integrated Systems [SiS] 85C501/2 (rev 39)
00: 39 10 06 04 06 00 00 60 39 10 06 04 06 00 00 60
10: 10 00 00 80 14 00 00 80 18 00 00 80 1c 00 00 80
20: 20 00 00 80 24 00 00 80 28 00 00 80 2c 00 00 80
30: 30 00 00 80 34 00 00 80 38 00 00 80 3c 00 00 80
40: 40 00 00 80 44 00 00 80 48 00 00 80 4c 00 00 80
50: b6 d5 60 61 30 00 c0 10 fc 00 00 e2 e0 11 3e 0a
60: 06 02 02 00 ff 00 00 ff 03 00 00 ff ff ff ff 44
70: 70 00 00 80 74 00 00 80 78 00 00 80 7c 00 00 80
80: 80 00 00 80 84 00 00 80 88 00 00 80 8c 00 00 80
90: 90 00 00 80 94 00 00 80 98 00 00 80 9c 00 00 80
a0: a0 00 00 80 a4 00 00 80 a8 00 00 80 ac 00 00 80
b0: b0 00 00 80 b4 00 00 80 b8 00 00 80 bc 00 00 80
c0: c0 00 00 80 c4 00 00 80 c8 00 00 80 cc 00 00 80
d0: d0 00 00 80 d4 00 00 80 d8 00 00 80 dc 00 00 80
e0: e0 00 00 80 e4 00 00 80 e8 00 00 80 ec 00 00 80
f0: f0 00 00 80 f4 00 00 80 f8 00 00 80 fc 00 00 80

00:01.0 Non-VGA unclassified device: Silicon Integrated Systems [SiS] 85C503/5513
00: 39 10 08 00 07 00 00 02 00 00 00 00 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 0a 80 0b 00 80 00 00 00 ff 00 10 0f 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0b.0 VGA compatible controller: Cirrus Logic GD 5434-8 [Alpine] (rev 8e)
00: 13 10 a8 00 03 00 00 00 8e 00 00 03 00 00 00 00
10: 00 00 00 fa 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0d.0 IDE interface: CMD Technology Inc PCI0640 (rev 02)
00: 95 10 40 06 00 00 00 02 02 0a 01 01 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0e 01 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 5e 08 00 00 00 00 00 00 00 40 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


--------------0F569A9D85A58830F6AB36B0
Content-Type: text/plain; charset=us-ascii;
 name=".config"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename=".config"

#
# Automatically generated by make menuconfig: don't edit
#
CONFIG_X86=y
CONFIG_ISA=y
# CONFIG_SBUS is not set
CONFIG_UID16=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
CONFIG_M586TSC=y
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_USE_STRING_486=y
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_TSC=y
# CONFIG_TOSHIBA is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
# CONFIG_MTRR is not set
# CONFIG_SMP is not set
# CONFIG_X86_UP_IOAPIC is not set

#
# General setup
#
CONFIG_NET=y
# CONFIG_VISWS is not set
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_EISA=y
# CONFIG_MCA is not set
# CONFIG_HOTPLUG is not set
# CONFIG_PCMCIA is not set
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
CONFIG_PM=y
# CONFIG_ACPI is not set
CONFIG_APM=m
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
# CONFIG_APM_CPU_IDLE is not set
# CONFIG_APM_DISPLAY_BLANK is not set
CONFIG_APM_RTC_IS_GMT=y
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_PC_FIFO=y
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AMIGA is not set
# CONFIG_PARPORT_MFC3 is not set
# CONFIG_PARPORT_ATARI is not set
# CONFIG_PARPORT_SUNBPP is not set
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play configuration
#
CONFIG_PNP=y
CONFIG_ISAPNP=y

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
CONFIG_BLK_DEV_LOOP=m
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_INITRD is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set
# CONFIG_BLK_DEV_MD is not set
# CONFIG_MD_LINEAR is not set
# CONFIG_MD_RAID0 is not set
# CONFIG_MD_RAID1 is not set
# CONFIG_MD_RAID5 is not set
# CONFIG_BLK_DEV_LVM is not set

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK=y
CONFIG_RTNETLINK=y
# CONFIG_NETLINK_DEV is not set
# CONFIG_NETFILTER is not set
# CONFIG_FILTER is not set
CONFIG_UNIX=y
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_IPV6 is not set
# CONFIG_KHTTPD is not set
# CONFIG_ATM is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_DECNET is not set
CONFIG_BRIDGE=y
# CONFIG_X25 is not set
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
# CONFIG_NET_SCHED is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set
# CONFIG_PHONE_IXJ is not set

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
# CONFIG_BLK_DEV_IDEDISK_FUJITSU is not set
# CONFIG_BLK_DEV_IDEDISK_IBM is not set
# CONFIG_BLK_DEV_IDEDISK_MAXTOR is not set
# CONFIG_BLK_DEV_IDEDISK_QUANTUM is not set
# CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set
# CONFIG_BLK_DEV_IDEDISK_WD is not set
# CONFIG_BLK_DEV_COMMERIAL is not set
# CONFIG_BLK_DEV_TIVO is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=m
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_BLK_DEV_CMD640=y
CONFIG_BLK_DEV_CMD640_ENHANCED=y
# CONFIG_BLK_DEV_ISAPNP is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_AEC62XX_TUNING is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD7409 is not set
# CONFIG_AMD7409_OVERRIDE is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_PIIX_TUNING is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX is not set
# CONFIG_PDC202XX_BURST is not set
# CONFIG_BLK_DEV_OSB4 is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y

#
# SCSI support
#
CONFIG_SCSI=m
CONFIG_BLK_DEV_SD=m
CONFIG_SD_EXTRA_DEVS=40
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=m
# CONFIG_SCSI_DEBUG_QUEUES is not set
CONFIG_SCSI_MULTI_LUN=y
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
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_MEGARAID is not set
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
CONFIG_SCSI_PPA=m
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_IZIP_EPP16 is not set
# CONFIG_SCSI_IZIP_SLOW_CTR is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_NCR53C7xx is not set
# CONFIG_SCSI_NCR53C8XX is not set
CONFIG_SCSI_SYM53C8XX=m
CONFIG_SCSI_NCR53C8XX_DEFAULT_TAGS=4
CONFIG_SCSI_NCR53C8XX_MAX_TAGS=32
CONFIG_SCSI_NCR53C8XX_SYNC=20
# CONFIG_SCSI_NCR53C8XX_PROFILE is not set
# CONFIG_SCSI_NCR53C8XX_IOMAPPED is not set
# CONFIG_SCSI_NCR53C8XX_PQS_PDS is not set
# CONFIG_SCSI_NCR53C8XX_SYMBIOS_COMPAT is not set
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
# CONFIG_SCSI_DEBUG is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set
# CONFIG_I2O_PCI is not set
# CONFIG_I2O_BLOCK is not set
# CONFIG_I2O_LAN is not set
# CONFIG_I2O_SCSI is not set
# CONFIG_I2O_PROC is not set

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
CONFIG_NET_VENDOR_SMC=y
# CONFIG_WD80x3 is not set
CONFIG_ULTRA=y
# CONFIG_ULTRA32 is not set
# CONFIG_SMC9194 is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
# CONFIG_NET_PCI is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_SK98LIN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

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
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

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
# CONFIG_INPUT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=m
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=y
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
CONFIG_MOUSE=m
CONFIG_PSMOUSE=y
# CONFIG_82C710_MOUSE is not set
# CONFIG_PC110_PAD is not set

#
# Joysticks
#
# CONFIG_JOYSTICK is not set
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_INTEL_RNG is not set
# CONFIG_NVRAM is not set
# CONFIG_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
# CONFIG_AGP is not set
# CONFIG_DRM is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=m
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BFS_FS is not set
CONFIG_FAT_FS=m
# CONFIG_MSDOS_FS is not set
# CONFIG_UMSDOS_FS is not set
CONFIG_VFAT_FS=m
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_RAMFS is not set
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
# CONFIG_MINIX_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
# CONFIG_SYSV_FS_WRITE is not set
# CONFIG_UDF_FS is not set
# CONFIG_UDF_RW is not set
# CONFIG_UFS_FS is not set
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_NFS_FS is not set
# CONFIG_NFS_V3 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFSD is not set
# CONFIG_NFSD_V3 is not set
# CONFIG_SUNRPC is not set
# CONFIG_LOCKD is not set
CONFIG_SMB_FS=m
# CONFIG_SMB_NLS_DEFAULT is not set
# CONFIG_NCP_FS is not set
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=m
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
CONFIG_NLS_ISO8859_1=m
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=m
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_UTF8 is not set

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
# CONFIG_VIDEO_SELECT is not set
# CONFIG_MDA_CONSOLE is not set

#
# Frame-buffer support
#
# CONFIG_FB is not set

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
# CONFIG_USB is not set

#
# Kernel hacking
#
# CONFIG_MAGIC_SYSRQ is not set

--------------0F569A9D85A58830F6AB36B0--

