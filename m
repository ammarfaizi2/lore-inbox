Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289564AbSCAOuc>; Fri, 1 Mar 2002 09:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293219AbSCAOuY>; Fri, 1 Mar 2002 09:50:24 -0500
Received: from alpha.show.it ([194.184.40.2]:23050 "EHLO alpha.show.it")
	by vger.kernel.org with ESMTP id <S289564AbSCAOuE>;
	Fri, 1 Mar 2002 09:50:04 -0500
Message-Id: <200203011450.g21EnuJ17640@alpha.show.it>
Content-Type: text/plain; charset=US-ASCII
From: Andrea Ferraris <ferraris@show.it>
Reply-To: ferraris@show.it
Organization: SHOW.IT
To: linux-kernel@vger.kernel.org
Subject: 2.4.18 OOPSes 
Date: Fri, 1 Mar 2002 15:47:28 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The PC is a P II 200Mhz with 128 MB RAM and a Promise ATA/66
controller, 2 ATA/100 60 GB disks ,a 3com 590 card. 
It is a Rh 7.2 system with all patches applied, with raid1 sw and ext3 file 
systems.

I get worses oopses with the 2.4.17 kernel and with the original RH 7.2 
kernel.

The machine is a backup server with RH rsync-2.4.6-10 and I get oopses
after transferring to the PC about 2-4 GB of data.

For better information here you are the dmesg output and the the ksymoops of 
the crashes:

