Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273345AbRKEWC1>; Mon, 5 Nov 2001 17:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281372AbRKEWCU>; Mon, 5 Nov 2001 17:02:20 -0500
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:56460 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S273345AbRKEWCE>;
	Mon, 5 Nov 2001 17:02:04 -0500
Message-ID: <3BE70C47.5020804@candelatech.com>
Date: Mon, 05 Nov 2001 15:01:43 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: Tim Jansen <tim@tjansen.de>
CC: Petr Baudis <pasky@pasky.ji.cz>, linux-kernel@vger.kernel.org
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
In-Reply-To: <E15zF9H-0000NL-00@wagner> <20011104163354.C14001@unthought.net> <20011105144112.Q11619@pasky.ji.cz> <160qdn-0ZGNrUC@fmrl04.sul.t-online.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Tim Jansen wrote:

> On Monday 05 November 2001 14:41, Petr Baudis wrote:
> 
>>So, please, can you enlighten me, what's so wrong on sysctl?
>>
> 
> It doesn't work for complex data, especially lists. How do you want to 
> configure devices, for example? 


How about this:

struct ioctl_payload {
    int how_many;
    int* numbers;
};


User space sets things up normally, with a valid pointer in 'numbers'.
Kernel space copy_from_user the structure, then copy_from_user the number's
memory...

Can that work?  If so, numbers could of course be any data structure we want...


> 
> bye...
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


