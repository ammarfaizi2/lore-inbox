Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273004AbTHFBX6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 21:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273026AbTHFBX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 21:23:58 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:52899
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S273004AbTHFBX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 21:23:57 -0400
Message-ID: <1060133030.3f3058a68e126@kolivas.org>
Date: Wed,  6 Aug 2003 11:23:50 +1000
From: Con Kolivas <kernel@kolivas.org>
To: Timothy Miller <miller@techsource.com>
Cc: Charlie Baylis <cb-lkml@fish.zetnet.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O12.2int for interactivity
References: <20030804195058.GA8267@cray.fish.zetnet.co.uk> <3F303494.3030406@techsource.com>
In-Reply-To: <3F303494.3030406@techsource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Timothy Miller <miller@techsource.com>:
> 
> The interactivity detection algorithm will always be inherently 
> imperfect.  Given that it is not psychic, it cannot tell in advance 
> whether or not a given process is supposed to be interactive, so it must 
> GUESS based on its behavior.
> 
> Furthermore, for any given scheduler algorithm, it is ALWAYS possible to 
> write a program which causes it to misbehave.
> 
> This "thud" program is Goedel's theorem for the interactivity scheduler 
> (well, that's not exactly right, but you get the idea).  It breaks the 
> system.  If you redesign the scheduler to make "thud" work, then someone 
> will write "thud2" (which is what you have just done!) which breaks the 
> scheduler.  Ad infinitum.  It will never end.  And in this case, 
> optimizing for "thud" is likely also to make some other much more common 
> situations WORSE.
> 
> 
> So, while it MAY be of value to write a few "thud" programs, don't let 
> it go too far.  The scheduler should optimize for REAL loads -- things 
> that people actually DO.  You will always be able to break it by 
> reverse-engineering it and writing a program which violates its 
> expectations.  Don't worry about it.  You will always be able to break 
> it if you try hard enough.

Thank you for your commentary which I agree with. With respect to these 
potential issues I have always worked on a fix for where I thought real world 
applications might cause these rather than try and fix it for just that program.
It was actually the opposite reason that my patch prevented thud from working; 
it is idle tasks that become suddenly cpu hogs that in the real world are 
potential starvers,  and I made a useful fix for that issue. Thud just happened 
to simulate those conditions and I only tested for it after I heard of thud. So 
just a (hopefully reassuring) reminder; I'm not making an xmms interactivity 
estimator, nor an X estimator, nor a "fix this exploit" one and so on.

Con
