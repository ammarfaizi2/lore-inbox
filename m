Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264943AbUAJJYm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 04:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264944AbUAJJYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 04:24:42 -0500
Received: from fep02.swip.net ([130.244.199.130]:31135 "EHLO
	fep02-svc.swip.net") by vger.kernel.org with ESMTP id S264943AbUAJJYg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 04:24:36 -0500
Message-ID: <3FFFC501.3090904@debian.org>
Date: Sat, 10 Jan 2004 10:25:21 +0100
From: Ludovic Drolez <ldrolez@debian.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: nfsd et swapd oops with 2.4.22-ltsp-2
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------030306090808090208040603"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030306090808090208040603
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi !

I'm using the LTSP distrib on an old Amd 5x86. I've attached an IDE disk to
it to transform it to a kind of NAS.

After a few days/hours of operation, the nfs server crashes and nfsd makes an
oops (and sometimes also kswapd). The ext2 partition is mounted with sync and
noatime options.

I've attached /proc/messages, but I couldn't run ksymoops on it because I cannot
find ltsp's system.map.

I was also able to reproduce the oops with a debian 2.4.2X kernel. I've checked
my ram with memtest86, and everything seems ok, so I'm stuck...

Any clues ?

-- 
Ludovic Drolez.

http://www.palmopensource.com       - The PalmOS Open Source Portal
http://www.drolez.com      - Personal site - Linux and PalmOS stuff

--------------030306090808090208040603
Content-Type: text/plain;
 name="kmsg3"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kmsg3"

<4>Linux version 2.4.22-ltsp-2 (root@BigDog) (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-98)) #2 Sat Nov 1 19:13:34 EST 2003
<6>BIOS-provided physical RAM map:
<4> BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
<4> BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
<4> BIOS-e820: 0000000000100000 - 0000000002000000 (usable)
<4> BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
<4> BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
<4> BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)
<5>32MB LOWMEM available.
<4>On node 0 totalpages: 8192
<4>zone(0): 4096 pages.
<4>zone(1): 4096 pages.
<4>zone(2): 0 pages.
<6>DMI not present.
<4>Kernel command line: rw root=/dev/ram0 init=/linuxrc rw 
<6>Initializing CPU#0
<4>Console: colour VGA+ 80x25
<4>Calibrating delay loop... 66.56 BogoMIPS
<6>Memory: 29340k/32768k available (1006k kernel code, 3044k reserved, 403k data, 80k init, 0k highmem)
<4>Checking if this processor honours the WP bit even in supervisor mode... Ok.
<6>Dentry cache hash table entries: 4096 (order: 3, 32768 bytes)
<6>Inode cache hash table entries: 2048 (order: 2, 16384 bytes)
<6>Mount cache hash table entries: 512 (order: 0, 4096 bytes)
<6>Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)
<4>Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
<7>CPU:     After generic, caps: 00000001 00000000 00000000 00000000
<7>CPU:             Common caps: 00000001 00000000 00000000 00000000
<4>CPU: AMD Am5x86-WB stepping 04
<6>Checking 'hlt' instruction... OK.
<6>Checking for popad bug... OK.
<4>POSIX conformance testing by UNIFIX
<6>PCI: PCI BIOS revision 2.10 entry at 0xf6f41, last bus=0
<6>PCI: Using configuration type 1
<6>PCI: Probing PCI hardware
<4>PCI: Probing PCI hardware (bus 00)
<4>PCI: Fixing base address flags for device 00:12.1
<6>PCI: Ignoring BAR0-3 of IDE controller 00:12.1
<6>Linux NET4.0 for Linux 2.4
<6>Based upon Swansea University Computer Society NET3.039
<4>Initializing RT netlink socket
<6>apm: BIOS not found.
<4>Starting kswapd
<6>devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
<6>devfs: boot_options: 0x0
<4>pty: 256 Unix98 ptys configured
<4>RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
<6>Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
<6>ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
<4>hda: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
<4>hdc: IBM-DCAA-34330, ATA DISK drive
<4>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
<4>ide1 at 0x170-0x177,0x376 on irq 15
<6>Partition check:
<6> hda:end_request: I/O error, dev 03:00 (hda), sector 0
<4>end_request: I/O error, dev 03:00 (hda), sector 2
<4>end_request: I/O error, dev 03:00 (hda), sector 4
<4>end_request: I/O error, dev 03:00 (hda), sector 6
<4>end_request: I/O error, dev 03:00 (hda), sector 0
<4>end_request: I/O error, dev 03:00 (hda), sector 2
<4>end_request: I/O error, dev 03:00 (hda), sector 4
<4>end_request: I/O error, dev 03:00 (hda), sector 6
<4> unable to read partition table
<6> hdc:end_request: I/O error, dev 16:00 (hdc), sector 0
<4>end_request: I/O error, dev 16:00 (hdc), sector 2
<4>end_request: I/O error, dev 16:00 (hdc), sector 4
<4>end_request: I/O error, dev 16:00 (hdc), sector 6
<4>end_request: I/O error, dev 16:00 (hdc), sector 0
<4>end_request: I/O error, dev 16:00 (hdc), sector 2
<4>end_request: I/O error, dev 16:00 (hdc), sector 4
<4>end_request: I/O error, dev 16:00 (hdc), sector 6
<4> unable to read partition table
<6>NET4: Linux TCP/IP 1.0 for NET4.0
<6>IP Protocols: ICMP, UDP, TCP
<6>IP: routing cache hash table of 512 buckets, 4Kbytes
<6>TCP: Hash tables configured (established 2048 bind 4096)
<6>NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
<5>RAMDISK: Compressed image found at block 0
<6>Freeing initrd memory: 940k freed
<4>VFS: Mounted root (ext2 filesystem).
<6>Freeing unused kernel memory: 80k freed
<6>via-rhine.c:v1.10-LK1.1.19  July-12-2003  Written by Donald Becker
<6>  http://www.scyld.com/network/via-rhine.html
<6>eth0: VIA VT86C100A Rhine at 0xfc80, 00:80:c8:da:14:49, IRQ 10.
<6>eth0: MII PHY found at address 8, status 0x782d advertising 05e1 Link 45e1.
<6>eth0: Setting full-duplex based on MII #8 link partner capability of 45e1.
<4>hdc: attached ide-disk driver.
<6>hdc: 8467200 sectors (4335 MB) w/96KiB Cache, CHS=8400/16/63
<6> /dev/ide/host1/bus0/target0/lun0: [PTBL] [527/255/63] p1
<4>register_swap_method: method nfs file
<6>Adding Swap: 16380k swap-space (priority -1)
<6>Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
<4>EXT2-fs warning (device ide1(22,1)): ext2_read_super: mounting ext3 filesystem as ext2
<4>
<4>EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
<4>EXT2-fs warning (device ide1(22,1)): ext2_read_super: mounting ext3 filesystem as ext2
<4>
<1>Unable to handle kernel paging request at virtual address 6b85051f
<4> printing eip:
<4>c0131bdc
<1>*pde = 00000000
<4>Oops: 0002
<4>CPU:    0
<4>EIP:    0010:[<c0131bdc>]    Not tainted
<4>EFLAGS: 00010246
<4>eax: 00000000   ebx: c02d4bc0   ecx: c02d4bc0   edx: 6b85051f
<4>esi: c02d4bc0   edi: c02d4bc0   ebp: c1057c28   esp: c1067f00
<4>ds: 0018   es: 0018   ss: 0018
<4>Process kswapd (pid: 4, stackpage=c1067000)
<4>Stack: c013427b c02d4bc0 c1040de4 c02299f0 c102c01c c0229a10 00000000 c1057c28 
<4>       00000009 0000034c c012ad08 c1057c28 000001d0 c0278a48 c1066000 00000056 
<4>       000001d0 c02299f0 0000000a c02789a0 c105b2dc 00000000 00000020 000001d0 
<4>Call Trace:    [<c013427b>] [<c012ad08>] [<c012af46>] [<c012afa0>] [<c012b09b>]
<4>  [<c012b0fa>] [<c012b209>] [<c012b178>] [<c0105000>] [<c0106eae>] [<c012b178>]
<4>
<4>Code: 89 02 c7 41 30 00 00 00 00 89 4c 24 04 eb 89 90 ff 74 24 04 
<4> <1>Unable to handle kernel paging request at virtual address 6f9ff7a1
<4> printing eip:
<4>c0131bdc
<1>*pde = 00000000
<4>Oops: 0002
<4>CPU:    0
<4>EIP:    0010:[<c0131bdc>]    Not tainted
<4>EFLAGS: 00010246
<4>eax: 00000000   ebx: c0958bc0   ecx: c0958bc0   edx: 6f9ff7a1
<4>esi: c0958bc0   edi: c0958bc0   ebp: c101e264   esp: c07c7cf4
<4>ds: 0018   es: 0018   ss: 0018
<4>Process nfsd (pid: 257, stackpage=c07c7000)
<4>Stack: c013427b c0958bc0 c101fe94 c0229940 c100001c c0229954 00000000 c101e264 
<4>       00000004 00000324 c012ad08 c101e264 000001d2 c029b2b4 c07c6000 0000004c 
<4>       000001d2 c02299f0 20000001 0000000f c105b564 00000000 00000020 000001d2 
<4>Call Trace:    [<c013427b>] [<c012ad08>] [<c012af46>] [<c012afa0>] [<c012b945>]
<4>  [<c012bbee>] [<c01248af>] [<c0124eed>] [<c0125130>] [<c015150f>] [<c0125731>]
<4>  [<c01255ec>] [<c2817c5e>] [<c281cd81>] [<c2823b58>] [<c2814533>] [<c2823438>]
<4>  [<c01f4172>] [<c2823b58>] [<c2823438>] [<c2823458>] [<c281433f>] [<c0106eae>]
<4>  [<c2814188>]
<4>
<4>Code: 89 02 c7 41 30 00 00 00 00 89 4c 24 04 eb 89 90 ff 74 24 04 
<4> 
--------------030306090808090208040603--

