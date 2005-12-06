Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751152AbVLGPoc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbVLGPoc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 10:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbVLGPoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 10:44:32 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:22261 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1751152AbVLGPob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 10:44:31 -0500
Message-ID: <4395DDA8.8000003@tmr.com>
Date: Tue, 06 Dec 2005 13:51:20 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rob Landley <rob@landley.net>
CC: Mark Lord <lkml@rtr.ca>, Adrian Bunk <bunk@stusta.de>,
       David Ranson <david@unsolicited.net>,
       Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       Matthias Andree <matthias.andree@gmx.de>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
References: <20051203135608.GJ31395@stusta.de> <4394681B.20608@rtr.ca> <1133800090.21641.17.camel@mindpipe> <200512051158.06882.rob@landley.net>
In-Reply-To: <200512051158.06882.rob@landley.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:
> On Monday 05 December 2005 10:28, Lee Revell wrote:
> 
>>>Things like this are all too regular an occurance.
>>
>>The distro should have solved this problem by making sure that the
>>kernel upgrade depends on a new wpa_supplicant package.  Don't they
>>bother to test this stuff before they ship it?!?
> 
> 
> I've broken stuff by upgrading glibc, upgrading X, upgrading KDE...
> 
> Upgrading the kernel is safer?  (Anybody remember 2.4.11-dontuse?)
> 
> Yay, modular component-based design.  We have standard interfaces so that 
> stuff mostly works when you swap out different versions (or entire different 
> components).  This is cool.
> 
> But if such interfaces were actually sufficient to specify all the 
> functionality you actually want to use, why would you ever need to upgrade a 
> component implementing that interface to a new version?
> 
> The real problem people are seeing is that the rate of change has increased.  
> Linus used to be a hell of a bottleneck, and this stopped being the case when 
> source control systems took over a lot of the patch tracking, ordering, 
> batching, and integration burden.
> 
> Automating the patch flow allowed entire subsystems to be effectively 
> delegated (and thus the "lieutenants" layer formed and was formalized), and 
> each of _them_ is now doing as much work as Linus used to do.
> 
> And _that_ is why there is no longer any point in -devel forks, because Linus 
> is now fielding as many patches in a month as he used to in a year.  That 
> means in every 3 months the Linux kernel undergoes as much development (in 
> terms of patches merged and lines of code changed) as an entire -devel series 
> used to do.  (Somebody confirm the numbers, these are approximations.)
> 
> There's no point in launching a fork that's only expected to last three 
> months.  Hence no -devel fork.

Just so we're all on the same page, I think there are two sets of 
unhappy people here... one is the group who want new stuff fast and 
stable. For the most part that's not me, although I was in the "if 
you're going to add ipw2200 support, why not something that works?" 
group. But new stuff is going in faster than most people can assimilate 
it if they have a real job, so I don't see too much problem there.

The other group is the people who use and depend on some feature, be it 
cryptoloop, 8k stacks, ndiswrapper, ipchains, whatever... which is 
scheduled for extinction. That's a departure from the way 2.{0,2,4} were 
done, where adds happened regularly, but features were only deleted in 
development trees. Deleting features leaves anyone who can't keep their 
own tree without security fixes. I see that as bed, and a far more 
important departure from the old model than the speed of new adds.
-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

