Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263262AbTKEWYK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 17:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263259AbTKEWX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 17:23:58 -0500
Received: from zok.SGI.COM ([204.94.215.101]:31369 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S263244AbTKEWWE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 17:22:04 -0500
Date: Wed, 5 Nov 2003 14:22:02 -0800
To: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: [DMESG] cpumask_t in action
Message-ID: <20031105222202.GA24119@sgi.com>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	linux-ia64@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At the kernel summit, Andrew asked if we really needed cpumask_t in the
kernel to support > BITS_PER_LONG CPUs.  We've sent out patches to fix
issues we've seen with large systems, but I realized that we had never
sent the dmesg of such a system booting up.  Some customers have much
larger systems than the I used here, so don't be lulled into thinking
that 2*BITS_PER_LONG is sufficient :).

I'm Cc'ing linux-ia64 because I think we have a lot of boot messages to
cleanup in arch/ia64...

Thanks,
Jesse

Linux version 2.6.0-test9 (jbarnes@tomahawk.engr.sgi.com) (gcc version 3.3.2) #1 SMP Wed Nov 5 14:05:25 PST 2003
EFI v1.02 by SGI: SALsystab=0x3004721d70 ACPI 2.0=0x3004721e40
ACPI: RSDP (v002    SGI                                    ) @ 0x0000003004721e40
ACPI: XSDT (v001    SGI  XSDTSN2 0x00010001  0x00000001) @ 0x0000003004722820
ACPI: MADT (v001    SGI  APICSN2 0x00010001  0x00000001) @ 0x0000003004722880
ACPI: SRAT (v001    SGI  SRATSN2 0x00010001  0x00000001) @ 0x0000003004722d40
ACPI: SLIT (v001    SGI  SLITSN2 0x00010001  0x00000001) @ 0x0000003004723b00
ACPI: FADT (v003    SGI  FACPSN2 0x00030001  0x00000001) @ 0x00000030047244d0
ACPI: DSDT (v001    SGI  DSDTSN2 0x00010001  0x00000001) @ 0x0000003004724490
ACPI:  (v000                 0x00000000  0x00000000) @ 0x0000000000000000
ACPI: SRAT revision 0
ACPI: SRAT Processor (id[0x00] eid[0x00]) in proximity domain 0 enabled
ACPI: SRAT Processor (id[0x20] eid[0x00]) in proximity domain 0 enabled
ACPI: SRAT Processor (id[0x00] eid[0x02]) in proximity domain 1 enabled
ACPI: SRAT Processor (id[0x20] eid[0x02]) in proximity domain 1 enabled
ACPI: SRAT Processor (id[0x00] eid[0x04]) in proximity domain 2 enabled
ACPI: SRAT Processor (id[0x20] eid[0x04]) in proximity domain 2 enabled
ACPI: SRAT Processor (id[0x00] eid[0x06]) in proximity domain 3 enabled
ACPI: SRAT Processor (id[0x20] eid[0x06]) in proximity domain 3 enabled
ACPI: SRAT Processor (id[0x00] eid[0x08]) in proximity domain 4 enabled
ACPI: SRAT Processor (id[0x20] eid[0x08]) in proximity domain 4 enabled
ACPI: SRAT Processor (id[0x00] eid[0x0a]) in proximity domain 5 enabled
ACPI: SRAT Processor (id[0x20] eid[0x0a]) in proximity domain 5 enabled
ACPI: SRAT Processor (id[0x00] eid[0x0c]) in proximity domain 6 enabled
ACPI: SRAT Processor (id[0x20] eid[0x0c]) in proximity domain 6 enabled
ACPI: SRAT Processor (id[0x00] eid[0x0e]) in proximity domain 7 enabled
ACPI: SRAT Processor (id[0x20] eid[0x0e]) in proximity domain 7 enabled
ACPI: SRAT Processor (id[0x00] eid[0x10]) in proximity domain 8 enabled
ACPI: SRAT Processor (id[0x20] eid[0x10]) in proximity domain 8 enabled
ACPI: SRAT Processor (id[0x00] eid[0x12]) in proximity domain 9 enabled
ACPI: SRAT Processor (id[0x20] eid[0x12]) in proximity domain 9 enabled
ACPI: SRAT Processor (id[0x00] eid[0x14]) in proximity domain 10 enabled
ACPI: SRAT Processor (id[0x20] eid[0x14]) in proximity domain 10 enabled
ACPI: SRAT Processor (id[0x00] eid[0x16]) in proximity domain 11 enabled
ACPI: SRAT Processor (id[0x20] eid[0x16]) in proximity domain 11 enabled
ACPI: SRAT Processor (id[0x00] eid[0x18]) in proximity domain 12 enabled
ACPI: SRAT Processor (id[0x20] eid[0x18]) in proximity domain 12 enabled
ACPI: SRAT Processor (id[0x00] eid[0x1a]) in proximity domain 13 enabled
ACPI: SRAT Processor (id[0x20] eid[0x1a]) in proximity domain 13 enabled
ACPI: SRAT Processor (id[0x00] eid[0x1c]) in proximity domain 14 enabled
ACPI: SRAT Processor (id[0x20] eid[0x1c]) in proximity domain 14 enabled
ACPI: SRAT Processor (id[0x00] eid[0x1e]) in proximity domain 15 enabled
ACPI: SRAT Processor (id[0x20] eid[0x1e]) in proximity domain 15 enabled
ACPI: SRAT Processor (id[0x00] eid[0x20]) in proximity domain 16 enabled
ACPI: SRAT Processor (id[0x20] eid[0x20]) in proximity domain 16 enabled
ACPI: SRAT Processor (id[0x00] eid[0x22]) in proximity domain 17 enabled
ACPI: SRAT Processor (id[0x20] eid[0x22]) in proximity domain 17 enabled
ACPI: SRAT Processor (id[0x00] eid[0x24]) in proximity domain 18 enabled
ACPI: SRAT Processor (id[0x20] eid[0x24]) in proximity domain 18 enabled
ACPI: SRAT Processor (id[0x00] eid[0x26]) in proximity domain 19 enabled
ACPI: SRAT Processor (id[0x20] eid[0x26]) in proximity domain 19 enabled
ACPI: SRAT Processor (id[0x00] eid[0x28]) in proximity domain 20 enabled
ACPI: SRAT Processor (id[0x20] eid[0x28]) in proximity domain 20 enabled
ACPI: SRAT Processor (id[0x00] eid[0x2a]) in proximity domain 21 enabled
ACPI: SRAT Processor (id[0x20] eid[0x2a]) in proximity domain 21 enabled
ACPI: SRAT Processor (id[0x00] eid[0x2c]) in proximity domain 22 enabled
ACPI: SRAT Processor (id[0x20] eid[0x2c]) in proximity domain 22 enabled
ACPI: SRAT Processor (id[0x00] eid[0x2e]) in proximity domain 23 enabled
ACPI: SRAT Processor (id[0x20] eid[0x2e]) in proximity domain 23 enabled
ACPI: SRAT Processor (id[0x00] eid[0x30]) in proximity domain 24 enabled
ACPI: SRAT Processor (id[0x20] eid[0x30]) in proximity domain 24 enabled
ACPI: SRAT Processor (id[0x00] eid[0x32]) in proximity domain 25 enabled
ACPI: SRAT Processor (id[0x20] eid[0x32]) in proximity domain 25 enabled
ACPI: SRAT Processor (id[0x00] eid[0x34]) in proximity domain 26 enabled
ACPI: SRAT Processor (id[0x20] eid[0x34]) in proximity domain 26 enabled
ACPI: SRAT Processor (id[0x00] eid[0x36]) in proximity domain 27 enabled
ACPI: SRAT Processor (id[0x20] eid[0x36]) in proximity domain 27 enabled
ACPI: SRAT Processor (id[0x00] eid[0x38]) in proximity domain 28 enabled
ACPI: SRAT Processor (id[0x20] eid[0x38]) in proximity domain 28 enabled
ACPI: SRAT Processor (id[0x00] eid[0x3a]) in proximity domain 29 enabled
ACPI: SRAT Processor (id[0x20] eid[0x3a]) in proximity domain 29 enabled
ACPI: SRAT Processor (id[0x00] eid[0x3c]) in proximity domain 30 enabled
ACPI: SRAT Processor (id[0x20] eid[0x3c]) in proximity domain 30 enabled
ACPI: SRAT Processor (id[0x00] eid[0x3e]) in proximity domain 31 enabled
ACPI: SRAT Processor (id[0x20] eid[0x3e]) in proximity domain 31 enabled
ACPI: SRAT Processor (id[0x00] eid[0x40]) in proximity domain 32 enabled
ACPI: SRAT Processor (id[0x20] eid[0x40]) in proximity domain 32 enabled
ACPI: SRAT Processor (id[0x00] eid[0x42]) in proximity domain 33 enabled
ACPI: SRAT Processor (id[0x20] eid[0x42]) in proximity domain 33 enabled
ACPI: SRAT Processor (id[0x00] eid[0x44]) in proximity domain 34 enabled
ACPI: SRAT Processor (id[0x20] eid[0x44]) in proximity domain 34 enabled
ACPI: SRAT Processor (id[0x00] eid[0x46]) in proximity domain 35 enabled
ACPI: SRAT Processor (id[0x20] eid[0x46]) in proximity domain 35 enabled
ACPI: SRAT Processor (id[0x00] eid[0x48]) in proximity domain 36 enabled
ACPI: SRAT Processor (id[0x20] eid[0x48]) in proximity domain 36 enabled
ACPI: SRAT Processor (id[0x00] eid[0x4a]) in proximity domain 37 enabled
ACPI: SRAT Processor (id[0x20] eid[0x4a]) in proximity domain 37 enabled
ACPI: SRAT Processor (id[0x00] eid[0x4c]) in proximity domain 38 enabled
ACPI: SRAT Processor (id[0x20] eid[0x4c]) in proximity domain 38 enabled
ACPI: SRAT Processor (id[0x00] eid[0x4e]) in proximity domain 39 enabled
ACPI: SRAT Processor (id[0x20] eid[0x4e]) in proximity domain 39 enabled
ACPI: SRAT Processor (id[0x00] eid[0x50]) in proximity domain 40 enabled
ACPI: SRAT Processor (id[0x20] eid[0x50]) in proximity domain 40 enabled
ACPI: SRAT Processor (id[0x00] eid[0x52]) in proximity domain 41 enabled
ACPI: SRAT Processor (id[0x20] eid[0x52]) in proximity domain 41 enabled
ACPI: SRAT Processor (id[0x00] eid[0x54]) in proximity domain 42 enabled
ACPI: SRAT Processor (id[0x20] eid[0x54]) in proximity domain 42 enabled
ACPI: SRAT Processor (id[0x00] eid[0x56]) in proximity domain 43 enabled
ACPI: SRAT Processor (id[0x20] eid[0x56]) in proximity domain 43 enabled
ACPI: SRAT Processor (id[0x00] eid[0x58]) in proximity domain 44 enabled
ACPI: SRAT Processor (id[0x20] eid[0x58]) in proximity domain 44 enabled
ACPI: SRAT Processor (id[0x00] eid[0x5a]) in proximity domain 45 enabled
ACPI: SRAT Processor (id[0x20] eid[0x5a]) in proximity domain 45 enabled
ACPI: SRAT Processor (id[0x00] eid[0x5c]) in proximity domain 46 enabled
ACPI: SRAT Processor (id[0x20] eid[0x5c]) in proximity domain 46 enabled
ACPI: SRAT Processor (id[0x00] eid[0x5e]) in proximity domain 47 enabled
ACPI: SRAT Processor (id[0x20] eid[0x5e]) in proximity domain 47 enabled
ACPI: SRAT Memory (0x0000003000000000 length 0x0000001000000000 type 0x1) in proximity domain 0 enabled
ACPI: SRAT Memory (0x000000b000000000 length 0x0000001000000000 type 0x1) in proximity domain 1 enabled
ACPI: SRAT Memory (0x0000013000000000 length 0x0000001000000000 type 0x1) in proximity domain 2 enabled
ACPI: SRAT Memory (0x000001b000000000 length 0x0000001000000000 type 0x1) in proximity domain 3 enabled
ACPI: SRAT Memory (0x0000023000000000 length 0x0000001000000000 type 0x1) in proximity domain 4 enabled
ACPI: SRAT Memory (0x000002b000000000 length 0x0000001000000000 type 0x1) in proximity domain 5 enabled
ACPI: SRAT Memory (0x0000033000000000 length 0x0000001000000000 type 0x1) in proximity domain 6 enabled
ACPI: SRAT Memory (0x000003b000000000 length 0x0000001000000000 type 0x1) in proximity domain 7 enabled
ACPI: SRAT Memory (0x0000043000000000 length 0x0000001000000000 type 0x1) in proximity domain 8 enabled
ACPI: SRAT Memory (0x000004b000000000 length 0x0000001000000000 type 0x1) in proximity domain 9 enabled
ACPI: SRAT Memory (0x0000053000000000 length 0x0000001000000000 type 0x1) in proximity domain 10 enabled
ACPI: SRAT Memory (0x000005b000000000 length 0x0000001000000000 type 0x1) in proximity domain 11 enabled
ACPI: SRAT Memory (0x0000063000000000 length 0x0000001000000000 type 0x1) in proximity domain 12 enabled
ACPI: SRAT Memory (0x000006b000000000 length 0x0000001000000000 type 0x1) in proximity domain 13 enabled
ACPI: SRAT Memory (0x0000073000000000 length 0x0000001000000000 type 0x1) in proximity domain 14 enabled
ACPI: SRAT Memory (0x000007b000000000 length 0x0000001000000000 type 0x1) in proximity domain 15 enabled
ACPI: SRAT Memory (0x0000083000000000 length 0x0000001000000000 type 0x1) in proximity domain 16 enabled
ACPI: SRAT Memory (0x000008b000000000 length 0x0000001000000000 type 0x1) in proximity domain 17 enabled
ACPI: SRAT Memory (0x0000093000000000 length 0x0000001000000000 type 0x1) in proximity domain 18 enabled
ACPI: SRAT Memory (0x000009b000000000 length 0x0000001000000000 type 0x1) in proximity domain 19 enabled
ACPI: SRAT Memory (0x00000a3000000000 length 0x0000001000000000 type 0x1) in proximity domain 20 enabled
ACPI: SRAT Memory (0x00000ab000000000 length 0x0000001000000000 type 0x1) in proximity domain 21 enabled
ACPI: SRAT Memory (0x00000b3000000000 length 0x0000001000000000 type 0x1) in proximity domain 22 enabled
ACPI: SRAT Memory (0x00000bb000000000 length 0x0000001000000000 type 0x1) in proximity domain 23 enabled
ACPI: SRAT Memory (0x00000c3000000000 length 0x0000001000000000 type 0x1) in proximity domain 24 enabled
ACPI: SRAT Memory (0x00000cb000000000 length 0x0000001000000000 type 0x1) in proximity domain 25 enabled
ACPI: SRAT Memory (0x00000d3000000000 length 0x0000001000000000 type 0x1) in proximity domain 26 enabled
ACPI: SRAT Memory (0x00000db000000000 length 0x0000001000000000 type 0x1) in proximity domain 27 enabled
ACPI: SRAT Memory (0x00000e3000000000 length 0x0000001000000000 type 0x1) in proximity domain 28 enabled
ACPI: SRAT Memory (0x00000eb000000000 length 0x0000001000000000 type 0x1) in proximity domain 29 enabled
ACPI: SRAT Memory (0x00000f3000000000 length 0x0000001000000000 type 0x1) in proximity domain 30 enabled
ACPI: SRAT Memory (0x00000fb000000000 length 0x0000001000000000 type 0x1) in proximity domain 31 enabled
ACPI: SRAT Memory (0x0000103000000000 length 0x0000001000000000 type 0x1) in proximity domain 32 enabled
ACPI: SRAT Memory (0x000010b000000000 length 0x0000001000000000 type 0x1) in proximity domain 33 enabled
ACPI: SRAT Memory (0x0000113000000000 length 0x0000001000000000 type 0x1) in proximity domain 34 enabled
ACPI: SRAT Memory (0x000011b000000000 length 0x0000001000000000 type 0x1) in proximity domain 35 enabled
ACPI: SRAT Memory (0x0000123000000000 length 0x0000001000000000 type 0x1) in proximity domain 36 enabled
ACPI: SRAT Memory (0x000012b000000000 length 0x0000001000000000 type 0x1) in proximity domain 37 enabled
ACPI: SRAT Memory (0x0000133000000000 length 0x0000001000000000 type 0x1) in proximity domain 38 enabled
ACPI: SRAT Memory (0x000013b000000000 length 0x0000001000000000 type 0x1) in proximity domain 39 enabled
ACPI: SRAT Memory (0x0000143000000000 length 0x0000001000000000 type 0x1) in proximity domain 40 enabled
ACPI: SRAT Memory (0x000014b000000000 length 0x0000001000000000 type 0x1) in proximity domain 41 enabled
ACPI: SRAT Memory (0x0000153000000000 length 0x0000001000000000 type 0x1) in proximity domain 42 enabled
ACPI: SRAT Memory (0x000015b000000000 length 0x0000001000000000 type 0x1) in proximity domain 43 enabled
ACPI: SRAT Memory (0x0000163000000000 length 0x0000001000000000 type 0x1) in proximity domain 44 enabled
ACPI: SRAT Memory (0x000016b000000000 length 0x0000001000000000 type 0x1) in proximity domain 45 enabled
ACPI: SRAT Memory (0x0000173000000000 length 0x0000001000000000 type 0x1) in proximity domain 46 enabled
ACPI: SRAT Memory (0x000017b000000000 length 0x0000001000000000 type 0x1) in proximity domain 47 enabled
ACPI: SLIT localities 48x48
Number of logical nodes in system = 48
Number of memory chunks in system = 48
SAL v2.09: oem=SGI, product=SN2
SAL: entry: pal_proc=0xfff800, sal_proc=0xfffc00
SAL: Platform features ITC_Drift 
SAL: AP wakeup using external interrupt vector 0x12
CPU 0: 61 virtual and 50 physical address bits
ACPI: Local APIC address 0xc0000000fee00000
ACPI: LSAPIC (acpi_id[0x00] lsapic_id[0x00] lsapic_eid[0x00] enabled)
CPU 0 (0x0000) enabled (BSP)
ACPI: LSAPIC (acpi_id[0x01] lsapic_id[0x20] lsapic_eid[0x00] enabled)
CPU 1 (0x2000) enabled
ACPI: LSAPIC (acpi_id[0x02] lsapic_id[0x00] lsapic_eid[0x02] enabled)
CPU 2 (0x0002) enabled
ACPI: LSAPIC (acpi_id[0x03] lsapic_id[0x20] lsapic_eid[0x02] enabled)
CPU 3 (0x2002) enabled
ACPI: LSAPIC (acpi_id[0x04] lsapic_id[0x00] lsapic_eid[0x04] enabled)
CPU 4 (0x0004) enabled
ACPI: LSAPIC (acpi_id[0x05] lsapic_id[0x20] lsapic_eid[0x04] enabled)
CPU 5 (0x2004) enabled
ACPI: LSAPIC (acpi_id[0x06] lsapic_id[0x00] lsapic_eid[0x06] enabled)
CPU 6 (0x0006) enabled
ACPI: LSAPIC (acpi_id[0x07] lsapic_id[0x20] lsapic_eid[0x06] enabled)
CPU 7 (0x2006) enabled
ACPI: LSAPIC (acpi_id[0x08] lsapic_id[0x00] lsapic_eid[0x08] enabled)
CPU 8 (0x0008) enabled
ACPI: LSAPIC (acpi_id[0x09] lsapic_id[0x20] lsapic_eid[0x08] enabled)
CPU 9 (0x2008) enabled
ACPI: LSAPIC (acpi_id[0x0a] lsapic_id[0x00] lsapic_eid[0x0a] enabled)
CPU 10 (0x000a) enabled
ACPI: LSAPIC (acpi_id[0x0b] lsapic_id[0x20] lsapic_eid[0x0a] enabled)
CPU 11 (0x200a) enabled
ACPI: LSAPIC (acpi_id[0x0c] lsapic_id[0x00] lsapic_eid[0x0c] enabled)
CPU 12 (0x000c) enabled
ACPI: LSAPIC (acpi_id[0x0d] lsapic_id[0x20] lsapic_eid[0x0c] enabled)
CPU 13 (0x200c) enabled
ACPI: LSAPIC (acpi_id[0x0e] lsapic_id[0x00] lsapic_eid[0x0e] enabled)
CPU 14 (0x000e) enabled
ACPI: LSAPIC (acpi_id[0x0f] lsapic_id[0x20] lsapic_eid[0x0e] enabled)
CPU 15 (0x200e) enabled
ACPI: LSAPIC (acpi_id[0x10] lsapic_id[0x00] lsapic_eid[0x10] enabled)
CPU 16 (0x0010) enabled
ACPI: LSAPIC (acpi_id[0x11] lsapic_id[0x20] lsapic_eid[0x10] enabled)
CPU 17 (0x2010) enabled
ACPI: LSAPIC (acpi_id[0x12] lsapic_id[0x00] lsapic_eid[0x12] enabled)
CPU 18 (0x0012) enabled
ACPI: LSAPIC (acpi_id[0x13] lsapic_id[0x20] lsapic_eid[0x12] enabled)
CPU 19 (0x2012) enabled
ACPI: LSAPIC (acpi_id[0x14] lsapic_id[0x00] lsapic_eid[0x14] enabled)
CPU 20 (0x0014) enabled
ACPI: LSAPIC (acpi_id[0x15] lsapic_id[0x20] lsapic_eid[0x14] enabled)
CPU 21 (0x2014) enabled
ACPI: LSAPIC (acpi_id[0x16] lsapic_id[0x00] lsapic_eid[0x16] enabled)
CPU 22 (0x0016) enabled
ACPI: LSAPIC (acpi_id[0x17] lsapic_id[0x20] lsapic_eid[0x16] enabled)
CPU 23 (0x2016) enabled
ACPI: LSAPIC (acpi_id[0x18] lsapic_id[0x00] lsapic_eid[0x18] enabled)
CPU 24 (0x0018) enabled
ACPI: LSAPIC (acpi_id[0x19] lsapic_id[0x20] lsapic_eid[0x18] enabled)
CPU 25 (0x2018) enabled
ACPI: LSAPIC (acpi_id[0x1a] lsapic_id[0x00] lsapic_eid[0x1a] enabled)
CPU 26 (0x001a) enabled
ACPI: LSAPIC (acpi_id[0x1b] lsapic_id[0x20] lsapic_eid[0x1a] enabled)
CPU 27 (0x201a) enabled
ACPI: LSAPIC (acpi_id[0x1c] lsapic_id[0x00] lsapic_eid[0x1c] enabled)
CPU 28 (0x001c) enabled
ACPI: LSAPIC (acpi_id[0x1d] lsapic_id[0x20] lsapic_eid[0x1c] enabled)
CPU 29 (0x201c) enabled
ACPI: LSAPIC (acpi_id[0x1e] lsapic_id[0x00] lsapic_eid[0x1e] enabled)
CPU 30 (0x001e) enabled
ACPI: LSAPIC (acpi_id[0x1f] lsapic_id[0x20] lsapic_eid[0x1e] enabled)
CPU 31 (0x201e) enabled
ACPI: LSAPIC (acpi_id[0x20] lsapic_id[0x00] lsapic_eid[0x20] enabled)
CPU 32 (0x0020) enabled
ACPI: LSAPIC (acpi_id[0x21] lsapic_id[0x20] lsapic_eid[0x20] enabled)
CPU 33 (0x2020) enabled
ACPI: LSAPIC (acpi_id[0x22] lsapic_id[0x00] lsapic_eid[0x22] enabled)
CPU 34 (0x0022) enabled
ACPI: LSAPIC (acpi_id[0x23] lsapic_id[0x20] lsapic_eid[0x22] enabled)
CPU 35 (0x2022) enabled
ACPI: LSAPIC (acpi_id[0x24] lsapic_id[0x00] lsapic_eid[0x24] enabled)
CPU 36 (0x0024) enabled
ACPI: LSAPIC (acpi_id[0x25] lsapic_id[0x20] lsapic_eid[0x24] enabled)
CPU 37 (0x2024) enabled
ACPI: LSAPIC (acpi_id[0x26] lsapic_id[0x00] lsapic_eid[0x26] enabled)
CPU 38 (0x0026) enabled
ACPI: LSAPIC (acpi_id[0x27] lsapic_id[0x20] lsapic_eid[0x26] enabled)
CPU 39 (0x2026) enabled
ACPI: LSAPIC (acpi_id[0x28] lsapic_id[0x00] lsapic_eid[0x28] enabled)
CPU 40 (0x0028) enabled
ACPI: LSAPIC (acpi_id[0x29] lsapic_id[0x20] lsapic_eid[0x28] enabled)
CPU 41 (0x2028) enabled
ACPI: LSAPIC (acpi_id[0x2a] lsapic_id[0x00] lsapic_eid[0x2a] enabled)
CPU 42 (0x002a) enabled
ACPI: LSAPIC (acpi_id[0x2b] lsapic_id[0x20] lsapic_eid[0x2a] enabled)
CPU 43 (0x202a) enabled
ACPI: LSAPIC (acpi_id[0x2c] lsapic_id[0x00] lsapic_eid[0x2c] enabled)
CPU 44 (0x002c) enabled
ACPI: LSAPIC (acpi_id[0x2d] lsapic_id[0x20] lsapic_eid[0x2c] enabled)
CPU 45 (0x202c) enabled
ACPI: LSAPIC (acpi_id[0x2e] lsapic_id[0x00] lsapic_eid[0x2e] enabled)
CPU 46 (0x002e) enabled
ACPI: LSAPIC (acpi_id[0x2f] lsapic_id[0x20] lsapic_eid[0x2e] enabled)
CPU 47 (0x202e) enabled
ACPI: LSAPIC (acpi_id[0x30] lsapic_id[0x00] lsapic_eid[0x30] enabled)
CPU 48 (0x0030) enabled
ACPI: LSAPIC (acpi_id[0x31] lsapic_id[0x20] lsapic_eid[0x30] enabled)
CPU 49 (0x2030) enabled
ACPI: LSAPIC (acpi_id[0x32] lsapic_id[0x00] lsapic_eid[0x32] enabled)
CPU 50 (0x0032) enabled
ACPI: LSAPIC (acpi_id[0x33] lsapic_id[0x20] lsapic_eid[0x32] enabled)
CPU 51 (0x2032) enabled
ACPI: LSAPIC (acpi_id[0x34] lsapic_id[0x00] lsapic_eid[0x34] enabled)
CPU 52 (0x0034) enabled
ACPI: LSAPIC (acpi_id[0x35] lsapic_id[0x20] lsapic_eid[0x34] enabled)
CPU 53 (0x2034) enabled
ACPI: LSAPIC (acpi_id[0x36] lsapic_id[0x00] lsapic_eid[0x36] enabled)
CPU 54 (0x0036) enabled
ACPI: LSAPIC (acpi_id[0x37] lsapic_id[0x20] lsapic_eid[0x36] enabled)
CPU 55 (0x2036) enabled
ACPI: LSAPIC (acpi_id[0x38] lsapic_id[0x00] lsapic_eid[0x38] enabled)
CPU 56 (0x0038) enabled
ACPI: LSAPIC (acpi_id[0x39] lsapic_id[0x20] lsapic_eid[0x38] enabled)
CPU 57 (0x2038) enabled
ACPI: LSAPIC (acpi_id[0x3a] lsapic_id[0x00] lsapic_eid[0x3a] enabled)
CPU 58 (0x003a) enabled
ACPI: LSAPIC (acpi_id[0x3b] lsapic_id[0x20] lsapic_eid[0x3a] enabled)
CPU 59 (0x203a) enabled
ACPI: LSAPIC (acpi_id[0x3c] lsapic_id[0x00] lsapic_eid[0x3c] enabled)
CPU 60 (0x003c) enabled
ACPI: LSAPIC (acpi_id[0x3d] lsapic_id[0x20] lsapic_eid[0x3c] enabled)
CPU 61 (0x203c) enabled
ACPI: LSAPIC (acpi_id[0x3e] lsapic_id[0x00] lsapic_eid[0x3e] enabled)
CPU 62 (0x003e) enabled
ACPI: LSAPIC (acpi_id[0x3f] lsapic_id[0x20] lsapic_eid[0x3e] enabled)
CPU 63 (0x203e) enabled
ACPI: LSAPIC (acpi_id[0x40] lsapic_id[0x00] lsapic_eid[0x40] enabled)
CPU 64 (0x0040) enabled
ACPI: LSAPIC (acpi_id[0x41] lsapic_id[0x20] lsapic_eid[0x40] enabled)
CPU 65 (0x2040) enabled
ACPI: LSAPIC (acpi_id[0x42] lsapic_id[0x00] lsapic_eid[0x42] enabled)
CPU 66 (0x0042) enabled
ACPI: LSAPIC (acpi_id[0x43] lsapic_id[0x20] lsapic_eid[0x42] enabled)
CPU 67 (0x2042) enabled
ACPI: LSAPIC (acpi_id[0x44] lsapic_id[0x00] lsapic_eid[0x44] enabled)
CPU 68 (0x0044) enabled
ACPI: LSAPIC (acpi_id[0x45] lsapic_id[0x20] lsapic_eid[0x44] enabled)
CPU 69 (0x2044) enabled
ACPI: LSAPIC (acpi_id[0x46] lsapic_id[0x00] lsapic_eid[0x46] enabled)
CPU 70 (0x0046) enabled
ACPI: LSAPIC (acpi_id[0x47] lsapic_id[0x20] lsapic_eid[0x46] enabled)
CPU 71 (0x2046) enabled
ACPI: LSAPIC (acpi_id[0x48] lsapic_id[0x00] lsapic_eid[0x48] enabled)
CPU 72 (0x0048) enabled
ACPI: LSAPIC (acpi_id[0x49] lsapic_id[0x20] lsapic_eid[0x48] enabled)
CPU 73 (0x2048) enabled
ACPI: LSAPIC (acpi_id[0x4a] lsapic_id[0x00] lsapic_eid[0x4a] enabled)
CPU 74 (0x004a) enabled
ACPI: LSAPIC (acpi_id[0x4b] lsapic_id[0x20] lsapic_eid[0x4a] enabled)
CPU 75 (0x204a) enabled
ACPI: LSAPIC (acpi_id[0x4c] lsapic_id[0x00] lsapic_eid[0x4c] enabled)
CPU 76 (0x004c) enabled
ACPI: LSAPIC (acpi_id[0x4d] lsapic_id[0x20] lsapic_eid[0x4c] enabled)
CPU 77 (0x204c) enabled
ACPI: LSAPIC (acpi_id[0x4e] lsapic_id[0x00] lsapic_eid[0x4e] enabled)
CPU 78 (0x004e) enabled
ACPI: LSAPIC (acpi_id[0x4f] lsapic_id[0x20] lsapic_eid[0x4e] enabled)
CPU 79 (0x204e) enabled
ACPI: LSAPIC (acpi_id[0x50] lsapic_id[0x00] lsapic_eid[0x50] enabled)
CPU 80 (0x0050) enabled
ACPI: LSAPIC (acpi_id[0x51] lsapic_id[0x20] lsapic_eid[0x50] enabled)
CPU 81 (0x2050) enabled
ACPI: LSAPIC (acpi_id[0x52] lsapic_id[0x00] lsapic_eid[0x52] enabled)
CPU 82 (0x0052) enabled
ACPI: LSAPIC (acpi_id[0x53] lsapic_id[0x20] lsapic_eid[0x52] enabled)
CPU 83 (0x2052) enabled
ACPI: LSAPIC (acpi_id[0x54] lsapic_id[0x00] lsapic_eid[0x54] enabled)
CPU 84 (0x0054) enabled
ACPI: LSAPIC (acpi_id[0x55] lsapic_id[0x20] lsapic_eid[0x54] enabled)
CPU 85 (0x2054) enabled
ACPI: LSAPIC (acpi_id[0x56] lsapic_id[0x00] lsapic_eid[0x56] enabled)
CPU 86 (0x0056) enabled
ACPI: LSAPIC (acpi_id[0x57] lsapic_id[0x20] lsapic_eid[0x56] enabled)
CPU 87 (0x2056) enabled
ACPI: LSAPIC (acpi_id[0x58] lsapic_id[0x00] lsapic_eid[0x58] enabled)
CPU 88 (0x0058) enabled
ACPI: LSAPIC (acpi_id[0x59] lsapic_id[0x20] lsapic_eid[0x58] enabled)
CPU 89 (0x2058) enabled
ACPI: LSAPIC (acpi_id[0x5a] lsapic_id[0x00] lsapic_eid[0x5a] enabled)
CPU 90 (0x005a) enabled
ACPI: LSAPIC (acpi_id[0x5b] lsapic_id[0x20] lsapic_eid[0x5a] enabled)
CPU 91 (0x205a) enabled
ACPI: LSAPIC (acpi_id[0x5c] lsapic_id[0x00] lsapic_eid[0x5c] enabled)
CPU 92 (0x005c) enabled
ACPI: LSAPIC (acpi_id[0x5d] lsapic_id[0x20] lsapic_eid[0x5c] enabled)
CPU 93 (0x205c) enabled
ACPI: LSAPIC (acpi_id[0x5e] lsapic_id[0x00] lsapic_eid[0x5e] enabled)
CPU 94 (0x005e) enabled
ACPI: LSAPIC (acpi_id[0x5f] lsapic_id[0x20] lsapic_eid[0x5e] enabled)
CPU 95 (0x205e) enabled
ACPI: Error parsing MADT - no IOSAPIC entries
register_intr: No IOSAPIC for GSI 0x0
GSI 0x0(low,level) -> CPU 0x0000 vector 48
96 CPUs available, 96 CPUs total
ia64_mca_init: Failed to register rendezvous interrupt with SAL.  rc = -2
SGI SAL version 3.01
CPU 0: nasid 0, slice 0, cnode 0
Virtual mem_map starts at 0xa0007fe263650000
On node 0 totalpages: 502233
  DMA zone: 502233 pages, LIFO batch:4
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
On node 1 totalpages: 502784
  DMA zone: 502784 pages, LIFO batch:4
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
On node 2 totalpages: 502783
  DMA zone: 502783 pages, LIFO batch:4
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
On node 3 totalpages: 502784
  DMA zone: 502784 pages, LIFO batch:4
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
On node 4 totalpages: 502784
  DMA zone: 502784 pages, LIFO batch:4
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
On node 5 totalpages: 502783
  DMA zone: 502783 pages, LIFO batch:4
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
On node 6 totalpages: 502784
  DMA zone: 502784 pages, LIFO batch:4
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
On node 7 totalpages: 502784
  DMA zone: 502784 pages, LIFO batch:4
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
On node 8 totalpages: 502784
  DMA zone: 502784 pages, LIFO batch:4
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
On node 9 totalpages: 502784
  DMA zone: 502784 pages, LIFO batch:4
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
On node 10 totalpages: 502784
  DMA zone: 502784 pages, LIFO batch:4
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
On node 11 totalpages: 502784
  DMA zone: 502784 pages, LIFO batch:4
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
On node 12 totalpages: 502784
  DMA zone: 502784 pages, LIFO batch:4
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
On node 13 totalpages: 502783
  DMA zone: 502783 pages, LIFO batch:4
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
On node 14 totalpages: 502784
  DMA zone: 502784 pages, LIFO batch:4
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
On node 15 totalpages: 502784
  DMA zone: 502784 pages, LIFO batch:4
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
On node 16 totalpages: 502783
  DMA zone: 502783 pages, LIFO batch:4
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
On node 17 totalpages: 502784
  DMA zone: 502784 pages, LIFO batch:4
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
On node 18 totalpages: 502784
  DMA zone: 502784 pages, LIFO batch:4
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
On node 19 totalpages: 502783
  DMA zone: 502783 pages, LIFO batch:4
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
On node 20 totalpages: 502784
  DMA zone: 502784 pages, LIFO batch:4
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
On node 21 totalpages: 502784
  DMA zone: 502784 pages, LIFO batch:4
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
On node 22 totalpages: 502783
  DMA zone: 502783 pages, LIFO batch:4
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
On node 23 totalpages: 502784
  DMA zone: 502784 pages, LIFO batch:4
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
On node 24 totalpages: 502784
  DMA zone: 502784 pages, LIFO batch:4
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
On node 25 totalpages: 502784
  DMA zone: 502784 pages, LIFO batch:4
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
On node 26 totalpages: 502784
  DMA zone: 502784 pages, LIFO batch:4
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
On node 27 totalpages: 502784
  DMA zone: 502784 pages, LIFO batch:4
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
On node 28 totalpages: 502784
  DMA zone: 502784 pages, LIFO batch:4
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
On node 29 totalpages: 502784
  DMA zone: 502784 pages, LIFO batch:4
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
On node 30 totalpages: 502783
  DMA zone: 502783 pages, LIFO batch:4
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
On node 31 totalpages: 502784
  DMA zone: 502784 pages, LIFO batch:4
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
On node 32 totalpages: 121856
  DMA zone: 121856 pages, LIFO batch:4
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
On node 33 totalpages: 121856
  DMA zone: 121856 pages, LIFO batch:4
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
On node 34 totalpages: 121856
  DMA zone: 121856 pages, LIFO batch:4
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
On node 35 totalpages: 121856
  DMA zone: 121856 pages, LIFO batch:4
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
On node 36 totalpages: 121856
  DMA zone: 121856 pages, LIFO batch:4
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
On node 37 totalpages: 121856
  DMA zone: 121856 pages, LIFO batch:4
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
On node 38 totalpages: 121856
  DMA zone: 121856 pages, LIFO batch:4
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
On node 39 totalpages: 121856
  DMA zone: 121856 pages, LIFO batch:4
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
On node 40 totalpages: 121856
  DMA zone: 121856 pages, LIFO batch:4
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
On node 41 totalpages: 121856
  DMA zone: 121856 pages, LIFO batch:4
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
On node 42 totalpages: 121856
  DMA zone: 121856 pages, LIFO batch:4
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
On node 43 totalpages: 121856
  DMA zone: 121856 pages, LIFO batch:4
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
On node 44 totalpages: 121856
  DMA zone: 121856 pages, LIFO batch:4
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
On node 45 totalpages: 121855
  DMA zone: 121855 pages, LIFO batch:4
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
On node 46 totalpages: 121856
  DMA zone: 121856 pages, LIFO batch:4
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
On node 47 totalpages: 121742
  DMA zone: 121742 pages, LIFO batch:4
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
Building zonelist for node : 0
Building zonelist for node : 1
Building zonelist for node : 2
Building zonelist for node : 3
Building zonelist for node : 4
Building zonelist for node : 5
Building zonelist for node : 6
Building zonelist for node : 7
Building zonelist for node : 8
Building zonelist for node : 9
Building zonelist for node : 10
Building zonelist for node : 11
Building zonelist for node : 12
Building zonelist for node : 13
Building zonelist for node : 14
Building zonelist for node : 15
Building zonelist for node : 16
Building zonelist for node : 17
Building zonelist for node : 18
Building zonelist for node : 19
Building zonelist for node : 20
Building zonelist for node : 21
Building zonelist for node : 22
Building zonelist for node : 23
Building zonelist for node : 24
Building zonelist for node : 25
Building zonelist for node : 26
Building zonelist for node : 27
Building zonelist for node : 28
Building zonelist for node : 29
Building zonelist for node : 30
Building zonelist for node : 31
Building zonelist for node : 32
Building zonelist for node : 33
Building zonelist for node : 34
Building zonelist for node : 35
Building zonelist for node : 36
Building zonelist for node : 37
Building zonelist for node : 38
Building zonelist for node : 39
Building zonelist for node : 40
Building zonelist for node : 41
Building zonelist for node : 42
Building zonelist for node : 43
Building zonelist for node : 44
Building zonelist for node : 45
Building zonelist for node : 46
Building zonelist for node : 47
Kernel command line: BOOT_IMAGE=scsi0:\efi\sgi\vmlinuz.jb root=/dev/sda3 console=ttyS0
fpswa interface at 17b07be02010 (rev 1.18)
PID hash table entries: 4096 (order 12: 65536 bytes)
CPU 0: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Console: colour dummy device 80x25
Memory: 286351744k/288609776k available (5245k code, 2249424k reserved, 1965k data, 192k init)
McKinley Errata 9 workaround not needed; disabling it
Calibrating delay loop... 2241.08 BogoMIPS
Dentry cache hash table entries: 33554432 (order: 14, 268435456 bytes)
Inode-cache hash table entries: 33554432 (order: 14, 268435456 bytes)
Mount-cache hash table entries: 1024 (order: 0, 16384 bytes)
POSIX conformance testing by UNIFIX
Boot processor id 0x0/0x0
task migration cache decay timeout: 10 msecs.
Starting migration thread for cpu 0
Bringing up 1
Processor 8192/1 is spinning up...
CPU 1: 61 virtual and 50 physical address bits
CPU 1: nasid 0, slice 2, cnode 0
CPU 1: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2232.84 BogoMIPS
CPU1: CPU has booted.
Processor 1 has spun up...
CPU 1 IS NOW UP!
Starting migration thread for cpu 1
Bringing up 2
Processor 2/2 is spinning up...
CPU 2: 61 virtual and 50 physical address bits
CPU 2: nasid 2, slice 0, cnode 1
CPU 2: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2241.08 BogoMIPS
CPU2: CPU has booted.
Processor 2 has spun up...
CPU 2 IS NOW UP!
Starting migration thread for cpu 2
Bringing up 3
Processor 8194/3 is spinning up...
CPU 3: 61 virtual and 50 physical address bits
CPU 3: nasid 2, slice 2, cnode 1
CPU 3: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2241.08 BogoMIPS
CPU3: CPU has booted.
Processor 3 has spun up...
CPU 3 IS NOW UP!
Starting migration thread for cpu 3
Bringing up 4
Processor 4/4 is spinning up...
CPU 4: 61 virtual and 50 physical address bits
CPU 4: nasid 4, slice 0, cnode 2
CPU 4: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2241.08 BogoMIPS
CPU4: CPU has booted.
Processor 4 has spun up...
CPU 4 IS NOW UP!
Starting migration thread for cpu 4
Bringing up 5
Processor 8196/5 is spinning up...
CPU 5: 61 virtual and 50 physical address bits
CPU 5: nasid 4, slice 2, cnode 2
CPU 5: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU5: CPU has booted.
Processor 5 has spun up...
CPU 5 IS NOW UP!
Starting migration thread for cpu 5
Bringing up 6
Processor 6/6 is spinning up...
CPU 6: 61 virtual and 50 physical address bits
CPU 6: nasid 6, slice 0, cnode 3
CPU 6: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU6: CPU has booted.
Processor 6 has spun up...
CPU 6 IS NOW UP!
Starting migration thread for cpu 6
Bringing up 7
Processor 8198/7 is spinning up...
CPU 7: 61 virtual and 50 physical address bits
CPU 7: nasid 6, slice 2, cnode 3
CPU 7: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU7: CPU has booted.
Processor 7 has spun up...
CPU 7 IS NOW UP!
Starting migration thread for cpu 7
Bringing up 8
Processor 8/8 is spinning up...
CPU 8: 61 virtual and 50 physical address bits
CPU 8: nasid 8, slice 0, cnode 4
CPU 8: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU8: CPU has booted.
Processor 8 has spun up...
CPU 8 IS NOW UP!
Starting migration thread for cpu 8
Bringing up 9
Processor 8200/9 is spinning up...
CPU 9: 61 virtual and 50 physical address bits
CPU 9: nasid 8, slice 2, cnode 4
CPU 9: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU9: CPU has booted.
Processor 9 has spun up...
CPU 9 IS NOW UP!
Starting migration thread for cpu 9
Bringing up 10
Processor 10/10 is spinning up...
CPU 10: 61 virtual and 50 physical address bits
CPU 10: nasid 10, slice 0, cnode 5
CPU 10: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU10: CPU has booted.
Processor 10 has spun up...
CPU 10 IS NOW UP!
Starting migration thread for cpu 10
Bringing up 11
Processor 8202/11 is spinning up...
CPU 11: 61 virtual and 50 physical address bits
CPU 11: nasid 10, slice 2, cnode 5
CPU 11: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU11: CPU has booted.
Processor 11 has spun up...
CPU 11 IS NOW UP!
Starting migration thread for cpu 11
Bringing up 12
Processor 12/12 is spinning up...
CPU 12: 61 virtual and 50 physical address bits
CPU 12: nasid 12, slice 0, cnode 6
CPU 12: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU12: CPU has booted.
Processor 12 has spun up...
CPU 12 IS NOW UP!
Starting migration thread for cpu 12
Bringing up 13
Processor 8204/13 is spinning up...
CPU 13: 61 virtual and 50 physical address bits
CPU 13: nasid 12, slice 2, cnode 6
CPU 13: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU13: CPU has booted.
Processor 13 has spun up...
CPU 13 IS NOW UP!
Starting migration thread for cpu 13
Bringing up 14
Processor 14/14 is spinning up...
CPU 14: 61 virtual and 50 physical address bits
CPU 14: nasid 14, slice 0, cnode 7
CPU 14: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU14: CPU has booted.
Processor 14 has spun up...
CPU 14 IS NOW UP!
Starting migration thread for cpu 14
Bringing up 15
Processor 8206/15 is spinning up...
CPU 15: 61 virtual and 50 physical address bits
CPU 15: nasid 14, slice 2, cnode 7
CPU 15: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU15: CPU has booted.
Processor 15 has spun up...
CPU 15 IS NOW UP!
Starting migration thread for cpu 15
Bringing up 16
Processor 16/16 is spinning up...
CPU 16: 61 virtual and 50 physical address bits
CPU 16: nasid 16, slice 0, cnode 8
CPU 16: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU16: CPU has booted.
Processor 16 has spun up...
CPU 16 IS NOW UP!
Starting migration thread for cpu 16
Bringing up 17
Processor 8208/17 is spinning up...
CPU 17: 61 virtual and 50 physical address bits
CPU 17: nasid 16, slice 2, cnode 8
CPU 17: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU17: CPU has booted.
Processor 17 has spun up...
CPU 17 IS NOW UP!
Starting migration thread for cpu 17
Bringing up 18
Processor 18/18 is spinning up...
CPU 18: 61 virtual and 50 physical address bits
CPU 18: nasid 18, slice 0, cnode 9
CPU 18: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU18: CPU has booted.
Processor 18 has spun up...
CPU 18 IS NOW UP!
Starting migration thread for cpu 18
Bringing up 19
Processor 8210/19 is spinning up...
CPU 19: 61 virtual and 50 physical address bits
CPU 19: nasid 18, slice 2, cnode 9
CPU 19: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU19: CPU has booted.
Processor 19 has spun up...
CPU 19 IS NOW UP!
Starting migration thread for cpu 19
Bringing up 20
Processor 20/20 is spinning up...
CPU 20: 61 virtual and 50 physical address bits
CPU 20: nasid 20, slice 0, cnode 10
CPU 20: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU20: CPU has booted.
Processor 20 has spun up...
CPU 20 IS NOW UP!
Starting migration thread for cpu 20
Bringing up 21
Processor 8212/21 is spinning up...
CPU 21: 61 virtual and 50 physical address bits
CPU 21: nasid 20, slice 2, cnode 10
CPU 21: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU21: CPU has booted.
Processor 21 has spun up...
CPU 21 IS NOW UP!
Starting migration thread for cpu 21
Bringing up 22
Processor 22/22 is spinning up...
CPU 22: 61 virtual and 50 physical address bits
CPU 22: nasid 22, slice 0, cnode 11
CPU 22: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU22: CPU has booted.
Processor 22 has spun up...
CPU 22 IS NOW UP!
Starting migration thread for cpu 22
Bringing up 23
Processor 8214/23 is spinning up...
CPU 23: 61 virtual and 50 physical address bits
CPU 23: nasid 22, slice 2, cnode 11
CPU 23: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU23: CPU has booted.
Processor 23 has spun up...
CPU 23 IS NOW UP!
Starting migration thread for cpu 23
Bringing up 24
Processor 24/24 is spinning up...
CPU 24: 61 virtual and 50 physical address bits
CPU 24: nasid 24, slice 0, cnode 12
CPU 24: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU24: CPU has booted.
Processor 24 has spun up...
CPU 24 IS NOW UP!
Starting migration thread for cpu 24
Bringing up 25
Processor 8216/25 is spinning up...
CPU 25: 61 virtual and 50 physical address bits
CPU 25: nasid 24, slice 2, cnode 12
CPU 25: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU25: CPU has booted.
Processor 25 has spun up...
CPU 25 IS NOW UP!
Starting migration thread for cpu 25
Bringing up 26
Processor 26/26 is spinning up...
CPU 26: 61 virtual and 50 physical address bits
CPU 26: nasid 26, slice 0, cnode 13
CPU 26: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU26: CPU has booted.
Processor 26 has spun up...
CPU 26 IS NOW UP!
Starting migration thread for cpu 26
Bringing up 27
Processor 8218/27 is spinning up...
CPU 27: 61 virtual and 50 physical address bits
CPU 27: nasid 26, slice 2, cnode 13
CPU 27: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU27: CPU has booted.
Processor 27 has spun up...
CPU 27 IS NOW UP!
Starting migration thread for cpu 27
Bringing up 28
Processor 28/28 is spinning up...
CPU 28: 61 virtual and 50 physical address bits
CPU 28: nasid 28, slice 0, cnode 14
CPU 28: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU28: CPU has booted.
Processor 28 has spun up...
CPU 28 IS NOW UP!
Starting migration thread for cpu 28
Bringing up 29
Processor 8220/29 is spinning up...
CPU 29: 61 virtual and 50 physical address bits
CPU 29: nasid 28, slice 2, cnode 14
CPU 29: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU29: CPU has booted.
Processor 29 has spun up...
CPU 29 IS NOW UP!
Starting migration thread for cpu 29
Bringing up 30
Processor 30/30 is spinning up...
CPU 30: 61 virtual and 50 physical address bits
CPU 30: nasid 30, slice 0, cnode 15
CPU 30: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU30: CPU has booted.
Processor 30 has spun up...
CPU 30 IS NOW UP!
Starting migration thread for cpu 30
Bringing up 31
Processor 8222/31 is spinning up...
CPU 31: 61 virtual and 50 physical address bits
CPU 31: nasid 30, slice 2, cnode 15
CPU 31: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU31: CPU has booted.
Processor 31 has spun up...
CPU 31 IS NOW UP!
Starting migration thread for cpu 31
Bringing up 32
Processor 32/32 is spinning up...
CPU 32: 61 virtual and 50 physical address bits
CPU 32: nasid 32, slice 0, cnode 16
CPU 32: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU32: CPU has booted.
Processor 32 has spun up...
CPU 32 IS NOW UP!
Starting migration thread for cpu 32
Bringing up 33
Processor 8224/33 is spinning up...
CPU 33: 61 virtual and 50 physical address bits
CPU 33: nasid 32, slice 2, cnode 16
CPU 33: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU33: CPU has booted.
Processor 33 has spun up...
CPU 33 IS NOW UP!
Starting migration thread for cpu 33
Bringing up 34
Processor 34/34 is spinning up...
CPU 34: 61 virtual and 50 physical address bits
CPU 34: nasid 34, slice 0, cnode 17
CPU 34: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU34: CPU has booted.
Processor 34 has spun up...
CPU 34 IS NOW UP!
Starting migration thread for cpu 34
Bringing up 35
Processor 8226/35 is spinning up...
CPU 35: 61 virtual and 50 physical address bits
CPU 35: nasid 34, slice 2, cnode 17
CPU 35: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU35: CPU has booted.
Processor 35 has spun up...
CPU 35 IS NOW UP!
Starting migration thread for cpu 35
Bringing up 36
Processor 36/36 is spinning up...
CPU 36: 61 virtual and 50 physical address bits
CPU 36: nasid 36, slice 0, cnode 18
CPU 36: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU36: CPU has booted.
Processor 36 has spun up...
CPU 36 IS NOW UP!
Starting migration thread for cpu 36
Bringing up 37
Processor 8228/37 is spinning up...
CPU 37: 61 virtual and 50 physical address bits
CPU 37: nasid 36, slice 2, cnode 18
CPU 37: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2249.32 BogoMIPS
CPU37: CPU has booted.
Processor 37 has spun up...
CPU 37 IS NOW UP!
Starting migration thread for cpu 37
Bringing up 38
Processor 38/38 is spinning up...
CPU 38: 61 virtual and 50 physical address bits
CPU 38: nasid 38, slice 0, cnode 19
CPU 38: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2232.84 BogoMIPS
CPU38: CPU has booted.
Processor 38 has spun up...
CPU 38 IS NOW UP!
Starting migration thread for cpu 38
Bringing up 39
Processor 8230/39 is spinning up...
CPU 39: 61 virtual and 50 physical address bits
CPU 39: nasid 38, slice 2, cnode 19
CPU 39: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2232.84 BogoMIPS
CPU39: CPU has booted.
Processor 39 has spun up...
CPU 39 IS NOW UP!
Starting migration thread for cpu 39
Bringing up 40
Processor 40/40 is spinning up...
CPU 40: 61 virtual and 50 physical address bits
CPU 40: nasid 40, slice 0, cnode 20
CPU 40: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2241.08 BogoMIPS
CPU40: CPU has booted.
Processor 40 has spun up...
CPU 40 IS NOW UP!
Starting migration thread for cpu 40
Bringing up 41
Processor 8232/41 is spinning up...
CPU 41: 61 virtual and 50 physical address bits
CPU 41: nasid 40, slice 2, cnode 20
CPU 41: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2241.08 BogoMIPS
CPU41: CPU has booted.
Processor 41 has spun up...
CPU 41 IS NOW UP!
Starting migration thread for cpu 41
Bringing up 42
Processor 42/42 is spinning up...
CPU 42: 61 virtual and 50 physical address bits
CPU 42: nasid 42, slice 0, cnode 21
CPU 42: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU42: CPU has booted.
Processor 42 has spun up...
CPU 42 IS NOW UP!
Starting migration thread for cpu 42
Bringing up 43
Processor 8234/43 is spinning up...
CPU 43: 61 virtual and 50 physical address bits
CPU 43: nasid 42, slice 2, cnode 21
CPU 43: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU43: CPU has booted.
Processor 43 has spun up...
CPU 43 IS NOW UP!
Starting migration thread for cpu 43
Bringing up 44
Processor 44/44 is spinning up...
CPU 44: 61 virtual and 50 physical address bits
CPU 44: nasid 44, slice 0, cnode 22
CPU 44: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU44: CPU has booted.
Processor 44 has spun up...
CPU 44 IS NOW UP!
Starting migration thread for cpu 44
Bringing up 45
Processor 8236/45 is spinning up...
CPU 45: 61 virtual and 50 physical address bits
CPU 45: nasid 44, slice 2, cnode 22
CPU 45: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU45: CPU has booted.
Processor 45 has spun up...
CPU 45 IS NOW UP!
Starting migration thread for cpu 45
Bringing up 46
Processor 46/46 is spinning up...
CPU 46: 61 virtual and 50 physical address bits
CPU 46: nasid 46, slice 0, cnode 23
CPU 46: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU46: CPU has booted.
Processor 46 has spun up...
CPU 46 IS NOW UP!
Starting migration thread for cpu 46
Bringing up 47
Processor 8238/47 is spinning up...
CPU 47: 61 virtual and 50 physical address bits
CPU 47: nasid 46, slice 2, cnode 23
CPU 47: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU47: CPU has booted.
Processor 47 has spun up...
CPU 47 IS NOW UP!
Starting migration thread for cpu 47
Bringing up 48
Processor 48/48 is spinning up...
CPU 48: 61 virtual and 50 physical address bits
CPU 48: nasid 48, slice 0, cnode 24
CPU 48: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU48: CPU has booted.
Processor 48 has spun up...
CPU 48 IS NOW UP!
Starting migration thread for cpu 48
Bringing up 49
Processor 8240/49 is spinning up...
CPU 49: 61 virtual and 50 physical address bits
CPU 49: nasid 48, slice 2, cnode 24
CPU 49: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU49: CPU has booted.
Processor 49 has spun up...
CPU 49 IS NOW UP!
Starting migration thread for cpu 49
Bringing up 50
Processor 50/50 is spinning up...
CPU 50: 61 virtual and 50 physical address bits
CPU 50: nasid 50, slice 0, cnode 25
CPU 50: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU50: CPU has booted.
Processor 50 has spun up...
CPU 50 IS NOW UP!
Starting migration thread for cpu 50
Bringing up 51
Processor 8242/51 is spinning up...
CPU 51: 61 virtual and 50 physical address bits
CPU 51: nasid 50, slice 2, cnode 25
CPU 51: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU51: CPU has booted.
Processor 51 has spun up...
CPU 51 IS NOW UP!
Starting migration thread for cpu 51
Bringing up 52
Processor 52/52 is spinning up...
CPU 52: 61 virtual and 50 physical address bits
CPU 52: nasid 52, slice 0, cnode 26
CPU 52: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU52: CPU has booted.
Processor 52 has spun up...
CPU 52 IS NOW UP!
Starting migration thread for cpu 52
Bringing up 53
Processor 8244/53 is spinning up...
CPU 53: 61 virtual and 50 physical address bits
CPU 53: nasid 52, slice 2, cnode 26
CPU 53: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU53: CPU has booted.
Processor 53 has spun up...
CPU 53 IS NOW UP!
Starting migration thread for cpu 53
Bringing up 54
Processor 54/54 is spinning up...
CPU 54: 61 virtual and 50 physical address bits
CPU 54: nasid 54, slice 0, cnode 27
CPU 54: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU54: CPU has booted.
Processor 54 has spun up...
CPU 54 IS NOW UP!
Starting migration thread for cpu 54
Bringing up 55
Processor 8246/55 is spinning up...
CPU 55: 61 virtual and 50 physical address bits
CPU 55: nasid 54, slice 2, cnode 27
CPU 55: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU55: CPU has booted.
Processor 55 has spun up...
CPU 55 IS NOW UP!
Starting migration thread for cpu 55
Bringing up 56
Processor 56/56 is spinning up...
CPU 56: 61 virtual and 50 physical address bits
CPU 56: nasid 56, slice 0, cnode 28
CPU 56: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU56: CPU has booted.
Processor 56 has spun up...
CPU 56 IS NOW UP!
Starting migration thread for cpu 56
Bringing up 57
Processor 8248/57 is spinning up...
CPU 57: 61 virtual and 50 physical address bits
CPU 57: nasid 56, slice 2, cnode 28
CPU 57: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU57: CPU has booted.
Processor 57 has spun up...
CPU 57 IS NOW UP!
Starting migration thread for cpu 57
Bringing up 58
Processor 58/58 is spinning up...
CPU 58: 61 virtual and 50 physical address bits
CPU 58: nasid 58, slice 0, cnode 29
CPU 58: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU58: CPU has booted.
Processor 58 has spun up...
CPU 58 IS NOW UP!
Starting migration thread for cpu 58
Bringing up 59
Processor 8250/59 is spinning up...
CPU 59: 61 virtual and 50 physical address bits
CPU 59: nasid 58, slice 2, cnode 29
CPU 59: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU59: CPU has booted.
Processor 59 has spun up...
CPU 59 IS NOW UP!
Starting migration thread for cpu 59
Bringing up 60
Processor 60/60 is spinning up...
CPU 60: 61 virtual and 50 physical address bits
CPU 60: nasid 60, slice 0, cnode 30
CPU 60: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU60: CPU has booted.
Processor 60 has spun up...
CPU 60 IS NOW UP!
Starting migration thread for cpu 60
Bringing up 61
Processor 8252/61 is spinning up...
CPU 61: 61 virtual and 50 physical address bits
CPU 61: nasid 60, slice 2, cnode 30
CPU 61: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU61: CPU has booted.
Processor 61 has spun up...
CPU 61 IS NOW UP!
Starting migration thread for cpu 61
Bringing up 62
Processor 62/62 is spinning up...
CPU 62: 61 virtual and 50 physical address bits
CPU 62: nasid 62, slice 0, cnode 31
CPU 62: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU62: CPU has booted.
Processor 62 has spun up...
CPU 62 IS NOW UP!
Starting migration thread for cpu 62
Bringing up 63
Processor 8254/63 is spinning up...
CPU 63: 61 virtual and 50 physical address bits
CPU 63: nasid 62, slice 2, cnode 31
CPU 63: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU63: CPU has booted.
Processor 63 has spun up...
CPU 63 IS NOW UP!
Starting migration thread for cpu 63
Bringing up 64
Processor 64/64 is spinning up...
CPU 64: 61 virtual and 50 physical address bits
CPU 64: nasid 64, slice 0, cnode 32
CPU 64: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU64: CPU has booted.
Processor 64 has spun up...
CPU 64 IS NOW UP!
Starting migration thread for cpu 64
Bringing up 65
Processor 8256/65 is spinning up...
CPU 65: 61 virtual and 50 physical address bits
CPU 65: nasid 64, slice 2, cnode 32
CPU 65: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU65: CPU has booted.
Processor 65 has spun up...
CPU 65 IS NOW UP!
Starting migration thread for cpu 65
Bringing up 66
Processor 66/66 is spinning up...
CPU 66: 61 virtual and 50 physical address bits
CPU 66: nasid 66, slice 0, cnode 33
CPU 66: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU66: CPU has booted.
Processor 66 has spun up...
CPU 66 IS NOW UP!
Starting migration thread for cpu 66
Bringing up 67
Processor 8258/67 is spinning up...
CPU 67: 61 virtual and 50 physical address bits
CPU 67: nasid 66, slice 2, cnode 33
CPU 67: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU67: CPU has booted.
Processor 67 has spun up...
CPU 67 IS NOW UP!
Starting migration thread for cpu 67
Bringing up 68
Processor 68/68 is spinning up...
CPU 68: 61 virtual and 50 physical address bits
CPU 68: nasid 68, slice 0, cnode 34
CPU 68: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU68: CPU has booted.
Processor 68 has spun up...
CPU 68 IS NOW UP!
Starting migration thread for cpu 68
Bringing up 69
Processor 8260/69 is spinning up...
CPU 69: 61 virtual and 50 physical address bits
CPU 69: nasid 68, slice 2, cnode 34
CPU 69: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU69: CPU has booted.
Processor 69 has spun up...
CPU 69 IS NOW UP!
Starting migration thread for cpu 69
Bringing up 70
Processor 70/70 is spinning up...
CPU 70: 61 virtual and 50 physical address bits
CPU 70: nasid 70, slice 0, cnode 35
CPU 70: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU70: CPU has booted.
Processor 70 has spun up...
CPU 70 IS NOW UP!
Starting migration thread for cpu 70
Bringing up 71
Processor 8262/71 is spinning up...
CPU 71: 61 virtual and 50 physical address bits
CPU 71: nasid 70, slice 2, cnode 35
CPU 71: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU71: CPU has booted.
Processor 71 has spun up...
CPU 71 IS NOW UP!
Starting migration thread for cpu 71
Bringing up 72
Processor 72/72 is spinning up...
CPU 72: 61 virtual and 50 physical address bits
CPU 72: nasid 72, slice 0, cnode 36
CPU 72: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU72: CPU has booted.
Processor 72 has spun up...
CPU 72 IS NOW UP!
Starting migration thread for cpu 72
Bringing up 73
Processor 8264/73 is spinning up...
CPU 73: 61 virtual and 50 physical address bits
CPU 73: nasid 72, slice 2, cnode 36
CPU 73: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU73: CPU has booted.
Processor 73 has spun up...
CPU 73 IS NOW UP!
Starting migration thread for cpu 73
Bringing up 74
Processor 74/74 is spinning up...
CPU 74: 61 virtual and 50 physical address bits
CPU 74: nasid 74, slice 0, cnode 37
CPU 74: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU74: CPU has booted.
Processor 74 has spun up...
CPU 74 IS NOW UP!
Starting migration thread for cpu 74
Bringing up 75
Processor 8266/75 is spinning up...
CPU 75: 61 virtual and 50 physical address bits
CPU 75: nasid 74, slice 2, cnode 37
CPU 75: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2232.84 BogoMIPS
CPU75: CPU has booted.
Processor 75 has spun up...
CPU 75 IS NOW UP!
Starting migration thread for cpu 75
Bringing up 76
Processor 76/76 is spinning up...
CPU 76: 61 virtual and 50 physical address bits
CPU 76: nasid 76, slice 0, cnode 38
CPU 76: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2232.84 BogoMIPS
CPU76: CPU has booted.
Processor 76 has spun up...
CPU 76 IS NOW UP!
Starting migration thread for cpu 76
Bringing up 77
Processor 8268/77 is spinning up...
CPU 77: 61 virtual and 50 physical address bits
CPU 77: nasid 76, slice 2, cnode 38
CPU 77: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2241.08 BogoMIPS
CPU77: CPU has booted.
Processor 77 has spun up...
CPU 77 IS NOW UP!
Starting migration thread for cpu 77
Bringing up 78
Processor 78/78 is spinning up...
CPU 78: 61 virtual and 50 physical address bits
CPU 78: nasid 78, slice 0, cnode 39
CPU 78: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2232.84 BogoMIPS
CPU78: CPU has booted.
Processor 78 has spun up...
CPU 78 IS NOW UP!
Starting migration thread for cpu 78
Bringing up 79
Processor 8270/79 is spinning up...
CPU 79: 61 virtual and 50 physical address bits
CPU 79: nasid 78, slice 2, cnode 39
CPU 79: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2241.08 BogoMIPS
CPU79: CPU has booted.
Processor 79 has spun up...
CPU 79 IS NOW UP!
Starting migration thread for cpu 79
Bringing up 80
Processor 80/80 is spinning up...
CPU 80: 61 virtual and 50 physical address bits
CPU 80: nasid 80, slice 0, cnode 40
CPU 80: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU80: CPU has booted.
Processor 80 has spun up...
CPU 80 IS NOW UP!
Starting migration thread for cpu 80
Bringing up 81
Processor 8272/81 is spinning up...
CPU 81: 61 virtual and 50 physical address bits
CPU 81: nasid 80, slice 2, cnode 40
CPU 81: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU81: CPU has booted.
Processor 81 has spun up...
CPU 81 IS NOW UP!
Starting migration thread for cpu 81
Bringing up 82
Processor 82/82 is spinning up...
CPU 82: 61 virtual and 50 physical address bits
CPU 82: nasid 82, slice 0, cnode 41
CPU 82: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU82: CPU has booted.
Processor 82 has spun up...
CPU 82 IS NOW UP!
Starting migration thread for cpu 82
Bringing up 83
Processor 8274/83 is spinning up...
CPU 83: 61 virtual and 50 physical address bits
CPU 83: nasid 82, slice 2, cnode 41
CPU 83: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU83: CPU has booted.
Processor 83 has spun up...
CPU 83 IS NOW UP!
Starting migration thread for cpu 83
Bringing up 84
Processor 84/84 is spinning up...
CPU 84: 61 virtual and 50 physical address bits
CPU 84: nasid 84, slice 0, cnode 42
CPU 84: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU84: CPU has booted.
Processor 84 has spun up...
CPU 84 IS NOW UP!
Starting migration thread for cpu 84
Bringing up 85
Processor 8276/85 is spinning up...
CPU 85: 61 virtual and 50 physical address bits
CPU 85: nasid 84, slice 2, cnode 42
CPU 85: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU85: CPU has booted.
Processor 85 has spun up...
CPU 85 IS NOW UP!
Starting migration thread for cpu 85
Bringing up 86
Processor 86/86 is spinning up...
CPU 86: 61 virtual and 50 physical address bits
CPU 86: nasid 86, slice 0, cnode 43
CPU 86: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU86: CPU has booted.
Processor 86 has spun up...
CPU 86 IS NOW UP!
Starting migration thread for cpu 86
Bringing up 87
Processor 8278/87 is spinning up...
CPU 87: 61 virtual and 50 physical address bits
CPU 87: nasid 86, slice 2, cnode 43
CPU 87: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU87: CPU has booted.
Processor 87 has spun up...
CPU 87 IS NOW UP!
Starting migration thread for cpu 87
Bringing up 88
Processor 88/88 is spinning up...
CPU 88: 61 virtual and 50 physical address bits
CPU 88: nasid 88, slice 0, cnode 44
CPU 88: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU88: CPU has booted.
Processor 88 has spun up...
CPU 88 IS NOW UP!
Starting migration thread for cpu 88
Bringing up 89
Processor 8280/89 is spinning up...
CPU 89: 61 virtual and 50 physical address bits
CPU 89: nasid 88, slice 2, cnode 44
CPU 89: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU89: CPU has booted.
Processor 89 has spun up...
CPU 89 IS NOW UP!
Starting migration thread for cpu 89
Bringing up 90
Processor 90/90 is spinning up...
CPU 90: 61 virtual and 50 physical address bits
CPU 90: nasid 90, slice 0, cnode 45
CPU 90: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU90: CPU has booted.
Processor 90 has spun up...
CPU 90 IS NOW UP!
Starting migration thread for cpu 90
Bringing up 91
Processor 8282/91 is spinning up...
CPU 91: 61 virtual and 50 physical address bits
CPU 91: nasid 90, slice 2, cnode 45
CPU 91: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU91: CPU has booted.
Processor 91 has spun up...
CPU 91 IS NOW UP!
Starting migration thread for cpu 91
Bringing up 92
Processor 92/92 is spinning up...
CPU 92: 61 virtual and 50 physical address bits
CPU 92: nasid 92, slice 0, cnode 46
CPU 92: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU92: CPU has booted.
Processor 92 has spun up...
CPU 92 IS NOW UP!
Starting migration thread for cpu 92
Bringing up 93
Processor 8284/93 is spinning up...
CPU 93: 61 virtual and 50 physical address bits
CPU 93: nasid 92, slice 2, cnode 46
CPU 93: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU93: CPU has booted.
Processor 93 has spun up...
CPU 93 IS NOW UP!
Starting migration thread for cpu 93
Bringing up 94
Processor 94/94 is spinning up...
CPU 94: 61 virtual and 50 physical address bits
CPU 94: nasid 94, slice 0, cnode 47
CPU 94: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU94: CPU has booted.
Processor 94 has spun up...
CPU 94 IS NOW UP!
Starting migration thread for cpu 94
Bringing up 95
Processor 8286/95 is spinning up...
CPU 95: 61 virtual and 50 physical address bits
CPU 95: nasid 94, slice 2, cnode 47
CPU 95: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
Calibrating delay loop... 2224.60 BogoMIPS
CPU95: CPU has booted.
Processor 95 has spun up...
CPU 95 IS NOW UP!
Starting migration thread for cpu 95
CPUS done 128
Total of 96 processors activated (213739.60 BogoMIPS).
NET: Registered protocol family 16
ACPI: Subsystem revision 20031002
    ACPI-0077: *** Warning: Invalid FADT value PM1_EVT_LEN=0 at offset 58 FADT=e00000300e5d0480
    ACPI-0077: *** Warning: Invalid FADT value PM1_CNT_LEN=0 at offset 59 FADT=e00000300e5d0480
    ACPI-0077: *** Warning: Invalid FADT value X_PM1a_EVT_BLK=0 at offset 98 FADT=e00000300e5d0480
    ACPI-0077: *** Warning: Invalid FADT value X_PM1a_CNT_BLK=0 at offset B0 FADT=e00000300e5d0480
    ACPI-0077: *** Warning: Invalid FADT value X_PM_TMR_BLK=0 at offset D4 FADT=e00000300e5d0480
    ACPI-0077: *** Warning: Invalid FADT value PM_TM_LEN=0 at offset 5B FADT=e00000300e5d0480
    ACPI-0888: *** Info: There are no GPE blocks defined in the FADT
