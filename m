Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314141AbSDVMoJ>; Mon, 22 Apr 2002 08:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314143AbSDVMoI>; Mon, 22 Apr 2002 08:44:08 -0400
Received: from zero.tech9.net ([209.61.188.187]:14854 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S314141AbSDVMoH>;
	Mon, 22 Apr 2002 08:44:07 -0400
Subject: Re: [PATCHSET] Linux 2.4.19-pre7-jam4
From: Robert Love <rml@tech9.net>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Norbert Kiesel <nkiesel@tbdnetworks.com>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20020422074013.GA7294@werewolf.able.es>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 22 Apr 2002 08:44:01 -0400
Message-Id: <1019479445.940.4.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-04-22 at 03:40, J.A. Magallon wrote:

> >1) sched.c complains about missing local_bh_count, TQUEUE_BH, ...

you need to #include linux/interrupts.h in sched.c

> Yup, there are files not covered by 20-sched-O1-rml-1.
> Fast search:
> 
> werewolf:/usr/src/linux# grep -r SCHED_YIELD *
> arch/alpha/mm/fault.c:          current->policy |= SCHED_YIELD;
> arch/mips/mm/fault.c:           tsk->policy |= SCHED_YIELD;
> arch/ppc/mm/fault.c:            current->policy |= SCHED_YIELD;
> arch/m68k/mm/fault.c:           current->policy |= SCHED_YIELD;
> arch/arm/mm/fault-common.c:     tsk->policy |= SCHED_YIELD;
> arch/sh/mm/fault.c:             current->policy |= SCHED_YIELD;
> arch/ia64/mm/fault.c:           current->policy |= SCHED_YIELD;
> arch/mips64/mm/fault.c:         tsk->policy |= SCHED_YIELD;
> arch/s390/mm/fault.c:           tsk->policy |= SCHED_YIELD;
> arch/s390x/mm/fault.c:          tsk->policy |= SCHED_YIELD;
> init/do_mounts.c:                       current->policy |= SCHED_YIELD;

I did not touch the arch-dependent code because there are other changes
the arches require that need to be made ...

	Robert Love

