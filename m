Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261433AbVACMwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbVACMwM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 07:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbVACMwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 07:52:12 -0500
Received: from anor.ics.muni.cz ([147.251.4.35]:58567 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id S261433AbVACMwC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 07:52:02 -0500
Date: Mon, 3 Jan 2005 13:52:00 +0100
From: Jan Kasprzak <kas@fi.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: Altix hang on boot with 2.6.8+
Message-ID: <20050103125200.GK26303@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Muni-Spam-TestIP: 147.251.48.42
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

I cannot boot a 2.6.8 or 2.6.10 kernel on my SGI Altix - it hangs during
boot after printing this:

[...]
CPU 0: base freq=200.000MHz, ITC ratio=14/2, ITC freq=1400.000MHz+/--1ppm
Console: colour dummy device 80x25

(from the 2.4 boot messages it seems that tha BogoMips test should
be the next line). 2.6.6 boots fine. I have also tried CONFIG_EFI_PCDP
and console=hcdp. 

The system is 3-node (6-cpu) Altix 350 running SLES 8.
Can 2.6.8+ boot on Altix 350? I may test 2.6.7 or -rc* if you want.

Full boot messages are here:

Linux version 2.6.8 (root@hostname) (gcc version 3.2.2) #2 SMP Mon Jan 3 13:35:16 CET 2005
EFI v1.02 by SGI: SALsystab=0x3002514a60 ACPI 2.0=0x3002514b60
ACPI: RSDP (v002    SGI                                    ) @ 0x0000003002514b60
ACPI: XSDT (v001    SGI  XSDTSN2 0x00010001  0x00000001) @ 0x00000030027a07d0
ACPI: MADT (v001    SGI  APICSN2 0x00010001  0x00000001) @ 0x0000003002514ba0
ACPI: SRAT (v001    SGI  SRATSN2 0x00010001  0x00000001) @ 0x00000030027a0830
ACPI: SLIT (v001    SGI  SLITSN2 0x00010001  0x00000001) @ 0x0000003002514c30
ACPI: FADT (v003    SGI  FACPSN2 0x00030001  0x00000001) @ 0x00000030027a09a0
ACPI: DSDT (v001    SGI  DSDTSN2 0x00010001  0x00000001) @ 0x0000003002514c80
ACPI: DSDT (v001    SGI  DSDTSN2 0x00010001  0x00000001) @ 0x0000000000000000
ACPI: SRAT revision 0
ACPI: SLIT localities 3x3
Number of logical nodes in system = 3
Number of memory chunks in system = 3
SAL 2.9: SGI SN2 version 4.4
SAL Platform features: ITC_Drift
SAL: AP wakeup using external interrupt vector 0x12
ACPI: Local APIC address 0xc0000000fee00000
ACPI: Error parsing MADT - no IOSAPIC entries
register_intr: No IOSAPIC for GSI 52
GSI 52 (level, low) -> CPU 0 (0x0000) vector 48
6 CPUs available, 6 CPUs total
Registering legacy COM ports for serial console
Increasing MCA rendezvous timeout from 20000 to 49000 milliseconds
MCA related initialization done
SGI SAL version 4.04
Virtual mem_map starts at 0xa0007ffef2138000
Built 3 zonelists
Kernel command line: BOOT_IMAGE=scsi0:/vmlinuz-2.6.10 root=900 ide=nodma hwprobe=-bios ro console=ttyS0
ide_setup: ide=nodmaIDE: Prevented DMA
PID hash table entries: 4096 (order 12: 65536 bytes)
CPU 0: base freq=200.000MHz, ITC ratio=14/2, ITC freq=1400.000MHz+/--1ppm
Console: colour dummy device 80x25
Linux version 2.6.8 (root@hostname) (gcc version 3.2.2) #2 SMP Mon Jan 3 13:35:16 CET 2005
EFI v1.02 by SGI: SALsystab=0x3002514a60 ACPI 2.0=0x3002514b60
ACPI: RSDP (v002    SGI                                    ) @ 0x0000003002514b60
ACPI: XSDT (v001    SGI  XSDTSN2 0x00010001  0x00000001) @ 0x00000030027a07d0
ACPI: MADT (v001    SGI  APICSN2 0x00010001  0x00000001) @ 0x0000003002514ba0
ACPI: SRAT (v001    SGI  SRATSN2 0x00010001  0x00000001) @ 0x00000030027a0830
ACPI: SLIT (v001    SGI  SLITSN2 0x00010001  0x00000001) @ 0x0000003002514c30
ACPI: FADT (v003    SGI  FACPSN2 0x00030001  0x00000001) @ 0x00000030027a09a0
ACPI: DSDT (v001    SGI  DSDTSN2 0x00010001  0x00000001) @ 0x0000003002514c80
ACPI: DSDT (v001    SGI  DSDTSN2 0x00010001  0x00000001) @ 0x0000000000000000
ACPI: SRAT revision 0
ACPI: SLIT localities 3x3
Number of logical nodes in system = 3
Number of memory chunks in system = 3
SAL 2.9: SGI SN2 version 4.4
SAL Platform features: ITC_Drift
SAL: AP wakeup using external interrupt vector 0x12
ACPI: Local APIC address 0xc0000000fee00000
ACPI: Error parsing MADT - no IOSAPIC entries
register_intr: No IOSAPIC for GSI 52
GSI 52 (level, low) -> CPU 0 (0x0000) vector 48
6 CPUs available, 6 CPUs total
Registering legacy COM ports for serial console
Increasing MCA rendezvous timeout from 20000 to 49000 milliseconds
MCA related initialization done
SGI SAL version 4.04
Virtual mem_map starts at 0xa0007ffef2138000
Built 3 zonelists
Kernel command line: BOOT_IMAGE=scsi0:/vmlinuz-2.6.10 root=900 ide=nodma hwprobe=-bios ro console=ttyS0
ide_setup: ide=nodmaIDE: Prevented DMA
PID hash table entries: 4096 (order 12: 65536 bytes)
CPU 0: base freq=200.000MHz, ITC ratio=14/2, ITC freq=1400.000MHz+/--1ppm
Console: colour dummy device 80x25

	Thanks,

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
> Whatever the Java applications and desktop dances may lead to, Unix will <
> still be pushing the packets around for a quite a while.      --Rob Pike <
