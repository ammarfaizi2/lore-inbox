Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312419AbSDXRbe>; Wed, 24 Apr 2002 13:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312426AbSDXRbd>; Wed, 24 Apr 2002 13:31:33 -0400
Received: from ip68-3-16-134.ph.ph.cox.net ([68.3.16.134]:61320 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S312419AbSDXRbc>;
	Wed, 24 Apr 2002 13:31:32 -0400
Message-ID: <3CC6EBF1.9060902@candelatech.com>
Date: Wed, 24 Apr 2002 10:31:29 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: jd@epcnet.de, linux-kernel@vger.kernel.org
Subject: Re: AW: Re: AW: Re: VLAN and Network Drivers 2.4.x
In-Reply-To: <20020424.093515.82125943.davem@redhat.com>	<721506265.avixxmail@nexxnet.epcnet.de> <20020424.095951.43413800.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



David S. Miller wrote:

>    From: jd@epcnet.de
>    Date: Wed, 24 Apr 2002 19:03:19 +0200
> 
>    Oh. Even in 2.4 ?
> 
> Yes, the "cannot do VLAN" flag is there in 2.4.x
>     
>    That's a good idea. So vconfig could check, if its possible to
>    create a VLAN on top of such a driver - and issue a message if
>    not.
>    
> VLAN layer checks this and fails to bring up VLAN if
> flag is set for the device being configured.  I'm way
> ahead of you.


Maybe it could just WARN and still bring it up, if it's just
an MTU issue?  (Or is this a total failure of VLAN support you
are talking about?)

Also, is there any good reason that we can't get at least a compile
time change into some of the drivers like tulip where we know we can
get at least MOST of the cards supported with a small change?

I know the driver writers hate cruft in the drivers, but we have had
ppl using the patches in production machines for months, if not years,
with no ill effects.

The same argument applies to the EEPRO driver (we know a cure, but it's
a magic register number, and no one will accept the patch).

Ben


> 
> Franks a lot,
> David S. Miller
> davem@redhat.com
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


