Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266678AbUHSQrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266678AbUHSQrR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 12:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266680AbUHSQrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 12:47:16 -0400
Received: from web21323.mail.yahoo.com ([216.136.175.209]:41578 "HELO
	web21323.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266678AbUHSQrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 12:47:14 -0400
Message-ID: <20040819164713.9973.qmail@web21323.mail.yahoo.com>
Date: Thu, 19 Aug 2004 09:47:13 -0700 (PDT)
From: Matthew Frost <artusemrys@sbcglobal.net>
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P4
To: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Cc: Thomas Charbonnel <thomas@undata.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Lee Revell <rlrevell@joe-job.com>
In-Reply-To: <20040819073247.GA1798@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Ingo Molnar <mingo@elte.hu> wrote: 
> i've uploaded the -P4 patch:
> 
>  
> http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8.1-P4
> 
> the main change is a more robust latency tracer - the previous one was
> not 100% correct for interrupts. People who have exprienced those weird
> ~1msec latencies in the idle task please re-check and re-post latency
> traces.

I receive the following errors on compile, after make has gotten through
building all config options:

-- SNIP --

  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
arch/i386/kernel/built-in.o(.text+0x398e): In function `do_nmi':
: undefined reference to `__trace'
arch/i386/kernel/built-in.o(.text+0x4101): In function `do_IRQ':
: undefined reference to `__trace'
arch/i386/kernel/built-in.o(.text+0xe1e9): In function
`smp_apic_timer_interrupt':
: undefined reference to `__trace'
arch/i386/mm/built-in.o(.text+0x71b): In function `do_page_fault':
: undefined reference to `__trace'
make: *** [.tmp_vmlinux1] Error 1


-P2 and -P3 gave me the same errors except for
`smp_apic_timer_interrupt'.
I have tried my .config, default, allyes, and allno, and I get the same
result regardless of config.  Tree is fresh, patch applied with -Np1
<../[patchname].  I also get fuzz and offsets, but they don't seem to
bear on the problem directly.  I'm currently running -P1, which doesn't
have this problem.  gcc is 3.3.4.

With thanks for a smoother system feel,
Matthew Frost
artusemrys at sbcglobal dot net
