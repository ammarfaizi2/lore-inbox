Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264178AbTFBWCl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 18:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264188AbTFBWCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 18:02:41 -0400
Received: from covert.brown-ring.iadfw.net ([209.196.123.142]:26385 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id S264178AbTFBWCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 18:02:31 -0400
Date: Mon, 2 Jun 2003 17:15:48 -0500
From: Art Haas <ahaas@airmail.net>
To: linux-kernel@vger.kernel.org
Subject: Oops with cs4236 and current BK
Message-ID: <20030602221548.GE663@artsapartment.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

No luck with BK from June 2 trying to get cs4236 module working. My
kernel does have the ALSA update; cs4236.c is version 1.16.

Here's the dmesg output from a reboot and attempt to load the module
once I get a prompt:

$ dmesg
Linux version 2.5.70-ajh3 (arth@pcdebian) (gcc version 3.3) #1 Mon Jun 2 13:30:59 CDT 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000008000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)
128MB LOWMEM available.
On node 0 totalpages: 32768
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 28672 pages, LIFO batch:7
  HighMem zone: 0 pages, LIFO batch:1
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=lnx-2.5.70ajh3 ro root=301 pci=usepirqmask ide=nodma mce
ide_setup: ide=nodmaIDE: Prevented DMA
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 199.777 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 394.24 BogoMIPS
Memory: 127388k/131072k available (1109k kernel code, 3120k reserved, 260k data, 260k init, 0k highmem)
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
Intel Pentium with F0 0F bug - workaround enabled.
CPU:     After generic, caps: 008001bf 00000000 00000000 00000000
Intel old style machine check architecture supported.
Intel old style machine check reporting enabled on CPU#0.
CPU: Intel Pentium MMX stepping 03
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfdb11, last bus=0
PCI: Using configuration type 1
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 248 entries (12 bytes)
biovec pool[1]:   4 bvecs: 248 entries (48 bytes)
biovec pool[2]:  16 bvecs: 248 entries (192 bytes)
biovec pool[3]:  64 bvecs: 248 entries (768 bytes)
biovec pool[4]: 128 bvecs: 124 entries (1536 bytes)
biovec pool[5]: 256 bvecs:  62 entries (3072 bytes)
Linux Plug and Play Support v0.96 (c) Adam Belay
pnp: the driver 'system' has been registered
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f8460
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x7d7e, dseg 0xf0000
pnp: match found with the PnP device '00:00' and the driver 'system'
pnp: match found with the PnP device '00:0d' and the driver 'system'
PnPBIOS: 14 nodes reported by PnP BIOS; 14 recorded by driver
block request queues:
 4/128 requests per read queue
 4/128 requests per write queue
 enter congestion at 15
 exit congestion at 17
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Initializing Cryptographic API
isapnp: Scanning for PnP cards...
pnp: res: Unable to resolve resource conflicts for the device '01:01.00', some devices may not be usable.
pnp: res: Unable to resolve resource conflicts for the device '01:01.01', some devices may not be usable.
pnp: res: Unable to resolve resource conflicts for the device '01:01.02', some devices may not be usable.
pnp: res: Unable to resolve resource conflicts for the device '01:01.03', some devices may not be usable.
isapnp: Card 'Turtle Beach Malibu'
isapnp: 1 Plug & Play card detected total
pty: 256 Unix98 ptys configured
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS3 at I/O 0x2e8 (irq = 3) is a 16550A
pnp: the driver 'serial' has been registered
pnp: match found with the PnP device '00:09' and the driver 'serial'
pnp: match found with the PnP device '00:0a' and the driver 'serial'
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ALI15X3: IDE controller at PCI slot 00:0b.0
ALI15X3: chipset revision 32
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
hda: ST33232A, ATA DISK drive
hdb: ATAPI CDROM, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: FUJITSU MPD3084AT, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hda: task_no_data_intr: error=0x04 { DriveStatusError }
hda: 6303024 sectors (3227 MB) w/128KiB Cache, CHS=6253/16/63
 hda: hda1 hda2 < hda5 hda6 hda7 >
hdc: max request size: 128KiB
hdc: 16514064 sectors (8455 MB) w/512KiB Cache, CHS=16383/16/63
 hdc: hdc1 hdc2 < hdc5 hdc6 > hdc3
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind 16384)
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 260k freed
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Adding 100760k swap on /dev/hda7.  Priority:-1 extents:1
Real Time Clock Driver v1.11
warning: process `update' used the obsolete bdflush system call
Fix your initscripts?
8139too Fast Ethernet driver 0.9.26
eth0: D-Link DFE-538TX (RealTek RTL8139) at 0xc881ef00, 00:05:5d:45:47:96, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8139C'
eth0: Setting half-duplex based on auto-negotiated partner ability 0000.
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
eth0: no IPv6 routers present
pnp: the driver 'cs423x' has been registered
pnp: match found with the PnP device '01:01.00' and the driver 'cs423x'
pnp: match found with the PnP device '01:01.02' and the driver 'cs423x'
pnp: match found with the PnP device '01:01.03' and the driver 'cs423x'
pnp: res: the device '01:01.00' has been activated.
ALSA sound/isa/cs423x/cs4236.c:334: isapnp WSS: wss port=0x538, fm port=0x390, sb port=0x240
ALSA sound/isa/cs423x/cs4236.c:336: isapnp WSS: irq=5, dma1=1, dma2=3
pnp: res: the device '01:01.02' has been activated.
ALSA sound/isa/cs423x/cs4236.c:353: isapnp CTRL: control port=0x1000
pnp: res: the device '01:01.03' has been activated.
ALSA sound/isa/cs423x/cs4236.c:379: isapnp MPU: port=0x338, irq=-1
ALSA sound/isa/cs423x/cs4231_lib.c:1056: cs4231: port = 0x538, id = 0xa
ALSA sound/isa/cs423x/cs4231_lib.c:1062: CS4231: VERSION (I25) = 0x3
ALSA sound/isa/cs423x/cs4231_lib.c:1131: CS4231: ext version; rev = 0xc8, id = 0xc8
ALSA sound/isa/cs423x/cs4236_lib.c:302: CS4236: [0x1000] C1 (version) = 0xff, ext = 0xc8
ALSA sound/isa/cs423x/cs4236_lib.c:304: CS4236+ chip detected, but control port 0x1000 is not valid
bad: scheduling while atomic!
Call Trace: [<c01129f7>]  [<c013170a>]  [<c0131c36>]  [<c014f152>]  [<c015010d>]  [<c8845e80>]  [<c015a550>]  [<c015a738>]  [<c016fc3c>]  [<c8845e10>]  [<c01a919d>]  [<c8845e58>]  [<c01a91eb>]  [<c8845e10>]  [<c01a93c9>]  [<c8845e10>]  [<c8845e10>]  [<c01a973b>]  [<c8845e10>]  [<c8845dfc>]  [<c0187d1e>]  [<c8845e10>]  [<c885b887>]  [<c8845dfc>]  [<c01290c8>]  [<c0108de7>] 
Unable to handle kernel NULL pointer dereference at virtual address 00000180
 printing eip:
c883b938
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c883b938>]    Not tainted
EFLAGS: 00010202
eax: 00000000   ebx: c3494000   ecx: c7ffc860   edx: c3444cc0
esi: c8845de0   edi: c8845e80   ebp: c0243998   esp: c3495f14
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 510, threadinfo=c3494000 task=c3d89320)
Stack: c3444cc0 c3444cc0 00000000 c8845de0 c8845e80 c0243998 c884503e 00000000 
       c11e0c00 c0187339 c3444cc0 c11e0c00 c11e0c00 c0187c73 c11e0c00 c8845e10 
       c01a91ca c11e0c00 c11e0410 c8845e58 c01a91eb c11e0c00 c8845e10 00000000 
Call Trace: [<c8845de0>]  [<c8845e80>]  [<c884503e>]  [<c0187339>]  [<c0187c73>]  [<c8845e10>]  [<c01a91ca>]  [<c8845e58>]  [<c01a91eb>]  [<c8845e10>]  [<c01a93c9>]  [<c8845e10>]  [<c8845e10>]  [<c01a973b>]  [<c8845e10>]  [<c8845dfc>]  [<c0187d1e>]  [<c8845e10>]  [<c885b887>]  [<c8845dfc>]  [<c01290c8>]  [<c0108de7>] 
Code: 8b 80 80 01 00 00 85 c0 74 1e 8b 43 14 48 89 43 14 8b 43 08 
 <6>note: modprobe[510] exited with preempt_count 4
bad: scheduling while atomic!
Call Trace: [<c01129f7>]  [<c0134eed>]  [<c0138b96>]  [<c0114173>]  [<c0117b96>]  [<c0109634>]  [<c0111171>]  [<c0116448>]  [<c012a4ec>]  [<c0131a0d>]  [<c0131c85>]  [<c0111060>]  [<c010904d>]  [<c8845de0>]  [<c8845e80>]  [<c883b938>]  [<c8845de0>]  [<c8845e80>]  [<c884503e>]  [<c0187339>]  [<c0187c73>]  [<c8845e10>]  [<c01a91ca>]  [<c8845e58>]  [<c01a91eb>]  [<c8845e10>]  [<c01a93c9>]  [<c8845e10>]  [<c8845e10>]  [<c01a973b>]  [<c8845e10>]  [<c8845dfc>]  [<c0187d1e>]  [<c8845e10>]  [<c885b887>]  [<c8845dfc>]  [<c01290c8>]  [<c0108de7>] 

Running this through ksymoops ...

$ ksymoops ...
ksymoops 2.4.9 on i586 2.5.70-ajh3.  Options used
     -v /mnt/src/linux-ajh/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.70-ajh3/ (default)
     -m /boot/System.map-2.5.70-ajh3 (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
./gnu/ksymoops-2.4.9/ksymoops: No such file or directory
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Intel Pentium with F0 0F bug - workaround enabled.
warning: process `update' used the obsolete bdflush system call
8139too Fast Ethernet driver 0.9.26
Call Trace: [<c01129f7>]  [<c013170a>]  [<c0131c36>]  [<c014f152>]  [<c015010d>]  [<c8845e80>]  [<c015a550>]  [<c015a738>]  [<c016fc3c>]  [<c8845e10>]  [<c01a919d>]  [<c8845e58>]  [<c01a91eb>]  [<c8845e10>]  [<c01a93c9>]  [<c8845e10>]  [<c8845e10>]  [<c01a973b>]  [<c8845e10>]  [<c8845dfc>]  [<c0187d1e>]  [<c8845e10>]  [<c885b887>]  [<c8845dfc>]  [<c01290c8>]  [<c0108de7>] 
Unable to handle kernel NULL pointer dereference at virtual address 00000180
c883b938
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c883b938>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000000   ebx: c3494000   ecx: c7ffc860   edx: c3444cc0
esi: c8845de0   edi: c8845e80   ebp: c0243998   esp: c3495f14
ds: 007b   es: 007b   ss: 0068
Stack: c3444cc0 c3444cc0 00000000 c8845de0 c8845e80 c0243998 c884503e 00000000 
       c11e0c00 c0187339 c3444cc0 c11e0c00 c11e0c00 c0187c73 c11e0c00 c8845e10 
       c01a91ca c11e0c00 c11e0410 c8845e58 c01a91eb c11e0c00 c8845e10 00000000 
