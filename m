Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263452AbTE0MiN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 08:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263458AbTE0MiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 08:38:13 -0400
Received: from smtp-out.comcast.net ([24.153.64.115]:64365 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S263452AbTE0MhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 08:37:00 -0400
Date: Tue, 27 May 2003 08:49:52 -0400
From: John M Flinchbaugh <glynis@butterfly.hjsoft.com>
Subject: [2.5.70] oops when rmmod yenta_socket
To: linux-kernel@vger.kernel.org
Message-id: <20030527124952.GB13051@butterfly.hjsoft.com>
MIME-version: 1.0
Content-type: multipart/signed; boundary=z6Eq5LdranGa6ru8;
 protocol="application/pgp-signature"; micalg=pgp-sha1
Content-disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--z6Eq5LdranGa6ru8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

with 2.5.69-70 my pcmcia nics (orinoco_cs and 3c574/8250_cs) don't
seem to like to initial correctly the first time when they boot.  if i=20
wait and insert them after boot, they're fine.  if they're in during=20
boot, cardmgr tries to load memory_cs for them instead of the correct=20
module.  i just sort of figured this is a module dependency issue, so i=20
was trying to debug it.

i shutdown pcmcia and tried to rmmod yenta_socket, and i got the oops
below at the end of this dmesg.  so far, 2.5.70 has looked alot like
2.5.69-bk11 that i'd been running before.

thanks.

gcc:
---
john@density:~$ gcc --version
gcc.real (GCC) 3.3 (Debian)
Copyright (C) 2003 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There
is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR
PURPOSE.
---

dmesg:
---
Linux version 2.5.70 (root@butterfly) (gcc version 3.3 (Debian)) #1 Tue=20
May 27 00:30:44 EDT 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000017fdb000 (usable)
 BIOS-e820: 0000000017fdb000 - 0000000018000000 (reserved)
 BIOS-e820: 00000000ffe00000 - 0000000100000000 (reserved)
383MB LOWMEM available.
On node 0 totalpages: 98267
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 94171 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
Building zonelist for node : 0
Kernel command line: auto BOOT_IMAGE=3DLinux root=3D304 resume=3D/dev/hda5=
=20
acpi=3Doff
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 597.497 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1179.64 BogoMIPS
Memory: 385544k/393068k available (1735k kernel code, 6784k reserved,=20
695k data, 128k init, 0k highmem)
Security Scaffold v1.0.0 initialized
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium III (Coppermine) stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v2.0 (20020519)
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfc0ae, last bus=3D1
PCI: Using configuration type 1
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030522
ACPI: Disabled via command line (acpi=3Doff)
Linux Plug and Play Support v0.96 (c) Adam Belay
pnp: the driver 'system' has been registered
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fe2d0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xe2f4, dseg 0x40
pnp: match found with the PnP device '00:01' and the driver 'system'
pnp: match found with the PnP device '00:02' and the driver 'system'
PnPBIOS: 16 nodes reported by PnP BIOS; 16 recorded by driver
block request queues:
 4/128 requests per read queue
 4/128 requests per write queue
 enter congestion at 15
 exit congestion at 17
ACPI: ACPI tables contain no PCI IRQ routing entries
PCI: Invalid ACPI-PCI IRQ routing table
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
Machine check exception polling timer started.
Enabling SEP on CPU 0
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Capability LSM initialized
Initializing Cryptographic API
Limiting direct PCI/PCI transfers.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
pty: 256 Unix98 ptys configured
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with=20
idebus=3Dxx
PIIX4: IDE controller at PCI slot 00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x0860-0x0867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x0868-0x086f, BIOS settings: hdc:DMA, hdd:pio
hda: IBM-DARA-212000, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: TOSHIBA DVD-ROM SD-C2402, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
pnp: the driver 'ide' has been registered
hda: max request size: 128KiB
hda: host protected area =3D> 1
hda: 23579136 sectors (12073 MB) w/418KiB Cache, CHS=3D23392/16/63,=20
UDMA(33)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 > p3 p4
input: PS/2 Generic Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Resume Machine: resuming from /dev/hda5
Resuming from device hda5
Resume Machine: This is normal swap space
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hda4, size 8192, journal first block=20
18, max trans len 1024, max batch 900, max commit age 30, max trans age=20
30
reiserfs: checking transaction log (hda4) for (hda4)
Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 128k freed
Adding 377488k swap on /dev/discs/disc0/part5.  Priority:-1 extents:1
Removing [24669 18012 0x0 SD]..done
Removing [24669 14123 0x0 SD]..done
There were 2 uncompleted unlinks/truncates. Completed
Real Time Clock Driver v1.11
i8k: unable to get SMM BIOS version
Dell laptop SMM driver v1.13 14/05/2002 Massimo Dal Zotto=20
(dz@debian.org)
mice: PS/2 mouse device common for all mice
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hda6, size 8192, journal first block=20
18, max trans len 1024, max batch 900, max commit age 30, max trans age=20
30
reiserfs: checking transaction log (hda6) for (hda6)
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hda7, size 8192, journal first block=20
18, max trans len 1024, max batch 900, max commit age 30, max trans age=20
30
reiserfs: checking transaction log (hda7) for (hda7)
Using r5 hash to sort names
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface=20
driver v2.1
PCI: Found IRQ 11 for device 00:07.2
PCI: Sharing IRQ 11 with 00:03.0
PCI: Sharing IRQ 11 with 00:03.1
uhci-hcd 00:07.2: Intel Corp. 82371AB/EB/MB PIIX4=20
uhci-hcd 00:07.2: irq 11, io base 0000dce0
Please use the 'usbfs' filetype instead, the 'usbdevfs' name is=20
deprecated.
uhci-hcd 00:07.2: new USB bus registered, assigned bus number 1
drivers/usb/host/uhci-hcd.c: detected 2 ports
uhci-hcd 00:07.2: root hub device address 1
usb usb1: new device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
usb usb1: Product: Intel Corp. 82371AB/EB/MB PIIX4=20
usb usb1: Manufacturer: Linux 2.5.70 uhci-hcd
usb usb1: SerialNumber: 00:07.2
drivers/usb/core/usb.c: usb_hotplug
usb usb1: usb_new_device - registering interface 1-0:0
drivers/usb/core/usb.c: usb_hotplug
hub 1-0:0: usb_device_probe
hub 1-0:0: usb_device_probe - got id
hub 1-0:0: USB hub found
hub 1-0:0: 2 ports detected
hub 1-0:0: standalone hub
hub 1-0:0: ganged power switching
hub 1-0:0: global over-current protection
hub 1-0:0: Port indicators are not supported
hub 1-0:0: power on to power good time: 2ms
hub 1-0:0: hub controller current requirement: 0mA
hub 1-0:0: local power source is good
hub 1-0:0: no over-current condition exists
hub 1-0:0: enabling power on all ports
drivers/usb/host/uhci-hcd.c: dce0: suspend_hc
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
Intel PCIC probe: PNP invalid resources ?
pnp: res: the device '00:0b' has been disabled.
not found.
PCI: Found IRQ 11 for device 00:03.0
PCI: Sharing IRQ 11 with 00:03.1
PCI: Sharing IRQ 11 with 00:07.2
Yenta IRQ list 0698, PCI irq11
Socket status: 30000010
PCI: Found IRQ 11 for device 00:03.1
PCI: Sharing IRQ 11 with 00:03.0
PCI: Sharing IRQ 11 with 00:07.2
Yenta IRQ list 0698, PCI irq11
Socket status: 30000006
cs: warning: no high memory space available!
cs: unable to map card memory!
cs: unable to map card memory!
cs: unable to map card memory!
cs: unable to map card memory!
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: excluding 0x800-0x84f
cs: IO port probe 0x0100-0x04ff: excluding 0x280-0x287 0x2f8-0x2ff=20
0x378-0x37f 0x3c0-0x3df 0x3f8-0x3ff 0x4d0-0x4d7
PCI: Found IRQ 5 for device 00:08.0
IPv6 v0.8 for NET4.0
Disabled Privacy Extensions on device c0333ba0(lo)
IPv6 over IPv4 tunneling driver
Unable to handle kernel paging request at virtual address d8a5981e
 printing eip:
d8a5f1b2
*pde =3D 17d89067
*pte =3D 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<d8a5f1b2>]    Not tainted
EFLAGS: 00010246
EIP is at yenta_config_init+0x172/0x1a0 [yenta_socket]
eax: d8a59000   ebx: d7dae400   ecx: 8000183c   edx: 00000cfe
esi: d8a61160   edi: 00000000   ebp: d658df38   esp: d658df1c
ds: 007b   es: 007b   ss: 0068
Process pccardd (pid: 378, threadinfo=3Dd658c000 task=3Dd65b0ce0)
Stack: d7fc8f20 00000018 0000003e 00000500 05c0b160 d8a61160 d697b550=20
d658df48=20
       d8a5f1f4 d8a61160 d8a61160 d658df58 d8a5f664 d8a61160 d697b400=20
