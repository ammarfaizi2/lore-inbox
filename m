Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282845AbRLBMO6>; Sun, 2 Dec 2001 07:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282843AbRLBMOt>; Sun, 2 Dec 2001 07:14:49 -0500
Received: from mail022.mail.bellsouth.net ([205.152.58.62]:36447 "EHLO
	imf22bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S282852AbRLBMOk>; Sun, 2 Dec 2001 07:14:40 -0500
Message-ID: <3C0A1B2B.D2285CB@mandrakesoft.com>
Date: Sun, 02 Dec 2001 07:14:35 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, bsdlite5@hotmail.com
Subject: Re: [PATCH] floppy.c #defines
In-Reply-To: <Pine.LNX.4.33.0112021351000.14914-100000@netfinity.realnet.co.sz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> 
> There was more but, all in all floppy.c is a strange place...
> 
> Regards,
>         Zwane
> 
> diffed against 2.5.1-pre5
> 
> diff -urN linux-2.5.1-pre5/drivers/block/floppy.c linux-2.5.1-pre5-test/drivers/block/floppy.c
> --- linux-2.5.1-pre5/drivers/block/floppy.c     Sun Dec  2 12:57:38 2001
> +++ linux-2.5.1-pre5-test/drivers/block/floppy.c        Sun Dec  2 12:58:44 2001
> @@ -496,7 +496,7 @@
> 
>  #define NO_SIGNAL (!interruptible || !signal_pending(current))
>  #define CALL(x) if ((x) == -EINTR) return -EINTR
> -#define ECALL(x) if ((ret = (x))) return ret;
> +#define ECALL(x) if ((ret = (x))) return ret
>  #define _WAIT(x,i) CALL(ret=wait_til_done((x),i))
>  #define WAIT(x) _WAIT((x),interruptible)
>  #define IWAIT(x) _WAIT((x),1)
> @@ -670,7 +670,7 @@
>         else
>                 return b;
>  }
> -#define INFBOUND(a,b) (a)=maximum((a),(b));
> +#define INFBOUND(a,b) (a)=maximum((a),(b))
> 
>  static int minimum(int a, int b)
>  {
> @@ -679,7 +679,7 @@
>         else
>                 return b;
>  }
> -#define SUPBOUND(a,b) (a)=minimum((a),(b));
> +#define SUPBOUND(a,b) (a)=minimum((a),(b))

the driver should be changed to use standard min/max/min_t/max_t, and
from there you can create a single BOUND macro.

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

