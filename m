Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265434AbTFMQ0H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 12:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265435AbTFMQ0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 12:26:07 -0400
Received: from air-2.osdl.org ([65.172.181.6]:1260 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265434AbTFMQ0B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 12:26:01 -0400
Date: Fri, 13 Jun 2003 09:41:40 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Steven Dake <sdake@mvista.com>
cc: Greg KH <greg@kroah.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] udev enhancements to use kernel event queue
In-Reply-To: <3EE9F2E5.1050407@mvista.com>
Message-ID: <Pine.LNX.4.44.0306130925510.908-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I suppose it is possible that devfs could be faster, however, there are 
> significant amounts of policies that can never be done in devfs which 
> must be done in user space.  For these types of applications, it makes 
> sense to provide the fastest mechanism available, even when it may only 
> improve boot performance by 1 second.

Eh? Why must you completely re-engineer a solution because you see the 
current one as deficient? Not only is it completely over-engineered by 
enforcing your fanatical ideas about requiring a new system daemon, but 
it's total pre-mature optimization. 

On top of that, you don't have any accurate numbers to back up your 
claims. Please perform and post the timings I suggested yesterday, and 
then we'll talk. 

> I understand what you mean by saying that 99.99% of users don't care 
> about availability.  While those particular users may spend significant 
> amounts of time improving Linux, it is the remaining folks that care 
> about availability that are interested in investing money into r&d to 
> improve availability while also improving feature set.  It is this set 
> of folks, (the people that do care about availability) that this patch 
> is targeted towards.

Then it is your responsibility to merge the continuing efforts and design 
goals of the kernel with the requirements of your high-paying customers in 
the smoothest possible way. Serving one while ignoring the other is a good 
way to waste a lot of time and money. 

I care about availability. But, I am not willing to integrate or support 
features that come from some random person just because they claim to 
improve availability, especially when a) I don't like the numbers and b) 
there are no numbers to back it up. 

> >As for the memory issues, if no one ever reads from the character node,
> >it will constantly fill up with events, right?  Shouldn't they be
> >eventually flushed out at some point in time?
> >  
> >
> This is a problem...  I wasn't quite sure how to handle this.  The two 
> choices are to include timeouts in events (after a certain amount of 
> time, events are timed out and freed) or to allow only a certain number 
> of events, after which events at the front of the queue are flushed.
> 
> The reality though, is that the user will be running the daemon to clear 
> out the events.  If they don't, then they get what they deserve :)

And this improves availability how? 


	-pat

