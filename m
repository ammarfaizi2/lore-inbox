Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263299AbTDVQmh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 12:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263300AbTDVQmg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 12:42:36 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:4312 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S263299AbTDVQmd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 12:42:33 -0400
Date: Tue, 22 Apr 2003 18:54:30 +0200 (MEST)
Message-Id: <200304221654.h3MGsUQK029822@harpo.it.uu.se>
From: mikpe@csd.uu.se
To: olh@suse.de
Subject: Re: 2.4.21-rc1 doesn't build on ppc (6xx/pmac)
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Apr 2003 15:47:39 +0200, Olaf Hering wrote:
>  On Tue, Apr 22, mikpe@csd.uu.se wrote:
> 
> > arch/ppc/kernel/head.o(__ftr_fixup+0x60): undefined reference to `CPU_FTR_HAS_HIGH_BATS'
> > arch/ppc/kernel/head.o(__ftr_fixup+0x64): undefined reference to `CPU_FTR_HAS_HIGH_BATS'
> > arch/ppc/kernel/kernel.o: In function `sys_call_table':
> > arch/ppc/kernel/kernel.o(.data+0x330c): undefined reference to `__setup_cpu_7450'
> > arch/ppc/kernel/kernel.o(.data+0x332c): undefined reference to `__setup_cpu_7450'
> > arch/ppc/kernel/kernel.o(.data+0x334c): undefined reference to `__setup_cpu_7450'
> > arch/ppc/kernel/kernel.o(.data+0x336c): undefined reference to `__setup_cpu_7455'
> > arch/ppc/kernel/kernel.o(.data+0x338c): undefined reference to `__setup_cpu_7455'
> > arch/ppc/kernel/kernel.o(.data+0x33ac): undefined reference to `__setup_cpu_7455'
> > make: *** [vmlinux] Error 1
> 
> 
> diff -purNX /home/olaf/kernel_exclude.txt kaputteslinuxdingens/arch/ppc/kernel/cputable.c linux-2.4.21-pre7-cset-1.1100-to-1.1116/arch/ppc/kernel/cputable.c
> --- kaputteslinuxdingens/arch/ppc/kernel/cputable.c	Mon Apr 21 21:28:04 2003
> +++ linux-2.4.21-pre7-cset-1.1100-to-1.1116/arch/ppc/kernel/cputable.c	Mon Apr 21 20:46:17 2003
> @@ -26,8 +26,7 @@ extern void __setup_cpu_750cx(unsigned l

<patch omitted>

That fixed it. Thanks!

/Mikael
