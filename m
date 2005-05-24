Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262016AbVEXMXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262016AbVEXMXe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 08:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbVEXMXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 08:23:33 -0400
Received: from zukmail03.zreo.compaq.com ([161.114.128.27]:59151 "EHLO
	zukmail03.zreo.compaq.com") by vger.kernel.org with ESMTP
	id S262016AbVEXMW2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 08:22:28 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: What is needed to boot 2.6 on opteron dual core
Date: Tue, 24 May 2005 14:22:14 +0200
Message-ID: <213219CA6232F94E989A9A5354135D2F093754@frqexc04.emea.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: What is needed to boot 2.6 on opteron dual core
Thread-Index: AcVf1Yn904fPWllfT1uDuh58CIJ10QAhMhrQ
From: "Cabaniols, Sebastien" <sebastien.cabaniols@hp.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 24 May 2005 12:22:15.0608 (UTC) FILETIME=[387F3B80:01C5605B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My hardware , a dual core HP workstation, is booting with Redhat4UP1 but
not with suse9.3, hence the original question: what is needed to boot a
dual core opteron, and obviously all kernels do not run easily on
dual-core platforms. I understand that all kernels generically
understand dual-core, so my guess is that the ACPI layer is doing wrong
things at setup time but I don't have enough knowledge about this.

Below is what happens at boot time with a vanilla 2.6 kernel from
kernel.org 2.6.12-rc4, 2.6.11.10, -ac show the same problem.



Bootdata ok (command line is ro root=/dev/sda2 hda=ide-scsi
earlyprintk=serial,ttyS0,9600 console=ttyS0,9600)
Linux version 2.6.11.9 (root@hptc267) (gcc version 3.2.3 20030502 (Red
Hat Linux 3.2.3-52)) #3 SMP Tue May 17 17:09:49 CEST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000cfff9500 (usable)
 BIOS-e820: 00000000cfff9500 - 00000000d0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000200000000 (usable)
kernel direct mapping tables upto ffff810200000000 @ 8000-11000
Nvidia board detected. Ignoring ACPI timer override.
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:1 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:1 APIC version 16
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x02] enabled)
Processor #2 15:1 APIC version 16
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] enabled)
Processor #3 15:1 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 8, version 17, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x09] address[0xf2600000] gsi_base[24])
IOAPIC[1]: apic_id 9, version 17, address 0xf2600000, GSI 24-27
ACPI: IOAPIC (id[0x0a] address[0xf2601000] gsi_base[28])
IOAPIC[2]: apic_id 10, version 17, address 0xf2601000, GSI 28-31
ACPI: IOAPIC (id[0x0b] address[0xf2700000] gsi_base[32])
IOAPIC[3]: apic_id 11, version 17, address 0xf2700000, GSI 32-55
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Checking aperture...
CPU 0: aperture @ 8000000 size 32 MB
Aperture from northbridge cpu 0 too small (32 MB)
No AGP bridge found
Your BIOS doesn't leave a aperture memory hole
Please enable the IOMMU option in the BIOS setup
This costs you 64 MB of RAM
Mapping aperture over 65536 KB of RAM @ c000000
Built 1 zonelists
Kernel command line: ro root=/dev/sda2 hda=ide-scsi
earlyprintk=serial,ttyS0,9600 console=ttyS0,9600
ide_setup: hda=ide-scsi
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 1.193182 MHz PIT timer.
time.c: Detected 2194.189 MHz processor.
disabling early console
Bootdata ok (command line is ro root=/dev/sda2 hda=ide-scsi
earlyprintk=serial,ttyS0,9600 console=ttyS0,9600)
Linux version 2.6.11.9 (root@hptc267) (gcc version 3.2.3 20030502 (Red
Hat Linux 3.2.3-52)) #3 SMP Tue May 17 17:09:49 CEST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000cfff9500 (usable)
 BIOS-e820: 00000000cfff9500 - 00000000d0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000200000000 (usable)
