Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268957AbUIHJCn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268957AbUIHJCn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 05:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268959AbUIHJCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 05:02:43 -0400
Received: from imap.gmx.net ([213.165.64.20]:7321 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S268957AbUIHJCl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 05:02:41 -0400
X-Authenticated: #20450766
Date: Wed, 8 Sep 2004 10:15:43 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: xuhaoz <xuhaoz@neonetech.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: beginner met kernel BUG at slab.c 871
In-Reply-To: <NNT6PcyfAWZdVbOnoPx00000024@nnt.neonetech.com>
Message-ID: <Pine.LNX.4.60.0409081013210.3925@poirot.grange>
References: <NNT6PcyfAWZdVbOnoPx00000024@nnt.neonetech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Sep 2004, xuhaoz wrote:

> linux-kernelhi:
>
> 	I met a kernel BUG at slab.c , exactly at here:
>
> 			down(&cache_chain_sem);
> 			{
> 				struct list_head *p;
> 				list_for_each(p,&cache_chain){
> 					kmem_cache_t *pc=list_entry(p,kmem_cache_t,next);
> 					if(!strcmp(pc->name,name))
> 						BUG();
> 				}
> 			}
> 	I also print the pc->name and name to the terminal, the pc->name is files_cache, certainly the name is files_cache.
>
>     the version is linux-2.4.19
>
> 	Would you please give some advice about the cause of the Kernel BUG?
> 	Maybe I haven't give you enough information, but I really don't know what message I should give, please tell me,
> 	and I will post them .

See /your/linux/kernel/sources/REPORTING_BUGS.

Regards
Guennadi

> 	 Any suggestion will be appreciated.
> 	Thank you .
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>

---
Guennadi Liakhovetski