d658df64=20
       d8a5e036 d8a61160 d658df70 d8aa9a2c 00000000 d658df88 d8aa9e77=20
d697b400=20
Call Trace:
 [<d8a61160>] +0x0/0x860 [yenta_socket]
 [<d8a5f1f4>] yenta_init+0x14/0x30 [yenta_socket]
 [<d8a61160>] +0x0/0x860 [yenta_socket]
 [<d8a61160>] +0x0/0x860 [yenta_socket]
 [<d8a5f664>] ti_init+0x14/0x30 [yenta_socket]
 [<d8a61160>] +0x0/0x860 [yenta_socket]
 [<d8a5e036>] +0x36/0x40 [yenta_socket]
 [<d8a61160>] +0x0/0x860 [yenta_socket]
 [<d8aa9a2c>] init_socket+0x2c/0x30 [pcmcia_core]
 [<d8aa9e77>] shutdown_socket+0x17/0x100 [pcmcia_core]
 [<d8aaa0bb>] socket_shutdown+0x4b/0x60 [pcmcia_core]
 [<d8aaa6bc>] pccardd+0x1fc/0x220 [pcmcia_core]
 [<c0116b20>] default_wake_function+0x0/0x30
 [<c0109282>] ret_from_fork+0x6/0x14
 [<c0116b20>] default_wake_function+0x0/0x30
 [<d8aaa4c0>] pccardd+0x0/0x220 [pcmcia_core]
 [<c010740d>] kernel_thread_helper+0x5/0x18

Code: c6 80 1e 08 00 00 00 8b 46 0c c6 80 16 08 00 00 00 8b 46 0c=20
---

=2Econfig:
---
#
# Automatically generated make config: don't edit
#
CONFIG_X86=3Dy
CONFIG_MMU=3Dy
CONFIG_UID16=3Dy
CONFIG_GENERIC_ISA_DMA=3Dy

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=3Dy

#
# General setup
#
CONFIG_SWAP=3Dy
CONFIG_SYSVIPC=3Dy
CONFIG_BSD_PROCESS_ACCT=3Dy
CONFIG_SYSCTL=3Dy
CONFIG_LOG_BUF_SHIFT=3D17
# CONFIG_EMBEDDED is not set
CONFIG_FUTEX=3Dy
CONFIG_EPOLL=3Dy

#
# Loadable module support
#
CONFIG_MODULES=3Dy
CONFIG_MODULE_UNLOAD=3Dy
CONFIG_MODULE_FORCE_UNLOAD=3Dy
CONFIG_OBSOLETE_MODPARM=3Dy
# CONFIG_MODVERSIONS is not set
CONFIG_KMOD=3Dy

#
# Processor type and features
#
CONFIG_X86_PC=3Dy
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
CONFIG_MPENTIUMIII=3Dy
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=3Dy
CONFIG_X86_XADD=3Dy
CONFIG_X86_L1_CACHE_SHIFT=3D5
CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy
CONFIG_X86_WP_WORKS_OK=3Dy
CONFIG_X86_INVLPG=3Dy
CONFIG_X86_BSWAP=3Dy
CONFIG_X86_POPAD_OK=3Dy
CONFIG_X86_GOOD_APIC=3Dy
CONFIG_X86_INTEL_USERCOPY=3Dy
CONFIG_X86_USE_PPRO_CHECKSUM=3Dy
CONFIG_HUGETLB_PAGE=3Dy
# CONFIG_SMP is not set
CONFIG_PREEMPT=3Dy
# CONFIG_X86_UP_APIC is not set
CONFIG_X86_TSC=3Dy
CONFIG_X86_MCE=3Dy
CONFIG_X86_MCE_NONFATAL=3Dy
# CONFIG_TOSHIBA is not set
CONFIG_I8K=3Dm
CONFIG_MICROCODE=3Dm
CONFIG_X86_MSR=3Dm
CONFIG_X86_CPUID=3Dm
# CONFIG_EDD is not set
CONFIG_NOHIGHMEM=3Dy
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=3Dy
CONFIG_HAVE_DEC_LOCK=3Dy

#
# Power management options (ACPI, APM)
#
CONFIG_PM=3Dy
CONFIG_SOFTWARE_SUSPEND=3Dy

