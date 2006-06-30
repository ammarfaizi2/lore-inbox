Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932628AbWF3Nkz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932628AbWF3Nkz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 09:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932619AbWF3Nkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 09:40:55 -0400
Received: from c-71-192-19-1.hsd1.ma.comcast.net ([71.192.19.1]:55574 "EHLO
	theintegrator.net") by vger.kernel.org with ESMTP id S932628AbWF3Nkx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 09:40:53 -0400
Message-ID: <8018457.1151674840445.OPEN-XCHANGE.WebMail.wwwrun@sles9>
Date: Fri, 30 Jun 2006 09:40:40 -0400 (EDT)
From: Bialock Andrew <abialock@asiopen.com>
To: linux-kernel@vger.kernel.org
Subject: [oops] Kernel BUG at dcache:286
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (normal)
X-Mailer: OPEN-XCHANGE 0.8.0-5 - WebMail
X-Operating-System: Linux 2.6.5-7.252-default i386 (JVM 1.4.2_11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am getting this set of errors when performing a backup over fiber
channel to a tape library. It only happens under load.

----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at dcache:286
invalid operand: 0000 [1] SMP
CPU 1
Pid: 15494, comm: checkproc Not tainted (2.6.5-7.257-smp
SLES9_SP3_BRANCH-20060515141414)
RIP: 0010:[<ffffffff801a85eb>] <ffffffff801a85eb>{d_alloc+395}
RSP: 0018:000001004d3e7d28  EFLAGS: 00010246
RAX: 0000000000000000 RBX: 00000100279c2980 RCX: 0000000000000000
RDX: 0000000000000005 RSI: 000001004cd7a011 RDI: 00000100279c2a6d
RBP: 000001004d3e7dd8 R08: 000000000000006d R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 00000100279c2a68
R13: 0000010077cffa80 R14: 0000010077cffa80 R15: 000001004d3e7dd8
FS: 0000002a95894b00(0000) GS:ffffffff8057da00(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000002a9571bf80 CR3: 000000007ff04000 CR4: 00000000000006e0
Process checkproc (pid: 15494, threadinfo 000001004d3e6000, task
000001006e64c1a0)
Stack: 000001004d3e7dd8 fffffffffffffff4 000001007a368760
0000000000000001
000001007a3686a0 ffffffff8019ceff 000001004d3e7e98 000001007ff9a180
       0000000000000000 000001004d3e7e98
Call Trace:<ffffffff8019ceff>{real_lookup+95}
<ffffffff8019d032>{do_lookup+114}
<ffffffff8019f0fe>{link_path_walk+2206}
       <ffffffff8019fd9b>{open_namei+155}
<ffffffff80197b6a>{cp_new_stat+234} <ffffffff8018a6e7>{filp_open+87}
<ffffffff8018a7af>{sys_open+159} <ffffffff801106b4>{system_call+124}


Code: 0f 0b 70 fd 38 80 ff ff ff ff 1e 01 f0 41 ff 45 00 49 8b 45
RIP <ffffffff801a85eb>{d_alloc+395} RSP <000001004d3e7d28>
 ----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at dcache:286
invalid operand: 0000 [2] SMP
CPU 1
Pid: 15743, comm: checkproc Not tainted (2.6.5-7.257-smp
SLES9_SP3_BRANCH-20060515141414)
RIP: 0010:[<ffffffff801a85eb>] <ffffffff801a85eb>{d_alloc+395}
RSP: 0018:000001007d7d7d28  EFLAGS: 00010246
RAX: 0000000000000000 RBX: 000001007c35a480 RCX: 0000000000000000
RDX: 0000000000000005 RSI: 000001001b2aa011 RDI: 000001007c35a56d
RBP: 000001007d7d7dd8 R08: 000000000000006d R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 000001007c35a568
R13: 000001007a86f480 R14: 000001007a86f480 R15: 000001007d7d7dd8
FS: 0000002a95894b00(0000) GS:ffffffff8057da00(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000002a9571bf80 CR3: 000000007ff04000 CR4: 00000000000006e0
Process checkproc (pid: 15743, threadinfo 000001007d7d6000, task
0000010068e5cc30)
Stack: 000001007d7d7dd8 fffffffffffffff4 000001007a99ea60
0000000000000001
000001007a99e9a0 ffffffff8019ceff 000001007d7d7e98 000001007ff9a180
       0000000000000000 000001007d7d7e98
Call Trace:<ffffffff8019ceff>{real_lookup+95}
<ffffffff8019d032>{do_lookup+114}
<ffffffff8019f0fe>{link_path_walk+2206}
       <ffffffff8019fd9b>{open_namei+155}
<ffffffff80197b6a>{cp_new_stat+234} <ffffffff8018a6e7>{filp_open+87}
<ffffffff8018a7af>{sys_open+159} <ffffffff801106b4>{system_call+124}


Code: 0f 0b 70 fd 38 80 ff ff ff ff 1e 01 f0 41 ff 45 00 49 8b 45
RIP <ffffffff801a85eb>{d_alloc+395} RSP <000001007d7d7d28>
 ----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at base:286
invalid operand: 0000 [3] SMP
CPU 1
Pid: 17132, comm: lsof Not tainted (2.6.5-7.257-smp
SLES9_SP3_BRANCH-20060515141414)
RIP: 0010:[<ffffffff801c500b>] <ffffffff801c500b>{proc_fd_link+123}
RSP: 0018:000001000e05fe68  EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000010039b3eca0 RCX: 000001007ff9a680
RDX: 000001007b2c4180 RSI: 000001000e05fe78 RDI: 0000010079925b80
RBP: 0000000000000000 R08: 000001000e05fe80 R09: 0000000000000001
R10: 0000000000000000 R11: 000001007ffa04a8 R12: 000001000e05fec8
R13: 0000000000001000 R14: 0000007fbfffd3f0 R15: 0000007fbfffd3f0
FS: 0000002a95894b00(0000) GS:ffffffff8057da00(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000526048 CR3: 000000007ff04000 CR4: 00000000000006e0
Process lsof (pid: 17132, threadinfo 000001000e05e000, task
000001007821eb40)
Stack: 000001007ff9a200 ffffffff801c54e4 0000000044a4a1c2
000001007ff9a680
0000000000000000 000001000e05fed8 000001000e05fec8 0000010039b3eca0
       0000000000001000 ffffffff801979bc
Call Trace:<ffffffff801c54e4>{proc_pid_readlink+164}
<ffffffff801979bc>{sys_readlink+268}
<ffffffff8019800e>{sys_newlstat+46} <ffffffff801106b4>{system_call+124}


Code: 0f 0b 30 01 39 80 ff ff ff ff 1e 01 f0 ff 02 48 89 16 c6 47
RIP <ffffffff801c500b>{proc_fd_link+123} RSP <000001000e05fe68>


This is a dual processor 3.4 GHz HP Proliant DL360 running SLES9 and a
qla6312 FC HBA that has been running quite well for over a year. The
only recent change was to move the tape library to fiber channel
(previously only the disk array was on fiber channel and the tape
library was locally connected via lvd SCSI).

Please personally CC the answers/comments posted to the list in response
to my posting to me.


TIA
Andy


Here is the dmesg output for reference:

Bootdata ok (command line is auto BOOT_IMAGE=Linux root=6803 selinux=0
splash=silent console=tty0 resume=/dev/cciss/c0d0
p2 showopts elevator=cfq)
Linux version 2.6.5-7.257-smp (geeko@buildhost) (gcc version 3.3.3 (SuSE
Linux)) #1 SMP Mon May 15 14:14:14 UTC 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
 BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fff3000 (usable)
 BIOS-e820: 000000007fff3000 - 000000007fffb000 (ACPI data)
 BIOS-e820: 000000007fffb000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fed00000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000ffc00000 - 0000000100000000 (reserved)
No NUMA configuration found
Faking a node at 0000000000000000-000000007fff3000
Bootmem setup node 0 0000000000000000-000000007fff3000
No mptable found.
On node 0 totalpages: 524275
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 520179 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v002 HP ) @ 0x00000000000f4f20
ACPI: XSDT (v001 HP P52 0x00000002 Ò 0x0000162e) @ 0x000000007fff3280
ACPI: FADT (v003 HP P52 0x00000002 Ò 0x0000162e) @ 0x000000007fff3300
ACPI: SPCR (v001 HP SPCRRBSU 0x00000001 Ò 0x0000162e) @
0x000000007fff3100
ACPI: MCFG (v001 HP ProLiant 0x00000001 0x00000000) @ 0x000000007fff3180
ACPI: MADT (v001 HP 00000083 0x00000002 0x00000000) @ 0x000000007fff31c0
ACPI: DSDT (v001 HP DSDT 0x00000001 INTL 0x20030228) @
0x0000000000000000
ACPI: PM-Timer IO Port: 0x908
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:3 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] disabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x04] disabled)
ACPI: LAPIC (acpi_id[0x06] lapic_id[0x06] enabled)
Processor #6 15:3 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:3 APIC version 16
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] disabled)
ACPI: LAPIC (acpi_id[0x05] lapic_id[0x05] disabled)
ACPI: LAPIC (acpi_id[0x07] lapic_id[0x07] enabled)
Processor #7 15:3 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x09] address[0xfec10000] gsi_base[24])
IOAPIC[1]: apic_id 9, version 32, address 0xfec10000, GSI 24-47
ACPI: IOAPIC (id[0x0a] address[0xfec82000] gsi_base[48])
IOAPIC[2]: apic_id 10, version 32, address 0xfec82000, GSI 48-71
ACPI: IOAPIC (id[0x0b] address[0xfec82100] gsi_base[72])
IOAPIC[3]: apic_id 11, version 32, address 0xfec82100, GSI 72-95
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Checking aperture...
Built 1 zonelists
Kernel command line: auto BOOT_IMAGE=Linux root=6803 selinux=0
splash=silent console=tty0 resume=/dev/cciss/c0d0p2 showo
pts elevator=cfq
bootsplash: silent mode.
Initializing CPU#0
PID hash table entries: 16 (order 4: 256 bytes)
CKRM Initialization
...... Initializing ClassType<taskclass> ........
...... Initializing ClassType<socketclass> ........
CKRM Initialization done
time.c: Using 3.579545 MHz PM timer.
time.c: Detected 3400.245 MHz processor.
Console: colour dummy device 80x25
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Memory: 2050516k/2097100k available (2461k kernel code, 0k reserved,
1226k data, 204k init)
Calibrating delay loop... 6717.44 BogoMIPS
Calibrating delay loop... 6717.44 BogoMIPS
Calibrating delay loop... 6717.44 BogoMIPS
Security Scaffold v1.0.0 initialized
SELinux:  Disabled at boot.
Mount-cache hash table entries: 256 (order: 0, 4096 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
using mwait in idle threads.
CPU: Physical Processor ID: 0
Using IO APIC NMI watchdog
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
CPU0:                   Intel(R) Xeon(TM) CPU 3.40GHz stepping 04
per-CPU timeslice cutoff: 1023.90 usecs.
task migration cache decay timeout: 2 msecs.
Booting processor 1/6 rip 6000 rsp 1007ff01f58
Initializing CPU#1
Calibrating delay loop... 6799.36 BogoMIPS
Calibrating delay loop... 6782.97 BogoMIPS
Calibrating delay loop... 6782.97 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 3
                  Intel(R) Xeon(TM) CPU 3.40GHz stepping 04
Booting processor 2/1 rip 6000 rsp 1007ff67f58
Initializing CPU#2
Calibrating delay loop... 6782.97 BogoMIPS
Calibrating delay loop... 6799.36 BogoMIPS
Calibrating delay loop... 6782.97 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
                  Intel(R) Xeon(TM) CPU 3.40GHz stepping 04
Booting processor 3/7 rip 6000 rsp 100036cbf58
Initializing CPU#3
Calibrating delay loop... 6782.97 BogoMIPS
Calibrating delay loop... 6799.36 BogoMIPS
Calibrating delay loop... 6782.97 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 3
                  Intel(R) Xeon(TM) CPU 3.40GHz stepping 04
Total of 4 processors activated (27115.52 BogoMIPS).
ENABLING IO-APIC IRQs
init IO_APIC IRQs
IO-APIC (apicid-pin) 8-0, 8-16, 8-17, 8-18, 8-19, 8-20, 8-21, 8-22,
 8-23, 9-0, 9-1, 9-2, 9-3, 9-4, 9-5, 9-6, 9-7, 9-8,
9-9, 9-10, 9-11, 9-12, 9-13, 9-14, 9-15, 9-16, 9-17, 9-18, 9-19, 9-20,
9-21, 9-22, 9-23, 10-0, 10-1, 10-2, 10-3, 10-4, 1
0-5, 10-6, 10-7, 10-8, 10-9, 10-10, 10-11, 10-12, 10-13, 10-14, 10-15,
10-16, 10-17, 10-18, 10-19, 10-20, 10-21, 10-22,
10-23, 11-0, 11-1, 11-2, 11-3, 11-4, 11-5, 11-6, 11-7, 11-8, 11-9,
11-10, 11-11, 11-12, 11-13, 11-14, 11-15, 11-16, 11-1
7, 11-18, 11-19, 11-20, 11-21, 11-22, 11-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=-1
activating NMI Watchdog ... done.
testing NMI watchdog ... OK.
Using local APIC timer interrupts.
Detected 12.500 MHz APIC timer.
checking TSC synchronization across 4 CPUs: passed.
time.c: Using PIT/TSC based timekeeping.
Brought up 4 CPUs
checking if image is initramfs...it isn't (no cpio magic); looks like an
initrd
Looking for DSDT in initrd ...No customized DSDT found in initrd!
khelper: max 64 concurrent processes
resid is -1 name is io <NULL>
CKRM .. create res clsobj for resouce <io>class <taskclass>
par=0000000000000000
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: probably your BIOS does not setup all CPUs.
mtrr: corrected configuration.
ACPI: Subsystem revision 20040326
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.IP2P._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.ICHR._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PTB0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PTB0.PCXA._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PTB0.PCXB._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PTA0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PTC0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs *5 7 10 11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 5 *7 10 11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 5 *7 10 11)
ACPI: PCI Interrupt Link [LNKD] (IRQs *5 7 10 11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 5 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs *5 7 10 11)
ACPI: PCI Interrupt Link [LNKG] (IRQs *5 7 10 11)
ACPI: PCI Interrupt Link [LNKH] (IRQs *5 7 10 11)
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even
'acpi=off'
GSI 16 assigned vector 0xA9 and IRQ 16
IOAPIC[0]: Set PCI routing entry (8-16 -> 0xa9 -> IRQ 16 Mode:1
Active:1)
ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI interrupt 0000:00:04.0[A] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 16
GSI 19 assigned vector 0xB1 and IRQ 17
IOAPIC[0]: Set PCI routing entry (8-19 -> 0xb1 -> IRQ 17 Mode:1
Active:1)
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 17
GSI 23 assigned vector 0xB9 and IRQ 18
IOAPIC[0]: Set PCI routing entry (8-23 -> 0xb9 -> IRQ 18 Mode:1
Active:1)
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 18
GSI 18 sharing vector 0xB9 and IRQ 18
IOAPIC[0]: Set PCI routing entry (8-18 -> 0xb9 -> IRQ 18 Mode:1
Active:1)
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
GSI 48 assigned vector 0xC1 and IRQ 19
IOAPIC[2]: Set PCI routing entry (10-0 -> 0xc1 -> IRQ 19 Mode:1
Active:1)
ACPI: PCI interrupt 0000:07:01.0[A] -> GSI 48 (level, low) -> IRQ 19
GSI 72 assigned vector 0xC9 and IRQ 20
IOAPIC[3]: Set PCI routing entry (11-0 -> 0xc9 -> IRQ 20 Mode:1
Active:1)
ACPI: PCI interrupt 0000:0a:01.0[A] -> GSI 72 (level, low) -> IRQ 20
GSI 73 assigned vector 0xD1 and IRQ 21
IOAPIC[3]: Set PCI routing entry (11-1 -> 0xd1 -> IRQ 21 Mode:1
Active:1)
ACPI: PCI interrupt 0000:0a:01.1[B] -> GSI 73 (level, low) -> IRQ 21
GSI 24 assigned vector 0xD9 and IRQ 22
IOAPIC[1]: Set PCI routing entry (9-0 -> 0xd9 -> IRQ 22 Mode:1 Active:1)
ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 24 (level, low) -> IRQ 22
GSI 25 assigned vector 0xE1 and IRQ 23
IOAPIC[1]: Set PCI routing entry (9-1 -> 0xe1 -> IRQ 23 Mode:1 Active:1)
ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 25 (level, low) -> IRQ 23
GSI 26 assigned vector 0xE9 and IRQ 24
IOAPIC[1]: Set PCI routing entry (9-2 -> 0xe9 -> IRQ 24 Mode:1 Active:1)
ACPI: PCI interrupt 0000:02:02.1[B] -> GSI 26 (level, low) -> IRQ 24
GSI 21 sharing vector 0xD1 and IRQ 21
IOAPIC[0]: Set PCI routing entry (8-21 -> 0xd1 -> IRQ 21 Mode:1
Active:1)
ACPI: PCI interrupt 0000:01:04.0[A] -> GSI 21 (level, low) -> IRQ 21
GSI 22 sharing vector 0xD9 and IRQ 22
IOAPIC[0]: Set PCI routing entry (8-22 -> 0xd9 -> IRQ 22 Mode:1
Active:1)
ACPI: PCI interrupt 0000:01:04.2[B] -> GSI 22 (level, low) -> IRQ 22
number of MP IRQ sources: 15.
number of IO-APIC #8 registers: 24.
number of IO-APIC #9 registers: 24.
number of IO-APIC #10 registers: 24.
number of IO-APIC #11 registers: 24.
testing the IO APIC.......................

