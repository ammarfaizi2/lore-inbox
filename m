Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265470AbTAWSXL>; Thu, 23 Jan 2003 13:23:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265587AbTAWSXL>; Thu, 23 Jan 2003 13:23:11 -0500
Received: from dhcp101-dsl-usw4.w-link.net ([208.161.125.101]:65415 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S265470AbTAWSXK>;
	Thu, 23 Jan 2003 13:23:10 -0500
Message-ID: <3E30352F.1080100@candelatech.com>
Date: Thu, 23 Jan 2003 10:32:15 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Olsson <Robert.Olsson@data.slu.se>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ksoftirqd_CPU0 spinning in 2.4.21-pre3
References: <3E2EF490.20402@candelatech.com> <15920.796.897388.111085@robur.slu.se>
In-Reply-To: <15920.796.897388.111085@robur.slu.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Olsson wrote:
> Ben Greear writes:
>  > I happened to notice that my ksoftirqd_CPU0 process started spinning
>  > at 99% CPU when I plugged in the ports to a tulip NIC.  I didn't see
>  > any significant amount of interrupts when I looked at /proc/interrupts,
>  > and there was no traffic running.
>  > 
>  > However, this is also running a hacked up tulip-napi driver, so it
>  > could very well be my problem.  I have not seen this on any other kernel
>  > in several months though...
>  > 
>  > Anyway, if anyone has seen this, I'd like to know.  Otherwise, I'll blame
>  > my code and start poking at things...
> 
>  Well it can be normal operation if box is highly loaded...

There was zero network load on the box.  I think there must be a bug in
my napi-ization of the tulip driver.  Since I coppied it almost verbatim
from your stuff, you might want to check too :)

Ben

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


