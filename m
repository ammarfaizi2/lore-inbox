Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265898AbTAZAoV>; Sat, 25 Jan 2003 19:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266095AbTAZAoV>; Sat, 25 Jan 2003 19:44:21 -0500
Received: from [64.8.50.202] ([64.8.50.202]:50579 "EHLO mta10.adelphia.net")
	by vger.kernel.org with ESMTP id <S265898AbTAZAoN>;
	Sat, 25 Jan 2003 19:44:13 -0500
From: "Robert E. Kearney Jr." <rekearney@adelphia.net>
To: <linux-kernel@vger.kernel.org>
Subject: Problems moving to 2.4.x from 2.2.x kernel  (unable to handle kernel paging request)
Date: Sat, 25 Jan 2003 19:53:15 -0500
Message-ID: <000601c2c4d5$4f24b8c0$7010a8c0@mozart>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'v been running fine for quite a while now, and figured its time to
update my kernel, and some of the software. I downloaded 2.4.20,
configured according to my previous kernel build on 2.2.16, compiled and
installed.  However, after about 1 min, I get a kernel panic(unable to
handle kernel paging request at virtual addres ....), usually kswapd,
sometimes machine dies right away, other times.. It dies a few seconds
later.  

No single command seems to initiate the panic....

I read through other posts, but couldn't find anything relevant.  I
reconfigured kernel and recompiled several times with different configs,
but each time, I still get the same response.  Hoping anyone can help
out here.  The only relevent topic I found about this problem is where
one user was getting this on 2.4.20, and reverted back to 2.4.18, I
tried 2.4.18 also with several configs...


Thanks for any help..


Here are some of the oops messages, 
Jan 23 22:18:56 terminus kernel: Unable to handle kernel paging request
at virtual address 00003600
Jan 23 22:18:56 terminus kernel:  printing eip:
Jan 23 22:18:56 terminus kernel: 00003600
Jan 23 22:18:56 terminus kernel: *pde = 00000000
Jan 23 22:18:56 terminus kernel: Oops: 0000
Jan 23 22:18:56 terminus kernel: CPU:    0
Jan 23 22:18:56 terminus kernel: EIP:
0010:[cpuid_exit+13824/-1072693248]    Not tainted
Jan 23 22:18:56 terminus kernel: EFLAGS: 00010202
Jan 23 22:18:56 terminus kernel: eax: 00000001   ebx: c02770a0   ecx:
c180a000   edx: 00000036
Jan 23 22:18:56 terminus kernel: esi: 00000036   edi: 0000000b   ebp:
000000c7   esp: c003ff28
Jan 23 22:18:56 terminus kernel: ds: 0018   es: 0018   ss: 0018
Jan 23 22:18:56 terminus kernel: Process kswapd (pid: 4,
stackpage=c003f000)
Jan 23 22:18:56 terminus kernel: Stack: c0013a30 c0126cf3 c02770a0
00000202 c003e000 00000008 000001d0 c021bd00 
Jan 23 22:18:56 terminus kernel:        c02980c0 c009bf40 c009e6a8
00000000 00000020 000001d0 00000006 00000cd0 
Jan 23 22:18:56 terminus kernel:        c0126e85 00000006 0000000c
c021bd00 00000006 000001d0 c021bd00 00000000 
Jan 23 22:18:56 terminus kernel: Call Trace:    [shrink_cache+723/784]
[shrink_caches+85/128] [try_to_free_pages_zone+48/80]
[kswapd_balance_pgdat+69/144] [kswapd_balance+22/48]
Jan 23 22:18:56 terminus kernel:   [kswapd+161/192] [kswapd+0/192]
[kernel_thread+43/64]

------------------------------------------------------------------------
----------------------
Bootup on 2.4.20, with oops stuff

