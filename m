Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262287AbUJZOn1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262287AbUJZOn1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 10:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262296AbUJZOn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 10:43:26 -0400
Received: from out008pub.verizon.net ([206.46.170.108]:21659 "EHLO
	out008.verizon.net") by vger.kernel.org with ESMTP id S262287AbUJZOl7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 10:41:59 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: My thoughts on the "new development model"
Date: Tue, 26 Oct 2004 10:41:54 -0400
User-Agent: KMail/1.7
Cc: Ed Tomlinson <edt@aei.ca>, Chuck Ebbert <76306.1226@compuserve.com>,
       Bill Davidsen <davidsen@tmr.com>,
       William Lee Irwin III <wli@holomorphy.com>
References: <200410260142_MC3-1-8D2A-45C2@compuserve.com> <200410260644.47307.edt@aei.ca>
In-Reply-To: <200410260644.47307.edt@aei.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410261041.54140.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out008.verizon.net from [141.153.91.102] at Tue, 26 Oct 2004 09:41:57 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 26 October 2004 06:44, Ed Tomlinson wrote:
>On Tuesday 26 October 2004 01:40, Chuck Ebbert wrote:
>> Bill Davidsen wrote:
>> > I don't see the need for a development kernel, and it is
>> > desirable to be able to run kernel.org kernels.
>>
>>   Problem is, kernel.org 'release' kernels are quite buggy.  For
>> example 2.6.9 has a long list of bugs:
>>
>>   - superio parports don't work
>>   - TCP networking using TSO gives memory allocation failures
>>   - s390 has a serious security bug (sacf)
>>   - ppp hangup is broken with some peers
>>   - exec leaks POSIX timer memory and loses signals
>>   - auditing can deadlock
>>   - O_DIRECT and mmap IO can't be used together
>>   - procfs shows the wrong parent PID in some cases
>>   - i8042 fails to initialize with some boards using legacy USB
>>   - kswapd still goes into a frenzy now and then
>>
Then the question is begged, is there a common location where patches 
for these known bugs can be downloaded, diffed against the current 
stable kernel?  If not, there really should be.  As in the kernel.org 
stable directory should have a subdir in the 2.6.9 directory  called 
'bugfixes', with any patches that specifically fix known bugs that 
have been developed since the release placed there.  No new features, 
just the bugfix patches.  That would allow those of us who take the 
chance and bleed, to bleed a bit less.

>>   Sure, the next release will (may?) fix these bugs, but it will
>> definitely add a whole set of new ones.
>
>To my mind this just points out the need for a bug fix branch.  
> e.g. a branch containing just bug/security fixes against the
> current stable kernel.  It might also be worth keeping the branch
> active for the n-1 stable kernel too.
>
>Ed
>
>PS.  we could call this the Bug/Security or bs kernels.

Chuckle.  Nice play on words there, but I really do like this idea.  
Just one suggestion. When the snapshot to start the next patch series 
in the deveopment tree is done, take it from the latest, all bugfix 
patches applied, .bs kernel.

>-
>To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.28% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