IO APIC #8......
.... register #00: 08000000
.......    : physical APIC id: 08
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... register #02: 00178020
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  0    1    0   0   0    1    1    71
 0a 001 01  0    0    0   0   0    1    1    79
 0b 001 01  0    0    0   0   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  0    0    0   0   0    1    1    99
 0f 001 01  0    0    0   0   0    1    1    A1
 10 00F 0F  1    1    0   1   0    1    1    A9
 11 000 00  1    0    0   0   0    0    0    00
 12 00F 0F  1    1    0   1   0    1    1    B9
 13 00F 0F  1    1    0   1   0    1    1    B1
 14 000 00  1    0    0   0   0    0    0    00
 15 00F 0F  1    1    0   1   0    1    1    D1
 16 00F 0F  1    1    0   1   0    1    1    D9
 17 00F 0F  1    1    0   1   0    1    1    B9

IO APIC #9......
.... register #00: 00000000
.......    : physical APIC id: 00
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... register #02: 00178020
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 00F 0F  1    1    0   1   0    1    1    D9
 01 00F 0F  1    1    0   1   0    1    1    E1
 02 00F 0F  1    1    0   1   0    1    1    E9
 03 000 00  1    0    0   0   0    0    0    00
 04 000 00  1    0    0   0   0    0    0    00
 05 000 00  1    0    0   0   0    0    0    00
 06 000 00  1    0    0   0   0    0    0    00
 07 000 00  1    0    0   0   0    0    0    00
 08 000 00  1    0    0   0   0    0    0    00
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  1    0    0   0   0    0    0    00
 0f 000 00  1    0    0   0   0    0    0    00
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00

