Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263513AbTJBVxb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 17:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263514AbTJBVxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 17:53:30 -0400
Received: from mrout1.yahoo.com ([216.145.54.171]:57873 "EHLO mrout1.yahoo.com")
	by vger.kernel.org with ESMTP id S263513AbTJBVxQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 17:53:16 -0400
Message-ID: <3F7C9E1F.2020709@bigfoot.com>
Date: Thu, 02 Oct 2003 14:52:31 -0700
From: Erik Steffl <steffl@bigfoot.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i386; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin List-Petersen <martin@list-petersen.se>
CC: Jeff Garzik <jgarzik@pobox.com>,
       Andrew Marold <andrew.marold@wlm.edial.com>,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Bernhard Rosenkraenzer <bero@arklinux.org>
Subject: Re: Serial ATA on Dell Dimension 8300 (Was: Re: Serial ATA support
 in	2.4.22)
References: <C67EF1F46A97534FADC870220F3AC8B79D4FDD@exchange.edial.office>	 <3F7AEF15.1070301@pobox.com>  <3F7B0209.7070509@pobox.com> <1065130970.5842.193.camel@loke>
In-Reply-To: <1065130970.5842.193.camel@loke>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin List-Petersen wrote:
> I've got trouble with both 2.4.22-ac1, ac4 and 2.4.22-bk25 + newest sata
> patch. (Debian Sid)
> 
> When i try to boot ac1 or ac4 from harddisk. The kernel would fail by
> endless stating:
> kmod: failed to exec /sbin/modprobe -s -k binfmt-0000, errno = 8
> on screen.
> 
> Do i boot the same kernel from floppy or cd (syslinux/isolinux - dmesg for ac4 attached, bootet from cd) it boots without trouble, 
> mounts the harddisk etc.
> 
> The machine is a Dell Dimension 8300 (practically the same as the Precision 360), with Intel 875 chipset (ICH5 SATA controllers).
> In bk25+sata patch reiserfs seems to be broken (dmesg attached), i will try an older version tomorrow.
> 
> I simply can't figure out, whats wrong here.

   I have intel D865PERL mb (close but not same as you have, I think 
they have the same sata controller), I used the 2.4.21-ac4 kernel, with 
SCSI_ATA enabled (otherwise system freezes right after it detects HDs). 
I also had to use libata5 patches from Jeff Garzik  to be able to use 
drive >137GB (not sure whether libata5 are in one of the more recent 
kernels or ac patches).

	erik

