Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268274AbUHFUAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268274AbUHFUAT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 16:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268269AbUHFUAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 16:00:18 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:57334 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S268277AbUHFT6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 15:58:17 -0400
Date: Fri, 6 Aug 2004 21:58:05 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.8-rc3-mm1: PROC_FS=n link errors
Message-ID: <20040806195804.GC2746@fs.tum.de>
References: <20040805031918.08790a82.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040805031918.08790a82.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2004 at 03:19:18AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.8-rc2-mm2:
>...
> +consolidate-prof_cpu_mask.patch
>...
> +profile_tick.patch
>...
> Consolidate a lot of the kernel profiling code.
>...

Theses patches cause the following link errors with CONFIG_PROC_FS=n:

<--  snip  -->

...
  LD      .tmp_vmlinux1
arch/i386/kernel/built-in.o(.text+0x45ce): In function `init_irq_proc':
: undefined reference to `create_prof_cpu_mask'
arch/i386/kernel/built-in.o(.text+0xfaf8): In function 
`smp_apic_timer_interrupt':
: undefined reference to `profile_tick'
arch/i386/kernel/built-in.o(.text+0xfc68): In function 
`smp_local_timer_interrupt':
: undefined reference to `profile_tick'
kernel/built-in.o(.sched.text+0x46): In function `schedule':
: undefined reference to `profile_hit'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

