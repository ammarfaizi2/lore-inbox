Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264941AbTLFE5j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 23:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264948AbTLFE5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 23:57:39 -0500
Received: from dodge.jordet.nu ([217.13.8.142]:33757 "EHLO dodge.jordet.nu")
	by vger.kernel.org with ESMTP id S264941AbTLFE5V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 23:57:21 -0500
Subject: Re: SMP broken on Dell PowerEdge 4100/200 under 2.6.0-testxx?
From: Stian Jordet <liste@jordet.nu>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Nick Piggin <piggin@cyberone.com.au>, Colin Coe <colin@coesta.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20031206045409.GK8039@holomorphy.com>
References: <3350.192.168.1.3.1070677965.squirrel@www.coesta.com>
	 <20031206024251.GG8039@holomorphy.com> <3FD14396.5070205@cyberone.com.au>
	 <20031206030755.GI8039@holomorphy.com>
	 <1070684918.7934.2.camel@chevrolet.hybel>
	 <20031206043757.GJ8039@holomorphy.com>
	 <1070686126.1166.0.camel@chevrolet.hybel>
	 <20031206045409.GK8039@holomorphy.com>
Content-Type: multipart/mixed; boundary="=-i9Cpyp1sti4gGUu22PQA"
Message-Id: <1070686634.1166.3.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 06 Dec 2003 05:57:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-i9Cpyp1sti4gGUu22PQA
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

lør, 06.12.2003 kl. 05.54 skrev William Lee Irwin III:
> Okay, irqbalance has gaffed (as predicted). Could you send in
> /proc/cpuinfo and /var/log/dmesg?

Here they are. Thanks for looking into this :)

Best regards,
Stian

--=-i9Cpyp1sti4gGUu22PQA
Content-Disposition: attachment; filename=cpuinfo.txt
Content-Type: text/plain; name=cpuinfo.txt; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 10
cpu MHz		: 1000.416
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 1957.88

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 10
cpu MHz		: 1000.416
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 1994.75


--=-i9Cpyp1sti4gGUu22PQA
Content-Disposition: attachment; filename=dmesg.txt
Content-Type: text/plain; name=dmesg.txt; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

Linux version 2.6.0-test11 (root@chevrolet) (gcc version 3.3.2 (Debian)) #3 SMP Thu Dec 4 16:51:17 CET 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fffc000 (usable)
 BIOS-e820: 000000001fffc000 - 000000001ffff000 (ACPI data)
 BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
