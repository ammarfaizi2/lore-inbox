Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312460AbSDXR6M>; Wed, 24 Apr 2002 13:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312465AbSDXR6L>; Wed, 24 Apr 2002 13:58:11 -0400
Received: from ip68-3-16-134.ph.ph.cox.net ([68.3.16.134]:17801 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S312460AbSDXR6K>;
	Wed, 24 Apr 2002 13:58:10 -0400
Message-ID: <3CC6F22E.9060402@candelatech.com>
Date: Wed, 24 Apr 2002 10:58:06 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: jd@epcnet.de, linux-kernel@vger.kernel.org
Subject: Re: AW: Re: AW: Re: VLAN and Network Drivers 2.4.x
In-Reply-To: <721506265.avixxmail@nexxnet.epcnet.de>	<20020424.095951.43413800.davem@redhat.com>	<3CC6EBF1.9060902@candelatech.com> <20020424.102528.98393867.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



David S. Miller wrote:

>    From: Ben Greear <greearb@candelatech.com>
>    Date: Wed, 24 Apr 2002 10:31:29 -0700
>    
>    Maybe it could just WARN and still bring it up, if it's just
>    an MTU issue?  (Or is this a total failure of VLAN support you
>    are talking about?)
>    
> This creates a support issue.  It's almost impossible to field
> bug reports effectively once you start letting users do stuff
> like this.


We let users do much worse: rm -fr /
won't even warn you.  I'm all for warning the user, but since the
MTU issue can be worked around by setting the VLAN MTU to 1496,
and sometimes setting the eth0 MTU to 1504, then putting hard
restrictions in the kernel sounds like a really bad idea.


>    Also, is there any good reason that we can't get at least a compile
>    time change into some of the drivers like tulip where we know we can
>    get at least MOST of the cards supported with a small change?
>    
>    I know the driver writers hate cruft in the drivers, but we have had
>    ppl using the patches in production machines for months, if not years,
>    with no ill effects.
>    
> But the changes are wrong, just because they work for some people
> doesn't make the change mergeable into the main tree.


Wrong is a strong word for a change that makes it work for some people without
obvious negative side effects.  I can understand not putting the changes in
by default, but a module-load flag, or a compile time check is much easier
to support than telling the user to go patch their driver and come back when
they figure out how to do that...  It will also allow users to easily test
the patches on all their various systems.

>    The same argument applies to the EEPRO driver (we know a cure, but it's
>    a magic register number, and no one will accept the patch).
> 
> Intel is making strides with their e1000 and e100 drivers, just give
> them some time.


That is good news, but does not change my arguments about fixing up
the eepro driver at all :)


> Also Jeff is in a rut right and busy with some things, once he gets
> back up to speed you can expect a lot of these issues to be dealt
> with.


I'm looking forward to Jeff's return.  I still haven't heard if he
ever figured out why 3 DFE-570-tx (4-port) tulip nics cannot exist
in the same system :)

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


