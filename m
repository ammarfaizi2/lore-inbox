Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750949AbWHJUXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbWHJUXG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751528AbWHJUWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:22:46 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:7044 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751522AbWHJUWc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 16:22:32 -0400
Message-ID: <44DB9582.6010609@garzik.org>
Date: Thu, 10 Aug 2006 16:22:26 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Mingming Cao <cmm@us.ibm.com>, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/5] Forking ext4 filesystem from ext3 filesystem
References: <1155172622.3161.73.camel@localhost.localdomain>	<20060809233914.35ab8792.akpm@osdl.org>	<44DB61D7.1000109@us.ibm.com> <20060810111839.51c73911.akpm@osdl.org>
In-Reply-To: <20060810111839.51c73911.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Thu, 10 Aug 2006 09:41:59 -0700
> Mingming Cao <cmm@us.ibm.com> wrote:
> 
>> Andrew Morton wrote:
>>
>>> On Wed, 09 Aug 2006 18:17:02 -0700
>>> Mingming Cao <cmm@us.ibm.com> wrote:
>>>
>>>
>>>> Fork(copy) ext4 filesystem from ext3 filesystem. Rename all functions in ext4 from ext3_xxx() to ext4_xxx().
>>>
>>> It would have been nice to spend a few hours cleaning up ext3 and JBD
>>> before doing this.  The code isn't toooo bad, but there are number of
>>> coding style problems, whitespace screwups, incorrect comments, missing
>>> comments, poorly-chosen variable names and all of that sort of thing.
>>>
>>> One the fs has been copied-and-pasted, it's much harder to address these
>>> things: either need to do it twice, or allow the filesystems to diverge, or
>>> not do it.
>>>
>> Andrew, thanks for taking a close look this series of changes.
>>
>> I agree with you that the timing is right, to do the clean up now rather 
>> than later. I would give it a try. If I could get more help from more 
>> code reviewer, it probably makes the effort a lot easier. For those 
>> issues you pointed out : coding style problem___incorrect comments, 
>> poorly-named variables  -- do you have any specific examples in your mind?
> 
> Not really, apart from the few things I identified elsewhere (such as the
> brelse thing).
> 
> It's just that now is the right time for a general spring-cleaning, if we
> ever want to do that.
> 
>>> Also, -mm presently has two patches pending against fs/jbd/ and nine pending
>>> against fs/ext3/.  We should get all those things merged before taking the
>>> copy.
>>>
>> So probably the right thing to do is keep the ext4 patches against mm 
>> tree instead of rc three?
> 
> That would drive everyone nuts, I think.  What I would suggest is:
> 
> - get ext3 into a ready-to-copy state (merge bugfixes, spring-clean, etc)

Presumably bug fixes should go in immediately, regardless of whether 
it's before or after "cp -a ext3 ext4".

I strongly disagree that ext3 should be subject to a spring cleaning. 
Comments, whitespace, very very minor things, sure.  Trying to get rid 
of brelse() when _many_ other filesystems also use it?  ext4 material.

That detracts from the idea that its the stable counterpart to the devel 
filesystem (ext4).

	Jeff


