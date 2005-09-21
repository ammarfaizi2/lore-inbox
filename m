Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751382AbVIUTUW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbVIUTUW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 15:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbVIUTUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 15:20:22 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:4111 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1751382AbVIUTUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 15:20:19 -0400
Message-ID: <4331B062.10506@tmr.com>
Date: Wed, 21 Sep 2005 15:11:30 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: liyu <liyu@ccoss.com.cn>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: A pettiness question.
References: <43311071.8070706@ccoss.com.cn>
In-Reply-To: <43311071.8070706@ccoss.com.cn>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

liyu wrote:
> Hi, All.
>      I found there are use double operator ! continuously sometimes in 
> kernel.
> e.g:
> 
>    static inline int is_page_cache_freeable(struct page *page)
>    {
>        return page_count(page) - !!PagePrivate(page) == 2;
>    }
> 
>    Who would like tell me why write like above?
>    
!!(N) is easier to write than ((N) ? 1 : 0)
-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

