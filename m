Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932200AbWFUPvk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbWFUPvk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 11:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbWFUPvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 11:51:40 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:35986 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751174AbWFUPvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 11:51:40 -0400
Date: Wed, 21 Jun 2006 11:51:14 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Esben Nielsen <nielsen.esben@googlemail.com>
cc: Esben Nielsen <nielsen.esben@gogglemail.com>,
       Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: Why can't I set the priority of softirq-hrt? (Re: 2.6.17-rt1)
In-Reply-To: <Pine.LNX.4.64.0606211736080.7939@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0606211145130.30583@gandalf.stny.rr.com>
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
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 21 Jun 2006, Esben Nielsen wrote:

> > The below patch has whitespace damage.  Could you resend?
> >
>
> Does it help if I send it as an attachment?
>

Don't know.  See below:

>
>
> >>
> >> Index: linux-2.6.17-rt1/kernel/rtmutex.c
> >> ===================================================================
> >> --- linux-2.6.17-rt1.orig/kernel/rtmutex.c
> >> +++ linux-2.6.17-rt1/kernel/rtmutex.c
> >> @@ -625,6 +625,7 @@ rt_lock_slowlock(struct rt_mutex *lock _
> >>

The below has two spaces before the tab.  Is that from your mailer?

> >>   	debug_rt_mutex_init_waiter(&waiter);
> >>   	waiter.task = NULL;
> >> +	waiter.save_state = 1;
> >>
> >>   	spin_lock(&lock->wait_lock);
> >>

The rest of the patch is the same.  The two spaces kill patch.

-- Steve

