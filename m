Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751784AbWFWQ7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784AbWFWQ7E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 12:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751786AbWFWQ7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 12:59:04 -0400
Received: from wr-out-0506.google.com ([64.233.184.226]:31648 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751784AbWFWQ7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 12:59:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=hKfTkMTuaD6E9Cu4/khcDMEKxySaLYZaG0n7OT9fnju6q11mvc90q4UFPUFTJKLBYqQYW1NjZuJ8zMJv1A/s4nNIJGtaQC/RoCrD2jN/rinQb1zL5MaSlszrQoI4rQUnUdxK0EmpMZywqXI+Pi94UfojKEM3I6CNwC1W4gTdQ4c=
Message-ID: <b7ddee480606230959w20ee6658ud8a1978c74655063@mail.gmail.com>
Date: Sat, 24 Jun 2006 00:59:02 +0800
From: "Raid Cheng" <chenglei@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: booting failure on 2.6.17-mm1
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using RHEL4-u3 with 2.6.9-34 on ppc64 and trying to install 2.6.17-mm1
on it. The whole compile process is fine, but when i boot the kernel,
the system crashed and i got following output:

boot: 2.6.17-mm1
Please wait, loading kernel...
   Elf64 kernel loaded...
Loading ramdisk...
ramdisk loaded at 02600000, size: 860 Kbytes
OF stdout device is: /vdevice/vty@30000000
Hypertas detected, assuming LPAR !
command line: ro console=hvc0 root=LABEL=/
memory layout at init:
  alloc_bottom : 00000000026d7000
  alloc_top    : 0000000008000000
  alloc_top_hi : 0000000080000000
  rmo_top      : 0000000008000000
  ram_top      : 0000000080000000
Looking for displays
instantiating rtas at 0x0000000007734000 ... done
0000000000000000 : boot cpu     0000000000000000
0000000000000002 : starting cpu hw idx 0000000000000002... done
0000000000000004 : starting cpu hw idx 0000000000000004... done
0000000000000006 : starting cpu hw idx 0000000000000006... done
copying OF device tree ...
Building dt strings...
Building dt structure...
Device tree strings 0x0000000002ad8000 -> 0x0000000002ad9055
Device tree struct  0x0000000002ada000 -> 0x0000000002ae2000
Calling quiesce ...
returning from prom_init
Partition configured for 8 cpus.
Starting Linux PPC64 #1 SMP Fri Jun 23 06:54:16 EDT 2006
-----------------------------------------------------
ppc64_pft_size                = 0x19
ppc64_interrupt_controller    = 0x2
physicalMemorySize            = 0x80000000
ppc64_caches.dcache_line_size = 0x80
ppc64_caches.icache_line_size = 0x80
htab_address                  = 0x0000000000000000
htab_hash_mask                = 0x3ffff
-----------------------------------------------------
Linux version 2.6.17-mm1 (root@localhost.localdomain) (gcc version
3.4.5 20051201 (Red Hat 3.4.5-2)) #1 SMP Fri Jun 23 06:54:16

EDT 2006
[boot]0012 Setup Arch
EEH: No capable adapters found
PPC64 nvram contains 7168 bytes
[boot]0015 Setup Done
Built 2 zonelists.  Total pages: 524288
Kernel command line: ro console=hvc0 root=LABEL=/
[boot]0020 XICS Init
[boot]0021 XICS Done
PID hash table entries: 4096 (order: 12, 32768 bytes)
Using pSeries machine description
Found initrd at 0xc000000002600000:0xc0000000026d7000
Partition configured for 8 cpus.
Starting Linux PPC64 #1 SMP Fri Jun 23 06:54:16 EDT 2006
-----------------------------------------------------
ppc64_pft_size                = 0x19
ppc64_interrupt_controller    = 0x2
physicalMemorySize            = 0x80000000
ppc64_caches.dcache_line_size = 0x80
ppc64_caches.icache_line_size = 0x80
htab_address                  = 0x0000000000000000
htab_hash_mask                = 0x3ffff
-----------------------------------------------------
Linux version 2.6.17-mm1 (root@localhost.localdomain) (gcc version
3.4.5 20051201 (Red Hat 3.4.5-2)) #1 SMP Fri Jun 23 06:54:16

EDT 2006
[boot]0012 Setup Arch
EEH: No capable adapters found
PPC64 nvram contains 7168 bytes
[boot]0015 Setup Done
Built 2 zonelists.  Total pages: 524288
Kernel command line: ro console=hvc0 root=LABEL=/
[boot]0020 XICS Init
[boot]0021 XICS Done
PID hash table entries: 4096 (order: 12, 32768 bytes)
Console: colour dummy device 80x25
------------------------
| Locking API testsuite:
----------------------------------------------------------------------------
                                 | spin |wlock |rlock |mutex | wsem | rsem |
  --------------------------------------------------------------------------
                     A-A deadlock:failed|failed|failed|failed|failed|failed|
                 A-B-B-A deadlock:failed|failed|  ok  |failed|failed|failed|
             A-B-B-C-C-A deadlock:failed|failed|  ok  |failed|failed|failed|
             A-B-C-A-B-C deadlock:failed|failed|  ok  |failed|failed|failed|
         A-B-B-C-C-D-D-A deadlock:failed|failed|  ok  |failed|failed|failed|
         A-B-C-D-B-D-D-A deadlock:failed|failed|  ok  |failed|failed|failed|
         A-B-C-D-B-C-D-A deadlock:failed|failed|  ok  |failed|failed|failed|
                    double unlock:failed|failed|failed|  ok  |failed|failed|
                  initialize held:failed|failed|failed|failed|failed|failed|
                 bad unlock order:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
  --------------------------------------------------------------------------
              recursive read-lock:             |  ok  |             |failed|
           recursive read-lock #2:             |failed|             |failed|
            mixed read-write-lock:             |failed|             |failed|
            mixed write-read-lock:             |failed|             |failed|
  --------------------------------------------------------------------------
     hard-irqs-on + irq-safe-A/12:failed|failed|  ok  |
     soft-irqs-on + irq-safe-A/12:failed|failed|  ok  |
     hard-irqs-on + irq-safe-A/21:failed|failed|  ok  |
     soft-irqs-on + irq-safe-A/21:failed|failed|  ok  |
       sirq-safe-A => hirqs-on/12:failed|failed|  ok  |
       sirq-safe-A => hirqs-on/21:failed|failed|  ok  |
         hard-safe-A + irqs-on/12:failed|failed|  ok  |
         soft-safe-A + irqs-on/12:failed|failed|  ok  |
         hard-safe-A + irqs-on/21:failed|failed|  ok  |
         soft-safe-A + irqs-on/21:failed|failed|  ok  |
    hard-safe-A + unsafe-B #1/123:failed|failed|  ok  |
    soft-safe-A + unsafe-B #1/123:failed|failed|  ok  |
    hard-safe-A + unsafe-B #1/132:failed|failed|  ok  |
    soft-safe-A + unsafe-B #1/132:failed|failed|  ok  |
    hard-safe-A + unsafe-B #1/213:failed|failed|  ok  |
    soft-safe-A + unsafe-B #1/213:failed|failed|  ok  |
    hard-safe-A + unsafe-B #1/231:failed|failed|  ok  |
    soft-safe-A + unsafe-B #1/231:failed|failed|  ok  |
    hard-safe-A + unsafe-B #1/312:failed|failed|  ok  |
    soft-safe-A + unsafe-B #1/312:failed|failed|  ok  |
    hard-safe-A + unsafe-B #1/321:failed|failed|  ok  |
    soft-safe-A + unsafe-B #1/321:failed|failed|  ok  |
    hard-safe-A + unsafe-B #2/123:failed|failed|  ok  |
    soft-safe-A + unsafe-B #2/123:failed|failed|  ok  |
    hard-safe-A + unsafe-B #2/132:failed|failed|  ok  |
    soft-safe-A + unsafe-B #2/132:failed|failed|  ok  |
    hard-safe-A + unsafe-B #2/213:failed|failed|  ok  |
    soft-safe-A + unsafe-B #2/213:failed|failed|  ok  |
    hard-safe-A + unsafe-B #2/231:failed|failed|  ok  |
    soft-safe-A + unsafe-B #2/231:failed|failed|  ok  |
    hard-safe-A + unsafe-B #2/312:failed|failed|  ok  |
    soft-safe-A + unsafe-B #2/312:failed|failed|  ok  |
    hard-safe-A + unsafe-B #2/321:failed|failed|  ok  |
    soft-safe-A + unsafe-B #2/321:failed|failed|  ok  |
      hard-irq lock-inversion/123:failed|failed|  ok  |
      soft-irq lock-inversion/123:failed|failed|  ok  |
      hard-irq lock-inversion/132:failed|failed|  ok  |
      soft-irq lock-inversion/132:failed|failed|  ok  |
      hard-irq lock-inversion/213:failed|failed|  ok  |
      soft-irq lock-inversion/213:failed|failed|  ok  |
      hard-irq lock-inversion/231:failed|failed|  ok  |
      soft-irq lock-inversion/231:failed|failed|  ok  |
      hard-irq lock-inversion/312:failed|failed|  ok  |
      soft-irq lock-inversion/312:failed|failed|  ok  |
      hard-irq lock-inversion/321:failed|failed|  ok  |
      soft-irq lock-inversion/321:failed|failed|  ok  |
      hard-irq read-recursion/123:  ok  |
      soft-irq read-recursion/123:  ok  |
      hard-irq read-recursion/132:  ok  |
      soft-irq read-recursion/132:  ok  |
      hard-irq read-recursion/213:  ok  |
      soft-irq read-recursion/213:  ok  |
Badness in __local_bh_enable at kernel/softirq.c:99
Call Trace:
[C00000000075F560] [C00000000000EA80] .show_stack+0x68/0x1b4 (unreliable)
[C00000000075F610] [C000000000021B00] .program_check_exception+0x1cc/0x5e4
[C00000000075F6B0] [C00000000000446C] program_check_common+0xec/0x100
--- Exception: 700 at .__local_bh_enable+0x64/0x80
    LR = .do_softirq+0xb0/0xd0
[C00000000075F9A0] [C00000000000B7A8] .do_softirq+0xa8/0xd0 (unreliable)
[C00000000075FA30] [C000000000055B18] .irq_exit+0x64/0x7c
[C00000000075FAB0] [C00000000001F5E0] .timer_interrupt+0x464/0x48c
[C00000000075FB80] [C0000000000034DC] decrementer_common+0xdc/0x100
--- Exception: 901 at .locking_selftest+0x159c/0x17dc
    LR = .locking_selftest+0x1598/0x17dc
[C00000000075FEF0] [C000000000514740] .start_kernel+0x1e0/0x330
[C00000000075FF90] [C000000000008534] .start_here_common+0x88/0x8c
      hard-irq read-recursion/231:  ok  |
      soft-irq read-recursion/231:  ok  |
      hard-irq read-recursion/312:  ok  |
      soft-irq read-recursion/312:  ok  |
      hard-irq read-recursion/321:  ok  |
      soft-irq read-recursion/321:  ok  |
--------------------------------------------------------
146 out of 218 testcases failed, as expected. |
----------------------------------------------------
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
freeing bootmem node 0
freeing bootmem node 1
Memory: 2046440k/2097152k available (5464k kernel code, 50712k
reserved, 2068k data, 569k bss, 264k init)
Mount-cache hash table entries: 256
Processor 1 found.
irq 18, desc: c00000000076ee80, depth: 1, count: 0, unhandled: 0
->handle_irq():  c000000000726700, handle_bad_irq+0x0/0x10
->chip(): c00000000058b5d8, xics_pic+0x0/0x80
->action(): 0000000000000000
  IRQ_DISABLED set
   IRQ_PER_CPU set
illegal vector 18 received!
kernel BUG in ack_bad_irq at include/asm/hardirq.h:25!
cpu 0x1: Vector: 700 (Program Check) at [c00000000fff3bd0]
    pc: c000000000086958: .handle_bad_irq+0x248/0x268
    lr: c000000000086954: .handle_bad_irq+0x244/0x268
    sp: c00000000fff3e50
   msr: 8000000000021032
  current = 0xc00000000770b7f0
  paca    = 0xc000000000579080
    pid   = 0, comm = idle
kernel BUG in ack_bad_irq at include/asm/hardirq.h:25!
irq 18, desc: c00000000076ee80, depth: 1, count: 0, unhandled: 0
->handle_irq():  c000000000726700, handle_bad_irq+0x0/0x10
->chip(): c00000000058b5d8, xics_pic+0x0/0x80
->action(): 0000000000000000
  IRQ_DISABLED set
   IRQ_PER_CPU set
illegal vector 18 received!
kernel BUG in ack_bad_irq at include/asm/hardirq.h:25!
cpu 0x0: Vector: 700 (Program Check) at [c00000000fffbbd0]
e       ppcc::  cc00nm>o n> : .handle_bad_irq+0x248/0x268
    lr: c000000000086954: .handle_bad_irq+0x244/0x268
    sp: c00000000fffbe50
   msr: 8000000000021032
  current = 0xc00000007ffb3000
  paca    = 0xc000000000578e80
    pid   = 1, comm = idle
kernel BUG in ack_bad_irq at include/asm/hardirq.h:25!
							

1:mon> t
[c00000000fff3ee0] c000000000086d60 .__do_IRQ+0x6c/0x298
[c00000000fff3f90] c000000000022e24 .call___do_IRQ+0x14/0x24
[c000000002affaa0] c00000000000b3ac .do_IRQ+0xe0/0x15c
[c000000002affb30] c0000000000041dc hardware_interrupt_entry+0xc/0x30
--- Exception: 501 (Hardware Interrupt) at c00000000003562c
.plpar_hcall_norets+0x10/0x1c
[link register   ] c0000000000369bc .pseries_shared_idle_sleep+0x24/0x44
[c000000002affe20] 0000000000000000 (unreliable)
[c000000002affe90] c000000000010428 .cpu_idle+0xfc/0x1d4
[c000000002afff00] c000000000025c80 .start_secondary+0x144/0x164
[c000000002afff90] c00000000000835c .start_secondary_prolog+0xc/0x10
1:mon> e
cpu 0x1: Vector: 700 (Program Check) at [c00000000fff3bd0]
    pc: c000000000086958: .handle_bad_irq+0x248/0x268
    lr: c000000000086954: .handle_bad_irq+0x244/0x268
    sp: c00000000fff3e50
   msr: 8000000000021032
  current = 0xc00000000770b7f0
  paca    = 0xc000000000579080
    pid   = 0, comm = idle
kernel BUG in ack_bad_irq at include/asm/hardirq.h:25!
1:mon> r
R00 = c000000000086954   R16 = 0000000000000000
R01 = c00000000fff3e50   R17 = 0000000000000000
R02 = c00000000075c5e8   R18 = 0000000000000000
R03 = 000000000000001f   R19 = 0000000000000000
R04 = 8000000000001032   R20 = 0000000000000000
R05 = ffffffffffffffff   R21 = 0000000000000000
R06 = 0000000063656976   R22 = 0000000000000000
R07 = 000000006564210d   R23 = 0000000000000001
R08 = 0000000000000000   R24 = 0000000000000001
R09 = 0000000000000000   R25 = 0000000000000000
R10 = c0000000007972c0   R26 = c000000002affba0
R11 = c00000000770b7f0   R27 = 0000000000000000
R12 = 0000000000004000   R28 = 0000000000000012
R13 = c000000000579080   R29 = 0000000000000012
R14 = 0000000000000000   R30 = c0000000005b2718
R15 = 00000000079f9a8c   R31 = c00000000076ee80
pc  = c000000000086958 .handle_bad_irq+0x248/0x268
lr  = c000000000086954 .handle_bad_irq+0x244/0x268
msr = 8000000000021032   cr  = 28000022
ctr = 80000000000d40b8   xer = 000000000000000d   trap =  700
								
Can anyone give me some helps about this error?

-Thanks

Raid Cheng
