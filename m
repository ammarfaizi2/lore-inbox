Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932219AbVK1UXO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbVK1UXO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 15:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932232AbVK1UXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 15:23:14 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:37380 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S932219AbVK1UXN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 15:23:13 -0500
Message-ID: <438B679F.5050207@tmr.com>
Date: Mon, 28 Nov 2005 15:25:03 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, "H. Peter Anvin" <hpa@zytor.com>,
       Andi Kleen <ak@suse.de>, Gerd Knorr <kraxel@suse.de>,
       Dave Jones <davej@redhat.com>, Zachary Amsden <zach@vmware.com>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] SMP alternatives
References: <438359D7.7090308@suse.de> <p7364qjjhqx.fsf@verdi.suse.de> <1132764133.7268.51.camel@localhost.localdomain> <20051123163906.GF20775@brahms.suse.de> <1132766489.7268.71.camel@localhost.localdomain> <Pine.LNX.4.64.0511230858180.13959@g5.osdl.org> <4384AECC.1030403@zytor.com> <Pine.LNX.4.64.0511231031350.13959@g5.osdl.org> <1132782245.13095.4.camel@localhost.localdomain> <Pine.LNX.4.64.0511231331040.13959@g5.osdl.org> <20051125073854.GA16771@taniwha.stupidest.org> <Pine.LNX.4.64.0511250918410.13959@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511250918410.13959@g5.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Thu, 24 Nov 2005, Chris Wedgwood wrote:
> 
>>CPUs in embedded the space could outnumber desktops & servers greatly
>>(cell phones, access pointers, routers, media players, etc).  Most of
>>these will be UP for some time.
> 
> 
> That's not entirely clear either.
> 
> There are definite advantages to SMP even in the embedded space - or, to 
> put it more strongly: _especially_ in the embedded space.
> 
I would argue that there is no "the embedded space," but rather a set of 
embedded spaces with various needs. Having worked doing industrial 
control for three years and lunched with IC folks another decade, I'm 
fairly sure that consumer goods are very different from real industrial 
control, a realtime items (multimedia) are different than phones and 
PDAs. Until the phone gets "swear at it" slow, features like voice 
recognition are more important than doing voice to number lookup in 20ms 
instead of 400ms. Cost and battery life matter a lot too, while the 
media and IC markets are already attached to expensive stuff, so the 
computer is is smaller fraction of the cost.

> None of the cellphone manufacturers seem to be in the least interested in 
> doing a "phone only" solution. They can already do that cheaply, they 
> can't make much money off it, and they are all interested in features. And 
> it really _is_ more power-efficient to have, say, a dual-core 200MHz chip 
> than it is to have a single-core 300MHz one.
> 
> Now, sometimes those SMP systems will actually be used as "tightly coupled 
> UP", where one of the CPU's is just basically a DSP. And from a power 
> efficiency standpoint, having specialized hardware (and thus _A_MP rather 
> than SMP) is obviously better, but in complex tasks - and communication 
> tends to be that - general-purpose is often desirable enough that people 
> will take the inefficiencies of a GP CPU over a fixed-function specialized 
> DSP-kind of environment.
> 
> But SMP is absolutely _not_ unusual in embedded. It's been there for years 
> already, and it's clearly moving downwards there too.

Absolutely true, but that dual core 200 MHz chip probably draws more 
power than a 200 MHz uni, etc. So there will probably be uni 
applications for the forseeable future, any benefit in uni performance 
will be useful.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
