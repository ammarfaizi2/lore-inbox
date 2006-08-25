Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751438AbWHYKuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbWHYKuz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 06:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751441AbWHYKuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 06:50:55 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:43799 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751438AbWHYKuy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 06:50:54 -0400
Message-ID: <44EED6BC.3060107@sw.ru>
Date: Fri, 25 Aug 2006 14:53:48 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>,
       Andi Kleen <ak@suse.de>, Greg KH <greg@kroah.com>,
       Oleg Nesterov <oleg@tv-sign.ru>, Matt Helsley <matthltc@us.ibm.com>,
       Rohit Seth <rohitseth@google.com>,
       Chandra Seetharaman <sekharan@us.ibm.com>
Subject: Re: [PATCH 2/6] BC: beancounters core (API)
References: <44EC31FB.2050002@sw.ru>	<44EC35EB.1030000@sw.ru>	<20060823094202.ff3a5573.akpm@osdl.org>	<44ED9633.7090504@sw.ru> <20060824080030.05232740.akpm@osdl.org>
In-Reply-To: <20060824080030.05232740.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Thu, 24 Aug 2006 16:06:11 +0400
> Kirill Korotaev <dev@sw.ru> wrote:
> 
> 
>>>>+#define bc_charge_locked(bc, r, v, s)			(0)
>>>>
>>>>>+#define bc_charge(bc, r, v)				(0)
>>>
>>>akpm:/home/akpm> cat t.c
>>>void foo(void)
>>>{
>>>	(0);
>>>}
>>>akpm:/home/akpm> gcc -c -Wall t.c
>>>t.c: In function 'foo':
>>>t.c:4: warning: statement with no effect
>>
>>these functions return value should always be checked (!).
> 
> 
> We have __must_check for that.
> 
> 
>>i.e. it is never called like:
>>  ub_charge(bc, r, v);
> 
> 
> Also...
> 
> 	if (bc_charge(tpyo, undefined_variable, syntax_error))
> 
> will happily compile if !CONFIG_BEANCOUNTER.
> 
> Turning these stubs into static inline __must_check functions fixes all this.

ok. will replace all empty stubs with inlines (with __must_check where appropriate)

Thanks,
Kirill

