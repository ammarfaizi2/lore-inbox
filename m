Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbVIUI53@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbVIUI53 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 04:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbVIUI53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 04:57:29 -0400
Received: from omta01sl.mx.bigpond.com ([144.140.92.153]:27644 "EHLO
	omta01sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1750764AbVIUI52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 04:57:28 -0400
Message-ID: <43312071.7000809@eyal.emu.id.au>
Date: Wed, 21 Sep 2005 18:57:21 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
User-Agent: Debian Thunderbird 1.0.2 (X11/20050817)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: A pettiness question.
References: <43311071.8070706@ccoss.com.cn> <200509211200.06274.dr_unique@ymg.ru>
In-Reply-To: <200509211200.06274.dr_unique@ymg.ru>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ustyugov Roman wrote:
>>Hi, All.
>>
>>    I found there are use double operator ! continuously sometimes in
>>kernel.
>>e.g:
>>
>>    static inline int is_page_cache_freeable(struct page *page)
>>    {
>>        return page_count(page) - !!PagePrivate(page) == 2;
>>    }
>>
>>    Who would like tell me why write like above?
>>
>>
>>    Thanks in advanced.
>>
>>
>>Liyu
> 
> 
> For example,
> 
> 	int test = 5;
> 	!test will be  0,  !!test will be 1.
> 
> This give a enum of {0,1}. If test is not 0, !!test will give 1, otherwise 0.
> 
> Am I right?

Yes, !! converts {zero,not-zero} to {0,1} which is useable
in arithmetic.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
