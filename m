Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264326AbTKUI0U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 03:26:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264327AbTKUI0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 03:26:20 -0500
Received: from imap.gmx.net ([213.165.64.20]:21229 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264326AbTKUIZQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 03:25:16 -0500
X-Authenticated: #4512188
Message-ID: <3FBDCCDF.9010304@gmx.de>
Date: Fri, 21 Nov 2003 09:29:19 +0100
From: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031116
X-Accept-Language: de-de, de, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test9-mm4
References: <20031118225120.1d213db2.akpm@osdl.org>
In-Reply-To: <20031118225120.1d213db2.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DMESG gives me following:

Debug: sleeping function called from invalid context at mm/slab.c:1868
in_atomic():1, irqs_disabled():0
Call Trace:
  [<c0120fbb>] __might_sleep+0xab/0xd0
  [<c0144fa5>] kmem_cache_alloc+0x65/0x70
  [<c0155161>] __get_vm_area+0x21/0xf0
  [<c0155263>] get_vm_area+0x33/0x40
  [<c011df03>] __ioremap+0xb3/0x100
  [<c011df79>] ioremap_nocache+0x29/0xb0
  [<f9a5ad87>] os_map_kernel_space+0x68/0x6c [nvidia]
  [<f9a6d377>] __nvsym00568+0x1f/0x2c [nvidia]
  [<f9a6f496>] __nvsym00775+0x6e/0xe0 [nvidia]
  [<f9a6f526>] __nvsym00781+0x1e/0x190 [nvidia]
  [<f9a70fac>] rm_init_adapter+0xc/0x10 [nvidia]
  [<f9a57dc9>] nv_kern_open+0xf3/0x228 [nvidia]
  [<c0164b40>] exact_match+0x0/0x10
  [<c0164941>] chrdev_open+0xf1/0x220
  [<c01aa332>] devfs_open+0xe2/0xf0
  [<c0159f32>] dentry_open+0x152/0x270
  [<c0159ddb>] filp_open+0x5b/0x60
  [<c015a2c3>] sys_open+0x53/0x90
  [<c041f532>] sysenter_past_esp+0x43/0x65

Debug: sleeping function called from invalid context at mm/slab.c:1868
in_atomic():1, irqs_disabled():0
Call Trace:
  [<c0120fbb>] __might_sleep+0xab/0xd0
  [<c0144fa5>] kmem_cache_alloc+0x65/0x70
  [<c0155161>] __get_vm_area+0x21/0xf0
  [<c0155263>] get_vm_area+0x33/0x40
  [<c011df03>] __ioremap+0xb3/0x100
  [<c011df79>] ioremap_nocache+0x29/0xb0
  [<f9a5ad87>] os_map_kernel_space+0x68/0x6c [nvidia]
  [<f9a6d377>] __nvsym00568+0x1f/0x2c [nvidia]
  [<f9a6f496>] __nvsym00775+0x6e/0xe0 [nvidia]
  [<f9a6f526>] __nvsym00781+0x1e/0x190 [nvidia]
  [<f9a70fac>] rm_init_adapter+0xc/0x10 [nvidia]
  [<f9a57dc9>] nv_kern_open+0xf3/0x228 [nvidia]
  [<c0164c82>] cdev_get+0x52/0xb0
  [<c0164941>] chrdev_open+0xf1/0x220
  [<c01aa332>] devfs_open+0xe2/0xf0
  [<c0159f32>] dentry_open+0x152/0x270
  [<c0159ddb>] filp_open+0x5b/0x60
  [<c015a2c3>] sys_open+0x53/0x90
  [<c041f532>] sysenter_past_esp+0x43/0x65

atkbd.c: Unknown key released (translated set 2, code 0x7a on 
isa0060/serio0).
atkbd.c: Unknown key released (translated set 2, code 0x7a on 
isa0060/serio0).
------------[ cut here ]------------
kernel BUG at arch/i386/mm/fault.c:357!
invalid operand: 0000 [#1]
PREEMPT
CPU:    0
EIP:    0060:[<c011da40>]    Tainted: PF  VLI
EFLAGS: 00210293
EIP is at do_page_fault+0x3a0/0x53a
eax: f6415dc0   ebx: f6415dc0   ecx: 00000000   edx: f6415dc0
esi: f6415de0   edi: f69f9180   ebp: f6c3dfb4   esp: f6c3df0c
ds: 007b   es: 007b   ss: 0068
Process artsd (pid: 3742, threadinfo=f6c3c000 task=f63e5980)
Stack: f6415dc0 f69f9180 40002004 00000001 00000001 40002004 f63e5980 
00000000
        00000001 00030002 bfffeca0 f7d13840 f6c3df90 c038b287 f7d13840 
bfffeca0
        bfffeca0 f6c3df6c f6c3df74 f9a589b9 00000000 f6c3df6c f7d85e28 
f6c3dfc4
Call Trace:
  [<c038b287>] snd_pcm_playback_ioctl1+0x57/0x4a0
  [<f9a589b9>] nv_kern_isr+0x25/0x5c [nvidia]
  [<c010d80b>] handle_IRQ_event+0x3b/0x70
  [<c016de9e>] sys_ioctl+0xbe/0x2a0
  [<c011d6a0>] do_page_fault+0x0/0x53a
  [<c041f733>] error_code+0x2f/0x38

Code: 8a 8b 85 70 ff ff ff c7 04 24 14 7d 43 c0 05 02 03 00 00 89 44 24 
04 e8 4f 61 00 00 f6 45 0c 04 0f 84 85 fd ff ff e9 57 fe ff ff <0f> 0b 
65 01 2c 7d 43 c0 8b 55 08 f6 42 32 02 74 27 8b 8d 6c ff
  ------------[ cut here ]------------
kernel BUG at arch/i386/mm/fault.c:357!
invalid operand: 0000 [#2]
PREEMPT
CPU:    0
EIP:    0060:[<c011da40>]    Tainted: PF  VLI
EFLAGS: 00210293
EIP is at do_page_fault+0x3a0/0x53a
eax: f64154c0   ebx: f64154c0   ecx: 00000000   edx: f64154c0
esi: f64154e0   edi: f5f01580   ebp: f6183fb4   esp: f6183f0c
ds: 007b   es: 007b   ss: 0068
Process aplay (pid: 3769, threadinfo=f6182000 task=f6199300)
Stack: f64154c0 f5f01580 40001004 00000001 00000001 40001004 f6199300 
40002000
        0000e000 00030002 c014df8f f64154c0 f5f015c0 f5f01580 f5f015a0 
f5f01598
        000800fb f5ac0d40 00000000 00000000 00000000 00000000 001000fb 
f7cd6800
Call Trace:
  [<c014df8f>] do_mmap_pgoff+0x35f/0x670
  [<c0112146>] sys_mmap2+0xc6/0xd0
  [<c011d6a0>] do_page_fault+0x0/0x53a
  [<c041f733>] error_code+0x2f/0x38

Code: 8a 8b 85 70 ff ff ff c7 04 24 14 7d 43 c0 05 02 03 00 00 89 44 24 
04 e8 4f 61 00 00 f6 45 0c 04 0f 84 85 fd ff ff e9 57 fe ff ff <0f> 0b 
65 01 2c 7d 43 c0 8b 55 08 f6 42 32 02 74 27 8b 8d 6c ff


It could be that also prvieous mm versions produced this, but only 
lately I set the first value of /proc/sys/kernel/printk to 6 instead of 1.

Another problem is when I reboot, just before the message "remounting 
readonly" (I think) I get two call traces regarding fault in 
inculde/asm/atomic.h and it seems some problem with ntfs driver, as this 
appears various times there. (I don't know how to catch the output just 
before rebooting..)

bash-2.05b$ dmesg
ting delay loop... 1888.25 BogoMIPS
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
checking if image is initramfs...it isn't (ungzip failed); looks like an 
initrd
Freeing initrd memory: 304k freed
CPU:     After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000
CPU:     After vendor identify, caps: 0383fbff c1c3fbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After all inits, caps: 0383fbff c1c3fbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm)  stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb420, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20031002
ACPI: IRQ 9 was Edge Triggered, setting to Level Triggerd
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [APC1] (IRQs *16)
ACPI: PCI Interrupt Link [APC2] (IRQs 17)
ACPI: PCI Interrupt Link [APC3] (IRQs *18)
ACPI: PCI Interrupt Link [APC4] (IRQs *19)
ACPI: PCI Interrupt Link [APCE] (IRQs 16)
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCS] (IRQs *23)
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22)
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ACPI: PCI Interrupt Link [LSMB] enabled at IRQ 10
ACPI: PCI Interrupt Link [LUBA] enabled at IRQ 11
ACPI: PCI Interrupt Link [LUBB] enabled at IRQ 5
ACPI: PCI Interrupt Link [LUB2] enabled at IRQ 10
ACPI: PCI Interrupt Link [LMAC] enabled at IRQ 10
ACPI: PCI Interrupt Link [LAPU] enabled at IRQ 10
ACPI: PCI Interrupt Link [LACI] enabled at IRQ 5
ACPI: PCI Interrupt Link [LFIR] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNK4] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNK3] enabled at IRQ 11
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 
'acpi=off'
vesafb: framebuffer at 0xc0000000, mapped to 0xf8808000, size 16384k
vesafb: mode is 1280x1024x16, linelength=2560, pages=1
vesafb: protected mode interface info at c000:ea60
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
fb0: VESA VGA frame buffer device
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.13 <tigran@veritas.com>
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
apm: overridden by ACPI.
highmem bounce pool size: 64 pages
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.5 [Flags: R/W].
udf: registering filesystem
SGI XFS for Linux with large block numbers, no debug enabled
ACPI: Power Button (FF) [PWRF]
ACPI: Fan [FAN] (on)
ACPI: Processor [CPU0] (supports C1)
ACPI: Thermal Zone [THRM] (40 C)
Console: switching to colour frame buffer device 160x64
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Using cfq io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.18.
PCI: Setting latency timer of device 0000:00:04.0 to 64
eth0: forcedeth.c: subsystem: 0147b:1c00
Linux video capture interface: v1.00
DriverInitialize MAC address = ff:ff:ff:ff:ff:ff:00:00
DriverInitialize key =
  ff ff ff ff
  ff ff ff ff
  ff ff ff ff
  ff ff ff ff
