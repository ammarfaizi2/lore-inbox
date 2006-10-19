Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423008AbWJSDiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423008AbWJSDiM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 23:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423237AbWJSDiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 23:38:12 -0400
Received: from wx-out-0506.google.com ([66.249.82.224]:56691 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1423008AbWJSDiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 23:38:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer;
        b=Ddm90Mxbw5ceTmJxs/Me+shQ9cvX/Z7E8cyghrkE0PYG6cvYe63UUu8fXdb3yeCMmz+l+Zkq6Gu9Ox+LkVQmy/sII9pdMJ4Z0U4yNwwKA657cLwbXyV6Jg9holiNoCxw1YrcDKD3wBHH2yPML4Dmn/RYyV6yt3DTseuYRH0mUEw=
In-Reply-To: <20061017225603.GA15846@c3po.0xdef.net>
References: <d0bd1c10610170311s3ef77226n1d645f3f1e178753@mail.gmail.com> <d0bd1c10610170318x5dac0620l8842c43430ac33b@mail.gmail.com> <20061017225603.GA15846@c3po.0xdef.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <8AC92F9D-9E69-4332-9165-7B98C16D5050@gmail.com>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kay Tiong Khoo <kaytiong@gmail.com>
Subject: Re: stopping a process during a timer interrupt
Date: Thu, 19 Oct 2006 11:38:00 +0800
To: Hagen Paul Pfeifer <hagen@jauu.net>
X-Mailer: Apple Mail (2.752.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks!

For the record, I was trying to sleep kernel threads as well as user  
threads. That didn't work out too well.

All worked fine when I only attempted to sleep user threads.

Kay Tiong

On Oct 18, 2006, at 6:56 AM, Hagen Paul Pfeifer wrote:

> * Kay Tiong Khoo | 2006-10-17 18:18:25 [+0800]:
>
>> On a timer interrupt, I tried to stop the current process by changing
>> it's run state to TASK_STOPPED via set_current_state(TASK_STOPPED).
>> However, this results in a system hang.
>>
>> I can't find a way to stop the current process during an interrupt
>> context. Does such code exist in the kernel? If not, how does one go
>> about implementing it from within a kernel module.
>
> Take a look at some driver implementations!
> There you will find some ways how to put a process into a sleep state.
>
> Grep for "*->state*TASK_UNINTERRUPTIBLE" and take also a look at the
> interaction with schedule() and spinlocks.
>
>> Thanks.
>> Kay Tiong
>
> Best regards
>
> -- 
> Hagen Pfeifer