IO APIC #10......
.... register #00: 0A000000
.......    : physical APIC id: 0A
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... register #02: 0A000000
.......     : arbitration: 0A
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 00F 0F  1    1    0   1   0    1    1    C1
 01 000 00  1    0    0   0   0    0    0    00
 02 000 00  1    0    0   0   0    0    0    00
 03 000 00  1    0    0   0   0    0    0    00
 04 000 00  1    0    0   0   0    0    0    00
 05 000 00  1    0    0   0   0    0    0    00
 06 000 00  1    0    0   0   0    0    0    00
 07 000 00  1    0    0   0   0    0    0    00
 08 000 00  1    0    0   0   0    0    0    00
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  1    0    0   0   0    0    0    00
 0f 000 00  1    0    0   0   0    0    0    00
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00

IO APIC #11......
.... register #00: 0B000000
.......    : physical APIC id: 0B
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... register #02: 0B000000
.......     : arbitration: 0B
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 00F 0F  1    1    0   1   0    1    1    C9
 01 00F 0F  1    1    0   1   0    1    1    D1
 02 000 00  1    0    0   0   0    0    0    00
 03 000 00  1    0    0   0   0    0    0    00
 04 000 00  1    0    0   0   0    0    0    00
 05 000 00  1    0    0   0   0    0    0    00
 06 000 00  1    0    0   0   0    0    0    00
 07 000 00  1    0    0   0   0    0    0    00
 08 000 00  1    0    0   0   0    0    0    00
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  1    0    0   0   0    0    0    00
 0f 000 00  1    0    0   0   0    0    0    00
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:19
IRQ18 -> 0:23-> 0:18
IRQ19 -> 2:0
IRQ20 -> 3:0
IRQ21 -> 3:1-> 0:21
IRQ22 -> 1:0-> 0:22
IRQ23 -> 1:1
IRQ24 -> 1:2
.................................... done.
PCI-DMA: Disabling IOMMU.
vesafb: framebuffer at 0xfc000000, mapped to 0xffffff0000005000, size
8128k
vesafb: mode is 800x600x16, linelength=1600, pages=7
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
mtrr: type mismatch for fc000000,400000 old: uncachable new:
write-combining
mtrr: type mismatch for fc000000,200000 old: uncachable new:
write-combining
mtrr: type mismatch for fc000000,100000 old: uncachable new:
write-combining
mtrr: type mismatch for fc000000,80000 old: uncachable new:
write-combining
mtrr: type mismatch for fc000000,40000 old: uncachable new:
write-combining
mtrr: type mismatch for fc000000,20000 old: uncachable new:
write-combining
mtrr: type mismatch for fc000000,10000 old: uncachable new:
write-combining
mtrr: type mismatch for fc000000,8000 old: uncachable new:
write-combining
mtrr: type mismatch for fc000000,4000 old: uncachable new:
write-combining
mtrr: type mismatch for fc000000,2000 old: uncachable new:
write-combining
mtrr: type mismatch for fc000000,1000 old: uncachable new:
write-combining
mtrr: size and base must be multiples of 4 kiB
mtrr: size: 0x800  base: 0xfc000000
mtrr: size and base must be multiples of 4 kiB
mtrr: size: 0x400  base: 0xfc000000
mtrr: size and base must be multiples of 4 kiB
mtrr: size: 0x200  base: 0xfc000000
mtrr: size and base must be multiples of 4 kiB
mtrr: size: 0x100  base: 0xfc000000
mtrr: size and base must be multiples of 4 kiB
mtrr: size: 0x80  base: 0xfc000000
mtrr: size and base must be multiples of 4 kiB
mtrr: size: 0x40  base: 0xfc000000
mtrr: size and base must be multiples of 4 kiB
mtrr: size: 0x20  base: 0xfc000000
mtrr: size and base must be multiples of 4 kiB
mtrr: size: 0x10  base: 0xfc000000
mtrr: size and base must be multiples of 4 kiB
mtrr: size: 0x8  base: 0xfc000000
mtrr: size and base must be multiples of 4 kiB
mtrr: size: 0x4  base: 0xfc000000
mtrr: size and base must be multiples of 4 kiB
mtrr: size: 0x2  base: 0xfc000000
mtrr: size and base must be multiples of 4 kiB
mtrr: size: 0x1  base: 0xfc000000
fb0: VESA VGA frame buffer device
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 128Kbytes
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
Initial HugeTLB pages allocated: 0
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
VFS: Disk quotas dquot_6.5.1
Initializing Cryptographic API
bootsplash 3.1.6-2004/03/31: looking for picture...<6> silentjpeg size
28539 bytes,<6>...found (800x600, 18412 bytes, v3
).
Console: switching to colour frame buffer device 92x32
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
Linux agpgart interface v0.100 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing
disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 128000K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
ICH5: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x0500-0x0507, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x0508-0x050f, BIOS settings: hdc:pio, hdd:pio
hda: CRN-8245B, ATAPI CD/DVD-ROM drive
Using cfq io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ATAPI 24X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
mice: PS/2 mouse device common for all mice
input: PC Speaker
serio: i8042 AUX port at 0x60,0x64 irq 12
input: ImExPS/2 Logitech Explorer Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 1
ACPI: (supports S0 S4 S5)
resid is -1 name is cpu <NULL>
CKRM .. create res clsobj for resouce <cpu>class <taskclass>
par=0000000000000000
........init_ckrm_sched_res , resid= 5
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
SCSI subsystem initialized
HP CISS Driver (v 2.6.8)
cciss: Device 0x46 has been found at bus 2 dev 1 func 0
ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 24 (level, low) -> IRQ 22
cciss: using DAC cycles
      blocks= 286734240 block_size= 512
      heads= 255, sectors= 32, cylinders= 35139

 cciss/c0d0: p1 p2 p3 p4
