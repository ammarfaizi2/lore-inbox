Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265800AbUIAJuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265800AbUIAJuV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 05:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265887AbUIAJuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 05:50:21 -0400
Received: from jive.SoftHome.net ([66.54.152.27]:17311 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id S265800AbUIAJuN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 05:50:13 -0400
From: filia@softhome.net
To: viro@parcelfarce.linux.theplanet.co.uk, arjanv@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: f_ops flag to speed up compatible ioctls in linux kernel
Date: Wed, 01 Sep 2004 03:50:11 -0600
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [212.18.200.6]
Message-ID: <courier.41359B53.00007549@softhome.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi! 

 Stop being arrogant.
 Can you please elaborate on how to make Linux kernel support e.g. motion 
controllers? They do not fit *any* known to me driver interface. They have 
several axes, they have about twenty parameters (float or integer), and they 
have several commands, a-la start, graceful stop, abrupt stop. Plus 
obviously diagnostics - about ten another commands with absolutely different 
parameters. And about ten motion monitoring commands. And this is one 
example I were need to program. 

 Or take any other freaky device we might got on market tomorrow. 

 As ioctl() opponent, be kind and give some advice what to do in that kind 
of situations. 

Al Viro written:
>> Hello!
>> Currently, on the x86_64 architecture, its quite tricky to make
>> a char device ioctl work for an x86 executables.
>> In particular,
>>    1. there is a requirement that ioctl number is unique -
>>       which is hard to guarantee especially for out of kernel modules
>
>Too bad. 
>
>>    2. there's a performance huge overhead for each compat call - there's
>>       a hash lookup in a global hash inside a lock_kernel -
>>       and I think compat performance *is* important. 
>> 
>> Further, adding a command to the ioctl suddenly requires changing
>> two places - registration code and ioctl itself.
>
> So don't add them.  Adding a new ioctl is *NOT* a step to be taken lightly -
> we used to be far too accepting in that area and as somebody who'd waded
> through the resulting dungpiles over the last months I can tell you that
> result is utterly revolting. 
> 
> Excuse me, but I have zero sympathy to people who complain about obstacles
> to dumping more into the same piles - it should be hard.

Arjan van de Ven written:
>> Further, adding a command to the ioctl suddenly requires changing
>> two places - registration code and ioctl itself.
>
>adding ioctls SHOULD be painful. Really painful. It's similar to adding
>syscalls; you'll have to keep compatibility basically forever so adding
>should not be an easy thing.

 --- with respect. best regards.
***    Philips @ Saarbruecken. 