Call Trace: [<c8845de0>]  [<c8845e80>]  [<c884503e>]  [<c0187339>]  [<c0187c73>]  [<c8845e10>]  [<c01a91ca>]  [<c8845e58>]  [<c01a91eb>]  [<c8845e10>]  [<c01a93c9>]  [<c8845e10>]  [<c8845e10>]  [<c01a973b>]  [<c8845e10>]  [<c8845dfc>]  [<c0187d1e>]  [<c8845e10>]  [<c885b887>]  [<c8845dfc>]  [<c01290c8>]  [<c0108de7>] 
Code: 8b 80 80 01 00 00 85 c0 74 1e 8b 43 14 48 89 43 14 8b 43 08 


Trace; c01129f7 <schedule+3b7/3c0>
Trace; c013170a <__pagevec_release+1a/30>
Trace; c0131c36 <truncate_inode_pages+b6/2a0>
Trace; c014f152 <cached_lookup+12/70>
Trace; c015010d <lookup_hash+3d/90>
Trace; c8845e80 <_end+858b90c/3fd43a8c>
Trace; c015a550 <generic_delete_inode+100/120>
Trace; c015a738 <iput+58/70>
Trace; c016fc3c <sysfs_hash_and_remove+5c/61>
Trace; c8845e10 <_end+858b89c/3fd43a8c>
Trace; c01a919d <device_release_driver+1d/50>
Trace; c8845e58 <_end+858b8e4/3fd43a8c>
Trace; c01a91eb <driver_detach+1b/30>
Trace; c8845e10 <_end+858b89c/3fd43a8c>
Trace; c01a93c9 <bus_remove_driver+29/60>
Trace; c8845e10 <_end+858b89c/3fd43a8c>
Trace; c8845e10 <_end+858b89c/3fd43a8c>
Trace; c01a973b <driver_unregister+b/1b>
Trace; c8845e10 <_end+858b89c/3fd43a8c>
Trace; c8845dfc <_end+858b888/3fd43a8c>
Trace; c0187d1e <pnp_unregister_driver+e/20>
Trace; c8845e10 <_end+858b89c/3fd43a8c>
Trace; c885b887 <_end+85a1313/3fd43a8c>
Trace; c8845dfc <_end+858b888/3fd43a8c>
Trace; c01290c8 <sys_init_module+f8/210>
Trace; c0108de7 <syscall_call+7/b>

