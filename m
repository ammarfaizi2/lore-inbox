Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284429AbRLEOm5>; Wed, 5 Dec 2001 09:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284430AbRLEOmr>; Wed, 5 Dec 2001 09:42:47 -0500
Received: from t2.redhat.com ([199.183.24.243]:36082 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S284429AbRLEOmq>; Wed, 5 Dec 2001 09:42:46 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <E16BWQ4-00070r-00@wagner> 
In-Reply-To: <E16BWQ4-00070r-00@wagner> 
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] BUG_ON() not arch-specific. 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 05 Dec 2001 14:42:32 +0000
Message-ID: <26384.1007563352@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


rusty@rustcorp.com.au said:
> --- linux-2.5.1-pre5/include/linux/kernel.h	Wed Dec  5 16:49:14 2001
> +++ working-2.5.1-pre5-percpu/include/linux/kernel.h	Wed Dec  5 18:12:15 2001
> @@ -176,4 +176,5 @@
>  	char _f[20-2*sizeof(long)-sizeof(int)];	/* Padding: libc5 uses this.. */
>  };
>  
> +#define BUG_ON(condition) do { if (unlikely((condition)!=0)) BUG(); } while(0)

You'll need to add #include <linux/compiler.h> to linux/kernel.h if you do 
that. Let's not make the include files any more broken than they already 
are :)


--
dwmw2


