Return-Path: <linux-kernel-owner+w=401wt.eu-S1751673AbXAQEBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751673AbXAQEBJ (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 23:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751701AbXAQEBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 23:01:09 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:58606 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751673AbXAQEBI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 23:01:08 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=l3UfGoJRtp/8P8AL+3+xhHKMx3XZBTE+Ixj2MMfYwpaZ7EX4fyfTp3mGWcV44uT7LeA6JrdrjZh20DlBlnSOAiCw7NtmHOzGsu8493Imd5pnlD6aPHyFyLEyWs7BAhCfRnnpN52pJOcZiovyhTSDnYoZEWUV96576yJFwDI9uQg=
Message-ID: <305c16960701162001j5ec23332hcd398cbe944916e1@mail.gmail.com>
Date: Wed, 17 Jan 2007 02:01:05 -0200
From: "Matheus Izvekov" <mizvekov@gmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: BUG: linux 2.6.19 unable to enable acpi
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just tried linux for the first time on this old machine, and i got
this problem. dmesg below:

Linux version 2.6.19 (root@localhost) (gcc version 4.1.1 (Gentoo
4.1.1-r3)) #10 PREEMPT Sun Dec 10 17:35:24 BRST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000dc000 - 00000000000e0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fdf0000 (usable)
 BIOS-e820: 000000000fdf0000 - 000000000fdf8000 (ACPI data)
 BIOS-e820: 000000000fdf8000 - 000000000fe00000 (ACPI NVS)
 BIOS-e820: 00000000ffef0000 - 00000000fff00000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
253MB LOWMEM available.
Entering add_active_range(0, 0, 65008) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->    65008
early_node_map[1] active PFN ranges
    0:        0 ->    65008
On node 0 totalpages: 65008
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 475 pages used for memmap
  Normal zone: 60437 pages, LIFO batch:15
DMI 2.2 present.
ACPI: RSDP (v000 AMI                                   ) @ 0x000fb080
ACPI: RSDT (v001 AMIINT          0x00000000 MSFT 0x00000097) @ 0x0fdf0000
ACPI: FADT (v001 AMIINT          0x00000000 MSFT 0x00000097) @ 0x0fdf0030
ACPI: DSDT (v001    SiS      620 0x00001000 MSFT 0x0100000a) @ 0x00000000
ACPI: PM-Timer IO Port: 0x408
Allocating PCI resources starting at 10000000 (gap: 0fe00000:f00f0000)
Detected 300.701 MHz processor.
Built 1 zonelists.  Total pages: 64501
Kernel command line: root=/dev/sda3
Local APIC disabled by BIOS -- you can enable it with "lapic"
mapped APIC to ffffd000 (01201000)
Initializing CPU#0
CPU 0 irqstacks, hard=c039e000 soft=c039d000
PID hash table entries: 1024 (order: 10, 4096 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 254172k/260032k available (1868k kernel code, 5368k reserved,
603k data, 180k init, 0k highmem)
virtual kernel memory layout:
    fixmap  : 0xfffb7000 - 0xfffff000   ( 288 kB)
    vmalloc : 0xd0800000 - 0xfffb5000   ( 759 MB)
    lowmem  : 0xc0000000 - 0xcfdf0000   ( 253 MB)
      .init : 0xc036b000 - 0xc0398000   ( 180 kB)
      .data : 0xc02d3086 - 0xc0369fa8   ( 603 kB)
      .text : 0xc0100000 - 0xc02d3086   (1868 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 601.79 BogoMIPS (lpj=300897)
Security Framework v1.0.0 initialized
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0080f9ff 00000000 00000000 00000000
00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After all inits, caps: 0080f9ff 00000000 00000000 00000040
00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium II (Klamath) stepping 03
Checking 'hlt' instruction... OK.
ACPI: Core revision 20060707
ACPI: setting ELCR to 0200 (from 1c00)
ACPI Error (hwacpi-0179): Hardware did not change modes [20060707]
ACPI Error (evxfevnt-0084): Could not transition to ACPI mode [20060707]
ACPI Warning (utxface-0154): AcpiEnable failed [20060707]
ACPI: Unable to enable ACPI