Linux version 2.4.18 (root@backup) (gcc version 2.96 20000731 (Red Hat 
Linux7.1  2.96-98)) #1 Thu Feb 28 22:55:12 MET 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000008000000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 32768
zone(0): 4096 pages.
zone(1): 28672 pages.
zone(2): 0 pages.
No local APIC present or hardware disabled
Kernel command line: ro root=/dev/md0
Initializing CPU#0
Detected 199.743 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 398.95 BogoMIPS
Memory: 127060k/131072k available (907k kernel code, 3628k reserved, 238k 
data,
204k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
CPU: Before vendor init, caps: 008001bf 00000000 00000000, vendor = 0
Intel Pentium with F0 0F bug - workaround enabled.
CPU: After vendor init, caps: 008001bf 00000000 00000000 00000000
CPU:     After generic, caps: 008001bf 00000000 00000000 00000000
CPU:             Common caps: 008001bf 00000000 00000000 00000000
CPU: Intel Pentium MMX stepping 03
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfb130, last bus=0
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
Journalled Block Device driver loaded
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Software Watchdog Timer: 0.05, timer margin: 60 sec
block: 128 slots per queue, batch=32
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
PDC20262: IDE controller on PCI bus 00 dev 70
PCI: Found IRQ 11 for device 00:0e.0
PDC20262: chipset revision 1
PDC20262: not 100% native mode: will probe irqs later
PDC20262: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0x7800-0x7807, BIOS settings: hde:DMA, hdf:DMA
    ide3: BM-DMA at 0x7808-0x780f, BIOS settings: hdg:pio, hdh:pio
hdc: CD-ROM 40X/AKU, ATAPI CD/DVD-ROM drive
hde: WDC WD600BB-32CCB0, ATA DISK drive
hdf: MAXTOR 6L060J3, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0x6800-0x6807,0x6c02 on irq 11
hde: 117231408 sectors (60022 MB) w/2048KiB Cache, CHS=116301/16/63, UDMA(66)
hdf: 117266688 sectors (60041 MB) w/1819KiB Cache, CHS=116336/16/63, UDMA(66)
hdc: ATAPI 40X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hde: hde1 hde2 hde3
 hdf: hdf1 hdf2
PCI: Found IRQ 10 for device 00:11.0
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
00:11.0: 3Com PCI 3c905C Tornado at 0x7c00. Vers LK1.1.16
md: raid1 personality registered as nr 3
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
 [events: 00000024]
 [events: 00000024]
md: autorun ...
md: considering hdf2 ...
md:  adding hdf2 ...
md:  adding hde3 ...
md: created md0
md: bind<hde3,1>
md: bind<hdf2,2>
md: running: <hdf2><hde3>
md: hdf2's event counter: 00000024
md: hde3's event counter: 00000024
md: md0: raid array is not clean -- starting background reconstruction
md: RAID level 1 does not need chunksize! Continuing anyway.
md0: max total readahead window set to 124k
md0: 1 data-disks, max readahead per data-disk: 124k
raid1: device hdf2 operational as mirror 1
raid1: device hde3 operational as mirror 0
raid1: raid set md0 not clean; reconstructing mirrors
raid1: raid set md0 active with 2 out of 2 mirrors
md: updating md0 RAID superblock on device
md: hdf2 [events: 00000025]<6>(write) hdf2's sb offset: 58320768
md: syncing RAID array md0
md: minimum _guaranteed_ reconstruction speed: 100 KB/sec/disc.
md: using maximum available idle IO bandwith (but not more than 100000 
KB/sec) f
or reconstruction.
md: using 124k window, over a total of 58302144 blocks.
md: hde3 [events: 00000025]<6>(write) hde3's sb offset: 58302144
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
(recovery.c, 252): journal_recover: JBD: recovery, exit status 0, recovered 
tran
sactions 28622 to 28731
(recovery.c, 255): journal_recover: JBD: Replayed 4342 and revoked 0/0 blocks
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 204k freed
Real Time Clock Driver v1.10e
Adding Swap: 312440k swap-space (priority -1)
Adding Swap: 262072k swap-space (priority -2)
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on md(9,0), internal journal
inserting floppy driver for 2.4.18
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI 
IS
APNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 (0x778) [PCSPP(,...)]
parport0: irq 7 detected
md: md0: sync done.
VFS: Disk change detected on device fd(2,0)


ksymoops 2.4.1 on i586 2.4.18.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18/ (default)
     -m /boot/System.map-2.4.18 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base says 
c019cc70, System.map says c014c040.  Ignoring ksyms_base entry
Unable to handle kernel NULL pointer dereference at virtual address 00000800
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c012e9c4>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: c6b49480   ebx: c6b49420    ecx: c6b49420    edx: 00000800
esi: c6b49420   edi: c6b49420    ebp: c1023980    esp: c1261f00
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 4, stackpage=c1261000)
Stack: c0131019 c6b49420 c12e1c00 c1023980 000001d0 c012f669 00000000 c1023980
       00000020 00001161 c0127105 c1023980 000001d0 c1205e30 c1260000 000001bd
       000001d0 c02139c8 c1205e30 c0c7b020 c1205ce0 00000002 00000020 000001d0
Call Trace: [<c0131019>] [<c012f669>] [<c0127105>] [<c0127330>] [<c01273a0>] 
[<c0127434>] [<c0127496>] [<c01275b1>] [<c0127510>] [<c0105000>] [<c0105516>] 
[<c0127510>]
Code: 89 02 c7 41 30 00 00 00 00 89 4c 24 04 e9 5a ff ff ff 8d 76 

>>EIP; c012e9c4 <__remove_from_queues+14/30>   <=====
Trace; c0131019 <try_to_free_buffers+59/e0>
Trace; c012f669 <try_to_release_page+29/50>
Trace; c0127105 <shrink_cache+1f5/2f0>
Trace; c0127330 <shrink_caches+50/90>
Trace; c01273a0 <try_to_free_pages+30/50>
Trace; c0127434 <kswapd_balance_pgdat+44/90>
Trace; c0127496 <kswapd_balance+16/30>
Trace; c01275b1 <kswapd+a1/c0>
Trace; c0127510 <kswapd+0/c0>
Trace; c0105000 <_stext+0/0>
Trace; c0105516 <kernel_thread+26/30>
Trace; c0127510 <kswapd+0/c0>
Code;  c012e9c4 <__remove_from_queues+14/30>
00000000 <_EIP>:
Code;  c012e9c4 <__remove_from_queues+14/30>   <=====
   0:   89 02                     mov    %eax,(%edx)   <=====
