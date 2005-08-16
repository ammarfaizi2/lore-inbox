Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932634AbVHPMAR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932634AbVHPMAR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 08:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932643AbVHPMAR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 08:00:17 -0400
Received: from odin2.bull.net ([192.90.70.84]:54686 "EHLO odin2.bull.net")
	by vger.kernel.org with ESMTP id S932634AbVHPMAP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 08:00:15 -0400
From: "Serge Noiraud" <serge.noiraud@bull.net>
To: Mr Machine <machinehasnoagenda@gmail.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: error compiling 2.6.13.rc6 with realtime-preempt patch -rt2 ('quirk_via_irq')
Date: Tue, 16 Aug 2005 14:02:56 +0200
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <4301D0F9.4050405@gmail.com>
In-Reply-To: <4301D0F9.4050405@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1252"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200508161402.57051.Serge.Noiraud@bull.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mardi 16 Août 2005 13:41, Mr Machine wrote/a écrit :
> i get this error during compile of pci drivers:
>
>    CC      drivers/pci/access.o
>    CC      drivers/pci/bus.o
>    CC      drivers/pci/probe.o
>    CC      drivers/pci/remove.o
>    CC      drivers/pci/pci.o
>    CC      drivers/pci/quirks.o
> drivers/pci/quirks.c: In function ‘quirk_via_irq’:
> drivers/pci/quirks.c:505: error: ‘vt8237_devfn’ undeclared (first use in
> this function)
> drivers/pci/quirks.c:505: error: (Each undeclared identifier is reported
> only once
> drivers/pci/quirks.c:505: error: for each function it appears in.)
> drivers/pci/quirks.c:506: error: ‘quirk_via_irq_not’ undeclared (first
> use in this function)
> make[2]: *** [drivers/pci/quirks.o] Error 1
> make[1]: *** [drivers/pci] Error 2
> make: *** [drivers] Error 2
> [mrmachine@localhost linux-2.6.12]$

I have the same problem with rt1 and rt2.

One 'bizarre' thing : If I patch directly 2.6.13.rc6 with the RT patch, I have 
an error on this driver with the first patch at 500 instead of 560!
Did we miss something ?
>
>
> if this helps, here's the realtime configuration section from my .config
> file:
>
> # CONFIG_LEGACY_TIMER is not set
> CONFIG_HPET_TIMER=y
> # CONFIG_HIGH_RES_TIMERS is not set
> CONFIG_HPET_EMULATE_RTC=y
> # CONFIG_SMP is not set
> # CONFIG_PREEMPT_NONE is not set
> # CONFIG_PREEMPT_VOLUNTARY is not set
> CONFIG_PREEMPT_DESKTOP=y
> # CONFIG_PREEMPT_RT is not set
> CONFIG_PREEMPT=y
> CONFIG_PREEMPT_SOFTIRQS=y
> CONFIG_PREEMPT_HARDIRQS=y
> # CONFIG_SPINLOCK_BKL is not set
> CONFIG_PREEMPT_BKL=y
> # CONFIG_PREEMPT_RCU is not set
> # CONFIG_RCU_TORTURE_TEST is not set
> CONFIG_ASM_SEMAPHORES=y
> CONFIG_RWSEM_XCHGADD_ALGORITHM=y
> # CONFIG_X86_UP_APIC is not set
>
>
> and from the pci driver section:
>
> #
> # Bus options (PCI, PCMCIA, EISA, MCA, ISA)
> #
> CONFIG_PCI=y
> # CONFIG_PCI_GOBIOS is not set
> # CONFIG_PCI_GOMMCONFIG is not set
> # CONFIG_PCI_GODIRECT is not set
> CONFIG_PCI_GOANY=y
> CONFIG_PCI_BIOS=y
> CONFIG_PCI_DIRECT=y
> # CONFIG_PCIEPORTBUS is not set
> # CONFIG_PCI_LEGACY_PROC is not set
> CONFIG_PCI_NAMES=y
> CONFIG_ISA_DMA_API=y
> # CONFIG_ISA is not set
> # CONFIG_MCA is not set
> # CONFIG_SCx200 is not set
>
> Please CC me on any replies.
>
> shayne
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
