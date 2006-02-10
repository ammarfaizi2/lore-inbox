Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751015AbWBJDFr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751015AbWBJDFr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 22:05:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751025AbWBJDFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 22:05:47 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:29774 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751015AbWBJDFq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 22:05:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=rmnEVvQvWqQPM24WmM+GATrgieJt6SchLS6qw8Arnd+PeI2Dc6T15m9X2mZdUNyjfWH1omUFZRAYpHSjY/P4DlG8quHo1dxHn+q7O1Z7kph3GajIzGd/xnw2DMS0x7Oph0JHbkI3WaiReTJZ/baQLrnajCyYXT6NZQV5ZLPQf7k=
Message-ID: <aa4c40ff0602091905w6280424dtc2c14eb5fbb1cfbc@mail.gmail.com>
Date: Thu, 9 Feb 2006 19:05:45 -0800
From: James Lamanna <jlamanna@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [OOPS] Only occurs when warm-booting 2.6.14
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an amd-64 box, dual opteron.
This oops on boot does not occur when doing a cold boot, but only when doing
a warm boot.
(Copied from netconsole, so I hope its all there...)


Unable to handle kernel NULL pointer dereference at 00000000000001cd RIP:
"<ffffffff80366759>{scsi_run_queue+25}"
PGD 0
Oops: 0000 [1]
SMP CPU 1
Modules linked in:
Pid: 0, comm: swapper Not tainted 2.6.14-gentoo-r5 #3
RIP: 0010:[<ffffffff80366759>]
"<ffffffff80366759>{scsi_run_queue+25}"
RSP: 0000:ffff8100411afe28  EFLAGS: 00010296
RAX: 0000000000000001 RBX: ffff81003fdcd9b8 RCX: 0000000000000034
RDX: 0000000000000001 RSI: ffffffff802b9710 RDI: ffff810001e76c00
RBP: ffff81003fdfad00 R08: 0000000000000003 R09: 0000000012fd28db
R10: ffff81003ffb59d0 R11: ffffffff80368360 R12: 0000000000000000
R13: 0000000000000001 R14: ffff810001e76c00 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffffffff8069d880(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00000000000001cd CR3: 0000000000101000 CR4: 00000000000006e0
Process swapper (pid: 0, threadinfo ffff810001e5c000, task ffff810001e56080)
Stack:
ffff810001e76c00 ffff81003fdcd9b8 ffff81003fdfad00 0000000000000292
0000000000000001 ffff810001e76c00 0000000000000000 ffffffff80366aff
ffff81003fdfad28 ffff81003fdfad00

Call Trace: <IRQ>
"<ffffffff80366aff>{scsi_end_request+207}"
"<ffffffff8036701a>{scsi_io_completion+1098}"
"<ffffffff80362338>{scsi_softirq+376}"
"<ffffffff8013ad8b>{__do_softirq+107}"
"<ffffffff8010ebff>{call_softirq+31}"
"<ffffffff80110301>{do_softirq+49}"
"<ffffffff801102c4>{do_IRQ+52}"
"<ffffffff8010de88>{ret_from_intr+0}"
<EOI>
"<ffffffff8013625d>{printk+141}"
"<ffffffff8011b550>{flat_send_IPI_mask+0}"
"<ffffffff80303970>{acpi_processor_idle+302}"
"<ffffffff8010bc52>{cpu_idle+82}"
"<ffffffff806b7f81>{start_secondary+977}"

Code:
41 f6 84 24 cd 01 00 00 80 49 8b 2c 24 0f 84 b6 00 00 00 49

RIP "<ffffffff80366759>{scsi_run_queue+25}"
RSP <ffff8100411afe28>
CR2: 00000000000001cd
Kernel panic - not syncing: Aiee, killing interrupt handler!

CPUINFO -----

fs0 ~ # cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 5
model name      : AMD Opteron(tm) Processor 246
stepping        : 10
cpu MHz         : 2009.276
cache size      : 1024 KB
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext lm
3dnowext 3dnow
bogomips        : 4022.82
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 5
model name      : AMD Opteron(tm) Processor 246
stepping        : 10
cpu MHz         : 2009.276
cache size      : 1024 KB
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext lm
3dnowext 3dnow
bogomips        : 4018.82
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp

LSPCI------

fs0 ~ # lspci -v
00:00.0 Memory controller: nVidia Corporation CK804 Memory Controller (rev a3)
        Subsystem: Tyan Computer Unknown device 2892
        Flags: bus master, 66MHz, fast devsel, latency 0
        Capabilities: [44] HyperTransport: Slave or Primary Interface
        Capabilities: [e0] HyperTransport: MSI Mapping

00:01.0 ISA bridge: nVidia Corporation CK804 ISA Bridge (rev a3)
        Subsystem: Tyan Computer Unknown device 2892
        Flags: bus master, 66MHz, fast devsel, latency 0
        I/O ports at 8c00 [size=128]

00:01.1 SMBus: nVidia Corporation CK804 SMBus (rev a2)
        Subsystem: Tyan Computer Unknown device 2892
        Flags: 66MHz, fast devsel
        I/O ports at 1000 [size=32]
        I/O ports at 5000 [size=64]
        I/O ports at 5040 [size=64]
        Capabilities: [44] Power Management version 2

00:02.0 USB Controller: nVidia Corporation CK804 USB Controller (rev
a2) (prog-if 10 [OHCI])
        Subsystem: Tyan Computer Unknown device 2892
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 50
        Memory at dd000000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2

00:02.1 USB Controller: nVidia Corporation CK804 USB Controller (rev
a3) (prog-if 20 [EHCI])
        Subsystem: Tyan Computer Unknown device 2892
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 233
        Memory at dd001000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [44] Debug port
        Capabilities: [80] Power Management version 2

00:06.0 IDE interface: nVidia Corporation CK804 IDE (rev a2) (prog-if
8a [Master SecP PriP])
        Subsystem: Tyan Computer Unknown device 2892
        Flags: bus master, 66MHz, fast devsel, latency 0
        I/O ports at 1400 [size=16]
        Capabilities: [44] Power Management version 2

00:07.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller
(rev a3) (prog-if 85 [Master SecO PriO])
        Subsystem: Tyan Computer Unknown device 2892
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 10
        I/O ports at 1440 [size=8]
        I/O ports at 1434 [size=4]
        I/O ports at 1438 [size=8]
        I/O ports at 1430 [size=4]
        I/O ports at 1410 [size=16]
        Memory at dd002000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2

00:08.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller
(rev a3) (prog-if 85 [Master SecO PriO])
        Subsystem: Tyan Computer Unknown device 2892
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 11
        I/O ports at 1458 [size=8]
        I/O ports at 144c [size=4]
        I/O ports at 1450 [size=8]
        I/O ports at 1448 [size=4]
        I/O ports at 1420 [size=16]
        Memory at dd003000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2
00:09.0 PCI bridge: nVidia Corporation CK804 PCI Bridge (rev a2)
(prog-if 01 [Subtractive decode])
        Flags: bus master, 66MHz, fast devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 00002000-00002fff
        Memory behind bridge: dd100000-deffffff
        Prefetchable memory behind bridge: 88000000-880fffff

00:0d.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
(prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
        Capabilities: [40] Power Management version 2
        Capabilities: [48] Message Signalled Interrupts: 64bit+
Queue=0/1 Enable-
        Capabilities: [58] HyperTransport: MSI Mapping
        Capabilities: [80] Express Root Port (Slot+) IRQ 0

00:0e.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
(prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
        Capabilities: [40] Power Management version 2
        Capabilities: [48] Message Signalled Interrupts: 64bit+
Queue=0/1 Enable-
        Capabilities: [58] HyperTransport: MSI Mapping
        Capabilities: [80] Express Root Port (Slot+) IRQ 0

00:18.0 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] HyperTransport Technology Configuration
        Flags: fast devsel
        Capabilities: [80] HyperTransport: Host or Secondary Interface
        Capabilities: [a0] HyperTransport: Host or Secondary Interface
        Capabilities: [c0] HyperTransport: Host or Secondary Interface

00:18.1 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Address Map
        Flags: fast devsel

00:18.2 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] DRAM Controller
        Flags: fast devsel

00:18.3 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Miscellaneous Control
        Flags: fast devsel

00:19.0 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] HyperTransport Technology Configuration
        Flags: fast devsel
        Capabilities: [80] HyperTransport: Host or Secondary Interface
        Capabilities: [a0] HyperTransport: Host or Secondary Interface
        Capabilities: [c0] HyperTransport: Host or Secondary Interface

