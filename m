Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273604AbRIUQ7C>; Fri, 21 Sep 2001 12:59:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273620AbRIUQ6w>; Fri, 21 Sep 2001 12:58:52 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:42757 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S273604AbRIUQ6h>; Fri, 21 Sep 2001 12:58:37 -0400
Subject: Re: spurious interrupt with ac kernel but not with vanilla 2.4.9
To: kernel@Expansa.sns.it (Luigi Genoni)
Date: Fri, 21 Sep 2001 18:03:56 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <Pine.LNX.4.33.0109211828390.31425-100000@Expansa.sns.it> from "Luigi Genoni" at Sep 21, 2001 06:39:05 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15kTiW-0000X2-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I noticed that on the abit kt7A MBs that i have, with via KT133A chipset,
> after i installed the kernel 2.4.9-ac10 (ac11 and 12 as well),
> at boot i get this message,
> 
> Sep 21 11:52:11 DarkStar kernel: ice 00:0b.0
> Sep 21 11:52:11 DarkStar kernel: spurious 8259A interrupt: IRQ7.
>  immediatelly before scsi adaptec detection and inizzializzation.

Thats indicating an IRQ appeared and vanished. IRQ 7 is the IRQ that happens
to occur for this.

> I was thinking to an HW problem, but with vanilla 2.4.9 kernel I do not
> get this message, and the code in arch/i386/kernel/i8259.c that should
> detect this spurious interrup is just the same on those two kernels.
> Changes are related to X86_IO_APIC, and I think this is the reason why
> this spurious interrupt is detected, but I would like to know if i should
> think I have some HW problem going on that stardard kernels do not detect.

The APIC only applies to multiprocessor boxes unless you are building with
uniprocessor apic support. Build a non SMP kernel without apic support
and let me know what that does
