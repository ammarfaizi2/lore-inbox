Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264622AbSKRSzC>; Mon, 18 Nov 2002 13:55:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264624AbSKRSzB>; Mon, 18 Nov 2002 13:55:01 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:27279 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S264622AbSKRSzB>; Mon, 18 Nov 2002 13:55:01 -0500
Date: Mon, 18 Nov 2002 14:01:58 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200211181901.gAIJ1wn10285@devserv.devel.redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] interrupt.h needs <asm/system.h>
In-Reply-To: <mailman.1037641141.13330.linux-kernel2news@redhat.com>
References: <mailman.1037641141.13330.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

><asm/system.h> is needed for smp_mb(). Apparently this definition is pulled in
> some other way on ia32.
> 
> --- linux-2.5.48/include/linux/interrupt.h	Mon Nov 18 10:04:00 2002
> +++ linux-m68k-2.5.48/include/linux/interrupt.h	Mon Nov 18 15:35:14 2002
> @@ -8,6 +8,7 @@
>  #include <asm/hardirq.h>
>  #include <asm/ptrace.h>
>  #include <asm/softirq.h>
> +#include <asm/system.h>
>  
>  struct irqaction {
>  	void (*handler)(int, void *, struct pt_regs *);

Geert's patch looks correct to me.

By the way, I am curious, why do we never comment why a header
was included, like so: "#include <asm/system.h> /* smp_mb */"?
I suspect people are afraid that the comments get stale.

-- Pete
