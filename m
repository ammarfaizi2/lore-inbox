Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269210AbRHQAYV>; Thu, 16 Aug 2001 20:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269207AbRHQAYL>; Thu, 16 Aug 2001 20:24:11 -0400
Received: from ool-18b899e0.dyn.optonline.net ([24.184.153.224]:13052 "EHLO
	bouncybouncy") by vger.kernel.org with ESMTP id <S269212AbRHQAX6>;
	Thu, 16 Aug 2001 20:23:58 -0400
Date: Thu, 16 Aug 2001 20:24:12 -0400
From: Justin A <justin@bouncybouncy.net>
To: "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VM nuisance
Message-ID: <20010816202412.B20072@bouncybouncy.net>
In-Reply-To: <20010816192946.A20072@bouncybouncy.net> <Pine.LNX.4.33.0108161704250.10866-100000@sol.compendium-tech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0108161704250.10866-100000@sol.compendium-tech.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wouldn't it be just a matter of


case 'f':    /* F -- oom handlder _f_ree memory */
	printk("Run OOM Handler\n");
	oom_kill();
	break;

in handle_sysrq in sysrq.c?

-Justin

On Thu, Aug 16, 2001 at 05:06:40PM -0700, Dr. Kelsey Hudson wrote:
> On Thu, 16 Aug 2001, Justin A wrote:
> 
> > Though it is not a complete solution for all cases(servers etc),
> > could a SysReq combination be added that triggers OOM?  I'm sure many
> > people use SysReq-k on occasion to get a system out of endless
> > swapping,  I think having a SysReq key for OOM would be a great
> > improvement.
> >
> > Comments?
> 
> I think it's a damn good idea. I'd actually begin coding that now, if I
> knew where to start. SysRQ has saved my life more than once -- i'm sure it
> would help all the other people who are having problems with randomized
> thrashing and stuff.
> 
>  Kelsey Hudson                                           khudson@ctica.com
>  Software Engineer
>  Compendium Technologies, Inc                               (619) 725-0771
> ---------------------------------------------------------------------------
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
