Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275004AbTHRUhv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 16:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274969AbTHRUgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 16:36:42 -0400
Received: from trotter.ricis.com ([64.244.234.19]:20163 "EHLO
	trotter.ricis.com") by vger.kernel.org with ESMTP id S275003AbTHRUf0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 16:35:26 -0400
Date: Mon, 18 Aug 2003 15:35:23 -0500
From: lee leahu <lee@ricis.com>
To: linux-kernel@vger.kernel.org
Subject: ioremap.c:30 kernel panic
Message-Id: <20030818153523.36e5d0ac.lee@ricis.com>
Reply-To: lee@ricis.com
Organization: RICIS, Inc.
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Policy: TAG vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello all,

I just upgraded my kernel to the following version 2.4.18-4gb on a dell poweredge 2450 server with adaptec raid controller (perc3 using module aacraid).

I am now getting a kernel panic.  

Listed below is the output from the kernel on the serial port.

please take a look and give some suggestions about what can be done to resolve this?  
i am not currently subscribed to this mailing list however, so please be sure to cc me on your replies.



------snip-----
Linux version 2.4.18-4GB (root@Gollum) (gcc version 2.95.3 20010315
(SuSE)) #1 T
hu Jul 17 18:35:14 GMT 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fffe000 (usable)
 BIOS-e820: 000000007fffe000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
1151MB HIGHMEM available.
896MB LOWMEM available.
Advanced speculative caching feature not present
On node 0 totalpages: 524286
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 294910 pages.
Building zonelist for node : 0
Kernel command line: auto BOOT_IMAGE=linux ro root=802
BOOT_FILE=/boot/vmlinuz c
onsole=ttyS0,9600
Initializing CPU#0
Detected 993.400 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 1979.18 BogoMIPS
Memory: 2069244k/2097144k available (1408k kernel code, 27516k reserved,
421k da
ta, 120k init, 1179640k highmem)
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode cache hash table entries: 131072 (order: 8, 1048576 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 131072 (order: 7, 524288 bytes)
Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium III (Coppermine) stepping 06
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
Checking for popad bug... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfc73e, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Discovered primary peer bus 01 [IRQ]
PCI: Using IRQ router ServerWorks [1166/0200] at 00:0f.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS not found.
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
kinoded started
VFS: Diskquotas version dquot_6.5.0 initialized
ACPI: Core Subsystem version [20011018]
ACPI: Subsystem enabled
remap_area_pte: page already exists
kernel BUG at ioremap.c:30!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0113e81>]    Not tainted
EFLAGS: 00010282
eax: 00000024   ebx: 00400000   ecx: 00000001   edx: 00000001
esi: 00000000   edi: ffffa000   ebp: 00013000   esp: c283bf3c
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, stackpage=c283b000)
Stack: c0268f60 00400000 f8813000 fc000000 00000000 00000063 c0101f90 fc3ed000
       ffffa000 00013000 fc3ed000 c0101f8c f8c13000 c0101f8c fffffff4 037ed000
       c0114044 f8c00000 fc000000 00400000 00000000 00000000 c02e5508 00000000
Call Trace: [<c0114044>] [<c0105023>] [<c0106ff8>]

Code: 0f 0b 1e 00 53 8f 26 c0 83 c4 04 8b 44 24 18 25 00 f0 ff ff
 <0>Kernel panic: Attempted to kill init!
------snip-----


-- 
Lee Leahu                           RICIS, Inc.
Internet Technology Specialist      866-RICIS-77 Toll Free Voice (US)
lee@ricis.com                       708-444-2690 Voice (International)
http://www.ricis.com/               866-99-RICIS Toll Free Fax (US)
                                    708-444-2697 Fax (International)

RICIS, Inc. is a member of the Public Safety Alliance Group

This email and any attachments that are included in it have been scanned
for malicious or inappropriate content and are believed to be safe.
