Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310869AbSCHOCM>; Fri, 8 Mar 2002 09:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310870AbSCHOCC>; Fri, 8 Mar 2002 09:02:02 -0500
Received: from [195.63.194.11] ([195.63.194.11]:48133 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S310869AbSCHOBw>; Fri, 8 Mar 2002 09:01:52 -0500
Message-ID: <3C88C35D.5030008@evision-ventures.com>
Date: Fri, 08 Mar 2002 14:57:49 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH][2.5] BUG check in elevator.c:237
In-Reply-To: <Pine.LNX.4.44.0203081443360.5383-100000@netfinity.realnet.co.sz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> Ok cool, regarding the ide-cd current problem, i still don't see how 
> moving it to a BH would help in this case, the only difference i can see 
> is that the ISR won't have to be so heavy and we can get more interrupt 
> handling done (assuming the BH processing keeps up). The problem isn't 
> that the read_intr is preempting other code and injecting already active 
> requests into the queue, but that ide-cd is allowing running requests to 
> be sent multiple times.

Yeep...

> If you can just explain marginally a  possible workaround other than the 
> kludge i diffed up i can try investigating further.

Actually I have right now no *precise* idea (please note the difference
between *no idea* and *no precise idea*) about the optimal fix.
However making things leaner in first step may give you direct insight
into the proper solution as a side effect (OK. I know this is a bit
philosophing, but this method works really frequently... it's called
deduction...).

And it may actually turn out that the diff could be shorter
as some wordish explanation ;-).

