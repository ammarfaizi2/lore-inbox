Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751204AbVHVVJO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbVHVVJO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 17:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbVHVVJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 17:09:14 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:35307 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751204AbVHVVJN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 17:09:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=rMTyStJMlPhR3tAU8OchyesmsUu0UkfcrHT3fH08A/8Epe5ss6BVcXvZm6Rz5AaUidZZ00nuJeXdrRXb9SF02218iRcOIqDN8ihHNF5VvAs6sU3u+XrtarIuGP+UaeoFaKZb/tycDsWSkPeLE0ZwlzH1hnBxRTblXdlRwc75XtI=  ;
Message-ID: <20050822154111.4058.qmail@web33304.mail.mud.yahoo.com>
Date: Mon, 22 Aug 2005 08:41:11 -0700 (PDT)
From: Danial Thom <danial_thom@yahoo.com>
Reply-To: danial_thom@yahoo.com
Subject: Re: 2.6.12 Performance problems
To: linux-kernel@vger.kernel.org
In-Reply-To: <2230.192.167.206.189.1124721719.squirrel@new.host.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

*confused by the top-posting..*

--- Luigi Genoni
<genoni@darkstar.linuxpratico.net> wrote:

> maybe it is possible to be more clear.
> 
> voluntary kernel preemption adds explicit
> preemption points into the
> kernel and  full kernel preemption makes all
> kernel code preemptible. This
> way even when a process is executing some
> syscall in kernel space, it can
> be volontary or involontary preempted.
> 
> For interactive users the systems seems to be
> smarter, but when the system
> is doing a lot of work in kernel space, then
> you of course have to lose
> something.
> 
> Also just to check id it's the case or not to
> preempt means you lose
> something. This something is usually troughput.
> In your case I would not
> use a preemptible kernel.
> 
> SOmething similar could be said about Timer
> frequency, but here the lost
> is connected to the number to interrupts you
> have to manage.
> 
> The point is that a desktop where the users
> simple need a smooth sysstem
> to be userd interactivelly, but not real CPU
> power, and a server where you
> need hourse power are different topics and need
> different kernel
> behaviour.
> 
> 
> 
> On Sun, August 21, 2005 19:07, Danial Thom
> wrote:
> 
> > Ok, well you'll have to explain this one:
> >
> >
> > "Low latency comes at the cost of decreased
> > throughput - can't have both"
> >
> > Seems to be a bit backwards. Threading the
> kernel
> > adds latency, so its the additional latency
> in the kernel that causes the
> > drop in throughput. Do you mean that kernel
> performance has been sacrificed
> > in order to be able to service other threads
> more quickly, even when there
> > are no other threads to be serviced?
> >
> > Danial

The issue I have with that logic is that you seem
to use "kernel" in a general sense without regard
to what its doing. Dropping packets is always
detrimental to the user regardless of what he's
using the computer for. An audio stream that
drops packets isn't going to be "smooth" at the
user level.

All of this aside, I need to measure the raw
capabilities of the kernel. With 'bsd OSes I can
tell what the breaking point is by driving the
machine to livelock. Linux seems to have a soft,
floating capacity in that it will drop packets
here and there for no isolatable reason. I'm
having difficulty making a case for its use in a
networking appliance, as dropped packets are not
acceptable. How do I tune the "its ok to drop
packets when x occurs" algorithm to be "its never
ok to drop packets unless x occurs" (such as a
queue depth)? Is it possible?

Danial


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
