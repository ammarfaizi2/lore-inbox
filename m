Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269132AbUJQOAZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269132AbUJQOAZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 10:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269133AbUJQOAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 10:00:25 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14721 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269132AbUJQOAW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 10:00:22 -0400
Message-ID: <41727AE9.9050703@pobox.com>
Date: Sun, 17 Oct 2004 10:00:09 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Hang on x86-64, 2.6.9-rc3-bk4
References: <41719537.1080505@pobox.com>	<417196AA.3090207@pobox.com>	<20041016154818.271a394b.akpm@osdl.org>	<4171B23F.6060305@pobox.com>	<20041016171458.4511ad8b.akpm@osdl.org>	<4171C20D.1000105@pobox.com> <20041016182116.33b3b788.akpm@osdl.org> <4171E978.6060207@pobox.com> <41720740.2030901@yahoo.com.au> <417273F9.6050605@pobox.com> <41727866.3000009@yahoo.com.au>
In-Reply-To: <41727866.3000009@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Jeff Garzik wrote:
> 
>> Nick Piggin wrote:
>>
>>> Hi Jeff, my patch has gone to Linus... but if you have time can
>>> you just verify that it works without the added cond_resched()
>>> please?
>>>
>>> Thanks.
>>
>>
>>
>>
>> Wouldn't akpm's patch be better?
>>
> 
> Doesn't actually fix the problem. Well *sigh*, it does but it doesn't
> if you know what I mean. It "fixed" the problem because your other
> (non-empty) zones will now increase total_scanned, which means the busy
> loop will turn into a sleepy loop and you don't notice a problem.
> 
>> I would tend to prefer that a one-liner hang fix go into -final, as 
>> it's easier to review and verify at this late stage.
>>
> 
> Apart from the above, akpm's patch does fix *a* bug, but actually changes
> much more common case code a lot more than my patch, and has less obvious
> consequences. It really wants a full cycle for performance regressions to
> appear.



Well, I'll let you and Andrew and Linus fight over it, then.

_Someone_ just please get _something_ into 2.6.9-final, so that the 
kernel doesn't hang under heavy I/O (someone else ack'd the problem, and 
the fix, privately as well, under a totally different test case).

	Jeff


