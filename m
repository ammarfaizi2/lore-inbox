Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbVIUJBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbVIUJBO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 05:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbVIUJBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 05:01:14 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:30865 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750765AbVIUJBN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 05:01:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HHbW9FwK39nGRVlQ8jRgl0WyQ8We/ACccneXoSl+1+YhTnZykxMixspXOPGvb0DO8Z6FXheKrlZMv0Thcy9BMjMIaobOxo2U5GxyZGuqcQuZyTpqCCYWPEymT7XTV507pG276P/pQjbEJYGUCl5pRcT14M6rVRy7HUOD/85P124=
Message-ID: <1e62d13705092102012f0a5c9c@mail.gmail.com>
Date: Wed, 21 Sep 2005 14:01:11 +0500
From: Fawad Lateef <fawadlateef@gmail.com>
Reply-To: fawadlateef@gmail.com
To: Ustyugov Roman <dr_unique@ymg.ru>
Subject: Re: A pettiness question.
Cc: liyu <liyu@ccoss.com.cn>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200509211200.06274.dr_unique@ymg.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43311071.8070706@ccoss.com.cn>
	 <200509211200.06274.dr_unique@ymg.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/05, Ustyugov Roman <dr_unique@ymg.ru> wrote:
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
> 
> For example,
> 
>         int test = 5;
>         !test will be  0,  !!test will be 1.
> 
> This give a enum of {0,1}. If test is not 0, !!test will give 1, otherwise 0.
> 
> Am I right?

Yes, but what abt the above case/example ??? PagePrivate is defined as
test_bit and test_bit will return 0 or 1 only ...... So y there is (
!! )  ??

-- 
Fawad Lateef
