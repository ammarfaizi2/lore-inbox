Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270691AbTHEVf0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 17:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272441AbTHEVfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 17:35:25 -0400
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:49085 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S270691AbTHEVfE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 17:35:04 -0400
Message-ID: <3F3021AA.1000201@rackable.com>
Date: Tue, 05 Aug 2003 14:29:14 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.22-pre10 ACPI kennel oops
Content-Type: multipart/mixed;
 boundary="------------090809050302000205060906"
X-OriginalArrivalTime: 05 Aug 2003 21:35:02.0303 (UTC) FILETIME=[6D93C2F0:01C35B99]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090809050302000205060906
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

  I'm getting a kernel oops on the intel woodruf P4 motherboard under 
2.4.22pre10.  This config worked fine under 2.4.21.  The output of 
ksymoops is attached, and the raw oops is attached.

ksymoops 2.4.4 on i686 2.4.20-8smp.  Options used
     -V (default)
     -K (specified)
     -L (specified)
     -O (specified)
     -m /boot/System.map-2.4.22-pre10 (specified)

ACPI: LAPIC_NMI (acpi_id[0x01] polarity[0x0] trigger[0x0] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] polarity[0x0] trigger[0x0] lint[0x1])
cpu: 0, clocks: 1328876, slice: 664438
Unable to handle kernel paging request at virtual address f8803000
c022d588
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c022d588>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 00000000   ebx: 00000000   ecx: 00000001   edx: c1c13ec0
esi: f8802ffd   edi: c1c13ee0   ebp: c1c13ec0   esp: c1c13e64
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, stackpage=c1c13000)
Stack: c1c13f1c c1c13f1c c1c13e84 c022d015 c1c13ec0 f8802fdd 00000024 
f8802fdd
       00000008 c0492d37 c0492d24 00200000 c1c13eb0 c1c13ec0 c1c13f2c 
c1c13eb0
       c022c984 c1c13f1c c1c13ec0 00000008 c0492cab c0492ca2 c1c13f0c 
54445353
Call Trace:    [<c022d015>] [<c022c984>] [<c022cb68>] [<c022cd89>] 
[<c022e124>]
  [<c022e1fa>] [<c0105000>] [<c010508b>] [<c0105000>] [<c01075ae>] 
[<c0105060>]
Code: f3 a5 e9 5c ff ff ff c1 e9 02 89 d7 f3 a5 a4 e9 4f ff ff ff

 >>EIP; c022d588 <__constant_memcpy+bd/f5>   <=====
Trace; c022d015 <acpi_tb_get_table_header+11a/12d>
Trace; c022c984 <acpi_tb_get_primary_table+64/d2>
Trace; c022cb68 <acpi_tb_get_required_tables+45/2b4>
Trace; c022cd89 <acpi_tb_get_required_tables+266/2b4>
Trace; c022e124 <acpi_load_tables+34/188>
Trace; c022e1fa <acpi_load_tables+10a/188>
Trace; c0105000 <_stext+0/0>
Trace; c010508b <init+2b/190>
Trace; c0105000 <_stext+0/0>
Trace; c01075ae <arch_kernel_thread+2e/40>
Trace; c0105060 <init+0/190>
Code;  c022d588 <__constant_memcpy+bd/f5>
00000000 <_EIP>:
Code;  c022d588 <__constant_memcpy+bd/f5>   <=====
   0:   f3 a5                     repz movsl %ds:(%esi),%es:(%edi)   <=====
Code;  c022d58a <__constant_memcpy+bf/f5>
   2:   e9 5c ff ff ff            jmp    ffffff63 <_EIP+0xffffff63>
Code;  c022d58f <__constant_memcpy+c4/f5>
   7:   c1 e9 02                  shr    $0x2,%ecx
Code;  c022d592 <__constant_memcpy+c7/f5>
   a:   89 d7                     mov    %edx,%edi
Code;  c022d594 <__constant_memcpy+c9/f5>
   c:   f3 a5                     repz movsl %ds:(%esi),%es:(%edi)
Code;  c022d596 <__constant_memcpy+cb/f5>
   e:   a4                        movsb  %ds:(%esi),%es:(%edi)
Code;  c022d597 <__constant_memcpy+cc/f5>
   f:   e9 4f ff ff ff            jmp    ffffff63 <_EIP+0xffffff63>