DVB: registering new adapter (Technisat SkyStar2 driver).
DVB: registering frontend 0:0 (Zarlink MT312)...
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE2: IDE controller at PCI slot 0000:00:09.0
NFORCE2: chipset revision 162
NFORCE2: not 100% native mode: will probe irqs later
NFORCE2: 0000:00:09.0 (rev a2) UDMA133 controller
     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: _NEC DV-5800A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: LITE-ON LTR-16102B, ATAPI CD/DVD-ROM drive
hdd: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
ide1 at 0x170-0x177,0x376 on irq 15
SiI3112 Serial ATA: IDE controller at PCI slot 0000:01:0b.0
SiI3112 Serial ATA: chipset revision 2
SiI3112 Serial ATA: 100% native mode on irq 11
     ide2: MMIO-DMA at 0xf9844000-0xf9844007, BIOS settings: hde:pio, 
hdf:pio
     ide3: MMIO-DMA at 0xf9844008-0xf984400f, BIOS settings: hdg:pio, 
hdh:pio
hde: SAMSUNG SP1614N, ATA DISK drive
ide2 at 0xf9844080-0xf9844087,0xf984408a on irq 11
hde: max request size: 7KiB
hde: 312581808 sectors (160041 MB) w/8192KiB Cache, CHS=19457/255/63, 
UDMA(100)
  /dev/ide/host2/bus0/target0/lun0: p1 p2 p3 < p5 p6 p7 p8 p9 >
