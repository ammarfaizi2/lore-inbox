Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317871AbSGKXzj>; Thu, 11 Jul 2002 19:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317899AbSGKXzi>; Thu, 11 Jul 2002 19:55:38 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:18320 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S317871AbSGKXzg>;
	Thu, 11 Jul 2002 19:55:36 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Daniel Phillips <phillips@arcor.de>
Cc: Alexander Viro <viro@math.psu.edu>, "David S. Miller" <davem@redhat.com>,
       adam@yggdrasil.com, R.E.Wolff@BitWizard.nl,
       linux-kernel@vger.kernel.org
Subject: Re: Rusty's module talk at the Kernel Summit 
In-reply-to: Your message of "Thu, 11 Jul 2002 12:54:42 +0200."
             <E17Sbat-0002TF-00@starship> 
Date: Fri, 12 Jul 2002 10:00:26 +1000
Message-Id: <20020711235822.8B2494849@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <E17Sbat-0002TF-00@starship> you write:
> Note how the rmmod-during-ret race just disappeared, because rmmod directly 
> calls deregister, which either succeeds or doesn't.  If it succeeds there are
> no mounts on the module and everything is quiet, remove away.  Easy huh?  
> Note also how we don't really have to divide up the 'deactivate' and 
> 'destroy' parts of the deregistration process, though I can see why it still 
> might be useful to do that.  Such refinements become a concern of the 
> filesystem machinery, not the module interface.
> 
> This is all by way of saying that Al is apparently well advanced in 
> implementing exactly the strategy I'd intended to demonstrate (Rusty and 
> Keith seem to be heading to the same place as well, by a twistier path).  I'm

<sigh>

I noted previously that you can do it if you do restrict the interface
to "one module, one fs" approach, as you've suggested here.  Al
corrected me saying that's not neccessary.  It's possible that he's
come up with a new twist on the "freeze-the-kernel" approach or
something.

Al has scribbled in the margin that there's a clever solution, let's
hope he doesn't die before revealing it. 8)

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
