Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267516AbUJBT1X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267516AbUJBT1X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 15:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267518AbUJBT1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 15:27:23 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:37827 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S267516AbUJBT1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 15:27:18 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.9-rc3-mm1 [immediate crash on AMD64]
Date: Sat, 2 Oct 2004 21:29:41 +0200
User-Agent: KMail/1.6.2
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
References: <20041002014352.2b55e98d.akpm@osdl.org>
In-Reply-To: <20041002014352.2b55e98d.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200410022129.41761.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 02 of October 2004 10:43, Andrew Morton wrote:
> 
> 
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc3/2.6.9-rc3-mm1/

It compiles for me on an Athlon 64-based box, but that's what I get from it 
after reboot (100% of the time):

Bootdata ok (command line is root=/dev/hdc6 vga=792 resume=/dev/hdc3 
pci=routeirq nmi_watchdog=0 console=ttyS0,57600)
Linux version 2.6.9-rc3-mm1 (rafael@albercik) (gcc version 3.3.3 (SuSE Linux)) 
#1 Sat Oct 2 12:20:54 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff40000 (usable)
 BIOS-e820: 000000001ff40000 - 000000001ff50000 (ACPI data)
 BIOS-e820: 000000001ff50000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
No mptable found.
PCI bridge 00:0a from 10de found. Setting "noapic". Overwrite with "apic"
  >>> ERROR: Invalid checksum
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: ASUSTeK  <6>Product ID: L5D          <6>APIC at: 0xFEE00000
Processor #0 15:4 APIC version 16
I/O APIC #1 Version 17 at 0xFEC00000.
Processors: 1
Checking aperture...
CPU 0: aperture @ e8000000 size 128 MB
Built 1 zonelists
Initializing CPU#0
Kernel command line: root=/dev/hdc6 vga=792 resume=/dev/hdc3 pci=routeirq 
nmi_watchdog=0 console=ttyS0,57600
PID hash table entries: 2048 (order: 11, 65536 bytes)
time.c: Using 1.193182 MHz PIT timer.
time.c: Detected 1795.399 MHz processor.
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Memory: 509464k/523520k available (2754k kernel code, 13508k reserved, 1144k 
data, 164k init)
Security Scaffold v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
There is already a security framework initialized, register_security failed.
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 256 (order: 0, 4096 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU: AMD Athlon(tm) 64 Processor 3000+ stepping 0a
ACPI: IRQ9 SCI: Edge set to Level Trigger.
Unable to handle kernel NULL pointer dereference at 0000000000000018 RIP:
<ffffffff8056bdf7>{setup_local_APIC+23}
PML4 0
Oops: 0000 [1]
CPU 0
Modules linked in:
Pid: 1, comm: swapper Tainted: G   M  2.6.9-rc3-mm1
RIP: 0010:[<ffffffff8056bdf7>] <ffffffff8056bdf7>{setup_local_APIC+23}
RSP: 0000:000001001fe27ef8  EFLAGS: 00010212
RAX: 0000000000000000 RBX: 0000000000040010 RCX: ffffffff804de3e0
RDX: 0000000000000000 RSI: 0000000001000000 RDI: ffffffff803c7ed1
RBP: 0000000000000010 R08: 000000000063d5f4 R09: 0000000000000005
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffffffff80557a80(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000018 CR3: 0000000000101000 CR4: 00000000000006e0
Process swapper (pid: 1, threadinfo 000001001fe26000, task 000001001fe251b0)
Stack: 0000000000000000 0000000000000000 0000000000000000 ffffffff8056bffb
       0000000000000001 0000000000000000 0000000000000800 ffffffff8010c0d0
       ffffffff8041e2e0 0000000000000800
Call Trace:<ffffffff8056bffb>{APIC_init_uniprocessor+139} 
<ffffffff8010c0d0>{init+32}
       <ffffffff80111843>{child_rip+8} <ffffffff8010c0b0>{init+0}
       <ffffffff8011183b>{child_rip+0}

Code: ff 50 18 85 c0 75 0c 0f 0b 59 83 3c 80 ff ff ff ff 4f 01 48
RIP <ffffffff8056bdf7>{setup_local_APIC+23} RSP <000001001fe27ef8>
CR2: 0000000000000018
 <0>Kernel panic - not syncing: Attempted to kill init!

Both the 2.6.9-rc3 and the 2.6.9-rc2-mm4 start just fine.

The .config is available at:
http://www.sisk.pl/kernel/041002/2.6.9-rc3-mm1.config
The output of dmesg (for 2.6.9-rc3) is available at:
http://www.sisk.pl/kernel/041002/2.6.9-rc3-dmesg.log

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
