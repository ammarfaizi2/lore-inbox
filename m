Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268102AbTAKUP2>; Sat, 11 Jan 2003 15:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268130AbTAKUP2>; Sat, 11 Jan 2003 15:15:28 -0500
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:54422 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S268102AbTAKUPZ>; Sat, 11 Jan 2003 15:15:25 -0500
Date: Sat, 11 Jan 2003 12:29:23 -0800
From: David Brownell <david-b@pacbell.net>
Subject: 2.5.56 won't boot (but 2.5.53 will)
To: linux-kernel@vger.kernel.org
Message-id: <3E207EA3.2090504@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So 2.5 is newly an obstacle on the machines I use for development
and testing.  There's the Cardbus issue (appeared in 2.5.53 as
far as I can tell) ... then there's this one (appeared in 2.5.54)
which I haven't seen posted before.

Symptom:  system hangs during boot, right where it's shown in the
annotated log below.  On 2.5.56 I also tried after disabling SMP
and all the local APIC stuff in the build, but it didn't matter.
These are otherwise the same .config setups, modulo whatever
magic "make oldconfig" did.

In case it matters, this is kt333-based with a vt8235 south bridge.
It's never shown this type of boot problem before.

Suggestions, or patches?

- Dave


Linux version 2.5.53 (root@helium) (gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-110)) #10 SMP 
Fri Jan 3 11:47:10 PST 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 0000000020000000 (usable)
  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
512MB LOWMEM available.
found SMP MP-table at 000f50e0
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
	
	right here is where 2.5.56 (and 2.5.54) stops booting:
	before messages about zone allocations.  Alt-SysRQ-B works.

On node 0 totalpages: 131072
   DMA zone: 4096 pages, LIFO batch:1
   Normal zone: 126976 pages, LIFO batch:16
   HighMem zone: 0 pages, LIFO batch:1
Intel MultiProcessor Specification v1.4
     Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #0 6:6 APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 1
Building zonelist for node : 0
Kernel command line: ro root=/dev/hda9 nmi_watchdog=1
Initializing CPU#0
Detected 1532.634 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3014.65 BogoMIPS
Memory: 515688k/524288k available (1508k kernel code, 7864k reserved, 725k data, 112k init, 0k highmem)


