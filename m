Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281908AbRLLFKW>; Wed, 12 Dec 2001 00:10:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281915AbRLLFKT>; Wed, 12 Dec 2001 00:10:19 -0500
Received: from 210-86-49-187.jetstart.xtra.co.nz ([210.86.49.187]:3968 "EHLO
	albatross.hisdad.org.nz") by vger.kernel.org with ESMTP
	id <S281908AbRLLFKG>; Wed, 12 Dec 2001 00:10:06 -0500
Subject: RE: [2.4.16 bug] Major failure
From: John Huttley <john@mwk.co.nz>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>,
        "Acpi-linux (E-mail 2)" <acpi-devel@lists.sourceforge.net>
In-Reply-To: <59885C5E3098D511AD690002A5072D3C42D7E1@orsmsx111.jf.intel.com>
In-Reply-To: <59885C5E3098D511AD690002A5072D3C42D7E1@orsmsx111.jf.intel.com>
Content-Type: multipart/mixed; boundary="=-HTtTeqqmJVm+ygvY/340"
X-Mailer: Evolution/1.0 (Preview Release)
Date: 12 Dec 2001 18:09:46 +1300
Message-Id: <1008133789.1367.0.camel@albatross.hisdad.org.nz>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-HTtTeqqmJVm+ygvY/340
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2001-12-12 at 10:16, Grover, Andrew wrote:
> > From: John Huttley [mailto:john@mwk.co.nz]
> > The video card is a GA-660, which is a TNT2 using the Xfree driver.
> > I have tried a 2.4.17-pre8 kernel with power management switched off.
> > There were no problems with this! It works just fine.
> > I subsequently tried a kernel with the ACPI drivers compiled in.
> > The system booted ok, but rather coming up with gdm, it gave
> > a part lit screen with no visible raster.
> 

Call this config 'B', as it was the second deader.


> Hi John,
> 
> What is this system? A desktop? What is the motherboard?

This is a gigabyte GA-6BXDS, BX chipset, 2x PIII cpus plus 7895 scsi.
The scsi is used for the cdrom and the tape drive.
An oldy but a goody. 


> Please send me the output from:
> - dmesg
> - /proc/interrupts
> - /proc/ioports
> - /proc/iomem
> - the output from /proc/acpi/dsdt (if possible) or get pmtools from
> http://developer.intel.com/technology/iapc/acpi/downloads.htm and please
> provide the output from acpidmp.
> 
> Thanks -- Regards -- Andy
> 
> PS you may also want to try the latest ACPI patch from that same site, but
> my guess is it will not solve your problem.

Hello Andy,

Please find attached the proc info, dmesg and the config.
This is the original failed configuration where the acpi
is compiled as modules. Call it Config 'A'. I'm going to try a few more
configs, so there may be other failures.

This system boots to run level 5.

The failure mode is:

* Switch to VC1 and start a 'tar' to the tape drive.

* Switch to X.

* Switch to VC1 to review the progress of the 'tar' and the system locks
solid. No ping either.


Please cc' me on any reply as I am not on the list.

Thank you for your interest,

Regards
John






--=-HTtTeqqmJVm+ygvY/340
Content-Disposition: attachment; filename=dmesg
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ISO-8859-1

Linux version 2.4.17-pre8 (root@albatross.hisdad.org.nz) (gcc version 2.96 =
20000731 (Red Hat Linux 7.1 2.96-98)) #2 SMP Tue Dec 11 16:38:47 NZDT 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000002fff0000 (usable)
 BIOS-e820: 000000002fff0000 - 000000002fff3000 (ACPI NVS)
 BIOS-e820: 000000002fff3000 - 0000000030000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
found SMP MP-table at 000f5b40
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
On node 0 totalpages: 196592
zone(0): 4096 pages.
zone(1): 192496 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #0 Pentium(tm) Pro APIC version 17
Processor #1 Pentium(tm) Pro APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Processors: 2
Kernel command line: auto BOOT_IMAGE=3D2.4.17-pre8 ro root=3D305 BOOT_FILE=
=3D/boot/vmlinuz-2.4.17-pre8 hdc=3Dide-scsi
ide_setup: hdc=3Dide-scsi
Initializing CPU#0
Detected 448.811 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 894.56 BogoMIPS
Memory: 771416k/786368k available (1296k kernel code, 14568k reserved, 338k=
 data, 220k init, 0k highmem)
Dentry-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor =3D 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor =3D 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU0: Intel Pentium III (Katmai) stepping 03
per-CPU timeslice cutoff: 1464.52 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 894.56 BogoMIPS
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor =3D 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
Intel machine check reporting enabled on CPU#1.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU1: Intel Pentium III (Katmai) stepping 02
Total of 2 processors activated (1789.13 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-18, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=3D0x31 pin1=3D2 pin2=3D0
number of MP IRQ sources: 22.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:  =20
 00 000 00  1    0    0   0   0    0    0    00
 01 003 03  0    0    0   0   0    1    1    39
 02 003 03  0    0    0   0   0    1    1    31
 03 003 03  0    0    0   0   0    1    1    41
 04 003 03  0    0    0   0   0    1    1    49
 05 003 03  0    0    0   0   0    1    1    51
 06 003 03  0    0    0   0   0    1    1    59
 07 003 03  0    0    0   0   0    1    1    61
 08 003 03  0    0    0   0   0    1    1    69
 09 003 03  0    0    0   0   0    1    1    71
 0a 003 03  0    0    0   0   0    1    1    79
 0b 003 03  0    0    0   0   0    1    1    81
 0c 003 03  0    0    0   0   0    1    1    89
 0d 003 03  0    0    0   0   0    1    1    91
 0e 003 03  0    0    0   0   0    1    1    99
 0f 003 03  0    0    0   0   0    1    1    A1
 10 003 03  1    1    0   1   0    1    1    A9
 11 003 03  1    1    0   1   0    1    1    B1
 12 000 00  1    0    0   0   0    0    0    00
 13 003 03  1    1    0   1   0    1    1    B9
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ19 -> 0:19
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 448.8108 MHz.
..... host bus clock speed is 99.7355 MHz.
cpu: 0, clocks: 997355, slice: 332451
CPU0<T0:997344,T1:664880,D:13,S:332451,C:997355>
cpu: 1, clocks: 997355, slice: 332451
CPU1<T0:997344,T1:332432,D:10,S:332451,C:997355>
checking TSC synchronization across CPUs: passed.
Waiting on wait_init_idle (map =3D 0x2)
All processors have done init_idle
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: probably your BIOS does not setup all CPUs
PCI: PCI BIOS revision 2.10 entry at 0xfb290, last bus=3D1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
PCI->APIC IRQ transform: (B0,I7,P3) -> 19
PCI->APIC IRQ transform: (B0,I9,P0) -> 17
PCI->APIC IRQ transform: (B0,I12,P0) -> 16
PCI->APIC IRQ transform: (B0,I12,P1) -> 16
PCI->APIC IRQ transform: (B1,I0,P0) -> 16
Limiting direct PCI/PCI transfers.
isapnp: Scanning for PnP cards...
isapnp: Calling quirk for 01:00
isapnp: SB audio device quirk - increasing port range
isapnp: Calling quirk for 01:02
isapnp: AWE32 quirk - adding two ports
isapnp: Card 'Creative SB AWE64  PnP'
isapnp: 1 Plug & Play card detected total
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
Journalled Block Device driver loaded
    ACPI-0454: *** Warning: Reference FAN_ at AML BDB not found
    ACPI-0454: *** Warning: Reference \_PR_.CPU0 at AML C06 not found
ACPI: Core Subsystem version [20011018]
ACPI: Subsystem enabled
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_P=
CI ISAPNP enabled
ttyS00 at 0x03f8 (irq =3D 4) is a 16550A
ttyS01 at 0x02f8 (irq =3D 3) is a 16550A
block: 128 slots per queue, batch=3D32
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: ST340823A, ATA DISK drive
hdc: SONY CD-RW CRX140E, ATAPI CD/DVD-ROM drive
hdd: ST320423A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 78165360 sectors (40021 MB) w/512KiB Cache, CHS=3D4865/255/63, UDMA(33=
)
hdd: 40011300 sectors (20486 MB) w/512KiB Cache, CHS=3D39693/16/63, UDMA(33=
)
Partition check:
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 >
 hdd: [PTBL] [2490/255/63] hdd1
loop: loaded (max 8 devices)
SCSI subsystem driver Revision: 1.00
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.4
        <Adaptec aic7895 Ultra SCSI adapter>
        aic7895C: Ultra Wide Channel A, SCSI Id=3D7, 32/253 SCBs

scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.4
        <Adaptec aic7895 Ultra SCSI adapter>
        aic7895C: Ultra Wide Channel B, SCSI Id=3D7, 32/253 SCBs

  Vendor: PLEXTOR   Model: CD-ROM PX-20TS    Rev: 1.00
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: HP        Model: C5683A            Rev: C908
  Type:   Sequential-Access                  ANSI SCSI revision: 02
scsi2 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: SONY      Model: CD-RW  CRX140E    Rev: 1.0s
  Type:   CD-ROM                             ANSI SCSI revision: 02
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
ds: no socket drivers loaded!
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 220k freed
Real Time Clock Driver v1.10e
Adding Swap: 265032k swap-space (priority -1)
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,5), internal journal
usb-uhci.c: $Revision: 1.268 $ time 16:51:17 Dec 11 2001
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: USB UHCI at I/O 0xe000, IRQ 19
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.268:USB Universal Host Controller Interface driver
usb.c: USB disconnect on device 1
hub.c: get_port_status(2) failed (err =3D -19)
hub.c: get_port_status(2) failed (err =3D -19)
hub.c: get_port_status(2) failed (err =3D -19)
hub.c: get_port_status(2) failed (err =3D -19)
hub.c: get_port_status(2) failed (err =3D -19)
hub.c: Cannot enable port 2 of hub 1, disabling port.
hub.c: Maybe the USB cable is bad?
hub.c: cannot disable port 2 of hub 1 (err =3D -19)
hub.c: get_hub_status failed
usb.c: USB bus 1 deregistered
usb-uhci.c: $Revision: 1.268 $ time 16:51:17 Dec 11 2001
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: USB UHCI at I/O 0xe000, IRQ 19
usb-uhci.c: Detected 2 ports
inserting floppy driver for 2.4.17-pre8
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.268:USB Universal Host Controller Interface driver
usb.c: registered new driver hid
hid-core.c: v1.8 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
usb.c: registered new driver usblp
printer.c: v0.8:USB Printer Device Class driver
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 5, lun 0
Attached scsi CD-ROM sr1 at scsi2, channel 0, id 0, lun 0
(scsi0:A:5): 10.000MB/s transfers (10.000MHz, offset 15)
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.12
sr1: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
Universal TUN/TAP device driver 1.4 (C)1999-2001 Maxim Krasnyansky
ACPI: System firmware supports S0 S1 S5
ACPI: Power Button (FF) found
ACPI: Multiple power buttons detected, ignoring fixed-feature
ACPI: Power Button (CM) found
Processor[0]: C0 C1
Processor[1]: C0 C1
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
hub.c: USB new device connect on bus1/2, assigned device number 2
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,7), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
usb-uhci.c: interrupt, status 3, frame# 784
input0: USB HID v1.00 Mouse [Microsoft Microsoft IntelliMouse =AE with Inte=
lliEye] on usb1:2.0
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,6), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
reiserfs: checking transaction log (device 03:09) ...
Using r5 hash to sort names
reiserfs: using 3.5.x disk format
ReiserFS version 3.6.25
st: Version 20011103, bufsize 32768, wrt 30720, max init. bufs 4, s/g segs =
16
Attached scsi tape st0 at scsi1, channel 0, id 6, lun 0
parport0: PC-style at 0x378 (0x778) [PCSPP(,...)]
parport0: irq 7 detected
Linux Tulip driver version 0.9.15-pre9 (Nov 6, 2001)
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media 10baseT (#0) described by a 21142 Serial PHY (2) =
block.
tulip0:  Index #1 - Media 10baseT-FDX (#4) described by a 21142 Serial PHY =
(2) block.
tulip0:  Index #2 - Media 100baseTx (#3) described by a 21143 SYM PHY (4) b=
lock.
tulip0:  Index #3 - Media 100baseTx-FDX (#5) described by a 21143 SYM PHY (=
4) block.
eth0: Digital DS21143 Tulip rev 48 at 0xe400, 00:C0:F6:B0:E0:AC, IRQ 17.

