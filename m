Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276863AbRJCEkG>; Wed, 3 Oct 2001 00:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276864AbRJCEjs>; Wed, 3 Oct 2001 00:39:48 -0400
Received: from wolf.ericsson.net.nz ([203.97.68.250]:47509 "EHLO
	wolf.ericsson.net.nz") by vger.kernel.org with ESMTP
	id <S276863AbRJCEjk>; Wed, 3 Oct 2001 00:39:40 -0400
Date: Wed, 3 Oct 2001 16:40:04 +1200 (NZST)
From: Mark Henson <kern@wolf.ericsson.net.nz>
To: <linux-kernel@vger.kernel.org>
Subject: Re: page_alloc problem... (kernel BUG at page_alloc.c:84! 2.4.2-2)
In-Reply-To: <Pine.LNX.4.33.0110030945050.27543-100000@wolf.ericsson.net.nz>
Message-ID: <Pine.LNX.4.33.0110031548080.30574-100000@wolf.ericsson.net.nz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Is this a known problem that could be fixed by upgrading to a later
kernel??

[root@jgate log]# lsmod
Module                  Size  Used by
dmfe                   10384   2  (autoclean)
ipchains               38976   0  (unused)

follows dmesg etc from the machine:

Linux version 2.4.2-2 (root@porky.devel.redhat.com) (gcc version 2.96
20000731 (Red Hat Linux 7.1 2.96-79)) #1 Sun Apr 8 20:41:30 EDT 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (usable)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
 BIOS-e820: 000000000f6f0000 @ 0000000000100000 (usable)
 BIOS-e820: 000000000000d000 @ 000000000f7f3000 (ACPI data)
 BIOS-e820: 0000000000003000 @ 000000000f7f0000 (ACPI NVS)
On node 0 totalpages: 63472
zone(0): 4096 pages.
zone DMA has max 32 cached pages.
zone(1): 59376 pages.
zone Normal has max 463 cached pages.
zone(2): 0 pages.
zone HighMem has max 1 cached pages.
Kernel command line: auto BOOT_IMAGE=linux ro root=302
BOOT_FILE=/boot/vmlinuz-2.4.2-2
Initializing CPU#0
Detected 855.742 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1703.93 BogoMIPS
Memory: 247236k/253888k available (1365k kernel code, 6264k reserved, 92k
data, 236k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
VFS: Diskquotas version dquot_6.5.0 initialized
CPU: Before vendor init, caps: 0183f9ff c1c7f9ff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 64K (64 bytes/line)
CPU: After vendor init, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: After generic, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: Common caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: AMD Duron(tm) processor stepping 01
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb410, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.14)
Starting kswapd v1.8
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
block: queued sectors max/low 164085kB/54695kB, 512 slots per queue
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:pio
hd0: C/H/S=19158/16/255 from BIOS ignored
hda: ST340824A, ATA DISK drive
hdc: HITACHI CDR-8435, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=77545/16/63,
UDMA(33)
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Serial driver version 5.02 (2000-08-09) with MANY_PORTS MULTIPORT
SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10d
md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md.c: sizeof(mdp_super_t) = 4096
autodetecting RAID arrays
autorun ...
... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 236k freed
Adding Swap: 524624k swap-space (priority -1)
Winbond Super-IO detection, now testing ports 3F0,370,250,4E,2E ...
SMSC Super-IO detection, now testing Ports 2F0, 370 ...
parport0: PC-style at 0x378, irq 7 [PCSPP,EPP]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport_pc: Via 686A parallel port: io=0x378, irq=7
ip_conntrack (1983 buckets, 15864 max)
PCI: Found IRQ 10 for device 00:08.0
PCI: Found IRQ 11 for device 00:0a.0
PCI: The same IRQ used for device 00:07.5
Davicom DM91xx net driver loaded, version 1.30 (June 11, 2000)




On Wed, 3 Oct 2001, Mark Henson wrote:

> Hi,
>
> I have had three page_alloc report errors on a machine that is running as
> an email and gateway server.  Max uptime last night was 10 days...
>
> The machine is a Duron 850 running 2.4.2-2 Redhat, I have 3 other machines
> runnning similar hardware, (Duron 700) one on 2.4.3 built from a tar ball
> RH 6.2 and the other on RH 2.4.2-2 as well.
>
> Can anyone help me identify if this is a hadrware fault - ie faulty
> hardware or if this is a problem with the specific hw design - Soltek MB
> or if this is a known issue and I need to upgrade to a recent 2.4.9 or
> similar kernel?
>
> thanks for your help
>
> cheers
> Mark
>
>
>
> Oct  2 13:51:00 jgate kernel: kernel BUG at page_alloc.c:84!
> Oct  2 13:51:00 jgate kernel: invalid operand: 0000
> Oct  2 13:51:00 jgate kernel: CPU:    0
> Oct  2 13:51:00 jgate kernel: EIP:    0010:[__free_pages_ok+75/848]
> Oct  2 13:51:00 jgate kernel: EIP:    0010:[<c012d07b>]
> Oct  2 13:51:00 jgate kernel: EFLAGS: 00010286
> Oct  2 13:51:00 jgate kernel: eax: 0000001f   ebx: c7e4acc8   ecx:
> fffffff5   edx: 00000000
> Oct  2 13:51:00 jgate kernel: esi: 00000000   edi: c1000164   ebp:
> 00000000   esp: ccc8de28
> Oct  2 13:51:00 jgate kernel: ds: 0018   es: 0018   ss: 0018
> Oct  2 13:51:00 jgate kernel: Process crond (pid: 20404,
> stackpage=ccc8d000)
> Oct  2 13:51:00 jgate kernel: Stack: c020ea7b c020ec89 00000054 c1044010
> c7e4acc8 00003000 003fd000 c0124b02
> Oct  2 13:51:00 jgate kernel:        c1000164 00003000 003fd000 cc817ffc
> c0121ed9 00000003 00002000 00000000
> Oct  2 13:51:00 jgate kernel:        00400000 c80fdbfc 00000000 c0000000
> c80fdbfc ccc8de8c ffffffff c024a3e0
> Oct  2 13:51:00 jgate kernel: Call Trace: [error_table+26787/46744]
> [error_table+27313/46744] [__set_page_dirty+50/64]
> [zap_page_range+457/656] [llc_oui+3940/4644] [send_signal+45/240]
> [exit_mmap+184/288]
> Oct  2 13:51:00 jgate kernel: Call Trace: [<c020ea7b>] [<c020ec89>]
> [<c0124b02>] [<c0121ed9>] [<c024a3e0>] [<c011dacd>] [<c0124698>]
> Oct  2 13:51:00 jgate kernel:        [mmput+38/80] [do_exit+185/560]
> [dequeue_signal+109/176] [do_signal+553/672] [pipe_read+202/608]
> [sys_read+194/208] [sys_llseek+201/224] [do_page_fault+0/1104]
> Oct  2 13:51:00 jgate kernel:        [<c0114b86>] [<c01188d9>]
> [<c011d82d>] [<c0108eb9>] [<c013ce1a>] [<c01339d2>] [<c01338f9>]
> [<c0112f30>]
> Oct  2 13:51:00 jgate kernel:        [signal_return+20/24]
> Oct  2 13:51:00 jgate kernel:        [<c0109064>]
> Oct  2 13:51:00 jgate kernel:
> Oct  2 13:51:00 jgate kernel: Code: 0f 0b 83 c4 0c 8b 0d ac 0b 2c c0 89 f8
> 29 c8 69 c0 f1 f0 f0
>
>
> Oct  3 04:03:01 jgate kernel: kernel BUG at page_alloc.c:84!
> Oct  3 04:03:01 jgate kernel: invalid operand: 0000
> Oct  3 04:03:01 jgate kernel: CPU:    0
> Oct  3 04:03:01 jgate kernel: EIP:    0010:[__free_pages_ok+75/848]
> Oct  3 04:03:01 jgate kernel: EIP:    0010:[<c012d07b>]
> Oct  3 04:03:01 jgate kernel: EFLAGS: 00010286
> Oct  3 04:03:01 jgate kernel: eax: 0000001f   ebx: c7e4acc8   ecx:
> fffffffe   edx: 00000000
> Oct  3 04:03:01 jgate kernel: esi: 00000000   edi: c1000164   ebp:
> 00000000   esp: c147bf38
> Oct  3 04:03:01 jgate kernel: ds: 0018   es: 0018   ss: 0018
> Oct  3 04:03:01 jgate kernel: Process kswapd (pid: 4, stackpage=c147b000)
> Oct  3 04:03:01 jgate kernel: Stack: c020ea7b c020ec89 00000054 c9819800
> 000001d3 c012c88e 00000000 c1000164
> Oct  3 04:03:01 jgate kernel:        c100018c c1000164 00000000 00000000
> c012c375 00000035 00000000 00000004
> Oct  3 04:03:01 jgate kernel:        00000000 00000021 00000000 00000056
> 00000000 00000028 00000004 000001d3
> Oct  3 04:03:02 jgate kernel: Call Trace: [error_table+26787/46744]
> [error_table+27313/46744] [free_shortage+30/144] [page_launder+1541/2432]
> [free_shortage+30/144] [do_try_to_free_pages+53/128] [kswapd+123/288]
> Oct  3 04:03:02 jgate kernel: Call Trace: [<c020ea7b>] [<c020ec89>]
> [<c012c88e>] [<c012c375>] [<c012c88e>] [<c012ca85>] [<c012cb4b>]
> Oct  3 04:03:02 jgate kernel:        [empty_bad_page+0/4096]
> [empty_bad_page+0/4096] [kernel_thread+38/48] [kswapd+0/288]
> Oct  3 04:03:02 jgate kernel:        [<c0105000>] [<c0105000>]
> [<c0107596>] [<c012cad0>]
> Oct  3 04:03:02 jgate kernel:
> Oct  3 04:03:02 jgate kernel: Code: 0f 0b 83 c4 0c 8b 0d ac 0b 2c c0 89 f8
> 29 c8 69 c0 f1 f0 f0
> Oct  3 04:03:03 jgate kernel: kernel BUG at exit.c:465!
> Oct  3 04:03:03 jgate kernel: invalid operand: 0000
> Oct  3 04:03:03 jgate kernel: CPU:    0
> Oct  3 04:03:03 jgate kernel: EIP:    0010:[do_exit+541/560]
> Oct  3 04:03:03 jgate kernel: EIP:    0010:[<c0118a3d>]
> Oct  3 04:03:03 jgate kernel: EFLAGS: 00010282
> Oct  3 04:03:03 jgate kernel: eax: 0000001a   ebx: 00000000   ecx:
> fffffffe   edx: 00000000
> Oct  3 08:55:20 jgate syslogd 1.4-0: restart.
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