00:19.1 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Address Map
        Flags: fast devsel

00:19.2 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] DRAM Controller
        Flags: fast devsel

00:19.3 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Miscellaneous Control
        Flags: fast devsel

01:06.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev
27) (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc Rage XL
        Flags: bus master, stepping, medium devsel, latency 66, IRQ 10
        Memory at de000000 (32-bit, non-prefetchable) [size=16M]
        I/O ports at 2000 [size=256]
        Memory at dd100000 (32-bit, non-prefetchable) [size=4K]
        [virtual] Expansion ROM at 88000000 [disabled] [size=128K]
        Capabilities: [5c] Power Management version 2
01:08.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro
100] (rev 10)
        Subsystem: Intel Corporation EtherExpress PRO/100 S Server Adapter
        Flags: bus master, medium devsel, latency 66, IRQ 177
        Memory at dd101000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at 2400 [size=64]
        Memory at dd120000 (32-bit, non-prefetchable) [size=128K]
        Capabilities: [dc] Power Management version 2

08:0a.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge
(rev 12) (prog-if 00 [Normal decode])
        Flags: bus master, 66MHz, medium devsel, latency 64
        Bus: primary=08, secondary=09, subordinate=09, sec-latency=96
        I/O behind bridge: 00003000-00003fff
        Memory behind bridge: df300000-df3fffff
        Prefetchable memory behind bridge: 00000000df800000-00000000dff00000
        Capabilities: [a0] PCI-X bridge device
        Capabilities: [b8] HyperTransport: Interrupt Discovery and Configuration
        Capabilities: [c0] HyperTransport: Slave or Primary Interface

