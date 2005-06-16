Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261720AbVFPDwb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261720AbVFPDwb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 23:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbVFPDwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 23:52:31 -0400
Received: from mxsf39.cluster1.charter.net ([209.225.28.166]:53904 "EHLO
	mxsf39.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S261720AbVFPDvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 23:51:13 -0400
X-IronPort-AV: i="3.93,202,1115006400"; 
   d="log'?scan'208"; a="1051466896:sNHT30501800"
Message-ID: <42B0F72D.5040405@cybsft.com>
Date: Wed, 15 Jun 2005 22:51:09 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
References: <20050608112801.GA31084@elte.hu>
In-Reply-To: <20050608112801.GA31084@elte.hu>
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/mixed;
 boundary="------------070006010705000408090607"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070006010705000408090607
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:
> i have released the -V0.7.48-00 Real-Time Preemption patch, which can be 
> downloaded from the usual place:
> 
>     http://redhat.com/~mingo/realtime-preempt/
> 
> this release includes an improved version of Daniel Walker's soft 
> irq-flag (hardirq-disable removal) feature. It is an unconditional part
> of the PREEMPT_RT preemption model - other preemption models should not
> be affected that much (besides possible build issues). Non-x86 arches
> wont build. Some regressions might happen, so take care..
> 
> Changes since -47-29:
> 
>  - soft IRQ flag support (Daniel Walker)
> 
>  - fix race in usbnet.c (Eugeny S. Mints)
> 
>  - further improvements to the soft IRQ flag code
> 
> to build a -V0.7.48-00 tree, the following patches should to be applied:
> 
>    http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.11.tar.bz2
>    http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.12-rc6.bz2
>    http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.12-rc6-V0.7.48-00
> 
> 	Ingo

Ingo,

Having problems with -RT-2.6.12-rc6-V0.7.48-33 booting on my older SMP
system (dual 933). Looking at the log apic.log it indicates a problem
with APIC. noapic.log is a log when I add "noapic" to the boot parameters.

-- 
   kr

--------------070006010705000408090607
Content-Type: text/plain;
 name="apic.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="apic.log"

Linux version 2.6.12-rc6-RT-V0.7.48-33 (kr@porky.cybersoft.int) (gcc version 3.4.3 20050227 (Red Hat 3.4.3-22.fc3)) #5 SMP Wed Jun 15 06:25:04 CDT 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff9e000 (usable)
 BIOS-e820: 000000001ff9e000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
511MB LOWMEM available.
found SMP MP-table at 000fe710
DMI 2.3 present.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: DELL     Product ID: WS 620       APIC at: 0xFEE00000
Processor #0 6:8 APIC version 17
Processor #1 6:8 APIC version 17
I/O APIC #2 Version 32 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 2
Allocating PCI resources starting at 20000000 (gap: 20000000:dec00000)
Real-Time Preemption Support (c) Ingo Molnar
Built 1 zonelists
Kernel command line: ro root=LABEL=/ console=ttyS0,38400 console=tty0 nmi_watchdog=1 
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 931.130 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 513760k/523896k available (2221k kernel code, 9752k reserved, 1222k data, 232k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Security Framework v1.0.0 initialized
Capability LSM initialized
Mount-cache hash table entries: 512
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel Pentium III (Coppermine) stepping 06
Booting processor 1/1 eip 2000
Initializing CPU#1
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium III (Coppermine) stepping 06
Total of 2 processors activated (3715.07 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=0
checking TSC synchronization across 2 CPUs: passed.
spawn_desched_task(00000000)
ksoftirqd started up.
softirq RT prio: 24.
ksoftirqd started up.
softirq RT prio: 24.
ksoftirqd started up.
softirq RT prio: 24.
ksoftirqd started up.
softirq RT prio: 24.
ksoftirqd started up.
softirq RT prio: 24.
ksoftirqd started up.
softirq RT prio: 24.
desched cpu_callback 3/00000000
desched cpu_callback 2/00000000
desched thread 0 started up.
softlockup thread 0 started up.
desched cpu_callback 3/00000001
ksoftirqd started up.
desched cpu_callback 2/00000001
Brought up 2 CPUs
ksoftirqd started up.
softirq RT prio: 24.
ksoftirqd started up.
softirq RT prio: 24.
ksoftirqd started up.
softirq RT prio: 24.
checking if image is initramfs... it is
Freeing initrd memory: 295k freed
softirq RT prio: 24.
ksoftirqd started up.
ksoftirqd started up.
softirq RT prio: 24.
desched thread 1 started up.
softlockup thread 1 started up.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfc03e, last bus=4
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
softirq RT prio: 24.
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Transparent bridge - 0000:00:1e.0
PCI: Using IRQ router PIIX/ICH [8086/2410] at 0000:00:1f.0
PCI->APIC IRQ transform: 0000:00:1f.2[D] -> IRQ 19
PCI->APIC IRQ transform: 0000:00:1f.3[B] -> IRQ 17
PCI->APIC IRQ transform: 0000:01:00.0[A] -> IRQ 16
PCI->APIC IRQ transform: 0000:04:04.0[A] -> IRQ 16
PCI->APIC IRQ transform: 0000:04:05.0[A] -> IRQ 17
PCI->APIC IRQ transform: 0000:04:05.1[B] -> IRQ 18
PCI->APIC IRQ transform: 0000:04:0a.0[A] -> IRQ 18
PCI: Failed to allocate mem resource #0:1000@0 for 0000:03:00.0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
nvidiafb: nVidia device/chipset 10DE0103
nvidiafb: nVidia Corporation NV10GL [Quadro]
nvidiafb: HW is currently programmed for CRT
nvidiafb: Using CRT on CRTC 0
nvidiafb: MTRR set to ON
nvidiafb: PCI nVidia NV10 framebuffer (64MB @ 0xE8000000)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH: IDE controller at PCI slot 0000:00:1f.1
ICH: chipset revision 2
ICH: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hda: SAMSUNG CD-R/RW SW-248F, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: Lite-On LTN483S 48x Max, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

  Vendor: QUANTUM   Model: ATLAS10K2-TY092L  Rev: DA40
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
 target0:0:0: Beginning Domain Validation
WIDTH IS 1
(scsi0:A:0): 6.600MB/s transfers (16bit)
(scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
 target0:0:0: Ending Domain Validation
scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs

  Vendor: SEAGATE   Model: SX118273LC        Rev: 6679
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi1:A:0:0: Tagged Queuing enabled.  Depth 32
 target1:0:0: Beginning Domain Validation
 target1:0:0: Domain Validation skipping write tests
(scsi1:A:0): 20.000MB/s transfers (20.000MHz, offset 15)
 target1:0:0: Ending Domain Validation
SCSI device sda: 17783239 512-byte hdwr sectors (9105 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 17783239 512-byte hdwr sectors (9105 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 35566480 512-byte hdwr sectors (18210 MB)
SCSI device sdb: drive cache: write through
SCSI device sdb: 35566480 512-byte hdwr sectors (18210 MB)
SCSI device sdb: drive cache: write through
 sdb: sdb1
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg1 at scsi1, channel 0, id 0, lun 0,  type 0
mice: PS/2 mouse device common for all mice
md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
IP: routing cache hash table of 256 buckets, 22Kbytes
TCP established hash table entries: 32768 (order: 9, 3145728 bytes)
TCP bind hash table entries: 32768 (order: 9, 2883584 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 8
NET: Registered protocol family 20
Testing NMI watchdog ... OK.
Starting balanced_irq
*****************************************************************************
*                                                                           *
*  WARNING, the following debugging options are turned on in your .config:  *
*                                                                           *
*        CONFIG_DEBUG_RT_LOCKING_MODE                                       *
*        CONFIG_RT_DEADLOCK_DETECT                                          *
*        CONFIG_DEBUG_PREEMPT                                               *
*                                                                           *
*  they may increase runtime overhead and latencies considerably!           *
*                                                                           *
*****************************************************************************
Freeing unused kernel memory: 232k freed
<<7>APIC error on CPU1: 08(08)

--------------070006010705000408090607
Content-Type: text/plain;
 name="noapic.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="noapic.log"

Linux version 2.6.12-rc6-RT-V0.7.48-33 (kr@porky.cybersoft.int) (gcc version 3.4.3 20050227 (Red Hat 3.4.3-22.fc3)) #5 SMP Wed Jun 15 06:25:04 CDT 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff9e000 (usable)
 BIOS-e820: 000000001ff9e000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
511MB LOWMEM available.
found SMP MP-table at 000fe710
DMI 2.3 present.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: DELL     Product ID: WS 620       APIC at: 0xFEE00000
Processor #0 6:8 APIC version 17
Processor #1 6:8 APIC version 17
I/O APIC #2 Version 32 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 2
Allocating PCI resources starting at 20000000 (gap: 20000000:dec00000)
Real-Time Preemption Support (c) Ingo Molnar
Built 1 zonelists
Kernel command line: ro root=LABEL=/ console=ttyS0,38400 console=tty0 nmi_watchdog=1 noapic
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 931.130 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 513760k/523896k available (2221k kernel code, 9752k reserved, 1222k data, 232k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Security Framework v1.0.0 initialized
Capability LSM initialized
Mount-cache hash table entries: 512
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel Pentium III (Coppermine) stepping 06
Booting processor 1/1 eip 2000
Initializing CPU#1
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium III (Coppermine) stepping 06
Total of 2 processors activated (3715.07 BogoMIPS).
checking TSC synchronization across 2 CPUs: passed.
spawn_desched_task(00000000)
ksoftirqd started up.
softirq RT prio: 24.
ksoftirqd started up.
softirq RT prio: 24.
ksoftirqd started up.
softirq RT prio: 24.
ksoftirqd started up.
softirq RT prio: 24.
ksoftirqd started up.
softirq RT prio: 24.
ksoftirqd started up.
softirq RT prio: 24.
desched cpu_callback 3/00000000
desched cpu_callback 2/00000000
desched thread 0 started up.
softlockup thread 0 started up.
desched cpu_callback 3/00000001
desched cpu_callback 2/00000001
ksoftirqd started up.
softirq RT prio: 24.
ksoftirqd started up.
softirq RT prio: 24.
ksoftirqd started up.
softirq RT prio: 24.
ksoftirqd started up.
softirq RT prio: 24.
ksoftirqd started up.
softirq RT prio: 24.
ksoftirqd started up.
softirq RT prio: 24.
Brought up 2 CPUs
desched thread 1 started up.
softlockup thread 1 started up.
checking if image is initramfs... it is
Freeing initrd memory: 295k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfc03e, last bus=4
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Transparent bridge - 0000:00:1e.0
PCI: Using IRQ router PIIX/ICH [8086/2410] at 0000:00:1f.0
PCI: Failed to allocate mem resource #0:1000@0 for 0000:03:00.0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
PCI: Found IRQ 9 for device 0000:01:00.0
PCI: Sharing IRQ 9 with 0000:04:04.0
nvidiafb: nVidia device/chipset 10DE0103
nvidiafb: nVidia Corporation NV10GL [Quadro]
nvidiafb: HW is currently programmed for CRT
nvidiafb: Using CRT on CRTC 0
nvidiafb: MTRR set to ON
nvidiafb: PCI nVidia NV10 framebuffer (64MB @ 0xE8000000)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH: IDE controller at PCI slot 0000:00:1f.1
ICH: chipset revision 2
ICH: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hda: SAMSUNG CD-R/RW SW-248F, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: Lite-On LTN483S 48x Max, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
PCI: Found IRQ 10 for device 0000:04:05.0
PCI: Sharing IRQ 10 with 0000:00:1f.3
PCI: Found IRQ 5 for device 0000:04:05.1
PCI: Sharing IRQ 5 with 0000:04:0a.0
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

  Vendor: QUANTUM   Model: ATLAS10K2-TY092L  Rev: DA40
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
 target0:0:0: Beginning Domain Validation
WIDTH IS 1
(scsi0:A:0): 6.600MB/s transfers (16bit)
(scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
 target0:0:0: Ending Domain Validation
scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs

  Vendor: SEAGATE   Model: SX118273LC        Rev: 6679
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi1:A:0:0: Tagged Queuing enabled.  Depth 32
 target1:0:0: Beginning Domain Validation
 target1:0:0: Domain Validation skipping write tests
(scsi1:A:0): 20.000MB/s transfers (20.000MHz, offset 15)
 target1:0:0: Ending Domain Validation
SCSI device sda: 17783239 512-byte hdwr sectors (9105 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 17783239 512-byte hdwr sectors (9105 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 35566480 512-byte hdwr sectors (18210 MB)
SCSI device sdb: drive cache: write through
SCSI device sdb: 35566480 512-byte hdwr sectors (18210 MB)
SCSI device sdb: drive cache: write through
 sdb: sdb1
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg1 at scsi1, channel 0, id 0, lun 0,  type 0
mice: PS/2 mouse device common for all mice
md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
IP: routing cache hash table of 256 buckets, 22Kbytes
TCP established hash table entries: 32768 (order: 9, 3145728 bytes)
TCP bind hash table entries: 32768 (order: 9, 2883584 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 8
NET: Registered protocol family 20
Testing NMI watchdog ... OK.
Starting balanced_irq
*****************************************************************************
*                                                                           *
*  WARNING, the following debugging options are turned on in your .config:  *
*                                                                           *
*        CONFIG_DEBUG_RT_LOCKING_MODE                                       *
*        CONFIG_RT_DEADLOCK_DETECT                                          *
*        CONFIG_DEBUG_PREEMPT                                               *
*                                                                           *
*  they may increase runtime overhead and latencies considerably!           *
*                                                                           *
*****************************************************************************
Freeing unused kernel memory: 232k freed
input: AT Translated Set 2 keyboard on isa0060/serio0
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
------------[ cut here ]------------
kernel BUG at drivers/ide/ide-io.c:1109!
invalid operand: 0000 [#1]
PREEMPT SMP 
Modules linked in: ide_cd cdrom
CPU:    1
EIP:    0060:[<c025cf63>]    Not tainted VLI
EFLAGS: 00010282   (2.6.12-rc6-RT-V0.7.48-33) 
EIP is at ide_do_request+0x3a3/0x3d0
eax: 00000025   ebx: 00000000   ecx: 00000000   edx: 00000079
esi: df227d68   edi: 00000000   ebp: 00000001   esp: df227bf0
ds: 007b   es: 007b   ss: 0068   preempt: 00000002
Process modprobe (pid: 1342, threadinfo=df226000 task=de83e920)
Stack: c03388a8 c034c013 00000455 df227d68 00000000 df227d68 00000000 00000001 
       c025d691 dfd7e200 ffffffff 00000002 00000000 00000002 dfd7e200 00000001 
       00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
Call Trace:
 [<c025d691>] ide_do_drive_cmd+0x121/0x190 (36)
 [<c0101940>] __switch_to+0x30/0x200 (116)
 [<e0839b8a>] cdrom_queue_packet_command+0x4a/0xd0 [ide_cd] (120)
 [<c0117490>] default_wake_function+0x0/0x30 (20)
 [<c012f195>] queue_work+0x55/0xa0 (12)
 [<c012f0b0>] call_usermodehelper+0x160/0x180 (28)
 [<e083b516>] ide_cdrom_packet+0xb6/0x100 [ide_cd] (36)
 [<c023a4e0>] blk_end_sync_rq+0x0/0x30 (152)
 [<e083be1b>] ide_cdrom_get_capabilities+0x9b/0xb0 [ide_cd] (36)
 [<e083bede>] ide_cdrom_probe_capabilities+0xae/0x4e0 [ide_cd] (92)
 [<e083c7bc>] ide_cdrom_setup+0x2ac/0x460 [ide_cd] (68)
 [<e083ceea>] ide_cd_probe+0x14a/0x2b0 [ide_cd] (32)
 [<c032a802>] _raw_spin_unlock+0x12/0x30 (28)
 [<c01e8010>] kobject_hotplug+0x2a0/0x2f0 (20)
 [<c01a9256>] sysfs_create_dir+0x36/0xa0 (20)
 [<c0232552>] driver_probe_device+0x32/0x80 (36)
 [<c02326b2>] driver_attach+0x52/0xa0 (20)
 [<c0232c37>] bus_add_driver+0x97/0xe0 (32)
 [<e083d05f>] ide_cdrom_init+0xf/0x20 [ide_cd] (32)
 [<c013ff97>] sys_init_module+0x157/0x240 (8)
 [<c010320b>] sysenter_past_esp+0x54/0x75 (28)
---------------------------
| preempt count: 00000003 ]
| 3-level deep critical section nesting:
----------------------------------------
.. [<c032a3c9>] .... _raw_spin_lock+0x19/0x90
.....[<00000000>] ..   ( <= 0x0)
.. [<c032a459>] .... _raw_spin_lock_irqsave+0x19/0xa0
.....[<00000000>] ..   ( <= 0x0)
.. [<c013b544>] .... print_traces+0x14/0x40
.....[<00000000>] ..   ( <= 0x0)

Code: 24 c7 40 08 00 00 00 00 e9 eb fe ff ff c7 04 24 a8 88 33 c0 b9 55 04 00 00 ba 13 c0 34 c0 89 4c 24 08 89 54 24 04 e8 7d 04 ec ff <0f> 0b 55 04 13 c0 34 c0 e9 64 fc ff ff c7 04 24 84 76 35 c0 e8 
 <6>note: modprobe[1342] exited with preempt_count 1
BUG: scheduling while atomic: modprobe/0x10000001/1342
caller is __cond_resched+0x42/0x60
 [<c032782b>] __schedule+0x52b/0x920 (8)
 [<c01183c2>] __cond_resched+0x42/0x60 (8)
 [<c015cbb6>] page_remove_rmap+0x36/0x90 (12)
 [<c01510e4>] mark_page_accessed+0x34/0x40 (12)
 [<c0155995>] zap_pte_range+0xe5/0x1e0 (8)
 [<c01514fd>] release_pages+0x14d/0x180 (12)
 [<c013b2a3>] add_preempt_count+0x23/0xe0 (4)
 [<c013b2a3>] add_preempt_count+0x23/0xe0 (8)
 [<c01183c2>] __cond_resched+0x42/0x60 (28)
 [<c032852c>] cond_resched+0x1c/0x30 (16)
 [<c0155cc2>] unmap_vmas+0x142/0x1b0 (8)
 [<c015abdb>] exit_mmap+0x5b/0x110 (64)
 [<c0104950>] do_invalid_op+0x0/0xb0 (48)
 [<c011a1db>] mmput+0x3b/0xb0 (8)
 [<c011ffe1>] do_exit+0xc1/0x420 (16)
 [<c0104950>] do_invalid_op+0x0/0xb0 (32)
 [<c01045bc>] die+0x18c/0x190 (8)
 [<c01049f6>] do_invalid_op+0xa6/0xb0 (60)
 [<c025cf63>] ide_do_request+0x3a3/0x3d0 (76)
 [<c011d7a9>] release_console_sem+0x79/0xe0 (4)
 [<c011d7a9>] release_console_sem+0x79/0xe0 (20)
 [<c011d585>] vprintk+0x185/0x270 (28)
 [<c032a802>] _raw_spin_unlock+0x12/0x30 (20)
 [<c0101940>] __switch_to+0x30/0x200 (16)
 [<c0103d5f>] error_code+0x4f/0x54 (36)
 [<c025cf63>] ide_do_request+0x3a3/0x3d0 (44)
 [<c025d691>] ide_do_drive_cmd+0x121/0x190 (44)
 [<c0101940>] __switch_to+0x30/0x200 (116)
 [<e0839b8a>] cdrom_queue_packet_command+0x4a/0xd0 [ide_cd] (120)
 [<c0117490>] default_wake_function+0x0/0x30 (20)
 [<c012f195>] queue_work+0x55/0xa0 (12)
 [<c012f0b0>] call_usermodehelper+0x160/0x180 (28)
 [<e083b516>] ide_cdrom_packet+0xb6/0x100 [ide_cd] (36)
 [<c023a4e0>] blk_end_sync_rq+0x0/0x30 (152)
 [<e083be1b>] ide_cdrom_get_capabilities+0x9b/0xb0 [ide_cd] (36)
 [<e083bede>] ide_cdrom_probe_capabilities+0xae/0x4e0 [ide_cd] (92)
 [<e083c7bc>] ide_cdrom_setup+0x2ac/0x460 [ide_cd] (68)
 [<e083ceea>] ide_cd_probe+0x14a/0x2b0 [ide_cd] (32)
 [<c032a802>] _raw_spin_unlock+0x12/0x30 (28)
 [<c01e8010>] kobject_hotplug+0x2a0/0x2f0 (20)
 [<c01a9256>] sysfs_create_dir+0x36/0xa0 (20)
 [<c0232552>] driver_probe_device+0x32/0x80 (36)
 [<c02326b2>] driver_attach+0x52/0xa0 (20)
 [<c0232c37>] bus_add_driver+0x97/0xe0 (32)
 [<e083d05f>] ide_cdrom_init+0xf/0x20 [ide_cd] (32)
 [<c013ff97>] sys_init_module+0x157/0x240 (8)
 [<c010320b>] sysenter_past_esp+0x54/0x75 (28)
---------------------------
| preempt count: 10000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<c032a3c9>] .... _raw_spin_lock+0x19/0x90
.....[<00000000>] ..   ( <= 0x0)
.. [<c013b544>] .... print_traces+0x14/0x40
.....[<00000000>] ..   ( <= 0x0)

BUG: sleeping function called from invalid context modprobe(1342) at mm/mmap.c:186
in_atomic():1 [00000001], irqs_disabled():0
 [<c01199cb>] __might_sleep+0xdb/0x100 (8)
 [<c015891f>] remove_vm_struct+0x2f/0xb0 (36)
 [<c015ac4e>] exit_mmap+0xce/0x110 (32)
 [<c0104950>] do_invalid_op+0x0/0xb0 (48)
 [<c011a1db>] mmput+0x3b/0xb0 (8)
 [<c011ffe1>] do_exit+0xc1/0x420 (16)
 [<c0104950>] do_invalid_op+0x0/0xb0 (32)
 [<c01045bc>] die+0x18c/0x190 (8)
 [<c01049f6>] do_invalid_op+0xa6/0xb0 (60)
 [<c025cf63>] ide_do_request+0x3a3/0x3d0 (76)
 [<c011d7a9>] release_console_sem+0x79/0xe0 (4)
 [<c011d7a9>] release_console_sem+0x79/0xe0 (20)
 [<c011d585>] vprintk+0x185/0x270 (28)
 [<c032a802>] _raw_spin_unlock+0x12/0x30 (20)
 [<c0101940>] __switch_to+0x30/0x200 (16)
 [<c0103d5f>] error_code+0x4f/0x54 (36)
 [<c025cf63>] ide_do_request+0x3a3/0x3d0 (44)
 [<c025d691>] ide_do_drive_cmd+0x121/0x190 (44)
 [<c0101940>] __switch_to+0x30/0x200 (116)
 [<e0839b8a>] cdrom_queue_packet_command+0x4a/0xd0 [ide_cd] (120)
 [<c0117490>] default_wake_function+0x0/0x30 (20)
 [<c012f195>] queue_work+0x55/0xa0 (12)
 [<c012f0b0>] call_usermodehelper+0x160/0x180 (28)
 [<e083b516>] ide_cdrom_packet+0xb6/0x100 [ide_cd] (36)
 [<c023a4e0>] blk_end_sync_rq+0x0/0x30 (152)
 [<e083be1b>] ide_cdrom_get_capabilities+0x9b/0xb0 [ide_cd] (36)
 [<e083bede>] ide_cdrom_probe_capabilities+0xae/0x4e0 [ide_cd] (92)
 [<e083c7bc>] ide_cdrom_setup+0x2ac/0x460 [ide_cd] (68)
 [<e083ceea>] ide_cd_probe+0x14a/0x2b0 [ide_cd] (32)
 [<c032a802>] _raw_spin_unlock+0x12/0x30 (28)
 [<c01e8010>] kobject_hotplug+0x2a0/0x2f0 (20)
 [<c01a9256>] sysfs_create_dir+0x36/0xa0 (20)
 [<c0232552>] driver_probe_device+0x32/0x80 (36)
 [<c02326b2>] driver_attach+0x52/0xa0 (20)
 [<c0232c37>] bus_add_driver+0x97/0xe0 (32)
 [<e083d05f>] ide_cdrom_init+0xf/0x20 [ide_cd] (32)
 [<c013ff97>] sys_init_module+0x157/0x240 (8)
 [<c010320b>] sysenter_past_esp+0x54/0x75 (28)
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<c032a3c9>] .... _raw_spin_lock+0x19/0x90
.....[<00000000>] ..   ( <= 0x0)
.. [<c013b544>] .... print_traces+0x14/0x40
.....[<00000000>] ..   ( <= 0x0)

BUG: scheduling while atomic: modprobe/0x10000001/1342
caller is __cond_resched+0x42/0x60
 [<c032782b>] __schedule+0x52b/0x920 (8)
 [<c01183c2>] __cond_resched+0x42/0x60 (8)
 [<c013b2a3>] add_preempt_count+0x23/0xe0 (12)
 [<c013b2a3>] add_preempt_count+0x23/0xe0 (12)
 [<c013b2a3>] add_preempt_count+0x23/0xe0 (32)
 [<c01183c2>] __cond_resched+0x42/0x60 (28)
 [<c032852c>] cond_resched+0x1c/0x30 (16)
 [<c011f1af>] put_files_struct+0x6f/0xe0 (8)
 [<c0120016>] do_exit+0xf6/0x420 (28)
 [<c0104950>] do_invalid_op+0x0/0xb0 (32)
 [<c01045bc>] die+0x18c/0x190 (8)
 [<c01049f6>] do_invalid_op+0xa6/0xb0 (60)
 [<c025cf63>] ide_do_request+0x3a3/0x3d0 (76)
 [<c011d7a9>] release_console_sem+0x79/0xe0 (4)
 [<c011d7a9>] release_console_sem+0x79/0xe0 (20)
 [<c011d585>] vprintk+0x185/0x270 (28)
 [<c032a802>] _raw_spin_unlock+0x12/0x30 (20)
 [<c0101940>] __switch_to+0x30/0x200 (16)
 [<c0103d5f>] error_code+0x4f/0x54 (36)
 [<c025cf63>] ide_do_request+0x3a3/0x3d0 (44)
 [<c025d691>] ide_do_drive_cmd+0x121/0x190 (44)
 [<c0101940>] __switch_to+0x30/0x200 (116)
 [<e0839b8a>] cdrom_queue_packet_command+0x4a/0xd0 [ide_cd] (120)
 [<c0117490>] default_wake_function+0x0/0x30 (20)
 [<c012f195>] queue_work+0x55/0xa0 (12)
 [<c012f0b0>] call_usermodehelper+0x160/0x180 (28)
 [<e083b516>] ide_cdrom_packet+0xb6/0x100 [ide_cd] (36)
 [<c023a4e0>] blk_end_sync_rq+0x0/0x30 (152)
 [<e083be1b>] ide_cdrom_get_capabilities+0x9b/0xb0 [ide_cd] (36)
 [<e083bede>] ide_cdrom_probe_capabilities+0xae/0x4e0 [ide_cd] (92)
 [<e083c7bc>] ide_cdrom_setup+0x2ac/0x460 [ide_cd] (68)
 [<e083ceea>] ide_cd_probe+0x14a/0x2b0 [ide_cd] (32)
 [<c032a802>] _raw_spin_unlock+0x12/0x30 (28)
 [<c01e8010>] kobject_hotplug+0x2a0/0x2f0 (20)
 [<c01a9256>] sysfs_create_dir+0x36/0xa0 (20)
 [<c0232552>] driver_probe_device+0x32/0x80 (36)
 [<c02326b2>] driver_attach+0x52/0xa0 (20)
 [<c0232c37>] bus_add_driver+0x97/0xe0 (32)
 [<e083d05f>] ide_cdrom_init+0xf/0x20 [ide_cd] (32)
 [<c013ff97>] sys_init_module+0x157/0x240 (8)
 [<c010320b>] sysenter_past_esp+0x54/0x75 (28)
---------------------------
| preempt count: 10000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<c032a3c9>] .... _raw_spin_lock+0x19/0x90
.....[<00000000>] ..   ( <= 0x0)
.. [<c013b544>] .... print_traces+0x14/0x40
.....[<00000000>] ..   ( <= 0x0)

BUG: sleeping function called from invalid context modprobe(1342) at fs/file_table.c:125
in_atomic():1 [00000001], irqs_disabled():0
 [<c01199cb>] __might_sleep+0xdb/0x100 (8)
 [<c0168637>] __fput+0x37/0x1b0 (36)
 [<c0166c32>] filp_close+0x52/0xa0 (32)
 [<c011f1aa>] put_files_struct+0x6a/0xe0 (24)
 [<c0120016>] do_exit+0xf6/0x420 (28)
 [<c0104950>] do_invalid_op+0x0/0xb0 (32)
 [<c01045bc>] die+0x18c/0x190 (8)
 [<c01049f6>] do_invalid_op+0xa6/0xb0 (60)
 [<c025cf63>] ide_do_request+0x3a3/0x3d0 (76)
 [<c011d7a9>] release_console_sem+0x79/0xe0 (4)
 [<c011d7a9>] release_console_sem+0x79/0xe0 (20)
 [<c011d585>] vprintk+0x185/0x270 (28)
 [<c032a802>] _raw_spin_unlock+0x12/0x30 (20)
 [<c0101940>] __switch_to+0x30/0x200 (16)
 [<c0103d5f>] error_code+0x4f/0x54 (36)
 [<c025cf63>] ide_do_request+0x3a3/0x3d0 (44)
 [<c025d691>] ide_do_drive_cmd+0x121/0x190 (44)
 [<c0101940>] __switch_to+0x30/0x200 (116)
 [<e0839b8a>] cdrom_queue_packet_command+0x4a/0xd0 [ide_cd] (120)
 [<c0117490>] default_wake_function+0x0/0x30 (20)
 [<c012f195>] queue_work+0x55/0xa0 (12)
 [<c012f0b0>] call_usermodehelper+0x160/0x180 (28)
 [<e083b516>] ide_cdrom_packet+0xb6/0x100 [ide_cd] (36)
 [<c023a4e0>] blk_end_sync_rq+0x0/0x30 (152)
 [<e083be1b>] ide_cdrom_get_capabilities+0x9b/0xb0 [ide_cd] (36)
 [<e083bede>] ide_cdrom_probe_capabilities+0xae/0x4e0 [ide_cd] (92)
 [<e083c7bc>] ide_cdrom_setup+0x2ac/0x460 [ide_cd] (68)
 [<e083ceea>] ide_cd_probe+0x14a/0x2b0 [ide_cd] (32)
 [<c032a802>] _raw_spin_unlock+0x12/0x30 (28)
 [<c01e8010>] kobject_hotplug+0x2a0/0x2f0 (20)
 [<c01a9256>] sysfs_create_dir+0x36/0xa0 (20)
 [<c0232552>] driver_probe_device+0x32/0x80 (36)
 [<c02326b2>] driver_attach+0x52/0xa0 (20)
 [<c0232c37>] bus_add_driver+0x97/0xe0 (32)
 [<e083d05f>] ide_cdrom_init+0xf/0x20 [ide_cd] (32)
 [<c013ff97>] sys_init_module+0x157/0x240 (8)
 [<c010320b>] sysenter_past_esp+0x54/0x75 (28)
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<c032a3c9>] .... _raw_spin_lock+0x19/0x90
.....[<00000000>] ..   ( <= 0x0)
.. [<c013b544>] .... print_traces+0x14/0x40
.....[<00000000>] ..   ( <= 0x0)

BUG: scheduling while atomic: modprobe/0x10000001/1342
caller is __cond_resched+0x42/0x60
 [<c032782b>] __schedule+0x52b/0x920 (8)
 [<c01183c2>] __cond_resched+0x42/0x60 (8)
 [<c0182246>] dput+0x1f6/0x210 (28)
 [<c0168710>] __fput+0x110/0x1b0 (24)
 [<c013b2a3>] add_preempt_count+0x23/0xe0 (4)
 [<c01183c2>] __cond_resched+0x42/0x60 (28)
 [<c032852c>] cond_resched+0x1c/0x30 (16)
 [<c011f1af>] put_files_struct+0x6f/0xe0 (8)
 [<c0120016>] do_exit+0xf6/0x420 (28)
 [<c0104950>] do_invalid_op+0x0/0xb0 (32)
 [<c01045bc>] die+0x18c/0x190 (8)
 [<c01049f6>] do_invalid_op+0xa6/0xb0 (60)
 [<c025cf63>] ide_do_request+0x3a3/0x3d0 (76)
 [<c011d7a9>] release_console_sem+0x79/0xe0 (4)
 [<c011d7a9>] release_console_sem+0x79/0xe0 (20)
 [<c011d585>] vprintk+0x185/0x270 (28)
 [<c032a802>] _raw_spin_unlock+0x12/0x30 (20)
 [<c0101940>] __switch_to+0x30/0x200 (16)
 [<c0103d5f>] error_code+0x4f/0x54 (36)
 [<c025cf63>] ide_do_request+0x3a3/0x3d0 (44)
 [<c025d691>] ide_do_drive_cmd+0x121/0x190 (44)
 [<c0101940>] __switch_to+0x30/0x200 (116)
 [<e0839b8a>] cdrom_queue_packet_command+0x4a/0xd0 [ide_cd] (120)
 [<c0117490>] default_wake_function+0x0/0x30 (20)
 [<c012f195>] queue_work+0x55/0xa0 (12)
 [<c012f0b0>] call_usermodehelper+0x160/0x180 (28)
 [<e083b516>] ide_cdrom_packet+0xb6/0x100 [ide_cd] (36)
 [<c023a4e0>] blk_end_sync_rq+0x0/0x30 (152)
 [<e083be1b>] ide_cdrom_get_capabilities+0x9b/0xb0 [ide_cd] (36)
 [<e083bede>] ide_cdrom_probe_capabilities+0xae/0x4e0 [ide_cd] (92)
 [<e083c7bc>] ide_cdrom_setup+0x2ac/0x460 [ide_cd] (68)
 [<e083ceea>] ide_cd_probe+0x14a/0x2b0 [ide_cd] (32)
 [<c032a802>] _raw_spin_unlock+0x12/0x30 (28)
 [<c01e8010>] kobject_hotplug+0x2a0/0x2f0 (20)
 [<c01a9256>] sysfs_create_dir+0x36/0xa0 (20)
 [<c0232552>] driver_probe_device+0x32/0x80 (36)
 [<c02326b2>] driver_attach+0x52/0xa0 (20)
 [<c0232c37>] bus_add_driver+0x97/0xe0 (32)
 [<e083d05f>] ide_cdrom_init+0xf/0x20 [ide_cd] (32)
 [<c013ff97>] sys_init_module+0x157/0x240 (8)
 [<c010320b>] sysenter_past_esp+0x54/0x75 (28)
---------------------------
| preempt count: 10000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<c032a3c9>] .... _raw_spin_lock+0x19/0x90
.....[<00000000>] ..   ( <= 0x0)
.. [<c013b544>] .... print_traces+0x14/0x40
.....[<00000000>] ..   ( <= 0x0)

BUG: modprobe/1342, lock held at task exit time!
 [c03d3e00] {(struct rw_semaphore *)(&s->rwsem)}
.. held by:          modprobe: 1342 [de83e920, 125]
... acquired at:  bus_add_driver+0x8f/0xe0
BUG: scheduling while atomic: modprobe/0x00000001/1342
caller is do_exit+0x261/0x420
 [<c032782b>] __schedule+0x52b/0x920 (8)
 [<c0120181>] do_exit+0x261/0x420 (8)
 [<c0232c2f>] bus_add_driver+0x8f/0xe0 (52)
 [<c0120181>] do_exit+0x261/0x420 (32)
 [<c0104950>] do_invalid_op+0x0/0xb0 (32)
 [<c01045bc>] die+0x18c/0x190 (8)
 [<c01049f6>] do_invalid_op+0xa6/0xb0 (60)
 [<c025cf63>] ide_do_request+0x3a3/0x3d0 (76)
 [<c011d7a9>] release_console_sem+0x79/0xe0 (4)
 [<c011d7a9>] release_console_sem+0x79/0xe0 (20)
 [<c011d585>] vprintk+0x185/0x270 (28)
 [<c032a802>] _raw_spin_unlock+0x12/0x30 (20)
 [<c0101940>] __switch_to+0x30/0x200 (16)
 [<c0103d5f>] error_code+0x4f/0x54 (36)
 [<c025cf63>] ide_do_request+0x3a3/0x3d0 (44)
 [<c025d691>] ide_do_drive_cmd+0x121/0x190 (44)
 [<c0101940>] __switch_to+0x30/0x200 (116)
 [<e0839b8a>] cdrom_queue_packet_command+0x4a/0xd0 [ide_cd] (120)
 [<c0117490>] default_wake_function+0x0/0x30 (20)
 [<c012f195>] queue_work+0x55/0xa0 (12)
 [<c012f0b0>] call_usermodehelper+0x160/0x180 (28)
 [<e083b516>] ide_cdrom_packet+0xb6/0x100 [ide_cd] (36)
 [<c023a4e0>] blk_end_sync_rq+0x0/0x30 (152)
 [<e083be1b>] ide_cdrom_get_capabilities+0x9b/0xb0 [ide_cd] (36)
 [<e083bede>] ide_cdrom_probe_capabilities+0xae/0x4e0 [ide_cd] (92)
 [<e083c7bc>] ide_cdrom_setup+0x2ac/0x460 [ide_cd] (68)
 [<e083ceea>] ide_cd_probe+0x14a/0x2b0 [ide_cd] (32)
 [<c032a802>] _raw_spin_unlock+0x12/0x30 (28)
 [<c01e8010>] kobject_hotplug+0x2a0/0x2f0 (20)
 [<c01a9256>] sysfs_create_dir+0x36/0xa0 (20)
 [<c0232552>] driver_probe_device+0x32/0x80 (36)
 [<c02326b2>] driver_attach+0x52/0xa0 (20)
 [<c0232c37>] bus_add_driver+0x97/0xe0 (32)
 [<e083d05f>] ide_cdrom_init+0xf/0x20 [ide_cd] (32)
 [<c013ff97>] sys_init_module+0x157/0x240 (8)
 [<c010320b>] sysenter_past_esp+0x54/0x75 (28)
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<c032a3c9>] .... _raw_spin_lock+0x19/0x90
.....[<00000000>] ..   ( <= 0x0)
.. [<c013b544>] .... print_traces+0x14/0x40
.....[<00000000>] ..   ( <= 0x0)


--------------070006010705000408090607--
