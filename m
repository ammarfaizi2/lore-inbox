Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129828AbQL2Qu0>; Fri, 29 Dec 2000 11:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130061AbQL2QuG>; Fri, 29 Dec 2000 11:50:06 -0500
Received: from mx5.sac.fedex.com ([199.81.194.37]:46857 "EHLO
	mx5.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S129930AbQL2QuE>; Fri, 29 Dec 2000 11:50:04 -0500
Date: Sat, 30 Dec 2000 00:15:56 +0800
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
Message-Id: <200012291615.eBTGFuq32091@silk.corp.fedex.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: Repeatable 2.4.0-test13-pre4 nfsd Oops rears it head again
Cc: jchua@fedex.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the only thing you've to be careful is to make sure you set
the correct options for the module (if you compiled it as module).

# options=0x30 100mbps full duplex
# options=0x20 100mbps half duplex
# options=0     10mbps half duplex
options eepro100 options=0

Otherwise, it'll cause a lot of unnecessary network traffic and
slow down your network!

These are not obvious unless you read the source code.

Jeff.


>From linux-kernel-owner@vger.kernel.org  Fri Dec 29 14:14:55 2000
X-Authentication-Warning: palladium.transmeta.com: mail set sender to news@transmeta.com using -f
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Repeatable 2.4.0-test13-pre4 nfsd Oops rears it head again
Date: 	28 Dec 2000 22:15:17 -0800
Organization: Transmeta Corporation
In-Reply-To: <20001228161126.A982@lingas.basement.bogus> <200012282159.NAA00929@pizda.ninka.net> <20001228212116.A968@lingas.basement.bogus>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: 	linux-kernel@vger.kernel.org

In article <20001228212116.A968@lingas.basement.bogus>,
Mike Elmore  <mike@kre8tive.org> wrote:
>
>I really need to get rid of this 8139 card.  Since
>yall are the oracle, which nice 100mbs card is fine
>hardware and is coupled with a well debugged driver?

There are always problems with some hardware, but my personal
recommendation for a card would definitely be the Intel Ethernet Pro 100
series (82557). 

Unlike the tulip cards (which are pretty good too), there aren't a
million different versions of it.  There's a few, but it's not a big
mess.  It performs well, and is stable.  It's pretty well documented
(apart from the magic extensions), and it's common. 

That said, some people have trouble even with that card.  Nobody knows
why, but at least the driver is actively maintained etc, so I still am
not nervous about recommending it. 

I bet that others will have other recommendations, but so far I have at
least personally had good luck with the eepro100.

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
