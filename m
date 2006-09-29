Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422660AbWI2XxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422660AbWI2XxG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 19:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422658AbWI2XxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 19:53:06 -0400
Received: from iron.pdx.net ([207.149.241.18]:56277 "EHLO iron.pdx.net")
	by vger.kernel.org with ESMTP id S932295AbWI2XxC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 19:53:02 -0400
Subject: RE: [aacraid] Adaptec 2820SA Crash
From: Sean Bruno <sean.bruno@dsl-only.net>
To: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <547AF3BD0F3F0B4CBDC379BAC7E4189F02CE35B6@otce2k03.adaptec.com>
References: <547AF3BD0F3F0B4CBDC379BAC7E4189F02CE35B6@otce2k03.adaptec.com>
Content-Type: text/plain
Date: Fri, 29 Sep 2006 16:53:01 -0700
Message-Id: <1159573981.3889.175.camel@home-desk>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmmmmmm....I don't seem to be able to post with the attachments.  Here
is the kernel panic/dump and some other information:

The system in question is an ASUS M2N32WS motherboard running an
Dual-Core Athlon64.

The 2820SA was tested with firmware revisions 9194 and 8832.  

The running o/s is Fedora Core 6 Test 3 with their latest renditions of
2.6.18.  I also compiled and tested vanilla 2.6.18 with the kernel
configuration from Fedora's kernels.

The driver version of aacraid reports as 1.1-5[2409]-mh2.


udevd[541]: add_to_rules: invalid rule
'/etc/udev/rules.d/50-udev.rules:153'
Unable to handle kernel paging request at ffffc20010084044 RIP:
 [<ffffffff88169501>] :aacraid:aac_rkt_intr+0x1a/0x122