#
# ACPI Support
#
CONFIG_ACPI=3Dy
CONFIG_ACPI_BOOT=3Dy
# CONFIG_ACPI_SLEEP is not set
CONFIG_ACPI_AC=3Dm
CONFIG_ACPI_BATTERY=3Dm
CONFIG_ACPI_BUTTON=3Dm
CONFIG_ACPI_FAN=3Dm
CONFIG_ACPI_PROCESSOR=3Dm
CONFIG_ACPI_THERMAL=3Dm
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_ACPI_DEBUG=3Dy
CONFIG_ACPI_BUS=3Dy
CONFIG_ACPI_INTERPRETER=3Dy
CONFIG_ACPI_EC=3Dy
CONFIG_ACPI_POWER=3Dy
CONFIG_ACPI_PCI=3Dy
CONFIG_ACPI_SYSTEM=3Dy
CONFIG_APM=3Dm
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
CONFIG_APM_DO_ENABLE=3Dy
CONFIG_APM_CPU_IDLE=3Dy
CONFIG_APM_DISPLAY_BLANK=3Dy
CONFIG_APM_RTC_IS_GMT=3Dy
# CONFIG_APM_ALLOW_INTS is not set
CONFIG_APM_REAL_MODE_POWER_OFF=3Dy

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=3Dy
# CONFIG_CPU_FREQ_PROC_INTF is not set
CONFIG_CPU_FREQ_GOV_USERSPACE=3Dm
CONFIG_CPU_FREQ_24_API=3Dy
CONFIG_CPU_FREQ_TABLE=3Dy

#
# CPUFreq processor drivers
#
CONFIG_X86_ACPI_CPUFREQ=3Dm
# CONFIG_X86_ACPI_CPUFREQ_PROC_INTF is not set
# CONFIG_X86_POWERNOW_K6 is not set
# CONFIG_X86_POWERNOW_K7 is not set
# CONFIG_X86_GX_SUSPMOD is not set
CONFIG_X86_SPEEDSTEP=3Dm
# CONFIG_X86_P4_CLOCKMOD is not set
# CONFIG_X86_LONGRUN is not set
# CONFIG_X86_LONGHAUL is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=3Dy
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=3Dy
CONFIG_PCI_BIOS=3Dy
CONFIG_PCI_DIRECT=3Dy
CONFIG_PCI_LEGACY_PROC=3Dy
CONFIG_PCI_NAMES=3Dy
CONFIG_ISA=3Dy
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set
CONFIG_HOTPLUG=3Dy

#
# PCMCIA/CardBus support
#
CONFIG_PCMCIA=3Dm
CONFIG_CARDBUS=3Dy
CONFIG_I82092=3Dm
CONFIG_I82365=3Dm
CONFIG_TCIC=3Dm
CONFIG_PCMCIA_PROBE=3Dy

#
# PCI Hotplug Support
#
CONFIG_HOTPLUG_PCI=3Dm
# CONFIG_HOTPLUG_PCI_COMPAQ is not set
CONFIG_HOTPLUG_PCI_ACPI=3Dm
# CONFIG_HOTPLUG_PCI_CPCI is not set

#
# Executable file formats
#
CONFIG_KCORE_ELF=3Dy
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=3Dm
CONFIG_BINFMT_ELF=3Dy
CONFIG_BINFMT_MISC=3Dm

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=3Dm
CONFIG_PARPORT_PC=3Dm
CONFIG_PARPORT_PC_CML1=3Dm
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=3Dy
# CONFIG_PARPORT_PC_SUPERIO is not set
CONFIG_PARPORT_PC_PCMCIA=3Dm
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=3Dy

#
# Plug and Play support
#
CONFIG_PNP=3Dy
CONFIG_PNP_NAMES=3Dy
CONFIG_PNP_DEBUG=3Dy

#
# Protocols
#
CONFIG_ISAPNP=3Dy
CONFIG_PNPBIOS=3Dy

#
# Block devices
#
CONFIG_BLK_DEV_FD=3Dm
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=3Dm
CONFIG_BLK_DEV_NBD=3Dm
CONFIG_BLK_DEV_RAM=3Dm
CONFIG_BLK_DEV_RAM_SIZE=3D4096
# CONFIG_BLK_DEV_INITRD is not set
# CONFIG_LBD is not set

#
# ATA/ATAPI/MFM/RLL device support
#
CONFIG_IDE=3Dy

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=3Dy

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=3Dy
CONFIG_IDEDISK_MULTI_MODE=3Dy
CONFIG_IDEDISK_STROKE=3Dy
CONFIG_BLK_DEV_IDECS=3Dm
CONFIG_BLK_DEV_IDECD=3Dm
CONFIG_BLK_DEV_IDEFLOPPY=3Dm
CONFIG_BLK_DEV_IDESCSI=3Dm
CONFIG_IDE_TASK_IOCTL=3Dy

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPNP=3Dy
CONFIG_BLK_DEV_IDEPCI=3Dy
CONFIG_BLK_DEV_GENERIC=3Dy
CONFIG_IDEPCI_SHARE_IRQ=3Dy
CONFIG_BLK_DEV_IDEDMA_PCI=3Dy
# CONFIG_BLK_DEV_IDE_TCQ is not set
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=3Dy
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=3Dy
# CONFIG_IDEDMA_PCI_WIP is not set
CONFIG_BLK_DEV_ADMA=3Dy
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=3Dy
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_RZ1000 is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=3Dy
CONFIG_IDEDMA_IVB=3Dy
CONFIG_BLK_DEV_IDE_MODES=3Dy

#
# SCSI device support
#
CONFIG_SCSI=3Dm

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=3Dm
CONFIG_CHR_DEV_ST=3Dm
CONFIG_CHR_DEV_OSST=3Dm
CONFIG_BLK_DEV_SR=3Dm
CONFIG_BLK_DEV_SR_VENDOR=3Dy
CONFIG_CHR_DEV_SG=3Dm

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_MULTI_LUN=3Dy
CONFIG_SCSI_REPORT_LUNS=3Dy
CONFIG_SCSI_CONSTANTS=3Dy
CONFIG_SCSI_LOGGING=3Dy

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_NCR53C7xx is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_NCR53C8XX is not set
# CONFIG_SCSI_SYM53C8XX is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_SEAGATE is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# PCMCIA SCSI adapter support
#
# CONFIG_PCMCIA_AHA152X is not set
# CONFIG_PCMCIA_FDOMAIN is not set
# CONFIG_PCMCIA_NINJA_SCSI is not set
# CONFIG_PCMCIA_QLOGIC is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
CONFIG_I2O=3Dm
CONFIG_I2O_PCI=3Dm
CONFIG_I2O_BLOCK=3Dm
CONFIG_I2O_SCSI=3Dm
CONFIG_I2O_PROC=3Dm

#
# Networking support
#
CONFIG_NET=3Dy

