Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264088AbTIINU7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 09:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264113AbTIINU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 09:20:58 -0400
Received: from maja.beep.pl ([195.245.198.10]:26130 "EHLO maja.beep.pl")
	by vger.kernel.org with ESMTP id S264088AbTIINUz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 09:20:55 -0400
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: Andrew de Quincey <adq_dvb@lidskialf.net>
Subject: acpi-irq-fixes from test5-mm1 broken with acpi=off
Date: Tue, 9 Sep 2003 15:18:07 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200309091518.07368.arekm@pld-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've tried vanilla test5 + your acpi-irq-fixes patch found here:
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test5/2.6.0-test5-mm1/broken-out/acpi-irq-fixes.patch

It changes things when comparingo to test5 - for more see:
- vanilla test5 dmesg: http://lkml.org/lkml/2003/9/9/31
- test5+acpi-irq-fixes dmesg: http://lkml.org/lkml/2003/9/9/56

Now the problem is that with vanilla test5 acpi=off works well - see dmesg 
http://lkml.org/lkml/2003/9/9/31 but after applying acpi-irq-fixes I get:

Loading pld-2.6.0..........................
BIOS data check successful
Linux version 2.6.0 (builder@beton) (gcc version 3.3.1 (PLD Linux)) #1 Tue Sep 
9 09:02:07 UTC 2003
Video mode to be used for restore is f07
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000cc000 - 00000000000d0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000eff0000 (usable)
 BIOS-e820: 000000000eff0000 - 000000000eff8000 (ACPI data)
 BIOS-e820: 000000000eff8000 - 000000000f000000 (ACPI NVS)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
239MB LOWMEM available.
On node 0 totalpages: 61424
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 57328 pages, LIFO batch:13
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=pld-2.6.0 ro root=303 console=ttyS0,57600n81 
console=tty0 acpi=off
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 1533.495 MHz processor.
Console: colour VGA+ 80x60
Memory: 239664k/245696k available (1661k kernel code, 5336k reserved, 679k 
data, 164k init, 0k highmem)
Calibrating delay loop... 3022.84 BogoMIPS
Security Scaffold v1.0.0 initialized
SELinux:  Not enabled at boot.
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD mobile AMD Athlon(tm) XP-M 1800+ stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfdb51, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20030813
ACPI: Interpreter disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f7710
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x673b, dseg 0xf0000
PnPBIOS: Unknown tag '0x82', length '22'.
PnPBIOS: 15 nodes reported by PnP BIOS; 15 recorded by driver
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c01cd217
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c01cd217>]    Not tainted
EFLAGS: 00010246
EIP is at acpi_pci_link_calc_penalties+0x29/0xad
eax: c0387dc0   ebx: 00000000   ecx: 00000000   edx: c03881c0
esi: 00000001   edi: 00000000   ebp: cefa3fa0   esp: cefa3f98
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=cefa2000 task=cefa18c0)
Stack: 00000000 00000001 cefa3fac c035b3cc c037130c cefa3fb8 c0368aa3 c0371308 
       cefa3fd4 c034c7bc cefa3fcc c0130432 c02af2be cefa2000 00000000 cefa3fec 
       c01050a1 00000000 c0105070 00000000 00000000 00000000 c0109259 00000000 
Call Trace:
 [<c035b3cc>] acpi_pci_irq_init+0xb/0x47
 [<c0368aa3>] pci_acpi_init+0x23/0x60
 [<c034c7bc>] do_initcalls+0x2c/0xa0
 [<c0130432>] init_workqueues+0x12/0x60
 [<c01050a1>] init+0x31/0x1d0
 [<c0105070>] init+0x0/0x1d0
 [<c0109259>] kernel_thread_helper+0x5/0xc

Code: 8b 01 74 04 0f 18 00 90 81 f9 cc 81 38 c0 74 6b 0f b6 41 10 
 <0>Kernel panic: Attempted to kill init!

-- 
Arkadiusz Mi¶kiewicz    CS at FoE, Wroclaw University of Technology
arekm.pld-linux.org AM2-6BONE, 1024/3DB19BBD, arekm(at)ircnet, PLD/Linux

