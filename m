Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271750AbTHHTeo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 15:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271812AbTHHTeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 15:34:44 -0400
Received: from dp.samba.org ([66.70.73.150]:39632 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S271750AbTHHTel (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 15:34:41 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       dipankar@in.ibm.com, andrea@suse.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       paulmck@us.ibm.com
Subject: Re: [PATCH] RCU: Reduce size of rcu_head 1 of 2 
In-reply-to: Your message of "02 Aug 2003 14:15:26 +0100."
             <1059830126.19819.8.camel@dhcp22.swansea.linux.org.uk> 
Date: Fri, 08 Aug 2003 12:21:04 +1000
Message-Id: <20030808193441.56F452C25E@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <1059830126.19819.8.camel@dhcp22.swansea.linux.org.uk> you write:
> On Sad, 2003-08-02 at 02:49, Rusty Russell wrote:
> > Sure.  But it's not neccessary.  The replacement is cleaner and
> > smaller, sure, but it's not worth changing once 2.6 is out.  In 2.7,
> > sure.
> > 
> > I'm happy to accept "no" from Andrew, but not happy to accept "we'll
> > just change the API midway through 2.6".
> 
> Please distinguish API from ABI. There is no ABI, there is no need for
> an ABI.

You are confused, but it seems you are not alone.  I don't understand
where this talk of ABI came from.

There are two patches.  Both reduce the size of the "struct rcu_head".
One simply changes the struct rcu_head from a double linked list to a
single linked list.  The other eliminates the "void *data" arg, and
changes the prototype of the call_rcu() function to take a pointer to
the struct rcu_head, rather than a user-defined data ptr.

It is the latter that I am concerned about changing mid-stable-series.

Hope that clarifies,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