hda: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
hdc: ATAPI 40X CD-ROM CD-R/RW drive, 2048kB Cache, DMA
ide-floppy driver 0.99.newide
hdd: No disk in drive
hdd: 98304kB, 32/64/96 CHS, 4096 kBps, 512 sector size, 2941 rpm
ohci1394: $Rev: 1045 $ Ben Collins <bcollins@debian.org>
PCI: Setting latency timer of device 0000:00:0d.0 to 64
ohci1394_0: OHCI-1394 1.1 (PCI): IRQ=[11]  MMIO=[cc084000-cc0847ff]  Max 
Packet=[2048]
ohci1394_0: SelfID received outside of bus reset sequence
video1394: Installed video1394 module
raw1394: /dev/raw1394 device initialized
Console: switching to colour frame buffer device 160x64
ehci_hcd 0000:00:02.2: EHCI Host Controller
PCI: Setting latency timer of device 0000:00:02.2 to 64
ehci_hcd 0000:00:02.2: irq 10, pci mem f984c000
ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 1
PCI: cache line size of 64 is not supported by device 0000:00:02.2
ehci_hcd 0000:00:02.2: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-13
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
ohci_hcd: 2003 Oct 13 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
ohci_hcd 0000:00:02.0: OHCI Host Controller
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: irq 11, pci mem f984e000
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
ohci_hcd 0000:00:02.1: OHCI Host Controller
PCI: Setting latency timer of device 0000:00:02.1 to 64
ohci_hcd 0000:00:02.1: irq 5, pci mem f9850000
ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 3 ports detected
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface 
driver v2.1
drivers/usb/core/usb.c: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
drivers/usb/core/usb.c: registered new driver usbscanner
drivers/usb/image/scanner.c: 0.4.15:USB Scanner Driver
mice: PS/2 mouse device common for all mice
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
I2O Core - (C) Copyright 1999 Red Hat Software
I2O: Event thread created as pid 16
i2o: Checking for PCI I2O controllers...
I2O configuration manager v 0.04.
   (C) Copyright 1999 Red Hat Software