>>EIP; c883b938 <_end+85813c4/3fd43a8c>   <=====

>>ebx; c3494000 <_end+31d9a8c/3fd43a8c>
>>ecx; c7ffc860 <_end+7d422ec/3fd43a8c>
>>edx; c3444cc0 <_end+318a74c/3fd43a8c>
>>esi; c8845de0 <_end+858b86c/3fd43a8c>
>>edi; c8845e80 <_end+858b90c/3fd43a8c>
>>ebp; c0243998 <module_mutex+0/10>
>>esp; c3495f14 <_end+31db9a0/3fd43a8c>

Trace; c8845de0 <_end+858b86c/3fd43a8c>
Trace; c8845e80 <_end+858b90c/3fd43a8c>
Trace; c884503e <_end+858aaca/3fd43a8c>
Trace; c0187339 <card_remove_first+49/60>
Trace; c0187c73 <pnp_device_remove+33/40>
Trace; c8845e10 <_end+858b89c/3fd43a8c>
Trace; c01a91ca <device_release_driver+4a/50>
Trace; c8845e58 <_end+858b8e4/3fd43a8c>
Trace; c01a91eb <driver_detach+1b/30>
Trace; c8845e10 <_end+858b89c/3fd43a8c>
Trace; c01a93c9 <bus_remove_driver+29/60>
Trace; c8845e10 <_end+858b89c/3fd43a8c>
Trace; c8845e10 <_end+858b89c/3fd43a8c>
Trace; c01a973b <driver_unregister+b/1b>
Trace; c8845e10 <_end+858b89c/3fd43a8c>
Trace; c8845dfc <_end+858b888/3fd43a8c>
Trace; c0187d1e <pnp_unregister_driver+e/20>
Trace; c8845e10 <_end+858b89c/3fd43a8c>
Trace; c885b887 <_end+85a1313/3fd43a8c>
Trace; c8845dfc <_end+858b888/3fd43a8c>
Trace; c01290c8 <sys_init_module+f8/210>
Trace; c0108de7 <syscall_call+7/b>

