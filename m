Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264814AbSJaKjl>; Thu, 31 Oct 2002 05:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264820AbSJaKjk>; Thu, 31 Oct 2002 05:39:40 -0500
Received: from mail.scram.de ([195.226.127.117]:25797 "EHLO mail.scram.de")
	by vger.kernel.org with ESMTP id <S264814AbSJaKjj>;
	Thu, 31 Oct 2002 05:39:39 -0500
Date: Thu, 31 Oct 2002 11:40:15 +0100 (CET)
From: Jochen Friedrich <jochen@scram.de>
X-X-Sender: jochen@gfrw1044.bocc.de
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.45
In-Reply-To: <Pine.LNX.4.44.0210301651120.6719-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.44.0210311138490.7997-100000@gfrw1044.bocc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

2.4.45 compile on Alpha fails:

  gcc -Wp,-MD,arch/alpha/kernel/.irq_alpha.o.d -D__KERNEL__ -Iinclude
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mno-fp-regs -ffixed-8 -mcpu=ev5
-Wa,-mev6 -nostdinc -iwithprefix include    -DKBUILD_BASENAME=irq_alpha
-c -o arch/alpha/kernel/irq_alpha.o arch/alpha/kernel/irq_alpha.c
In file included from arch/alpha/kernel/irq_alpha.c:15:
arch/alpha/kernel/irq_impl.h: In function `alpha_do_profile':
arch/alpha/kernel/irq_impl.h:50: `prof_buffer' undeclared (first use in
this function)
arch/alpha/kernel/irq_impl.h:50: (Each undeclared identifier is reported
only once
arch/alpha/kernel/irq_impl.h:50: for each function it appears in.)
arch/alpha/kernel/irq_impl.h:61: `prof_shift' undeclared (first use in
this function)
arch/alpha/kernel/irq_impl.h:67: `prof_len' undeclared (first use in this
function)
make[1]: *** [arch/alpha/kernel/irq_alpha.o] Error 1
make: *** [arch/alpha/kernel] Error 2

--jochen

