Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313070AbSDSWMd>; Fri, 19 Apr 2002 18:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313090AbSDSWMc>; Fri, 19 Apr 2002 18:12:32 -0400
Received: from ip68-3-107-226.ph.ph.cox.net ([68.3.107.226]:39355 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S313070AbSDSWMc>;
	Fri, 19 Apr 2002 18:12:32 -0400
Message-ID: <3CC0964D.4000008@candelatech.com>
Date: Fri, 19 Apr 2002 15:12:29 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: rddunlap@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: unresolved symbol: __udivdi3
In-Reply-To: <Pine.LNX.4.33L2.0204191408450.15597-100000@dragon.pdx.osdl.net>	<3CC092F2.8090009@candelatech.com> <20020419.145651.82832824.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



David S. Miller wrote:

>    From: Ben Greear <greearb@candelatech.com>
>    Date: Fri, 19 Apr 2002 14:58:10 -0700
> 
>    then I get another unresolved symbol:
>    __umodi3
>    
> Someone needs to add this routine under arch/sparc/lib/
> 
>    I'm guessing that there is some optimization the compiler is doing that
>    is using the mod operator somehow, but I am unsure about how to work around
>    this.
> 
> "guessing"?  Have a look the definition of do_div in asm-sparc/div64.h
> it explicitly does a mod operation :-)


Yeah, I just noticed that.  What good is do_div if it calls %
which is also not resolved???  I can see why you had all the
hi/lo crap in the pktgen.c now :)

(I'm looking in asm-i386/div64.h, btw, since I'm running on x86
right now.)


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