Code;  c883b938 <_end+85813c4/3fd43a8c>
00000000 <_EIP>:
Code;  c883b938 <_end+85813c4/3fd43a8c>   <=====
   0:   8b 80 80 01 00 00         mov    0x180(%eax),%eax   <=====
Code;  c883b93e <_end+85813ca/3fd43a8c>
   6:   85 c0                     test   %eax,%eax
Code;  c883b940 <_end+85813cc/3fd43a8c>
   8:   74 1e                     je     28 <_EIP+0x28>
Code;  c883b942 <_end+85813ce/3fd43a8c>
   a:   8b 43 14                  mov    0x14(%ebx),%eax
Code;  c883b945 <_end+85813d1/3fd43a8c>
   d:   48                        dec    %eax
Code;  c883b946 <_end+85813d2/3fd43a8c>
   e:   89 43 14                  mov    %eax,0x14(%ebx)
Code;  c883b949 <_end+85813d5/3fd43a8c>
  11:   8b 43 08                  mov    0x8(%ebx),%eax

Call Trace: [<c01129f7>]  [<c0134eed>]  [<c0138b96>]  [<c0114173>]  [<c0117b96>]  [<c0109634>]  [<c0111171>]  [<c0116448>]  [<c012a4ec>]  [<c0131a0d>]  [<c0131c85>]  [<c0111060>]  [<c010904d>]  [<c8845de0>]  [<c8845e80>]  [<c883b938>]  [<c8845de0>]  [<c8845e80>]  [<c884503e>]  [<c0187339>]  [<c0187c73>]  [<c8845e10>]  [<c01a91ca>]  [<c8845e58>]  [<c01a91eb>]  [<c8845e10>]  [<c01a93c9>]  [<c8845e10>]  [<c8845e10>]  [<c01a973b>]  [<c8845e10>]  [<c8845dfc>]  [<c0187d1e>]  [<c8845e10>]  [<c885b887>]  [<c8845dfc>]  [<c01290c8>]  [<c0108de7>] 
Warning (Oops_read): Code line not seen, dumping what data is available