QLogic Fibre Channel HBA Driver
ACPI: PCI interrupt 0000:07:01.0[A] -> GSI 48 (level, low) -> IRQ 19
qla6312 0000:07:01.0: Found an ISP6312, irq 19, iobase
0xffffff00008f6000
qla6312 0000:07:01.0: Configuring PCI space...
qla6312 0000:07:01.0: Configure NVRAM parameters...
qla6312 0000:07:01.0: Verifying loaded RISC code...
qla6312 0000:07:01.0: LIP reset occured (f7f7).
qla6312 0000:07:01.0: Waiting for LIP to complete...
qla6312 0000:07:01.0: LOOP UP detected (2 Gbps).
qla6312 0000:07:01.0: Topology - (F_Port), Host Loop address 0xffff
scsi0 : qla2xxx
qla6312 0000:07:01.0:
 QLogic Fibre Channel HBA Driver: 8.01.02-sles
  QLogic QLA200 -
  ISP6312: PCI-X (133 MHz) @ 0000:07:01.0 hdma+, host#=0, fw=3.03.18 FLX
  Vendor: DGC       Model: RAID 5            Rev: 0219
  Type:   Direct-Access                      ANSI SCSI revision: 04
qla6312 0000:07:01.0: scsi(0:0:0:0): Enabled tagged queuing, queue depth
32.
SCSI device sda: 1048576000 512-byte hdwr sectors (536871 MB)
SCSI device sda: drive cache: write through
 sda: sda1
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
  Vendor: HP        Model: MSL6000 Series    Rev: 0513
  Type:   Medium Changer                     ANSI SCSI revision: 02
  Vendor: HP        Model: SDLT600           Rev: 2323
  Type:   Sequential-Access                  ANSI SCSI revision: 03
  Vendor: HP        Model: SDLT600           Rev: 2323
  Type:   Sequential-Access                  ANSI SCSI revision: 03
