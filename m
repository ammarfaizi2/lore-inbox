Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262880AbUB0Ofo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 09:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262882AbUB0Ofo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 09:35:44 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:40720 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S262880AbUB0Off (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 09:35:35 -0500
Message-ID: <403F582E.10500@techsource.com>
Date: Fri, 27 Feb 2004 09:46:06 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Peter Williams <peterw@aurema.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] O(1) Entitlement Based Scheduler
References: <Pine.GSO.4.03.10402260834530.27582-100000@swag.sw.oz.au> <403D3E47.4080501@techsource.com> <403D576A.6030900@aurema.com> <403E1A11.5050704@techsource.com> <403E53EA.2010001@aurema.com>
In-Reply-To: <403E53EA.2010001@aurema.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Peter Williams wrote:
> Timothy Miller wrote:
> 

>>
>>
>> We don't want user-space programs to have control over priority. 
> 
> 
> They already do e.g. renice is such a program.

No one's talking about LOWERING priority here.  You can only DoS someone 
else if you can set negative nice values, and non-root can't do that.

> 
>> This is DoS waiting to happen.
>>
>>> 2. have a user space daemon poll running tasks periodically and 
>>> renice them if they are running specified binaries
>>
>>
>>
>> This is much too specific.  Again, if the USER has control over this
>> list,
> 
> 
> It would obviously be under root control.

And that means if someone wants to run a program which is not on the 
list but which requires (and deserves) higher priority, they cannot.