i2c /dev entries driver
i2c_adapter i2c-0: nForce2 SMBus adapter at 0x5000
i2c_adapter i2c-1: nForce2 SMBus adapter at 0x5100
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[000000508df0fbe3]
Advanced Linux Sound Architecture Driver Version 0.9.7 (Thu Sep 25 
19:16:36 2003 UTC).
request_module: failed /sbin/modprobe -- snd-card-0. error = -16
PCI: Setting latency timer of device 0000:00:06.0 to 64
hub 2-0:1.0: new USB device on port 1, assigned address 2
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 2 if 0 
alt 1 proto 2 vid 0x03F0 pid 0x1004
intel8x0_measure_ac97_clock: measured 49854 usecs
intel8x0: clocking to 47386
ALSA device list:
   #0: NVidia nForce2 at 0xcc081000, irq 5
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S3 S4 S5)
UDF-fs DEBUG fs/udf/lowlevel.c:65:udf_get_last_session: 
CDROMMULTISESSION not supported: rc=-22
UDF-fs DEBUG fs/udf/super.c:1544:udf_fill_super: Multi-session=0
UDF-fs DEBUG fs/udf/super.c:532:udf_vrs: Starting at sector 16 (2048 
byte sectors)
UDF-fs: No VRS found
XFS mounting filesystem hde6
Ending clean XFS mount for filesystem: hde6
VFS: Mounted root (xfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 160k freed
NTFS volume version 3.1.
NTFS volume version 3.1.
nvidia: no version magic, tainting kernel.
nvidia: module license 'NVIDIA' taints kernel.
0: nvidia: loading NVIDIA Linux x86 nvidia.o Kernel Module  1.0-4496 
Wed Jul 16 19:03:09 PDT 2003
Debug: sleeping function called from invalid context at mm/slab.c:1868
in_atomic():1, irqs_disabled():0
Call Trace:
  [<c0120fbb>] __might_sleep+0xab/0xd0
  [<c0144fa5>] kmem_cache_alloc+0x65/0x70
  [<c0155161>] __get_vm_area+0x21/0xf0
  [<c0155263>] get_vm_area+0x33/0x40
  [<c011df03>] __ioremap+0xb3/0x100
  [<c011df79>] ioremap_nocache+0x29/0xb0
  [<f9a5ad87>] os_map_kernel_space+0x68/0x6c [nvidia]
  [<f9a6d377>] __nvsym00568+0x1f/0x2c [nvidia]
  [<f9a6f496>] __nvsym00775+0x6e/0xe0 [nvidia]
  [<f9a6f526>] __nvsym00781+0x1e/0x190 [nvidia]
  [<f9a70fac>] rm_init_adapter+0xc/0x10 [nvidia]
  [<f9a57dc9>] nv_kern_open+0xf3/0x228 [nvidia]
  [<c0164b40>] exact_match+0x0/0x10
  [<c0164941>] chrdev_open+0xf1/0x220
  [<c01aa332>] devfs_open+0xe2/0xf0
  [<c0159f32>] dentry_open+0x152/0x270
  [<c0159ddb>] filp_open+0x5b/0x60
  [<c015a2c3>] sys_open+0x53/0x90
  [<c041f532>] sysenter_past_esp+0x43/0x65

Debug: sleeping function called from invalid context at mm/slab.c:1868
in_atomic():1, irqs_disabled():0
Call Trace:
  [<c0120fbb>] __might_sleep+0xab/0xd0
  [<c0144fa5>] kmem_cache_alloc+0x65/0x70
  [<c0155161>] __get_vm_area+0x21/0xf0
  [<c0155263>] get_vm_area+0x33/0x40
  [<c011df03>] __ioremap+0xb3/0x100
  [<c011df79>] ioremap_nocache+0x29/0xb0
  [<f9a5ad87>] os_map_kernel_space+0x68/0x6c [nvidia]
  [<f9a6d377>] __nvsym00568+0x1f/0x2c [nvidia]
  [<f9a6f496>] __nvsym00775+0x6e/0xe0 [nvidia]
  [<f9a6f526>] __nvsym00781+0x1e/0x190 [nvidia]
  [<f9a70fac>] rm_init_adapter+0xc/0x10 [nvidia]
  [<f9a57dc9>] nv_kern_open+0xf3/0x228 [nvidia]
  [<c0164c82>] cdev_get+0x52/0xb0
  [<c0164941>] chrdev_open+0xf1/0x220
  [<c01aa332>] devfs_open+0xe2/0xf0
  [<c0159f32>] dentry_open+0x152/0x270
  [<c0159ddb>] filp_open+0x5b/0x60
  [<c015a2c3>] sys_open+0x53/0x90
  [<c041f532>] sysenter_past_esp+0x43/0x65

atkbd.c: Unknown key released (translated set 2, code 0x7a on 
isa0060/serio0).
atkbd.c: Unknown key released (translated set 2, code 0x7a on 
isa0060/serio0).
------------[ cut here ]------------
kernel BUG at arch/i386/mm/fault.c:357!
invalid operand: 0000 [#1]
PREEMPT
CPU:    0
EIP:    0060:[<c011da40>]    Tainted: PF  VLI
EFLAGS: 00210293
EIP is at do_page_fault+0x3a0/0x53a
eax: f6415dc0   ebx: f6415dc0   ecx: 00000000   edx: f6415dc0
esi: f6415de0   edi: f69f9180   ebp: f6c3dfb4   esp: f6c3df0c
ds: 007b   es: 007b   ss: 0068
Process artsd (pid: 3742, threadinfo=f6c3c000 task=f63e5980)
Stack: f6415dc0 f69f9180 40002004 00000001 00000001 40002004 f63e5980 
00000000
        00000001 00030002 bfffeca0 f7d13840 f6c3df90 c038b287 f7d13840 
bfffeca0
        bfffeca0 f6c3df6c f6c3df74 f9a589b9 00000000 f6c3df6c f7d85e28 
f6c3dfc4
Call Trace:
  [<c038b287>] snd_pcm_playback_ioctl1+0x57/0x4a0
  [<f9a589b9>] nv_kern_isr+0x25/0x5c [nvidia]
  [<c010d80b>] handle_IRQ_event+0x3b/0x70
  [<c016de9e>] sys_ioctl+0xbe/0x2a0
  [<c011d6a0>] do_page_fault+0x0/0x53a
  [<c041f733>] error_code+0x2f/0x38

Code: 8a 8b 85 70 ff ff ff c7 04 24 14 7d 43 c0 05 02 03 00 00 89 44 24 
04 e8 4f 61 00 00 f6 45 0c 04 0f 84 85 fd ff ff e9 57 fe ff ff <0f> 0b 
65 01 2c 7d 43 c0 8b 55 08 f6 42 32 02 74 27 8b 8d 6c ff
  ------------[ cut here ]------------
kernel BUG at arch/i386/mm/fault.c:357!
invalid operand: 0000 [#2]
PREEMPT
CPU:    0
EIP:    0060:[<c011da40>]    Tainted: PF  VLI
EFLAGS: 00210293
EIP is at do_page_fault+0x3a0/0x53a
eax: f64154c0   ebx: f64154c0   ecx: 00000000   edx: f64154c0
esi: f64154e0   edi: f5f01580   ebp: f6183fb4   esp: f6183f0c
ds: 007b   es: 007b   ss: 0068
Process aplay (pid: 3769, threadinfo=f6182000 task=f6199300)
Stack: f64154c0 f5f01580 40001004 00000001 00000001 40001004 f6199300 
40002000
        0000e000 00030002 c014df8f f64154c0 f5f015c0 f5f01580 f5f015a0 
f5f01598
        000800fb f5ac0d40 00000000 00000000 00000000 00000000 001000fb 
f7cd6800
Call Trace:
  [<c014df8f>] do_mmap_pgoff+0x35f/0x670
  [<c0112146>] sys_mmap2+0xc6/0xd0
  [<c011d6a0>] do_page_fault+0x0/0x53a
  [<c041f733>] error_code+0x2f/0x38

Code: 8a 8b 85 70 ff ff ff c7 04 24 14 7d 43 c0 05 02 03 00 00 89 44 24 
04 e8 4f 61 00 00 f6 45 0c 04 0f 84 85 fd ff ff e9 57 fe ff ff <0f> 0b 
65 01 2c 7d 43 c0 8b 55 08 f6 42 32 02 74 27 8b 8d 6c ff

bash-2.05b$
bash-2.05b$ dmesg
ting delay loop... 1888.25 BogoMIPS
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
checking if image is initramfs...it isn't (ungzip failed); looks like an 
initrd
Freeing initrd memory: 304k freed
CPU:     After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000
CPU:     After vendor identify, caps: 0383fbff c1c3fbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After all inits, caps: 0383fbff c1c3fbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm)  stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb420, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20031002
ACPI: IRQ 9 was Edge Triggered, setting to Level Triggerd
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [APC1] (IRQs *16)
ACPI: PCI Interrupt Link [APC2] (IRQs 17)
ACPI: PCI Interrupt Link [APC3] (IRQs *18)
ACPI: PCI Interrupt Link [APC4] (IRQs *19)
ACPI: PCI Interrupt Link [APCE] (IRQs 16)
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCS] (IRQs *23)
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22)
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ACPI: PCI Interrupt Link [LSMB] enabled at IRQ 10
ACPI: PCI Interrupt Link [LUBA] enabled at IRQ 11
ACPI: PCI Interrupt Link [LUBB] enabled at IRQ 5
ACPI: PCI Interrupt Link [LUB2] enabled at IRQ 10
ACPI: PCI Interrupt Link [LMAC] enabled at IRQ 10
ACPI: PCI Interrupt Link [LAPU] enabled at IRQ 10
ACPI: PCI Interrupt Link [LACI] enabled at IRQ 5
ACPI: PCI Interrupt Link [LFIR] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNK4] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNK3] enabled at IRQ 11
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 
'acpi=off'
vesafb: framebuffer at 0xc0000000, mapped to 0xf8808000, size 16384k
vesafb: mode is 1280x1024x16, linelength=2560, pages=1
vesafb: protected mode interface info at c000:ea60
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
fb0: VESA VGA frame buffer device
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.13 <tigran@veritas.com>
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
apm: overridden by ACPI.
highmem bounce pool size: 64 pages
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.5 [Flags: R/W].
udf: registering filesystem
SGI XFS for Linux with large block numbers, no debug enabled
ACPI: Power Button (FF) [PWRF]
ACPI: Fan [FAN] (on)
ACPI: Processor [CPU0] (supports C1)
ACPI: Thermal Zone [THRM] (40 C)
Console: switching to colour frame buffer device 160x64
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Using cfq io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.18.
PCI: Setting latency timer of device 0000:00:04.0 to 64
eth0: forcedeth.c: subsystem: 0147b:1c00
Linux video capture interface: v1.00
DriverInitialize MAC address = ff:ff:ff:ff:ff:ff:00:00
DriverInitialize key =
  ff ff ff ff
  ff ff ff ff
  ff ff ff ff
  ff ff ff ff
