Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751051AbWJMOvz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbWJMOvz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 10:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751055AbWJMOvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 10:51:55 -0400
Received: from relay02.pair.com ([209.68.5.16]:12044 "HELO relay02.pair.com")
	by vger.kernel.org with SMTP id S1751051AbWJMOvz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 10:51:55 -0400
X-pair-Authenticated: 71.197.50.189
Date: Fri, 13 Oct 2006 09:51:51 -0500 (CDT)
From: Chase Venters <chase.venters@clientec.com>
X-X-Sender: root@turbotaz.ourhouse
To: James Courtier-Dutton <James@superbug.co.uk>
cc: Arjan van de Ven <arjan@infradead.org>,
       John Richard Moser <nigelenki@comcast.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Can context switches be faster?
In-Reply-To: <452F7303.6070303@superbug.co.uk>
Message-ID: <Pine.LNX.4.64.0610130950410.17368@turbotaz.ourhouse>
References: <452E62F8.5010402@comcast.net>  <20061012171929.GB24658@flint.arm.linux.org.uk>
  <452E888D.6040002@comcast.net> <1160678231.3000.451.camel@laptopd505.fenrus.org>
 <452F7303.6070303@superbug.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Oct 2006, James Courtier-Dutton wrote:

> Arjan van de Ven wrote:
>> On Thu, 2006-10-12 at 14:25 -0400, John Richard Moser wrote:
>>
>>
>>>   - Does the current code act on these behaviors, or just flush all
>>>     cache regardless?
>>
>> the cache flushing is a per architecture property. On x86, the cache
>> flushing isn't needed; but a TLB flush is. Depending on your hardware
>> that can be expensive as well.
>>
>
> So, that is needed for a full process context switch to another process.
> Is the context switch between threads quicker as it should not need to
> flush the TLB?

Indeed. This is also true for switching from a process to a kernel thread 
and back, because kernel threads don't have their own user-space virtual 
memory; they just live inside the kernel virtual memory mapped into every 
process.

> James
>

Thanks,
Chase
