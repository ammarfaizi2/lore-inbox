Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263298AbSITR1c>; Fri, 20 Sep 2002 13:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263310AbSITR1b>; Fri, 20 Sep 2002 13:27:31 -0400
Received: from waste.org ([209.173.204.2]:57032 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S263298AbSITR02>;
	Fri, 20 Sep 2002 13:26:28 -0400
Date: Fri, 20 Sep 2002 12:31:32 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.37
Message-ID: <20020920173132.GE15627@waste.org>
References: <Pine.LNX.4.33.0209200840320.2721-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0209200840320.2721-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2002 at 08:45:04AM -0700, Linus Torvalds wrote:
> 
> Lots of stuff all over the map.  Arch updates (ppc*, sparc*, x86 machine
> reorg), VM merges from Andrew, ACPI updates, BIO layer updates,
> networking, driverfs, build process, pid hash, you name it it's there.

Something with APIC handling went south. 

# CONFIG_SMP is not set
CONFIG_PREEMPT=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y

  ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s arch/i386/kernel/head.o arch/i386/kernel/init_task.o  init/built-in.o --start-group  arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o  arch/i386/mach-generic/built-in.o kernel/built-in.o mm/built-in.o fs/built-in.o ipc/built-in.o security/built-in.o  lib/lib.a  arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o  net/built-in.o --end-group -o vmlinux
arch/i386/kernel/built-in.o: In function `disconnect_bsp_APIC':
arch/i386/kernel/built-in.o(.text+0xd4b2): undefined reference to `pic_mode'
arch/i386/kernel/built-in.o: In function `clear_IO_APIC':
arch/i386/kernel/built-in.o(.text+0xe213): undefined reference to `nr_ioapics'
arch/i386/kernel/built-in.o(.text+0xe254): undefined reference to `nr_ioapics'
arch/i386/kernel/built-in.o: In function `IO_APIC_get_PCI_irq_vector':
arch/i386/kernel/built-in.o(.text+0xe315): undefined reference to `mp_bus_id_to_pci_bus'
arch/i386/kernel/built-in.o(.text+0xe32a): undefined reference to `mp_irq_entries'

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