--=-HTtTeqqmJVm+ygvY/340
Content-Disposition: attachment; filename=config
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ISO-8859-1

#
# Automatically generated by make menuconfig: don't edit
#
CONFIG_X86=3Dy
CONFIG_ISA=3Dy
# CONFIG_SBUS is not set
CONFIG_UID16=3Dy

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=3Dy

#
# Loadable module support
#
CONFIG_MODULES=3Dy
# CONFIG_MODVERSIONS is not set
CONFIG_KMOD=3Dy

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
CONFIG_MPENTIUMIII=3Dy
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
CONFIG_X86_WP_WORKS_OK=3Dy
CONFIG_X86_INVLPG=3Dy
CONFIG_X86_CMPXCHG=3Dy
CONFIG_X86_XADD=3Dy
CONFIG_X86_BSWAP=3Dy
CONFIG_X86_POPAD_OK=3Dy
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy
CONFIG_X86_L1_CACHE_SHIFT=3D5
CONFIG_X86_TSC=3Dy
CONFIG_X86_GOOD_APIC=3Dy
CONFIG_X86_PGE=3Dy
CONFIG_X86_USE_PPRO_CHECKSUM=3Dy
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
CONFIG_NOHIGHMEM=3Dy
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=3Dy
CONFIG_SMP=3Dy
# CONFIG_MULTIQUAD is not set
CONFIG_HAVE_DEC_LOCK=3Dy

#
# General setup
#
CONFIG_NET=3Dy
CONFIG_X86_IO_APIC=3Dy
CONFIG_X86_LOCAL_APIC=3Dy
CONFIG_PCI=3Dy
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=3Dy
CONFIG_PCI_BIOS=3Dy
CONFIG_PCI_DIRECT=3Dy
CONFIG_PCI_NAMES=3Dy
# CONFIG_EISA is not set
# CONFIG_MCA is not set
CONFIG_HOTPLUG=3Dy

#
# PCMCIA/CardBus support
#
CONFIG_PCMCIA=3Dy
CONFIG_CARDBUS=3Dy
# CONFIG_I82092 is not set
# CONFIG_I82365 is not set
# CONFIG_TCIC is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set
# CONFIG_HOTPLUG_PCI_COMPAQ is not set
# CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM is not set
CONFIG_SYSVIPC=3Dy
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=3Dy
CONFIG_KCORE_ELF=3Dy
# CONFIG_KCORE_AOUT is not set
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_ELF=3Dy
CONFIG_BINFMT_MISC=3Dy
CONFIG_PM=3Dy
CONFIG_ACPI=3Dy
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUSMGR=3Dm
CONFIG_ACPI_SYS=3Dm
CONFIG_ACPI_CPU=3Dm
CONFIG_ACPI_BUTTON=3Dm
# CONFIG_ACPI_AC is not set
# CONFIG_ACPI_EC is not set
# CONFIG_ACPI_CMBATT is not set
# CONFIG_ACPI_THERMAL is not set
# CONFIG_APM is not set

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
CONFIG_PARPORT_PC_SUPERIO=3Dy
# CONFIG_PARPORT_PC_PCMCIA is not set
# CONFIG_PARPORT_AMIGA is not set
# CONFIG_PARPORT_MFC3 is not set
# CONFIG_PARPORT_ATARI is not set
# CONFIG_PARPORT_GSC is not set
# CONFIG_PARPORT_SUNBPP is not set
# CONFIG_PARPORT_OTHER is not set
# CONFIG_PARPORT_1284 is not set

#
# Plug and Play configuration
#
CONFIG_PNP=3Dy
CONFIG_ISAPNP=3Dy

#
# Block devices
#
CONFIG_BLK_DEV_FD=3Dm
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
CONFIG_BLK_DEV_LOOP=3Dy
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_RAM=3Dy
CONFIG_BLK_DEV_RAM_SIZE=3D4096
CONFIG_BLK_DEV_INITRD=3Dy

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set
# CONFIG_BLK_DEV_MD is not set
# CONFIG_MD_LINEAR is not set
# CONFIG_MD_RAID0 is not set
# CONFIG_MD_RAID1 is not set
# CONFIG_MD_RAID5 is not set
# CONFIG_MD_MULTIPATH is not set
# CONFIG_BLK_DEV_LVM is not set

