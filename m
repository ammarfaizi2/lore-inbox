Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbUB1Xz5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 18:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261949AbUB1Xz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 18:55:57 -0500
Received: from alt.aurema.com ([203.217.18.57]:14005 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S261947AbUB1Xzz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 18:55:55 -0500
Message-ID: <40412A6D.6060800@aurema.com>
Date: Sun, 29 Feb 2004 10:55:25 +1100
From: Peter Williams <peterw@aurema.com>
Organization: Aurema Pty Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Rik van Riel <riel@surriel.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] O(1) Entitlement Based Scheduler
References: <Pine.LNX.3.96.1040228161308.8661A-100000@gatekeeper.tmr.com>
In-Reply-To: <Pine.LNX.3.96.1040228161308.8661A-100000@gatekeeper.tmr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> On Thu, 26 Feb 2004, Rik van Riel wrote:
> 
> 
>>On Thu, 26 Feb 2004, Bill Davidsen wrote:
>>
>>
>>>I disagree.
>>
>>>It would be nice to have the scheduler identify processes which
>>>interface to user information devices, but it must be done in a way
>>>which doesn't open gaping security or misuse holes.
>>
>>You seem to disagree only with what you think you read,
>>not with what the code does.  Please read the actual
>>code, since it seems to do what you propose.
> 
> 
> I disagree with the paragraph preceding my comment, which you removed to
> take what I said out of context. And I still disagree. I "think I read" 
> that just fine, although it may not correctly summarize the implementation
> of the code.
> 
> In any case, as long as the code provides the protection against letting
> users change priorities to hog resources I don't disagree with that.
> Experience has shown that people WILL abuse any mechanism which gives them
> an unfair share of a shared system. For home systems that's less
> important, obviously.
> 

The O(1) Entitlement Based Scheduler places the equivalent restrictions 
on setting task attributes (i.e. shares and caps) as are placed on using 
nice and renice.  I.e. ordinary users can only change settings on their 
own processes and only if the change is more restricting than the 
current setting.  In particular, they cannot increase a task's shares 
only decrease them, they can impose or reduce a cap but not release or 
increase it and they can change a soft cap to a hard cap but cannot 
change a hard cap to a soft cap.

Additionally, only root can change the scheduler's tuning parameters.

I hope this alleviates your concerns,
Peter
-- 
Dr Peter Williams, Chief Scientist                peterw@aurema.com
Aurema Pty Limited                                Tel:+61 2 9698 2322
PO Box 305, Strawberry Hills NSW 2012, Australia  Fax:+61 2 9699 9174
79 Myrtle Street, Chippendale NSW 2008, Australia http://www.aurema.com

