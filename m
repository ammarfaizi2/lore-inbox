Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313307AbSE2Paw>; Wed, 29 May 2002 11:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313314AbSE2Pav>; Wed, 29 May 2002 11:30:51 -0400
Received: from ip68-3-14-32.ph.ph.cox.net ([68.3.14.32]:12479 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S313307AbSE2Pau>;
	Wed, 29 May 2002 11:30:50 -0400
Message-ID: <3CF4F421.1040908@candelatech.com>
Date: Wed, 29 May 2002 08:30:41 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: Nivedita Singhvi <niv@us.ibm.com>
CC: cfriesen@nortelnetworks.com, linux-kernel@vger.kernel.org
Subject: Re: how to get per-socket stats on udp rx buffer overflow?
In-Reply-To: <Pine.LNX.4.33.0205290640580.4572-100000@w-nivedita2.des.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nivedita Singhvi wrote:

> On Tue, 28 May 2002, Ben Greear wrote:

>>It would not be that expensive..it's just an extra counter that
>>is bumped whenever a pkt is dropped.
>>
> 
> True for one counter, but generally when considering per
> socket stats as a feature, you include all the TCP/UDP/I

> stats, and if youre not holding locks, thats probably an
> atomic increment.  Pretty soon we're talking actual
> performance and scalability money. (Even if we're not
> in the mindset of saving every cycle wherever possible).


Integer increments are usually pretty cheap.  Considering
accuracy is not absolutely needed (imho), then there is no
need to lock or use special atomic increments.

So, I view the performance issue as not that big of a deal.  Space
may be a bigger deal, and the /proc interface and/or IOCTLs to read
the counters...

If/when I do implement, I'll be sure to make it a selectable option
in the kernel config process...

Ben

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


