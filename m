Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751238AbVLLMTW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbVLLMTW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 07:19:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbVLLMTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 07:19:21 -0500
Received: from mail.gmx.de ([213.165.64.21]:43146 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751238AbVLLMTV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 07:19:21 -0500
X-Authenticated: #23671415
Message-ID: <439D6AD5.3080704@gmx.de>
Date: Mon, 12 Dec 2005 13:19:33 +0100
From: Jan Altenberg <jan.altenberg@gmx.de>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.15-rc5: irq 9: nobody cared
X-Enigmail-Version: 0.92.0.0
Content-Type: multipart/mixed;
 boundary="------------050804090205090008080607"
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050804090205090008080607
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

on one of my test machines I recognized the following bootup messages
with kernel 2.6.15-rc5. Booting with "irqpoll" doesn't help.
I also tried 2.6.14 with the same result.


ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: debug port 1
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
irq 9: nobody cared (try booting with the "irqpoll" option)
 [<c013934a>] __report_bad_irq+0x2a/0xa0
 [<c0138ba0>] handle_IRQ_event+0x30/0x70
 [<c0139460>] note_interrupt+0x80/0xf0
 [<c0138cb8>] __do_IRQ+0xd8/0xf0
 [<c0104fd9>] do_IRQ+0x19/0x30
 [<c01037c2>] common_interrupt+0x1a/0x20
 [<c011c31e>] __do_softirq+0x2e/0x90
 [<c011c3a6>] do_softirq+0x26/0x30
 [<c011c475>] irq_exit+0x35/0x40
 [<c0104fde>] do_IRQ+0x1e/0x30
 [<c01037c2>] common_interrupt+0x1a/0x20
 [<c029007b>] as_can_break_anticipation+0x6b/0x180
 [<c0138fa2>] setup_irq+0xc2/0x140
 [<c0366cf0>] usb_hcd_irq+0x0/0x70
 [<c01391b5>] request_irq+0x85/0xa0
 [<c0367229>] usb_add_hcd+0x319/0x3f0
 [<c0366cf0>] usb_hcd_irq+0x0/0x70
 [<c02a7906>] pci_set_master+0x46/0x80
 [<c036fb7b>] usb_hcd_pci_probe+0x24b/0x3f0
 [<c02a9479>] pci_call_probe+0x19/0x20
 [<c02a94e5>] __pci_device_probe+0x65/0x80
 [<c02a952f>] pci_device_probe+0x2f/0x50
 [<c02fd488>] driver_probe_device+0x38/0xb0
 [<c02fd580>] __driver_attach+0x0/0x50
 [<c02fd5c7>] __driver_attach+0x47/0x50
 [<c02fc9d9>] bus_for_each_dev+0x69/0x80
 [<c02fd5f5>] driver_attach+0x25/0x30
 [<c02fd580>] __driver_attach+0x0/0x50
 [<c02fcf2d>] bus_add_driver+0x8d/0xe0
 [<c02fda60>] driver_register+0x40/0x50
 [<c02fda00>] klist_devices_get+0x0/0x10
 [<c02fda10>] klist_devices_put+0x0/0x10
 [<c011d92e>] register_proc_table+0xbe/0x130
 [<c02a97f1>] __pci_register_driver+0x71/0xb0
 [<c0117927>] printk+0x17/0x20
 [<c0545dec>] ehci_hcd_pci_init+0x5c/0x70
 [<c052690b>] do_initcalls+0x2b/0xc0
 [<c01002b0>] init+0x0/0x170
 [<c01002b0>] init+0x0/0x170
 [<c01002ec>] init+0x3c/0x170
 [<c0101039>] kernel_thread_helper+0x5/0xc
handlers:
[<c0366cf0>] (usb_hcd_irq+0x0/0x70)
Disabling IRQ #9
ehci_hcd 0000:00:1d.7: irq 9, io mem 0xc0080000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004



Any hints?

Thanks,
JAN



--------------050804090205090008080607
Content-Type: text/plain;
 name="bootlog"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bootlog"

Linux version 2.6.15-rc5pm (root@wom1) (gcc-Version 3.3.5 (Debian 1:3.3.5-8ubuntu2)) #2 PREEMPT Mon Dec 12 13:55:31 CET 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e000 (usable)
 BIOS-e820: 000000000009e000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001f7fa400 (usable)
 BIOS-e820: 000000001f7fa400 - 000000001f7ffc00 (ACPI data)
 BIOS-e820: 000000001f7ffc00 - 000000001f800000 (ACPI NVS)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
503MB LOWMEM available.
DMI not present.
Allocating PCI resources starting at 20000000 (gap: 1f800000:e0700000)
Built 1 zonelists
Kernel command line: root=/dev/hdc2 ro console=ttyS1,9600 console=tty0
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 1495.400 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 506292k/516072k available (3237k kernel code, 9264k reserved, 1000k data, 296k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 2994.01 BogoMIPS (lpj=5988030)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Capability LSM initialized
Mount-cache hash table entries: 512
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 1024K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
mtrr: v2.0 (20020519)
CPU: Intel(R) Celeron(R) M processor         1.50GHz stepping 08
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
NET: Registered protocol family 16
EISA bus registered
PCI: PCI BIOS revision 2.10 entry at 0xff6b1, last bus=2
PCI: Using configuration type 1
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fdfb0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xdfa7, dseg 0x94000
PNPBIOS fault.. attempting recovery.
PnPBIOS: Warning! Your PnP BIOS caused a fatal error. Attempting to continue
PnPBIOS: You may need to reboot with the "pnpbios=off" option to operate stably
PnPBIOS: Check with your vendor for an updated BIOS
PnPBIOS: dev_node_info: unexpected status 0x2b
PnPBIOS: Unable to get node info.  Aborting.
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Probing PCI hardware
PCI quirk: region 1000-107f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 0500-053f claimed by ICH4 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
  IO window: b000-cfff
  MEM window: c0100000-c04fffff
  PREFETCH window: 98000000-981fffff
audit: initializing netlink socket (disabled)
audit(1134392381.852:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
NTFS driver 2.1.25 [Flags: R/W].
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 855 Chipset.
agpgart: Detected 8060K stolen memory.
agpgart: AGP aperture is 128M @ 0x90000000
intelfb: Framebuffer driver for Intel(R) 830M/845G/852GM/855GM/865G/915G/915GM chipsets
intelfb: Version 0.9.2
intelfb: 00:02.0: Intel(R) 855GME, aperture size 128MB, stolen memory 8060kB
mtrr: type mismatch for 90000000,8000000 old: uncachable new: write-combining
intelfb: Mode is interlaced.
intelfb: Initial video mode is 1024x768-32@70.
Console: switching to colour frame buffer device 128x48
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
parkbd: no such parport
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
floppy0: no floppy controllers found
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
xd: Out of memory.
Intel(R) PRO/1000 Network Driver - version 6.1.16-k2
Copyright (c) 1999-2005 Intel Corporation.
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic channels, max=256) (6 bit encapsulation enabled).
CSLIP: code copyright 1989 Regents of the University of California.
SLIP linefill/keepalive option.
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
ICH4: chipset revision 2
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xdc00-0xdc07, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xdc08-0xdc0f, BIOS settings: hdc:pio, hdd:pio
hdc: IBM-DTTA-351010, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
hdc: max request size: 128KiB
hdc: 19807200 sectors (10141 MB) w/466KiB Cache, CHS=19650/16/63
hdc: cache flushes not supported
 hdc: hdc1 hdc2
ide-floppy driver 0.99.newide
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: debug port 1
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
irq 9: nobody cared (try booting with the "irqpoll" option)
 [<c013934a>] __report_bad_irq+0x2a/0xa0
 [<c0138ba0>] handle_IRQ_event+0x30/0x70
 [<c0139460>] note_interrupt+0x80/0xf0
 [<c0138cb8>] __do_IRQ+0xd8/0xf0
 [<c0104fd9>] do_IRQ+0x19/0x30
 [<c01037c2>] common_interrupt+0x1a/0x20
 [<c011c31e>] __do_softirq+0x2e/0x90
 [<c011c3a6>] do_softirq+0x26/0x30
 [<c011c475>] irq_exit+0x35/0x40
 [<c0104fde>] do_IRQ+0x1e/0x30
 [<c01037c2>] common_interrupt+0x1a/0x20
 [<c029007b>] as_can_break_anticipation+0x6b/0x180
 [<c0138fa2>] setup_irq+0xc2/0x140
 [<c0366cf0>] usb_hcd_irq+0x0/0x70
 [<c01391b5>] request_irq+0x85/0xa0
 [<c0367229>] usb_add_hcd+0x319/0x3f0
 [<c0366cf0>] usb_hcd_irq+0x0/0x70
 [<c02a7906>] pci_set_master+0x46/0x80
 [<c036fb7b>] usb_hcd_pci_probe+0x24b/0x3f0
 [<c02a9479>] pci_call_probe+0x19/0x20
 [<c02a94e5>] __pci_device_probe+0x65/0x80
 [<c02a952f>] pci_device_probe+0x2f/0x50
 [<c02fd488>] driver_probe_device+0x38/0xb0
 [<c02fd580>] __driver_attach+0x0/0x50
 [<c02fd5c7>] __driver_attach+0x47/0x50
 [<c02fc9d9>] bus_for_each_dev+0x69/0x80
 [<c02fd5f5>] driver_attach+0x25/0x30
 [<c02fd580>] __driver_attach+0x0/0x50
 [<c02fcf2d>] bus_add_driver+0x8d/0xe0
 [<c02fda60>] driver_register+0x40/0x50
 [<c02fda00>] klist_devices_get+0x0/0x10
 [<c02fda10>] klist_devices_put+0x0/0x10
 [<c011d92e>] register_proc_table+0xbe/0x130
 [<c02a97f1>] __pci_register_driver+0x71/0xb0
 [<c0117927>] printk+0x17/0x20
 [<c0545dec>] ehci_hcd_pci_init+0x5c/0x70
 [<c052690b>] do_initcalls+0x2b/0xc0
 [<c01002b0>] init+0x0/0x170
 [<c01002b0>] init+0x0/0x170
 [<c01002ec>] init+0x3c/0x170
 [<c0101039>] kernel_thread_helper+0x5/0xc
handlers:
[<c0366cf0>] (usb_hcd_irq+0x0/0x70)
Disabling IRQ #9
ehci_hcd 0000:00:1d.7: irq 9, io mem 0xc0080000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: Product: EHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.15-rc5pm ehci_hcd
usb usb1: SerialNumber: 0000:00:1d.7
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
USB Universal Host Controller Interface driver v2.3
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: detected 2 ports
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 11, io base 0x0000f400
usb usb2: Product: UHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.15-rc5pm uhci_hcd
usb usb2: SerialNumber: 0000:00:1d.0
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: detected 2 ports
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 10, io base 0x0000f000
usb usb3: Product: UHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.15-rc5pm uhci_hcd
usb usb3: SerialNumber: 0000:00:1d.1
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
mice: PS/2 mouse device common for all mice
ts: Compaq touchscreen protocol output
EISA: Probing bus 0 at eisa.0
Cannot allocate resource for EISA slot 1
EISA: Detected 0 cards.
NET: Registered protocol family 2
input: AT Translated Set 2 keyboard as /class/input/input0
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 4, 65536 bytes)
TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
TCP reno registered
IPv4 over IPv4 tunneling driver
ip_conntrack version 2.4 (4031 buckets, 32248 max) - 192 bytes per conntrack
arp_tables: (C) 2002 David S. Miller
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
Bridge firewalling registered
Using IPI Shortcut mode
ReiserFS: hdc2: found reiserfs format "3.6" with standard journal
ReiserFS: hdc2: using ordered data mode
ReiserFS: hdc2: journal params: device hdc2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hdc2: checking transaction log (hdc2)
ReiserFS: hdc2: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 296k freed
Adding 1012052k swap on /dev/hdc1.  Priority:-1 extents:1 across:1012052k


--------------050804090205090008080607
Content-Type: text/plain;
 name="config"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="config"

grep "=[y|m]" .config

CONFIG_X86_32=y
CONFIG_SEMAPHORE_SLEEPERS=y
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_EXPERIMENTAL=y
CONFIG_BROKEN=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_LOCK_KERNEL=y
CONFIG_LOCALVERSION_AUTO=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_AUDIT=y
CONFIG_AUDITSYSCALL=y
CONFIG_HOTPLUG=y
CONFIG_KOBJECT_UEVENT=y
CONFIG_KALLSYMS=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_KMOD=y
CONFIG_LBD=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
CONFIG_DEFAULT_AS=y
CONFIG_X86_PC=y
CONFIG_MPENTIUMM=y
CONFIG_X86_GENERIC=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_PREEMPT=y
CONFIG_PREEMPT_BKL=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_MCE=y
CONFIG_HIGHMEM4G=y
CONFIG_HIGHMEM=y
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_MTRR=y
CONFIG_SECCOMP=y
CONFIG_HZ_250=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_LEGACY_PROC=y
CONFIG_ISA_DMA_API=y
CONFIG_ISA=y
CONFIG_EISA=y
CONFIG_EISA_VLB_PRIMING=y
CONFIG_EISA_PCI_EISA=y
CONFIG_EISA_VIRTUAL_ROOT=y
CONFIG_EISA_NAMES=y
CONFIG_HOTPLUG_PCI=y
CONFIG_BINFMT_ELF=y
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=y
CONFIG_XFRM=y
CONFIG_NET_KEY=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_ASK_IP_FIB_HASH=y
CONFIG_IP_FIB_HASH=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_FWMARK=y
CONFIG_NET_IPIP=y
CONFIG_SYN_COOKIES=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
CONFIG_TCP_CONG_BIC=y
CONFIG_NETFILTER=y
CONFIG_BRIDGE_NETFILTER=y
CONFIG_IP_NF_CONNTRACK=y
CONFIG_IP_NF_CT_ACCT=y
CONFIG_IP_NF_CONNTRACK_MARK=y
CONFIG_IP_NF_CT_PROTO_SCTP=y
CONFIG_IP_NF_FTP=y
CONFIG_IP_NF_IRC=y
CONFIG_IP_NF_TFTP=y
CONFIG_IP_NF_AMANDA=y
CONFIG_IP_NF_ARPTABLES=y
CONFIG_IP_NF_ARPFILTER=y
CONFIG_IP_NF_ARP_MANGLE=y
CONFIG_BRIDGE=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_SERIAL=y
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
CONFIG_PNP=y
CONFIG_ISAPNP=y
CONFIG_PNPBIOS=y
CONFIG_PNPBIOS_PROC_FS=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_XD=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_CRYPTOLOOP=y
CONFIG_BLK_DEV_SX8=y
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDEFLOPPY=y
CONFIG_IDE_TASK_IOCTL=y
CONFIG_IDE_GENERIC=y
CONFIG_BLK_DEV_IDEPNP=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_IVB=y
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y
CONFIG_BLK_DEV_SD=y
CONFIG_BLK_DEV_SR=y
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=y
CONFIG_SCSI_SPI_ATTRS=y
CONFIG_SCSI_FC_ATTRS=y
CONFIG_SCSI_ISCSI_ATTRS=y
CONFIG_SCSI_QLA2XXX=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=y
CONFIG_TUN=y
CONFIG_E1000=y
CONFIG_FDDI=y
CONFIG_HIPPI=y
CONFIG_SLIP=y
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
CONFIG_SLIP_MODE_SLIP6=y
CONFIG_NET_FC=y
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_TSDEV=y
CONFIG_INPUT_EVDEV=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_CT82C710=y
CONFIG_SERIO_PARKBD=y
CONFIG_SERIO_PCIPS2=y
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
CONFIG_GAMEPORT=y
CONFIG_GAMEPORT_NS558=y
CONFIG_GAMEPORT_L4=y
CONFIG_GAMEPORT_EMU10K1=y
CONFIG_GAMEPORT_FM801=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_NONSTANDARD=y
CONFIG_STALDRV=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_PRINTER=y
CONFIG_LP_CONSOLE=y
CONFIG_RTC=y
CONFIG_AGP=y
CONFIG_AGP_INTEL=y
CONFIG_I2C=y
CONFIG_I2C_ALGOBIT=y
CONFIG_FB=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB_INTEL=y
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB=y
CONFIG_USB_DEBUG=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_UHCI_HCD=y
CONFIG_USB_STORAGE=y
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
CONFIG_JBD=y
CONFIG_JBD_DEBUG=y
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
CONFIG_FS_POSIX_ACL=y
CONFIG_ROMFS_FS=y
CONFIG_INOTIFY=y
CONFIG_QUOTA=y
CONFIG_QUOTACTL=y
CONFIG_DNOTIFY=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=y
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_NTFS_FS=y
CONFIG_NTFS_RW=y
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_RAMFS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFS_V4=y
CONFIG_NFS_DIRECTIO=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=y
CONFIG_RPCSEC_GSS_KRB5=y
CONFIG_PARTITION_ADVANCED=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
CONFIG_LDM_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_ISO8859_1=y
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_INFO=y
CONFIG_EARLY_PRINTK=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
CONFIG_SECURITY=y
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_CAPABILITIES=y
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_DISABLE=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRC_CCITT=y
CONFIG_CRC32=y
CONFIG_LIBCRC32C=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_X86_BIOS_REBOOT=y


--------------050804090205090008080607
Content-Type: text/plain;
 name="lspci"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci"

jan@wom1:~$ lspci -vv
0000:00:00.0 Host bridge: Intel Corp. 82852/855GM Host Bridge (rev 02)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at 80000000 (32-bit, prefetchable) [size=256M]
        Capabilities: <available only to root>

0000:00:00.1 System peripheral: Intel Corp. 855GM/GME GMCH Memory I/O Control Registers (rev 02)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

0000:00:00.3 System peripheral: Intel Corp. 855GM/GME GMCH Configuration Process Registers (rev 02)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

0000:00:01.0 PCI bridge: Intel Corp. 855GME GMCH Host-to-AGP Bridge (Virtual PCI-to-PCI) (rev 02) (prog-if 00 [Normal decode])
        Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-

0000:00:02.0 VGA compatible controller: Intel Corp. 82852/855GM Integrated Graphics Device (rev 02) (prog-if 00 [VGA])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at 90000000 (32-bit, prefetchable) [size=128M]
        Region 1: Memory at c0000000 (32-bit, non-prefetchable) [size=512K]
        Region 2: I/O ports at f800 [size=8]
        Capabilities: <available only to root>

0000:00:1d.0 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 11
        Region 4: I/O ports at f400 [size=32]

0000:00:1d.1 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Intel Corp.: Unknown device 24c2
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 10
        Region 4: I/O ports at f000 [size=32]

0000:00:1d.7 USB Controller: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB 2.0 EHCI Controller (rev 02) (prog-if 20 [EHCI])
        Subsystem: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB 2.0 EHCI Controller
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin D routed to IRQ 9
        Region 0: Memory at c0080000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: <available only to root>

0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 82) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR+
        Latency: 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
        I/O behind bridge: 0000b000-0000cfff
        Memory behind bridge: c0100000-c04fffff
        Prefetchable memory behind bridge: 98000000-981fffff
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-

