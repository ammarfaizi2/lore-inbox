Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273635AbRIURPG>; Fri, 21 Sep 2001 13:15:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273626AbRIUROq>; Fri, 21 Sep 2001 13:14:46 -0400
Received: from Expansa.sns.it ([192.167.206.189]:10255 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S273635AbRIUROg>;
	Fri, 21 Sep 2001 13:14:36 -0400
Date: Fri, 21 Sep 2001 19:14:58 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: spurious interrupt with ac kernel but not with vanilla 2.4.9
In-Reply-To: <E15kTiW-0000X2-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0109211905530.31425-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 21 Sep 2001, Alan Cox wrote:

> > I noticed that on the abit kt7A MBs that i have, with via KT133A chipset,
> > after i installed the kernel 2.4.9-ac10 (ac11 and 12 as well),
> > at boot i get this message,
> >
> > Sep 21 11:52:11 DarkStar kernel: ice 00:0b.0
> > Sep 21 11:52:11 DarkStar kernel: spurious 8259A interrupt: IRQ7.
> >  immediatelly before scsi adaptec detection and inizzializzation.
>
> Thats indicating an IRQ appeared and vanished. IRQ 7 is the IRQ that happens
> to occur for this.
>
> > I was thinking to an HW problem, but with vanilla 2.4.9 kernel I do not
> > get this message, and the code in arch/i386/kernel/i8259.c that should
> > detect this spurious interrup is just the same on those two kernels.
> > Changes are related to X86_IO_APIC, and I think this is the reason why
> > this spurious interrupt is detected, but I would like to know if i should
> > think I have some HW problem going on that stardard kernels do not detect.
>
> The APIC only applies to multiprocessor boxes unless you are building with
> uniprocessor apic support. Build a non SMP kernel without apic support
> and let me know what that does

yes, i was using a non SMP kernel with both apic and io_apic support
enabled.

actally:

with APIC support
and
without IO_APIC support

I do not get this message again, but I am so sorry, because my processor
has integrated APIC support.

I just made another test on a dual Athlon 1200 Mhz per CPU on an MB with
AMD chipset, and here this problem does not appear.

Thanx

Luigi