Nvidia board detected. Ignoring ACPI timer override.
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:1 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:1 APIC version 16
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x02] enabled)
Processor #2 15:1 APIC version 16
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] enabled)
Processor #3 15:1 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 8, version 17, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x09] address[0xf2600000] gsi_base[24])
IOAPIC[1]: apic_id 9, version 17, address 0xf2600000, GSI 24-27
ACPI: IOAPIC (id[0x0a] address[0xf2601000] gsi_base[28])
IOAPIC[2]: apic_id 10, version 17, address 0xf2601000, GSI 28-31
ACPI: IOAPIC (id[0x0b] address[0xf2700000] gsi_base[32])
IOAPIC[3]: apic_id 11, version 17, address 0xf2700000, GSI 32-55
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Checking aperture...
CPU 0: aperture @ 8000000 size 32 MB
Aperture from northbridge cpu 0 too small (32 MB)
No AGP bridge found
Your BIOS doesn't leave a aperture memory hole
Please enable the IOMMU option in the BIOS setup
This costs you 64 MB of RAM
Mapping aperture over 65536 KB of RAM @ c000000
Built 1 zonelists
Kernel command line: ro root=/dev/sda2 hda=ide-scsi
earlyprintk=serial,ttyS0,9600 console=ttyS0,9600
ide_setup: hda=ide-scsi
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 1.193182 MHz PIT timer.
time.c: Detected 2194.189 MHz processor.
disabling early console
Console: colour VGA+ 80x25
Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes)
Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes)
Memory: 7391296k/8388608k available (2236k kernel code, 210072k
reserved, 1201k data, 200k init)
Mount-cache hash table entries: 256 (order: 0, 4096 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU: Physical Processor ID: 0
Using local APIC NMI watchdog using perfctr0
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU: Physical Processor ID: 0
CPU0: Dual Core AMD Opteron(tm) Processor 275 stepping 02
per-CPU timeslice cutoff: 1023.72 usecs.
task migration cache decay timeout: 2 msecs.
Booting processor 1/1 rip 6000 rsp ffff8100cff97f58
Initializing CPU#1
Calibrating delay loop... <7>spurious 8259A interrupt: IRQ7.
----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at timer:416
invalid operand: 0000 [1] SMP 
CPU 1 
Modules linked in:
Pid: 0, comm: swapper Not tainted 2.6.11.9
RIP: 0010:[<ffffffff8013c82d>] <ffffffff8013c82d>{cascade+45}
RSP: 0018:ffff8100cff9fed8  EFLAGS: 00010083
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000022
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff81001000c860
RBP: ffff81001000d878 R08: ffff81000801cc80 R09: 0000000000000000
R10: 0000000000000000 R11: 00000000c0010008 R12: ffff81001000c860
R13: 0000000000000000 R14: ffff8100cff9ff08 R15: 000000000000000a
FS:  0000000000000000(0000) GS:ffffffff8049c280(0000)
knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000000 CR3: 0000000000101000 CR4: 00000000000006a0
Process swapper (pid: 0, threadinfo ffff8100cff96000, task
ffff8100cff90df0)
Stack: 0000000000000008 0000000000000000 ffffffff8049f410
ffff81001000c860 
       ffffffff804da9e0 ffffffff8013ce1e ffff8100cff9ff08
ffff8100cff9ff08 
       0000000000000096 ffffffff80113376 
Call Trace:<IRQ> <ffffffff8013ce1e>{run_timer_softirq+126}
<ffffffff80113376>{enable_8259A_irq+38} 
       <ffffffff801386fe>{__do_softirq+126}
<ffffffff801387b3>{do_softirq+51} 
       <ffffffff80110417>{do_IRQ+71} <ffffffff8010d98d>{ret_from_intr+0}

        <EOI> <ffffffff80157832>{__alloc_pages+930}
<ffffffff8010b287>{calibrate_delay+167} 
       <ffffffff804b4faa>{smp_callin+154}
<ffffffff804b4fde>{start_secondary+14} 
       

Code: 0f 0b 94 85 34 80 ff ff ff ff a0 01 66 66 66 90 66 66 90 48 
RIP <ffffffff8013c82d>{cascade+45} RSP <ffff8100cff9fed8>
 <0>Kernel panic - not syncing: Aiee, killing interrupt handler!
 NMI Watchdog detected LOCKUP on CPU0CPU 0 
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.11.9
RIP: 0010:[<ffffffff801ca329>] <ffffffff801ca329>{__delay+9}
RSP: 0000:ffff8100cff93e80  EFLAGS: 00000297
RAX: 00000000388c65dc RBX: 000000000000c2b0 RCX: 0000000038898b11
RDX: 00000000000000a1 RSI: 0000000000006000 RDI: 0000000000034fa8
RBP: 0000000000000001 R08: 0000000000000000 R09: 000000000000000f
R10: 00000000ffffffff R11: 0000000000000010 R12: ffffffff8049c200
R13: 0000000000000000 R14: 0000000000006000 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffffffff8049c200(0000)
knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000e0804a CR3: 0000000000101000 CR4: 00000000000006e0
Process swapper (pid: 1, threadinfo ffff8100cff92000, task
ffff8100cff914d0)
Stack: ffffffff804b53b1 0000000000000000 0000000000000001
0000000000000000 
       ffffffff801c84ce 0000000000000000 0000000000000010
0000000000000020 
       0000ffffffff8010 0000000000000000 
Call Trace:<ffffffff804b53b1>{do_boot_cpu+353}
<ffffffff801c84ce>{strstr+94} 
       <ffffffff804b57d8>{smp_boot_cpus+664} <ffffffff8010b094>{init+36}

       <ffffffff8010df9f>{child_rip+8} <ffffffff8010b070>{init+0} 
       <ffffffff8010df97>{child_rip+0} 

Code: 48 29 c8 48 39 f8 72 f4 90 c3 66 66 66 90 66 66 90 66 66 90 
console shuts up ...
 <0>Kernel panic - not syncing: Aiee, killing interrupt handler!

 

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Bill Davidsen
Sent: lundi 23 mai 2005 22:24
To: Andi Kleen
Cc: linux-kernel@vger.kernel.org
Subject: Re: What is needed to boot 2.6 on opteron dual core

Andi Kleen wrote:
>>Could you clarify that? I have to install one when it comes in to the 
>>owner, and I'm not sure how you would do "runtime tuning" if it 
>>doesn't boot. Did you mean boot parameters, BIOS diddling, or ???
> 
> 
> What I meant to say is that all kernels should run on dual cores, but 
> newer ones likely have better performance. Nothing to do for the user.

Okay, thanks. I look forward to trying this.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in the body of a message to majordomo@vger.kernel.org More majordomo
info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