found SMP MP-table at 000f5500
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
On node 0 totalpages: 131068
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126972 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 ASUS                                      ) @ 0x000f6930
ACPI: RSDT (v001 ASUS   CV266DLS 0x30303031 MSFT 0x31313031) @ 0x1fffc000
ACPI: FADT (v001 ASUS   CV266DLS 0x30303031 MSFT 0x31313031) @ 0x1fffc100
ACPI: BOOT (v001 ASUS   CV266DLS 0x30303031 MSFT 0x31313031) @ 0x1fffc040
ACPI: MADT (v001 ASUS   CV266DLS 0x30303031 MSFT 0x31313031) @ 0x1fffc080
ACPI: DSDT (v001   ASUS CV266DLS 0x00001000 MSFT 0x0100000b) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x03] enabled)
Processor #3 6:8 APIC version 17
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:8 APIC version 17
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, IRQ 0-23
ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x1])
ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x3] trigger[0x3])
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Building zonelist for node : 0
Kernel command line: root=/dev/sda2 ro idebus=33 vga=0 noirqbalance
ide_setup: idebus=33
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1000.416 MHz processor.
Console: colour VGA+ 80x25
Memory: 512816k/524272k available (3543k kernel code, 10660k reserved, 1185k data, 208k init, 0k highmem)
Calibrating delay loop... 1957.88 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0383fbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0383fbff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU:     After all inits, caps: 0383fbff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel Pentium III (Coppermine) stepping 0a
per-CPU timeslice cutoff: 731.00 usecs.
task migration cache decay timeout: 1 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/0 eip 3000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1994.75 BogoMIPS
CPU:     After generic identify, caps: 0383fbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0383fbff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU:     After all inits, caps: 0383fbff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium III (Coppermine) stepping 0a
Total of 2 processors activated (3952.64 BogoMIPS).
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=-1
number of MP IRQ sources: 15.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................
IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  1    1    0   1   0    1    1    71
 0a 001 01  0    0    0   0   0    1    1    79
 0b 001 01  0    0    0   0   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  0    0    0   0   0    1    1    99
 0f 001 01  0    0    0   0   0    1    1    A1
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
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
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 999.0518 MHz.
..... host bus clock speed is 133.0269 MHz.
checking TSC synchronization across 2 CPUs: passed.
Starting migration thread for cpu 0
Bringing up 1
CPU 1 IS NOW UP!
Starting migration thread for cpu 1
CPUS done 2
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0d40, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20031002
IOAPIC[0]: Set PCI routing entry (2-9 -> 0x71 -> IRQ 9 Mode:1 Active:1)
    ACPI-0109: *** Error: No object was returned from [\_SB_.PCI0.PX40.IRDA._STA] (Node dff3f860), AE_NOT_EXIST
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fbd80
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xbdb0, dseg 0xf0000
pnp: 00:11: ioport range 0xe400-0xe47f has been reserved
pnp: 00:11: ioport range 0xe800-0xe83f has been reserved
PnPBIOS: 14 nodes reported by PnP BIOS; 14 recorded by driver
SCSI subsystem initialized
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
IOAPIC[0]: Set PCI routing entry (2-17 -> 0xa9 -> IRQ 17 Mode:1 Active:1)
00:00:07[A] -> 2-17 -> IRQ 17
IOAPIC[0]: Set PCI routing entry (2-18 -> 0xb1 -> IRQ 18 Mode:1 Active:1)
00:00:07[B] -> 2-18 -> IRQ 18
IOAPIC[0]: Set PCI routing entry (2-19 -> 0xb9 -> IRQ 19 Mode:1 Active:1)
00:00:05[A] -> 2-19 -> IRQ 19
Pin 2-19 already programmed
IOAPIC[0]: Set PCI routing entry (2-16 -> 0xc1 -> IRQ 16 Mode:1 Active:1)
00:00:0c[B] -> 2-16 -> IRQ 16
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
IOAPIC[0]: Set PCI routing entry (2-11 -> 0xc9 -> IRQ 27 Mode:1 Active:1)
00:00:11[A] -> 2-11 -> IRQ 27
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
IOAPIC[0]: Set PCI routing entry (2-10 -> 0xd1 -> IRQ 26 Mode:1 Active:1)
00:00:11[B] -> 2-10 -> IRQ 26
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 12
IOAPIC[0]: Set PCI routing entry (2-12 -> 0xd9 -> IRQ 28 Mode:1 Active:1)
00:00:11[C] -> 2-12 -> IRQ 28
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
IOAPIC[0]: Set PCI routing entry (2-5 -> 0xe1 -> IRQ 21 Mode:1 Active:1)
00:00:11[D] -> 2-5 -> IRQ 21
Pin 2-16 already programmed
Pin 2-17 already programmed
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
irda_init()
NET: Registered protocol family 23
Bluetooth: Core ver 2.3
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
radeonfb_pci_register BEGIN
radeonfb: ref_clk=2700, ref_div=12, xclk=27000 defaults
radeonfb: probed SDR SGRAM 131072k videoram
radeon_get_moninfo: bios 4 scratch = 22000202
radeonfb: ATI Radeon 9700 ND SDR SGRAM 128 MB
radeonfb: DVI port CRT monitor connected
radeonfb: CRT port CRT monitor connected
radeonfb_pci_register END
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
IA-32 Microcode Update Driver: v1.13 <tigran@veritas.com>
ikconfig 0.7 with /proc/config*
VFS: Disk quotas dquot_6.5.1
NTFS driver 2.1.5 [Flags: R/O].
udf: registering filesystem
SGI XFS for Linux with ACLs, no debug enabled
SGI XFS Quota Management subsystem
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU] (supports C1)
ACPI: Processor [CPU1] (supports C1)
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
Intel(R) PRO/100 Network Driver - version 2.3.30-k1
Copyright (c) 2003 Intel Corporation

