Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261862AbVGZPAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbVGZPAx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 11:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbVGZO7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 10:59:11 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:23312 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261841AbVGZO4o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 10:56:44 -0400
Message-ID: <42E65023.8060209@tmr.com>
Date: Tue, 26 Jul 2005 11:00:51 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Hancock <hancockr@shaw.ca>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel cached memory
References: <4t5s8-68A-33@gated-at.bofh.it> <4tdIU-479-9@gated-at.bofh.it> <42E5C40A.7000709@shaw.ca>
In-Reply-To: <42E5C40A.7000709@shaw.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock wrote:
> John Pearson wrote:
> 
>> Wouldn't having (practically) all your memory used for cache slow down
>> starting a new program? First it would have to free up that space, and 
>> then
>> put stuff in that space, taking potentially twice as long.
> 
> 
> If the cache pages are clean (not been modified since they were read 
> from the disk), then evicting that data will not take very long. If the 
> program you are just starting is not in the cache, then the time taken 
> to load it from disk will dwarf the time needed to evict cached pages. 
> And there's also the possibility that the cache contains the data you 
> are loading, which definitely will speed things up..
> 
The problem lies with data write evicting program pages in many cases. 
You are right that they don't need to be written, but they do need to be 
read back, so when I unhide a window there's a large delay while the 
underlying program is read back in. If the pages are dirty, then there's 
the delay while they are written.

It's exactly the benefit from having cached pages which is lost.

I would love more control in this area, but short of maintaining a patch 
I don't see it happening.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