Jan 23 22:17:05 terminus syslog: klogd shutdown succeeded
Jan 23 22:17:05 terminus exiting on signal 15
Jan 23 22:18:08 terminus syslogd 1.3-3: restart.
Jan 23 22:18:08 terminus syslog: syslogd startup succeeded
Jan 23 22:18:08 terminus syslog: klogd startup succeeded
Jan 23 22:18:08 terminus kernel: klogd 1.3-3, log source = /proc/kmsg
started.
Jan 23 22:18:08 terminus kernel: Inspecting /boot/System.map
Jan 23 22:18:08 terminus random: Initializing random number generator:
succeeded
Jan 23 22:18:09 terminus xinetd[393]: failed to parse 192.168.16.100,
[line=16]
Jan 23 22:18:09 terminus kernel: Loaded 12797 symbols from
/boot/System.map.
Jan 23 22:18:09 terminus kernel: Symbols match kernel version 2.4.20.
Jan 23 22:18:09 terminus kernel: No module symbols loaded - kernel
modules not enabled. 
Jan 23 22:18:09 terminus kernel: Linux version 2.4.20
(root@terminus.dnspenguin.com) (gcc version 2.96 20000731 (Red Hat Linux
7.0)) #4 Thu Jan 23 21:15:07 EST 2003
Jan 23 22:18:09 terminus kernel: BIOS-provided physical RAM map:
Jan 23 22:18:09 terminus kernel:  BIOS-e820: 0000000000000000 -
000000000009f400 (usable)
Jan 23 22:18:09 terminus kernel:  BIOS-e820: 000000000009f400 -
00000000000a0000 (reserved)
Jan 23 22:18:09 terminus kernel:  BIOS-e820: 00000000000e0000 -
0000000000100000 (reserved)
Jan 23 22:18:09 terminus kernel:  BIOS-e820: 0000000000100000 -
0000000001000000 (usable)
Jan 23 22:18:09 terminus kernel:  BIOS-e820: 00000000fec00000 -
00000000fec01000 (reserved)
Jan 23 22:18:09 terminus kernel:  BIOS-e820: 00000000fee00000 -
00000000fee01000 (reserved)
Jan 23 22:18:09 terminus kernel:  BIOS-e820: 00000000fffe0000 -
0000000100000000 (reserved)
Jan 23 22:18:09 terminus kernel: 16MB LOWMEM available.
Jan 23 22:18:09 terminus kernel: On node 0 totalpages: 4096
Jan 23 22:18:09 terminus kernel: zone(0): 4096 pages.
Jan 23 22:18:09 terminus kernel: zone(1): 0 pages.
Jan 23 22:18:09 terminus kernel: zone(2): 0 pages.
Jan 23 22:18:09 terminus kernel: IBM machine detected. Enabling
interrupts during APM calls.
Jan 23 22:18:09 terminus kernel: Kernel command line: auto
BOOT_IMAGE=linux5 ro root=301 BOOT_FILE=/boot/bzImage-012303-1
ether=15,0x5000,eth0 ether=5,0x210,eth1
Jan 23 22:18:09 terminus kernel: Initializing CPU#0
Jan 23 22:18:09 terminus kernel: Detected 166.196 MHz processor.
Jan 23 22:18:09 terminus kernel: Console: colour VGA+ 80x25
Jan 23 22:18:09 terminus kernel: Calibrating delay loop... 331.77
BogoMIPS
Jan 23 22:18:09 terminus kernel: Memory: 14168k/16384k available (967k
kernel code, 1828k reserved, 232k data, 244k init, 0k highmem)
Jan 23 22:18:09 terminus kernel: Dentry cache hash table entries: 2048
(order: 2, 16384 bytes)
Jan 23 22:18:09 terminus kernel: Inode cache hash table entries: 1024
(order: 1, 8192 bytes)
Jan 23 22:18:09 terminus kernel: Mount-cache hash table entries: 512
(order: 0, 4096 bytes)
Jan 23 22:18:10 terminus kernel: Buffer-cache hash table entries: 1024
(order: 0, 4096 bytes)
Jan 23 22:18:10 terminus kernel: Page-cache hash table entries: 4096
(order: 2, 16384 bytes)
Jan 23 22:18:10 terminus xinetd[393]: finger disabled, removing 
Jan 23 22:18:10 terminus xinetd[393]: tftp disabled, removing 
Jan 23 22:18:10 terminus xinetd[393]: telnet disabled, removing 
Jan 23 22:18:10 terminus xinetd[393]: talk disabled, removing 
Jan 23 22:18:10 terminus xinetd[393]: swat disabled, removing 
Jan 23 22:18:10 terminus xinetd[393]: socks disabled, removing 
Jan 23 22:18:10 terminus xinetd[393]: shell disabled, removing 
Jan 23 22:18:10 terminus xinetd[393]: login disabled, removing 
Jan 23 22:18:10 terminus kernel: Intel Pentium with F0 0F bug -
workaround enabled.
Jan 23 22:18:10 terminus xinetd[393]: exec disabled, removing 
Jan 23 22:18:10 terminus xinetd[393]: ntalk disabled, removing 
Jan 23 22:18:10 terminus xinetd[393]: linuxconf disabled, removing 
Jan 23 22:18:10 terminus xinetd[393]: ftp disabled, removing 
Jan 23 22:18:10 terminus xinetd[393]: {init_services} no services.
Exiting...
Jan 23 22:18:10 terminus kernel: CPU: Intel Pentium MMX stepping 03
Jan 23 22:18:10 terminus xinetd: xinetd startup succeeded
Jan 23 22:18:10 terminus kernel: Checking 'hlt' instruction... OK.
Jan 23 22:18:10 terminus kernel: POSIX conformance testing by UNIFIX
Jan 23 22:18:10 terminus kernel: PCI: PCI BIOS revision 2.10 entry at
0xfd8bc, last bus=0
Jan 23 22:18:10 terminus kernel: PCI: Using configuration type 1
Jan 23 22:18:10 terminus kernel: PCI: Probing PCI hardware
Jan 23 22:18:10 terminus kernel: Limiting direct PCI/PCI transfers.
Jan 23 22:18:10 terminus kernel: Activating ISA DMA hang workarounds.
Jan 23 22:18:10 terminus kernel: Linux NET4.0 for Linux 2.4
Jan 23 22:18:10 terminus kernel: Based upon Swansea University Computer
Society NET3.039
Jan 23 22:18:10 terminus kernel: Initializing RT netlink socket
Jan 23 22:18:10 terminus kernel: Starting kswapd
Jan 23 22:18:10 terminus kernel: parport0: PC-style at 0x3bc
[PCSPP(,...)]
Jan 23 22:18:10 terminus kernel: pty: 256 Unix98 ptys configured
Jan 23 22:18:10 terminus kernel: Serial driver version 5.05c
(2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
Jan 23 22:18:10 terminus kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
Jan 23 22:18:10 terminus kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A
Jan 23 22:18:10 terminus kernel: lp0: using parport0 (polling).
Jan 23 22:18:10 terminus kernel: Uniform Multi-Platform E-IDE driver
Revision: 6.31
Jan 23 22:18:10 terminus kernel: ide: Assuming 33MHz system bus speed
for PIO modes; override with idebus=xx
Jan 23 22:18:10 terminus kernel: PIIX3: IDE controller on PCI bus 00 dev
09
Jan 23 22:18:10 terminus kernel: PIIX3: chipset revision 0
Jan 23 22:18:10 terminus kernel: PIIX3: not 100% native mode: will probe
irqs later
Jan 23 22:18:10 terminus kernel:     ide0: BM-DMA at 0xfff0-0xfff7, BIOS
settings: hda:pio, hdb:pio
Jan 23 22:18:10 terminus kernel: hda: WDC AC22500L, ATA DISK drive
Jan 23 22:18:10 terminus kernel: hdb: ATAPI CDROM, ATAPI CD/DVD-ROM
drive
Jan 23 22:18:10 terminus kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Jan 23 22:18:10 terminus kernel: blk: queue c0292e84, I/O limit 4095Mb
(mask 0xffffffff)
Jan 23 22:18:10 terminus kernel: hda: 4999680 sectors (2560 MB) w/256KiB
Cache, CHS=620/128/63, (U)DMA
Jan 23 22:18:10 terminus kernel: hdb: ATAPI 128X CD-ROM drive, 128kB
Cache, (U)DMA
Jan 23 22:18:10 terminus kernel: Uniform CD-ROM driver Revision: 3.12
Jan 23 22:18:10 terminus kernel: ide-floppy driver 0.99.newide
Jan 23 22:18:10 terminus kernel: Partition check:
Jan 23 22:18:10 terminus kernel:  hda: hda1 hda2 < hda5 hda6 >
Jan 23 22:18:10 terminus kernel: Floppy drive(s): fd0 is 1.44M
Jan 23 22:18:10 terminus kernel: FDC 0 is a National Semiconductor
PC87306
Jan 23 22:18:10 terminus kernel: eth1: 3c5x9 at 0x210, 10baseT port,
address  00 20 af 25 35 15, IRQ 5.
Jan 23 22:18:10 terminus kernel: 3c509.c:1.19 16Oct2002 becker@scyld.com
Jan 23 22:18:10 terminus kernel: http://www.scyld.com/network/3c509.html
Jan 23 22:18:10 terminus kernel: loop: loaded (max 8 devices)
Jan 23 22:18:10 terminus kernel: 3c59x: Donald Becker and others.
www.scyld.com/network/vortex.html
Jan 23 22:18:10 terminus kernel: 00:0b.0: 3Com PCI 3c590 Vortex 10Mbps
at 0x5000. Vers LK1.1.16
Jan 23 22:18:10 terminus kernel: 00:0b.0: Overriding PCI latency timer
(CFLT) setting of 24, new value is 248.
Jan 23 22:18:10 terminus kernel: ide-floppy driver 0.99.newide
Jan 23 22:18:10 terminus kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Jan 23 22:18:10 terminus kernel: IP Protocols: ICMP, UDP, TCP
Jan 23 22:18:10 terminus kernel: IP: routing cache hash table of 512
buckets, 4Kbytes
Jan 23 22:18:11 terminus kernel: TCP: Hash tables configured
(established 1024 bind 2048)
Jan 23 22:18:11 terminus kernel: ip_conntrack version 2.1 (128 buckets,
1024 max) - 292 bytes per conntrack
Jan 23 22:18:11 terminus kernel: ip_tables: (C) 2000-2002 Netfilter core
team
Jan 23 22:18:11 terminus kernel: NET4: Unix domain sockets 1.0/SMP for
Linux NET4.0.
Jan 23 22:18:11 terminus kernel: VFS: Mounted root (ext2 filesystem)
readonly.
Jan 23 22:18:11 terminus kernel: Freeing unused kernel memory: 244k
freed
Jan 23 22:18:11 terminus kernel: Adding Swap: 96728k swap-space
(priority -1)
Jan 23 22:18:11 terminus kernel: eth1: Setting 3c5x9/3c5x9B half-duplex
mode if_port: 0, sw_info: 3f30
Jan 23 22:18:11 terminus kernel: eth1: Setting Rx mode to 1 addresses.
Jan 23 22:18:12 terminus smb: smbd startup succeeded
Jan 23 22:18:12 terminus smb: nmbd startup succeeded
Jan 23 22:18:13 terminus sshd: sshd startup succeeded
Jan 23 22:18:13 terminus sshd[433]: Server listening on 0.0.0.0 port 22.
Jan 23 22:18:14 terminus lpd: lpd startup succeeded
Jan 23 22:18:14 terminus gpm: gpm startup succeeded
Jan 23 22:18:15 terminus crond[485]: (CRON) STARTUP (fork ok) 
Jan 23 22:18:15 terminus crond: crond startup succeeded
Jan 23 22:18:26 terminus PAM_unix[496]: (system-auth) session opened for
user root by LOGIN(uid=0)
Jan 23 22:18:27 terminus  -- root[496]: ROOT LOGIN ON tty1
Jan 23 22:18:34 terminus PAM_unix[497]: (system-auth) session opened for
user root by LOGIN(uid=0)
Jan 23 22:18:34 terminus  -- root[497]: ROOT LOGIN ON tty2
Jan 23 22:18:56 terminus kernel: Unable to handle kernel paging request
at virtual address 00003600
Jan 23 22:18:56 terminus kernel:  printing eip:
Jan 23 22:18:56 terminus kernel: 00003600
Jan 23 22:18:56 terminus kernel: *pde = 00000000
Jan 23 22:18:56 terminus kernel: Oops: 0000
Jan 23 22:18:56 terminus kernel: CPU:    0
Jan 23 22:18:56 terminus kernel: EIP:
0010:[cpuid_exit+13824/-1072693248]    Not tainted
Jan 23 22:18:56 terminus kernel: EFLAGS: 00010202
Jan 23 22:18:56 terminus kernel: eax: 00000001   ebx: c02770a0   ecx:
c180a000   edx: 00000036
Jan 23 22:18:56 terminus kernel: esi: 00000036   edi: 0000000b   ebp:
000000c7   esp: c003ff28
Jan 23 22:18:56 terminus kernel: ds: 0018   es: 0018   ss: 0018
Jan 23 22:18:56 terminus kernel: Process kswapd (pid: 4,
stackpage=c003f000)
Jan 23 22:18:56 terminus kernel: Stack: c0013a30 c0126cf3 c02770a0
00000202 c003e000 00000008 000001d0 c021bd00 
Jan 23 22:18:56 terminus kernel:        c02980c0 c009bf40 c009e6a8
00000000 00000020 000001d0 00000006 00000cd0 
Jan 23 22:18:56 terminus kernel:        c0126e85 00000006 0000000c
c021bd00 00000006 000001d0 c021bd00 00000000 
Jan 23 22:18:56 terminus kernel: Call Trace:    [shrink_cache+723/784]
[shrink_caches+85/128] [try_to_free_pages_zone+48/80]
[kswapd_balance_pgdat+69/144] [kswapd_balance+22/48]
Jan 23 22:18:56 terminus kernel:   [kswapd+161/192] [kswapd+0/192]
[kernel_thread+43/64]
Jan 23 22:18:56 terminus kernel: 
Jan 23 22:18:57 terminus kernel: Code:  Bad EIP value.
Jan 23 22:18:57 terminus kernel:  <1>Unable to handle kernel paging
request at virtual address 00003400
Jan 23 22:18:57 terminus kernel:  printing eip:
Jan 23 22:18:57 terminus kernel: 00003400
Jan 23 22:18:57 terminus kernel: *pde = 00000000
Jan 23 22:18:57 terminus kernel: Oops: 0000
Jan 23 22:18:57 terminus kernel: CPU:    0
Jan 23 22:18:57 terminus kernel: EIP:
0010:[cpuid_exit+13312/-1072693248]    Not tainted
Jan 23 22:18:57 terminus kernel: EFLAGS: 00010202
Jan 23 22:18:57 terminus kernel: eax: 00000001   ebx: c02770a0   ecx:
c180a000   edx: 00000034
Jan 23 22:18:57 terminus kernel: esi: 00000034   edi: 00000020   ebp:
00000117   esp: c09ede18
Jan 23 22:18:57 terminus kernel: ds: 0018   es: 0018   ss: 0018
Jan 23 22:18:57 terminus kernel: Process view (pid: 542,
stackpage=c09ed000)
Jan 23 22:18:57 terminus kernel: Stack: c0013a04 c0126cf3 c02770a0
c017875c c09ec000 0000001c 000001d2 c021bd00 
Jan 23 22:18:57 terminus kernel:        00000296 00000000 c009e270
00000000 00000020 000001d2 00000006 00000d0e 
Jan 23 22:18:57 terminus kernel:        c0126e85 00000006 0000000c
c021bd00 00000006 000001d2 c021bd00 00000000 
Jan 23 22:18:57 terminus kernel: Call Trace:    [shrink_cache+723/784]
[generic_make_request+332/352] [shrink_caches+85/128]
[try_to_free_pages_zone+48/80] [balance_classzone+90/528]
Jan 23 22:18:57 terminus kernel:   [__alloc_pages+274/368]
[page_cache_read+95/192] [generic_file_readahead+261/320]
[do_generic_file_read+484/1088] [generic_file_read+124/272]
[file_read_actor+0/192]
Jan 23 22:18:57 terminus kernel:   [sys_read+150/240] [sys_brk+197/256]
[system_call+51/64]
Jan 23 22:18:57 terminus kernel: 
Jan 23 22:18:57 terminus kernel: Code:  Bad EIP value.
Jan 23 22:19:35 terminus kernel:  <1>Unable to handle kernel paging
request at virtual address 00002800
Jan 23 22:19:35 terminus kernel:  printing eip:
Jan 23 22:19:35 terminus kernel: 00002800
Jan 23 22:19:35 terminus kernel: *pde = 00000000
Jan 23 22:19:35 terminus kernel: Oops: 0000
Jan 23 22:19:35 terminus kernel: CPU:    0
Jan 23 22:19:35 terminus kernel: EIP:
0010:[cpuid_exit+10240/-1072693248]    Not tainted
Jan 23 22:19:35 terminus kernel: EFLAGS: 00010202
Jan 23 22:19:35 terminus kernel: eax: 00000001   ebx: c02770a0   ecx:
c180a000   edx: 00000028
Jan 23 22:19:35 terminus kernel: esi: 00000028   edi: 00000020   ebp:
000000f1   esp: c09edcc0
Jan 23 22:19:35 terminus kernel: ds: 0018   es: 0018   ss: 0018
Jan 23 22:19:35 terminus kernel: Process vi (pid: 546,
stackpage=c09ed000)
Jan 23 22:19:35 terminus kernel: Stack: c00139d8 c0126cf3 c02770a0
c0117c6b c09ec000 00000018 000001d2 c021bd00 
Jan 23 22:19:35 terminus kernel:        c010b644 c09edce4 c0298d68
00000000 00000020 000001d2 00000006 00000b3e 
Jan 23 22:19:35 terminus kernel:        c0126e85 00000006 00000011
c021bd00 00000006 000001d2 c021bd00 00000000 
Jan 23 22:19:35 terminus kernel: Call Trace:    [shrink_cache+723/784]
[update_wall_time+11/64] [timer_interrupt+116/288]
[shrink_caches+85/128] [try_to_free_pages_zone+48/80]
Jan 23 22:19:35 terminus kernel:   [balance_classzone+90/528]
[__alloc_pages+274/368] [do_anonymous_page+94/320] [do_no_page+53/464]
[handle_mm_fault+88/192] [read_cache_page+183/288]
Jan 23 22:19:35 terminus kernel:   [do_page_fault+390/1227]
[batch_entropy_process+172/176] [__alloc_pages+178/368]
[do_anonymous_page+288/320] [do_no_page+53/464] [do_page_fault+0/1227]
Jan 23 22:19:35 terminus kernel:   [error_code+52/64]
[file_read_actor+120/192] [do_generic_file_read+534/1088]
[generic_file_read+124/272] [file_read_actor+0/192] [sys_read+150/240]
Jan 23 22:19:35 terminus kernel:   [sys_brk+197/256] [system_call+51/64]
Jan 23 22:19:35 terminus kernel: 
Jan 23 22:19:35 terminus kernel: Code:  Bad EIP value.
Jan 23 22:20:00 terminus CROND[549]: (root) CMD
(/usr/local/scripts/adm/checkdhcpcd.sh) 
Jan 23 22:20:00 terminus CROND[550]: (root) CMD
(/usr/local/scripts/adm/putip.sh) 
Jan 23 22:20:00 terminus kernel:  <1>Unable to handle kernel paging
request at virtual address 00002a00
Jan 23 22:20:00 terminus kernel:  printing eip:
Jan 23 22:20:00 terminus kernel: 00002a00
Jan 23 22:20:00 terminus kernel: *pde = 00000000
Jan 23 22:20:00 terminus kernel: Oops: 0000
Jan 23 22:20:00 terminus kernel: CPU:    0
Jan 23 22:20:00 terminus kernel: EIP:
0010:[cpuid_exit+10752/-1072693248]    Not tainted
Jan 23 22:20:00 terminus kernel: EFLAGS: 00010202
Jan 23 22:22:05 terminus syslogd 1.3-3: restart.

System info..
------------------------------------------------------------------------
----------------------
./scripts/ver_linux
Gnu C                  2.96
Gnu make               3.79.1
binutils               2.10.0.18
util-linux             2.10m
mount                  2.10m
modutils               2.3.14
e2fsprogs              1.18
pcmcia-cs              3.1.19
Linux C Library        2.1.92
Dynamic linker (ldd)   2.1.92
Procps                 2.0.7
Net-tools              1.56
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded
------------------------------------------------------------------------
----------------------
/proc/pci
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Intel 82437VX Triton II (rev 2).
      Medium devsel.  Master Capable.  Latency=32.  
  Bus  0, device   1, function  0:
    ISA bridge: Intel 82371SB PIIX3 ISA (rev 1).
      Medium devsel.  Fast back-to-back capable.  Master Capable.  No
bursts.  
  Bus  0, device   1, function  1:
    IDE interface: Intel 82371SB PIIX3 IDE (rev 0).
      Medium devsel.  Fast back-to-back capable.  Master Capable.
Latency=32.  
      I/O at 0xfff0 [0xfff1].
  Bus  0, device   1, function  2:
    USB Controller: Intel 82371SB PIIX3 USB (rev 1).
      Medium devsel.  Fast back-to-back capable.  IRQ 15.  Master
Capable.  No bursts.  
      I/O at 0x5020 [0x5021].
  Bus  0, device   8, function  0:
    VGA compatible controller: Cirrus Logic GD 5446 (rev 0).
      Medium devsel.  
      Prefetchable 32 bit memory at 0x40000000 [0x40000008].
  Bus  0, device  11, function  0:
    Ethernet controller: 3Com 3C590 10bT (rev 0).
      Medium devsel.  IRQ 15.  Master Capable.  Latency=248.  Min
Gnt=3.Max Lat=8.
      I/O at 0x5000 [0x5001].
------------------------------------------------------------------------
----------------------
lspci -vvv
00:00.0 Host bridge: Intel Corporation 430VX - 82437VX TVX [Triton VX]
(rev 02)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32

00:01.0 ISA bridge: Intel Corporation 82371SB PIIX3 ISA [Natoma/Triton
II] (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:01.1 IDE interface: Intel Corporation 82371SB PIIX3 IDE
[Natoma/Triton II] (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at fff0

00:01.2 USB Controller: Intel Corporation 82371SB PIIX3 USB
[Natoma/Triton II] (rev 01) (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 15
	Region 4: I/O ports at 5020

00:08.0 VGA compatible controller: Cirrus Logic GD 5446 (prog-if 00
[VGA])
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop+
ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Region 0: Memory at 40000000 (32-bit, prefetchable)

00:0b.0 Ethernet controller: 3Com Corporation 3c590 10BaseT [Vortex]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 248 (750ns min, 2000ns max)
	Interrupt: pin A routed to IRQ 15
	Region 0: I/O ports at 5000
------------------------------------------------------------------------
----------------------
/proc/cpuinfo
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 5
model		: 4
model name	: Pentium MMX
stepping	: 3
cpu MHz		: 166.195
fdiv_bug	: no
hlt_bug		: no
sep_bug		: no
f00f_bug	: yes
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr mce cx8 mmx
bogomips	: 331.78
------------------------------------------------------------------------
----------------------

/proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
0210-021f : 3c509
03bc-03be : parport0
03c0-03df : vga+
03f6-03f6 : ide0
5000-501f : eth0




