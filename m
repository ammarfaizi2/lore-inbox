Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262665AbRE0BCy>; Sat, 26 May 2001 21:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262668AbRE0BCo>; Sat, 26 May 2001 21:02:44 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:26062 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S262665AbRE0BC3>;
	Sat, 26 May 2001 21:02:29 -0400
Message-ID: <3B10521D.346E5886@mandrakesoft.com>
Date: Sat, 26 May 2001 21:02:21 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
Cc: "Ingo T. Storm" <it@lapavoni.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.5 does not link on Ruffian (alpha)
In-Reply-To: <3B0BFE90.CE148B7@kjist.ac.kr> <20010523210923.A730@athlon.random> <022e01c0e5fc$39ac0cf0$2e2ca8c0@buxtown.de> <20010526193649.B1834@athlon.random> <20010526201442.D1834@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> diff -urN alpha/arch/alpha/kernel/sys_dp264.c alpha-1/arch/alpha/kernel/sys_dp264.c
> --- alpha/arch/alpha/kernel/sys_dp264.c Sun Apr  1 01:17:07 2001
> +++ alpha-1/arch/alpha/kernel/sys_dp264.c       Wed May 23 02:43:49 2001
> @@ -16,15 +16,18 @@
>  #include <linux/pci.h>
>  #include <linux/init.h>
> 
> +#define __EXTERN_INLINE inline
> +#include <asm/io.h>
> +#include <asm/core_tsunami.h>
> +#undef  __EXTERN_INLINE
> +

Why is "__EXTERN_INLINE" defined as "inline" not "extern inline"?

I simply added "extern" and things started working (as noted in my
previous message in this thread)..

-- 
Jeff Garzik      | Disbelief, that's why you fail.
Building 1024    |
MandrakeSoft     |
