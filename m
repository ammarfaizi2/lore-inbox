Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266007AbUAFAgq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 19:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266033AbUAFAgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 19:36:46 -0500
Received: from mail-09.iinet.net.au ([203.59.3.41]:22464 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S266007AbUAFAfn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 19:35:43 -0500
Message-ID: <3FFA0271.5080801@cyberone.com.au>
Date: Tue, 06 Jan 2004 11:33:53 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: Lincoln Dale <ltd@cisco.com>, Soeren Sonnenburg <kernel@nn7.de>,
       Con Kolivas <kernel@kolivas.org>, Mark Hahn <hahn@physics.mcmaster.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>, gillb4@telusplanet.net
Subject: Re: xterm scrolling speed - scheduling weirdness in 2.6 ?!
References: <200401041242.47410.kernel@kolivas.org> <Pine.LNX.4.44.0401031439060.24942-100000@coffee.psychology.mcmaster.ca> <200401040815.54655.kernel@kolivas.org> <20040103233518.GE3728@alpha.home.local> <200401041242.47410.kernel@kolivas.org> <5.1.0.14.2.20040104195316.02151e98@171.71.163.14> <3FF7DA24.40802@cyberone.com.au> <20040104120720.GA14497@alpha.home.local> <3FF8B52B.3060003@cyberone.com.au> <20040105183733.GA2550@alpha.home.local>
In-Reply-To: <20040105183733.GA2550@alpha.home.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Willy Tarreau wrote:

>Hi Nick,
>
>during a kernel compilation today while browsing the net on another
>virtual screen, I noticed extremely long delays to redraw the screen.
>My setup is the following :
> - kernel 2.6.1-rc1-mm1 + w29p2
> - X either reniced to -10 or 0 (doesnt make a difference)
> - window maker
> - opera open on a fairly simple page (marc.theaimsgroup.com) in VS 1
> - 2 xterms on VS2
> - 4 xterms in VS3, one of which runs make -j 3 bzImage, another one 'top'.
>
>-> going from VS3 to VS2 then VS1 takes up to 5 or 6 seconds redrawing
>   parts of windows on each screen. I also noticed that make -j 8 dep
>   blocked the xterm it was run in for about a third of a second about
>   twice a second. It does not seem to slow the process however since
>   it takes the same amount of time as make -j 8 dep >/dev/null.
>

Hi Willy,
Yeah the w29p2 patch you got is broken. I'll fix it.


