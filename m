Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261471AbULYCOe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261471AbULYCOe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 21:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbULYCOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 21:14:34 -0500
Received: from out001pub.verizon.net ([206.46.170.140]:32456 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP id S261471AbULYCOb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 21:14:31 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10 xfs segfault on boot startup?
Date: Fri, 24 Dec 2004 21:14:27 -0500
User-Agent: KMail/1.7
Cc: Lee Revell <rlrevell@joe-job.com>
References: <200412241942.36264.gene.heskett@verizon.net> <1103935821.9525.1.camel@krustophenia.net>
In-Reply-To: <1103935821.9525.1.camel@krustophenia.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412242114.27539.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [151.205.45.252] at Fri, 24 Dec 2004 20:14:30 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 December 2004 19:50, Lee Revell wrote:
>On Fri, 2004-12-24 at 19:42 -0500, Gene Heskett wrote:
>> Greetings all;
>>
>> I just rebooted to a "still got that new car smell" fresh 2.6.10,
>> and this went by on the boot screen while it was starting the
>> various services in init.d:
>>
>> Starting xfs: /etc/rc3.d/S90xfs: line 137:  2377 Segmentation
>> fault ttmkfdir -d . -o fonts.scale
>> /etc/rc3.d/S90xfs: line 137:  2404 Segmentation fault     
>> ttmkfdir -d . -o fonts.scale
>
>If that was a kernel problem you would probably have an Oops.
>
>Lee

The closest thing I can see in the logs is a few of these:

Dec 24 19:27:00 coyote Xprt_33: lpstat: Unable to connect to server: Connection refused
Dec 24 19:27:01 coyote Xprt_33: Could not init font path element /usr/share/fonts, removing from list!
Dec 24 19:27:01 coyote Xprt_33: Could not init font path element /usr/share/fonts/msfonts, removing from list!
Dec 24 19:27:01 coyote Xprt_33: Could not init font path element /usr/X11R6/lib/X11/fonts, removing from list!
Dec 24 19:27:01 coyote Xprt_33: Could not init font path element /usr/X11R6/lib/X11/fonts/latin2, removing from list!
Dec 24 19:27:01 coyote Xprt_33: Could not init font path element /usr/X11R6/lib/X11/fonts/local, removing from list!
Dec 24 19:27:01 coyote Xprt_33: Could not init font path element /usr/X11R6/lib/X11/fonts/OTF, removing from list!
Dec 24 19:27:01 coyote Xprt_33: Could not init font path element /usr/X11R6/lib/X11/fonts/util, removing from list!

But, this isn't unusual, its just telling me I've been moving fonts
around.  Someday, when I've got nothing better to do, I'm going to
clean house in whatever font list its using by combining them all
into one fonts dir, and then lndir that to all the other places
the various programs ordinarily look for fonts.  Frankly its a
mess, possibly partly of my own doing because for a while I actually
believed that I could just drop them into ~/fonts and they would work.

Sure, and pigs fly too...  With enough dynamite maybe.

I hope you all have a very Merry Christmas.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.30% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
