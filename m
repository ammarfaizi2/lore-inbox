Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261643AbSJ1Wt1>; Mon, 28 Oct 2002 17:49:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261644AbSJ1Wt1>; Mon, 28 Oct 2002 17:49:27 -0500
Received: from p50829418.dip.t-dialin.net ([80.130.148.24]:5893 "EHLO
	Marvin.DL8BCU.ampr.org") by vger.kernel.org with ESMTP
	id <S261643AbSJ1WtY>; Mon, 28 Oct 2002 17:49:24 -0500
Date: Mon, 28 Oct 2002 22:55:52 +0000
From: Thorsten Kranzkowski <dl8bcu@dl8bcu.de>
To: Tom Vier <tmv@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: conflicting types for sys_swap{on,off} Re: Linux 2.5.44-ac5
Message-ID: <20021028225552.E2396@Marvin.DL8BCU.ampr.org>
Reply-To: dl8bcu@dl8bcu.de
Mail-Followup-To: Tom Vier <tmv@comcast.net>, linux-kernel@vger.kernel.org
References: <200210281452.g9SEqwF17910@devserv.devel.redhat.com> <20021028224651.GA11490@yzero>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20021028224651.GA11490@yzero>; from tmv@comcast.net on Mon, Oct 28, 2002 at 05:46:51PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2002 at 05:46:51PM -0500, Tom Vier wrote:
> i'm not sure how to fix this. does anyone have a patch?
> 
> make -f kernel/Makefile 
>   gcc -Wp,-MD,kernel/.sys.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mno-fp-regs -ffixed-8 -mcpu=ev56 -Wa,-mev6 -fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BASENAME=sys -DEXPORT_SYMTAB  -c -o kernel/sys.o kernel/sys.c
> kernel/sys.c:216: conflicting types for `sys_swapon'
> include/linux/swap.h:212: previous declaration of `sys_swapon'
> kernel/sys.c:217: conflicting types for `sys_swapoff'
> include/linux/swap.h:211: previous declaration of `sys_swapoff'
> make[1]: *** [kernel/sys.o] Error 1
> make: *** [kernel] Error 2

I just commented out both lines from kernel/sys.c to make it compile.
Don't know what the proper fix might be.

Thorsten

> 
> 
> -- 
> Tom Vier <tmv@comcast.net>
> DSA Key ID 0xE6CB97DA
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
| Thorsten Kranzkowski        Internet: dl8bcu@dl8bcu.de                      |
| Mobile: ++49 170 1876134       Snail: Niemannsweg 30, 49201 Dissen, Germany |
| Ampr: dl8bcu@db0lj.#rpl.deu.eu, dl8bcu@marvin.dl8bcu.ampr.org [44.130.8.19] |
