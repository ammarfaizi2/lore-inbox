Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265312AbSKEXAI>; Tue, 5 Nov 2002 18:00:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265313AbSKEXAI>; Tue, 5 Nov 2002 18:00:08 -0500
Received: from paloma13.e0k.nbg-hannover.de ([62.181.130.13]:7353 "HELO
	paloma13.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S265312AbSKEXAD> convert rfc822-to-8bit; Tue, 5 Nov 2002 18:00:03 -0500
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: 2.5.46: SCSI and/or ReiserFS v3.6 broken? Kernel panic
Date: Wed, 6 Nov 2002 00:06:10 +0100
User-Agent: KMail/1.4.7
Cc: ReiserFS List <reiserfs-list@namesys.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200211060006.10425.Dieter.Nuetzel@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

VFS: Cannot open root device "803" or 08:03
Please append a correct "root=" boot option
Kernel panic: VFS: unable to mount root fs on 08:03

With and without HugeTLB file system support.
With and without ACPI, APIC.

Worked all the time before.

dual Athlon MP 1900+
MSI K7D Master-L (aka Ms-6501) Rev 1.0, AMD 768MPX

How it looks with 2.4.19 + patches:

<4>Linux version 2.4.19-ck5-pc (root@SunWave1) (gcc version 2.95.3 20010315 
(SuSE)) #1 SMP
Sam Sep 7 04:20:05 CEST 2002
<6>BIOS-provided physical RAM map:
<4> BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
<4> BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
<4> BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
<4> BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
<4> BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
<4> BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
<4> BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
<5>127MB HIGHMEM available.
<5>896MB LOWMEM available.
<7>ACPI: have wakeup address 0xc0002000
<4>found SMP MP-table at 000f4af0
<4>hm, page 000f4000 reserved twice.
<4>hm, page 000f5000 reserved twice.
<4>hm, page 000f1000 reserved twice.
<4>hm, page 000f2000 reserved twice.
<6>Advanced speculative caching feature present
<4>On node 0 totalpages: 262128
<4>zone(0): 4096 pages.
<4>zone(1): 225280 pages.
<4>zone(2): 32752 pages.
<6>ACPI: RSDP (v000 AMD2P                      ) @ 0x000f6400
<6>ACPI: RSDT (v001 AMD2P  AWRDACPI 16944.11825) @ 0x3fff3000
<6>ACPI: FADT (v001 AMD2P  AWRDACPI 16944.11825) @ 0x3fff3040
<6>ACPI: MADT (v001 AMD2P  AWRDACPI 16944.11825) @ 0x3fff6480
<6>ACPI: Local APIC address 0xfee00000
<6>ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
<4>Processor #0 Pentium(tm) Pro APIC version 16
<6>ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
<4>Processor #1 Pentium(tm) Pro APIC version 16
<6>ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
<6>IOAPIC[0]: Assigned apic_id 2
<4>IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, IRQ 0-23
<6>ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] 
trigger[0x0])
<6>ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x3] 
trigger[0x3])
<6>Using ACPI (MADT) for SMP configuration information
<4>Kernel command line: auto BOOT_IMAGE=linux.old ro root=803 
BOOT_FILE=/boot/vmlinuz.old r
eboot=warm video=radeonfb:1280x1024-8@75
<6>Initializing CPU#0
<4>Detected 1600.096 MHz processor.
<4>Console: colour VGA+ 80x25
<4>Calibrating delay loop... 3191.60 BogoMIPS
<6>Memory: 1032628k/1048512k available (1350k kernel code, 15496k reserved, 
499k data, 100k init, 131008k highmem)

[-]