#
# Networking options
#
CONFIG_PACKET=3Dy
CONFIG_PACKET_MMAP=3Dy
CONFIG_NETLINK_DEV=3Dy
CONFIG_NETFILTER=3Dy
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_FILTER=3Dy
CONFIG_UNIX=3Dy
CONFIG_INET=3Dy
CONFIG_IP_MULTICAST=3Dy
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
CONFIG_INET_ECN=3Dy
CONFIG_SYN_COOKIES=3Dy

#
#   IP: Netfilter Configuration
#
# CONFIG_IP_NF_CONNTRACK is not set
# CONFIG_IP_NF_QUEUE is not set
# CONFIG_IP_NF_IPTABLES is not set
# CONFIG_IP_NF_COMPAT_IPCHAINS is not set
# CONFIG_IP_NF_COMPAT_IPFWADM is not set
# CONFIG_IPV6 is not set
# CONFIG_KHTTPD is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set
# CONFIG_PHONE_IXJ is not set
# CONFIG_PHONE_IXJ_PCMCIA is not set

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=3Dy

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=3Dy
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=3Dy
CONFIG_IDEDISK_MULTI_MODE=3Dy
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
# CONFIG_BLK_DEV_IDEDISK_FUJITSU is not set
# CONFIG_BLK_DEV_IDEDISK_IBM is not set
# CONFIG_BLK_DEV_IDEDISK_MAXTOR is not set
# CONFIG_BLK_DEV_IDEDISK_QUANTUM is not set
# CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set
# CONFIG_BLK_DEV_IDEDISK_WD is not set
# CONFIG_BLK_DEV_COMMERIAL is not set
# CONFIG_BLK_DEV_TIVO is not set
# CONFIG_BLK_DEV_IDECS is not set
# CONFIG_BLK_DEV_IDECD is not set
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
CONFIG_BLK_DEV_IDESCSI=3Dy
CONFIG_BLK_DEV_CMD640=3Dy
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
CONFIG_BLK_DEV_RZ1000=3Dy
CONFIG_BLK_DEV_IDEPCI=3Dy
CONFIG_IDEPCI_SHARE_IRQ=3Dy
CONFIG_BLK_DEV_IDEDMA_PCI=3Dy
CONFIG_BLK_DEV_ADMA=3Dy
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_IDEDMA_PCI_AUTO=3Dy
CONFIG_BLK_DEV_IDEDMA=3Dy
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_AEC62XX_TUNING is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_AMD74XX_OVERRIDE is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
CONFIG_BLK_DEV_PIIX=3Dy
CONFIG_PIIX_TUNING=3Dy
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX is not set
# CONFIG_PDC202XX_BURST is not set
# CONFIG_PDC202XX_FORCE is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=3Dy
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=3Dy
# CONFIG_BLK_DEV_ATARAID is not set
# CONFIG_BLK_DEV_ATARAID_PDC is not set
# CONFIG_BLK_DEV_ATARAID_HPT is not set

#
# SCSI support
#
CONFIG_SCSI=3Dy
# CONFIG_BLK_DEV_SD is not set
CONFIG_CHR_DEV_ST=3Dm
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=3Dm
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_SR_EXTRA_DEVS=3D2
CONFIG_CHR_DEV_SG=3Dm
CONFIG_SCSI_DEBUG_QUEUES=3Dy
# CONFIG_SCSI_MULTI_LUN is not set
CONFIG_SCSI_CONSTANTS=3Dy
# CONFIG_SCSI_LOGGING is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AHA1740 is not set
# CONFIG_SCSI_AACRAID is not set
CONFIG_SCSI_AIC7XXX=3Dy
CONFIG_AIC7XXX_CMDS_PER_DEVICE=3D253
CONFIG_AIC7XXX_RESET_DELAY_MS=3D5000
# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
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
# CONFIG_SCSI_EATA_DMA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
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
# CONFIG_SCSI_SIM710 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_DEBUG is not set

#
# PCMCIA SCSI adapter support
#
# CONFIG_SCSI_PCMCIA is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_BOOT is not set
# CONFIG_FUSION_ISENSE is not set
# CONFIG_FUSION_CTL is not set
# CONFIG_FUSION_LAN is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set
# CONFIG_I2O_PCI is not set
# CONFIG_I2O_BLOCK is not set
# CONFIG_I2O_LAN is not set
# CONFIG_I2O_SCSI is not set
# CONFIG_I2O_PROC is not set

#
# Network device support
#
CONFIG_NETDEVICES=3Dy

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=3Dm
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
CONFIG_TUN=3Dm
# CONFIG_ETHERTAP is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=3Dy
# CONFIG_SUNLANCE is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNBMAC is not set
# CONFIG_SUNQE is not set
# CONFIG_SUNLANCE is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=3Dy
# CONFIG_PCNET32 is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_CS89x0 is not set
CONFIG_TULIP=3Dm
# CONFIG_TULIP_MWI is not set
# CONFIG_TULIP_MMIO is not set
# CONFIG_DE4X5 is not set
# CONFIG_DGRS is not set
# CONFIG_DM9102 is not set
# CONFIG_EEPRO100 is not set
# CONFIG_LNE390 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_NE3210 is not set
# CONFIG_ES3210 is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_RHINE_MMIO is not set
# CONFIG_WINBOND_840 is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_MYRI_SBUS is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_SK98LIN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# PCMCIA network device support
#
CONFIG_NET_PCMCIA=3Dy
# CONFIG_PCMCIA_3C589 is not set
# CONFIG_PCMCIA_3C574 is not set
# CONFIG_PCMCIA_FMVJ18X is not set
CONFIG_PCMCIA_PCNET=3Dy
# CONFIG_PCMCIA_AXNET is not set
# CONFIG_PCMCIA_NMCLAN is not set
# CONFIG_PCMCIA_SMC91C92 is not set
# CONFIG_PCMCIA_XIRC2PS is not set
# CONFIG_ARCNET_COM20020_CS is not set
# CONFIG_PCMCIA_IBMTR is not set
# CONFIG_PCMCIA_XIRCOM is not set
# CONFIG_PCMCIA_XIRTULIP is not set
CONFIG_NET_PCMCIA_RADIO=3Dy
CONFIG_PCMCIA_RAYCS=3Dy
# CONFIG_PCMCIA_NETWAVE is not set
# CONFIG_PCMCIA_WAVELAN is not set
# CONFIG_AIRONET4500_CS is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Input core support
#
CONFIG_INPUT=3Dm
CONFIG_INPUT_KEYBDEV=3Dm
CONFIG_INPUT_MOUSEDEV=3Dm
CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1600
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D1200
CONFIG_INPUT_JOYDEV=3Dm
CONFIG_INPUT_EVDEV=3Dm

#
# Character devices
#
CONFIG_VT=3Dy
CONFIG_VT_CONSOLE=3Dy
CONFIG_SERIAL=3Dy
CONFIG_SERIAL_CONSOLE=3Dy
# CONFIG_SERIAL_ACPI is not set
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=3Dy
CONFIG_UNIX98_PTY_COUNT=3D256
# CONFIG_PRINTER is not set
# CONFIG_PPDEV is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
CONFIG_MOUSE=3Dy
CONFIG_PSMOUSE=3Dy
# CONFIG_82C710_MOUSE is not set
# CONFIG_PC110_PAD is not set

#
# Joysticks
#
# CONFIG_INPUT_GAMEPORT is not set
# CONFIG_INPUT_NS558 is not set
# CONFIG_INPUT_LIGHTNING is not set
# CONFIG_INPUT_PCIGAME is not set
# CONFIG_INPUT_CS461X is not set
# CONFIG_INPUT_EMU10K1 is not set
# CONFIG_INPUT_SERIO is not set
# CONFIG_INPUT_SERPORT is not set
# CONFIG_INPUT_ANALOG is not set
# CONFIG_INPUT_A3D is not set
# CONFIG_INPUT_ADI is not set
# CONFIG_INPUT_COBRA is not set
# CONFIG_INPUT_GF2K is not set
# CONFIG_INPUT_GRIP is not set
# CONFIG_INPUT_INTERACT is not set
# CONFIG_INPUT_TMDC is not set
# CONFIG_INPUT_SIDEWINDER is not set
# CONFIG_INPUT_IFORCE_USB is not set
# CONFIG_INPUT_IFORCE_232 is not set
# CONFIG_INPUT_WARRIOR is not set
# CONFIG_INPUT_MAGELLAN is not set
# CONFIG_INPUT_SPACEORB is not set
# CONFIG_INPUT_SPACEBALL is not set
# CONFIG_INPUT_STINGER is not set
# CONFIG_INPUT_DB9 is not set
# CONFIG_INPUT_GAMECON is not set
# CONFIG_INPUT_TURBOGRAFX is not set
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_INTEL_RNG is not set
# CONFIG_NVRAM is not set
CONFIG_RTC=3Dm
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=3Dm
CONFIG_AGP_INTEL=3Dy
# CONFIG_AGP_I810 is not set
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_DRM is not set

