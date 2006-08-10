Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751440AbWHJQmF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440AbWHJQmF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 12:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161434AbWHJQmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 12:42:05 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:22660 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751363AbWHJQmD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 12:42:03 -0400
Message-ID: <44DB61D7.1000109@us.ibm.com>
Date: Thu, 10 Aug 2006 09:41:59 -0700
From: Mingming Cao <cmm@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/5] Forking ext4 filesystem from ext3 filesystem
References: <1155172622.3161.73.camel@localhost.localdomain> <20060809233914.35ab8792.akpm@osdl.org>
In-Reply-To: <20060809233914.35ab8792.akpm@osdl.org>
Content-Type: text/plain; charset=gb18030; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> On Wed, 09 Aug 2006 18:17:02 -0700
> Mingming Cao <cmm@us.ibm.com> wrote:
> 
> 
>>Fork(copy) ext4 filesystem from ext3 filesystem. Rename all functions in ext4 from ext3_xxx() to ext4_xxx().
> 
> 
> It would have been nice to spend a few hours cleaning up ext3 and JBD
> before doing this.  The code isn't toooo bad, but there are number of
> coding style problems, whitespace screwups, incorrect comments, missing
> comments, poorly-chosen variable names and all of that sort of thing.
>
> One the fs has been copied-and-pasted, it's much harder to address these
> things: either need to do it twice, or allow the filesystems to diverge, or
> not do it.
>
Andrew, thanks for taking a close look this series of changes.

I agree with you that the timing is right, to do the clean up now rather 
than later. I would give it a try. If I could get more help from more 
code reviewer, it probably makes the effort a lot easier. For those 
issues you pointed out : coding style problem£¬incorrect comments, 
poorly-named variables  -- do you have any specific examples in your mind?

> Also, -mm presently has two patches pending against fs/jbd/ and nine pending
> against fs/ext3/.  We should get all those things merged before taking the
> copy.
> 
So probably the right thing to do is keep the ext4 patches against mm 
tree instead of rc three?

> Also, JBD is presently feeding into submit_bh() buffer_heads which span two
> machine pages, and some device drivers spit the dummy.  It'd be better to
> fix that once, rather than twice..  

Okay, I will look at it.


Thanks,
Mingming