<6>SCSI subsystem driver Revision: 1.00
<6>scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
<4>        <Adaptec 29160B Ultra160 SCSI adapter>
<4>        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
<4>
<6>scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
<4>        <Adaptec 2940 Ultra SCSI adapter>
<4>        aic7880: Ultra Wide Channel A, SCSI Id=7, 16/253 SCBs
<4>
<4>  Vendor: IBM       Model: DDYS-T18350N      Rev: S96H
<4>  Type:   Direct-Access                      ANSI SCSI revision: 03
<4>scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
<4>  Vendor: IBM       Model: DDRS-34560D       Rev: DC1B
<4>  Type:   Direct-Access                      ANSI SCSI revision: 02
<4>  Vendor: IBM       Model: DDRS-34560W       Rev: S71D
<4>  Type:   Direct-Access                      ANSI SCSI revision: 02
<4>  Vendor: TOSHIBA   Model: DVD-ROM SD-M1401  Rev: 1010
<4>  Type:   CD-ROM                             ANSI SCSI revision: 02
<4>  Vendor: TEAC      Model: CD-W512SB         Rev: 1.0H
<4>  Type:   CD-ROM                             ANSI SCSI revision: 02
<4>scsi1:A:1:0: Tagged Queuing enabled.  Depth 253
<4>scsi1:A:2:0: Tagged Queuing enabled.  Depth 253
<4>Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
<4>Attached scsi disk sdb at scsi1, channel 0, id 1, lun 0
<4>Attached scsi disk sdc at scsi1, channel 0, id 2, lun 0
<4>(scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
<4>SCSI device sda: 35843670 512-byte hdwr sectors (18352 MB)
<6>Partition check:
<6> sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 >
<4>(scsi1:A:1): 40.000MB/s transfers (20.000MHz, offset 8, 16bit)
<4>SCSI device sdb: 8925000 512-byte hdwr sectors (4570 MB)
<6> sdb: sdb1 sdb2 < sdb5 sdb6 sdb7 sdb8 >
<4>(scsi1:A:2): 40.000MB/s transfers (20.000MHz, offset 8, 16bit)
<4>SCSI device sdc: 8925000 512-byte hdwr sectors (4570 MB)
<6> sdc: sdc1

[-]

<4>reiserfs: found format "3.6" with standard journal
<4>reiserfs: checking transaction log (sd(8,3)) for (sd(8,3))
<4>Using r5 hash to sort names
<4>VFS: Mounted root (reiserfs filesystem) readonly.
<6>Freeing unused kernel memory: 100k freed
<6>Adding Swap: 1028120k swap-space (priority -1)
<4>reiserfs: found format "3.6" with standard journal
<4>reiserfs: checking transaction log (sd(8,2)) for (sd(8,2))
<4>Using r5 hash to sort names
<4>reiserfs: found format "3.6" with standard journal
<4>reiserfs: checking transaction log (sd(8,5)) for (sd(8,5))
<4>Using r5 hash to sort names
<4>reiserfs: found format "3.6" with standard journal
<4>reiserfs: checking transaction log (sd(8,6)) for (sd(8,6))
<4>Using r5 hash to sort names
<4>reiserfs: found format "3.6" with standard journal
<4>reiserfs: checking transaction log (sd(8,7)) for (sd(8,7))
<4>Using r5 hash to sort names
<4>reiserfs: found format "3.6" with standard journal
<4>reiserfs: checking transaction log (sd(8,8)) for (sd(8,8))
<4>Using r5 hash to sort names
<4>reiserfs: found format "3.6" with standard journal
<4>reiserfs warning: wrong transaction max size (8192). Changed to 1024
<4>reiserfs: checking transaction log (sd(8,17)) for (sd(8,17))
<4>Using r5 hash to sort names
<4>reiserfs: found format "3.6" with standard journal
<4>reiserfs: checking transaction log (sd(8,21)) for (sd(8,21))
<4>Using r5 hash to sort names
<4>reiserfs: found format "3.6" with standard journal
<4>reiserfs: checking transaction log (sd(8,22)) for (sd(8,22))
<4>Using r5 hash to sort names
<4>reiserfs: found format "3.6" with standard journal
<4>reiserfs: checking transaction log (sd(8,23)) for (sd(8,23))
<4>Using r5 hash to sort names
<4>reiserfs: found format "3.6" with standard journal
<4>reiserfs: checking transaction log (sd(8,24)) for (sd(8,24))
<4>Using r5 hash to sort names

Thanks,
	Dieter
