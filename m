Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131584AbRA1Gyp>; Sun, 28 Jan 2001 01:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135362AbRA1Gy0>; Sun, 28 Jan 2001 01:54:26 -0500
Received: from smtp-rt-5.wanadoo.fr ([193.252.19.159]:28138 "EHLO
	bassia.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S131584AbRA1GyU>; Sun, 28 Jan 2001 01:54:20 -0500
Message-ID: <3A73C1D8.578AEEE@wanadoo.fr>
Date: Sun, 28 Jan 2001 07:53:12 +0100
From: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
Organization: Home PC
X-Mailer: Mozilla 4.76 [fr] (X11; U; Linux 2.4.1-pre10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Ford <david@linux.com>
CC: devfs@oss.sgi.com, rgooch@atnf.csiro.au,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] devfsd, compiling on glibc22x
In-Reply-To: <3A7383B2.19DDD006@linux.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Ford wrote:
> 
> This patch is simple, defines RTLD_NEXT if not previously defined.
> 
> --- devfsd.c.orig       Sat Jan 27 18:14:19 2001
> +++ devfsd.c    Sat Jan 27 18:15:46 2001
> @@ -165,6 +165,7 @@
>      Last updated by Richard Gooch   3-JUL-2000: Added "-C
> /etc/modules.devfs"
>    when calling modprobe(8). Fail if a configuration line has EXECUTE
> modprobe.
> 
> +    Updated by      David Ford      27-JAN-2001: Added RTLD_NEXT define
> 
>  */
>  #include <unistd.h>
> @@ -221,6 +222,10 @@
>  #define AC_MKNEWCOMPAT              8
>  #define AC_RMOLDCOMPAT              9
>  #define AC_RMNEWCOMPAT              10
> +
> +#ifndef RTLD_NEXT
> +# define RTLD_NEXT     ((void *) -1l)
> +#endif
> 
>  struct permissions_type
>  {


for me :
make CFLAGS='-O2 -I. -D_GNU_SOURCE' 
compiles without any patch. is it correct ?

-- 
------------------------------------------------
 Pierre Rousselet <pierre.rousselet@wanadoo.fr>
------------------------------------------------
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
