Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313130AbSDSXdx>; Fri, 19 Apr 2002 19:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313131AbSDSXdx>; Fri, 19 Apr 2002 19:33:53 -0400
Received: from ip68-3-107-226.ph.ph.cox.net ([68.3.107.226]:28604 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S313130AbSDSXdv>;
	Fri, 19 Apr 2002 19:33:51 -0400
Message-ID: <3CC0A95A.2070000@candelatech.com>
Date: Fri, 19 Apr 2002 16:33:46 -0700
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

Also, for what it's worth, do_div on x86 seems to corrupt arguments
given to it, and may do other screwy things.  I'm just going to
go back to casting and let user-space do any precise division.

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
> 
> 


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


