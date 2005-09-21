Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbVIUH4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbVIUH4R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 03:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbVIUH4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 03:56:17 -0400
Received: from [213.132.87.177] ([213.132.87.177]:64722 "EHLO gserver.ymgeo.ru")
	by vger.kernel.org with ESMTP id S1750747AbVIUH4R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 03:56:17 -0400
From: Ustyugov Roman <dr_unique@ymg.ru>
To: liyu <liyu@ccoss.com.cn>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: A pettiness question.
Date: Wed, 21 Sep 2005 12:00:05 +0400
User-Agent: KMail/1.8
References: <43311071.8070706@ccoss.com.cn>
In-Reply-To: <43311071.8070706@ccoss.com.cn>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="gb18030"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509211200.06274.dr_unique@ymg.ru>
X-OriginalArrivalTime: 21 Sep 2005 08:03:39.0359 (UTC) FILETIME=[F9A986F0:01C5BE82]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi, All.
>
>     I found there are use double operator ! continuously sometimes in
> kernel.
> e.g:
>
>     static inline int is_page_cache_freeable(struct page *page)
>     {
>         return page_count(page) - !!PagePrivate(page) == 2;
>     }
>
>     Who would like tell me why write like above?
>
>
>     Thanks in advanced.
>
>
> Liyu

For example,

	int test = 5;
	!test will be  0,  !!test will be 1.

This give a enum of {0,1}. If test is not 0, !!test will give 1, otherwise 0.

Am I right?
-- 
RomanU
