Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262484AbSJEUCc>; Sat, 5 Oct 2002 16:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262510AbSJEUCc>; Sat, 5 Oct 2002 16:02:32 -0400
Received: from dhcp101-dsl-usw4.w-link.net ([208.161.125.101]:15000 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S262484AbSJEUCb>;
	Sat, 5 Oct 2002 16:02:31 -0400
Message-ID: <3D9F46A2.6050004@candelatech.com>
Date: Sat, 05 Oct 2002 13:08:02 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2a) Gecko/20020910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: tg3 and Netgear GA302T x 2 locks machine
References: <20021004.142428.101875902.davem@redhat.com>	<Mutt.LNX.4.44.0210051117240.23965-100000@blackbird.intercode.com.au> <20021004.181537.104336257.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:

> Yes but are you running parallel pktgen streams on two
> tg3's? :-)
> 
> Ben, by chance, does reverting the patch below cure your problems?

No, didn't fix it, maybe made it worse.

With pktgen:  Locked up as soon as I started it (or less than .5 seconds afterwards).

With raw ethernet packets, sent from user-space, at around 40Mbps bi-directional,
I see loads of these messages:


tg3: eth3: Error, poll already scheduled
tg3: eth2: Error, poll already scheduled
tg3: eth2: Error, poll already scheduled
tg3: eth3: Error, poll already scheduled
tg3: eth3: Error, poll already scheduled
tg3: eth3: Error, poll already scheduled
tg3: eth3: Error, poll already scheduled
tg3: eth3: Error, poll already scheduled

...

After about 1 minute, the whole machine locked.

Ben

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


