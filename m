Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263205AbUB1FCS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 00:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263198AbUB1FCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 00:02:18 -0500
Received: from alt.aurema.com ([203.217.18.57]:11154 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S263205AbUB1FCF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 00:02:05 -0500
Message-ID: <4040207E.8040706@aurema.com>
Date: Sat, 28 Feb 2004 16:00:46 +1100
From: Peter Williams <peterw@aurema.com>
Organization: Aurema Pty Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Timothy Miller <miller@techsource.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] O(1) Entitlement Based Scheduler
References: <Pine.GSO.4.03.10402260834530.27582-100000@swag.sw.oz.au> <403D3E47.4080501@techsource.com> <403D576A.6030900@aurema.com> <403E1A11.5050704@techsource.com> <403E53EA.2010001@aurema.com> <403F582E.10500@techsource.com>
In-Reply-To: <403F582E.10500@techsource.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Miller wrote:
> 
> 
> Peter Williams wrote:
> 
>> Timothy Miller wrote:
>>
> 
>>>
>>>
>>> We don't want user-space programs to have control over priority. 
>>
>>
>>
>> They already do e.g. renice is such a program.
> 
> 
> No one's talking about LOWERING priority here.  You can only DoS someone 
> else if you can set negative nice values, and non-root can't do that.

Which is why root has to be in control of the mechanism.

> 
>>
>>> This is DoS waiting to happen.
>>>
>>>> 2. have a user space daemon poll running tasks periodically and 
>>>> renice them if they are running specified binaries
>>>
>>>
>>>
>>>
>>> This is much too specific.  Again, if the USER has control over this
>>> list,
>>
>>
>>
>> It would obviously be under root control.
> 
> 
> And that means if someone wants to run a program which is not on the 
> list but which requires (and deserves) higher priority, they cannot.

Any mechanism that causes a task to be treated more favourably than 
others needs to be under root's control.  It's root's prerogative to 
decide who deserves more favourable treatment.  This is even more 
important (for obvious reasons) if a reservation (or guarantee) 
mechanism is involved.

I'd like to stress at this point that xmms only needs a boost under 
extremely high loads and this issue is being blown out of proportion.

Peter
-- 
Dr Peter Williams, Chief Scientist                peterw@aurema.com
Aurema Pty Limited                                Tel:+61 2 9698 2322
PO Box 305, Strawberry Hills NSW 2012, Australia  Fax:+61 2 9699 9174
79 Myrtle Street, Chippendale NSW 2008, Australia http://www.aurema.com