Trace; c01129f7 <schedule+3b7/3c0>
Trace; c0134eed <unmap_vmas+1ed/240>
Trace; c0138b96 <exit_mmap+66/180>
Trace; c0114173 <mmput+53/a0>
Trace; c0117b96 <do_exit+116/430>
Trace; c0109634 <die+c4/d0>
Trace; c0111171 <do_page_fault+111/469>
Trace; c0116448 <printk+108/170>
Trace; c012a4ec <find_get_pages+2c/70>
Trace; c0131a0d <pagevec_lookup+1d/30>
Trace; c0131c85 <truncate_inode_pages+105/2a0>
Trace; c0111060 <do_page_fault+0/469>
Trace; c010904d <error_code+2d/40>
Trace; c8845de0 <_end+858b86c/3fd43a8c>
Trace; c8845e80 <_end+858b90c/3fd43a8c>
Trace; c883b938 <_end+85813c4/3fd43a8c>
Trace; c8845de0 <_end+858b86c/3fd43a8c>
Trace; c8845e80 <_end+858b90c/3fd43a8c>
Trace; c884503e <_end+858aaca/3fd43a8c>
Trace; c0187339 <card_remove_first+49/60>
Trace; c0187c73 <pnp_device_remove+33/40>
Trace; c8845e10 <_end+858b89c/3fd43a8c>
Trace; c01a91ca <device_release_driver+4a/50>
Trace; c8845e58 <_end+858b8e4/3fd43a8c>
Trace; c01a91eb <driver_detach+1b/30>
Trace; c8845e10 <_end+858b89c/3fd43a8c>
Trace; c01a93c9 <bus_remove_driver+29/60>
Trace; c8845e10 <_end+858b89c/3fd43a8c>
Trace; c8845e10 <_end+858b89c/3fd43a8c>
Trace; c01a973b <driver_unregister+b/1b>
Trace; c8845e10 <_end+858b89c/3fd43a8c>
Trace; c8845dfc <_end+858b888/3fd43a8c>
Trace; c0187d1e <pnp_unregister_driver+e/20>
Trace; c8845e10 <_end+858b89c/3fd43a8c>
Trace; c885b887 <_end+85a1313/3fd43a8c>
Trace; c8845dfc <_end+858b888/3fd43a8c>
Trace; c01290c8 <sys_init_module+f8/210>
Trace; c0108de7 <syscall_call+7/b>


1 warning and 1 error issued.  Results may not be reliable.
$

Any ideas on how to resolve the PNP conflicts seen during the bootup?
Maybe these trigger the oops?

Art Haas

-- 
To announce that there must be no criticism of the President, or that we
are to stand by the President, right or wrong, is not only unpatriotic
and servile, but is morally treasonable to the American public.
 -- Theodore Roosevelt, Kansas City Star, 1918
