Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265804AbUAQAlR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 19:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265862AbUAQAlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 19:41:17 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:8944 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265804AbUAQAlQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 19:41:16 -0500
Date: Sat, 17 Jan 2004 01:41:13 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Eduard Roccatello <lilo.please.no.spam@roccatello.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: p4-clockmod does not compile under 2.6.1-mm3
Message-ID: <20040117004112.GB12027@fs.tum.de>
References: <200401162014.24567.lilo.please.no.spam@roccatello.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401162014.24567.lilo.please.no.spam@roccatello.it>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 16, 2004 at 08:14:24PM +0100, Eduard Roccatello wrote:

> Hello :-)

Hi Eduard,

> bash-2.05b# gcc --version
> gcc (GCC) 3.2.3
> 
> bash-2.05b# make
>   SPLIT   include/linux/autoconf.h -> include/config/*
> make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
>   CHK     include/linux/compile.h
>   CC      arch/i386/kernel/cpu/cpufreq/p4-clockmod.o
> arch/i386/kernel/cpu/cpufreq/p4-clockmod.c: In function `cpufreq_p4_setdc':
> arch/i386/kernel/cpu/cpufreq/p4-clockmod.c:71: `cpu_sibling_map' undeclared 
> (first use in this function)
> arch/i386/kernel/cpu/cpufreq/p4-clockmod.c:71: (Each undeclared identifier 
> is reported only once
> arch/i386/kernel/cpu/cpufreq/p4-clockmod.c:71: for each function it appears 
> in.)
> make[3]: *** [arch/i386/kernel/cpu/cpufreq/p4-clockmod.o] Error 1
> make[2]: *** [arch/i386/kernel/cpu/cpufreq] Error 2
> make[1]: *** [arch/i386/kernel/cpu] Error 2
> make: *** [arch/i386/kernel] Error 2
> 
> adding a cpumask_t cpu_sibling_map[NR_CPUS] to the function make it compile 
> but i think this is a very bad solution (sorry I'm not a kernel hacker :-)


thanks for your report.

This was a known bug in -mm3 that is already fixed in -mm4 [1].


> Thanks,
> Eduard

cu
Adrian

[1] ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.1/2.6.1-mm4/broken-out/p4-clockmod-sibling-map-fix.patch

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

