Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750824AbWIUAaN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbWIUAaN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 20:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbWIUAaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 20:30:13 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:40092 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750824AbWIUAaL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 20:30:11 -0400
Subject: Re: [ckrm-tech] [patch00/05]: Containers(V2)- Introduction
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Paul Menage <menage@google.com>
Cc: npiggin@suse.de, CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>, pj@sgi.com,
       Rohit Seth <rohitseth@google.com>, devel@openvz.org,
       Christoph Lameter <clameter@sgi.com>
In-Reply-To: <6599ad830609201257m22605deei25ae6a0eadb6c516@mail.google.com>
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	 <Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com>
	 <1158777240.6536.89.camel@linuxchandra>
	 <6599ad830609201143h19f6883wb388666e27913308@mail.google.com>
	 <1158778496.6536.95.camel@linuxchandra>
	 <6599ad830609201225k3d38afe2gea7adc2fa8067e0@mail.google.com>
	 <1158780923.6536.110.camel@linuxchandra>
	 <6599ad830609201257m22605deei25ae6a0eadb6c516@mail.google.com>
Content-Type: text/plain
Organization: IBM
Date: Wed, 20 Sep 2006 17:30:07 -0700
Message-Id: <1158798607.6536.112.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-20 at 12:57 -0700, Paul Menage wrote:
> On 9/20/06, Chandra Seetharaman <sekharan@us.ibm.com> wrote:
> > > At its most crude, this could be something like:
> > >
> > > struct container {
> > > #ifdef CONFIG_CPUSETS
> > >   struct cpuset cs;
> > > #endif
> > > #ifdef CONFIG_RES_GROUPS
> > >   struct resource_group rg;
> > > #endif
> > > };
> >
> > Won't it restrict the user to choose one of these, and not both.
> 
> Not necessarily - you could have both compiled in, and each would only
> worry about the resource management that they cared about - e.g. you
> could use the memory node isolation portion of cpusets (in conjunction
> with fake numa nodes/zones) for memory containment, but give every
> cpuset access to all CPUs and control CPU usage via the resource
> groups CPU controller.
> 
> The generic code would take care of details like container
> creation/destruction (with appropriate callbacks into cpuset and/or
> res_group code, tracking task membership of containers, etc.

What I am wondering is that whether the tight coupling of rg and cpuset
(into a container data structure) is ok.

> 
> Paul
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