#
# PCMCIA character devices
#
# CONFIG_PCMCIA_SERIAL_CS is not set
# CONFIG_MWAVE is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
CONFIG_QUOTA=3Dy
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=3Dy
CONFIG_REISERFS_FS=3Dm
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BFS_FS is not set
CONFIG_EXT3_FS=3Dy
CONFIG_JBD=3Dy
# CONFIG_JBD_DEBUG is not set
CONFIG_FAT_FS=3Dm
CONFIG_MSDOS_FS=3Dm
# CONFIG_UMSDOS_FS is not set
CONFIG_VFAT_FS=3Dm
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_CRAMFS is not set
CONFIG_TMPFS=3Dy
# CONFIG_RAMFS is not set
CONFIG_ISO9660_FS=3Dm
CONFIG_JOLIET=3Dy
# CONFIG_ZISOFS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=3Dy
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=3Dy
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=3Dy
# CONFIG_SYSV_FS is not set
# CONFIG_UDF_FS is not set
# CONFIG_UDF_RW is not set
# CONFIG_UFS_FS is not set
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
CONFIG_NFS_FS=3Dm
# CONFIG_NFS_V3 is not set
# CONFIG_ROOT_NFS is not set
CONFIG_NFSD=3Dm
CONFIG_NFSD_V3=3Dy
CONFIG_SUNRPC=3Dm
CONFIG_LOCKD=3Dm
CONFIG_LOCKD_V4=3Dy
CONFIG_SMB_FS=3Dm
CONFIG_SMB_NLS_DEFAULT=3Dy
CONFIG_SMB_NLS_REMOTE=3D"cp437"
# CONFIG_NCP_FS is not set
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set
# CONFIG_ZISOFS_FS is not set
# CONFIG_ZLIB_FS_INFLATE is not set

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
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=3Dm
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ISO8859_1=3Dm
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Console drivers
#
CONFIG_VGA_CONSOLE=3Dy
# CONFIG_VIDEO_SELECT is not set
# CONFIG_MDA_CONSOLE is not set

#
# Frame-buffer support
#
# CONFIG_FB is not set

#
# Sound
#
CONFIG_SOUND=3Dm
# CONFIG_SOUND_BT878 is not set
# CONFIG_SOUND_CMPCI is not set
# CONFIG_SOUND_EMU10K1 is not set
# CONFIG_MIDI_EMU10K1 is not set
# CONFIG_SOUND_FUSION is not set
# CONFIG_SOUND_CS4281 is not set
# CONFIG_SOUND_ES1370 is not set
# CONFIG_SOUND_ES1371 is not set
# CONFIG_SOUND_ESSSOLO1 is not set
# CONFIG_SOUND_MAESTRO is not set
# CONFIG_SOUND_MAESTRO3 is not set
# CONFIG_SOUND_ICH is not set
# CONFIG_SOUND_RME96XX is not set
# CONFIG_SOUND_SONICVIBES is not set
# CONFIG_SOUND_TRIDENT is not set
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
# CONFIG_SOUND_VIA82CXXX is not set
# CONFIG_MIDI_VIA82CXXX is not set
CONFIG_SOUND_OSS=3Dm
# CONFIG_SOUND_TRACEINIT is not set
# CONFIG_SOUND_DMAP is not set
# CONFIG_SOUND_AD1816 is not set
# CONFIG_SOUND_SGALAXY is not set
# CONFIG_SOUND_ADLIB is not set
# CONFIG_SOUND_ACI_MIXER is not set
# CONFIG_SOUND_CS4232 is not set
# CONFIG_SOUND_SSCAPE is not set
# CONFIG_SOUND_GUS is not set
# CONFIG_SOUND_VMIDI is not set
# CONFIG_SOUND_TRIX is not set
# CONFIG_SOUND_MSS is not set
# CONFIG_SOUND_MPU401 is not set
# CONFIG_SOUND_NM256 is not set
# CONFIG_SOUND_MAD16 is not set
# CONFIG_SOUND_PAS is not set
# CONFIG_PAS_JOYSTICK is not set
# CONFIG_SOUND_PSS is not set
CONFIG_SOUND_SB=3Dm
CONFIG_SOUND_AWE32_SYNTH=3Dm
# CONFIG_SOUND_WAVEFRONT is not set
# CONFIG_SOUND_MAUI is not set
# CONFIG_SOUND_YM3812 is not set
# CONFIG_SOUND_OPL3SA1 is not set
# CONFIG_SOUND_OPL3SA2 is not set
# CONFIG_SOUND_YMFPCI is not set
# CONFIG_SOUND_YMFPCI_LEGACY is not set
# CONFIG_SOUND_UART6850 is not set
# CONFIG_SOUND_AEDSP16 is not set
# CONFIG_SOUND_TVMIXER is not set

#
# USB support
#
CONFIG_USB=3Dy
# CONFIG_USB_DEBUG is not set
CONFIG_USB_DEVICEFS=3Dy
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_LONG_TIMEOUT is not set
CONFIG_USB_UHCI=3Dm
# CONFIG_USB_UHCI_ALT is not set
# CONFIG_USB_OHCI is not set
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH is not set
CONFIG_USB_STORAGE=3Dm
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_HP8200e is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_ACM is not set
CONFIG_USB_PRINTER=3Dm
CONFIG_USB_HID=3Dm
# CONFIG_USB_HIDDEV is not set
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_DC2XX is not set
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_SCANNER is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_CATC is not set
# CONFIG_USB_CDCETHER is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set
# CONFIG_USB_SERIAL_GENERIC is not set
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28X is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28XA is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28XB is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA18X is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19W is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA49W is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_XIRCOM is not set
# CONFIG_USB_SERIAL_OMNINET is not set
# CONFIG_USB_RIO500 is not set

#
# Bluetooth support
#
# CONFIG_BLUEZ is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=3Dy
# CONFIG_DEBUG_HIGHMEM is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_IOVIRT is not set
CONFIG_MAGIC_SYSRQ=3Dy
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_BUGVERBOSE is not set

--=-HTtTeqqmJVm+ygvY/340
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=dsdt
Content-Transfer-Encoding: base64

