Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269747AbSISCDD>; Wed, 18 Sep 2002 22:03:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269753AbSISCDD>; Wed, 18 Sep 2002 22:03:03 -0400
Received: from dhcp101-dsl-usw4.w-link.net ([208.161.125.101]:40603 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S269747AbSISCCi>;
	Wed, 18 Sep 2002 22:02:38 -0400
Message-ID: <3D893165.10106@candelatech.com>
Date: Wed, 18 Sep 2002 19:07:33 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Networking: send-to-self [link to non-broken patch this
 time]
References: <3D8826BE.5090007@candelatech.com>	<20020918.155534.102954410.davem@redhat.com>	<3D890A51.7000103@candelatech.com> <20020918.182855.47438220.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:

> It's hash lookup code, nearly identical to ipv4 version except
> it's dealing with 128-bit IP addresses instead of 32-bit.
> 
> You give up way too easily, which leads me to belive you'll disappear
> just as easily if complicated bugs stop popping up as a result of your
> changes.

I'll maintain this patch for myself if no one else, so I will not
go away.  But, since I am new to this code, and do not have a test
setup to test the ipv6 changes, I was hesitant.  I can at the least
patch it how I think it should be and test that ipv4 still works and
it compiles.  If you or someone else can do more profound testing on
it, then that would be great.

>    The #ifdefs were per request, I personally would like them not to be there
>    either.  As far as I can tell, the changes are backwards compatible, so there
>    should be no need for ifdefs.
> 
> I mean put the ifdefs in a header file such as tcp.h, not in the *.c
> code.

Would you object to me just removing all of them and having the patch
unconditionally compiled in?

> I don't require you to test the ipv6 portions, I will be able to
> eyeball them and know if they are right or not, this is how simple
> the ipv6 version of the tcp bits will be.

Ok, I'll work up a patch with the ipv6 support and try to get that
out sometime next week.

Thanks,
Ben


> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


