Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750924AbWIUBZt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750924AbWIUBZt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 21:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750927AbWIUBZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 21:25:49 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:7110 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750924AbWIUBZs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 21:25:48 -0400
Subject: Re: [ckrm-tech] [patch00/05]: Containers(V2)- Introduction
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Paul Menage <menage@google.com>
Cc: Paul Jackson <pj@sgi.com>, npiggin@suse.de,
       ckrm-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       rohitseth@google.com, clameter@sgi.com
In-Reply-To: <6599ad830609201605s2fc1ccbdse31e3e60a50d56bc@mail.google.com>
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	 <Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com>
	 <1158777240.6536.89.camel@linuxchandra>
	 <6599ad830609201143h19f6883wb388666e27913308@mail.google.com>
	 <1158778496.6536.95.camel@linuxchandra>
	 <6599ad830609201225k3d38afe2gea7adc2fa8067e0@mail.google.com>
	 <20060920134903.fbd9fea8.pj@sgi.com>
	 <6599ad830609201351k6d72067fpc86069ffb5bb60ba@mail.google.com>
	 <20060920140401.39cc88ab.pj@sgi.com>
	 <6599ad830609201605s2fc1ccbdse31e3e60a50d56bc@mail.google.com>
Content-Type: text/plain
Organization: IBM
Date: Wed, 20 Sep 2006 18:25:45 -0700
Message-Id: <1158801945.6536.125.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-20 at 16:05 -0700, Paul Menage wrote:
> On 9/20/06, Paul Jackson <pj@sgi.com> wrote:
> > Paul M. wrote:
> > > I'm not saying that they can - but they could be parallel types of
> > > resource controller for a generic container abstraction,
> >
> > When there are a sufficiently large number of sufficiently
> > similar types of objects, such as for example file systems,
> > then a 'generic container abstraction' such as vfs in the
> > file system case becomes well worth it, even essential.
> 
> Well, cpusets, resource groups and bean counters are all process
> container abstractions of a sort, all with different management
> interfaces to userspace. But they all have the notion of wanting to be
> able to group tasks together.

Very true. When you read it this way it spells PAGG :), doesn't it

I think it is a good idea to have a separate grouping mechanism.

> 
> Here's the kind of approach I'm suggesting. Note that the extremely
> incomplete patch attached (not included inline since it's 87K) hasn't
> even been compiled, let alone tested - it's just to illustrate the
> idea of separation between the container aspects of cpusets (which are
> almost identical to the container aspects of resource groups) and the
> resource control portions. Essentially, I've
> 
> - ripped out the cpusetfs portions of cpusets and moved them to container.c
> 
> - added some hooks from the container system into cpusets, to e.g.
> populate a containerfs dir with the appropriate cpusets files, or set
> the right memory/cpu masks for a task that moves into a container.
> 
> - adjusted places that would need to be updated to call
> container_xxx() rather than cpuset_xxx().
> 
> It would be fairly easy to hook resource groups into the same container system.
> 
> Paul
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


