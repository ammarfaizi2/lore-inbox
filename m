Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266271AbUFYSWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266271AbUFYSWN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 14:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266829AbUFYSWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 14:22:13 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:36358 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S266271AbUFYSWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 14:22:09 -0400
Message-ID: <40DC71E8.3020403@techsource.com>
Date: Fri, 25 Jun 2004 14:41:44 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Sean Neakums <sneakums@zork.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Collapse ext2 and 3 please
References: <40DB605D.6000409@comcast.net> <6uhdsz3jud.fsf@zork.zork.net>	<40DC685E.1020406@techsource.com> <6uoen71pky.fsf@zork.zork.net>
In-Reply-To: <6uoen71pky.fsf@zork.zork.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Sean Neakums wrote:
> Timothy Miller <miller@techsource.com> writes:
> 
> 
>>Sean Neakums wrote:
>>
>>>I seem to remember somebody, I think maybe Andrew Morton, suggesting
>>>that a no-journal mode be added to ext3 so that ext2 could be removed.
>>>I can't find the message in question right now, though.
>>
>>As an option, that might be nice, but if everyone were to start using
>>ext3 even for their non-journalled file systems, the ext2 code would
>>be subject to code rot.
> 
> 
> My paraphrase is at fault here.  In the above, "removed" == "removed
> from the kernel tree".


I understood that.

Let me be more clear.  I agree with other people's comments to the 
effect that ext2 and ext3 have different goals and therefore different 
and potentially incompatible optimizations.  If ext3 had a mode that 
made it equivalent to ext2, which encouraged people to only compile in 
ext3 even for ext2 partitions (to save on kernel memory), then future 
ext2 code bases would get less use and therefore less testing and 
therefore more code rot.

It is reasonable to allow the redundancy between ext2 and ext3 in order 
to allow them to diverge.  This kind of future-proofing mentality 
underlies the reasons why kernel developers don't want to completely 
stablize the module ABI, for example.