#
# Networking options
#
CONFIG_PACKET=3Dm
CONFIG_PACKET_MMAP=3Dy
CONFIG_NETLINK_DEV=3Dm
CONFIG_NETFILTER=3Dy
CONFIG_NETFILTER_DEBUG=3Dy
CONFIG_UNIX=3Dy
CONFIG_NET_KEY=3Dm
CONFIG_INET=3Dy
CONFIG_IP_MULTICAST=3Dy
CONFIG_IP_ADVANCED_ROUTER=3Dy
CONFIG_IP_MULTIPLE_TABLES=3Dy
CONFIG_IP_ROUTE_FWMARK=3Dy
CONFIG_IP_ROUTE_NAT=3Dy
CONFIG_IP_ROUTE_MULTIPATH=3Dy
CONFIG_IP_ROUTE_TOS=3Dy
CONFIG_IP_ROUTE_VERBOSE=3Dy
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=3Dm
CONFIG_NET_IPGRE=3Dm
CONFIG_NET_IPGRE_BROADCAST=3Dy
CONFIG_IP_MROUTE=3Dy
CONFIG_IP_PIMSM_V1=3Dy
CONFIG_IP_PIMSM_V2=3Dy
CONFIG_ARPD=3Dy
CONFIG_INET_ECN=3Dy
CONFIG_SYN_COOKIES=3Dy
CONFIG_INET_AH=3Dm
CONFIG_INET_ESP=3Dm
CONFIG_INET_IPCOMP=3Dm

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=3Dm
CONFIG_IP_NF_FTP=3Dm
CONFIG_IP_NF_IRC=3Dm
CONFIG_IP_NF_TFTP=3Dm
CONFIG_IP_NF_AMANDA=3Dm
CONFIG_IP_NF_QUEUE=3Dm
CONFIG_IP_NF_IPTABLES=3Dm
CONFIG_IP_NF_MATCH_LIMIT=3Dm
CONFIG_IP_NF_MATCH_MAC=3Dm
CONFIG_IP_NF_MATCH_PKTTYPE=3Dm
CONFIG_IP_NF_MATCH_MARK=3Dm
CONFIG_IP_NF_MATCH_MULTIPORT=3Dm
CONFIG_IP_NF_MATCH_TOS=3Dm
CONFIG_IP_NF_MATCH_ECN=3Dm
CONFIG_IP_NF_MATCH_DSCP=3Dm
CONFIG_IP_NF_MATCH_AH_ESP=3Dm
CONFIG_IP_NF_MATCH_LENGTH=3Dm
CONFIG_IP_NF_MATCH_TTL=3Dm
CONFIG_IP_NF_MATCH_TCPMSS=3Dm
CONFIG_IP_NF_MATCH_HELPER=3Dm
CONFIG_IP_NF_MATCH_STATE=3Dm
CONFIG_IP_NF_MATCH_CONNTRACK=3Dm
CONFIG_IP_NF_MATCH_UNCLEAN=3Dm
CONFIG_IP_NF_MATCH_OWNER=3Dm
CONFIG_IP_NF_FILTER=3Dm
CONFIG_IP_NF_TARGET_REJECT=3Dm
CONFIG_IP_NF_TARGET_MIRROR=3Dm
CONFIG_IP_NF_NAT=3Dm
CONFIG_IP_NF_NAT_NEEDED=3Dy
CONFIG_IP_NF_TARGET_MASQUERADE=3Dm
CONFIG_IP_NF_TARGET_REDIRECT=3Dm
CONFIG_IP_NF_NAT_LOCAL=3Dy
CONFIG_IP_NF_NAT_SNMP_BASIC=3Dm
CONFIG_IP_NF_NAT_IRC=3Dm
CONFIG_IP_NF_NAT_FTP=3Dm
CONFIG_IP_NF_NAT_TFTP=3Dm
CONFIG_IP_NF_NAT_AMANDA=3Dm
CONFIG_IP_NF_MANGLE=3Dm
CONFIG_IP_NF_TARGET_TOS=3Dm
CONFIG_IP_NF_TARGET_ECN=3Dm
CONFIG_IP_NF_TARGET_DSCP=3Dm
CONFIG_IP_NF_TARGET_MARK=3Dm
CONFIG_IP_NF_TARGET_LOG=3Dm
CONFIG_IP_NF_TARGET_ULOG=3Dm
CONFIG_IP_NF_TARGET_TCPMSS=3Dm
CONFIG_IP_NF_ARPTABLES=3Dm
CONFIG_IP_NF_ARPFILTER=3Dm
CONFIG_IP_NF_COMPAT_IPCHAINS=3Dm
CONFIG_IP_NF_COMPAT_IPFWADM=3Dm
CONFIG_IPV6=3Dm
CONFIG_IPV6_PRIVACY=3Dy
CONFIG_INET6_AH=3Dm
CONFIG_INET6_ESP=3Dm
CONFIG_INET6_IPCOMP=3Dm

#
# IPv6: Netfilter Configuration
#
CONFIG_IP6_NF_QUEUE=3Dm
CONFIG_IP6_NF_IPTABLES=3Dm
CONFIG_IP6_NF_MATCH_LIMIT=3Dm
CONFIG_IP6_NF_MATCH_MAC=3Dm
CONFIG_IP6_NF_MATCH_RT=3Dm
CONFIG_IP6_NF_MATCH_OPTS=3Dm
CONFIG_IP6_NF_MATCH_FRAG=3Dm
CONFIG_IP6_NF_MATCH_HL=3Dm
CONFIG_IP6_NF_MATCH_MULTIPORT=3Dm
CONFIG_IP6_NF_MATCH_OWNER=3Dm
CONFIG_IP6_NF_MATCH_MARK=3Dm
CONFIG_IP6_NF_MATCH_IPV6HEADER=3Dm
CONFIG_IP6_NF_MATCH_AHESP=3Dm
CONFIG_IP6_NF_MATCH_LENGTH=3Dm
CONFIG_IP6_NF_MATCH_EUI64=3Dm
CONFIG_IP6_NF_FILTER=3Dm
CONFIG_IP6_NF_TARGET_LOG=3Dm
CONFIG_IP6_NF_MANGLE=3Dm
CONFIG_IP6_NF_TARGET_MARK=3Dm
CONFIG_XFRM_USER=3Dm

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=3Dm
CONFIG_IP_SCTP=3Dm
CONFIG_SCTP_ADLER32=3Dy
CONFIG_SCTP_DBG_MSG=3Dy
CONFIG_SCTP_DBG_OBJCNT=3Dy
# CONFIG_SCTP_HMAC_NONE is not set
# CONFIG_SCTP_HMAC_SHA1 is not set
CONFIG_SCTP_HMAC_MD5=3Dy
# CONFIG_ATM is not set
CONFIG_VLAN_8021Q=3Dm
# CONFIG_LLC is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
CONFIG_NET_SCHED=3Dy
CONFIG_NET_SCH_CBQ=3Dm
CONFIG_NET_SCH_HTB=3Dm
CONFIG_NET_SCH_CSZ=3Dm
CONFIG_NET_SCH_PRIO=3Dm
CONFIG_NET_SCH_RED=3Dm
CONFIG_NET_SCH_SFQ=3Dm
CONFIG_NET_SCH_TEQL=3Dm
CONFIG_NET_SCH_TBF=3Dm
CONFIG_NET_SCH_GRED=3Dm
CONFIG_NET_SCH_DSMARK=3Dm
CONFIG_NET_SCH_INGRESS=3Dm
CONFIG_NET_QOS=3Dy
CONFIG_NET_ESTIMATOR=3Dy
CONFIG_NET_CLS=3Dy
CONFIG_NET_CLS_TCINDEX=3Dm
CONFIG_NET_CLS_ROUTE4=3Dm
CONFIG_NET_CLS_ROUTE=3Dy
CONFIG_NET_CLS_FW=3Dm
CONFIG_NET_CLS_U32=3Dm
CONFIG_NET_CLS_RSVP=3Dm
CONFIG_NET_CLS_RSVP6=3Dm
CONFIG_NET_CLS_POLICE=3Dy