DVB: registering new adapter (Technisat SkyStar2 driver).
DVB: registering frontend 0:0 (Zarlink MT312)...
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE2: IDE controller at PCI slot 0000:00:09.0
NFORCE2: chipset revision 162
NFORCE2: not 100% native mode: will probe irqs later
NFORCE2: 0000:00:09.0 (rev a2) UDMA133 controller
     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: _NEC DV-5800A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: LITE-ON LTR-16102B, ATAPI CD/DVD-ROM drive
hdd: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
ide1 at 0x170-0x177,0x376 on irq 15
SiI3112 Serial ATA: IDE controller at PCI slot 0000:01:0b.0
SiI3112 Serial ATA: chipset revision 2
SiI3112 Serial ATA: 100% native mode on irq 11
     ide2: MMIO-DMA at 0xf9844000-0xf9844007, BIOS settings: hde:pio, 
hdf:pio
     ide3: MMIO-DMA at 0xf9844008-0xf984400f, BIOS settings: hdg:pio, 
hdh:pio
hde: SAMSUNG SP1614N, ATA DISK drive
ide2 at 0xf9844080-0xf9844087,0xf984408a on irq 11
hde: max request size: 7KiB
hde: 312581808 sectors (160041 MB) w/8192KiB Cache, CHS=19457/255/63, 
UDMA(100)
  /dev/ide/host2/bus0/target0/lun0: p1 p2 p3 < p5 p6 p7 p8 p9 >
