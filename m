Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263235AbTE3Ak0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 20:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263239AbTE3Ak0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 20:40:26 -0400
Received: from covert.black-ring.iadfw.net ([209.196.123.142]:41740 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id S263235AbTE3AkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 20:40:06 -0400
Date: Thu, 29 May 2003 19:53:17 -0500
From: Art Haas <ahaas@airmail.net>
To: linux-kernel@vger.kernel.org
Subject: Oops with 2.5.70-bk trying to load cs4236 module
Message-ID: <20030530005316.GA21108@artsapartment.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Here's the skinny on an oops I see when trying to load the cs4236 ALSA
module. My computer has a Turtle Beach Malibu sound card in it, and I
got it installed just before the PNP subsystem was rewritten in 2.5, so
I haven't had the card work yet. Getting it running has been on the
back-burner for a while. With the latest patches in from Al Viro I
thought I'd give it a shot and see if the kernel can load this module
up, but it can't.

Here's the dmesg output from my reboot into the 2.5.70-bk kernel pulled
from May 29. Just after bootin up I tried 'modprobe snd-card-0' and got
the oops.

The dmesg output does show that the card has some PNP conflicts
detected during the boot up. I have no idea how to fix this, and would
welcome some suggestions from some hardware-savvy people about how to
resolve these conflicts. Onward to the dmesg output and ksymoops
readout ...

$ dmesg
Linux version 2.5.70-ajh2 (arth@pcdebian) (gcc version 3.3) #1 Thu May 29 13:36:09 CDT 2003
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
Kernel command line: BOOT_IMAGE=lnx-2.5.70ajh2 ro root=301 pci=usepirqmask ide=nodma mce
ide_setup: ide=nodmaIDE: Prevented DMA
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 199.777 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 395.26 BogoMIPS
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
ALSA sound/isa/cs423x/cs4236.c:380: isapnp MPU: port=0x338, irq=-1
ALSA sound/isa/cs423x/cs4231_lib.c:1056: cs4231: port = 0x538, id = 0xa
ALSA sound/isa/cs423x/cs4231_lib.c:1062: CS4231: VERSION (I25) = 0x3
ALSA sound/isa/cs423x/cs4231_lib.c:1131: CS4231: ext version; rev = 0xc8, id = 0xc8
ALSA sound/isa/cs423x/cs4236_lib.c:302: CS4236: [0x1000] C1 (version) = 0xff, ext = 0xc8
ALSA sound/isa/cs423x/cs4236_lib.c:304: CS4236+ chip detected, but control port 0x1000 is not valid
CS4236+ soundcard not found or device busy
bad: scheduling while atomic!
Call Trace: [<c01129e7>]  [<c0112cac>]  [<c0112a40>]  [<c0112a40>]  [<c8846e80>]  [<c0123a8e>]  [<c0123a50>]  [<c0129143>]  [<c0108de7>] 
Unable to handle kernel paging request at virtual address 40130780
 printing eip:
40097106
*pde = 0776c067
*pte = 00000000
Oops: 0004 [#1]
CPU:    0
EIP:    0073:[<40097106>]    Not tainted
EFLAGS: 00010202
eax: 40130780   ebx: 401408c8   ecx: 00000080   edx: 00000013
esi: 00000013   edi: 0804f6b8   ebp: bffffa08   esp: bffff9c0
ds: 007b   es: 007b   ss: 007b
Process modprobe (pid: 561, threadinfo=c7832000 task=c6e02720)
 <6>note: modprobe[561] exited with preempt_count 3
bad: scheduling while atomic!
Call Trace: [<c01129e7>]  [<c0134e8d>]  [<c0138b36>]  [<c0114163>]  [<c0117b86>]  [<c0109624>]  [<c0111161>]  [<c013ddef>]  [<c013e0f4>]  [<c013e13c>]  [<c01282aa>]  [<c0111050>]  [<c010904d>] 


Running this through ksymoops gives the following ...

$ ksymoops (... options ...)
ksymoops 2.4.9 on i586 2.5.70-ajh2.  Options used
     -v /mnt/src/linux-ajh/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.70-ajh2/ (default)
     -m /boot/System.map-2.5.70-ajh2 (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Intel Pentium with F0 0F bug - workaround enabled.
warning: process `update' used the obsolete bdflush system call
8139too Fast Ethernet driver 0.9.26
Call Trace: [<c01129e7>]  [<c0112cac>]  [<c0112a40>]  [<c0112a40>]  [<c8846e80>]  [<c0123a8e>]  [<c0123a50>]  [<c0129143>]  [<c0108de7>] 
Unable to handle kernel paging request at virtual address 40130780
40097106
*pde = 0776c067
Oops: 0004 [#1]
CPU:    0
EIP:    0073:[<40097106>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 40130780   ebx: 401408c8   ecx: 00000080   edx: 00000013
esi: 00000013   edi: 0804f6b8   ebp: bffffa08   esp: bffff9c0
ds: 007b   es: 007b   ss: 007b
Call Trace: [<c01129e7>]  [<c0134e8d>]  [<c0138b36>]  [<c0114163>]  [<c0117b86>]  [<c0109624>]  [<c0111161>]  [<c013ddef>]  [<c013e0f4>]  [<c013e13c>]  [<c01282aa>]  [<c0111050>]  [<c010904d>] 
Warning (Oops_read): Code line not seen, dumping what data is available


Trace; c01129e7 <schedule+3b7/3c0>
Trace; c0112cac <wait_for_completion+7c/d0>
Trace; c0112a40 <default_wake_function+0/20>
Trace; c0112a40 <default_wake_function+0/20>
Trace; c8846e80 <_end+858c90c/3fd43a8c>
Trace; c0123a8e <synchronize_kernel+2e/40>
Trace; c0123a50 <wakeme_after_rcu+0/10>
Trace; c0129143 <sys_init_module+183/210>
Trace; c0108de7 <syscall_call+7/b>

>>EIP; 40097106 Before first symbol   <=====

Trace; c01129e7 <schedule+3b7/3c0>
Trace; c0134e8d <unmap_vmas+1ed/240>
Trace; c0138b36 <exit_mmap+66/180>
Trace; c0114163 <mmput+53/a0>
Trace; c0117b86 <do_exit+116/430>
Trace; c0109624 <die+c4/d0>
Trace; c0111161 <do_page_fault+111/469>
Trace; c013ddef <unmap_vm_area+2f/80>
Trace; c013e0f4 <__vunmap+74/a0>
Trace; c013e13c <vfree+1c/30>
Trace; c01282aa <free_module+5a/70>
Trace; c0111050 <do_page_fault+0/469>
Trace; c010904d <error_code+2d/40>


1 warning and 1 error issued.  Results may not be reliable.

Here's a trimmed version of what I see in /var/log/messages ...

May 29 16:24:49 pcdebian kernel: ALSA sound/isa/cs423x/cs4236.c:334: isapnp WSS: wss port=0x538, fm port=0x390, sb port=0x240
May 29 16:24:49 pcdebian kernel: ALSA sound/isa/cs423x/cs4236.c:336: isapnp WSS: irq=5, dma1=1, dma2=3
May 29 16:24:49 pcdebian kernel: ALSA sound/isa/cs423x/cs4236.c:353: isapnp CTRL: control port=0x1000
May 29 16:24:49 pcdebian kernel: ALSA sound/isa/cs423x/cs4236.c:380: isapnp MPU: port=0x338, irq=-1
May 29 16:24:49 pcdebian kernel: ALSA sound/isa/cs423x/cs4231_lib.c:1056: cs4231: port = 0x538, id = 0xa
May 29 16:24:49 pcdebian kernel: ALSA sound/isa/cs423x/cs4231_lib.c:1062: CS4231: VERSION (I25) = 0x3
May 29 16:24:49 pcdebian kernel: ALSA sound/isa/cs423x/cs4231_lib.c:1131: CS4231: ext version; rev = 0xc8, id = 0xc8
May 29 16:24:49 pcdebian kernel: ALSA sound/isa/cs423x/cs4236_lib.c:302: CS4236: [0x1000] C1 (version) = 0xff, ext = 0xc8
May 29 16:24:49 pcdebian kernel: ALSA sound/isa/cs423x/cs4236_lib.c:304: CS4236+ chip detected, but control port 0x1000 is not valid
May 29 16:24:49 pcdebian kernel: Call Trace: [schedule+951/960]  [wait_for_completion+124/208]  [default_wake_function+0/32]  [default_wake_function+0/32]  [_end+140036364/1070873228]  [synchronize_kernel+46/64]  [wakeme_after_rcu+0/16]  [sys_init_module+387/528]  [syscall_call+7/11] 
May 29 16:24:49 pcdebian kernel:  printing eip:
May 29 16:24:49 pcdebian kernel: 40097106
May 29 16:24:49 pcdebian kernel: Oops: 0004 [#1]
May 29 16:24:49 pcdebian kernel: CPU:    0
May 29 16:24:49 pcdebian kernel: EIP:    0073:[_binary_usr_initramfs_data_cpio_gz_size+1074360454/-1072693376]    Not tainted
May 29 16:24:49 pcdebian kernel: EFLAGS: 00010202
May 29 16:24:49 pcdebian kernel: eax: 40130780   ebx: 401408c8   ecx: 00000080   edx: 00000013
May 29 16:24:49 pcdebian kernel: esi: 00000013   edi: 0804f6b8   ebp: bffffa08   esp: bffff9c0
May 29 16:24:49 pcdebian kernel: ds: 007b   es: 007b   ss: 007b
May 29 16:24:49 pcdebian kernel: Process modprobe (pid: 561, threadinfo=c7832000 task=c6e02720)
May 29 16:24:49 pcdebian kernel:  <6>note: modprobe[561] exited with preempt_count 3
May 29 16:24:49 pcdebian kernel: Call Trace: [schedule+951/960]  [unmap_vmas+493/576]  [exit_mmap+102/384]  [mmput+83/160]  [do_exit+278/1072]  [die+196/208]  [do_page_fault+273/1129]  [unmap_vm_area+47/128]  [__vunmap+116/160]  [vfree+28/48]  [free_module+90/112]  [do_page_fault+0/1129]  [error_code+45/64] 

More info can be provided on request. Thanks in advance for looking at
this. A double thanks in advance to the person or people who can help me
resolve the PNP conflicts I see during the message. Any recommendations
on a forum or mailing list where hardware issues/gripes can be resolved?

Art Haas
-- 
To announce that there must be no criticism of the President, or that we
are to stand by the President, right or wrong, is not only unpatriotic
and servile, but is morally treasonable to the American public.
 -- Theodore Roosevelt, Kansas City Star, 1918