RFNEVDEoAAAB4kdCVCAgIEFXUkRBQ1BJABAAAE1TRlQHAAABECxcX1BSX1uDEVwuX1BSX0NQVV8A
AAAAAABbgxFcLl9QUl9DUFUxAQAAAAAACFxfUzBfEgoECgUKBQoFCgUIXF9TMV8SCgQKBAoECgQK
BAhcX1M1XxIGBAAAAABbgFxERUJHAQqACgFbgQxcREVCRwFEQkcxCFuAQ01PUwEKcAoCW4EQQ01P
UwFJTlhfCERUQV8IW4BFWFRNAAww+A8AChBbgSlFWFRNAlJPTTEQUk1TMRBST00yEFJNUzIQUk9N
MxBSTVMzEEFNRU0gW4BWR0FNAAwCAAwACgFbgQtWR0FNAVZHQTEIW4BcU01JQwEKsgoBW4EMXFNN
SUMBU0NQXwhbgFxUUkFQAQsvQAoBW4EOXFRSQVABAAFUUjEzAVuAXEdCTEUBCyFACgFbgQxcR0JM
RQFFU01JCAhDTURCEQMKCIxDTURCCgBCWVQwjENNREIKAUJZVDGMQ01EQgoCQllUMoxDTURCCgNC
WVQzjENNREIKBEJZVDSMQ01EQgoFQllUNYxDTURCCgZCWVQ2jENNREIKB0JZVDcISURFQhEDCjhb
E0lERUIKAAo4Q01EMFsTSURFQgo4CjhDTUQxWxNJREVCCnAKOENNRDJbE0lERUIKqAo4Q01EM1sT
SURFQgrgCjhDTUQ0WxNJREVCCxgBCjhDTUQ1WxNJREVCC1ABCjhDTUQ2WxNJREVCC4gBCjhDTUQ3
W4BBUE1QAQqyCgJbgRBBUE1QAUFQTUMIQVBNRAhbgEVMQ1IBC9AECgJbgRBFTENSAUVMQzEIRUxD
MghbgEdQT0IBCzRACgRbgUcKR1BPQgFHUDAwAUdQMDEBR1AwMgFHUDAzAUdQMDQBR1AwNQFHUDA2
AUdQMDcBR1AwOAFHUDA5AUdQMEEBR1AwQgFHUDBDAUdQMEQBR1AwRQFHUDBGAUdQMTABR1AxMQFH
UDEyAUdQMTMBR1AxNAFHUDE1AUdQMTYBR1AxNwFHUDE4AUdQMTkBR1AxQQFHUDFCAUdQMUMBR1Ax
RAFHUDFFAUdQMUYBCE9TRkwKARRBBVNUUkMCoAqSk4doh2mkCgByh2gKAWAIQlVGMBECYAhCVUYx
EQJgcGhCVUYwcGlCVUYxohpgdmCgFZKTg4hCVUYwYACDiEJVRjFgAKQApAFbgFJUQ00BCnAKAluB
EFJUQ00BQ01JTghDTURBCFuGEkNNSU5DTURBAQBIB1NIVVQIW4BcR1JBTQALAAQLAAFbgRdcR1JB
TQEAQAhGTEcwCABIVFNGTEcIW4BJTkZPAAxA+A8ACgFbgRBJTkZPAUtCREkBUlRDVwFbgEJFRVAB
CmEKAVuBC0JFRVABUzFCXwhbgENPTlQBCkAKBFuBGkNPTlQBQ05UMAhDTlQxCENOVDIIQ1RSTAgU
QwZTUEtSAXBTMUJfYHAKtkNUUkxwClVDTlQycAoDQ05UMnBoYqI3lGIKAH1TMUJfCgNTMUJfcAv/
X2OiB5RjCgB2Y3tTMUJfCvxTMUJfcAv/DmOiB5RjCgB2Y3ZicGBTMUJfEBdcAAhQSUNGCgAUDF9Q
SUMBcGhQSUNGFEQFXF9QVFMBoBaTaAoFfWgKUGBwYFNDUF9wAVRSMTOgC5NoCgFwAVRSMTOgC5No
CgJwAVRSMTN9aArwYHBgREJHMaAFk2gKBKALk2gKBXABR1AxQhQbXF9XQUsBcAr/REJHMYZcLl9T
Ql9QV1JCCgIQSk5cX1NJX1uAU0lGRwAMHPgPAAoBW4ENU0lGRwFTQklUAQAHW4BJVEUxAQvwAwoC
W4EQSVRFMQFJTkRYCERBVEEIW4ZNBklORFhEQVRBAQAQQ0ZHXwgAIExETl8IAEANUE9XQwgAGFBS
RUcIAEgEQUNUUggASBdJT0FICElPQUwIAEAHSU5UUggACElOVDEIAAhETUNICABIJUdQNDAIAEgX
T1BUMQhPUFQyCE9QVDMIW4BFTkcxAQt5AgoBW4ELRU5HMQFDT05HCBRDEEVORkcAcAqGQ09OR3AK
gENPTkdwClVDT05HcApVQ09OR3AKaklORFhwCrVJTkRYcAraSU5EWHAK7UlORFhwCvZJTkRYcAr7
SU5EWHAKfUlORFhwCr5JTkRYcArfSU5EWHAKb0lORFhwCjdJTkRYcAobSU5EWHAKDUlORFhwCoZJ
TkRYcArDSU5EWHAKYUlORFhwCrBJTkRYcApYSU5EWHAKLElORFhwChZJTkRYcAqLSU5EWHAKRUlO
RFhwCqJJTkRYcArRSU5EWHAK6ElORFhwCnRJTkRYcAo6SU5EWHAKnUlORFhwCs5JTkRYcArnSU5E
WHAKc0lORFhwCjlJTkRYFBRFWEZHAHAKAklORFhwCgJEQVRBFE8EU1BMRAJFTkZHcAoHSU5EWHAK
B0RBVEGgB5NoAHBpYKAck2gBcAoCYH1QUkVHCgFQUkVHe2AKP2B9YGlgcApxSU5EWHBgREFUQUVY
RkdbgFRIUk8BCxFACgFbgQtUSFJPAVRIUlAIFCZHUkVOAXBUSFJQYKAJk2gAe2AK/WCgCZNoAX1g
CgJgcGBUSFJQFBFERUxZAXBoYKIHlGAKAHZgFEkGRkFPTgB7U0VORgoCYHtTRU5GCghhcAoAYqAK
k2AKAn1iCkBioAqTYQoIfWIKgGJbIguwBHBHQllUClhgoBKSk2AKMEdCWVQKQUdCWVQKQnBHQllU
ClZge2AKP2B9YGJiU0JZVApWYhQuRkFPRgBwR0JZVApWYHtgCj9iU0JZVApWYnBHQllUCldge2AK
92NTQllUCldjW4BJUF9fAQuVAgoCW4EQSVBfXwFJRFhTCERBVDAIFA1TQ0ZHAVNCWVQKQGgUL1NU
T1MDcEdCWVQKTmB9YAoBYVNCWVQKTmFTQllUClVpU0JZVApWaFNCWVQKTmAUL1NUSFkDcEdCWVQK
TmB9YAoBYVNCWVQKTmFTQllUClNpU0JZVApUaFNCWVQKTmAURwZSVE1QAHBHQllUCk5ke2QK+GB9
YAoBYFNCWVQKTmBwR0JZVApQYXBHQllUClFieWEKCGF9YWJjemMKB2N5YwoCYXJjYWNyYwusCmNT
QllUCk5kd2MKBGN0Yws8DGN4YwoDZ2OkYxQSU0JZVAJwaElEWFNwaURBVDAUFEdCWVQBcGhJRFhT
cERBVDBnpGcUD19NU0cBcGBgcGhEQkcxFE8JX1NTVAGgGJNoAKAQk1NCSVQKAFNQTEQKAAoipAoA
oB+TaAFTUExECgAKAEdSRU4KAHABR1AxQkZBT06kCgCgDpNoCgJHUkVOCgGkCgCgOJNoCgNGQU9G
cApTSU5YX3BEVEFfZHtkCgRkoAuTZAoEcABHUDFCU1BMRAoBCoBHUkVOCgGkCgCgFpNoCgRHUkVO
CgFTUExECgAKAKQKAFuAVEVNTQAMEPgPAAoMW4EkVEVNTQJUUDFIEFRQMUwQVFAySBBUUDJMEFRS
UEMQU0VORhAIVFZBUhEICgUAAAAAAIxUVkFSCgBQTENZi1RWQVIKAUNUT1OLVFZBUgoDQ1RIWXBU
UDFIQ1RPU3BUUDFMQ1RIWQhUQlVGEQcKBAAAAACMVEJVRgoAREIwMIxUQlVGCgFEQjAxi1RCVUYK
AERXMDCLVEJVRgoCRFcwMYpUQlVGCgBEQVREW4BJUF9fAQuVAgoCW4EQSVBfXwFJRFhTCERBVDAI
FA1TQ0ZHAVNCWVQKQGgUL1NUT1MDcEdCWVQKTmB9YAoBYVNCWVQKTmFTQllUClVpU0JZVApWaFNC
WVQKTmAUL1NUSFkDcEdCWVQKTmB9YAoBYVNCWVQKTmFTQllUClNpU0JZVApUaFNCWVQKTmAURwZS
VE1QAHBHQllUCk5ke2QK+GB9YAoBYFNCWVQKTmBwR0JZVApQYXBHQllUClFieWEKCGF9YWJjemMK
B2N5YwoCYXJjYWNyYwusCmNTQllUCk5kd2MKBGN0Yws8DGN4YwoDZ2OkYxQSU0JZVAJwaElEWFNw
aURBVDAUFEdCWVQBcGhJRFhTcERBVDBnpGcQQhNcX1RaX1uFSRJUSFJNCF9BTDASBgFGQU5fFB5f
QUMwAKAQfVBMQ1lQTENZZ6RUUDJIoQakVFAxSAhfUFNMEgwBXC5fUFJfQ1BVMAhfVFNQCjwIX1RD
MQoECF9UQzIKAxQeX1BTVgCgEH1QTENZUExDWWekVFAxSKEGpFRQMkgUC19DUlQApFRSUEMUTgRf
VE1QAHtTRU5GCgVmoCWTZgoFcFJUTVBmoBWSlWZUUlBDcFRSUENndGcKCmekZ6EDpGZ7U0VORgoB
ZqAKk2YKAaRSVE1QoQWkC4YLFCRfU0NQAaAIaHABUExDWaEHcABQTENZhlwuX1RaX1RIUk0KgRQx
U1RNUAJwaURXMDCgEmhTVEhZREIwMERCMDFEVzAwoRFTVE9TREIwMERCMDFEVzAwEAZcX0dQRRCP
sAFcX1NCX1uCGVBXUkIIX0hJRAxB0AwMFAlfU1RBAKQKC1uCThtNRU1fCF9ISUQMQdAMARRNGl9D
UlMACEJVRjARQgcKboYJAAEAAA8AAEAAAIYJAAEAQA8AAEAAAIYJAAEAgA8AAEAAAIYJAAEAwA8A
AEAAAIYJAAEAAAAAAAABAIYJAAEAAP//AAABAIYJAAEAAAAAAAAKAIYJAAEAABAAAAAAAIYJAAEA
AMD+ABAAAHkAikJVRjAKNEFDTU2KQlVGMAoEUk1BMYpCVUYwCghSU1MxikJVRjAKEFJNQTKKQlVG
MAoUUlNTMopCVUYwChxSTUEzikJVRjAKIFJTUzOKQlVGMAooUk1BNIpCVUYwCixSU1M0ikJVRjAK
XEVYVE10QU1FTQwAABAARVhUTaA1kpNST00xAHBSTUExUk1BMnlST00xCghgcGBSTUExeVJNUzEK
CGBwYFJTUzFwCwCAUlNTMqA1kpNST00yAHBSTUEyUk1BM3lST00yCghgcGBSTUEyeVJNUzIKCGBw
YFJTUzJwCwDAUlNTM6A3kpNST00zAHBSTUEzUk1BNHlST00zCghgcGBSTUEzeVJNUzMKCGBwYFJT
UzNwDAAAAQBSU1M0cEFNRU1BQ01NpEJVRjBbgoqSAVBDSTAIX0hJRAxB0AoDCF9BRFIKABQJX1NU
QQCkCg8UShFfQ1JTAAhCVUYwEUIKCp6IDQACAQAAAAAA/wAAAAABRwH4DPgMAQiIDQABDAMAAAAA
9wwAAPgMiA0AAQwDAAAADf8/AAAAM0cBAEAAQAFCiA0AAQwDAABCQP9PAAC+D0cBAFAAUAEQiA0A
AQwDAAAQUP//AADwr4cXAAAMAwAAAAAAAAoA/38MAAAAAAAAgAIAhxcAAAwDAAAAAAAAEAD//7/+
AAAAAAAA8P95AIpCVUYwCnZWTUFYikJVRjAKflZMRU55VkdBMQoJYHJgDP//CwBWTUFYcmAMAAAC
AFZMRU6KQlVGMAqMVENNTYpCVUYwCphUT01NckFNRU0MAAABAFRDTU10DAAAwP5UQ01NVE9NTaRC
VUYwCFBJQ00SRzYcEh4EDP//CAAKAFwvBF9TQl9QQ0kwSVNBX0xOS0EKABIeBAz//wgACgFcLwRf
U0JfUENJMElTQV9MTktCCgASHgQM//8IAAoCXC8EX1NCX1BDSTBJU0FfTE5LQwoAEh4EDP//CAAK
A1wvBF9TQl9QQ0kwSVNBX0xOS0QKABIeBAz//wkACgBcLwRfU0JfUENJMElTQV9MTktCCgASHgQM
//8JAAoBXC8EX1NCX1BDSTBJU0FfTE5LQwoAEh4EDP//CQAKAlwvBF9TQl9QQ0kwSVNBX0xOS0QK
ABIeBAz//wkACgNcLwRfU0JfUENJMElTQV9MTktBCgASHgQM//8KAAoAXC8EX1NCX1BDSTBJU0Ff
TE5LQwoAEh4EDP//CgAKAVwvBF9TQl9QQ0kwSVNBX0xOS0QKABIeBAz//woACgJcLwRfU0JfUENJ
MElTQV9MTktBCgASHgQM//8KAAoDXC8EX1NCX1BDSTBJU0FfTE5LQgoAEh4EDP//CwAKAFwvBF9T
Ql9QQ0kwSVNBX0xOS0QKABIeBAz//wsACgFcLwRfU0JfUENJMElTQV9MTktBCgASHgQM//8LAAoC
XC8EX1NCX1BDSTBJU0FfTE5LQgoAEh4EDP//CwAKA1wvBF9TQl9QQ0kwSVNBX0xOS0MKABIeBAz/
/wwACgBcLwRfU0JfUENJMElTQV9MTktBCgASHgQM//8MAAoBXC8EX1NCX1BDSTBJU0FfTE5LQQoA
Eh4EDP//DAAKAlwvBF9TQl9QQ0kwSVNBX0xOS0MKABIeBAz//wwACgNcLwRfU0JfUENJMElTQV9M
TktECgASHgQM//8HAAoAXC8EX1NCX1BDSTBJU0FfTE5LQQoAEh4EDP//BwAKAVwvBF9TQl9QQ0kw
SVNBX0xOS0IKABIeBAz//wcACgJcLwRfU0JfUENJMElTQV9MTktDCgASHgQM//8HAAoDXC8EX1NC
X1BDSTBJU0FfTE5LRAoAEh4EDP//AQAKAFwvBF9TQl9QQ0kwSVNBX0xOS0EKABIeBAz//wEACgFc
LwRfU0JfUENJMElTQV9MTktCCgASHgQM//8BAAoCXC8EX1NCX1BDSTBJU0FfTE5LQwoAEh4EDP//
AQAKA1wvBF9TQl9QQ0kwSVNBX0xOS0QKAAhBUElDEksYHBINBAz//wgACgAKAAoQEg0EDP//CAAK
AQoAChESDQQM//8IAAoCCgAKEhINBAz//wgACgMKAAoTEg0EDP//CQAKAAoAChESDQQM//8JAAoB
CgAKEhINBAz//wkACgIKAAoTEg0EDP//CQAKAwoAChASDQQM//8KAAoACgAKEhINBAz//woACgEK
AAoTEg0EDP//CgAKAgoAChASDQQM//8KAAoDCgAKERINBAz//wsACgAKAAoTEg0EDP//CwAKAQoA
ChASDQQM//8LAAoCCgAKERINBAz//wsACgMKAAoSEg0EDP//DAAKAAoAChASDQQM//8MAAoBCgAK
EBINBAz//wwACgIKAAoSEg0EDP//DAAKAwoAChMSDQQM//8HAAoACgAKEBINBAz//wcACgEKAAoR
Eg0EDP//BwAKAgoAChISDQQM//8HAAoDCgAKExINBAz//wEACgAKAAoQEg0EDP//AQAKAQoAChES
DQQM//8BAAoCCgAKEhINBAz//wEACgMKAAoTFBlfUFJUAKALklBJQ0akUElDTaEGpEFQSUNbgkoE
UFg0MAhfQURSDAAABwBbgFBJUlECCmAKBBAuXABbgSlcLwRfU0JfUENJMFBYNDBQSVJRAVBJUkEI
UElSQghQSVJDCFBJUkQIW4IbVVNCMAhfQURSDAIABwAIX1BSVxIGAgoICgRbgg9QWDQzCF9BRFIM
AwAHAFuCjSQBSVNBXwhfQURSDAAABwAUCV9TVEEApAoLW4JBEkxOS0EIX0hJRAxB0AwPCF9VSUQK
ARQcX1NUQQB7UElSQQqAYKAIk2AKgKQKCaEEpAoLFBpfUFJTAAhCVUZBEQkKBiP43Bh5AKRCVUZB
FBFfRElTAH1QSVJBCoBQSVJBFEMHX0NSUwAIQlVGQREJCgYjAAAYeQCMQlVGQQoBSVJBMYxCVUZB
CgJJUkEycAoAY3AKAGR7UElSQQqPYaAxlWEKgHthCg9hoA6UYQoHdGEKCGJ5AWJkoQugCZRhCgB5
AWFjcGNJUkExcGRJUkEypEJVRkEUSwRfU1JTAYxoCgFJUkExjGgKAklSQTJ5SVJBMgoIYH1gSVJB
MWBwCgBhemAKAWCiDJRgCgB1YXpgCgFge1BJUkEKcGB9YWBQSVJBW4JBEkxOS0IIX0hJRAxB0AwP
CF9VSUQKAhQcX1NUQQB7UElSQgqAYKAIk2AKgKQKCaEEpAoLFBpfUFJTAAhCVUZCEQkKBiP43Bh5
AKRCVUZCFBFfRElTAH1QSVJCCoBQSVJCFEMHX0NSUwAIQlVGQhEJCgYjAAAYeQCMQlVGQgoBSVJC
MYxCVUZCCgJJUkIycAoAY3AKAGR7UElSQgqPYaAxlWEKgHthCg9hoA6UYQoHdGEKCGJ5AWJkoQug
CZRhCgB5AWFjcGNJUkIxcGRJUkIypEJVRkIUSwRfU1JTAYxoCgFJUkIxjGgKAklSQjJ5SVJCMgoI
YH1gSVJCMWBwCgBhemAKAWCiDJRgCgB1YXpgCgFge1BJUkIKcGB9YWBQSVJCW4JFEUxOS0MIX0hJ
RAxB0AwPCF9VSUQKAxQcX1NUQQB7UElSQwqAYKAIk2AKgKQKCaEEpAoLCF9QUlMRCQoGI/jcGHkA
FBFfRElTAH1QSVJDCoBQSVJDFEMHX0NSUwAIQlVGQxEJCgYjAAAYeQCMQlVGQwoBSVJDMYxCVUZD
CgJJUkMycAoAY3AKAGR7UElSQwqPYKAxlWAKgHtgCg9goA6UYAoHdGAKCGJ5AWJkoQugCZRgCgB5
AWBjcGNJUkMxcGRJUkMypEJVRkMUSwRfU1JTAYxoCgFJUkMxjGgKAklSQzJ5SVJDMgoIYH1gSVJD
MWBwCgBhemAKAWCiDJRgCgB1YXpgCgFge1BJUkMKcGB9YWBQSVJDW4JFEUxOS0QIX0hJRAxB0AwP
CF9VSUQKBBQcX1NUQQB7UElSRAqAYKAIk2AKgKQKCaEEpAoLCF9QUlMRCQoGI/jcGHkAFBFfRElT
AH1QSVJECoBQSVJEFEMHX0NSUwAIQlVGRBEJCgYjAAAYeQCMQlVGRAoBSVJEMYxCVUZECgJJUkQy
cAoAY3AKAGR7UElSRAqPYKAxlWAKgHtgCg9goA6UYAoHdGAKCGJ5AWJkoQugCZRgCgB5AWBjcGNJ
UkQxcGRJUkQypEJVRkQUSwRfU1JTAYxoCgFJUkQxjGgKAklSRDJ5SVJEMgoIYH1gSVJEMWBwCgBh
emAKAWCiDJRgCgB1YXpgCgFge1BJUkQKcGB9YWBQSVJEW4JDCFNZU1IIX0hJRAxB0AwCCF9VSUQK
AQhfQ1JTEUYGCmJHARAAEAABEEcBIgAiAAEeRwFEAEQAARxHAWIAYgABAkcBZQBlAAELRwF0AHQA
AQxHAZEAkQABA0cBogCiAAEeRwHgAOAAARBHAfAD8AMBAkcB0ATQBAECRwGUApQCAQR5AFuCK1BJ
Q18IX0hJRAtB0AhfQ1JTERgKFUcBIAAgAAECRwGgAKAAAQIiBAB5AFuCPURNQTEIX0hJRAxB0AIA
CF9DUlMRKAolKhAERwEAAAAAARBHAYAAgAABEUcBlACUAAEMRwHAAMAAASB5AFuCJVRNUl8IX0hJ
RAxB0AEACF9DUlMREAoNRwFAAEAAAQQiAQB5AFuCJVJUQ18IX0hJRAxB0AsACF9DUlMREAoNRwFw
AHAAAAQiAAF5AFuCIlNQS1IIX0hJRAxB0AgACF9DUlMRDQoKRwFhAGEAAQF5AFuCJUNPUFIIX0hJ
RAxB0AwECF9DUlMREAoNRwHwAPAAARAiACB5AFuASVRFMQEL8AMKAluBEElURTEBSU5EWAhEQVRB
CFuARU5HMQELeQIKAVuBC0VORzEBQ09ORwhbhkYGSU5EWERBVEEBABBDRkdfCAAgTEROXwgAQA1Q
T1dDCABIBkFDVFIIAEgXSU9BSAhJT0FMCABAB0lOVFIIAAhJTlQxCAAIRE1DSAgASCVHUDQwCABI
F09QVDEIT1BUMghPUFQzCBRDEEVORkcAcAqGQ09OR3AKgENPTkdwClVDT05HcApVQ09OR3AKaklO
RFhwCrVJTkRYcAraSU5EWHAK7UlORFhwCvZJTkRYcAr7SU5EWHAKfUlORFhwCr5JTkRYcArfSU5E
WHAKb0lORFhwCjdJTkRYcAobSU5EWHAKDUlORFhwCoZJTkRYcArDSU5EWHAKYUlORFhwCrBJTkRY
cApYSU5EWHAKLElORFhwChZJTkRYcAqLSU5EWHAKRUlORFhwCqJJTkRYcArRSU5EWHAK6ElORFhw
CnRJTkRYcAo6SU5EWHAKnUlORFhwCs5JTkRYcArnSU5EWHAKc0lORFhwCjlJTkRYFA1FWEZHAHAK
AkNGR19bgkggRkRDMAhfSElEDEHQBwAUOl9TVEEARU5GR3AATEROX6AMQUNUUkVYRkekCg+hHKAR
kUlPQUhJT0FMRVhGR6QKDaEIRVhGR6QKABQbX0RJUwBFTkZHcAoATEROX3AAQUNUUkVYRkcURRFf
Q1JTAAhCVUYwERsKGEcBAAAAAAAERwEAAAAAAAEiAAAqAAB5AIxCVUYwCgJJT0xPjEJVRjAKA0lP
SEmMQlVGMAoESU9STIxCVUYwCgVJT1JIjEJVRjAKCklMTzGMQlVGMAoLSUhJMYxCVUYwCgxJUkwx
jEJVRjAKDUlSSDGMQlVGMAoRSVJRTIxCVUYwChRETUFWRU5GR3AATEROX3ABQUNUUnJJT0FMCgJi
cGJJT0xPcGJJT1JMcElPQUhJT0hJcElPQUhJT1JIcklPQUwKB2JwYklMTzFwYklSTDFwSU9BSElI
STFwSU9BSElSSDFwAWB5YElOVFJJUlFMcAFgeWBETUNIRE1BVkVYRkekQlVGMAhfUFJTER0KGjBH
AfID8gMABEcB9wP3AwABIkAAKgQAOHkAFEcGX1NSUwGMaAoCSU9MT4xoCgNJT0hJi2gKEUlSUUyM
aAoURE1BVkVORkdwAExETl9wCvBJT0FMcElPSElJT0FIgklSUUxgdGAKAUlOVFKCRE1BVmB0YAoB
RE1DSHABQUNUUkVYRkdbgkAaVUFSMQhfSElEDEHQBQEIX1VJRAoBFDtfU1RBAEVORkdwCgFMRE5f
oAxBQ1RSRVhGR6QKD6EcoBGRSU9BSElPQUxFWEZHpAoNoQhFWEZHpAoAFBtfRElTAEVORkdwCgFM
RE5fcABBQ1RSRVhGRxRPCV9DUlMACEJVRjEREAoNRwEAAAAAAAgiAAB5AIxCVUYxCgJJT0xPjEJV
RjEKA0lPSEmMQlVGMQoESU9STIxCVUYxCgVJT1JIjEJVRjEKCUlSUUxFTkZHcAoBTEROX3ABQUNU
UnBJT0FMSU9MT3BJT0FMSU9STHBJT0FISU9ISXBJT0FISU9SSHABYHlgSU5UUklSUUxFWEZHpEJV
RjEIX1BSUxE2CjMwRwH4A/gDAAgiuAAwRwH4AvgCAAgiuAAwRwHoA+gDAAgiuAAwRwHoAugCAAgi
uAA4eQAURAVfU1JTAYxoCgJJT0xPjGgKA0lPSEmMaAoJSVJRTEVORkdwCgFMRE5fcElPTE9JT0FM
cElPSElJT0FIgklSUUxgdGAKAUlOVFJwAUFDVFJFWEZHW4JOGlVBUjIIX0hJRAxB0AUBCF9VSUQK
AhQ7X1NUQQBFTkZHcAoCTEROX6AMQUNUUkVYRkekCg+hHKARkUlPQUhJT0FMRVhGR6QKDaEIRVhG
R6QKABQpX0RJUwBFTkZHcAoCTEROX3tPUFQyCgdgoAuTYAoAcABBQ1RSRVhGRxRPCV9DUlMACEJV
RjIREAoNRwEAAAAAAAgiAAB5AIxCVUYyCgJJT0xPjEJVRjIKA0lPSEmMQlVGMgoESU9STIxCVUYy
CgVJT1JIjEJVRjIKCUlSUUxFTkZHcAoCTEROX3ABQUNUUnBJT0FMSU9MT3BJT0FMSU9STHBJT0FI
SU9ISXBJT0FISU9SSHABYHlgSU5UUklSUUxFWEZHpEJVRjIIX1BSUxE2CjMwRwH4A/gDAAgiuAAw
RwH4AvgCAAgiuAAwRwHoA+gDAAgiuAAwRwHoAugCAAgiuAA4eQAURAVfU1JTAYxoCgJJT0xPjGgK
A0lPSEmMaAoJSVJRTEVORkdwCgJMRE5fcAFBQ1RScElPTE9JT0FMcElPSElJT0FIgklSUUxgdGAK
AUlOVFJFWEZHW4JJHUxQVF8IX0hJRAxB0AQAFEMFX1NUQQBFTkZHcAoDTEROX3tPUFQxCgJgoC+T
YAoAoAxBQ1RSRVhGR6QKD6EcoBGRSU9BSElPQUxFWEZHpAoNoQhFWEZHpAoAoQhFWEZHpAoAFBtf
RElTAEVORkdwCgNMRE5fcABBQ1RSRVhGRxRDDF9DUlMACEJVRjUREAoNRwEAAAAAAAgiAAB5AIxC
VUY1CgJJT0xPjEJVRjUKA0lPSEmMQlVGNQoESU9STIxCVUY1CgVJT1JIjEJVRjUKB0lPTE6MQlVG
NQoJSVJRTEVORkdwCgNMRE5fcAFBQ1RScElPQUxJT0xPcElPQUxJT1JMcElPQUhJT0hJcElPQUhJ
T1JIoA+TSU9MTwq8cAoESU9MTqEIcAoISU9MTnABYHlgSU5UUklSUUxFWEZHpEJVRjUIX1BSUxEq
CicwRwF4A3gDAAgiuAAwRwF4AngCAAgiuAAwRwG8A7wDAAQiuAA4eQAURAZfU1JTAYxoCgJJT0xP
jGgKA0lPSEmMaAoESU9STIxoCgVJT1JIjGgKCUlSUUxFTkZHcAoDTEROX3BJT0xPSU9BTHBJT0hJ
SU9BSIFJUlFMYHRgCgFJTlRScAFBQ1RSRVhGR1uCQilFQ1BfCF9ISUQMQdAEARRDBV9TVEEARU5G
R3AKA0xETl97T1BUMQoCYKAvk2AKAqAMQUNUUkVYRkekCg+hHKARkUlPQUhJT0FMRVhGR6QKDaEI
RVhGR6QKAKEIRVhGR6QKABQbX0RJUwBFTkZHcAoDTEROX3AAQUNUUkVYRkcURBVfQ1JTAAhCVUY2
ERsKGEcBAAAAAAAARwEAAAAAAAAiAAAqAAB5AIxCVUY2CgJJT0xPjEJVRjYKA0lPSEmMQlVGNgoE
SU9STIxCVUY2CgVJT1JIjEJVRjYKB0lPTE6MQlVGNgoKSU9FTIxCVUY2CgtJT0VIjEJVRjYKDElP
TUyMQlVGNgoNSU9NSIxCVUY2Cg9JT0hOjEJVRjYKEUlSUUyMQlVGNgoURE1BQ0VORkdwCgNMRE5f
cAFBQ1RScElPQUxJT0xPcElPQUxJT1JMcElPQUxJT0VMcElPQUxJT01McElPQUhJT0hJcElPQUhJ
T1JIcElPQUhjfWMKBGNwY0lPRUhwY0lPTUigFpNJT0xPCrxwCgRJT0xOcAoESU9ITqEPcAoISU9M
TnAKBElPSE5wAWB5YElOVFJJUlFMcAFgeWBETUNIRE1BQ0VYRkekQlVGNghfUFJTEUwECkgwRwF4
A3gDAAhHAXgHeAcABCK4ACoLADBHAXgCeAIACEcBeAZ4BgAEIrgAKgsAMEcBvAO8AwAERwG8B7wH
AAQiuAAqCwA4eQAUSgZfU1JTAYxoCgJJT0xPjGgKA0lPSEmMaAoRSVJRTIxoChRETUFDRU5GR3AK
A0xETl9wAUFDVFJwSU9MT0lPQUxwSU9ISUlPQUiBSVJRTGB0YAoBSU5UUoFETUFDYXRhCgFETUNI
RVhGR1uCQgVQUzJNCF9ISUQMQdAPExQnX1NUQQBFTkZHcAoGTEROX6AMQUNUUkVYRkekCg+hCEVY
RkekCgAUGV9DUlMACEJVRk0RCAoFIgAQeQCkQlVGTVuCQgZQUzJLCF9ISUQMQdADAxQnX1NUQQBF
TkZHcAoGTEROX6AMQUNUUkVYRkekCg+hCEVYRkekCgAUKV9DUlMACEJVRjcRGAoVRwFgAGAAAQFH
AWQAZAABASICAHkApEJVRjcIX1BSVxIGAgoJCgU=