#
# Network testing
#
CONFIG_NET_PKTGEN=3Dm
CONFIG_NETDEVICES=3Dy

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=3Dm
CONFIG_BONDING=3Dm
CONFIG_EQUALIZER=3Dm
CONFIG_TUN=3Dm
# CONFIG_ETHERTAP is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
# CONFIG_NET_ETHERNET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
CONFIG_PLIP=3Dm
CONFIG_PPP=3Dm
CONFIG_PPP_MULTILINK=3Dy
CONFIG_PPP_FILTER=3Dy
CONFIG_PPP_ASYNC=3Dm
CONFIG_PPP_SYNC_TTY=3Dm
CONFIG_PPP_DEFLATE=3Dm
CONFIG_PPP_BSDCOMP=3Dm
CONFIG_PPPOE=3Dm
CONFIG_SLIP=3Dm
CONFIG_SLIP_COMPRESSED=3Dy
CONFIG_SLIP_SMART=3Dy
CONFIG_SLIP_MODE_SLIP6=3Dy

#
# Wireless LAN (non-hamradio)
#
CONFIG_NET_RADIO=3Dy

#
# Obsolete Wireless cards support (pre-802.11)
#
CONFIG_STRIP=3Dm
# CONFIG_ARLAN is not set
CONFIG_WAVELAN=3Dm
CONFIG_PCMCIA_WAVELAN=3Dm
CONFIG_PCMCIA_NETWAVE=3Dm

#
# Wireless 802.11 Frequency Hopping cards support
#
# CONFIG_PCMCIA_RAYCS is not set

#
# Wireless 802.11b ISA/PCI cards support
#
CONFIG_AIRO=3Dm
CONFIG_HERMES=3Dm
CONFIG_PLX_HERMES=3Dm
CONFIG_PCI_HERMES=3Dm

#
# Wireless 802.11b Pcmcia/Cardbus cards support
#
CONFIG_PCMCIA_HERMES=3Dm
CONFIG_AIRO_CS=3Dm
CONFIG_NET_WIRELESS=3Dy

#
# Token Ring devices (depends on LLC=3Dy)
#
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
CONFIG_SHAPER=3Dm

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# PCMCIA network device support
#
CONFIG_NET_PCMCIA=3Dy
CONFIG_PCMCIA_3C589=3Dm
CONFIG_PCMCIA_3C574=3Dm
CONFIG_PCMCIA_FMVJ18X=3Dm
CONFIG_PCMCIA_PCNET=3Dm
CONFIG_PCMCIA_NMCLAN=3Dm
CONFIG_PCMCIA_SMC91C92=3Dm
CONFIG_PCMCIA_XIRC2PS=3Dm
CONFIG_PCMCIA_AXNET=3Dm

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
CONFIG_IRDA=3Dm

#
# IrDA protocols
#
CONFIG_IRLAN=3Dm
CONFIG_IRNET=3Dm
CONFIG_IRCOMM=3Dm
CONFIG_IRDA_ULTRA=3Dy

#
# IrDA options
#
CONFIG_IRDA_CACHE_LAST_LSAP=3Dy
CONFIG_IRDA_FAST_RR=3Dy
CONFIG_IRDA_DEBUG=3Dy

#
# Infrared-port device drivers
#

#
# SIR device drivers
#
CONFIG_IRTTY_SIR=3Dm

#
# Dongle support
#
# CONFIG_DONGLE is not set

#
# Old SIR device drivers
#
# CONFIG_IRTTY_OLD is not set
CONFIG_IRPORT_SIR=3Dm

#
# Old Serial dongle support
#
# CONFIG_DONGLE_OLD is not set

#
# FIR device drivers
#
# CONFIG_USB_IRDA is not set
CONFIG_NSC_FIR=3Dm
CONFIG_WINBOND_FIR=3Dm
# CONFIG_TOSHIBA_OLD is not set
# CONFIG_TOSHIBA_FIR is not set
# CONFIG_SMC_IRCC_OLD is not set
CONFIG_SMC_IRCC_FIR=3Dm
CONFIG_ALI_FIR=3Dm
CONFIG_VLSI_FIR=3Dm

#
# ISDN subsystem
#
# CONFIG_ISDN_BOOL is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=3Dy

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=3Dm
CONFIG_INPUT_MOUSEDEV_PSAUX=3Dy
CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=3Dm
CONFIG_INPUT_EVBUG=3Dm

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=3Dy
CONFIG_SERIO=3Dy
CONFIG_SERIO_I8042=3Dy
CONFIG_SERIO_SERPORT=3Dy
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=3Dy
CONFIG_KEYBOARD_ATKBD=3Dy
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=3Dy
CONFIG_MOUSE_PS2=3Dy
CONFIG_MOUSE_SERIAL=3Dm
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=3Dy
CONFIG_INPUT_PCSPKR=3Dm
CONFIG_INPUT_UINPUT=3Dm

#
# Character devices
#
CONFIG_VT=3Dy
CONFIG_VT_CONSOLE=3Dy
CONFIG_HW_CONSOLE=3Dy
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=3Dm
CONFIG_SERIAL_8250_CS=3Dm
CONFIG_SERIAL_8250_EXTENDED=3Dy
# CONFIG_SERIAL_8250_MANY_PORTS is not set
CONFIG_SERIAL_8250_SHARE_IRQ=3Dy
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
# CONFIG_SERIAL_8250_MULTIPORT is not set
# CONFIG_SERIAL_8250_RSA is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=3Dm
CONFIG_UNIX98_PTYS=3Dy
CONFIG_UNIX98_PTY_COUNT=3D256
CONFIG_PRINTER=3Dm
CONFIG_LP_CONSOLE=3Dy
CONFIG_PPDEV=3Dm
# CONFIG_TIPAR is not set

#
# I2C support
#
CONFIG_I2C=3Dm
CONFIG_I2C_ALGOBIT=3Dm
CONFIG_I2C_PHILIPSPAR=3Dm
CONFIG_I2C_ELV=3Dm
CONFIG_I2C_VELLEMAN=3Dm
# CONFIG_SCx200_ACB is not set
CONFIG_I2C_ALGOPCF=3Dm
# CONFIG_I2C_ELEKTOR is not set
CONFIG_I2C_CHARDEV=3Dm

#
# I2C Hardware Sensors Mainboard support
#
CONFIG_I2C_ALI15X3=3Dm
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
CONFIG_I2C_I801=3Dm
CONFIG_I2C_ISA=3Dm
CONFIG_I2C_PIIX4=3Dm
CONFIG_I2C_SIS96X=3Dm
CONFIG_I2C_VIAPRO=3Dm