PGD 3fc1a067 PUD 3fc1b067 PMD 3fdf7067 PTE 0
Oops: 0000 [1] SMP
last sysfs file: /class/net/lo/type
CPU 0
Modules linked in: i2c_nforce2 ohci1394 i2c_core ieee1394 floppy aacraid
pcspkrdPid: 743, comm: modprobe Not tainted 2.6.18-1.2693.fc6 #1
RIP: 0010:[<ffffffff88169501>]
[<ffffffff88169501>] :aacraid:aac_rkt_intr+0x1a2RSP:
0018:ffffffff80716ef8  EFLAGS: 00010002
RAX: 0000000000000000 RBX: ffff81003c61b138 RCX: ffffc20010084000
RDX: ffff81003d4af9e8 RSI: ffff81003bbe26d8 RDI: 00000000000000b1
RBP: ffffffff80716f08 R08: ffffffff80716f28 R09: 0000000000000001
R10: ffffffff802c238e R11: ffffffff806be440 R12: ffff81003bbe26d8
R13: 0000000000000000 R14: 00000000000000b1 R15: ffff81003d4af9e8
FS:  00002aaaaaab6240(0000) GS:ffffffff8069b000(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: ffffc20010084044 CR3: 000000003ce1f000 CR4: 00000000000006e0
Process modprobe (pid: 743, threadinfo ffff81003d4ae000, task
ffff81003ee510c0)
Stack:  ffff81003c61b138 0000000000000000 ffffffff80716f48
ffffffff80211475
 ffffffff806be440 ffffffff806be400 000000000000b100 00000000000000b1
 ffffffff806be440 ffff81003c61b138 ffffffff80716f88 ffffffff802c23f1
Call Trace:
 [<ffffffff80211475>] handle_IRQ_event+0x2c/0x64
 [<ffffffff802c23f1>] __do_IRQ+0xaf/0x114
 [<ffffffff802700a1>] do_IRQ+0xf8/0x107
 [<ffffffff80260d46>] ret_from_intr+0x0/0xf
DWARF2 unwinder stuck at ret_from_intr+0x0/0xf
Leftover inexact backtrace:
 <IRQ> <EOI> [<ffffffff80278c61>] do_flush_tlb_all+0x0/0x87
 [<ffffffff80295c57>] on_each_cpu+0x2d/0x36
 [<ffffffff80278f4b>] flush_tlb_all+0x1c/0x1e
 [<ffffffff8025457b>] unmap_vm_area+0x1d4/0x276
 [<ffffffff80201c20>] init_level4_pgt+0xc20/0x1000
 [<ffffffff802d1973>] __remove_vm_area+0x2c/0x44
 [<ffffffff802d19ab>] remove_vm_area+0x20/0x36
 [<ffffffff802840a1>] iounmap+0x8e/0xce
 [<ffffffff88166684>] :aacraid:aac_init_adapter+0xcc/0x674
 [<ffffffff88169857>] :aacraid:aac_rkt_init+0x15d/0x250
 [<ffffffff88162a47>] :aacraid:aac_probe_one+0x209/0x4c6
 [<ffffffff8035ce4f>] pci_device_probe+0x106/0x186
 [<ffffffff8028e73f>] default_wake_function+0x0/0xf
 [<ffffffff803bf972>] driver_probe_device+0x5c/0xb1
 [<ffffffff803bfadc>] __driver_attach+0x89/0xdb
 [<ffffffff803bfa53>] __driver_attach+0x0/0xdb
 [<ffffffff803bf324>] bus_for_each_dev+0x49/0x7a
 [<ffffffff803bf89c>] driver_attach+0x1c/0x1e
 [<ffffffff803bef3c>] bus_add_driver+0x89/0x138
 [<ffffffff803bfd87>] driver_register+0x8f/0x93
 [<ffffffff8035d051>] __pci_register_driver+0x63/0x85
 [<ffffffff8817c033>] :aacraid:aac_init+0x33/0x6e
 [<ffffffff802afc95>] sys_init_module+0x1708/0x18cc
 [<ffffffff802dbffb>] __kmalloc+0x0/0x134
 [<ffffffff8026080e>] system_call+0x7e/0x83


Code: 8b 59 44 83 fb ff 75 0c 8b 59 44 83 fb ff 0f 84 ed 00 00 00
RIP  [<ffffffff88169501>] :aacraid:aac_rkt_intr+0x1a/0x122
 RSP <ffffffff80716ef8>
CR2: ffffc20010084044
 <3>BUG: sleeping function called from invalid context at
kernel/rwsem.c:20
in_atomic():1, irqs_disabled():1

Call Trace:
 [<ffffffff8026ebcd>] show_trace+0xae/0x336
 [<ffffffff8026ee6a>] dump_stack+0x15/0x17
 [<ffffffff8020badb>] __might_sleep+0xb2/0xb4
 [<ffffffff802a6226>] down_read+0x1d/0x4a
 [<ffffffff8029e091>] blocking_notifier_call_chain+0x1b/0x41
 [<ffffffff80294329>] profile_task_exit+0x15/0x17
 [<ffffffff80215cd7>] do_exit+0x24/0x911
 [<ffffffff8026a2ff>] do_page_fault+0x7ba/0x842
 [<ffffffff80261591>] error_exit+0x0/0x96
DWARF2 unwinder stuck at error_exit+0x0/0x96
Leftover inexact backtrace:
 <IRQ> [<ffffffff802c238e>] __do_IRQ+0x4c/0x114
 [<ffffffff88169501>] :aacraid:aac_rkt_intr+0x1a/0x122
 [<ffffffff80211475>] handle_IRQ_event+0x2c/0x64
 [<ffffffff802c23f1>] __do_IRQ+0xaf/0x114
 [<ffffffff80278c61>] do_flush_tlb_all+0x0/0x87
 [<ffffffff802700a1>] do_IRQ+0xf8/0x107
 [<ffffffff80260d46>] ret_from_intr+0x0/0xf
 <EOI> [<ffffffff80278c61>] do_flush_tlb_all+0x0/0x87
 [<ffffffff80295c57>] on_each_cpu+0x2d/0x36
 [<ffffffff80278f4b>] flush_tlb_all+0x1c/0x1e
 [<ffffffff8025457b>] unmap_vm_area+0x1d4/0x276
 [<ffffffff80201c20>] init_level4_pgt+0xc20/0x1000
 [<ffffffff802d1973>] __remove_vm_area+0x2c/0x44
 [<ffffffff802d19ab>] remove_vm_area+0x20/0x36
 [<ffffffff802840a1>] iounmap+0x8e/0xce
 [<ffffffff88166684>] :aacraid:aac_init_adapter+0xcc/0x674
 [<ffffffff88169857>] :aacraid:aac_rkt_init+0x15d/0x250
 [<ffffffff88162a47>] :aacraid:aac_probe_one+0x209/0x4c6
 [<ffffffff8035ce4f>] pci_device_probe+0x106/0x186
 [<ffffffff8028e73f>] default_wake_function+0x0/0xf
 [<ffffffff803bf972>] driver_probe_device+0x5c/0xb1
 [<ffffffff803bfadc>] __driver_attach+0x89/0xdb
 [<ffffffff803bfa53>] __driver_attach+0x0/0xdb
 [<ffffffff803bf324>] bus_for_each_dev+0x49/0x7a
 [<ffffffff803bf89c>] driver_attach+0x1c/0x1e
 [<ffffffff803bef3c>] bus_add_driver+0x89/0x138
 [<ffffffff803bfd87>] driver_register+0x8f/0x93
 [<ffffffff8035d051>] __pci_register_driver+0x63/0x85
 [<ffffffff8817c033>] :aacraid:aac_init+0x33/0x6e
 [<ffffffff802afc95>] sys_init_module+0x1708/0x18cc
 [<ffffffff802dbffb>] __kmalloc+0x0/0x134
 [<ffffffff8026080e>] system_call+0x7e/0x83

BUG: warning at kernel/lockdep.c:1816/trace_hardirqs_on() (Not tainted)

Call Trace:
 [<ffffffff8026ebcd>] show_trace+0xae/0x336
 [<ffffffff8026ee6a>] dump_stack+0x15/0x17
 [<ffffffff802a83b3>] trace_hardirqs_on+0xbc/0x13d
 [<ffffffff80267e32>] _spin_unlock_irq+0x2b/0x31
 [<ffffffff80267491>] __down_read+0x3d/0xa1
 [<ffffffff802a624f>] down_read+0x46/0x4a
 [<ffffffff8029e091>] blocking_notifier_call_chain+0x1b/0x41
 [<ffffffff80294329>] profile_task_exit+0x15/0x17
 [<ffffffff80215cd7>] do_exit+0x24/0x911
 [<ffffffff8026a2ff>] do_page_fault+0x7ba/0x842
 [<ffffffff80261591>] error_exit+0x0/0x96
DWARF2 unwinder stuck at error_exit+0x0/0x96
Leftover inexact backtrace:
 <IRQ> [<ffffffff802c238e>] __do_IRQ+0x4c/0x114
 [<ffffffff88169501>] :aacraid:aac_rkt_intr+0x1a/0x122
 [<ffffffff80211475>] handle_IRQ_event+0x2c/0x64
 [<ffffffff802c23f1>] __do_IRQ+0xaf/0x114
 [<ffffffff80278c61>] do_flush_tlb_all+0x0/0x87
 [<ffffffff802700a1>] do_IRQ+0xf8/0x107
 [<ffffffff80260d46>] ret_from_intr+0x0/0xf
 <EOI> [<ffffffff80278c61>] do_flush_tlb_all+0x0/0x87
 [<ffffffff80295c57>] on_each_cpu+0x2d/0x36
 [<ffffffff80278f4b>] flush_tlb_all+0x1c/0x1e
 [<ffffffff8025457b>] unmap_vm_area+0x1d4/0x276
 [<ffffffff80201c20>] init_level4_pgt+0xc20/0x1000
 [<ffffffff802d1973>] __remove_vm_area+0x2c/0x44
 [<ffffffff802d19ab>] remove_vm_area+0x20/0x36
 [<ffffffff802840a1>] iounmap+0x8e/0xce
 [<ffffffff88166684>] :aacraid:aac_init_adapter+0xcc/0x674
 [<ffffffff88169857>] :aacraid:aac_rkt_init+0x15d/0x250
 [<ffffffff88162a47>] :aacraid:aac_probe_one+0x209/0x4c6
 [<ffffffff8035ce4f>] pci_device_probe+0x106/0x186
 [<ffffffff8028e73f>] default_wake_function+0x0/0xf
 [<ffffffff803bf972>] driver_probe_device+0x5c/0xb1
 [<ffffffff803bfadc>] __driver_attach+0x89/0xdb
 [<ffffffff803bfa53>] __driver_attach+0x0/0xdb
 [<ffffffff803bf324>] bus_for_each_dev+0x49/0x7a
 [<ffffffff803bf89c>] driver_attach+0x1c/0x1e
 [<ffffffff803bef3c>] bus_add_driver+0x89/0x138
 [<ffffffff803bfd87>] driver_register+0x8f/0x93
 [<ffffffff8035d051>] __pci_register_driver+0x63/0x85
 [<ffffffff8817c033>] :aacraid:aac_init+0x33/0x6e
 [<ffffffff802afc95>] sys_init_module+0x1708/0x18cc
 [<ffffffff802dbffb>] __kmalloc+0x0/0x134
 [<ffffffff8026080e>] system_call+0x7e/0x83

Kernel panic - not syncing: Aiee, killing interrupt handler!
 BUG: warning at kernel/panic.c:137/panic() (Not tainted)

Call Trace:
 [<ffffffff8026ebcd>] show_trace+0xae/0x336
 [<ffffffff8026ee6a>] dump_stack+0x15/0x17
 [<ffffffff80292f79>] panic+0x202/0x213
 [<ffffffff80215d48>] do_exit+0x95/0x911
 [<ffffffff8026a2ff>] do_page_fault+0x7ba/0x842
 [<ffffffff80261591>] error_exit+0x0/0x96
DWARF2 unwinder stuck at error_exit+0x0/0x96
Leftover inexact backtrace:
 <IRQ> [<ffffffff802c238e>] __do_IRQ+0x4c/0x114
 [<ffffffff88169501>] :aacraid:aac_rkt_intr+0x1a/0x122
 [<ffffffff80211475>] handle_IRQ_event+0x2c/0x64
 [<ffffffff802c23f1>] __do_IRQ+0xaf/0x114
 [<ffffffff80278c61>] do_flush_tlb_all+0x0/0x87
 [<ffffffff802700a1>] do_IRQ+0xf8/0x107
 [<ffffffff80260d46>] ret_from_intr+0x0/0xf
 <EOI> [<ffffffff80278c61>] do_flush_tlb_all+0x0/0x87
 [<ffffffff80295c57>] on_each_cpu+0x2d/0x36
 [<ffffffff80278f4b>] flush_tlb_all+0x1c/0x1e
 [<ffffffff8025457b>] unmap_vm_area+0x1d4/0x276
 [<ffffffff80201c20>] init_level4_pgt+0xc20/0x1000
 [<ffffffff802d1973>] __remove_vm_area+0x2c/0x44
 [<ffffffff802d19ab>] remove_vm_area+0x20/0x36
 [<ffffffff802840a1>] iounmap+0x8e/0xce
 [<ffffffff88166684>] :aacraid:aac_init_adapter+0xcc/0x674
 [<ffffffff88169857>] :aacraid:aac_rkt_init+0x15d/0x250
 [<ffffffff88162a47>] :aacraid:aac_probe_one+0x209/0x4c6
 [<ffffffff8035ce4f>] pci_device_probe+0x106/0x186
 [<ffffffff8028e73f>] default_wake_function+0x0/0xf
 [<ffffffff803bf972>] driver_probe_device+0x5c/0xb1
 [<ffffffff803bfadc>] __driver_attach+0x89/0xdb
 [<ffffffff803bfa53>] __driver_attach+0x0/0xdb
 [<ffffffff803bf324>] bus_for_each_dev+0x49/0x7a
 [<ffffffff803bf89c>] driver_attach+0x1c/0x1e
 [<ffffffff803bef3c>] bus_add_driver+0x89/0x138
 [<ffffffff803bfd87>] driver_register+0x8f/0x93
 [<ffffffff8035d051>] __pci_register_driver+0x63/0x85
 [<ffffffff8817c033>] :aacraid:aac_init+0x33/0x6e
 [<ffffffff802afc95>] sys_init_module+0x1708/0x18cc
 [<ffffffff802dbffb>] __kmalloc+0x0/0x134
 [<ffffffff8026080e>] system_call+0x7e/0x83

On Thu, 2006-09-28 at 09:06 -0400, Salyzyn, Mark wrote:
> I look forward to seeing them.
> 
> Please report them to the scsi list as well.
> 
> Sincerely -- Mark Salyzyn
> 
> > -----Original Message-----
> > From: linux-kernel-owner@vger.kernel.org 
> > [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Sean Bruno
> > Sent: Wednesday, September 27, 2006 10:47 PM
> > To: linux-kernel@vger.kernel.org
> > Subject: [aacraid] Adaptec 2820SA Crash
> > 
> > 
> > I noted that the aacraid module under 2.6.18 is crashing pretty hard
> > under 2.6.18
> > 
> > Anyone working on that?  I'll send more detail in the AM with serial
> > console captures and dump information.
> > 
> > Sean
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe 
> > linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 