--=-HTtTeqqmJVm+ygvY/340
Content-Disposition: attachment; filename=interrupts
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ISO-8859-1

           CPU0       CPU1      =20
  0:      57067      61544    IO-APIC-edge  timer
  1:       1505       1651    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  5:          4          0    IO-APIC-edge  soundblaster
  8:          1          0    IO-APIC-edge  rtc
  9:          0          0    IO-APIC-edge  acpi
 14:       4789       6656    IO-APIC-edge  ide0
 15:         27         52    IO-APIC-edge  ide1
 16:        180        172   IO-APIC-level  aic7xxx, aic7xxx
 17:        661        663   IO-APIC-level  eth0
 19:       5122       5025   IO-APIC-level  usb-uhci
NMI:          0          0=20
LOC:     118508     118498=20
ERR:          0
MIS:          0

--=-HTtTeqqmJVm+ygvY/340
Content-Disposition: attachment; filename=iomem
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ISO-8859-1

00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-2ffeffff : System RAM
  00100000-0024433c : Kernel code
  0024433d-00298bbf : Kernel data
2fff0000-2fff2fff : ACPI Non-volatile Storage
2fff3000-2fffffff : ACPI Tables
d8000000-dbffffff : Intel Corp. 440BX/ZX - 82443BX/ZX Host bridge
dc000000-ddffffff : PCI Bus #01
  dc000000-dcffffff : nVidia Corporation Riva TnT2 [NV5]