Code;  c012e9c6 <__remove_from_queues+16/30>
   2:   c7 41 30 00 00 00 00      movl   $0x0,0x30(%ecx)
Code;  c012e9cd <__remove_from_queues+1d/30>
   9:   89 4c 24 04               mov    %ecx,0x4(%esp,1)
Code;  c012e9d1 <__remove_from_queues+21/30>
   d:   e9 5a ff ff ff            jmp    ffffff6c <_EIP+0xffffff6c> c012e930 
<__remove_from_lru_list+0/80>
Code;  c012e9d6 <__remove_from_queues+26/30>
  12:   8d 76 00                  lea    0x0(%esi),%esi

<1> Unable to handle kernel NULL pointer dereference at virtual address 
00000800
c012e9c4
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c012e9c4>]    Not tainted
EFLAGS: 00010246
eax: 00000000   ebx: c6b49480   ecx: c6b49480   edx: 00000000
esi: c6b49480   edi: c6b49480   ebp: c10232c0   esp: c2c41e4c
ds: 0018   es: 0018   ss: 0018
Process rsync (pid: 776, stackpage=c2c41000)
Stack: c0131019 c6b49480 c12e1c00 c10232c0 000001d2 c012f669 00000000 c10232c0
       00000010 000011ae c0127105 c10232c0 000001d2 c2c41ec8 c2c40000 000001c6
       000001d2 c02139c8 c3c99440 c01524e5 c1205180 00000000 00000020 000001d2
Call Trace: [<c0131019>] [<c012f669>] [<c0127105>] [<c01524e5>] [<c0127330>] 
[<c01273a0>] [<c0127c17>] [<c0127e7a>] [<c012388b>] [<c012d5c6>] [<c0106d03>]
Code: 89 02 c7 41 30 00 00 00 00 89 4c 24 04 e9 5a ff ff ff 8d 76

>>EIP; c012e9c4 <__remove_from_queues+14/30>   <=====
Trace; c0131019 <try_to_free_buffers+59/e0>
Trace; c012f669 <try_to_release_page+29/50>
Trace; c0127105 <shrink_cache+1f5/2f0>
Trace; c01524e5 <ext3_mark_iloc_dirty+35/50>
Trace; c0127330 <shrink_caches+50/90>
Trace; c01273a0 <try_to_free_pages+30/50>
Trace; c0127c17 <balance_classzone+57/1b0>
Trace; c0127e7a <__alloc_pages+10a/170>
Trace; c012388b <generic_file_write+41b/700>
Trace; c012d5c6 <sys_write+96/f0>
Trace; c0106d03 <system_call+33/40>
Code;  c012e9c4 <__remove_from_queues+14/30>
00000000 <_EIP>:
Code;  c012e9c4 <__remove_from_queues+14/30>   <=====
   0:   89 02                     mov    %eax,(%edx)   <=====
Code;  c012e9c6 <__remove_from_queues+16/30>
   2:   c7 41 30 00 00 00 00      movl   $0x0,0x30(%ecx)
Code;  c012e9cd <__remove_from_queues+1d/30>
   9:   89 4c 24 04               mov    %ecx,0x4(%esp,1)
Code;  c012e9d1 <__remove_from_queues+21/30>
   d:   e9 5a ff ff ff            jmp    ffffff6c <_EIP+0xffffff6c> c012e930 
<__remove_from_lru_list+0/80>
Code;  c012e9d6 <__remove_from_queues+26/30>
  12:   8d 76 00                  lea    0x0(%esi),%esi


2 warnings issued.  Results may not be reliable.
