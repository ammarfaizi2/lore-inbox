Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271430AbRHPE24>; Thu, 16 Aug 2001 00:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271433AbRHPE2s>; Thu, 16 Aug 2001 00:28:48 -0400
Received: from dynamic-141.remotepoint.com ([204.221.114.141]:9732 "EHLO
	aerospace.fries.net") by vger.kernel.org with ESMTP
	id <S271430AbRHPE2e>; Thu, 16 Aug 2001 00:28:34 -0400
Date: Wed, 15 Aug 2001 22:45:39 -0500
From: David Fries <dfries@mail.win.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.{6,7,8} breaks intel SMP PCI irq detection
Message-ID: <20010815224539.A657@d-131-151-189-65.dynamic.umr.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.5 books fine on my dual processor SMP box, 2.4.6 and beyond break
The scsi driver thinks it is on irq 5, but it is normally on irq 17 so
the system is stuck in scsi resets.

Pentium MMX,
Host bridge: Intel Corporation 430HX - 82439HX TXC [Triton II] (rev 3)
ISA bridge: Intel Corporation 82371SB PIIX3 ISA [Natoma/Triton II] (rev 1)

Boot logs of 2.4.8 and 2.4.5 follow.

Linux version 2.4.8 (root@aerospace) (gcc version 2.95.2 20000220 (Debian GNU/Linux)) #8 SMP Wed Aug 15 20:55:29 CDT 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000008000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
found SMP MP-table at 000f0c80
hm, page 000f0000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f0000 reserved twice.
hm, page 000f1000 reserved twice.
On node 0 totalpages: 32768
zone(0): 4096 pages.
zone(1): 28672 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #0 Pentium(tm) APIC version 17
    Floating point unit present.
    Machine Exception supported.
    64 bit compare & exchange supported.
    Internal APIC present.
    Bootup CPU
Processor #1 Pentium(tm) APIC version 17
    Floating point unit present.
    Machine Exception supported.
    64 bit compare & exchange supported.
    Internal APIC present.
Bus #0 is ISA   
Bus #1 is PCI   
I/O APIC #2 Version 17 at 0xFEC00000.
Int: type 3, pol 0, trig 0, bus 0, IRQ 00, APIC ID 2, APIC INT 00
Int: type 0, pol 0, trig 0, bus 0, IRQ 01, APIC ID 2, APIC INT 01
Int: type 0, pol 0, trig 0, bus 0, IRQ 00, APIC ID 2, APIC INT 02
Int: type 0, pol 0, trig 0, bus 0, IRQ 03, APIC ID 2, APIC INT 03
Int: type 0, pol 0, trig 0, bus 0, IRQ 04, APIC ID 2, APIC INT 04
Int: type 0, pol 0, trig 0, bus 0, IRQ 05, APIC ID 2, APIC INT 05
Int: type 0, pol 0, trig 0, bus 0, IRQ 06, APIC ID 2, APIC INT 06
Int: type 0, pol 0, trig 0, bus 0, IRQ 07, APIC ID 2, APIC INT 07
Int: type 0, pol 0, trig 0, bus 0, IRQ 08, APIC ID 2, APIC INT 08
Int: type 0, pol 0, trig 0, bus 0, IRQ 09, APIC ID 2, APIC INT 09
Int: type 0, pol 0, trig 0, bus 0, IRQ 0a, APIC ID 2, APIC INT 0a
Int: type 0, pol 0, trig 0, bus 0, IRQ 0b, APIC ID 2, APIC INT 0b
Int: type 0, pol 0, trig 0, bus 0, IRQ 0c, APIC ID 2, APIC INT 0c
Int: type 0, pol 0, trig 0, bus 0, IRQ 0d, APIC ID 2, APIC INT 0d
Int: type 0, pol 0, trig 0, bus 0, IRQ 0e, APIC ID 2, APIC INT 0e
Int: type 0, pol 0, trig 0, bus 0, IRQ 0f, APIC ID 2, APIC INT 0f
Int: type 0, pol 3, trig 3, bus 1, IRQ 50, APIC ID 2, APIC INT 10
Int: type 0, pol 3, trig 3, bus 1, IRQ 4c, APIC ID 2, APIC INT 11
Int: type 0, pol 3, trig 3, bus 1, IRQ 48, APIC ID 2, APIC INT 12
Int: type 0, pol 3, trig 3, bus 1, IRQ 44, APIC ID 2, APIC INT 13
Int: type 2, pol 0, trig 0, bus 0, IRQ 00, APIC ID 2, APIC INT 17
Lint: type 3, pol 1, trig 1, bus 0, IRQ 00, APIC ID ff, APIC LINT 00
Lint: type 1, pol 1, trig 1, bus 0, IRQ 00, APIC ID ff, APIC LINT 01
Processors: 2
mapped APIC to ffffe000 (fee00000)
mapped IOAPIC to ffffd000 (fec00000)
Kernel command line: BOOT_IMAGE=2.4.8 ro root=802 BOOT_FILE=/2.4.8 ncr53c8xx=revprob:y console=ttyS0
Initializing CPU#0
Detected 199.436 MHz processor.
Console: colour VGA+ 132x44
Calibrating delay loop... 398.13 BogoMIPS
Memory: 126252k/131072k available (1267k kernel code, 4432k reserved, 423k data, 212k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
Intel Pentium with F0 0F bug - workaround enabled.
Intel old style machine check architecture supported.
Intel old style machine check reporting enabled on CPU#0.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Intel old style machine check architecture supported.
Intel old style machine check reporting enabled on CPU#0.
CPU0: Intel Pentium MMX stepping 03
per-CPU timeslice cutoff: 159.71 usecs.
Getting VERSION: 30010
Getting VERSION: 30010
Getting ID: 0
Getting ID: f000000
Getting LVT0: 700
Getting LVT1: 400
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
CPU present map: 3
Booting processor 1/1 eip 2000
Setting warm reset code and vector.
1.
2.
3.
Asserting INIT.
Waiting for send to finish...
+Deasserting INIT.
Waiting for send to finish...
+#startup loops: 2.
Sending STARTUP #1.
After apic_write.
Initializing CPU#1
Startup point 1.
CPU#1 (phys ID: 1) waiting for CALLOUT
Waiting for send to finish...
+Sending STARTUP #2.
After apic_write.
Startup point 1.
Waiting for send to finish...
+After Startup.
Before Callout 1.
CALLIN, before setup_local_APIC().
After Callout 1.
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 398.13 BogoMIPS
Stack at about c1251fbc
Intel old style machine check architecture supported.
Intel old style machine check reporting enabled on CPU#1.
OK.
CPU1: Intel Pentium MMX stepping 03
CPU has booted.
Before bogomips.
Total of 2 processors activated (796.26 BogoMIPS).
Before bogocount - setting activated=1.
Boot done.
ENABLING IO-APIC IRQs
...changing IO-APIC physical APIC ID to 2 ... ok.
Synchronizing Arb IDs.
..TIMER: vector=31 pin1=2 pin2=0
testing the IO APIC.......................

.................................... done.
calibrating APIC timer ...
..... CPU clock speed is 199.4205 MHz.
..... host bus clock speed is 66.4734 MHz.
cpu: 0, clocks: 664734, slice: 221578
CPU0<T0:664720,T1:443136,D:6,S:221578,C:664734>
cpu: 1, clocks: 664734, slice: 221578
CPU1<T0:664720,T1:221552,D:12,S:221578,C:664734>
checking TSC synchronization across CPUs: passed.
Setting commenced=1, go go go
PCI: PCI BIOS revision 2.10 entry at 0xfb420, last bus=0
PCI: Using configuration type 1
PCI: Probing PCI hardware
querying PCI -> IRQ mapping bus:0, slot:17, pin:0.
PCI BIOS passed nonexistent PCI bus 0!
querying PCI -> IRQ mapping bus:0, slot:18, pin:0.
PCI BIOS passed nonexistent PCI bus 0!
querying PCI -> IRQ mapping bus:0, slot:19, pin:0.
PCI BIOS passed nonexistent PCI bus 0!
querying PCI -> IRQ mapping bus:0, slot:20, pin:0.
PCI BIOS passed nonexistent PCI bus 0!
Limiting direct PCI/PCI transfers.
Activating ISA DMA hang workarounds.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10d
block: 128 slots per queue, batch=16
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX3: IDE controller on PCI bus 00 dev 39
PIIX3: chipset revision 0
PIIX3: not 100% native mode: will probe irqs later
hda: Maxtor 7213 AT, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 415264 sectors (213 MB) w/64KiB Cache, CHS=683/16/38
Partition check:
 hda: hda1
PPP generic driver version 2.4.1
SCSI subsystem driver Revision: 1.00
sym53c8xx: at PCI bus 0, device 17, function 0
sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
sym53c8xx: 53c875 detected with Tekram NVRAM
sym53c875-0: rev 0x26 on pci bus 0 device 17 function 0 irq 5
sym53c875-0: Tekram format NVRAM, ID 7, Fast-20, Parity Checking
scsi0 : sym53c8xx-1.7.3c-20010512
scsi : aborting command due to timeout : pid 0, scsi0, channel 0, id 0, lun 0 Inquiry 00 00 00 ff 00 
sym53c8xx_abort: pid=0 serial_number=1 serial_number_at_timeout=1
SCSI host 0 abort (pid 0) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
sym53c8xx_reset: pid=0 reset_flags=2 serial_number=1 serial_number_at_timeout=1
SCSI host 0 abort (pid 0) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
sym53c8xx_reset: pid=0 reset_flags=2 serial_number=2 serial_number_at_timeout=2
SCSI host 0 abort (pid 0) timed out - resetting
SCSI bus is being reset for host 0 channel 0.

Linux version 2.4.5 (root@aerospace) (gcc version 2.95.2 20000220 (Debian GNU/Linux)) #7 SMP Wed Aug 15 20:04:54 CDT 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000008000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
found SMP MP-table at 000f0c80
hm, page 000f0000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f0000 reserved twice.
hm, page 000f1000 reserved twice.
On node 0 totalpages: 32768
zone(0): 4096 pages.
zone(1): 28672 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #0 Pentium(tm) APIC version 17
    Floating point unit present.
    Machine Exception supported.
    64 bit compare & exchange supported.
    Internal APIC present.
    Bootup CPU
Processor #1 Pentium(tm) APIC version 17
    Floating point unit present.
    Machine Exception supported.
    64 bit compare & exchange supported.
    Internal APIC present.
Bus #0 is ISA   
Bus #1 is PCI   
I/O APIC #2 Version 17 at 0xFEC00000.
Int: type 3, pol 0, trig 0, bus 0, IRQ 00, APIC ID 2, APIC INT 00
Int: type 0, pol 0, trig 0, bus 0, IRQ 01, APIC ID 2, APIC INT 01
Int: type 0, pol 0, trig 0, bus 0, IRQ 00, APIC ID 2, APIC INT 02
Int: type 0, pol 0, trig 0, bus 0, IRQ 03, APIC ID 2, APIC INT 03
Int: type 0, pol 0, trig 0, bus 0, IRQ 04, APIC ID 2, APIC INT 04
Int: type 0, pol 0, trig 0, bus 0, IRQ 05, APIC ID 2, APIC INT 05
Int: type 0, pol 0, trig 0, bus 0, IRQ 06, APIC ID 2, APIC INT 06
Int: type 0, pol 0, trig 0, bus 0, IRQ 07, APIC ID 2, APIC INT 07
Int: type 0, pol 0, trig 0, bus 0, IRQ 08, APIC ID 2, APIC INT 08
Int: type 0, pol 0, trig 0, bus 0, IRQ 09, APIC ID 2, APIC INT 09
Int: type 0, pol 0, trig 0, bus 0, IRQ 0a, APIC ID 2, APIC INT 0a
Int: type 0, pol 0, trig 0, bus 0, IRQ 0b, APIC ID 2, APIC INT 0b
Int: type 0, pol 0, trig 0, bus 0, IRQ 0c, APIC ID 2, APIC INT 0c
Int: type 0, pol 0, trig 0, bus 0, IRQ 0d, APIC ID 2, APIC INT 0d
Int: type 0, pol 0, trig 0, bus 0, IRQ 0e, APIC ID 2, APIC INT 0e
Int: type 0, pol 0, trig 0, bus 0, IRQ 0f, APIC ID 2, APIC INT 0f
Int: type 0, pol 3, trig 3, bus 1, IRQ 50, APIC ID 2, APIC INT 10
Int: type 0, pol 3, trig 3, bus 1, IRQ 4c, APIC ID 2, APIC INT 11
Int: type 0, pol 3, trig 3, bus 1, IRQ 48, APIC ID 2, APIC INT 12
Int: type 0, pol 3, trig 3, bus 1, IRQ 44, APIC ID 2, APIC INT 13
Int: type 2, pol 0, trig 0, bus 0, IRQ 00, APIC ID 2, APIC INT 17
Lint: type 3, pol 1, trig 1, bus 0, IRQ 00, APIC ID ff, APIC LINT 00
Lint: type 1, pol 1, trig 1, bus 0, IRQ 00, APIC ID ff, APIC LINT 01
Processors: 2
mapped APIC to ffffe000 (fee00000)
mapped IOAPIC to ffffd000 (fec00000)
Kernel command line: BOOT_IMAGE=2.4.5 ro root=802 BOOT_FILE=/2.4.5 ncr53c8xx=revprob:y console=ttyS0 init=/bin/bash
Initializing CPU#0
Detected 199.435 MHz processor.
Console: colour VGA+ 132x44
Calibrating delay loop... 398.13 BogoMIPS
Memory: 126312k/131072k available (1233k kernel code, 4372k reserved, 399k data, 208k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
Intel Pentium with F0 0F bug - workaround enabled.
Intel old style machine check architecture supported.
Intel old style machine check reporting enabled on CPU#0.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Intel old style machine check architecture supported.
Intel old style machine check reporting enabled on CPU#0.
CPU0: Intel Pentium MMX stepping 03
per-CPU timeslice cutoff: 159.71 usecs.
Getting VERSION: 30010
Getting VERSION: 30010
Getting ID: 0
Getting ID: f000000
Getting LVT0: 700
Getting LVT1: 400
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
CPU present map: 3
Booting processor 1/1 eip 2000
Setting warm reset code and vector.
1.
2.
3.
Asserting INIT.
Waiting for send to finish...
+Deasserting INIT.
Waiting for send to finish...
+#startup loops: 2.
Sending STARTUP #1.
After apic_write.
Initializing CPU#1
Startup point 1.
CPU#1 (phys ID: 1) waiting for CALLOUT
Waiting for send to finish...
+Sending STARTUP #2.
After apic_write.
Startup point 1.
Waiting for send to finish...
+After Startup.
Before Callout 1.
CALLIN, before setup_local_APIC().
After Callout 1.
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 398.13 BogoMIPS
Stack at about c12f7fbc
Intel old style machine check architecture supported.
Intel old style machine check reporting enabled on CPU#1.
OK.
CPU1: Intel Pentium MMX stepping 03
CPU has booted.
Before bogomips.
Total of 2 processors activated (796.26 BogoMIPS).
Before bogocount - setting activated=1.
Boot done.
ENABLING IO-APIC IRQs
...changing IO-APIC physical APIC ID to 2 ... ok.
Synchronizing Arb IDs.
..TIMER: vector=49 pin1=2 pin2=0
testing the IO APIC.......................

.................................... done.
calibrating APIC timer ...
..... CPU clock speed is 199.4272 MHz.
..... host bus clock speed is 66.4755 MHz.
cpu: 0, clocks: 664755, slice: 221585
CPU0<T0:664752,T1:443152,D:15,S:221585,C:664755>
cpu: 1, clocks: 664755, slice: 221585
CPU1<T0:664752,T1:221568,D:14,S:221585,C:664755>
checking TSC synchronization across CPUs: passed.
Setting commenced=1, go go go
PCI: PCI BIOS revision 2.10 entry at 0xfb420, last bus=0
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI->APIC IRQ transform: (B0,I17,P0) -> 19
PCI->APIC IRQ transform: (B0,I18,P0) -> 18
PCI->APIC IRQ transform: (B0,I19,P0) -> 17
PCI->APIC IRQ transform: (B0,I20,P0) -> 16
Limiting direct PCI/PCI transfers.
Activating ISA DMA hang workarounds.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
Serial driver version 5.05a (2001-03-20) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10d
block: queued sectors max/low 83824kB/27941kB, 256 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX3: IDE controller on PCI bus 00 dev 39
PIIX3: chipset revision 0
PIIX3: not 100% native mode: will probe irqs later
hda: Maxtor 7213 AT, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 415264 sectors (213 MB) w/64KiB Cache, CHS=683/16/38
Partition check:
 hda: hda1
early initialization of device teql0 is deferred
PPP generic driver version 2.4.1
SCSI subsystem driver Revision: 1.00
sym53c8xx: at PCI bus 0, device 17, function 0
sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)                                
sym53c8xx: 53c875 detected with Tekram NVRAM                                    
sym53c875-0: rev 0x26 on pci bus 0 device 17 function 0 irq 19                  
sym53c875-0: Tekram format NVRAM, ID 7, Fast-20, Parity Checking                
scsi0 : sym53c8xx-1.7.3a-20010304                                               
sym53c875-0-<0,*>: FAST-20 WIDE SCSI 40.0 MB/s (50.0 ns, offset 15)             
  Vendor: IBM       Model: DGHS09U           Rev: 0350                          
  Type:   Direct-Access                      ANSI SCSI revision: 03             
  Vendor: YAMAHA    Model: CRW4416S          Rev: 1.0g                          
  Type:   CD-ROM                             ANSI SCSI revision: 02             
Detected scsi disk sda at scsi0, channel 0, id 0, lun 0                         
SCSI device sda: 17916240 512-byte hdwr sectors (9173 MB)                       
 sda: sda1 sda2                                                                 
Detected scsi CD-ROM sr0 at scsi0, channel 0, id 6, lun 0                       
sym53c875-0-<6,*>: FAST-10 SCSI 8.0 MB/s (125.0 ns, offset 16)                  
sr0: scsi3-mmc drive: 16x/16x writer cd/rw xa/form2 cdda tray                   

-- 
		+---------------------------------+
		|      David Fries                |
		|      dfries@mail.win.org        |
		+---------------------------------+
