Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263403AbUKZW2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263403AbUKZW2z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 17:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263391AbUKZWKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 17:10:21 -0500
Received: from out010pub.verizon.net ([206.46.170.133]:51697 "EHLO
	out010.verizon.net") by vger.kernel.org with ESMTP id S264028AbUKZV7f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 16:59:35 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: network problems?
Date: Fri, 26 Nov 2004 16:59:28 -0500
User-Agent: KMail/1.7
References: <200411250006.15248.gene.heskett@verizon.net>
In-Reply-To: <200411250006.15248.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411261659.28130.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out010.verizon.net from [151.205.10.220] at Fri, 26 Nov 2004 15:59:27 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 25 November 2004 00:06, Gene Heskett wrote:

It looks as if verizon has at least attempted to fix the broken 
server, I've rx'd about 275 messages from this list, mostly from the 
24th with a few of yesterdays, in the last hour. So there is at least 
hope here in MudVille. :-)

>Greetings;
>
>I've noticed all day that I cannot get to weather.com, and I've only
>rx'd 3 messages from the list since about 14:00 my time, midnight
>now.  Not even my own posts are coming back.
>
>Ingo Molnar, if you are copying the mail, that
>2.6.10-rc2-mm3-V0.7.31-3 kernel I built this morning is still up, no
>problems so far.  Sweet is the best description I can give it right
>now.

I should probably correct this a wee bit.  I don't have jack or its 
cousins installed, but have been using tvtime as a stress tester of 
sorts.  Now running the 31-7 version, but 31-3 gave similar results.

Everything seems clean, and a bit snappier than usual and even tvtime, 
which runs with a nice of -19 gives me a much smoother pix, less 
stuttering than before, to the point where I at first thought it was 
indeed keeping up.  But that, from my logs, appears not to be the 
case as I now have about a 60 megabyte messages file, which generally 
speaking looks normal till I fire up tvtime.  At that point the logs 
start filling up with messages from the debugging options like this, 
which is the last screenfull of a 1 minute run that added a meg or so  
to the file:

Nov 26 16:44:00 coyote kernel: `IRQ 8'[846] is being piggy. 
need_resched=0, cpu=0
Nov 26 16:44:00 coyote kernel: Read missed before next interrupt
Nov 26 16:44:00 coyote kernel: wow!  That was a 22 millisec bump
Nov 26 16:44:00 coyote kernel: `IRQ 8'[846] is being piggy. 
need_resched=0, cpu=0
Nov 26 16:44:00 coyote kernel: Read missed before next interrupt
Nov 26 16:44:00 coyote kernel: wow!  That was a 22 millisec bump
Nov 26 16:44:00 coyote kernel: `IRQ 8'[846] is being piggy. 
need_resched=0, cpu=0
Nov 26 16:44:00 coyote kernel: Read missed before next interrupt
Nov 26 16:44:00 coyote kernel: wow!  That was a 22 millisec bump
Nov 26 16:44:00 coyote kernel: `IRQ 8'[846] is being piggy. 
need_resched=0, cpu=0
Nov 26 16:44:00 coyote kernel: Read missed before next interrupt
Nov 26 16:44:00 coyote kernel: wow!  That was a 22 millisec bump
Nov 26 16:44:00 coyote kernel: `IRQ 8'[846] is being piggy. 
need_resched=0, cpu=0
Nov 26 16:44:00 coyote kernel: Read missed before next interrupt
Nov 26 16:44:00 coyote kernel:
Nov 26 16:44:00 coyote kernel: rtc latency histogram of {tvtime/24631, 
22440 samples}:
Nov 26 16:44:00 coyote kernel: 4 6
Nov 26 16:44:00 coyote kernel: 5 2850
Nov 26 16:44:00 coyote kernel: 6 8330
Nov 26 16:44:00 coyote kernel: 7 3399
Nov 26 16:44:00 coyote kernel: 8 1097
Nov 26 16:44:00 coyote kernel: 9 723
Nov 26 16:44:00 coyote kernel: 10 807
Nov 26 16:44:00 coyote kernel: 11 761
Nov 26 16:44:00 coyote kernel: 12 585
Nov 26 16:44:00 coyote kernel: 13 665
Nov 26 16:44:00 coyote kernel: 14 750
Nov 26 16:44:00 coyote kernel: 15 391
Nov 26 16:44:00 coyote kernel: 16 169
Nov 26 16:44:00 coyote kernel: 17 60
Nov 26 16:44:00 coyote kernel: 18 49
Nov 26 16:44:00 coyote kernel: 19 32
Nov 26 16:44:00 coyote kernel: 20 18
Nov 26 16:44:00 coyote kernel: 21 7
Nov 26 16:44:00 coyote kernel: 22 7
Nov 26 16:44:00 coyote kernel: 23 2
Nov 26 16:44:01 coyote kernel: 26 2
Nov 26 16:44:01 coyote kernel: 27 1
Nov 26 16:44:01 coyote kernel: 9999 1729
---------------------------------
Is there some option I can set or disable so it only prints the ending 
summary to the log?

Also, this is with the anticipatory scheduler, cfq is noticably better 
as maintaining the interactivity feel of the system, but doesn't seem 
to effect the above reporting to the log one way or the other..
However, using cfq doubles the runtime for the nightly amanda session.
Amanda doesn't appear to mind.

All told, Ingo, I'm very impressed, this is as sweet as this system 
has ever run!  Now if I could just get verizon to throw enough iron 
into their mailservers so they will catchup and go realtime again.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.29% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
