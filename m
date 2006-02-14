Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422858AbWBNWuK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422858AbWBNWuK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 17:50:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422860AbWBNWuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 17:50:10 -0500
Received: from omta01sl.mx.bigpond.com ([144.140.92.153]:34696 "EHLO
	omta01sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1422858AbWBNWuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 17:50:08 -0500
Message-ID: <43F25E9D.6090702@bigpond.net.au>
Date: Wed, 15 Feb 2006 09:50:05 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jean Delvare <khali@linux-fr.org>
CC: quilt-dev@nongnu.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Yasushi SHOJI <yashi@atmark-techno.com>
Subject: Re: [Quilt-dev] Quilt 0.43 has been released! [SERIOUS BUG]
References: <RyUOlVAg.1139905119.2584600.khali@localhost>
In-Reply-To: <RyUOlVAg.1139905119.2584600.khali@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta01sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Tue, 14 Feb 2006 22:50:05 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Delvare wrote:
> Hi all,
> 
> On 2006-02-14, Andreas Gruenbacher wrote:
> 
>>On Tuesday 14 February 2006 04:25, Peter Williams wrote:
>>
>>>The problem arises when pushing a patch that has errors in it (due to
>>>changes in the previous patches in the series) and needs the -f flag to
>>>force the push.  What's happening is that the reverse of the errors is
>>>being applied to the "pre patch" file in the .pc directory.  Then when
>>>you pop this patch it returns the file to a state with the reverse of
>>>the errors applied to it.
>>
>>Found and fixed. It's a missed rollback_patch on one of the two branches of
>>the code that checks if a patch can be reverse applied. This case
>>apparently doesn't trigger as easily as it seems, or else we would have
>>found it sooner. Still quite bad.
> 
> 
> I probably encountered it the other day, but as I couldn't explain what
> was happening,  I mistakenly concluded to a user error and started again
> from a fresh tree. Or maybe it was really a user error after all.

I went through much the same process (several times) before it finally 
dawned on me that it might be a problem with the newly updated quilt and 
replaced it with 0.42 :-(.  I was worried that the symptoms were so 
bizarre and hard to describe properly that the problem would be hard to 
fix so I was impressed by the speed with which the problem was solved.

> 
> I was about to suggest that we add a test in the quilt test suite, but I
> see you did already - good!
> 
> 
>>Shall we wait until the translations are up-to-date again, or release
>>0.44 immediately?
> 
> 
> I'd say:
> * Fix the temporary file leak in the mail command I have been reporting a
> few days ago - unless it's there on purpose.
> * Update the translations. I'll take care of French this evening
> (GMT+01).
> * Let people (including me) do a little testing. If nothing else, running
> the test suite on a few different systems can't hurt.
> * Release.
> 
> We can be done by tomorrow if Yashi can handle the Japanese translation
> fast. If Yashi is too busy I guess we'll have to release anyway...

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
