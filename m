Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266211AbUAGTjm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 14:39:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266216AbUAGTjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 14:39:42 -0500
Received: from fw.osdl.org ([65.172.181.6]:59783 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266211AbUAGTj2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 14:39:28 -0500
Date: Wed, 7 Jan 2004 11:40:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: Joe Korty <joe.korty@ccur.com>
Cc: linux-kernel@vger.kernel.org, Paul Jackson <pj@sgi.com>
Subject: Re: reduce cpumask digit grouping from 8 to 4
Message-Id: <20040107114037.3e10f18f.akpm@osdl.org>
In-Reply-To: <20040107171142.GA11525@rudolph.ccur.com>
References: <20040107171142.GA11525@rudolph.ccur.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Korty <joe.korty@ccur.com> wrote:
>
> As long as we are going to have a seperator in cpumask_t displays,
> we might as well as group the digits into readable units.
> 
> Against 2.6.1-rc2.
> 
> --- base/lib/mask.c	2004-01-07 11:40:07.000000000 -0500
> +++ new/lib/mask.c	2004-01-07 11:57:38.000000000 -0500
> @@ -88,8 +88,8 @@
>  int __mask_snprintf_len(char *buf, unsigned int buflen,
>  	const unsigned long *maskp, unsigned int maskbytes)
>  {
> -	u32 *wordp = (u32 *)maskp;
> -	int i = maskbytes/sizeof(u32) - 1;
> +	u16 *wordp = (u16 *)maskp;
> +	int i = maskbytes/sizeof(u16) - 1;
>  	int len = 0;
>  	char *sep = "";
>  

What does the before-and-after output look like?

Thanks.
