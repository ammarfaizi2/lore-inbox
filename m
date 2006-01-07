Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965358AbWAGAAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965358AbWAGAAr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 19:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965360AbWAGAAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 19:00:46 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:14776 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965358AbWAGAAq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 19:00:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Dm+szpcgjyzJhfFMyNEViZNHBUfe97MCksot3JBw5Ozmm1MnnctQoGQoqgLTv9EQgubV9rX1HcYThQhHWUo+U8Orx/mwyZHokSVgn0NqozIBET6g1qwTFW30zYs8hv1WxApZbW7zkmW50CzDWDXslUIllvgMqO/BeMMukTJzqVo=
Message-ID: <86802c440601061600p5cba2fbet61b2269cca3ab021@mail.gmail.com>
Date: Fri, 6 Jan 2006 16:00:44 -0800
From: Yinghai Lu <yinghai.lu@amd.com>
To: Andi Kleen <ak@muc.de>
Subject: Re: Inclusion of x86_64 memorize ioapic at bootup patch
Cc: Vivek Goyal <vgoyal@in.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Morton Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060106234803.GA67207@muc.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060103044632.GA4969@in.ibm.com> <20060106234803.GA67207@muc.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric,

Do you try kexec with Nvidia ck804 based MB? it seems some one modify
the mptable but not update the checksum ...

YH

The first kernel said:

..TIMER: vector=0x31 apic1=0 pin1=2 apic2=0 pin2=0
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ...
..... (found apic 0 pin 0) ...works.
testing the IO APIC.......................


.................................... done.
Using local APIC timer interrupts.
Detected 12.564 MHz APIC timer.



LBsuse91AMD64:/x/xx/xx/elf # ../kexec -l ram0_2.5_2.6.15_k8.1_mydisk8_x86_64.elf
LBsuse91AMD64:/x/xx/xx/elf # ../kexec -e
Starting new kernel
Firmware type: LinuxBIOS
old bootloader convention, maybe loadlin?
Bootdata ok (command line is apic=debug pci=routeirq
ramdisk_size=65536 root=/dev/ram0 rw console=tty0
console=ttyS0,115200n8 )
Linux version 2.6.15-gdb9edfd7 (root@yhlunb) (gcc version 4.0.2
20050901 (prerelease) (SUSE Linux)) #7 SMP Fri Jan 6 15:18:18 PST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 0000000000000e7c (reserved)
 BIOS-e820: 0000000000000e7c - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 00000000000f0400 (reserved)
 BIOS-e820: 0000000000100000 - 00000000c0000000 (usable)
 BIOS-e820: 0000000100000000 - 0000000240000000 (usable)
ACPI: Unable to locate RSDP
Scanning NUMA topology in Northbridge 24
Number of nodes 4
Node 0 MemBase 0000000000000000 Limit 0000000080000000
Node 1 MemBase 0000000080000000 Limit 0000000140000000
Node 2 MemBase 0000000140000000 Limit 00000001c0000000
Node 3 MemBase 00000001c0000000 Limit 0000000240000000
Using node hash shift of 30
Bootmem setup node 0 0000000000000000-0000000080000000
Bootmem setup node 1 0000000080000000-0000000140000000
Bootmem setup node 2 0000000140000000-00000001c0000000
Bootmem setup node 3 00000001c0000000-0000000240000000
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
SMP mptable: checksum error!
BIOS bug, MP table errors detected!...
... disabling SMP support. (tell your hw vendor)
Allocating PCI resources starting at c4000000 (gap: c0000000:40000000)
Checking aperture...
CPU 0: aperture @ f8000000 size 64 MB
CPU 1: aperture @ f8000000 size 64 MB
CPU 2: aperture @ f8000000 size 64 MB
CPU 3: aperture @ f8000000 size 64 MB
Built 4 zonelists
Kernel command line: apic=debug pci=routeirq ramdisk_size=65536
root=/dev/ram0 rw console=tty0 console=ttyS0,115200n8
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 1.193182 MHz PIT timer.
time.c: Detected 1809.308 MHz processor.
Console: colour dummy device 80x25
Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
Memory: 8223632k/9437184k available (2958k kernel code, 164588k
reserved, 1183k data, 228k init)
Calibrating delay using timer specific routine.. 3623.87 BogoMIPS (lpj=7247741)
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0(2) -> Node 0 -> Core 0
mtrr: v2.0 (20020519)
weird, boot CPU (#16) not listed by the BIOS.
SMP motherboard not detected.
Getting VERSION: 40010
Getting VERSION: 40010
Getting ID: 10000000
Getting ID: ef000000
Getting LVT0: 700
Getting LVT1: 400
----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at arch/x86_64/kernel/apic.c:333
invalid operand: 0000 [1] SMP
CPU 0
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.15-gdb9edfd7 #7
RIP: 0010:[<ffffffff8056cd64>] <ffffffff8056cd64>{setup_local_APIC+23}
RSP: 0000:ffff810141c49eb8  EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000010 RCX: 0000000000000000
RDX: 00000000ffffff01 RSI: ffff810141c49f08 RDI: ffffffff80518fc0
RBP: 0000000000000000 R08: 0000000000000720 R09: 00000000ffffffff
R10: 00000000ffffffff R11: ffffffff8023dfa5 R12: 0000000000000010
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffffffff80557800(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00000000005adf18 CR3: 0000000000101000 CR4: 00000000000006e0
Process swapper (pid: 1, threadinfo ffff810141c48000, task ffff810003619480)
Stack: 00000000ffffffff ffffffff8056d089 0000000000010000 0000000000000000
       0000000000000000 0000000000000000 0000000000010000 0000000000000000
       0000000000000000 0000000000000000
Call Trace:<ffffffff8056d089>{APIC_init_uniprocessor+151}
<ffffffff8056beb1>{smp_prepare_cpus+637}
       <ffffffff8010b07a>{init+54} <ffffffff8010b044>{init+0}
       <ffffffff8010e662>{child_rip+8} <ffffffff8010b044>{init+0}
       <ffffffff8010e65a>{child_rip+0}

Code: 0f 0b 68 15 63 40 80 c2 4d 01 48 8b 05 bb 6d f0 ff ff 50 28
RIP <ffffffff8056cd64>{setup_local_APIC+23} RSP <ffff810141c49eb8>
 <0>Kernel panic - not syncing: Attempted to kill init!
