Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750968AbWIUBpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbWIUBpZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 21:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750976AbWIUBpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 21:45:25 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:55237 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750968AbWIUBpX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 21:45:23 -0400
Subject: Re: [ckrm-tech] [patch00/05]: Containers(V2)- Introduction
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Paul Menage <menage@google.com>
Cc: Paul Jackson <pj@sgi.com>, npiggin@suse.de,
       ckrm-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       rohitseth@google.com, devel@openvz.org, clameter@sgi.com
In-Reply-To: <6599ad830609201742h71d112f4tae8fe390cb874c0b@mail.google.com>
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	 <Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com>
	 <1158777240.6536.89.camel@linuxchandra>
	 <Pine.LNX.4.64.0609201252030.32409@schroedinger.engr.sgi.com>
	 <1158798715.6536.115.camel@linuxchandra>
	 <20060920173638.370e774a.pj@sgi.com>
	 <6599ad830609201742h71d112f4tae8fe390cb874c0b@mail.google.com>
Content-Type: text/plain
Organization: IBM
Date: Wed, 20 Sep 2006 18:45:20 -0700
Message-Id: <1158803120.6536.139.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-20 at 17:42 -0700, Paul Menage wrote:
> On 9/20/06, Paul Jackson <pj@sgi.com> wrote:
> > Chandra wrote:
> > > AFAICS, That doesn't help me in over committing resources.
> >
> > I agree - I don't think cpusets plus fake numa ... handles over commit.
> > You might could hack up a cheap substitute, but it wouldn't do the job.
> 
> I have some patches locally that basically let you give out a small
> set of nodes initially to a cpuset, and if memory pressure in
> try_to_free_pages() passes a specified threshold, automatically
> allocate one of the parent cpuset's unused memory nodes to the child
> cpuset, up to specified limit. It's a bit ugly, but lets you trade of
> performance vs memory footprint on a per-job basis (when combined with
> fake numa to give lots of small nodes).

Interesting. So you could set up the fake node with "guarantee" and let
it grow till "limit" ?

BTW, can you do these with fake nodes:
 - dynamic creation
 - dynamic removal
 - dynamic change of size

Also, How could we account when a process moves from one node to
another ?
  
> 
> Paul
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


