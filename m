Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267223AbSKPFu2>; Sat, 16 Nov 2002 00:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267224AbSKPFu2>; Sat, 16 Nov 2002 00:50:28 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:26876 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S267223AbSKPFu1>;
	Sat, 16 Nov 2002 00:50:27 -0500
Message-ID: <3DD5DE2E.9CC9941A@mvista.com>
Date: Fri, 15 Nov 2002 21:57:02 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Helge Hafting <helge.hafting@broadpark.no>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.47-bk4 compile failure, due to crypto
References: <3DD53234.B0F1C9C8@broadpark.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The QUICK fix is to turn the offending function into a
"#define"...

-g

Helge Hafting wrote:
> 
> I get this, even if I de-selects all the crypto stuff.
> Helge Hafting
> 
> make -f scripts/Makefile.build obj=net/core
>   gcc -Wp,-MD,net/core/.skbuff.o.d -D__KERNEL__ -Iinclude -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
> -march=i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include
> -DKBUILD_BASENAME=skbuff -DKBUILD_MODNAME=skbuff   -c -o
> net/core/skbuff.o net/core/skbuff.c
> In file included from include/net/xfrm.h:6,
>                  from net/core/skbuff.c:61:
> include/linux/crypto.h: In function `crypto_tfm_alg_modname':
> include/linux/crypto.h:202: dereferencing pointer to incomplete type
> include/linux/crypto.h:205: warning: control reaches end of non-void
> function
> make[2]: *** [net/core/skbuff.o] Error 1
> make[1]: *** [net/core] Error 2
> make: *** [net] Error 2
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
