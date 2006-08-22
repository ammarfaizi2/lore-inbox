Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751109AbWHVLu3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbWHVLu3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 07:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbWHVLu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 07:50:29 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:2312 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751109AbWHVLu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 07:50:28 -0400
Date: Tue, 22 Aug 2006 13:50:28 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jan Beulich <jbeulich@novell.com>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: 2.6.18-rc4-mm2: x86_64 compile error
Message-ID: <20060822115028.GV11651@stusta.de>
References: <20060819220008.843d2f64.akpm@osdl.org> <20060821212140.GN11651@stusta.de> <44EAD869.76E4.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44EAD869.76E4.0078.0@novell.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2006 at 10:11:53AM +0200, Jan Beulich wrote:
> >>> Adrian Bunk <bunk@stusta.de> 21.08.06 23:21 >>>
> >On Sat, Aug 19, 2006 at 10:00:08PM -0700, Andrew Morton wrote:
> >>...
> >> Changes since 2.6.18-rc4-mm1:
> >>...
> >> +x86_64-mm-fix-x86-cpuid-keys-used-in-alternative_smp.patch
> >>...
> >>  x86_64 tree updates
> >>...
> >
> >This patch causes the following compile error (cross compiling from i386 
> >using gcc 4.1):
> >
> ><--  snip  -->
> >
> >...
> >  LD      .tmp_vmlinux1
> >kernel/built-in.o:(.smp_altinstructions+0x10): undefined reference to `X86_FEATURE_UP'
> >kernel/built-in.o:(.smp_altinstructions+0x28): undefined reference to `X86_FEATURE_UP'
> >kernel/built-in.o:(.smp_altinstructions+0x40): undefined reference to `X86_FEATURE_UP'
> >kernel/built-in.o:(.smp_altinstructions+0x58): undefined reference to `X86_FEATURE_UP'
> >make[1]: *** [.tmp_vmlinux1] Error 1
> 
> Odd - asm/cpufeature.h is being included by asm/processor.h, which is included by
> linux/sched.h, which in turn I would have assumed is included by virtually everything.
> The simply solution would be to explicitly include it from asm/alternative.h - could you
> give that a try? Regardless of that I'd be curious what source file under kernel/ (and
> perhaps with what .config) neither includes linux/sched.h nor asm/processor.h.

I was using defconfig.

I don't know whether looking at this bug makes muh sense since Andi said 
he already has a patch queued to fix it.

> Jan

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