> 
> Regards,
> Martin List-Petersen
> martin at list-petersen dot se
> --
> Microsoft DNS service terminates abnormally when it recieves a response
> to a DNS query that was never made. Fix Information: Run your DNS
> service on a different platform.
> -- BugTraq
> 
> 
> ------------------------------------------------------------------------
> 
> Linux version 2.4.22-bk25-20031002-odin (root@odin) (gcc version 3.3.2 20030908 (Debian prerelease)) #1 SMP tor okt 2 21:53:33 CEST 2003
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
>  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 000000003ff74000 (usable)
>  BIOS-e820: 000000003ff74000 - 000000003ff76000 (ACPI NVS)
>  BIOS-e820: 000000003ff76000 - 000000003ff97000 (ACPI data)
>  BIOS-e820: 000000003ff97000 - 0000000040000000 (reserved)
>  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
>  BIOS-e820: 00000000fecf0000 - 00000000fecf1000 (reserved)
>  BIOS-e820: 00000000fed20000 - 00000000fed90000 (reserved)
>  BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
>  BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
> 127MB HIGHMEM available.
> 896MB LOWMEM available.
> found SMP MP-table at 000fe710
> hm, page 000fe000 reserved twice.
> hm, page 000ff000 reserved twice.
> hm, page 000f0000 reserved twice.
> On node 0 totalpages: 262004
> zone(0): 4096 pages.
> zone(1): 225280 pages.
> zone(2): 32628 pages.
> ACPI: RSDP (v000 DELL                                      ) @ 0x000feb90
> ACPI: RSDT (v001 DELL    8300    0x00000007 ASL  0x00000061) @ 0x000fd1ca
> ACPI: FADT (v001 DELL    8300    0x00000007 ASL  0x00000061) @ 0x000fd1fe
> ACPI: SSDT (v001   DELL    st_ex 0x00001000 MSFT 0x0100000d) @ 0xfffc8937
> ACPI: MADT (v001 DELL    8300    0x00000007 ASL  0x00000061) @ 0x000fd272
> ACPI: BOOT (v001 DELL    8300    0x00000007 ASL  0x00000061) @ 0x000fd2de
> ACPI: DSDT (v001   DELL    dt_ex 0x00001000 MSFT 0x0100000d) @ 0x00000000
> ACPI: Local APIC address 0xfee00000
> ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
> Processor #0 Pentium 4(tm) XEON(tm) APIC version 20
> ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
> Processor #1 Pentium 4(tm) XEON(tm) APIC version 20
> ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] disabled)
> ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] disabled)
> ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
> IOAPIC[0]: Assigned apic_id 2
> IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, IRQ 0-23
> ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x0])
> ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x1] trigger[0x3])
> Using ACPI (MADT) for SMP configuration information
> Kernel command line: root=/dev/sda2 ro console=tty0 console=ttyS0,9600n8 BOOT_IMAGE=linux.bin
> Initializing CPU#0
> Detected 2992.564 MHz processor.
> Console: colour VGA+ 80x25
> Calibrating delay loop... 5976.88 BogoMIPS
> Memory: 1031936k/1048016k available (1977k kernel code, 15696k reserved, 655k data, 132k init, 130512k highmem)
> Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
> Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
> Mount cache hash table entries: 512 (order: 0, 4096 bytes)
> Buffer cache hash table entries: 65536 (order: 6, 262144 bytes)
> Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
> CPU: Trace cache: 12K uops, L1 D cache: 8K
> CPU: L2 cache: 512K
> CPU: Physical Processor ID: 0
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#0.
> Enabling fast FPU save and restore... done.
> Enabling unmasked SIMD FPU exception support... done.
> Checking 'hlt' instruction... OK.
> POSIX conformance testing by UNIFIX
> mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
> mtrr: detected mtrr type: Intel
> CPU: Trace cache: 12K uops, L1 D cache: 8K
> CPU: L2 cache: 512K
> CPU: Physical Processor ID: 0
> Intel machine check reporting enabled on CPU#0.
> CPU0: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 09
> per-CPU timeslice cutoff: 1462.91 usecs.
> enabled ExtINT on CPU#0
> ESR value before enabling vector: 00000040
> ESR value after enabling vector: 00000000
> Booting processor 1/1 eip 3000
> Initializing CPU#1
> masked ExtINT on CPU#1
> ESR value before enabling vector: 00000000
> ESR value after enabling vector: 00000000
> Calibrating delay loop... 5976.88 BogoMIPS
> CPU: Trace cache: 12K uops, L1 D cache: 8K
> CPU: L2 cache: 512K
> CPU: Physical Processor ID: 0
> Intel machine check reporting enabled on CPU#1.
> CPU1: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 09
> Total of 2 processors activated (11953.76 BogoMIPS).
> cpu_sibling_map[0] = 1
> cpu_sibling_map[1] = 0
> ENABLING IO-APIC IRQs
> ..TIMER: vector=0x31 pin1=2 pin2=0
> testing the IO APIC.......................
>                                                                                                                                                 
> .................................... done.
> Using local APIC timer interrupts.
> calibrating APIC timer ...
> ..... CPU clock speed is 2992.4180 MHz.
> ..... host bus clock speed is 199.4944 MHz.
> cpu: 0, clocks: 1994944, slice: 664981
> CPU0<T0:1994944,T1:1329952,D:11,S:664981,C:1994944>
> cpu: 1, clocks: 1994944, slice: 664981
> CPU1<T0:1994944,T1:664976,D:6,S:664981,C:1994944>
> checking TSC synchronization across CPUs: passed.
> Waiting on wait_init_idle (map = 0x2)
> All processors have done init_idle
> ACPI: Subsystem revision 20030916
> PCI: PCI BIOS revision 2.10 entry at 0xfbb30, last bus=2
> PCI: Using configuration type 1
> ACPI: Interpreter enabled
> ACPI: Using IOAPIC for interrupt routing
> ACPI: System [ACPI] (supports S0 S1 S3 S4 S5)
> ACPI: PCI Root Bridge [PCI0] (00:00)
> PCI: Probing PCI hardware (bus 00)
> PCI: Ignoring BAR0-3 of IDE controller 00:1f.1
> Transparent bridge - Intel Corp. 82801BA/CA/DB/EB PCI Bridge
> ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 15)
> ACPI: PCI Interrupt Link [LNKB] (IRQs *3 4 5 6 7 9 10 11 12 15)
> ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *9 10 11 12 15)
> ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12 15)
> ACPI: PCI Interrupt Link [LNKE] (IRQs *3 4 5 6 7 9 10 11 12 15)
> ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 *10 11 12 15)
> ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 *5 6 7 9 10 11 12 15)
> ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 *5 6 7 9 10 11 12 15)
> PCI: Probing PCI hardware
> PCI: Using ACPI for IRQ routing
> PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
> Linux NET4.0 for Linux 2.4
> Based upon Swansea University Computer Society NET3.039
> Initializing RT netlink socket
> IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
> Starting kswapd
> allocated 32 pages and 32 bhs reserved for the highmem bounces
> VFS: Disk quotas vdquot_6.5.1
> Journalled Block Device driver loaded
> devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
> devfs: boot_options: 0x0
> ACPI: Processor [CPU0] (supports C1)
> ACPI: Processor [CPU1] (supports C1)
> pty: 256 Unix98 ptys configured
> Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
> ttyS00 at 0x03f8 (irq = 4) is a 16550A
> Floppy drive(s): fd0 is 1.44M
> FDC 0 is a post-1991 82077
> RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
> loop: loaded (max 8 devices)
> Intel(R) PRO/100 Network Driver - version 2.3.18-k1
> Copyright (c) 2003 Intel Corporation
>                                                                                                                                                 
> e100: eth0: Intel(R) PRO/100 Network Connection
>   Hardware receive checksums enabled
>                                                                                                                                                 
> Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> ICH5: IDE controller at PCI slot 00:1f.1
> ICH5: chipset revision 2
> ICH5: not 100% native mode: will probe irqs later
>     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:DMA
> ICH5-SATA: IDE controller at PCI slot 00:1f.2
> ICH5-SATA: chipset revision 2
> ICH5-SATA: 100% native mode on irq 18
>     ide0: BM-DMA at 0xfea0-0xfea7, BIOS settings: hda:DMA, hdb:pio
> hda: ST3120026AS, ATA DISK drive
> hdb: probing with STATUS(0x00) instead of ALTSTATUS(0x50)
> hdb: probing with STATUS(0x00) instead of ALTSTATUS(0x50)
> blk: queue c041d460, I/O limit 4095Mb (mask 0xffffffff)
> hdc: SAMSUNG DVD-ROM SD-616T, ATAPI CD/DVD-ROM drive
> hdd: _NEC DVD+RW ND-1100A, ATAPI CD/DVD-ROM drive
> ide0 at 0xfe00-0xfe07,0xfe12 on irq 18
> ide1 at 0x170-0x177,0x376 on irq 15
> hda: attached ide-disk driver.
> hda: host protected area => 1
> hda: 234375000 sectors (120000 MB) w/8192KiB Cache, CHS=14589/255/63, UDMA(33)
> hdc: attached ide-cdrom driver.
> hdc: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
> Uniform CD-ROM driver Revision: 3.12
> hdd: attached ide-cdrom driver.
> hdd: ATAPI 40X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
> Partition check:
>  /dev/ide/host0/bus0/target0/lun0: p1 p2
> SCSI subsystem driver Revision: 1.00
> kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
> kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
> kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
> i2c-core.o: i2c core module version 2.8.0 (20030714)
> i2c-dev.o: i2c /dev entries driver module version 2.8.0 (20030714)
> i2c-proc.o version 2.8.0 (20030714)
> Initializing Cryptographic API
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols: ICMP, UDP, TCP, IGMP
> IP: routing cache hash table of 8192 buckets, 64Kbytes
> TCP: Hash tables configured (established 262144 bind 65536)
> Linux IP multicast router 0.06 plus PIM-SM
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> VFS: Cannot open root device "sda2" or 08:02
> Please append a correct "root=" boot option
> Kernel panic: VFS: Unable to mount root fs on 08:02


