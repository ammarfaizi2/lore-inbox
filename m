Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273519AbRIUQjL>; Fri, 21 Sep 2001 12:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273509AbRIUQjB>; Fri, 21 Sep 2001 12:39:01 -0400
Received: from Expansa.sns.it ([192.167.206.189]:25614 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S273499AbRIUQis>;
	Fri, 21 Sep 2001 12:38:48 -0400
Date: Fri, 21 Sep 2001 18:39:05 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: spurious interrupt with ac kernel but not with vanilla 2.4.9
In-Reply-To: <E15kSvj-0000Mb-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0109211828390.31425-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI,

I noticed that on the abit kt7A MBs that i have, with via KT133A chipset,
after i installed the kernel 2.4.9-ac10 (ac11 and 12 as well),
at boot i get this message,

Sep 21 11:52:11 DarkStar kernel: ice 00:0b.0
Sep 21 11:52:11 DarkStar kernel: spurious 8259A interrupt: IRQ7.
 immediatelly before scsi adaptec detection and inizzializzation.

doing a cat /proc/interrupt I can read

ERR:	1

As many people I have parport on irq 7, and the parport simply works
anyway (tested with a printer).

I was thinking to an HW problem, but with vanilla 2.4.9 kernel I do not
get this message, and the code in arch/i386/kernel/i8259.c that should
detect this spurious interrup is just the same on those two kernels.
Changes are related to X86_IO_APIC, and I think this is the reason why
this spurious interrupt is detected, but I would like to know if i should
think I have some HW problem going on that stardard kernels do not detect.

bests
Luigi



