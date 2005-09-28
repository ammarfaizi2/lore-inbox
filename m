Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030199AbVI1DBa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030199AbVI1DBa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 23:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030200AbVI1DBa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 23:01:30 -0400
Received: from nproxy.gmail.com ([64.233.182.195]:47115 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030199AbVI1DB3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 23:01:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NZzAv5q0G/1VnuTvZYexSpCNlgsdwx89H5lb15bCxKNPrPdLgCVKmP3L8I0SPBgoblogmda8v5XHp1lsegKuLUTZgIrDO2is6/BBs7Yoo/nxrcXgN4Quj+nieblBxKzNw2U4WDjc8xCA4D+8ZI82Ku84ed28xwlL9Qb//Hvwd1M=
Message-ID: <2cd57c90050927200118eb9ade@mail.gmail.com>
Date: Wed, 28 Sep 2005 11:01:25 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: Coywolf Qi Hunt <coywolf@gmail.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [RFC][PATCH] inline a few tiny functions in init/initramfs.c
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Con Kolivas <kernel@kolivas.org>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1127872565.5210.4.camel@npiggin-nld.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200509240126.26575.jesper.juhl@gmail.com>
	 <200509241415.43773.kernel@kolivas.org>
	 <4334DB96.3040904@yahoo.com.au>
	 <9a87484905092717074e85657e@mail.gmail.com>
	 <1127872565.5210.4.camel@npiggin-nld.site>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/05, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> On Wed, 2005-09-28 at 02:07 +0200, Jesper Juhl wrote:
>
> > Ok, so it seems that there's agreement that the other two inlines in
> > the patch makes sense, but the malloc() is not clear cut.
> >
> > Since this is in initramfs after all it doesn't make that big a
> > difference overall, so I'll just send in a patch that inlines the
> > other two functions but leaves malloc() alone.
> >
>
> Well, they're not particularly performance critical, and everything
> is marked init anyway so I don't know why you would bother changing
> anything ;)
>

Don't you feel "static inline void __init " stupid? (inline + __init)
Anyway don't do things like that manually. Leave the optimization job
to gcc.
--
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
