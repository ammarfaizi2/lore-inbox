Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbTLTXT0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 18:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbTLTXTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 18:19:25 -0500
Received: from mail-10.iinet.net.au ([203.59.3.42]:20966 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261799AbTLTXTV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 18:19:21 -0500
Message-ID: <3FE4D8F6.60100@cyberone.com.au>
Date: Sun, 21 Dec 2003 10:19:18 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] 2.6.0 sched migrate comment
References: <3FE46885.2030905@cyberone.com.au> <3FE468BF.9000102@cyberone.com.au> <3FE468F5.7020501@cyberone.com.au> <20031220202611.GB32320@elte.hu>
In-Reply-To: <20031220202611.GB32320@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ingo Molnar wrote:

>* Nick Piggin <piggin@cyberone.com.au> wrote:
>
>  
>
>>Some comments were lost during minor surgery here...
>>    
>>
>
>this patch collides with John Hawkes' sched_clock() fix-patch which goes
>in first. Also, the patch does more than just comment fixups. It changes
>the order of tests, where a bug slipped in:
>
>+       if (!idle && (delta <= cache_decay_ticks))
>
>This will cause the cache-hot test to almost never trigger, which is
>clearly incorrect. The correct test is:
>
>        if (!idle && (delta <= JIFFIES_TO_NS(cache_decay_ticks)))
>
>anyway, i've fixed it all up (patch attached).
>  
>

Yep, thanks again.