-- 
Once you have their hardware. Never give it back.
(The First Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>


--------------090809050302000205060906
Content-Type: text/plain;
 name="oopsacpi"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="oopsacpi"

 TrLinux version 2.4.22-pre10 (root@grendel) (gcc version 3.2.2 20030222 =
(Red Hat Linux 3.2.2-5)) #2 SMP Fri Aug 1 07:39:59 PDT 2003              =
            BIOS-provided physical RAM map:ntel Corporation              =
                   BIOS-e820: 0000000000000000 - 000000000009b400 (usable=
)                        BIOS-e820: 000000000009b400 - 000000000009b800 (=
reserved)                      BIOS-e820: 00000000000e8000 - 000000000010=
0000 (reserved) . Peter Anvin        BIOS-e820: 0000000000100000 - 000000=
003ffc0000 (usable)                        BIOS-e820: 000000003ffc0000 - =
000000003fff8000 (ACPI data)                     BIOS-e820: 000000003fff8=
000 - 0000000040000000 (ACPI NVS)                      BIOS-e820: 0000000=
0fec00000 - 00000000fec01000 (reserved)                      BIOS-e820: 0=
0000000fee00000 - 00000000fee01000 (reserved)                      BIOS-e=
820: 00000000ffb80000 - 00000000ffc00000 (reserved)                      =
BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)                =
     127MB HIGHMEM available.re # is 71, 72, 73, 80 or 90)               =
           896MB LOWMEM available.all Red Hat 7.1-8.0 full auto /w lilo  =
                 found SMP MP-table at 000ff780 is 71, 72, 73, or 80)    =
                       hm, page 000ff000 reserved twice.Hat 7.1-9.0 semi =
auto                         hm, page 00100000 reserved twice.is 71, 72, =
73, 80 or 90)                      hm, page 000f1000 reserved twice.hard =
drive                                    hm, page 000f2000 reserved twice=
=2E                                              On node 0 totalpages: 26=
2080ng /vmlinuz-2.4.22-pre10..............             zone(0): 4096 page=
s.  =20
zone(1): 225280 pages.
zone(2): 32704 pages.
ACPI: RSDP (v000 AMI                        ) @ 0x000ff980
ACPI: RSDT (v001 D845WD WD84510A 08194.04632) @ 0x3fff0000
ACPI: FADT (v001 D845WD WD84510A 08194.04632) @ 0x3fff1000
ACPI: MADT (v001 D845WD WD84510A 08194.04632) @ 0x3ffe2f75
ACPI: SSDT (v001 D845WD WD84510A 00000.00001) @ 0x3ffe2fdd
ACPI: DSDT (v001 D845WD WD84510A 00000.00001) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 Pentium 4(tm) XEON(tm) APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] disabled)
ACPI: LAPIC_NMI (acpi_id[0x01] polarity[0x0] trigger[0x0] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] polarity[0x0] trigger[0x0] lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, IRQ 0-23
ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x1] trigger[=
0x3])
ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[=
0x0])
Using ACPI (MADT) for SMP configuration information
Kernel command line: root=3D/dev/nfs ip=3D::::::dhcp nfsroot=3D10.10.1.3:=
/vol0/nfs/root/current console=3DttyS1,9600 console=3Dtty0 BOOT_IMAGE=3D/=
vmlinuz-2.4.22-pre10=20
Initializing CPU#0
Detected 2392.081 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 4771.02 BogoMIPS
Memory: 1030008k/1048320k available (3314k kernel code, 17908k reserved, =
1171k data, 380k init, 130816k highmem)
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Hyper-Threading is disabled
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Hyper-Threading is disabled
Intel machine check reporting enabled on CPU#0.
CPU0: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 07
per-CPU timeslice cutoff: 1462.89 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Error: only one processor found.
ENABLING IO-APIC IRQs
=2E.TIMER: vector=3D0x31 pin1=3D2 pin2=3D0
testing the IO APIC.......................

=2E................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
=2E.... CPU clock speed is 2391.9812 MHz.
=2E.... host bus clock speed is 132.8876 MHz.
cpu: 0, clocks: 1328876, slice: 664438
CPU0<T0:1328864,T1:664416,D:10,S:664438,C:1328876>
Waiting on wait_init_idle (map =3D 0x0)
All processors have done init_idle
ACPI: Subsystem revision 20030619
PCI: PCI BIOS revision 2.10 entry at 0xfda95, last bus=3D2
PCI: Using configuration type 1
Unable to handle kernel paging request at virtual address f8803000
 printing eip:
c022d588
*pde =3D 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c022d588>]    Not tainted
EFLAGS: 00010206
eax: 00000000   ebx: 00000000   ecx: 00000001   edx: c1c13ec0
esi: f8802ffd   edi: c1c13ee0   ebp: c1c13ec0   esp: c1c13e64
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, stackpage=3Dc1c13000)
Stack: c1c13f1c c1c13f1c c1c13e84 c022d015 c1c13ec0 f8802fdd 00000024 f88=
02fdd=20
       00000008 c0492d37 c0492d24 00200000 c1c13eb0 c1c13ec0 c1c13f2c c1c=
13eb0=20
       c022c984 c1c13f1c c1c13ec0 00000008 c0492cab c0492ca2 c1c13f0c 544=
45353=20
Call Trace:    [<c022d015>] [<c022c984>] [<c022cb68>] [<c022cd89>] [<c022=
e124>]
  [<c022e1fa>] [<c0105000>] [<c010508b>] [<c0105000>] [<c01075ae>] [<c010=
5060>]

Code: f3 a5 e9 5c ff ff ff c1 e9 02 89 d7 f3 a5 a4 e9 4f ff ff ff=20
 <0>Kernel panic: Attempted to kill init!
 
--------------090809050302000205060906--

