Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265988AbTGFG1Q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 02:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266613AbTGFG1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 02:27:16 -0400
Received: from mail.tbdnetworks.com ([63.209.25.99]:65035 "EHLO stargazer")
	by vger.kernel.org with ESMTP id S265988AbTGFG1F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 02:27:05 -0400
Date: Sat, 5 Jul 2003 23:41:36 -0700
To: linux-kernel@vger.kernel.org
Subject: OOPS: 2.5.74-bk3 during boot
Message-ID: <20030706064136.GA28895@tbdnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Norbert Kiesel <nkiesel@tbdnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I get the following oops after upgrading from 2.5.74-bk2, I get the
following oops during boot (dmesg below).

--nk

ksymoops 2.4.8 on i686 2.5.74-bk3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.74-bk3/ (default)
     -m /boot/System.map-2.5.74-bk3 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel NULL pointer dereference at virtual address 00000000
00000000
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<00000000>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: c0313660   ebx: fffffff4   ecx: c74485fc   edx: c74485fc
esi: c77dc070   edi: c13bed00   ebp: c7455f70   esp: c7455f08
ds: 007b   es: 007b   ss: 0068
Stack: c015f024 c77dc070 c13bed00 c7455f70 ffffffd8 c74485e0 00008242 c7455f70 
       c015f809 c7455f78 c74485e0 c7455f70 00000000 c7455f78 00000001 00000002 
       c74482c0 00008241 400098b8 c77dd000 c7454000 c014fd8e c77dd000 00008242 
Call Trace: [<c015f024>]  [<c015f809>]  [<c014fd8e>]  [<c015025b>]  [<c010ae4b>] 
Code:  Bad EIP value.


>>EIP; 00000000 Before first symbol

>>eax; c0313660 <proc_link_inode_operations+0/4c>
>>ebx; fffffff4 <__kernel_rt_sigreturn+1bb4/????>
>>ecx; c74485fc <__crc_dump_fpu+3bbed1/3c77be>
>>edx; c74485fc <__crc_dump_fpu+3bbed1/3c77be>
>>esi; c77dc070 <__crc_xfrm_state_walk+939ab/1dd519>
>>edi; c13bed00 <__crc_kset_find_obj+91dba/2cad8a>
>>ebp; c7455f70 <__crc_alloc_tty_driver+2087/108adc>
>>esp; c7455f08 <__crc_alloc_tty_driver+201f/108adc>

Trace; c015f024 <__lookup_hash+a4/e0>
Trace; c015f809 <open_namei+2e9/430>
Trace; c014fd8e <filp_open+3e/70>
Trace; c015025b <sys_open+5b/90>
Trace; c010ae4b <syscall_call+7/b>


1 warning and 1 error issued.  Results may not be reliable.


Linux version 2.5.74-bk3 (nkiesel@voyager) (gcc version 3.3.1 20030626 (Debian prerelease)) #6 Sat Jul 5 23:12:11 PDT 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8400 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000077f0000 (usable)
 BIOS-e820: 00000000077f0000 - 00000000077ffc00 (ACPI data)
 BIOS-e820: 00000000077ffc00 - 0000000007800000 (ACPI NVS)
 BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)
119MB LOWMEM available.
On node 0 totalpages: 30704
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 26608 pages, LIFO batch:6
  HighMem zone: 0 pages, LIFO batch:1
