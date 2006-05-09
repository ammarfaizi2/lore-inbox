Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751464AbWEIIVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbWEIIVF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 04:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751465AbWEIIVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 04:21:05 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:42706 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1751464AbWEIIVE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 04:21:04 -0400
Subject: Re: [RT PATCH] fix futex compilation (rt20)
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: dipankar@in.ibm.com
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <20060508091535.GB6081@in.ibm.com>
References: <20060508091535.GB6081@in.ibm.com>
Date: Tue, 09 May 2006 10:24:51 +0200
Message-Id: <1147163091.3969.0.camel@frecb000686>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 09/05/2006 10:23:32,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 09/05/2006 10:24:02,
	Serialize complete at 09/05/2006 10:24:02
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-08 at 14:45 +0530, Dipankar Sarma wrote:
> Hi Ingo,
> 
> I needed this patch to compile and boot rt20 on x86_64. Just FYI.
> 
> Thanks
> Dipankar
> 
> Signed-off-by: Dipankar Sarma <dipankar@in.ibm.com>
> 
> diff -puN kernel/futex_compat.c~fix-futex-compile kernel/futex_compat.c
> --- linux-2.6.16-rt20/kernel/futex_compat.c~fix-futex-compile	2006-05-08 13:59:53.000000000 +0530
> +++ linux-2.6.16-rt20-dipankar/kernel/futex_compat.c	2006-05-08 14:01:02.000000000 +0530
> @@ -137,5 +137,5 @@ asmlinkage long compat_sys_futex(u32 __u
>  	if (op == FUTEX_REQUEUE || op == FUTEX_CMP_REQUEUE)
>  		val2 = (int) (unsigned long) utime;
>  
> -	return do_futex(uaddr, op, val, timeout, uaddr2, val2, val3);
> +	return do_futex(uaddr, op, val, &t, uaddr2, val2, val3);
>  }
> 
> _

  Whoops, missed this one, thanks.

  OK with me.

  Sébastien.

