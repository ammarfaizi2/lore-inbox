Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932207AbWFUQOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbWFUQOI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 12:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932184AbWFUQOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 12:14:08 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:42306 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932207AbWFUQOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 12:14:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:x-x-sender:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type:from;
        b=bAi11FxCJ3taZ7BLHruxrCc3Zk69u09sLFvrqd+wr9qqC+APHWkuAEg0YZDRAgOllxg6F2OLuTA8lK9fKe8hBEQpJ++YqkAHUZgBkg94HtKx/qhdcFbZc4PMwxjD8k39cvrwVhx5+w2Og9pdEcUorfz9BCWzQknhi6CBcZBNggs=
Date: Wed, 21 Jun 2006 18:14:11 +0100 (BST)
X-X-Sender: simlo@localhost.localdomain
To: Steven Rostedt <rostedt@goodmis.org>
cc: Esben Nielsen <nielsen.esben@googlemail.com>,
       Esben Nielsen <nielsen.esben@gogglemail.com>,
       Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: Why can't I set the priority of softirq-hrt? (Re: 2.6.17-rt1)
In-Reply-To: <Pine.LNX.4.58.0606211145130.30583@gandalf.stny.rr.com>
Message-ID: <Pine.LNX.4.64.0606211809290.7939@localhost.localdomain>
References: <20060618070641.GA6759@elte.hu>  <Pine.LNX.4.64.0606201656230.11643@localhost.localdomain>
  <1150816429.6780.222.camel@localhost.localdomain> 
 <Pine.LNX.4.64.0606201725550.11643@localhost.localdomain> 
 <Pine.LNX.4.58.0606201229310.729@gandalf.stny.rr.com> 
 <Pine.LNX.4.64.0606201903030.11643@localhost.localdomain>
 <1150824092.6780.255.camel@localhost.localdomain>
 <Pine.LNX.4.64.0606202217160.11643@localhost.localdomain>
 <Pine.LNX.4.58.0606210418160.29673@gandalf.stny.rr.com>
 <Pine.LNX.4.64.0606211204220.10723@localhost.localdomain>
 <Pine.LNX.4.64.0606211638560.6572@localhost.localdomain>
 <Pine.LNX.4.58.0606211114140.29348@gandalf.stny.rr.com>
 <Pine.LNX.4.64.0606211736080.7939@localhost.localdomain>
 <Pine.LNX.4.58.0606211145130.30583@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
From: Esben Nielsen <nielsen.esben@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Odd, ...

On Wed, 21 Jun 2006, Steven Rostedt wrote:

>
> On Wed, 21 Jun 2006, Esben Nielsen wrote:
>
>>> The below patch has whitespace damage.  Could you resend?
>>>
>>
>> Does it help if I send it as an attachment?
>>
>
> Don't know.  See below:
>
>>
>>
>>>>
>>>> Index: linux-2.6.17-rt1/kernel/rtmutex.c
>>>> ===================================================================
>>>> --- linux-2.6.17-rt1.orig/kernel/rtmutex.c
>>>> +++ linux-2.6.17-rt1/kernel/rtmutex.c
>>>> @@ -625,6 +625,7 @@ rt_lock_slowlock(struct rt_mutex *lock _
>>>>
>
> The below has two spaces before the tab.  Is that from your mailer?

When I open the patch file in emacs it isn't like that, so I guess so, but 
when I open my mail-box in emacs it is like that. So it has to be Pine. I 
thought ctrl-R did the trick of inserting a patch from quilt?

Anyway, could you apply the attached patch from the previous mail?

Esben


>
>>>>   	debug_rt_mutex_init_waiter(&waiter);
>>>>   	waiter.task = NULL;
>>>> +	waiter.save_state = 1;
>>>>
>>>>   	spin_lock(&lock->wait_lock);
>>>>
>
> The rest of the patch is the same.  The two spaces kill patch.
>
> -- Steve
>