#
# I2C Hardware Sensors Chip support
#
CONFIG_SENSORS_ADM1021=3Dm
CONFIG_SENSORS_IT87=3Dm
CONFIG_SENSORS_LM75=3Dm
CONFIG_SENSORS_VIA686A=3Dm
CONFIG_SENSORS_W83781D=3Dm
CONFIG_I2C_SENSOR=3Dm

#
# Mice
#
# CONFIG_BUSMOUSE is not set
# CONFIG_QIC02_TAPE is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
CONFIG_WATCHDOG=3Dy
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_SOFT_WATCHDOG=3Dm
# CONFIG_WDT is not set
# CONFIG_WDTPCI is not set
# CONFIG_PCWATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_EUROTECH_WDT is not set
# CONFIG_IB700_WDT is not set
# CONFIG_I810_TCO is not set
# CONFIG_MIXCOMWD is not set
# CONFIG_SCx200_WDT is not set
# CONFIG_60XX_WDT is not set
# CONFIG_W83877F_WDT is not set
# CONFIG_MACHZ_WDT is not set
# CONFIG_SC520_WDT is not set
# CONFIG_AMD7XX_TCO is not set
# CONFIG_ALIM7101_WDT is not set
# CONFIG_SC1200_WDT is not set
# CONFIG_WAFER_WDT is not set
# CONFIG_CPU5_WDT is not set
# CONFIG_HW_RANDOM is not set
CONFIG_NVRAM=3Dm
CONFIG_RTC=3Dm
CONFIG_GEN_RTC=3Dm
CONFIG_GEN_RTC_X=3Dy
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=3Dm
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD_8151 is not set
CONFIG_AGP_INTEL=3Dm
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_VIA is not set
CONFIG_DRM=3Dy
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_GAMMA is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_I810 is not set
# CONFIG_DRM_I830 is not set
# CONFIG_DRM_MGA is not set

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
# CONFIG_MWAVE is not set
CONFIG_RAW_DRIVER=3Dm
CONFIG_HANGCHECK_TIMER=3Dm

#
# Multimedia devices
#
CONFIG_VIDEO_DEV=3Dm

#
# Video For Linux
#
CONFIG_VIDEO_PROC_FS=3Dy

#
# Video Adapters
#
# CONFIG_VIDEO_BT848 is not set
# CONFIG_VIDEO_PMS is not set
# CONFIG_VIDEO_BWQCAM is not set
# CONFIG_VIDEO_CQCAM is not set
# CONFIG_VIDEO_W9966 is not set
CONFIG_VIDEO_CPIA=3Dm
# CONFIG_VIDEO_CPIA_PP is not set
CONFIG_VIDEO_CPIA_USB=3Dm
# CONFIG_VIDEO_SAA5249 is not set
# CONFIG_TUNER_3036 is not set
# CONFIG_VIDEO_STRADIS is not set
# CONFIG_VIDEO_ZORAN is not set
# CONFIG_VIDEO_ZR36120 is not set
# CONFIG_VIDEO_SAA7134 is not set
# CONFIG_VIDEO_MXB is not set
# CONFIG_VIDEO_DPC is not set

#
# Radio Adapters
#
# CONFIG_RADIO_CADET is not set
# CONFIG_RADIO_RTRACK is not set
# CONFIG_RADIO_RTRACK2 is not set
# CONFIG_RADIO_AZTECH is not set
# CONFIG_RADIO_GEMTEK is not set
# CONFIG_RADIO_GEMTEK_PCI is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_MAESTRO is not set
# CONFIG_RADIO_SF16FMI is not set
# CONFIG_RADIO_TERRATEC is not set
# CONFIG_RADIO_TRUST is not set
# CONFIG_RADIO_TYPHOON is not set
# CONFIG_RADIO_ZOLTRIX is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set
# CONFIG_VIDEO_BTCX is not set

#
# File systems
#
CONFIG_EXT2_FS=3Dy
CONFIG_EXT2_FS_XATTR=3Dy
CONFIG_EXT2_FS_POSIX_ACL=3Dy
CONFIG_EXT2_FS_SECURITY=3Dy
CONFIG_EXT3_FS=3Dm
CONFIG_EXT3_FS_XATTR=3Dy
CONFIG_EXT3_FS_POSIX_ACL=3Dy
CONFIG_EXT3_FS_SECURITY=3Dy
CONFIG_JBD=3Dm
CONFIG_JBD_DEBUG=3Dy
CONFIG_FS_MBCACHE=3Dy
CONFIG_REISERFS_FS=3Dy
# CONFIG_REISERFS_CHECK is not set
CONFIG_REISERFS_PROC_INFO=3Dy
CONFIG_JFS_FS=3Dm
CONFIG_JFS_POSIX_ACL=3Dy
# CONFIG_JFS_DEBUG is not set
CONFIG_JFS_STATISTICS=3Dy
CONFIG_FS_POSIX_ACL=3Dy
CONFIG_XFS_FS=3Dm
CONFIG_XFS_RT=3Dy
CONFIG_XFS_QUOTA=3Dy
CONFIG_XFS_POSIX_ACL=3Dy
CONFIG_MINIX_FS=3Dm
# CONFIG_ROMFS_FS is not set
CONFIG_QUOTA=3Dy
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=3Dm
CONFIG_QUOTACTL=3Dy
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=3Dm

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=3Dm
CONFIG_JOLIET=3Dy
CONFIG_ZISOFS=3Dy
CONFIG_ZISOFS_FS=3Dm
CONFIG_UDF_FS=3Dm

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=3Dy
CONFIG_MSDOS_FS=3Dm
CONFIG_VFAT_FS=3Dy
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=3Dy
CONFIG_DEVFS_FS=3Dy
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=3Dy
CONFIG_DEVPTS_FS_XATTR=3Dy
CONFIG_DEVPTS_FS_SECURITY=3Dy
CONFIG_TMPFS=3Dy
# CONFIG_HUGETLBFS is not set
CONFIG_RAMFS=3Dy

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=3Dm
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=3Dm
CONFIG_NFS_V3=3Dy
CONFIG_NFS_V4=3Dy
CONFIG_NFSD=3Dm
CONFIG_NFSD_V3=3Dy
CONFIG_NFSD_V4=3Dy
CONFIG_NFSD_TCP=3Dy
CONFIG_LOCKD=3Dm
CONFIG_LOCKD_V4=3Dy
CONFIG_EXPORTFS=3Dm
CONFIG_SUNRPC=3Dm
CONFIG_SUNRPC_GSS=3Dm
CONFIG_RPCSEC_GSS_KRB5=3Dm
CONFIG_SMB_FS=3Dm
# CONFIG_SMB_NLS_DEFAULT is not set
CONFIG_CIFS=3Dm
# CONFIG_NCP_FS is not set
CONFIG_CODA_FS=3Dm
# CONFIG_INTERMEZZO_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=3Dy
CONFIG_SMB_NLS=3Dy
CONFIG_NLS=3Dy

