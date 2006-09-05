Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965018AbWIERUr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965018AbWIERUr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 13:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965127AbWIERUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 13:20:47 -0400
Received: from xenotime.net ([66.160.160.81]:18157 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S965018AbWIERUp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 13:20:45 -0400
Date: Tue, 5 Sep 2006 10:24:11 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Alon Bar-Lev <alon.barlev@gmail.com>
Cc: Andi Kleen <ak@suse.de>, Matt Domsch <Matt_Domsch@dell.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       johninsd@san.rr.com, davej@codemonkey.org.uk, Riley@williams.name,
       trini@kernel.crashing.org, davem@davemloft.net, ecd@brainaid.de,
       jj@sunsite.ms.mff.cuni.cz, anton@samba.org, wli@holomorphy.com,
       lethal@linux-sh.org, rc@rc0.org.uk, spyro@f2s.com, rth@twiddle.net,
       avr32@atmel.com, hskinnemoen@atmel.com, starvik@axis.com,
       ralf@linux-mips.org, matthew@wil.cx, grundler@parisc-linux.org,
       geert@linux-m68k.org, zippel@linux-m68k.org, paulus@samba.org,
       schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
       uclinux-v850@lsi.nec.co.jp, chris@zankel.net
Subject: Re: [PATCH 23/26] Dynamic kernel command-line - um
Message-Id: <20060905102411.0767059a.rdunlap@xenotime.net>
In-Reply-To: <200609040123.43788.alon.barlev@gmail.com>
References: <200609040115.22856.alon.barlev@gmail.com>
	<200609040123.43788.alon.barlev@gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Sep 2006 01:23:42 +0300 Alon Bar-Lev wrote:

> 
> 1. Rename saved_command_line into boot_command_line.
> 2. Set command_line as __initdata.
> 
> Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>
> 
> ---
> 
> diff -urNp linux-2.6.18-rc5-mm1.org/arch/um/include/user_util.h linux-2.6.18-rc5-mm1/arch/um/include/user_util.h
> --- linux-2.6.18-rc5-mm1.org/arch/um/include/user_util.h	2006-06-18 04:49:35.000000000 +0300
> +++ linux-2.6.18-rc5-mm1/arch/um/include/user_util.h	2006-09-03 23:47:03.000000000 +0300
> @@ -38,7 +38,7 @@ extern unsigned long long highmem;
>  
>  extern char host_info[];
>  
> -extern char saved_command_line[];
> +extern char __initdata boot_command_line[];
>  
>  extern unsigned long _stext, _etext, _sdata, _edata, __bss_start, _end;
>  extern unsigned long _unprotected_end;
> diff -urNp linux-2.6.18-rc5-mm1.org/arch/um/kernel/um_arch.c linux-2.6.18-rc5-mm1/arch/um/kernel/um_arch.c
> --- linux-2.6.18-rc5-mm1.org/arch/um/kernel/um_arch.c	2006-09-03 18:56:51.000000000 +0300
> +++ linux-2.6.18-rc5-mm1/arch/um/kernel/um_arch.c	2006-09-03 19:47:59.000000000 +0300
> @@ -482,7 +482,7 @@ void __init setup_arch(char **cmdline_p)
>  	atomic_notifier_chain_register(&panic_notifier_list,
>  			&panic_exit_notifier);
>  	paging_init();
> -        strlcpy(saved_command_line, command_line, COMMAND_LINE_SIZE);
> +        strlcpy(boot_command_line, command_line, COMMAND_LINE_SIZE);
>   	*cmdline_p = command_line;
>  	setup_hostinfo();
>  }

Please use tabs instead of spaces for indentation.

---
~Randy
