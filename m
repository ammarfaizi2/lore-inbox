Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267528AbTALVRX>; Sun, 12 Jan 2003 16:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267532AbTALVRX>; Sun, 12 Jan 2003 16:17:23 -0500
Received: from xyzzy.bubble.org ([132.238.254.34]:35085 "EHLO xyzzy.bubble.org")
	by vger.kernel.org with ESMTP id <S267528AbTALVRV>;
	Sun, 12 Jan 2003 16:17:21 -0500
Message-ID: <3E21DD72.7080903@xyzzy.bubble.org>
Date: Sun, 12 Jan 2003 16:26:10 -0500
From: Jeffrey Ross <jeff@xyzzy.bubble.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ACPI errors (2.4.21-pre3-ac4)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This existed with the earlier kernels as well, on boot up I get the 
following when I enable ACPI:

early in the dmesg output:

found SMP MP-table at 000ff780
hm, page 000ff000 reserved twice.
hm, page 00100000 reserved twice.
hm, page 000fd000 reserved twice.
hm, page 000fe000 reserved twice.
On node 0 totalpages: 63296
zone(0): 4096 pages.
zone(1): 59200 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.4
     Virtual Wire compatibility mode.
OEM ID:  Product ID: BrkdleG-ICH4 APIC at: 0xFEE00000
Processor #0 Pentium 4(tm) XEON(tm) APIC version 20
I/O APIC #1 Version 32 at 0xFEC00000.
Enabling APIC mode: Flat.       Using 1 I/O APICs
Processors: 1
Kernel command line: ro root=/dev/hda3 console=tty0 console=ttyS0
Initializing CPU#0

and then a little further down:

ACPI-0202: *** Warning: Invalid table signature ASF! found
ACPI-0095: *** Error: Acpi_load_tables: Error getting required tables 
(DSDT/FADT/FACS): AE_BAD_SIGNATURE
ACPI-0116: *** Error: Acpi_load_tables: Could not load tables: 
AE_BAD_SIGNATURE
ACPI: System description table load failed

Processor is a P-4 2Ghz

/proc/cpuinfo:
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.00GHz
stepping        : 4
cpu MHz         : 1999.823
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 3984.58


The motherboard is an Intel model D845GBV

Jeff

