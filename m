Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261450AbUKIJN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbUKIJN4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 04:13:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261453AbUKIJNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 04:13:55 -0500
Received: from witte.sonytel.be ([80.88.33.193]:47606 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261450AbUKIJNm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 04:13:42 -0500
Date: Tue, 9 Nov 2004 10:13:20 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Kumar Gala <galak@somerset.sps.mot.com>
cc: Andrew Morton <akpm@osdl.org>,
       Linux/PPC Development <linuxppc-dev@ozlabs.org>,
       Paul Mackerras <paulus@samba.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][PPC32] Add performance counters to cpu_spec
In-Reply-To: <Pine.LNX.4.61.0411082332090.13565@blarg.somerset.sps.mot.com>
Message-ID: <Pine.GSO.4.61.0411091012550.25943@waterleaf.sonytel.be>
References: <Pine.LNX.4.61.0411082332090.13565@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Nov 2004, Kumar Gala wrote:
> Adds the number of performance monitor counters each PowerPC processor has to
> the cpu table.  Makes oprofile support a bit cleaner since we dont need a case
> statement on processor version to determine the number of counters.
> 
> Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
> 
> --
> 
> diff -Nru a/arch/ppc/kernel/cputable.c b/arch/ppc/kernel/cputable.c
> --- a/arch/ppc/kernel/cputable.c	2004-11-08 21:02:51 -06:00
> +++ b/arch/ppc/kernel/cputable.c	2004-11-08 21:02:51 -06:00
> @@ -82,6 +82,7 @@
>  	CPU_FTR_601 | CPU_FTR_HPTE_TABLE,
>  	COMMON_PPC | PPC_FEATURE_601_INSTR | PPC_FEATURE_UNIFIED_CACHE,
>  	32, 32,
> +	0,
>  	__setup_cpu_601
>      },
>      {	/* 603 */

Perhaps you want to switch to C99-style struct initialization as well?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
