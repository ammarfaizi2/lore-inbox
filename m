Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265492AbUHSLVe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265492AbUHSLVe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 07:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265383AbUHSLVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 07:21:33 -0400
Received: from mail.gmx.de ([213.165.64.20]:57323 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265301AbUHSLRg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 07:17:36 -0400
X-Authenticated: #4399952
Date: Thu, 19 Aug 2004 13:28:37 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Thomas Charbonnel <thomas@undata.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Lee Revell <rlrevell@joe-job.com>
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P4
Message-Id: <20040819132837.2c5403f4@mango.fruits.de>
In-Reply-To: <20040819073247.GA1798@elte.hu>
References: <20040816033623.GA12157@elte.hu>
	<1092627691.867.150.camel@krustophenia.net>
	<20040816034618.GA13063@elte.hu>
	<1092628493.810.3.camel@krustophenia.net>
	<20040816040515.GA13665@elte.hu>
	<1092654819.5057.18.camel@localhost>
	<20040816113131.GA30527@elte.hu>
	<20040816120933.GA4211@elte.hu>
	<1092716644.876.1.camel@krustophenia.net>
	<20040817080512.GA1649@elte.hu>
	<20040819073247.GA1798@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Aug 2004 09:32:47 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> 
> i've uploaded the -P4 patch:
> 
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8.1-P4

Hi, this patch doesn't really apply cleanly. Do i need to worry about
the "fuzz" and the offsets?

flo

patch -p1 --dry-run < /home/tapas/downloads/voluntary-preempt-2.6.8.1-P4
patching file arch/i386/kernel/entry.S
patching file arch/i386/kernel/i386_ksyms.c
patching file arch/i386/kernel/i8259.c
patching file arch/i386/kernel/io_apic.c
patching file arch/i386/kernel/irq.c
Hunk #12 succeeded at 656 with fuzz 2.
patching file arch/i386/kernel/apic.c
patching file arch/i386/kernel/smp.c
patching file arch/i386/kernel/traps.c
patching file arch/i386/mm/fault.c
patching file arch/i386/Kconfig
patching file arch/i386/lib/usercopy.c
patching file arch/i386/mach-visws/setup.c
patching file arch/i386/mach-visws/visws_apic.c
patching file arch/i386/mach-voyager/setup.c
patching file arch/i386/boot/compressed/misc.c
patching file arch/i386/mach-default/setup.c
patching file include/asm-ppc64/uaccess.h
patching file include/asm-m68k/uaccess.h
patching file include/asm-parisc/uaccess.h
patching file include/asm-mips/uaccess.h
patching file include/asm-ppc/uaccess.h
patching file include/asm-x86_64/uaccess.h
patching file include/asm-ia64/uaccess.h
patching file include/linux/irq.h
patching file include/linux/sched.h
patching file include/linux/blkdev.h
patching file include/linux/buffer_head.h
patching file include/linux/interrupt.h
patching file include/linux/kernel.h
patching file include/linux/kernel_stat.h
patching file include/linux/pagemap.h
patching file include/linux/preempt.h
patching file include/linux/sysctl.h
patching file include/linux/writeback.h
patching file include/asm-m68knommu/uaccess.h
patching file include/asm-um/uaccess.h
patching file include/asm-arm/uaccess.h
patching file include/asm-sparc/uaccess.h
patching file include/asm-alpha/uaccess.h
patching file include/asm-h8300/uaccess.h
patching file include/asm-i386/irq.h
patching file include/asm-i386/checksum.h
patching file include/asm-i386/hardirq.h
patching file include/asm-i386/hw_irq.h
patching file include/asm-i386/io_apic.h
patching file include/asm-i386/signal.h
patching file include/asm-i386/uaccess.h
patching file include/asm-i386/system.h
patching file include/asm-s390/uaccess.h
patching file include/asm-cris/uaccess.h
patching file include/asm-sparc64/uaccess.h
patching file include/asm-arm26/uaccess.h
patching file include/asm-v850/uaccess.h
patching file include/asm-sh/uaccess.h
patching file include/asm-sh64/uaccess.h
patching file drivers/char/tty_io.c
patching file drivers/char/random.c
Hunk #1 succeeded at 947 (offset 5 lines).
patching file drivers/block/ll_rw_blk.c
Hunk #3 succeeded at 2400 (offset 1 line).
Hunk #4 succeeded at 2448 (offset 1 line).
Hunk #5 succeeded at 3065 (offset 3 lines).
Hunk #6 succeeded at 3132 (offset 3 lines).
patching file drivers/input/keyboard/atkbd.c
patching file drivers/input/mouse/psmouse-base.c
patching file drivers/ide/ide-io.c
patching file drivers/md/dm-table.c
patching file drivers/md/linear.c
patching file drivers/md/multipath.c
patching file drivers/md/raid0.c
patching file drivers/md/raid1.c
patching file fs/ext3/ialloc.c
patching file fs/ext3/inode.c
patching file fs/ext3/namei.c
patching file fs/ext3/super.c
patching file fs/proc/proc_misc.c
patching file fs/proc/task_mmu.c
patching file fs/jbd/checkpoint.c
patching file fs/jbd/commit.c
patching file fs/jbd/revoke.c
patching file fs/buffer.c
patching file fs/dcache.c
patching file fs/exec.c
patching file fs/file_table.c
patching file fs/fs-writeback.c
patching file fs/inode.c
patching file fs/select.c
patching file net/ipv4/route.c
patching file net/ipv4/tcp_minisocks.c
patching file net/core/dev.c
patching file net/core/sock.c
patching file kernel/Makefile
patching file kernel/exit.c
patching file kernel/hardirq.c
patching file kernel/kthread.c
patching file kernel/printk.c
patching file kernel/profile.c
patching file kernel/rcupdate.c
patching file kernel/sched.c
patching file kernel/softirq.c
patching file kernel/sysctl.c
patching file kernel/timer.c
patching file kernel/latency.c
patching file kernel/kallsyms.c
patching file mm/filemap.c
patching file mm/memory.c
patching file mm/mempool.c
patching file mm/mmap.c
patching file mm/slab.c
patching file mm/vmscan.c
patching file mm/msync.c
patching file init/Kconfig
patching file init/main.c
patching file Makefile
