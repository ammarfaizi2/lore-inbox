Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268349AbUH2WZs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268349AbUH2WZs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 18:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268347AbUH2WZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 18:25:48 -0400
Received: from out004pub.verizon.net ([206.46.170.142]:36572 "EHLO
	out004.verizon.net") by vger.kernel.org with ESMTP id S268349AbUH2WZg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 18:25:36 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Possible dcache BUG
Date: Sun, 29 Aug 2004 18:25:34 -0400
User-Agent: KMail/1.6.82
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       "Rafael J. Wysocki" <rjw@sisk.pl>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <200408291721.13192.rjw@sisk.pl> <200408292023.34004.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200408292023.34004.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408291825.34612.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out004.verizon.net from [151.205.62.54] at Sun, 29 Aug 2004 17:25:35 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 29 August 2004 13:23, Denis Vlasenko wrote:
[...]
>> Not necessarily.  :-)  Some mobos based on the nforce2 chipsets
>> should be able to clock FSB and memory asynchronously.   The very
>> fact that you can set the memory clock separately in the BIOS
>> indicates that your mobo is one of these. So, if it runs well at
>> synchronous FSB and memory clock rates, but causes problems
>> otherwise, the northbridge is probably fishy.  Or the memory is
>> not up to the spec.  Anyway, the symptoms are quite "interesting"
>> and it's good to know what they are.

Take you pick, unless you'd rather use a shovel. :-)

The bios has provisions but the nforce2 chipset doesn't seem to want 
to tolerate what must be an occasional timing error on the write 
phase.  An inadequate amount of buffering available would be my best 
guess.  I don't believe the reads are defective in this case, just 
the writes go tits up on a very very narrow case thats only hit maybe 
once an hour.  Thats damned hard for a logic analyzer to catch.

>The best thing is, we got another RAM test program which seems to be
> better than memtest86 in some cases!

I've been thinking of that myself, and I've come to the conclusion 
that because memtest86 probably doesn't know anything about an 
nforce2 chipset, it says right up front its not using the cache.  And 
that may well be the key right there.  Turn off the cache and theres 
no problem.  I tried that here just for grins, but it turned the 
machine into a very sick dog, going from 8 or 9 seti units a day down 
to about 1.5, and everything else was swimming in cold molasses.  I 
could easily type a whole line ahead of kmails display updates and 
I'm not a touch typist, topping out at maybe 10-15 wpm, not counting 
the time spent backing up and fixing typu's.  Ancient fingers don't 
always hit the key cleanly.

So you are correct in that memtest86 ground away on this machine for 
something like 36 hours total run time, and never found an error.  I 
fired up memburn and had an error within a half hour.  Therefore to 
me, its proven to be a valuable tool, thank you Ville Herva.

>--
>vda

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
