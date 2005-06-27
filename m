Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261647AbVF0Szx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261647AbVF0Szx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 14:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261614AbVF0Syw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 14:54:52 -0400
Received: from wproxy.gmail.com ([64.233.184.196]:64376 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261591AbVF0SwR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 14:52:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ZijQVMA8itSaJBPMoJ7P2pcdHh/m4CiicnltMkhLT4eyFbRl2O/fbgDF++aG1lB1zjOHYA/8s3UFUIskMCmoYPCOXHEms5tONFP0/JCmx2JS0ahP5ESj1aml6tkRiHDvieqZp/X6EtRpLL4UMBBhVyOgpyszHctazsSSALoa9JA=
Message-ID: <3642108305062711524e1e163@mail.gmail.com>
Date: Mon, 27 Jun 2005 11:52:16 -0700
From: Jim serio <jseriousenet@gmail.com>
Reply-To: Jim serio <jseriousenet@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.X not recognizing second CPU
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an Intel SAI2 with 2 P3 1.0Ghz CPUs installed. BIOS is up to
date and recognizes both CPUs. I installed RHEL4 which comes with
2.6.9-11 and, while it seems to recognize both CPUs, I get an error
saying "CPU #0 not responding. Cannot use it". I tried 2.6.10, 11 and
12 with the same bad luck. For kicks, I tried 2.4.29 and it recognizes
both CPUs. Googling and searching the kernel archives revelaed a few
others with this same problem but no solutions. I tried disabling HUGE
memory support (PAE). Tried noapic and force=acpi (together and
separately). If anyone has some suggestions on how to resolve this
issue, I would appreciate it.

Jim

Attached is the output of dmesg and cpuinfo for 2.6.12 .

----- dmesg -----
ACPI: IOAPIC (id[0x02] address[0xfec01000] gsi_base[16])
IOAPIC[1]: apic_id 2, version 17, address 0xfec01000, GSI 16-31
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Kernel command line: ro root=LABEL=/ rhgb quiet
Initializing CPU#0
CPU 0 irqstacks, hard=c03db000 soft=c03bb000
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 997.609 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1033672k/1048512k available (1824k kernel code, 14108k
reserved, 744k data, 176k init, 131008k highmem)
Calibrating delay loop... 1974.27 BogoMIPS (lpj=987136)
Security Scaffold v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
There is already a security framework initialized, register_security failed.
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0387fbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  0387fbff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU serial number disabled.
CPU: After all inits, caps:        0383f3ff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel Pentium III (Coppermine) stepping 0a
per-CPU timeslice cutoff: 731.70 usecs.
task migration cache decay timeout: 1 msecs.
Booting processor 1/0 eip 3000
CPU 1 irqstacks, hard=c03dc000 soft=c03bc000
Not responding.
Inquiring remote APIC #0...
... APIC #0 ID: 00000000
... APIC #0 VERSION: 00040011
... APIC #0 SPIV: 000000ff
CPU #0 not responding - cannot use it.
Total of 1 processors activated (1974.27 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ...  failed.
...trying to set up timer as Virtual Wire IRQ... works.
Brought up 1 CPUs
zapping low mappings.
checking if image is initramfs... it is
Freeing initrd memory: 484k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd9f0, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040816
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:0f.1
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Root Bridge [PCI1] (00:01)
PCI: Probing PCI hardware (bus 01)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI1._PRT]
ACPI: PCI Interrupt Link [IR1] (IRQs 5 10 11) *9
ACPI: PCI Interrupt Link [LN0E] (IRQs *14)
ACPI: PCI Interrupt Link [LN0F] (IRQs *15)
ACPI: PCI Interrupt Link [LN12] (IRQs *18)
ACPI: PCI Interrupt Link [LN13] (IRQs *19)
ACPI: PCI Interrupt Link [LN14] (IRQs *20)
ACPI: PCI Interrupt Link [LN15] (IRQs *21)
ACPI: PCI Interrupt Link [LN17] (IRQs *23)
ACPI: PCI Interrupt Link [LN18] (IRQs *24)
ACPI: PCI Interrupt Link [LN19] (IRQs *25)
ACPI: PCI Interrupt Link [LN1A] (IRQs *26)
ACPI: PCI Interrupt Link [LN1B] (IRQs *27)
ACPI: PCI Interrupt Link [LN1C] (IRQs *28)
ACPI: PCI Interrupt Link [LN1D] (IRQs *29)
Linux Plug and Play Support v0.97 (c) Adam Belay
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
ACPI: PCI interrupt 0000:00:08.0[A] -> GSI 24 (level, low) -> IRQ 169
ACPI: PCI interrupt 0000:00:09.0[A] -> GSI 25 (level, low) -> IRQ 177
ACPI: PCI Interrupt Link [IR1] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:0f.2[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:01:0a.0[A] -> GSI 20 (level, low) -> IRQ 185
ACPI: PCI interrupt 0000:01:0a.1[A] -> GSI 20 (level, low) -> IRQ 185
ACPI: PCI interrupt 0000:01:0b.0[A] -> GSI 21 (level, low) -> IRQ 193
Simple Boot Flag at 0x7d set to 0x1
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
audit: initializing netlink socket (disabled)
audit(1119541327.945:0): initialized
highmem bounce pool size: 64 pages
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
ksign: Installing public key data
Loading keyring
- Added public key D67B3E6B1ED6FEC7
- User ID: Red Hat, Inc. (Kernel Module GPG key)
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI: Processor [CPU0] (supports C1)
ACPI: Processor [CPU1] (supports C1)
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Maximum main memory to use for agp memory: 941M
agpgart: unable to determine aperture size.
agpgart: agp_backend_initialize() failed.
agpgart-serverworks: probe of 0000:00:00.0 failed with error -22
agpgart: Maximum main memory to use for agp memory: 941M
agpgart: unable to determine aperture size.
agpgart: agp_backend_initialize() failed.
agpgart-serverworks: probe of 0000:00:00.1 failed with error -22
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
divert: not allocating divert_blk for non-ethernet device lo
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PDC20269: IDE controller at PCI slot 0000:00:08.0
ACPI: PCI interrupt 0000:00:08.0[A] -> GSI 24 (level, low) -> IRQ 169
PDC20269: chipset revision 2
PDC20269: 100% native mode on irq 169
    ide2: BM-DMA at 0x2400-0x2407, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x2408-0x240f, BIOS settings: hdg:pio, hdh:pio
Probing IDE interface ide2...
hde: Maxtor 6Y250P0, ATA DISK drive
Using cfq io scheduler
ide2 at 0x2440-0x2447,0x2436 on irq 169
Probing IDE interface ide3...
hdg: Maxtor 6Y250P0, ATA DISK drive
ide3 at 0x2438-0x243f,0x2432 on irq 169
PDC20269: IDE controller at PCI slot 0000:00:09.0
ACPI: PCI interrupt 0000:00:09.0[A] -> GSI 25 (level, low) -> IRQ 177
PDC20269: chipset revision 2
PDC20269: 100% native mode on irq 177
    ide4: BM-DMA at 0x2410-0x2417, BIOS settings: hdi:pio, hdj:pio
    ide5: BM-DMA at 0x2418-0x241f, BIOS settings: hdk:pio, hdl:pio
Probing IDE interface ide4...
hdi: Maxtor 6Y250P0, ATA DISK drive
ide4 at 0x2458-0x245f,0x244e on irq 177
Probing IDE interface ide5...
hdk: Maxtor 6B250R0, ATA DISK drive
ide5 at 0x2450-0x2457,0x244a on irq 177
SvrWks CSB5: IDE controller at PCI slot 0000:00:0f.1
SvrWks CSB5: chipset revision 147
SvrWks CSB5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x2420-0x2427, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x2428-0x242f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: Maxtor 6B080P0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: SAMSUNG CDRW/DVD SM-308B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hde: max request size: 1024KiB
hde: 490234752 sectors (251000 MB) w/7936KiB Cache, CHS=30515/255/63, UDMA(133)
hde: cache flushes supported
 hde:
hdg: max request size: 1024KiB
hdg: 490234752 sectors (251000 MB) w/7936KiB Cache, CHS=30515/255/63, UDMA(133)
hdg: cache flushes supported
 hdg:
hdi: max request size: 1024KiB
hdi: 490234752 sectors (251000 MB) w/7936KiB Cache, CHS=30515/255/63, UDMA(133)
hdi: cache flushes supported
 hdi:
hdk: max request size: 1024KiB
hdk: 490234752 sectors (251000 MB) w/16384KiB Cache, CHS=30515/255/63, UDMA(133)
hdk: cache flushes supported
 hdk:
hda: max request size: 128KiB
hda: 160086528 sectors (81964 MB) w/8192KiB Cache, CHS=65535/16/63, UDMA(33)
hda: cache flushes supported
 hda: hda1 hda2 hda3
hdc: ATAPI 32X DVD-ROM CD-R/RW drive, 2048kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 64Kbytes
TCP: Hash tables configured (established 131072 bind 43690)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S1 S4 S5)
ACPI wakeup devices: 
PCI0  RTC COMA LAN0 USB0 PCI1 
Freeing unused kernel memory: 176k freed
SCSI subsystem initialized
ACPI: PCI interrupt 0000:01:0a.0[A] -> GSI 20 (level, low) -> IRQ 185
sym0: <1010-33> rev 0x1 at pci 0000:01:0a.0 irq 185
sym0: using 64 bit DMA addressing
sym0: No NVRAM, ID 7, Fast-80, LVD, parity checking
sym0: SCSI BUS has been reset.
scsi0 : sym-2.1.18j
  Vendor: EXABYTE   Model: VXA 1x10 1U       Rev: A102
  Type:   Medium Changer                     ANSI SCSI revision: 04
 target0:0:2: Beginning Domain Validation
 target0:0:2: Domain Validation skipping write tests
 target0:0:2: Ending Domain Validation
  Vendor: EXABYTE   Model: VXA-2             Rev: 2100
  Type:   Sequential-Access                  ANSI SCSI revision: 02
 target0:0:3: Beginning Domain Validation
sym0:3: wide asynchronous.
sym0:3: FAST-40 WIDE SCSI 80.0 MB/s ST (25.0 ns, offset 30)
 target0:0:3: Domain Validation skipping write tests
 target0:0:3: Ending Domain Validation
ACPI: PCI interrupt 0000:01:0a.1[A] -> GSI 20 (level, low) -> IRQ 185
sym1: <1010-33> rev 0x1 at pci 0000:01:0a.1 irq 185
sym1: using 64 bit DMA addressing
sym1: No NVRAM, ID 7, Fast-80, LVD, parity checking
sym1: SCSI BUS has been reset.
scsi1 : sym-2.1.18j
  Vendor: EXABYTE   Model: VXA AutoPak 1x10  Rev: E36r
  Type:   Medium Changer                     ANSI SCSI revision: 02
 target1:0:5: Beginning Domain Validation
 target1:0:5: Ending Domain Validation
  Vendor: ECRIX     Model: VXA-1             Rev: 1100
  Type:   Sequential-Access                  ANSI SCSI revision: 02
 target1:0:6: Beginning Domain Validation
sym1:6: wide asynchronous.
sym1:6: FAST-40 WIDE SCSI 80.0 MB/s ST (25.0 ns, offset 30)
 target1:0:6: Domain Validation skipping write tests
 target1:0:6: Ending Domain Validation
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
Attached scsi generic sg0 at scsi0, channel 0, id 2, lun 0,  type 8
Attached scsi generic sg1 at scsi0, channel 0, id 3, lun 0,  type 1
Attached scsi generic sg2 at scsi1, channel 0, id 5, lun 0,  type 8
Attached scsi generic sg3 at scsi1, channel 0, id 6, lun 0,  type 1
st: Version 20040403, fixed bufsize 32768, s/g segs 256
Attached scsi tape st0 at scsi0, channel 0, id 3, lun 0
st0: try direct i/o: yes (alignment 512 B), max page reachable by HBA 268435455
Attached scsi tape st1 at scsi1, channel 0, id 6, lun 0
st1: try direct i/o: yes (alignment 512 B), max page reachable by HBA 268435455
inserting floppy driver for 2.6.9-11.ELsmp
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
ACPI: PCI interrupt 0000:01:0b.0[A] -> GSI 21 (level, low) -> IRQ 193
ACPI: PCI interrupt 0000:01:0b.0[A] -> GSI 21 (level, low) -> IRQ 193
divert: allocating divert_blk for eth0
eth0: SK-9821 V2.0 Gigabit Ethernet 10/100/1000Base-T Adapter
      PrefPort:A  RlmtMode:Check Link State
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI interrupt 0000:00:0f.2[A] -> GSI 11 (level, low) -> IRQ 11
ohci_hcd 0000:00:0f.2: OHCI Host Controller
ohci_hcd 0000:00:0f.2: irq 11, pci mem f8820000
ohci_hcd 0000:00:0f.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET: Registered protocol family 10
Disabled Privacy Extensions on device c03356c0(lo)
IPv6 over IPv4 tunneling driver
divert: not allocating divert_blk for non-ethernet device sit0
mtrr: Serverworks LE detected. Write-combining disabled.
mtrr: your processor doesn't support write-combining
mtrr: Serverworks LE detected. Write-combining disabled.
mtrr: your processor doesn't support write-combining
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (FF) [SLPF]
EXT3 FS on hda3, internal journal
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm@uk.sistina.com
cdrom: open failed.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 2096472k swap on /dev/hda2.  Priority:-1 extents:1
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (8191 buckets, 65528 max) - 340 bytes per conntrack
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        none
    irq moderation:  disabled
    scatter-gather:  enabled
i2c /dev entries driver
eth0: no IPv6 routers present
mtrr: Serverworks LE detected. Write-combining disabled.
mtrr: your processor doesn't support write-combining
mtrr: Serverworks LE detected. Write-combining disabled.
mtrr: your processor doesn't support write-combining
sym0:2:0: ABORT operation started.
sym0:2:control msgout: 80 6.
sym0:2:0: ABORT operation complete.
sym0: unexpected disconnect
sym0:2:0: DEVICE RESET operation started.
sym0:2:0: DEVICE RESET operation complete.
sym0:2:control msgout: c.
sym0: TARGET 2 has been reset.
sym0:2:0: ABORT operation started.
sym0:2:0: ABORT operation complete.
sym0:2:0: BUS RESET operation started.
sym0:2:0: BUS RESET operation complete.
sym0: SCSI BUS reset detected.
sym0: SCSI BUS has been reset.
st0: Block limits 1 - 245760 bytes.
sym0:2:0: ABORT operation started.
sym0:2:control msgout: 80 6.
sym0:2:0: ABORT operation complete.
sym0: unexpected disconnect
sym0:2:0: DEVICE RESET operation started.
sym0:2:0: DEVICE RESET operation complete.
sym0:2:control msgout: c.
sym0: TARGET 2 has been reset.
sym0:2:0: ABORT operation started.
sym0:2:0: ABORT operation complete.
sym0:2:0: BUS RESET operation started.
sym0:2:0: BUS RESET operation complete.
sym0: SCSI BUS reset detected.
sym0: SCSI BUS has been reset.
st1: Block limits 1 - 245760 bytes.
sym0:2:0: ABORT operation started.
sym0:2:control msgout: 80 6.
sym0:2:0: ABORT operation complete.
sym0: unexpected disconnect
sym0:2:0: DEVICE RESET operation started.
sym0:2:0: DEVICE RESET operation complete.
sym0:2:control msgout: c.
sym0: TARGET 2 has been reset.
sym0:2:0: ABORT operation started.
sym0:2:0: ABORT operation complete.
sym0:2:0: BUS RESET operation started.
sym0:2:0: BUS RESET operation complete.
sym0: SCSI BUS reset detected.
sym0: SCSI BUS has been reset.
-----


----- cpuinfo -----
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 10
cpu MHz		: 997.609
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca cmov pat
pse36 mmx fxsr sse
bogomips	: 1974.27
-----
