Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263714AbTHZMUG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 08:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263710AbTHZMUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 08:20:06 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:15799 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S263714AbTHZMT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 08:19:59 -0400
Date: Tue, 26 Aug 2003 09:15:31 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4: always_inline for gcc3
In-Reply-To: <20030826082459.GC2017@werewolf.able.es>
Message-ID: <Pine.LNX.4.44.0308260850170.3191@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Can you please explain me what are the differences when using "__inline__
__attribute__((always_inline))" and why you chose to use that?

On Tue, 26 Aug 2003, J.A. Magallon wrote:

> Hi.
>
> Resending for 2.4.23-pre ;)
>
> --- 25/include/linux/compiler.h~gcc3-inline-fix	2003-03-06
> 03:02:43.000000000 -0800
> +++ 25-akpm/include/linux/compiler.h	2003-03-06 03:11:42.000000000 -0800
> @@ -1,6 +1,13 @@
>  #ifndef __LINUX_COMPILER_H
>  #define __LINUX_COMPILER_H
>
> +#if __GNUC__ >= 3
> +#define inline		__inline__ __attribute__((always_inline))
> +#define inline__	__inline__ __attribute__((always_inline))
> +#define __inline	__inline__ __attribute__((always_inline))
> +#define __inline__	__inline__ __attribute__((always_inline))
> +#endif
> +
>  /* Somewhere in the middle of the GCC 2.96 development cycle, we implemented
>     a mechanism by which the user can annotate likely branch directions and
>     expect the blocks to be reordered appropriately.  Define __builtin_expect
>
>
>

