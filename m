Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932309AbWHCV12@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbWHCV12 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 17:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbWHCV12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 17:27:28 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:12748 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932309AbWHCV11
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 17:27:27 -0400
Message-ID: <44D26A3E.5080603@vmware.com>
Date: Thu, 03 Aug 2006 14:27:26 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Willy Tarreau <w@1wt.eu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, greg@kroah.com,
       Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Jack Lo <jlo@vmware.com>
Subject: Re: A proposal - binary
References: <44D1CC7D.4010600@vmware.com>	 <1154611272.23655.71.camel@localhost.localdomain>	 <20060803202929.GA8776@1wt.eu> <1154639566.23655.132.camel@localhost.localdomain>
In-Reply-To: <1154639566.23655.132.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ar Iau, 2006-08-03 am 22:29 +0200, ysgrifennodd Willy Tarreau:
>   
>> I think that the issue Zach tried to cover is the current inability to
>> keep the same binary module across multiple kernel versions. That's why
>> he compared modules<->kernel to ELF<->glibc. In that sense, he's right.
>>     
>
> I think thats why he's wrong.
>
> The interface for a hypedvisor is
>
>       Kernel -> Something -> Hypedvisor
>
> The kernel->something interface can change randomly by day of week, who
> cares. A better analogy would be a device driver - we recompile device
> drivers each kernel variant, which change their internal interfaces, we 
> redesign their locking but we don't have to change the hardware.
>
> Ditto talking to the hypedvisor. The ABI is the hypedvisor syscall/trap
> interface not the kernel module interface. As such insmod is just fine.
>   

Yes, the module issue is completely tangential.  We would like to have 
the ability to load a hypervisor module at run-time, and this may be 
slightly nicer from a GPL point of view, by allowing us to publish a GPL 
module that interfaces to the kernel.  But the Something layer really is 
more like firmware, and merely making a GPL'd module interface to it 
doesn't actually change the underlying legal / technical ramifications 
that Alan pointed out.

Zach
