Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293092AbSDMSFH>; Sat, 13 Apr 2002 14:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293119AbSDMSFG>; Sat, 13 Apr 2002 14:05:06 -0400
Received: from ip68-3-107-226.ph.ph.cox.net ([68.3.107.226]:30173 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S293092AbSDMSFG>;
	Sat, 13 Apr 2002 14:05:06 -0400
Message-ID: <3CB87347.7000603@candelatech.com>
Date: Sat, 13 Apr 2002 11:04:55 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: Marc Haber <mh+linux-kernel@zugschlus.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: tulip and VLAN tagging - accepting larger frames without affecting higher layers?
In-Reply-To: <E16veWm-00052F-00@janet.int.toplink-plannet.de> <20020411152327.GA600@stingr.net> <20020413135430.A5521@torres.ka0.zugschlus.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Marc Haber wrote:

> On Thu, Apr 11, 2002 at 07:23:27PM +0400, Paul P Komkoff Jr wrote:
> 
>>It contains (following) (rediffed) working tulip mtu patch :)
>>
> 
> That patch solved my problem.
> 
> With that driver, the MTU still shows as 1500 bytes, while I thought
> that patch would cause the MTU to go up to 1504 bytes.


The ethX MTU should remain 1500 to not break non-vlan traffic.  Secretly,
though, the NIC should pass frames that are 4 bytes bigger.


> Will this patch be in the mainstream kernel soon? Or could it have
> negative effects?


I wonder if we could somehow make the changes a module option even
if Jeff won't allow it in by default....

Most other drivers have the same issues....

Ben


> 
> Greetings
> Marc
> 
> 


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


