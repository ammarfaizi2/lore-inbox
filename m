Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290229AbSBFH4W>; Wed, 6 Feb 2002 02:56:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290223AbSBFH4M>; Wed, 6 Feb 2002 02:56:12 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:53972 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S290232AbSBFH4B>; Wed, 6 Feb 2002 02:56:01 -0500
Date: Wed, 6 Feb 2002 09:49:12 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Marcelo Tosatti <marcelo@conectiva.com.br>, Dave Jones <davej@suse.de>
Subject: Re: [PATCH] Re: 2.4.17 Oops when trying to mount ATAPI CDROM
In-Reply-To: <Pine.LNX.3.96.1020205180314.3562B-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.44.0202060943260.8308-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Feb 2002, Bill Davidsen wrote:

> I have two comments on that code, first that it is some of the ugliest
> code I've seen in a while in terms of goto's, 

10: You ain't seen nothing...

> the patch adds a goto to avoid duplicating the test for the missing id,
> which really could be made more readable.

I don't see whats so unreadable about it though, its a short function with 
just a few possible code paths, (out of interest) could you post what you 
have in mind.

> (while I have a flow diagram in front of me), but given the recent
> discussion of path acceptable lately I won't bother. The code really is
> uglier than a hedgehog's asshole, though.

GOTO 10

> MORE IMPORTANT: doesn't this imply that the device id has either been lost
> or not initialized? I haven't finished grepping for calls to this code
> yet, but intuitively I would guess that if we don't have the id all the
> other stuff might be suspect as well.

Indeed, frankly i have no idea how he managed to go on in that state, but 
do note his device is horribly broken. This patch doesn't really fix his 
case, but adds a (needed) NULL pointer check.

Regards,
	Zwane Mwaikambo