ACPI: SCI (IRQ-1) allocation failed
    ACPI-0133: *** Error: Unable to install System Control Interrupt Handler, AE_NOT_ACQUIRED
ACPI: Unable to start the ACPI Interpreter
Trying to free free IRQ0
SCSI subsystem initialized
ACPI: ACPI tables contain no PCI IRQ routing entries
PCI: Invalid ACPI-PCI IRQ routing table
perfmon: version 2.0 IRQ 238
perfmon: Itanium 2 PMU detected, 16 PMCs, 18 PMDs, 4 counters (47 bits)
PAL Information Facility v0.5
perfmon: added sampling format default_format
perfmon_default_smpl: default_format v2.0 registered
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
SGI XFS for Linux with large block/inode numbers, no debug enabled
pty: 256 Unix98 ptys configured
sn_serial: sn_sal_module_init
EFI Time Services Driver v0.4
loop: loaded (max 8 devices)
tg3.c:v2.2 (August 24, 2003)
PCI: Found IRQ 54 for device 0000:01:04.0
ACPI: No IRQ known for interrupt pin A of device 0000:01:04.0 - using IRQ 54
eth0: Tigon3 [partno(030-1771-000) rev 0105 PHY(5701)] (PCI:66MHz:64-bit) 10/100/1000BaseT Ethernet 08:00:69:13:e6:a7
PCI: Found IRQ 66 for device 0000:11:04.0
ACPI: No IRQ known for interrupt pin A of device 0000:11:04.0 - using IRQ 66
eth1: Tigon3 [partno(030-1771-000) rev 0105 PHY(5701)] (PCI:66MHz:64-bit) 10/100/1000BaseT Ethernet 08:00:69:13:e4:a4
PCI: Found IRQ 53 for device 0000:01:03.0
ACPI: No IRQ known for interrupt pin A of device 0000:01:03.0 - using IRQ 53
qla1280: QLA12160 found on PCI bus 1, dev 3
scsi(0): Enabling SN2 PCI DMA dual channel lockup workaround
scsi(0): Enabling SN2 PCI DMA workaround
scsi(0:0): Resetting SCSI BUS
scsi(0:1): Resetting SCSI BUS
PCI: Found IRQ 65 for device 0000:11:03.0
ACPI: No IRQ known for interrupt pin A of device 0000:11:03.0 - using IRQ 65
qla1280: QLA12160 found on PCI bus 17, dev 3
scsi(1): Enabling SN2 PCI DMA dual channel lockup workaround
scsi(1): Enabling SN2 PCI DMA workaround
scsi(1:0): Resetting SCSI BUS
scsi(1:1): Resetting SCSI BUS
scsi0 : QLogic QLA12160 PCI to SCSI Host Adapter: bus 1 device 3 irq 53
       Firmware version: 10.04.32, Driver version 3.23.37
