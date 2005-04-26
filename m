Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261616AbVDZUgg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261616AbVDZUgg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 16:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbVDZUgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 16:36:36 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:22156 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261616AbVDZUa7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 16:30:59 -0400
Message-ID: <426EA4D7.9080008@tmr.com>
Date: Tue, 26 Apr 2005 16:30:15 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: Linus Torvalds <torvalds@osdl.org>, Mike Taht <mike.taht@timesys.com>,
       Matt Mackall <mpm@selenic.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
Subject: Re: Mercurial 0.3 vs git benchmarks
References: <Pine.LNX.4.58.0504252032500.18901@ppc970.osdl.org><Pine.LNX.4.58.0504252032500.18901@ppc970.osdl.org> <426E852A.40904@zytor.com>
In-Reply-To: <426E852A.40904@zytor.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Linus Torvalds wrote:
> 
>>
>> And don't try to make me explain why the patchbomb has any IO time at 
>> all,
>> it should all have fit in the cache, but I think the writeback logic
>> kicked in.
> 
> 
> The default log size on ext3 is quite small.  Making the log larger 
> probably would have helped.

Experience tells me that making the log larger does very good things for 
performance in many load types. However, that fsync issue forcing the 
write of the whole log may get worse if there's a lot pending.

I suspect this would be helped by noatime.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