hda: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
hdc: ATAPI 40X CD-ROM CD-R/RW drive, 2048kB Cache, DMA
ide-floppy driver 0.99.newide
hdd: No disk in drive
hdd: 98304kB, 32/64/96 CHS, 4096 kBps, 512 sector size, 2941 rpm
ohci1394: $Rev: 1045 $ Ben Collins <bcollins@debian.org>
PCI: Setting latency timer of device 0000:00:0d.0 to 64
ohci1394_0: OHCI-1394 1.1 (PCI): IRQ=[11]  MMIO=[cc084000-cc0847ff]  Max 
Packet=[2048]
ohci1394_0: SelfID received outside of bus reset sequence
video1394: Installed video1394 module
raw1394: /dev/raw1394 device initialized
Console: switching to colour frame buffer device 160x64
ehci_hcd 0000:00:02.2: EHCI Host Controller
PCI: Setting latency timer of device 0000:00:02.2 to 64
ehci_hcd 0000:00:02.2: irq 10, pci mem f984c000
ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 1
PCI: cache line size of 64 is not supported by device 0000:00:02.2
ehci_hcd 0000:00:02.2: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-13
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
ohci_hcd: 2003 Oct 13 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
ohci_hcd 0000:00:02.0: OHCI Host Controller
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: irq 11, pci mem f984e000
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
ohci_hcd 0000:00:02.1: OHCI Host Controller
PCI: Setting latency timer of device 0000:00:02.1 to 64
ohci_hcd 0000:00:02.1: irq 5, pci mem f9850000
ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 3 ports detected
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface 
driver v2.1
drivers/usb/core/usb.c: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
drivers/usb/core/usb.c: registered new driver usbscanner
drivers/usb/image/scanner.c: 0.4.15:USB Scanner Driver
mice: PS/2 mouse device common for all mice
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
I2O Core - (C) Copyright 1999 Red Hat Software
I2O: Event thread created as pid 16
i2o: Checking for PCI I2O controllers...
I2O configuration manager v 0.04.
   (C) Copyright 1999 Red Hat Software
