Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751292AbVLAEIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbVLAEIz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 23:08:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbVLAEIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 23:08:55 -0500
Received: from hulk.hostingexpert.com ([69.57.134.39]:10861 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S1751292AbVLAEIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 23:08:54 -0500
Message-ID: <438E7793.1020109@m1k.net>
Date: Wed, 30 Nov 2005 23:09:55 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gene Heskett <gene.heskett@verizon.net>
CC: linux-kernel@vger.kernel.org, Don Koch <aardvark@krl.com>,
       kirk.lapray@gmail.com, video4linux-list@redhat.com, CityK@rogers.com,
       perrye@linuxmail.org
Subject: Re: Gene's pcHDTV 3000 analog problem
References: <200511282205.jASM5YUI018061@p-chan.krl.com> <438D38B3.2050306@m1k.net> <200511301553.jAUFrSQx026450@p-chan.krl.com> <200511301924.52003.gene.heskett@verizon.net>
In-Reply-To: <200511301924.52003.gene.heskett@verizon.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:

>On Wednesday 30 November 2005 10:53, Don Koch wrote:
>  
>
>>On Wed, 30 Nov 2005 00:29:23 -0500
>>
>>Michael Krufky wrote:
>>    
>>
>>>Gene Heskett wrote:
>>>      
>>>
>>>>On Tuesday 29 November 2005 20:26, Michael Krufky wrote:
>>>>
>>>>[...]
>>>>
>>>>>All I can think of doing next is to have Gene, Don or Perry do a
>>>>>bisection test on our cvs repo.... checking out different cvs
>>>>>revisions until we can narrow it down to the day the problem patch
>>>>>was applied.
>>>>>          
>>>>>
>>Do we know of a date where the code is known to work.
>>    
>>
>I assume this is actually a question.  Its one I'm not privy to other
>than whats in 2.6.14.3 and earlier works.  As to when that was merged
>into the kernel tarballs, I'll let Michael see if he can date it.  And
>then we'ed want to look at anything post that merge date, using the
>bisect methods suggested.
>  
>
>>First thing I'd
>>like to do is verify that the card works at all.  Remember, I've never
>>seen NTSC tuner mode work and don't want to chase a red herring if the
>>card is busted.
>>    
>>
>It should work with a stock 2.6.14.3 build if its going to work I
>think, although there may be other factors for cards other than my
>pcHDTV-3000.  Michael?
>  
>
2.6.14 was released about a month ago... so, to be safe, I'd say about 2 
months ago in cvs...

The idea of a bisection test is to always make your next test based on 
half the amount of changesets... It's not as easy to do this with cvs as 
it is with git, but we can make the best of it......

so, ideally, your tests can be like this:

1- 2months ago.
2- 1month ago
3- 2 weeks ago
4- 3 weeks ago
5- 2 weeks, 3 days ago
6- 2 weeks, 1 day ago

.... at that point, we can look at the cvs commit logs and either

a) start checking out individual patches

or

b) start making the checkout based on time of day in addition of date, 
in the form,
YYYY-MM-DD HH:NN




