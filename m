Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264939AbSK0XcE>; Wed, 27 Nov 2002 18:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264940AbSK0XcE>; Wed, 27 Nov 2002 18:32:04 -0500
Received: from marcie.netcarrier.net ([216.178.72.21]:47624 "HELO
	marcie.netcarrier.net") by vger.kernel.org with SMTP
	id <S264939AbSK0XcD>; Wed, 27 Nov 2002 18:32:03 -0500
Message-ID: <3DE557AC.A8DE08E5@compuserve.com>
Date: Wed, 27 Nov 2002 18:39:24 -0500
From: Kevin Brosius <cobra@compuserve.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.16-4GB i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Arnd Bergmann <arnd@bergmann-dalldorf.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
Subject: Re: hugetlbpage.c build failure?
References: <3DE54702.44D98750@compuserve.com> <200211272301.AAA29750@post.webmailer.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:
> 
> 
> Kevin Brosius wrote:
> > arch/i386/mm/hugetlbpage.c:610: parse error before '*' token
> 
> The patch below fixed this for me
> 
> ===== arch/i386/mm/hugetlbpage.c 1.17 vs edited =====
> --- 1.17/arch/i386/mm/hugetlbpage.c     Thu Nov 14 23:03:02 2002
> +++ edited/arch/i386/mm/hugetlbpage.c   Wed Nov 27 19:18:23 2002
> @@ -14,6 +14,7 @@
>  #include <linux/slab.h>
>  #include <linux/module.h>
>  #include <linux/err.h>
> +#include <linux/sysctl.h>
>  #include <asm/mman.h>
>  #include <asm/pgalloc.h>

Thanks guys, that does it here.  Greg, was yours a run time fix? I don't
see any difference during build.

-- 
Kevin