Using anticipatory io scheduler
  Vendor: SGI       Model: ST336753LC        Rev: 2741
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi(0:0:1:0): Sync: period 9, offset 14, Wide, DT, Tagged queuing: depth 255
  Vendor: SGI       Model: ST336753LC        Rev: 2741
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi(0:0:2:0): Sync: period 9, offset 14, Wide, DT, Tagged queuing: depth 255
scsi1 : QLogic QLA12160 PCI to SCSI Host Adapter: bus 17 device 3 irq 65
       Firmware version: 10.04.32, Driver version 3.23.37
  Vendor: SGI       Model: ST336753LC        Rev: 2741
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi(1:0:1:0): Sync: period 9, offset 14, Wide, DT, Tagged queuing: depth 255
  Vendor: SGI       Model: ST336753LC        Rev: 2741
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi(1:0:2:0): Sync: period 9, offset 14, Wide, DT, Tagged queuing: depth 255
SCSI device sda: 71687372 512-byte hdwr sectors (36704 MB)
SCSI device sda: drive cache: write through
 sda: sda1 sda2 sda3
Attached scsi disk sda at scsi0, channel 0, id 1, lun 0
SCSI device sdb: 71687372 512-byte hdwr sectors (36704 MB)
SCSI device sdb: drive cache: write through
 sdb: sdb1 sdb2 sdb3 sdb4 sdb5 sdb6 sdb7 sdb8
Attached scsi disk sdb at scsi0, channel 0, id 2, lun 0
SCSI device sdc: 71687372 512-byte hdwr sectors (36704 MB)
SCSI device sdc: drive cache: write through
 sdc: sdc1 sdc2 sdc3
Attached scsi disk sdc at scsi1, channel 0, id 1, lun 0
SCSI device sdd: 71687372 512-byte hdwr sectors (36704 MB)
SCSI device sdd: drive cache: write through
 sdd: sdd1 sdd2 sdd3 sdd4 sdd5 sdd6 sdd7 sdd8
Attached scsi disk sdd at scsi1, channel 0, id 2, lun 0
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
IP: routing cache hash table of 8388608 buckets, 131072Kbytes
swapper: page allocation failure. order:17, mode:0x20
TCP: Hash tables configured (established 67108864 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
XFS mounting filesystem sda3
Ending clean XFS mount for filesystem: sda3
VFS: Mounted root (xfs filesystem) readonly.
Freeing unused kernel memory: 192kB freed
XFS mounting filesystem sdb6
