Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266210AbTADGLz>; Sat, 4 Jan 2003 01:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266271AbTADGLz>; Sat, 4 Jan 2003 01:11:55 -0500
Received: from dp.samba.org ([66.70.73.150]:35284 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266210AbTADGLy>;
	Sat, 4 Jan 2003 01:11:54 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: "David S. Miller" <davem@redhat.com>
Cc: kronos@kronoz.cjb.net, linux-kernel@vger.kernel.org,
       "Alexey N. Kuznetsov" <kuznet@ms2.inr.ac.ru>
Subject: Re: [RFC] Migrating net/sched to new module interface 
In-reply-to: Your message of "03 Jan 2003 00:37:04 -0800."
             <1041583024.8648.11.camel@rth.ninka.net> 
Date: Sat, 04 Jan 2003 17:09:41 +1100
Message-Id: <20030104062027.90D922C37B@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <1041583024.8648.11.camel@rth.ninka.net> you write:
> On Thu, 2003-01-02 at 21:10, Rusty Russell wrote:
> > Hmm, I thought the sched stuff all runs under the network brlock?  If
> > so, it doesn't need to be held in, since it's not preemptible.
> 
> The packet schedulers transmit, not receive.
> They have their own queue locking, along with the device
> xmit lock.

Then the patch to mark the "owner" should be straightforward.  I
haven't looked at kronos's patch in detail, though.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
