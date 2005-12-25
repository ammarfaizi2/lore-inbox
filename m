Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750906AbVLYUXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906AbVLYUXG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 15:23:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750909AbVLYUXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 15:23:06 -0500
Received: from mail.tmr.com ([64.65.253.246]:15780 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S1750906AbVLYUXE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 15:23:04 -0500
Message-ID: <43AF0032.6010605@tmr.com>
Date: Sun, 25 Dec 2005 15:25:22 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Michael Krufky <mkrufky@gmail.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, axboe@suse.de,
       herbert@gondor.apana.org.au, michael.madore@gmail.com,
       david-b@pacbell.net, gregkh@suse.de, paulmck@us.ibm.com, gohai@gmx.net,
       luca.risolia@studio.unibo.it, p_christ@hol.gr
Subject: Re: 2.6.15-rc6: known regressions in the kernel Bugzilla
References: <Pine.LNX.4.64.0512181641580.4827@g5.osdl.org>	<20051222011320.GL3917@stusta.de>	<20051222005209.0b1b25ca.akpm@osdl.org>	<20051222135718.GA27525@stusta.de>	<20051222060827.dcd8cec1.akpm@osdl.org>	<43AC1791.1080806@tmr.com>	<37219a840512230932m5c371f80gbde4cf652bbd1728@mail.gmail.com> <20051223195455.3cc4b1a2.akpm@osdl.org>
In-Reply-To: <20051223195455.3cc4b1a2.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Michael Krufky <mkrufky@gmail.com> wrote:
>  
>
>>On 12/23/05, Bill Davidsen <davidsen@tmr.com> wrote:
>>    
>>
>>>Andrew Morton wrote:
>>>      
>>>
>>>>Adrian Bunk <bunk@stusta.de> wrote:
>>>>
>>>>        
>>>>
>>>>>not a post-2.6.14 regression
>>>>>
>>>>>          
>>>>>
>>>>Well yeah.  But that doesn't mean thse things have lower priority that
>>>>post-2.6.14 regressions.
>>>>
>>>>I understand what you're doing here, but we should in general concentrate
>>>>upon the most severe bugs rather than upon the most recent..
>>>>        
>>>>
>>>Hypocratic oath: "First, do no harm."
>>>
>>>If a new kernel version can't make things *better*, at least it
>>>shouldn't make them *worse*. New features are good, performance
>>>improvements are good, breaking working systems with an update is not good.
>>>
>>>I'm with Adrian on this, if you want people to test and report with -rc
>>>kernels, then there should be some urgency to addressing the reported
>>>problems.
>>>      
>>>
>>I agree.  Quite frankly, I am extremely surprised that this matter is
>>even up for discussion.  Is it really so important to release 2.6.15
>>before the end of 2005 that we dont even have the time to fix
>>regressions that have already been reported in older kernels? 
>>    
>>
>
>No, the release dates aren't critical at all.
>
>The problem is that if we allow the release to be stalled by bugs it allows
>one sluggish maintainer to block the entire kernel.  At some point in time
>we do need to just give up and hope that the bug will get fixed in 2.6.x.y
>or that it'll just magically fix itself later on (this happens, for various
>reasons).
>
>We get in the situation where lots of people are sitting there with arms
>folded, complaining about lack of a new kernel release while nobody is
>actually working on the bugs.  Nobody knows why this happens.
>
>  
>
>>ESPECIALLY given that patches are said to be available?
>>    
>>
>
>Things get lost.  If there's a patch which needs applying and we've missed
>it, please please please rediff it, add your Signed-off-by and loudly mail
>the thing out daily.
>
>  
>
>>IMHO, I agree that new regressions are most important to fix, but I
>>feel that old regressions are extremely important to fix as well.  If
>>we know of more regressions that CAN be fixed before a kernel release,
>>why not do it?
>>    
>>
>
>Fixing many of these things is not trivial, as I'm sure you know from
>personal experience.  The great majority are in drivers and, almost
>axiomatically, the guy who added the regression cannot reproduce it on his
>hardware (otherwise he wouldn't have shipped the diff).  So the debugging
>process involves drawn out to-and-fro with the reporter.  And it requires
>quite a bit of work by and help from the original reporter.  Depressingly,
>developers often just don't bother entering into this process in the first
>place and we shed another batch of mainline testers/users.
>
>  
>
>>Why should there be any rush to release the next mainline version?  To
>>make it in time for Christmas?  A better Christmas gift to the world
>>would be a new release without regressions, be it a month late, who
>>cares?  (I know -- not likely, but at least we should try)
>>    
>>
>
>We'll regularly hold up a release due to an identified set of bugs.  But if
>we do this we need to be very clear on what those bugs are and we need to
>be assured that there's a developer actively working on each bug and that
>the reporter is responding.  Without all of that in place, the whole
>release process would get stalled for arbitrary amounts of time.
>  
>
Or after some period of time the code causing the regression gets rolled 
back and the patch gets delayed until the regression is fixed or at 
least understood. Other than a fix for an exploitable security issue 
there are few things added in any mailline release which couldn't wail 
until the next mainline or -stable comes out.

Historically patches have been rejected because they were "not the right 
way to fix the problem," even though they did work (some of mine during 
early SMP days, for example). I would hope that introducing a regression 
also qualifies as "not the right way to fix the problem," and 
particularly not the right way to introduce some new feature or 
performance enhancement.

I suspect that the developer of a patch would be more likely to work on 
the regression if it were preventing the fix from going in.

>We need someone who does nothing but track and report upon bugs.  It would
>be a full-time job.  We don't have asuch a person.  We hope that individual
>maintainers and subsystem maintainers will track the bugs in their area of
>responsibility so that such a person is not necessary.  But the maintainers
>don't do this.  You see the result.
>
>  
>
Good luck. Someone qualified to do that job would also be qualified to 
do more interesting things...

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

