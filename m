Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267155AbTBLNhY>; Wed, 12 Feb 2003 08:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267156AbTBLNhY>; Wed, 12 Feb 2003 08:37:24 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:6381 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S267155AbTBLNhW>; Wed, 12 Feb 2003 08:37:22 -0500
Date: Wed, 12 Feb 2003 14:47:06 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Dominik Brodowski <linux@brodo.de>
Subject: 2.5.60-dj2: lonkhaul.c doesn't compile
Message-ID: <20030212134706.GH17128@fs.tum.de>
References: <20030211182256.GA28903@codemonkey.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030211182256.GA28903@codemonkey.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2003 at 06:22:56PM +0000, Dave Jones wrote:

>...
> 2.5.60-dj1
> - cpufreq updates.
>...
>   - Updates various core parts, and other cpufreq drivers.
>...

This broke the compilation of longhaul.c #ifdef CONFIG_CPU_FREQ_24_API:

<--  snip  -->

...
  gcc -Wp,-MD,arch/i386/kernel/cpu/cpufreq/.longhaul.o.d -D__KERNEL__ 
-Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing 
-fno-common -pipe -mpreferred-stack-boundary=2 -march=k6 
-Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    -DKBUILD_BASENAME=longhaul 
-DKBUILD_MODNAME=longhaul -c -o arch/i386/kernel/cpu/cpufreq/longhaul.o 
arch/i386/kernel/cpu/cpufreq/longhaul.c
arch/i386/kernel/cpu/cpufreq/longhaul.c: In function `longhaul_cpu_init':
arch/i386/kernel/cpu/cpufreq/longhaul.c:644: `longhaul_driver' undeclared (first use in this function)
arch/i386/kernel/cpu/cpufreq/longhaul.c:644: (Each undeclared identifier is reported only once
arch/i386/kernel/cpu/cpufreq/longhaul.c:644: for each function it appears in.)
arch/i386/kernel/cpu/cpufreq/longhaul.c: At top level:
arch/i386/kernel/cpu/cpufreq/longhaul.c:650: `longhaul_driver' used prior to declaration
make[3]: *** [arch/i386/kernel/cpu/cpufreq/longhaul.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