0000:00:1f.0 ISA bridge: Intel Corp. 82801DB/DBL (ICH4/ICH4-L) LPC Bridge (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

0000:00:1f.1 IDE interface: Intel Corp. 82801DB/DBL (ICH4/ICH4-L) UltraATA-100 IDE Controller (rev 02) (prog-if 8a [Master SecP PriP])
        Subsystem: Intel Corp.: Unknown device 24c2
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 7
        Region 0: I/O ports at <ignored>
        Region 1: I/O ports at <ignored>
        Region 2: I/O ports at <ignored>
        Region 3: I/O ports at <ignored>
        Region 4: I/O ports at dc00 [size=16]
        Region 5: Memory at c0080400 (32-bit, non-prefetchable) [size=1K]

0000:00:1f.3 SMBus: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) SMBus Controller (rev 02)
        Subsystem: Intel Corp.: Unknown device 24c2
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 5
        Region 4: I/O ports at d800 [size=32]

0000:02:00.0 Ethernet controller: Intel Corp. 82541GI/PI Gigabit Ethernet Controller (rev 05)
        Subsystem: Intel Corp. PRO/1000 MT Network Connection
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (63750ns min), Cache Line Size: 0x10 (64 bytes)
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at c0100000 (32-bit, non-prefetchable) [size=128K]
        Region 1: Memory at c0120000 (32-bit, non-prefetchable) [size=64K]
        Region 2: I/O ports at cc00 [size=64]
        Expansion ROM at ff000000 [disabled] [size=64K]
        Capabilities: <available only to root>