i2c /dev entries driver
i2c_adapter i2c-0: nForce2 SMBus adapter at 0x5000
i2c_adapter i2c-1: nForce2 SMBus adapter at 0x5100
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[000000508df0fbe3]
Advanced Linux Sound Architecture Driver Version 0.9.7 (Thu Sep 25 
19:16:36 2003 UTC).
request_module: failed /sbin/modprobe -- snd-card-0. error = -16
PCI: Setting latency timer of device 0000:00:06.0 to 64
hub 2-0:1.0: new USB device on port 1, assigned address 2
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 2 if 0 
alt 1 proto 2 vid 0x03F0 pid 0x1004
intel8x0_measure_ac97_clock: measured 49854 usecs
intel8x0: clocking to 47386
ALSA device list:
   #0: NVidia nForce2 at 0xcc081000, irq 5
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S3 S4 S5)
UDF-fs DEBUG fs/udf/lowlevel.c:65:udf_get_last_session: 
CDROMMULTISESSION not supported: rc=-22
UDF-fs DEBUG fs/udf/super.c:1544:udf_fill_super: Multi-session=0
UDF-fs DEBUG fs/udf/super.c:532:udf_vrs: Starting at sector 16 (2048 
byte sectors)
UDF-fs: No VRS found
XFS mounting filesystem hde6
Ending clean XFS mount for filesystem: hde6
VFS: Mounted root (xfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 160k freed
NTFS volume version 3.1.
NTFS volume version 3.1.
nvidia: no version magic, tainting kernel.
nvidia: module license 'NVIDIA' taints kernel.

Prakash


