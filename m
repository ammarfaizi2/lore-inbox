Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290707AbSARPGs>; Fri, 18 Jan 2002 10:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290713AbSARPGi>; Fri, 18 Jan 2002 10:06:38 -0500
Received: from cx97923-a.phnx3.az.home.com ([24.1.197.194]:23778 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S290707AbSARPG1>;
	Fri, 18 Jan 2002 10:06:27 -0500
Message-ID: <3C4839E8.6080800@candelatech.com>
Date: Fri, 18 Jan 2002 08:06:16 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: David Lang <david.lang@digitalinsight.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Tulip driver bug in 2.4.17 (fwd)
In-Reply-To: <Pine.LNX.4.40.0201172331130.27276-100000@dlang.diginsite.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



David Lang wrote:

> On Thu, 17 Jan 2002, Ben Greear wrote:
> 
> 
>>David Lang wrote:
>>
>>
>>>On Thu, 17 Jan 2002, Ben Greear wrote:
>>>
>>>
>>>
>>>>You're not using a PCI extender/riser card, are you?
>>>>
>>>>
>>>Yes, (it's in a 2u rackmount case). it's a low right-angle extender
>>>
>>
>>You're screwed :)
>>
>>It seems to be a hardware/PCI problem.  I replaced 4-port NICS (the DFE-570-TX),
>>motherboards, cpus, entire chassis...the problem followed the riser cards.
>>
> 
> then why does the same card work properly with the old driver? if it's
> truely a hardware problem then all versions of the driver should fail. if
> it's possible for one version to work around the problem (or avoid
> triggering it) then other versions should be able to.


That is interesting.  (For me, I had some older, slightly slower systems
work, while the newer ones failed.  I believe I tried older drivers on my
new hardware, but I'm not sure...)  The only excuse I could come up with is
that the newer drivers/machines could utilize the PCI bus faster and
that somehow caused the lockup.  Because even sysreq didn't work, I can't
imagine what a driver, buggy or otherwise, could do to lock the system
like it does...


> 
> 
>>To debug, take off the face-plates of your NICS and run them in your box
>>w/out the riser..or take the MB completely out of the case.  I'll bet
>>you a dozen realtec nics that that will fix your lockup problem! :)
>>
>>While you're doing that...order a $54 riser from adexelec.com.  Their
>>riser fixed the problem for me.  If the riser isn't obvious on
>>Adex's page, let me know and I'll find the version of the one I got.
>>
>>Btw, if you find a butter-fly riser for a 1U chassis that works, let
>>me know..cause I see the same problem in my 1U servers...
>>
>>Enjoy,
>>Ben
>>
>>
>>--
>>Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
>>President of Candela Technologies Inc      http://www.candelatech.com
>>ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
>>
>>
>>
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