0000:02:01.0 Ethernet controller: Intel Corp. 82541GI/PI Gigabit Ethernet Controller (rev 05)
        Subsystem: Intel Corp. PRO/1000 MT Network Connection
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (63750ns min), Cache Line Size: 0x10 (64 bytes)
        Interrupt: pin A routed to IRQ 7
        Region 0: Memory at c0140000 (32-bit, non-prefetchable) [size=128K]
        Region 1: Memory at c0160000 (32-bit, non-prefetchable) [size=64K]
        Region 2: I/O ports at c800 [size=64]
        Expansion ROM at 98000000 [disabled] [size=64K]
        Capabilities: <available only to root>

0000:02:02.0 Memory controller: Eltec Elektronik GmbH: Unknown device 000a
        Subsystem: Eltec Elektronik GmbH: Unknown device 000a
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 0: Memory at 98080000 (32-bit, prefetchable) [size=512K]

0000:02:04.0 DMA controller: PLX Technology, Inc. PCI <-> IOBus Bridge (rev 02) (prog-if 00 [8237])
        Subsystem: Unknown device 0010:c230
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at c0170000 (32-bit, non-prefetchable) [size=128]
        Region 1: I/O ports at c400 [size=128]
        Region 2: Memory at c0200000 (32-bit, non-prefetchable) [size=1M]
        Region 3: I/O ports at c000 [size=16]
        Region 4: Memory at c0300000 (32-bit, non-prefetchable) [size=1M]
        Region 5: Memory at c0400000 (32-bit, non-prefetchable) [size=64K]

0000:02:05.0 Network controller: PLX Technology, Inc. PCI <-> IOBus Bridge (rev 02)
        Subsystem: PEP MODULAR Computers GmbH: Unknown device 0080
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 7
        Region 0: Memory at c0410000 (32-bit, non-prefetchable) [size=128]
        Region 1: I/O ports at bc00 [size=128]
        Region 2: Memory at c0410400 (32-bit, non-prefetchable) [size=1K]
        Region 3: Memory at c0414000 (32-bit, non-prefetchable) [size=16K]
        Expansion ROM at 98010000 [disabled] [size=2K]


--------------050804090205090008080607--
