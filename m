Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751058AbVIUPIZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058AbVIUPIZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 11:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbVIUPIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 11:08:25 -0400
Received: from xenotime.net ([66.160.160.81]:58064 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751056AbVIUPIY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 11:08:24 -0400
Date: Wed, 21 Sep 2005 08:08:22 -0700 (PDT)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Ustyugov Roman <dr_unique@ymg.ru>
cc: liyu <liyu@ccoss.com.cn>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: A pettiness question.
In-Reply-To: <200509211200.06274.dr_unique@ymg.ru>
Message-ID: <Pine.LNX.4.58.0509210807330.6192@shark.he.net>
References: <43311071.8070706@ccoss.com.cn> <200509211200.06274.dr_unique@ymg.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Sep 2005, Ustyugov Roman wrote:

> > Hi, All.
> >
> >     I found there are use double operator ! continuously sometimes in
> > kernel.
> > e.g:
> >
> >     static inline int is_page_cache_freeable(struct page *page)
> >     {
> >         return page_count(page) - !!PagePrivate(page) == 2;
> >     }
> >
> >     Who would like tell me why write like above?
> >
> >
> >     Thanks in advanced.
> >
> >
> > Liyu
>
> For example,
>
> 	int test = 5;
> 	!test will be  0,  !!test will be 1.
>
> This give a enum of {0,1}. If test is not 0, !!test will give 1, otherwise 0.
>
> Am I right?

Yes.  I think of it as a "truth value" predicate (or operator).

-- 
~Randy