#
# Native Language Support
#
CONFIG_NLS_DEFAULT=3D"iso8859-1"
CONFIG_NLS_CODEPAGE_437=3Dm
CONFIG_NLS_CODEPAGE_737=3Dm
CONFIG_NLS_CODEPAGE_775=3Dm
CONFIG_NLS_CODEPAGE_850=3Dm
CONFIG_NLS_CODEPAGE_852=3Dm
CONFIG_NLS_CODEPAGE_855=3Dm
CONFIG_NLS_CODEPAGE_857=3Dm
CONFIG_NLS_CODEPAGE_860=3Dm
CONFIG_NLS_CODEPAGE_861=3Dm
CONFIG_NLS_CODEPAGE_862=3Dm
CONFIG_NLS_CODEPAGE_863=3Dm
CONFIG_NLS_CODEPAGE_864=3Dm
CONFIG_NLS_CODEPAGE_865=3Dm
CONFIG_NLS_CODEPAGE_866=3Dm
CONFIG_NLS_CODEPAGE_869=3Dm
CONFIG_NLS_CODEPAGE_936=3Dm
CONFIG_NLS_CODEPAGE_950=3Dm
CONFIG_NLS_CODEPAGE_932=3Dm
CONFIG_NLS_CODEPAGE_949=3Dm
CONFIG_NLS_CODEPAGE_874=3Dm
CONFIG_NLS_ISO8859_8=3Dm
CONFIG_NLS_CODEPAGE_1250=3Dm
CONFIG_NLS_CODEPAGE_1251=3Dm
CONFIG_NLS_ISO8859_1=3Dm
CONFIG_NLS_ISO8859_2=3Dm
CONFIG_NLS_ISO8859_3=3Dm
CONFIG_NLS_ISO8859_4=3Dm
CONFIG_NLS_ISO8859_5=3Dm
CONFIG_NLS_ISO8859_6=3Dm
CONFIG_NLS_ISO8859_7=3Dm
CONFIG_NLS_ISO8859_9=3Dm
CONFIG_NLS_ISO8859_13=3Dm
CONFIG_NLS_ISO8859_14=3Dm
CONFIG_NLS_ISO8859_15=3Dm
CONFIG_NLS_KOI8_R=3Dm
CONFIG_NLS_KOI8_U=3Dm
CONFIG_NLS_UTF8=3Dm

#
# Graphics support
#
CONFIG_FB=3Dy
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=3Dy
CONFIG_VIDEO_SELECT=3Dy
# CONFIG_FB_HGA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I810 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
CONFIG_FB_ATY=3Dm
CONFIG_FB_ATY_CT=3Dy
# CONFIG_FB_ATY_GX is not set
# CONFIG_FB_ATY_XL_INIT is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=3Dy
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=3Dy
CONFIG_FRAMEBUFFER_CONSOLE=3Dm
CONFIG_PCI_CONSOLE=3Dy
CONFIG_FONTS=3Dy
# CONFIG_FONT_8x8 is not set
CONFIG_FONT_8x16=3Dy
# CONFIG_FONT_6x11 is not set
# CONFIG_FONT_PEARL_8x8 is not set
# CONFIG_FONT_ACORN_8x8 is not set
# CONFIG_FONT_MINI_4x6 is not set
# CONFIG_FONT_SUN8x16 is not set
# CONFIG_FONT_SUN12x22 is not set

#
# Logo configuration
#
CONFIG_LOGO=3Dy
CONFIG_LOGO_LINUX_MONO=3Dy
CONFIG_LOGO_LINUX_VGA16=3Dy
CONFIG_LOGO_LINUX_CLUT224=3Dy

#
# Sound
#
CONFIG_SOUND=3Dm

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=3Dm
CONFIG_SND_SEQUENCER=3Dm
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_OSSEMUL=3Dy
CONFIG_SND_MIXER_OSS=3Dm
CONFIG_SND_PCM_OSS=3Dm
CONFIG_SND_SEQUENCER_OSS=3Dy
CONFIG_SND_RTCTIMER=3Dm
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# ISA devices
#
# CONFIG_SND_AD1816A is not set
# CONFIG_SND_AD1848 is not set
# CONFIG_SND_CS4231 is not set
# CONFIG_SND_CS4232 is not set
# CONFIG_SND_CS4236 is not set
# CONFIG_SND_ES968 is not set
# CONFIG_SND_ES1688 is not set
# CONFIG_SND_ES18XX is not set
# CONFIG_SND_GUSCLASSIC is not set
# CONFIG_SND_GUSEXTREME is not set
# CONFIG_SND_GUSMAX is not set
# CONFIG_SND_INTERWAVE is not set
# CONFIG_SND_INTERWAVE_STB is not set
# CONFIG_SND_OPTI92X_AD1848 is not set
# CONFIG_SND_OPTI92X_CS4231 is not set
# CONFIG_SND_OPTI93X is not set
# CONFIG_SND_SB8 is not set
# CONFIG_SND_SB16 is not set
# CONFIG_SND_SBAWE is not set
# CONFIG_SND_WAVEFRONT is not set
# CONFIG_SND_ALS100 is not set
# CONFIG_SND_AZT2320 is not set
# CONFIG_SND_CMI8330 is not set
# CONFIG_SND_DT019X is not set
# CONFIG_SND_OPL3SA2 is not set
# CONFIG_SND_SGALAXY is not set

#
# PCI devices
#
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
CONFIG_SND_MAESTRO3=3Dm
# CONFIG_SND_FM801 is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set

#
# ALSA USB devices
#
# CONFIG_SND_USB_AUDIO is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB=3Dm
CONFIG_USB_DEBUG=3Dy

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=3Dy
CONFIG_USB_BANDWIDTH=3Dy
CONFIG_USB_DYNAMIC_MINORS=3Dy

#
# USB Host Controller Drivers
#
# CONFIG_USB_EHCI_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=3Dm

#
# USB Device Class drivers
#
CONFIG_USB_AUDIO=3Dm
CONFIG_USB_BLUETOOTH_TTY=3Dm
CONFIG_USB_MIDI=3Dm
CONFIG_USB_ACM=3Dm
CONFIG_USB_PRINTER=3Dm
CONFIG_USB_STORAGE=3Dm
CONFIG_USB_STORAGE_DEBUG=3Dy
CONFIG_USB_STORAGE_DATAFAB=3Dy
CONFIG_USB_STORAGE_FREECOM=3Dy
CONFIG_USB_STORAGE_ISD200=3Dy
CONFIG_USB_STORAGE_DPCM=3Dy
CONFIG_USB_STORAGE_HP8200e=3Dy
CONFIG_USB_STORAGE_SDDR09=3Dy
CONFIG_USB_STORAGE_SDDR55=3Dy
CONFIG_USB_STORAGE_JUMPSHOT=3Dy

