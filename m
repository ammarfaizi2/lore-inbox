Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbTJCWWQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 18:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbTJCWWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 18:22:16 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:12300 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S261326AbTJCWWO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 18:22:14 -0400
Date: Fri, 3 Oct 2003 18:22:11 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: =?iso-8859-1?Q?Peter_W=E4chtler?= <pwaechtler@mac.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org,
       bo.z.li@intel.com, manfred@colorfullife.com
Subject: Re: [PATCH] [2/2] posix message queues
Message-ID: <20031003182211.Q26086@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <1065196646.3682.54.camel@picklock.adams.family>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1065196646.3682.54.camel@picklock.adams.family>; from pwaechtler@mac.com on Fri, Oct 03, 2003 at 05:59:26PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 03, 2003 at 05:59:26PM +0200, Peter Wächtler wrote:
> diff -X dontdiff -Nur vanilla-2.6.0-test6/include/asm-i386/unistd.h linux-2.6.0-test6/include/asm-i386/unistd.h
> --- vanilla-2.6.0-test6/include/asm-i386/unistd.h	2003-08-23 01:57:19.000000000 +0200
> +++ linux-2.6.0-test6/include/asm-i386/unistd.h	2003-09-07 21:48:07.000000000 +0200
> @@ -278,8 +278,15 @@
>  #define __NR_tgkill		270
>  #define __NR_utimes		271
>  #define __NR_fadvise64_64	272
> +#define __NR_sys_mq_open      273
> +#define __NR_sys_mq_unlink    (__NR_sys_mq_open+1)
> +#define __NR_mq_timedsend     (__NR_sys_mq_open+2)
> +#define __NR_mq_timedreceive  (__NR_sys_mq_open+3)
> +#define __NR_mq_notify        (__NR_sys_mq_open+4)
> +#define __NR_mq_getattr       (__NR_sys_mq_open+5)
> +#define __NR_mq_setattr       (__NR_sys_mq_open+6)

s/__NR_sys_mq/__NR_mq/g

	Jakub
