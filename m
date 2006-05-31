Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965211AbWEaWWl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965211AbWEaWWl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 18:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965212AbWEaWWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 18:22:40 -0400
Received: from es335.com ([67.65.19.105]:18759 "EHLO mail.es335.com")
	by vger.kernel.org with ESMTP id S965209AbWEaWWj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 18:22:39 -0400
Subject: Re: [PATCH 1/2] iWARP Connection Manager.
From: Steve Wise <swise@opengridcomputing.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <adaverlx3ld.fsf@cisco.com>
References: <20060531182650.3308.81538.stgit@stevo-desktop>
	 <20060531182652.3308.1244.stgit@stevo-desktop>
	 <20060531114059.704ef1f1@localhost.localdomain> <ada3beqyp39.fsf@cisco.com>
	 <1149109080.7469.15.camel@stevo-desktop>
	 <20060531140100.36024296@localhost.localdomain> <adaverlx3ld.fsf@cisco.com>
Content-Type: text/plain
Date: Wed, 31 May 2006 17:22:38 -0500
Message-Id: <1149114158.7469.38.camel@stevo-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

so be it.

iwcm.c and the ammasso files will all use sizeof().

Steve.


On Wed, 2006-05-31 at 14:54 -0700, Roland Dreier wrote:
> This is a silly thing to argue about, but...
> 
>  > The preferred form for passing a size of a struct is the following:
>  > 
>  > 	p = kmalloc(sizeof(*p), ...);
>  > 
>  > The alternative form where struct name is spelled out hurts readability and
>  > introduces an opportunity for a bug when the pointer variable type is changed
>  > but the corresponding sizeof that is passed to a memory allocator is not.
> 
> I would argue that this is talking about sizeof(*p) vs. sizeof (struct foo)
> rather than sizeof(*p) vs. sizeof *p.
> 
> You wouldn't write:
> 
> 	return(*p);
> 
> but rather
> 
> 	return *p;
> 
> And sizeof is an operator not a function, so I think the same usage
> would apply.
> 
> With that said the prevalent kernel usage does seem to be sizeof(*foo)
> (by about 10 to 1).  But I can't help feeling it looks silly.
> 
>  - R.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