scsi: unknown device type 12
  Vendor: HP        Model: NS E1200-160      Rev: 5687
  Type:   RAID                               ANSI SCSI revision: 04
  Vendor: COMPAQ    Model: MSL5000 Series    Rev: 0408
  Type:   Medium Changer                     ANSI SCSI revision: 02
  Vendor: COMPAQ    Model: SuperDLT1         Rev: 3333
  Type:   Sequential-Access                  ANSI SCSI revision: 02
  Vendor: COMPAQ    Model: SuperDLT1         Rev: 3333
  Type:   Sequential-Access                  ANSI SCSI revision: 02
scsi: unknown device type 12
  Vendor: HP        Model: NS E1200-160      Rev: 5687
  Type:   RAID                               ANSI SCSI revision: 04
SGI XFS with ACLs, security attributes, realtime, large block/inode
numbers, dmapi support, no debug enabled
XFS mounting filesystem cciss/c0d0p3
Starting XFS recovery on filesystem: cciss/c0d0p3 (dev: cciss/c0d0p3)
Ending XFS recovery on filesystem: cciss/c0d0p3 (dev: cciss/c0d0p3)
VFS: Mounted root (xfs filesystem) readonly.
Trying to move old root to /initrd ... /initrd does not exist. Ignored.
Unmounting old root
Trying to free ramdisk memory ... failed
Freeing unused kernel memory: 204k freed
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
device-mapper: Allocated new minor_bits array for 1024 devices
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
SGI XFS Quota Management subsystem
XFS mounting filesystem cciss/c0d0p1
Starting XFS recovery on filesystem: cciss/c0d0p1 (dev: cciss/c0d0p1)
Ending XFS recovery on filesystem: cciss/c0d0p1 (dev: cciss/c0d0p1)
XFS mounting filesystem cciss/c0d0p4
Starting XFS recovery on filesystem: cciss/c0d0p4 (dev: cciss/c0d0p4)
Ending XFS recovery on filesystem: cciss/c0d0p4 (dev: cciss/c0d0p4)
subfs 0.9
ReiserFS: sda1: found reiserfs format "3.6" with standard journal
ReiserFS: sda1: using ordered data mode
reiserfs: using flush barriers
ReiserFS: sda1: journal params: device sda1, size 8192, journal first
block 18, max trans len 1024, max batch 900, max c
ommit age 30, max trans age 30
ReiserFS: sda1: checking transaction log (sda1)
reiserfs: disabling flush barriers on sda1
ReiserFS: sda1: Using r5 hash to sort names
Adding 2101192k swap on /dev/cciss/c0d0p2.  Priority:42 extents:1
tg3.c:v3.37 (August 25, 2005)
ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 25 (level, low) -> IRQ 23
eth0: Tigon3 [partno(349321-001) rev 2100 PHY(5704)]
(PCIX:100MHz:64-bit) 10/100/1000BaseT Ethernet 00:11:85:c2:f0:15
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] Split[0] WireSpeed[1]
TSOcap[0]
eth0: dma_rwctrl[769f0000]
ACPI: PCI interrupt 0000:02:02.1[B] -> GSI 26 (level, low) -> IRQ 24
eth1: Tigon3 [partno(349321-001) rev 2100 PHY(5704)]
(PCIX:100MHz:64-bit) 10/100/1000BaseT Ethernet 00:11:85:c2:f0:14
eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1]
TSOcap[1]
eth1: dma_rwctrl[769f0000]
usbcore: registered new driver usbfs
usbcore: registered new driver hub
tg3: eth0: Link is up at 1000 Mbps, full duplex.
tg3: eth0: Flow control is off for TX and off for RX.
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 16
uhci_hcd 0000:00:1d.0: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 16, io base 0000000000002000
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
usb usb1: Product: UHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.5-7.257-smp uhci_hcd
usb usb1: SerialNumber: 0000:00:1d.0
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 17
uhci_hcd 0000:00:1d.1: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 17, io base 0000000000002020
hw_random hardware driver 1.0.0 loaded
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
usb usb2: Product: UHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.5-7.257-smp uhci_hcd
usb usb2: SerialNumber: 0000:00:1d.1
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 18
ehci_hcd 0000:00:1d.7: EHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 18, pci mem ffffff00009a7000
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 3
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2003-Dec-29
usb usb3: Product: EHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.5-7.257-smp ehci_hcd
usb usb3: SerialNumber: 0000:00:1d.7
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 4 ports detected
Fusion MPT base driver 3.02.62suse
Copyright (c) 1999-2005 LSI Logic Corporation
Fusion MPT SPI Host driver 3.02.62suse
ACPI: PCI interrupt 0000:0a:01.0[A] -> GSI 72 (level, low) -> IRQ 20
mptbase: Initiating ioc0 bringup
ioc0: 53C1030: Capabilities={Initiator,Target}
scsi1 : ioc0: LSI53C1030, FwRev=01032700h, Ports=1, MaxQ=255, IRQ=20
st: Version 20040318, fixed bufsize 32768, s/g segs 256
Attached scsi tape st0 at scsi0, channel 0, id 1, lun 1
st0: try direct i/o: yes (alignment 512 B), max page reachable by HBA
4503599627370495
Attached scsi tape st1 at scsi0, channel 0, id 1, lun 2
st1: try direct i/o: yes (alignment 512 B), max page reachable by HBA
4503599627370495
Attached scsi tape st2 at scsi0, channel 0, id 2, lun 1
st2: try direct i/o: yes (alignment 512 B), max page reachable by HBA
4503599627370495
Attached scsi tape st3 at scsi0, channel 0, id 2, lun 2
st3: try direct i/o: yes (alignment 512 B), max page reachable by HBA
4503599627370495
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg1 at scsi0, channel 0, id 1, lun 0,  type 8
Attached scsi generic sg2 at scsi0, channel 0, id 1, lun 1,  type 1
Attached scsi generic sg3 at scsi0, channel 0, id 1, lun 2,  type 1
Attached scsi generic sg4 at scsi0, channel 0, id 1, lun 3,  type 12
Attached scsi generic sg5 at scsi0, channel 0, id 2, lun 0,  type 8
Attached scsi generic sg6 at scsi0, channel 0, id 2, lun 1,  type 1
Attached scsi generic sg7 at scsi0, channel 0, id 2, lun 2,  type 1
Attached scsi generic sg8 at scsi0, channel 0, id 2, lun 3,  type 12
st0: Block limits 4 - 16777212 bytes.
st3: Block limits 4 - 16777212 bytes.
ACPI: PCI interrupt 0000:0a:01.1[B] -> GSI 73 (level, low) -> IRQ 21
mptbase: Initiating ioc1 bringup
ioc1: 53C1030: Capabilities={Initiator,Target}
scsi2 : ioc1: LSI53C1030, FwRev=01032700h, Ports=1, MaxQ=255, IRQ=21
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
lp: driver loaded but no devices found
drivers/usb/serial/usb-serial.c: USB Serial support registered for
Generic
usbcore: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1)
ACPI: Processor [CPU1] (supports C1)
ACPI: Processor [CPU2] (supports C1)
ACPI: Processor [CPU3] (supports C1)
ACPI: Thermal Zone [THM0] (8 C)
speedstep-centrino: found unsupported CPU with Enhanced SpeedStep: send
/proc/cpuinfo to Jeremy Fitzhardinge <jeremy@goo
p.org>
inserting floppy driver for 2.6.5-7.257-smp
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
end_request: I/O error, dev fd0, sector 0
end_request: I/O error, dev fd0, sector 0
BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
eth0: no IPv6 routers present