Compaq 12XL125 machine detected. Enabling interrupts during APM calls.
ACPI: RSDP (v000 PTLTD                      ) @ 0x000f72e0
ACPI: RSDT (v001 PTLTD    RSDT   01540.00000) @ 0x077fcab8
ACPI: FADT (v001 COMPAQ Wrangler 01540.00000) @ 0x077ffb8c
ACPI: DSDT (v001 Compaq Wrangler 01540.00000) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: MADT not present
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=Linux-2.5 ro root=305
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 512 (order 9: 4096 bytes)
Detected 498.520 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 974.84 BogoMIPS
Memory: 118324k/122816k available (1801k kernel code, 3956k reserved, 577k data, 148k init, 0k highmem)
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium III (Coppermine) stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 498.0053 MHz.
..... host bus clock speed is 99.0610 MHz.
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfd83e, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 230 entries (12 bytes)
biovec pool[1]:   4 bvecs: 230 entries (48 bytes)
biovec pool[2]:  16 bvecs: 230 entries (192 bytes)
biovec pool[3]:  64 bvecs: 230 entries (768 bytes)
biovec pool[4]: 128 bvecs: 115 entries (1536 bytes)
biovec pool[5]: 256 bvecs:  57 entries (3072 bytes)
ACPI: Subsystem revision 20030619
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 7 9 *11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 9, disabled)
ACPI: PCI Interrupt Link [LNKC] (IRQs 7 *9 11 12)
ACPI: PCI Interrupt Link [LNKD] (IRQs 7 9 *11 12)
ACPI: Embedded Controller [EC] (gpe 6)
Linux Plug and Play Support v0.96 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f7300
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xa0eb, dseg 0x400
PnPBIOS: 18 nodes reported by PnP BIOS; 18 recorded by driver
block request queues:
 4/128 requests per read queue
 4/128 requests per write queue
 enter congestion at 15
 exit congestion at 17
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 9
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
pty: 256 Unix98 ptys configured
Enabling SEP on CPU 0
Journalled Block Device driver loaded
Initializing Cryptographic API
PCI: Disabling Via external APIC routing
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.11
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686a (rev 1b) IDE UDMA66 controller on pci0000:00:07.1
    ide0: BM-DMA at 0x1420-0x1427, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1428-0x142f, BIOS settings: hdc:DMA, hdd:pio
hda: TOSHIBA MK6014MAP, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: TOSHIBA DVD-ROM SD-C2302, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: host protected area => 1
hda: 11733120 sectors (6007 MB), CHS=12416/15/63
 hda: hda1 hda2 < hda5 > hda3 hda4
hdc: ATAPI 24X DVD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
ti113x: Routing card interrupts to PCI
Yenta IRQ list 0000, PCI irq9
Socket status: 30000010
Intel PCIC probe: not found.
mice: PS/2 mouse device common for all mice
input: PC Speaker
Synaptics Touchpad, model: 1
 Firware: 4.6
 Sensor: 15
 new absolute packet format
 Touchpad has extended capability bits
 -> four buttons
 -> multifinger detection
 -> palm detection
input: Synaptics Synaptics TouchPad on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 16384)
Initializing IPsec netlink socket
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 148k freed
Adding 234352k swap on /dev/hda4.  Priority:-1 extents:1
EXT3 FS on hda5, internal journal
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
00000000
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<00000000>]    Not tainted
EFLAGS: 00010286
eax: c0313660   ebx: fffffff4   ecx: c74485fc   edx: c74485fc
esi: c77dc070   edi: c13bed00   ebp: c7455f70   esp: c7455f08
ds: 007b   es: 007b   ss: 0068
Process rcS (pid: 25, threadinfo=c7454000 task=c76a2680)
Stack: c015f024 c77dc070 c13bed00 c7455f70 ffffffd8 c74485e0 00008242 c7455f70 
       c015f809 c7455f78 c74485e0 c7455f70 00000000 c7455f78 00000001 00000002 
       c74482c0 00008241 400098b8 c77dd000 c7454000 c014fd8e c77dd000 00008242 
Call Trace: [<c015f024>]  [<c015f809>]  [<c014fd8e>]  [<c015025b>]  [<c010ae4b>] 
Code:  Bad EIP value.
 <6>Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
Please use the 'usbfs' filetype instead, the 'usbdevfs' name is deprecated.
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
uhci-hcd 0000:00:07.2: VIA Technologies, In USB
uhci-hcd 0000:00:07.2: irq 11, io base 00001400
Please use the 'usbfs' filetype instead, the 'usbdevfs' name is deprecated.
uhci-hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
hub 1-0:0: USB hub found
hub 1-0:0: 2 ports detected
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Processor [CPU0] (supports C1 C2)
ACPI: Thermal Zone [THRM] (50 C)
PCI: Setting latency timer of device 0000:00:07.5 to 64
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x220-0x22f 0x378-0x37f 0x388-0x38f 0x3c0-0x3df 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
eth0: Xircom: port 0x300, irq 9, hwaddr 00:10:A4:E0:83:40
eth0: media 10BaseT, silicon revision 4
eth0: no IPv6 routers present
