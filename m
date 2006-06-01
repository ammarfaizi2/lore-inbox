Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964831AbWFAJwm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964831AbWFAJwm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 05:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964834AbWFAJwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 05:52:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39113 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964831AbWFAJwl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 05:52:41 -0400
Date: Thu, 1 Jun 2006 02:56:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>
Subject: Re: 2.6.17-rc5-mm2
Message-Id: <20060601025632.6683041e.akpm@osdl.org>
In-Reply-To: <447EB4AD.4060101@reub.net>
References: <20060601014806.e86b3cc0.akpm@osdl.org>
	<447EB4AD.4060101@reub.net>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Jun 2006 21:34:37 +1200
Reuben Farrelly <reuben-lkml@reub.net> wrote:

> 
> 
> On 1/06/2006 8:48 p.m., Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc5/2.6.17-rc5-mm2/
> > 
> > 
> > - A cfq bug was fixed in mainline, so the git-cfq tree has been restored.
> > 
> > - Various lock-validator and genirq fixes have been added.  Should be
> >   slightly less oopsy than 2.6.17-rc5-mm1.
> > 
> > - I just realised that I've been accidentally not updating the PCI tree for
> >   a while.  Will be restored in next -mm.
> > 
> > - Has been booted and has passed various stress-tests on quad x86_64,
> >   quad ancient-Xeon, quad power4, quad ia64, dual old-PIII and a modern
> >   pentium-M laptop.  So if it breaks, it's your fault.
> 
> What an optimist if ever I've seen one ;)

Dammit.

> ...
>
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> ICH7: IDE controller at PCI slot 0000:00:1f.1
> ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 177
> ICH7: chipset revision 1
> ICH7: not 100% native mode: will probe irqs later
>      ide0: BM-DMA at 0x30b0-0x30b7, BIOS settings: hda:DMA, hdb:pio
> hda: PIONEER DVD-RW DVR-111D, ATAPI CD/DVD-ROM drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ACPI (acpi_bus-0192): Device `IDES]is not power manageable [20060310]
> ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 185
> ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA mode
> ahci 0000:00:1f.2: flags: 64bit ncq led clo pio slum part
> ata1: SATA max UDMA/133 cmd 0xFFFFC20000016100 ctl 0x0 bmdma 0x0 irq 58
> ata2: SATA max UDMA/133 cmd 0xFFFFC20000016180 ctl 0x0 bmdma 0x0 irq 58
> ata3: SATA max UDMA/133 cmd 0xFFFFC20000016200 ctl 0x0 bmdma 0x0 irq 58

I assume you're using the ahci driver here.

> ata4: SATA max UDMA/133 cmd 0xFFFFC20000016280 ctl 0x0 bmdma 0x0 irq 58
> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> Unable to handle kernel NULL pointer dereference at 0000000000000000 RIP:
>   [<0000000000000000>]
> PGD 0
> Oops: 0010 [1] SMP
> last sysfs file:
> CPU 0
> Modules linked in:
> Pid: 0, comm: idle Not tainted 2.6.17-rc5-mm2 #2
> RIP: 0010:[<0000000000000000>]  [<0000000000000000>]
> RSP: 0000:ffffffff80660f98  EFLAGS: 00010006
> RAX: 0000000000003a00 RBX: ffffffff8090dec8 RCX: 0000000000000000
> RDX: ffffffff8090dec8 RSI: ffffffff808fe100 RDI: 000000000000003a
> RBP: ffffffff80660fb0 R08: 0000000000000001 R09: ffffffff802676aa
> R10: 0000000000000000 R11: 0000000000000000 R12: 000000000000003a
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffffffff808fa000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
> CR2: 0000000000000000 CR3: 0000000000201000 CR4: 00000000000006e0
> Process idle (pid: 0, threadinfo ffffffff8090c000, task ffffffff80593760)
> Stack: ffffffff80270132 ffffffff8025dbb1 ffffffff8094e084 ffffffff8090def0
>         ffffffff802641a9  <EOI> ff6500005d4be8fa 65c900000020250c 00000010250c8b48
>         f700001fd8e98148 7400000003582444
> Call Trace:
> 

And we did a jump-to-zero.  I'm suspecting the sata changes.

Is this the mysterious missing ->mode_filter, perhaps?  I don't think so -
we test for null there.

Should ahci.c have a data_xfer vector?  Right now it's left at NULL.

> 
> Code:  Bad RIP value.
> RIP  [<0000000000000000>] RSP <ffffffff80660f98>
> CR2: 0000000000000000
>   <0>Kernel panic - not syncing: Aiee, killing interrupt handler!
>   BUG: warning at kernel/lockdep.c:1853/trace_hardirqs_on()
> 
> Call Trace:
>    [<ffffffff8026e6ed>] show_trace+0xad/0x225
>          [<ffffffff8026e87a>] dump_stack+0x15/0x1b  [<ffffffff802a05da>] 
> trace_hardirqs_on+0xa1/0x124
>          [<ffffffff80276fec>] smp_send_stop+0x4c/0x68
>          [<ffffffff8028a491>] panic+0xa7/0x220  [<ffffffff80216376>] 
> do_exit+0x74/0x94f
>          [<ffffffff8020b195>] do_page_fault+0x895/0x9c4
>          [<ffffffff802649dd>] error_exit+0x0/0x8e
> Rebooting in 60 seconds..BUG: warning at kernel/panic.c:114/panic()
> 

And here we collapsed instead of generating a backtrace.  Both Ingo and the
x86_64 guys have been playing with the backtrace code.

> 
> Hardware posted at http://www.reub.net/files/kernel/system-hardware

A .config would be useful too.

> Box has MSI capabilities and MSI compiled in.
> 

Hopefully MSI is fixed now.

