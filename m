Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbTJHPik (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 11:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbTJHPik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 11:38:40 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:6086 "EHLO smtp.bitmover.com")
	by vger.kernel.org with ESMTP id S261684AbTJHPih (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 11:38:37 -0400
Date: Wed, 8 Oct 2003 08:38:32 -0700
From: Larry McVoy <lm@bitmover.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, bcollins@debian.org
Subject: Re: bkcvs problems?
Message-ID: <20031008153832.GA9561@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>, bcollins@debian.org
References: <20031007191433.GA683@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031007191433.GA683@elf.ucw.cz>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.3,
	required 7, AWL)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed.  Ben, please check the SVN tree to see if it is OK.  I suspect
it is, I believe that the problem was a screwed up ssh key so the CVS
archive on kernel.bkbits.net was not getting updated.

On Tue, Oct 07, 2003 at 09:14:35PM +0200, Pavel Machek wrote:
> Hi!
> 
> According to bkbits, andi's cpufreq changes are in:
> 
> http://linus.bkbits.net:8080/linux-2.5/patch@1.1480?nav=index.html|ChangeSet@-1d|cset@1.1480
> ....
> diff -Nru a/arch/x86_64/kernel/Makefile b/arch/x86_64/kernel/Makefile
> --- a/arch/x86_64/kernel/Makefile	Fri Sep 26 06:53:37 2003
> +++ b/arch/x86_64/kernel/Makefile	Sun Oct  5 13:31:26 2003
> @@ -26,3 +26,5 @@
>  
>  bootflag-y			+= ../../i386/kernel/bootflag.o
>  cpuid-$(CONFIG_X86_CPUID)	+= ../../i386/kernel/cpuid.o
> +
> +obj-$(CONFIG_CPU_FREQ)	+=	cpufreq/
> ....
> 
> but bkcvs thinks otherwise:
> 
> head	1.26;
> access;
> symbols;
> locks; strict;
> comment	@# @;
> expand	@o@;
> 
> 
> 1.26
> date	2003.09.26.15.56.18;	author ak;	state Exp;
> branches;
> next	1.25;
> ...
> 1.26
> log
> @Another small x86-64 merge
> 
> (Logical change 1.13489)
> @
> text
> @#
> # Makefile for the linux kernel.
> #
> 
> extra-y 	:= head.o head64.o init_task.o vmlinux.lds.s
> EXTRA_AFLAGS	:= -traditional
> obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o \
> 		ptrace.o i8259.o ioport.o ldt.o setup.o time.o sys_x86_64.o \
> 		x8664_ksyms.o i387.o syscall.o vsyscall.o \
> 		setup64.o bluesmoke.o bootflag.o e820.o reboot.o warmreboot.o
> 
> obj-$(CONFIG_MTRR)		+= ../../i386/kernel/cpu/mtrr/
> obj-$(CONFIG_ACPI)		+= acpi/
> obj-$(CONFIG_X86_MSR)		+= msr.o
> obj-$(CONFIG_X86_CPUID)		+= cpuid.o
> obj-$(CONFIG_SMP)		+= smp.o smpboot.o trampoline.o
> obj-$(CONFIG_X86_LOCAL_APIC)	+= apic.o  nmi.o
> obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o mpparse.o
> obj-$(CONFIG_PM)		+= suspend.o
> obj-$(CONFIG_SOFTWARE_SUSPEND)	+= suspend_asm.o
> obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
> obj-$(CONFIG_GART_IOMMU)	+= pci-gart.o aperture.o
> obj-$(CONFIG_DUMMY_IOMMU)	+= pci-nommu.o pci-dma.o
> 
> obj-$(CONFIG_MODULES)		+= module.o
> 
> bootflag-y			+= ../../i386/kernel/bootflag.o
> cpuid-$(CONFIG_X86_CPUID)	+= ../../i386/kernel/cpuid.o
> @
> ....
> 
> (Of course, I initally tried with simple cvs update, then I killed
> whole tree and did cvs update, but that did not help. I did bk sync
> five minutes ago, just to be sure, but it did not help).
> 
> 								Pavel
> 
> -- 
> When do you have a heart between your knees?
> [Johanka's followup: and *two* hearts?]

-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
