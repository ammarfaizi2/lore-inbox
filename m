Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261342AbVC2UDI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbVC2UDI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 15:03:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261343AbVC2UDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 15:03:08 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19382 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261342AbVC2UC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 15:02:59 -0500
Message-ID: <4249B464.50607@pobox.com>
Date: Tue, 29 Mar 2005 15:02:44 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com, netdev@oss.sgi.com
Subject: Re: [PATCH] s390: claw network device driver
References: <200503290533.j2T5XEYT028850@hera.kernel.org>	<4248FBFD.5000809@pobox.com>	<20050328230830.5e90396f.akpm@osdl.org>	<20050329071210.GA16409@havoc.gtf.org>	<20050328232359.4f1e04b9.akpm@osdl.org>	<42490763.5010008@pobox.com> <20050329000239.6346d73e.akpm@osdl.org>
In-Reply-To: <20050329000239.6346d73e.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
>>Andrew Morton wrote:
>>
>>>Jeff Garzik <jgarzik@pobox.com> wrote:
>>>
>>>
>>>>>Was cc'ed to linux-net last Thursday, but it looks like the messages was
>>>>>too large and the vger server munched it.
>>>>
>>>>This also brings up a larger question... why was a completely unreviewed
>>>>net driver merged?
>>>
>>>
>>>Because nobody noticed that it didn't make it to the mailing list,
>>>obviously.
>>
>>That's ducking the question.  Let me rephrase.
>>
>>Why was a complete lack of response judged to be an ACK?
> 
> 
> That's not uncommon.  I don't ask people "are you reading the mailing list
> which you should be reading" unless I think it's someone who doesn't read
> the mailing lists which they should be reading.
> 
> 
>>For new drivers, that's a -horrible- precedent.  You are quite skilled 
>>at poking random hackers :)  why not poke somebody to ack a new drivers? 
> 
> 
> In this case I didn't think about it very hard, sorry - figured it was s390
> stuff and it hence falls under the "if it breaks, it's the s390 team's
> problem" exemption.

Yeah, and I -am- sympathetic to that sort of thing.  I just feel really 
strongly that we need to have a higher-than-normal barrier for new code.

It may be an S/390 driver, but Jeff's Law of Bad Code states "where 
there is bad code, it will be copied."  Propagating the 2.2.x-era 
'tbusy' flag to yet more drivers is something I absolutely do not want 
to happen.

I also feel that we have shifted from a "Linus doesn't scale" problem to 
an "akpm doesn't scale" problem.  As much work as you put it (lots!), 
you can't possibly be expected to review all the new drivers and such.

I would prefer a "new driver must be acked by at least one non-author" 
rule.  We need -some- barrier to entry.  If that rule is OK with others, 
I'm quite willing to do that for my areas like libata.


>>  It's not like this driver (or many of the other new drivers) 
>>desperately need to get into the kernel ASAP, so desperate that a lack 
>>of review was OK.
> 
> 
> True.  But it's not as if we can't fix stuff up after it's merged up.  The
> reasons for holding off on a merge would be:
> 
> a) We're not sure that the feature should be merged at all
> 
> b) Holding off on a merge is a tool we use to motivate the submitter to
>    fix the code up
> 
> c) The merge breaks existing stuff.
> 
> I don't think any of those things apply here.  The only downside is the
> increased bk patch volume.

In general, I have supported your philosophy of accelerated upstreaming 
of code.  I just worry about going too far, and this driver was a 
case-in-point.

As Linus and others have pointed out many times in the past, there is no 
harm in -not- upstreaming code until it is "ready."  Our current system 
of maintainers/lieutenants is sufficiently distributed as to allow this.

	Jeff