de000000-dfffffff : PCI Bus #01
  de000000-dfffffff : nVidia Corporation Riva TnT2 [NV5]
e2000000-e2000fff : Adaptec AHA-2940U/UW / AHA-39xx / AIC-7895
  e2000000-e2000fff : aic7xxx
e2001000-e200107f : Digital Equipment Corporation DECchip 21142/43
  e2001000-e200107f : tulip
e2002000-e2002fff : Adaptec AHA-2940U/UW / AHA-39xx / AIC-7895 (#2)
  e2002000-e2002fff : aic7xxx
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

--=-HTtTeqqmJVm+ygvY/340
Content-Disposition: attachment; filename=ioports
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ISO-8859-1

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0213-0213 : isapnp read
0220-022f : soundblaster
02f8-02ff : serial(auto)
0330-0333 : MPU-401 UART
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
4000-403f : Intel Corp. 82371AB PIIX4 ACPI
5000-501f : Intel Corp. 82371AB PIIX4 ACPI
d000-dfff : PCI Bus #01
e000-e01f : Intel Corp. 82371AB PIIX4 USB
  e000-e01f : usb-uhci
e400-e47f : Digital Equipment Corporation DECchip 21142/43
  e400-e47f : tulip
e800-e8ff : Adaptec AHA-2940U/UW / AHA-39xx / AIC-7895
  e800-e8ff : aic7xxx
ec00-ecff : Adaptec AHA-2940U/UW / AHA-39xx / AIC-7895 (#2)
  ec00-ecff : aic7xxx
f000-f00f : Intel Corp. 82371AB PIIX4 IDE
  f000-f007 : ide0
  f008-f00f : ide1

--=-HTtTeqqmJVm+ygvY/340--

