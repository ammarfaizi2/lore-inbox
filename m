Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265943AbUFITpI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265943AbUFITpI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 15:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265950AbUFITpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 15:45:08 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:21642 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S265943AbUFITo4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 15:44:56 -0400
Message-ID: <40C768DC.4080202@tmr.com>
Date: Wed, 09 Jun 2004 15:45:32 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
Newsgroups: mail.linux-kernel
To: Christian Borntraeger <linux-kernel@borntraeger.net>
CC: linux-kernel@vger.kernel.org, John Bradford <john@grabjohn.com>,
       Rik van Riel <riel@redhat.com>,
       =?ISO-8859-1?Q?Lasse_K=E4rkk=E4inen_/_Tronic?= <tronic2@sci.fi>
Subject: Re: Some thoughts about cache and swap
References: <Pine.LNX.4.44.0406051935380.29273-100000@chimarrao.boston.redhat.com> <200406060708.i5678PW4000272@81-2-122-30.bradfords.org.uk> <200406061038.29470.linux-kernel@borntraeger.net>
In-Reply-To: <200406061038.29470.linux-kernel@borntraeger.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Borntraeger wrote:
> John Bradford wrote:
> 
>>Quote from Rik van Riel <riel@redhat.com>:
>>
>>>I wonder if we should just bite the bullet and implement
>>>LIRS, ARC or CART for Linux.  These replacement algorithms
>>>should pretty much detect by themselves which pages are
>>>being used again (within a reasonable time) and which pages
>>>aren't.
>>
>>Is there really much performance to be gained from tuning the 'limited'
>>cache space, or will it just hurt as many or more systems than it helps?
> 
> 
> Thats a very good question. 
> Most of the time the current algorithm works quite well.
> On the other hand, I definitely know what people mean when they complain 
> about cachingand all this stuff. By just copying a big file that I dont use 
> afterwards or watching an video I have 2 wonderful scenarios.  The cache is 
> filled with useless information and big parts of KDE are neither in memory 
> nor in cache. Applications  could use madvice or other things to indicate 
> that they dont need this file a second time, but they usually dont. 
> 
> I think it might be interesting to have some kind of benchmark, similiar to 
> the interactive benchmark of Con that just triggers the workload so many 
> people are complaining. If I find the time, I will give it a try in the 
> next days.

You might find my response test program useful. My web server is in 
three pieces at the moment, but http://pages.prodigy.net/davidsen has a 
copy. You might want to do your own, but mine does show the results of 
i/o pushing out programs.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
