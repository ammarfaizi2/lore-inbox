Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275304AbRIZQeI>; Wed, 26 Sep 2001 12:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275305AbRIZQd6>; Wed, 26 Sep 2001 12:33:58 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:30697 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S275304AbRIZQdn>;
	Wed, 26 Sep 2001 12:33:43 -0400
Message-ID: <3BB2036D.A72C1C25@candelatech.com>
Date: Wed, 26 Sep 2001 09:33:49 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Steven Rostedt <srostedt@stny.rr.com>
CC: duwe@informatik.uni-erlangen.de,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mc146818rtc.h for user land programs (2.4.10)
In-Reply-To: <Pine.LNX.4.33.0109261152100.5923-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> 
> The following patch is for linux-2.4.10
> This is needed for user land programs to use the
> mc146818rtc.h header.
> 
> --- include/linux/mc146818rtc.h.orig    Wed Sep 26 23:43:00 2001
> +++ include/linux/mc146818rtc.h Wed Sep 26 23:43:25 2001
> @@ -16,7 +16,9 @@
>  #include <linux/spinlock.h>            /* spinlock_t */
>  #include <asm/mc146818rtc.h>           /* register access macros */
> 
> +#ifdef __KERNEL__
>  extern spinlock_t rtc_lock;            /* serialize CMOS RAM access */
> +#endif

I can see arguing with Alan about the inclusion of linux-kernel headers
in some cases, but I don't see anything in this file that looks like a
user-space program could use.  Which part of this file do the user
space programs need?

Ben


-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
