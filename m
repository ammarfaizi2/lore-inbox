Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269100AbUINNi7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269100AbUINNi7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 09:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269290AbUINNi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 09:38:59 -0400
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:29594 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269100AbUINNiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 09:38:54 -0400
Message-ID: <4146F46A.6070800@yahoo.com.au>
Date: Tue, 14 Sep 2004 23:38:50 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Move domain setup and add dual core support.
References: <m3vfeigs5b.fsf@averell.firstfloor.org> <4146EB80.9090801@yahoo.com.au> <20040914132055.GA79737@muc.de>
In-Reply-To: <20040914132055.GA79737@muc.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Tue, Sep 14, 2004 at 11:00:48PM +1000, Nick Piggin wrote:
> 
>>Andi Kleen wrote:
>>
>>
>>>Patch is for 2.6.9rc1-bk19. It's much smaller than it looks,
>>>most of it is just moving code from sched.c to sched-domains.h
>>>
>>
>>OK, I guess this should be alright... but it will clash badly
>>with the stuff in -mm, which really needs to get in.
> 
> 
> Ok, I will redo it.
> 
> But I would like to have the CMP patch soon in mainline for 2.6.9. Are 
> the patches in mm scheduled to be soon in mainline? 

I hope so for 2.6.9. Not too sure of the plans, but if they prove
stable early on in -mm, I think there may be enough time to get them
in for 2.6.9

> 
>>And your patch will be much smaller because most of the moving
>>is done for you.
> 
> 
> Where is it moved to? 
> 

include/linux/sched.h

I know we've been trying to move stuff *out* of there, but this is
something that actually fits. On the other hand, it is not really
going to be used by more than a few files outside sched.c, so maybe
it could go to its own file if anyone felt strongly about it.
