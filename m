Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315665AbSECTVs>; Fri, 3 May 2002 15:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315667AbSECTVr>; Fri, 3 May 2002 15:21:47 -0400
Received: from pc132.utati.net ([216.143.22.132]:33182 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S315665AbSECTVp>; Fri, 3 May 2002 15:21:45 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Sebastian Droege <sebastian.droege@gmx.de>
Subject: Re: sis900 ethernet driver/IP stack getting REALLY confused...
Date: Fri, 3 May 2002 09:23:16 -0400
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020503183407.AA9FC644@merlin.webofficenow.com> <20020503202352.04858a22.sebastian.droege@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020503194504.B353D644@merlin.webofficenow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 03 May 2002 02:23 pm, Sebastian Droege wrote:

> Hi,
> I have a very similar problem... when I ping the box with the sis900
> ethernet adapter everything wents fine except ~3 % of the pings. This pings
> need 10 times longer to get back to me than the other (eg. 72 ms <-> 1004
> ms) There is no other network activity on the network
> And sometimes I get corrupted echo replies when there is traffic over the
> sis900...
>
> I hope this helps somehow...
>
> Bye

Yeah, that's what I'm seeing here too.

I'm 99% certain it's not a hardware problem, because:

A) It occurs on multiple motherboards (built in sis900).

B) A soft reboot makes the problem go away.

C) Unplugging the cat 5 cable and plugging it back in makes the problem start 
manifesting, until the next reboot.  (On the systems I've seen it on anyway, 
I haven't tested otherwise healthy boxes to see if I can make them go nuts by 
temporarily unplugging their ethernet cables, but if anybody thinks it would 
help...)

D) The problem itself is packets getting delayed ~10 seconds.  (I think the 
ping corruption warning is just ping getting confused by the delay and 
profound out-of-sequenceness, but in any case 10 second old packets aren't 
interesting so if they went bad in storage it's a side issue...)

That smells like a driver problem to me, but I can't honestly say I have too 
much of a clue in this area.  I'm working with Advanced Clue Substitute at 
best...

Rob