e100: selftest OK.
e100: eth0: Intel(R) PRO/100 Network Connection
  Hardware receive checksums enabled
  cpu cycle saver enabled

PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
Linux video capture interface: v1.00
saa7130/34: v4l2 driver version 0.2.9 loaded
saa7134[0]: found at 0000:00:0c.0, rev: 1, irq: 19, latency: 32, mmio: 0xdc000000
saa7134[0]: subsystem: 153b:1143, board: Terratec Cinergy 600 TV [card=11,autodetected]
saa7134[0]: board init: gpio is 50000
saa7134[0]: registered input device for IR
saa7134[0]: i2c eeprom 00: 3b 15 43 11 ff ff ff ff ff ff ff ff ff ff ff ff
saa7134[0]: i2c eeprom 10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
saa7134[0]: i2c eeprom 20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
saa7134[0]: i2c eeprom 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
request_module: failed /sbin/modprobe -- tuner. error = -16
saa7134[0]: registered device video0 [v4l2]
saa7134[0]: registered device vbi0
saa7134[0]: registered device radio0
tuner: chip found @ 0xc0
tuner: type set to 5 (Philips PAL_BG (FI1216 and compatibles))
registering 0-0060
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes
VP_IDE: IDE controller at PCI slot 0000:00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xa000-0xa007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xa008-0xa00f, BIOS settings: hdc:pio, hdd:DMA
hda: WDC WD1200JB-00CRA1, ATA DISK drive
hdb: WDC WD1200JB-75CRA0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
saa7134[0]/audio: audio carrier scan failed, using 5.500 MHz [default]
hdd: IOMEGA ZIP 100 ATAPI Floppy, ATAPI FLOPPY drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=65535/16/63, UDMA(100)
 hda: hda1
hdb: max request size: 128KiB
hdb: Host Protected Area detected.
	current capacity is 234375000 sectors (120000 MB)
	native  capacity is 234441648 sectors (120034 MB)
hdb: 234375000 sectors (120000 MB) w/8192KiB Cache, CHS=65535/16/63, UDMA(100)
 hdb: hdb1
ide-floppy driver 0.99.newide
hdd: 98288kB, 196576 blocks, 512 sector size
hdd: 98304kB, 96/64/32 CHS, 4096 kBps, 512 sector size, 2941 rpm
 hdd: hdd1 hdd2 hdd3 hdd4
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.35
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

(scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
  Vendor: SEAGATE   Model: ST318452LW        Rev: 0004
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.35
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs

(scsi1:A:4): 20.000MB/s transfers (20.000MHz, offset 16)
(scsi1:A:5): 20.000MB/s transfers (20.000MHz, offset 15)
(scsi1:A:6): 7.812MB/s transfers (7.812MHz, offset 15)
  Vendor: PIONEER   Model: DVD-ROM DVD-304F  Rev: 1.03
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: YAMAHA    Model: CRW-F1S           Rev: 1.0g
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: SEAGATE   Model: DAT    04687-XXX  Rev: 6610
  Type:   Sequential-Access                  ANSI SCSI revision: 02
st: Version 20030811, fixed bufsize 32768, s/g segs 256
Attached scsi tape st0 at scsi1, channel 0, id 6, lun 0
st0: try direct i/o: yes, max page reachable by HBA 1048575
SCSI device sda: 35843670 512-byte hdwr sectors (18352 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 0x/0x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
Attached scsi CD-ROM sr0 at scsi1, channel 0, id 4, lun 0
sr1: scsi3-mmc drive: 44x/44x writer cd/rw xa/form2 cdda tray
Attached scsi CD-ROM sr1 at scsi1, channel 0, id 5, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg1 at scsi1, channel 0, id 4, lun 0,  type 5
Attached scsi generic sg2 at scsi1, channel 0, id 5, lun 0,  type 5
Attached scsi generic sg3 at scsi1, channel 0, id 6, lun 0,  type 1
PCI: Enabling device 0000:00:0f.0 (0000 -> 0002)
Yenta: CardBus bridge found at 0000:00:0f.0 [14ef:0220]
Yenta: ISA IRQ list 0000, PCI irq18
Socket status: 30000006
PCI: Enabling device 0000:00:0f.1 (0000 -> 0002)
Yenta: CardBus bridge found at 0000:00:0f.1 [14ef:0220]
Yenta: ISA IRQ list 0000, PCI irq19
Socket status: 30000810
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
uhci_hcd 0000:00:11.2: UHCI Host Controller
uhci_hcd 0000:00:11.2: irq 21, io base 00009800
uhci_hcd 0000:00:11.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
uhci_hcd 0000:00:11.3: UHCI Host Controller
uhci_hcd 0000:00:11.3: irq 21, io base 00009400
uhci_hcd 0000:00:11.3: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:11.4: UHCI Host Controller
uhci_hcd 0000:00:11.4: irq 21, io base 00009000
uhci_hcd 0000:00:11.4: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
drivers/usb/core/usb.c: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
drivers/usb/core/usb.c: registered new driver hiddev
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
drivers/usb/core/usb.c: registered new driver usbscanner
drivers/usb/image/scanner.c: 0.4.15:USB Scanner Driver
mice: PS/2 mouse device common for all mice
input: PC Speaker
gameport: pci0000:00:0e.1 speed 1704 kHz
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
registering 1-002d
registering 1-0049
registering 1-0048
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
ip_conntrack version 2.1 (4095 buckets, 32760 max) - 304 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
hub 3-0:1.0: new USB device on port 2, assigned address 2
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 2 if 0 alt 0 proto 2 vid 0x03F0 pid 0x3304
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
NET: Registered protocol family 1
NET: Registered protocol family 17
IrCOMM protocol (Dag Brattli)
Bluetooth: L2CAP ver 2.1
Bluetooth: L2CAP socket layer initialized
Bluetooth: SCO (Voice Link) ver 0.3
Bluetooth: SCO socket layer initialized
Bluetooth: RFCOMM ver 1.0
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: BNEP (Ethernet Emulation) ver 1.0
Bluetooth: BNEP filters: protocol multicast
Software Suspend has malfunctioning SMP support. Disabled :(
ACPI: (supports S0 S1 S4 S5)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 208k freed
hub 2-0:1.0: new USB device on port 1, assigned address 2
drivers/usb/image/scanner.c: USB scanner device (0x04b8/0x011d) now attached to usb/scanner0
hub 2-0:1.0: new USB device on port 2, assigned address 3
Adding 1052248k swap on /dev/sda4.  Priority:-1 extents:1
EXT3 FS on sda2, internal journal
hub 1-0:1.0: new USB device on port 1, assigned address 2
input: USB HID v1.10 Keyboard [Logitech USB Receiver] on usb-0000:00:11.2-1
input: USB HID v1.10 Mouse [Logitech USB Receiver] on usb-0000:00:11.2-1
hub 1-0:1.0: new USB device on port 2, assigned address 3
usb 1-2: USB disconnect, address 3
Bluetooth: HCI USB driver ver 2.4
drivers/usb/core/usb.c: registered new driver hci_usb
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA Pro 266 chipset
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 64M @ 0xf8000000
hub 1-0:1.0: new USB device on port 2, assigned address 4
XFS mounting filesystem sda3
Ending clean XFS mount for filesystem: sda3
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on hdb1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
NTFS volume version 3.0.
usb 1-2: device not accepting address 4, error -110
hub 1-0:1.0: new USB device on port 2, assigned address 5
hci_usb: probe of 1-2:1.1 failed with error -5
hci_usb: probe of 1-2:1.2 failed with error -5
e100: eth0 NIC Link is Up 100 Mbps Full duplex
nfs warning: mount version older than kernel
nfs warning: mount version older than kernel

--=-i9Cpyp1sti4gGUu22PQA--

