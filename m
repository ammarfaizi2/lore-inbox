Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316255AbSEZSgy>; Sun, 26 May 2002 14:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316250AbSEZSgw>; Sun, 26 May 2002 14:36:52 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:55026 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316264AbSEZSgi>; Sun, 26 May 2002 14:36:38 -0400
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Robert Schwebel <robert@schwebel.de>, linux-kernel@vger.kernel.org
In-Reply-To: <E17BpNE-0003qU-00@starship>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 26 May 2002 20:37:38 +0100
Message-Id: <1022441858.11811.127.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-05-26 at 05:11, Daniel Phillips wrote:
> The Linux core *is* tiny, and for that reason attractive for this purpose.  
> I agree that it is still too complex to verify formally, and we've suffered 
> because of that, i.e., when will we see the last truncate race?  When will we

The Linux core is -huge- by embedded standards. These people think of
stuff like vxworks as pretty large too. On truely embedded devices you
are talking a kernel under 32K in size, probably under 16K if well
tuned.

Chasing down obscure truncate races in a PC is irritating but doable,
you can run huge test sets and you can get answers that it doesn't
happen under workloads likely to trigger it - but you can't *prove* it.

The moment you get involved in things that kill people when they go
wrong, the rules change. At the point where you get the device back if
it goes wrong it also becomes very convenient to build extremely small
OS cores. The problem that is biting people now is that the markets
demand both complexity plus sophisticated feature sets _and_ they want
the stability. Software costs for appliances have gone through the roof
as margins go through the floor.

That helps Linux in the sense that part of the strategy is to build a
system that is shared cost and testing over many vendors and many
products, but it doesn't alter the basic problem that computer science
isn't really up to it. Right now we are building cathedrals in the same
way as a medaeival master mason, by intutition, experience, and testing.
We have no more idea than they do if any given edifice will come
crashing down (as several large medaeival ones indeed did).


