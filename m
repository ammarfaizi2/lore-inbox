Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312716AbSDOOPR>; Mon, 15 Apr 2002 10:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312750AbSDOOPQ>; Mon, 15 Apr 2002 10:15:16 -0400
Received: from Expansa.sns.it ([192.167.206.189]:14855 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S312716AbSDOOPP>;
	Mon, 15 Apr 2002 10:15:15 -0400
Date: Mon, 15 Apr 2002 16:15:04 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: J Sloan <joe@tmsusa.com>
cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.8 final -
In-Reply-To: <3CB9EF57.6010609@tmsusa.com>
Message-ID: <Pine.LNX.4.44.0204151607480.26730-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OH well, on sparc64 setup_per_cpu_areas()  simply is
not declared, since it is not a GENERIC_PER_CPU.

then asm/cacheflush.h, required by linux/highmem.h,
does not exist.

And then PREEMPT_ACTIVE is not defined...

it seems that I could not test under sparc64 also this release, sigh!

On Sun, 14 Apr 2002, J Sloan wrote:

> Observations -
>
> The up-fix for the setup_per_cpu_areas compile
> issue apparently didn't make it into 2.5.8-final,
> so we had to apply the patch from 2.5.8-pre3
> to get it to compile.
>
> That said, however, everything works, all services
> are running, all devices working, Xfree is happy.
>
> P4-B/1600,  genuine intel mobo running RH 7.2+rawhide
>
> It also passes the q3a test with snappy results
>
> :-)
>
> Joe
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