#
# USB Human Interface Devices (HID)
#
CONFIG_USB_HID=3Dm
CONFIG_USB_HIDINPUT=3Dy
CONFIG_HID_FF=3Dy
CONFIG_HID_PID=3Dy
CONFIG_LOGITECH_FF=3Dy
# CONFIG_THRUSTMASTER_FF is not set
CONFIG_USB_HIDDEV=3Dy

#
# USB HID Boot Protocol drivers
#
CONFIG_USB_KBD=3Dm
CONFIG_USB_MOUSE=3Dm
# CONFIG_USB_AIPTEK is not set
CONFIG_USB_WACOM=3Dm
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_XPAD is not set

#
# USB Imaging devices
#
CONFIG_USB_MDC800=3Dm
CONFIG_USB_SCANNER=3Dm
CONFIG_USB_MICROTEK=3Dm
CONFIG_USB_HPUSBSCSI=3Dm

#
# USB Multimedia devices
#
CONFIG_USB_DABUSB=3Dm
CONFIG_USB_VICAM=3Dm
CONFIG_USB_DSBR=3Dm
# CONFIG_USB_IBMCAM is not set
# CONFIG_USB_KONICAWC is not set
# CONFIG_USB_OV511 is not set
# CONFIG_USB_PWC is not set
# CONFIG_USB_SE401 is not set
# CONFIG_USB_STV680 is not set

#
# USB Network adaptors
#
CONFIG_USB_CATC=3Dm
CONFIG_USB_KAWETH=3Dm
CONFIG_USB_PEGASUS=3Dm
CONFIG_USB_RTL8150=3Dm
CONFIG_USB_USBNET=3Dm

#
# USB Host-to-Host Cables
#
CONFIG_USB_AN2720=3Dy
CONFIG_USB_BELKIN=3Dy
CONFIG_USB_GENESYS=3Dy
CONFIG_USB_NET1080=3Dy
CONFIG_USB_PL2301=3Dy

#
# Intelligent USB Devices/Gadgets
#
CONFIG_USB_ARMLINUX=3Dy
CONFIG_USB_EPSON2888=3Dy
CONFIG_USB_ZAURUS=3Dy
CONFIG_USB_CDCETHER=3Dy

#
# USB port drivers
#
CONFIG_USB_USS720=3Dm

#
# USB Serial Converter support
#
CONFIG_USB_SERIAL=3Dm
CONFIG_USB_SERIAL_GENERIC=3Dy
CONFIG_USB_SERIAL_BELKIN=3Dm
CONFIG_USB_SERIAL_WHITEHEAT=3Dm
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=3Dm
CONFIG_USB_SERIAL_EMPEG=3Dm
CONFIG_USB_SERIAL_FTDI_SIO=3Dm
CONFIG_USB_SERIAL_VISOR=3Dm
CONFIG_USB_SERIAL_IPAQ=3Dm
CONFIG_USB_SERIAL_IR=3Dm
CONFIG_USB_SERIAL_EDGEPORT=3Dm
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
CONFIG_USB_SERIAL_KEYSPAN_PDA=3Dm
CONFIG_USB_SERIAL_KEYSPAN=3Dm
# CONFIG_USB_SERIAL_KEYSPAN_MPR is not set
CONFIG_USB_SERIAL_KEYSPAN_USA28=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA28X=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA28XA=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA28XB=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA19=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA18X=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA19W=3Dy
# CONFIG_USB_SERIAL_KEYSPAN_USA19QW is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19QI is not set
CONFIG_USB_SERIAL_KEYSPAN_USA49W=3Dy
# CONFIG_USB_SERIAL_KEYSPAN_USA49WLC is not set
CONFIG_USB_SERIAL_KLSI=3Dm
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
CONFIG_USB_SERIAL_MCT_U232=3Dm
CONFIG_USB_SERIAL_PL2303=3Dm
# CONFIG_USB_SERIAL_SAFE is not set
CONFIG_USB_SERIAL_CYBERJACK=3Dm
CONFIG_USB_SERIAL_XIRCOM=3Dm
CONFIG_USB_SERIAL_OMNINET=3Dm
CONFIG_USB_EZUSB=3Dy

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI26=3Dm
CONFIG_USB_TIGL=3Dm
CONFIG_USB_AUERSWALD=3Dm
CONFIG_USB_RIO500=3Dm
# CONFIG_USB_BRLVGER is not set
CONFIG_USB_LCD=3Dm
CONFIG_USB_TEST=3Dm
CONFIG_USB_GADGET=3Dm
CONFIG_USB_NET2280=3Dm
CONFIG_USB_ZERO=3Dm
CONFIG_USB_ZERO_NET2280=3Dy
CONFIG_USB_ETH=3Dm
CONFIG_USB_ETH_NET2280=3Dy

#
# Bluetooth support
#
# CONFIG_BT is not set

#
# Profiling support
#
CONFIG_PROFILING=3Dy
CONFIG_OPROFILE=3Dm

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=3Dy
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_IOVIRT is not set
CONFIG_MAGIC_SYSRQ=3Dy
# CONFIG_DEBUG_SPINLOCK is not set
CONFIG_KALLSYMS=3Dy
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
CONFIG_FRAME_POINTER=3Dy

#
# Security options
#
CONFIG_SECURITY=3Dy
CONFIG_SECURITY_NETWORK=3Dy
CONFIG_SECURITY_CAPABILITIES=3Dy
# CONFIG_SECURITY_ROOTPLUG is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=3Dy
CONFIG_CRYPTO_HMAC=3Dy
CONFIG_CRYPTO_NULL=3Dm
CONFIG_CRYPTO_MD4=3Dm
CONFIG_CRYPTO_MD5=3Dm
CONFIG_CRYPTO_SHA1=3Dm
CONFIG_CRYPTO_SHA256=3Dm
CONFIG_CRYPTO_SHA512=3Dm
CONFIG_CRYPTO_DES=3Dm
CONFIG_CRYPTO_BLOWFISH=3Dm
CONFIG_CRYPTO_TWOFISH=3Dm
CONFIG_CRYPTO_SERPENT=3Dm
CONFIG_CRYPTO_AES=3Dm
CONFIG_CRYPTO_DEFLATE=3Dm
CONFIG_CRYPTO_TEST=3Dm

#
# Library routines
#
CONFIG_CRC32=3Dm
CONFIG_ZLIB_INFLATE=3Dm
CONFIG_ZLIB_DEFLATE=3Dm
CONFIG_X86_BIOS_REBOOT=3Dy
---

--=20
____________________}John Flinchbaugh{______________________
| glynis@hjsoft.com         http://www.hjsoft.com/~glynis/ |
~~Powered by Linux: Reboots are for hardware upgrades only~~

--z6Eq5LdranGa6ru8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+017wCGPRljI8080RAgZAAJwKSpn6edo6tZ4NjJ0ODgJh89h2dACff6JD
n5IGQVsUCh4KOWAwOjbBSjk=
=58e/
-----END PGP SIGNATURE-----

--z6Eq5LdranGa6ru8--