08:0a.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X IOAPIC (rev
01) (prog-if 10 [IO-APIC])
        Subsystem: Advanced Micro Devices [AMD] AMD-8131 PCI-X IOAPIC
        Flags: bus master, medium devsel, latency 0
        Memory at df200000 (64-bit, non-prefetchable) [size=4K]

08:0b.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge
(rev 12) (prog-if 00 [Normal decode])
        Flags: bus master, 66MHz, medium devsel, latency 64
        Bus: primary=08, secondary=0a, subordinate=0a, sec-latency=96
        I/O behind bridge: 00004000-00004fff
        Memory behind bridge: df400000-df4fffff
        Prefetchable memory behind bridge: 0000000088100000-0000000088100000
        Capabilities: [a0] PCI-X bridge device
        Capabilities: [b8] HyperTransport: Interrupt Discovery and Configuration

08:0b.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X IOAPIC (rev
01) (prog-if 10 [IO-APIC])
        Subsystem: Advanced Micro Devices [AMD] AMD-8131 PCI-X IOAPIC
        Flags: bus master, medium devsel, latency 0
        Memory at df201000 (64-bit, non-prefetchable) [size=4K]

09:02.0 Fibre Channel: LSI Logic / Symbios Logic FC929X Fibre Channel
Adapter (rev 81)
        Subsystem: LSI Logic / Symbios Logic Unknown device 10d0
        Flags: bus master, 66MHz, medium devsel, latency 72, IRQ 225
        I/O ports at 3000 [size=256]
        Memory at df310000 (64-bit, non-prefetchable) [size=64K]
        Memory at df300000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [50] Power Management version 2
        Capabilities: [58] Message Signalled Interrupts: 64bit+
Queue=0/0 Enable-
        Capabilities: [68] PCI-X non-bridge device

09:02.1 Fibre Channel: LSI Logic / Symbios Logic FC929X Fibre Channel
Adapter (rev 81)
        Subsystem: LSI Logic / Symbios Logic Unknown device 10d0
        Flags: bus master, 66MHz, medium devsel, latency 72, IRQ 217
        I/O ports at 3400 [size=256]
        Memory at df330000 (64-bit, non-prefetchable) [size=64K]
        Memory at df320000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [50] Power Management version 2
        Capabilities: [58] Message Signalled Interrupts: 64bit+
Queue=0/0 Enable-
        Capabilities: [68] PCI-X non-bridge device
09:03.0 RAID bus controller: 3ware Inc 9xxx-series SATA-RAID
        Subsystem: 3ware Inc 9xxx-series SATA-RAID
        Flags: bus master, 66MHz, medium devsel, latency 72, IRQ 217
        I/O ports at 3800 [size=256]
        Memory at df340000 (64-bit, non-prefetchable) [size=256]
        Memory at df800000 (64-bit, prefetchable) [size=8M]
        [virtual] Expansion ROM at df350000 [disabled] [size=64K]
        Capabilities: [48] Power Management version 2

0a:03.0 SCSI storage controller: Adaptec AHA-3960D / AIC-7899A U160/m (rev 01)
        Subsystem: Adaptec AHA-3960D U160/m
        Flags: bus master, 66MHz, medium devsel, latency 72, IRQ 201
        BIST result: 00
        I/O ports at 4000 [disabled] [size=256]
        Memory at df400000 (64-bit, non-prefetchable) [size=4K]
        [virtual] Expansion ROM at 88100000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2

0a:03.1 SCSI storage controller: Adaptec AHA-3960D / AIC-7899A U160/m (rev 01)
        Subsystem: Adaptec AHA-3960D U160/m
        Flags: bus master, 66MHz, medium devsel, latency 72, IRQ 209
        BIST result: 00
        I/O ports at 4400 [disabled] [size=256]
        Memory at df401000 (64-bit, non-prefetchable) [size=4K]
        [virtual] Expansion ROM at 88120000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2

0a:09.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5704
Gigabit Ethernet (rev 03)
        Subsystem: Broadcom Corporation Unknown device 1644
        Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 185
        Memory at df420000 (64-bit, non-prefetchable) [size=64K]
        Memory at df410000 (64-bit, non-prefetchable) [size=64K]
        [virtual] Expansion ROM at 88140000 [disabled] [size=64K]
        Capabilities: [40] PCI-X non-bridge device
        Capabilities: [48] Power Management version 2
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled Interrupts: 64bit+
Queue=0/3 Enable-

0a:09.1 Ethernet controller: Broadcom Corporation NetXtreme BCM5704
Gigabit Ethernet (rev 03)
        Subsystem: Broadcom Corporation Unknown device 1644
        Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 193
        Memory at df440000 (64-bit, non-prefetchable) [size=64K]
        Memory at df430000 (64-bit, non-prefetchable) [size=64K]
        [virtual] Expansion ROM at 88150000 [disabled] [size=64K]
        Capabilities: [40] PCI-X non-bridge device
        Capabilities: [48] Power Management version 2
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled Interrupts: 64bit+
Queue=0/3 Enable-


Thanks.

-- James
