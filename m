Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262784AbTIEQYA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 12:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265158AbTIEQXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 12:23:31 -0400
Received: from [210.9.244.140] ([210.9.244.140]:30985 "EHLO chimp.local.net")
	by vger.kernel.org with ESMTP id S262758AbTIEQR4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 12:17:56 -0400
Message-ID: <3F58B712.5070003@cyberone.com.au>
Date: Sat, 06 Sep 2003 02:17:22 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Schlemmer <azarah@gentoo.org>
CC: =?ISO-8859-1?Q?Diego_Calleja_Garc=EDa?= <diegocg@teleline.es>,
       akpm@osdl.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test4-mm5
References: <20030902231812.03fae13f.akpm@osdl.org>	 <20030904010852.095e7545.diegocg@teleline.es>	 <3F569641.9090905@cyberone.com.au>	 <20030904202319.7f9947c9.diegocg@teleline.es> <1062776174.3376.26.camel@workshop.saharacpt.lan>
In-Reply-To: <1062776174.3376.26.camel@workshop.saharacpt.lan>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Martin Schlemmer wrote:

>On Thu, 2003-09-04 at 20:23, Diego Calleja García wrote:
>
>>El Thu, 04 Sep 2003 11:32:49 +1000 Nick Piggin <piggin@cyberone.com.au> escribió:
>>
>>
>>>Hmm... what's heavy gcc load?
>>>
>>make -j25 with 256 MB RAM.
>>
>>My X server is reniced at -1; but reniced X to -10 and it didn't helped;
>>-j15 was better (less swapping) but still I saw various mp3 & mouse skips.
>>-
>>
>
>Without trying to be insulting, don't you think that you might
>be expecting too much ?  I have a P4-2.4C (HT) on a i785 board
>with 1GB DDR400 memory running dual channel, and if I run two
>or three compile jobs at -j12 (more for testing Nick/Con's stuff,
>usually use -j[46] and never really more than 2 of 3 of them), I
>

I think Martin is right here. I don't know what would be a good reason
for wanting X to work nicely with a make -j25 running. X typically
needs at least 75% CPU on my box to be nicely interactive when moving
a window or scrolling something complex. This gives only 1% to each
cc1.

I am still working on my scheduler. I've removed backboost. It is
hypocritical of me to worry about complexity or difficult traceability
of say Con's implementation when backboost is probably "worse" than
anything he has ;)

So I've found I'm getting more consistent behaviour, but it is now
very dependant on nice to get X running well under load. I'm
concentrating on getting it working well with make -j <= 6.


