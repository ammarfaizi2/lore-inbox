Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318622AbSH1DgI>; Tue, 27 Aug 2002 23:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318627AbSH1DgH>; Tue, 27 Aug 2002 23:36:07 -0400
Received: from pacific.moreton.com.au ([203.143.238.4]:7108 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id <S318622AbSH1DgG>; Tue, 27 Aug 2002 23:36:06 -0400
Message-ID: <3D6C466C.5010704@snapgear.com>
Date: Wed, 28 Aug 2002 13:41:32 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: linux-2.5.32uc0 (MMU-less support)
References: <3D6C34D6.9070601@snapgear.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi All,

Just for fun...

For those that haven't seen linux running on an MMU-less processor
here is the boot trace. Below is what it looks like...

This is running on a Motorola 5272 ColdFire processor (@66MHz),
the board is the M5272C3 board, this one is fitted with 16MB of RAM.
The console is the builtin serial port.

Regards
Greg


------------------------------------------------------------------------
Linux version 2.5.32uc0 (gerg@goober) (gcc version 2.95.3 20010315 
(release)(ColdFire patches - 20010318 from 
http://fiddes.net/coldfire/)(-msep-data patches)) #4 Wed Aug 28 13:04:21 
EST 2002


uClinux/COLDFIRE(m5272)
COLDFIRE port done by Greg Ungerer, gerg@snapgear.com
Flat model support (C) 1998,1999 Kenneth Albanowski, D. Jeff Dionne
On node 0 totalpages: 4096
zone(0): 0 pages.
zone(1): 4096 pages.
zone(2): 0 pages.
Kernel command line:
Calibrating delay loop... 43.72 BogoMIPS
Memory available: 14636k/16384k RAM, 0k/0k ROM (680k kernel code, 201k data)
kmem_create: Forcing size word alignment - task_struct
kmem_create: Forcing size word alignment - mm_struct
Security Scaffold v1.0.0 initialized
kmem_create: Forcing size word alignment - filp
Dentry-cache hash table entries: 2048 (order: 2, 16384 bytes)
Inode-cache hash table entries: 1024 (order: 1, 8192 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
kmem_create: Forcing size word alignment - bdev_cache
kmem_create: Forcing size word alignment - cdev_cache
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
eth0: FEC ENET Version 0.2, 00:cf:52:72:c3:01
fec: PHY @ 0x1, ID 0x0022561b -- AM79C874
Starting kswapd
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec: init pool 0, 1 entries, 12 bytes
biovec: init pool 1, 4 entries, 48 bytes
biovec: init pool 2, 16 entries, 192 bytes
biovec: init pool 3, 64 entries, 768 bytes
biovec: init pool 4, 128 entries, 1536 bytes
biovec: init pool 5, 256 entries, 3072 bytes
kmem_create: Forcing size word alignment - file_lock_cache
aio_setup: sizeof(struct page) = 40
kmem_create: Forcing size word alignment - ext2_inode_cache
ColdFire internal UART serial driver version 1.00
ttyS0 at 0x10000100 (irq = 73) is a builtin ColdFire UART
ttyS1 at 0x10000140 (irq = 74) is a builtin ColdFire UART
kmem_create: Forcing size word alignment - blkdev_requests
block: 48 slots per queue, batch=12
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
PPP generic driver version 2.4.2
uclinux[mtd]: RAM probe address=0xfc778 size=0x8d000
Creating 1 MTD partitions on "RAM":
0x00000000-0x0008d000 : "ROMfs"
uclinux[mtd]: set ROMfs to be root filesystem
NET4: Linux TCP/IP 1.0 for NET4.0
kmem_create: Forcing size word alignment - tcp_sock
kmem_create: Forcing size word alignment - udp_sock
kmem_create: Forcing size word alignment - raw4_sock
IP Protocols: ICMP, UDP, TCP
kmem_create: Forcing size word alignment - ip_dst_cache
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 1024 bind 1024)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (romfs filesystem) readonly.
Freeing unused kernel memory: 24k freed (0xe6000 - 0xeb000)
Shell invoked to run file: /etc/rc
Command: hostname uClinux
Command: /bin/expand /etc/ramfs.img /dev/ram0
Command: mount -t proc proc /proc
Command: mount -t ext2 /dev/ram0 /var
Command: mkdir /var/tmp
Command: mkdir /var/log
Command: mkdir /var/run
Command: mkdir /var/lock
Command: ifconfig lo 127.0.0.1
Command: route add -net 127.0.0.0 netmask 255.0.0.e0 lo
Command: dhcpcd -p t-a eth0 &
h0: config: auto-negotiation on, 100FDX, 100HDX, 10FDX, 10HDX.
[12]
Command: cat /etc/motd
Welcome to
           ____ _  _
          /  __| ||_|
     _   _| |  | | _ ____  _   _  _  _
    | | | | |  | || |  _ \| | | |\ \/ /
    | |_| | |__| || | | | | |_| |/    \
    |  ___\____|_||_|_| |_|\____|\_/\_/
    | |
    |_|

For further information check:
http://www.uclinux.org/

Execution Finished, Exiting

Sash command shell (version 1.1.1)
/>
/> ps
   PID PORT STAT SIZE SHARED %CPU COMMAND
     1      S     18K     0K  0.3 init
     2      R      0K     0K  0.5 ksoftirqd_CPU0
     3      S      0K     0K  0.0 keventd
     4      S      0K     0K  0.0 kswapd
     7      S      0K     0K  0.0 mtdblockd
     5      S      0K     0K  0.0 pdflush
     6      S      0K     0K  0.0 pdflush
    12      S     18K     0K  0.0 dhcpcd -p -a eth0
    13   S0 R     21K     0K  0.0 /bin/sh
    14      S     11K     0K  0.0 /bin/inetd
    15      S     34K     0K  0.0 /bin/boa
/>
/>
/> cat /proc/cpuinfo
CPU:		COLDFIRE(m5272)
MMU:		none
FPU:		none
Clocking:	65.5MHz
BogoMips:	43.72
Calibration:	21862400 loops
/>
/>
/> cat /proc/meminfo
MemTotal:            0 kB
MemFree:         11428 kB
MemShared:           0 kB
Cached:            744 kB
SwapCached:          0 kB
Active:            136 kB
Inactive:          552 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:            0 kB
LowFree:         11428 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:             128 kB
Writeback:           0 kB
Committed_AS:        0 kB
PageTables:          0 kB
ReverseMaps:         0
/>

------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
SnapGear Pty Ltd                               PHONE:    +61 7 3435 2888
825 Stanley St,                                  FAX:    +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com

