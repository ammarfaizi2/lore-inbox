Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751813AbWCOPcG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751813AbWCOPcG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 10:32:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751961AbWCOPcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 10:32:06 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:35252 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751813AbWCOPcF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 10:32:05 -0500
Subject: Re: [PATCH 03/03] Unmapped: Add guarantee code
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Magnus Damm <magnus@valinux.co.jp>,
       Linux Kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       Valerie Clement <Valerie.Clement@bull.net>
In-Reply-To: <aec7e5c30603110429tcad0ff1lc0073c613486eec5@mail.gmail.com>
References: <20060310034412.8340.90939.sendpatchset@cherry.local>
	 <20060310034429.8340.61997.sendpatchset@cherry.local>
	 <44110727.802@yahoo.com.au>
	 <aec7e5c30603092204h21fa7639wf90e6d4e2fdee128@mail.gmail.com>
	 <1142005277.8174.107.camel@linuxchandra>
	 <aec7e5c30603110429tcad0ff1lc0073c613486eec5@mail.gmail.com>
Content-Type: text/plain
Organization: IBM
Date: Wed, 15 Mar 2006 07:32:00 -0800
Message-Id: <1142436720.1658.29.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-03-11 at 21:29 +0900, Magnus Damm wrote:

> 
> > > The memory controller in ckrm also breaks out the LRU, but puts one
> > > LRU instance in each class. My code does not depend on ckrm, but it
> > > should be possible to have some kind of resource control with this
> >
> > i do not understand how breaking lru lists into mapped/unmapped pages
> > and providing a knob to control the proportion of mapped/unmapped pages
> > in a node help in resource control.
> 
> It is one type of resource control. It is of course not a complete
> solution like ckrm, but on machines with more than one node (or a
> regular PC with numa emulation) it is possible to create partitions
> using CPUSETS and then use this patch to control the amount of memory
> that should be dedicated for say mapped pages on each node.
> 
> CKRM and CPUSETS are the ways to provide resource control today.
> CPUSETS is coarse-grained, but CKRM aims for finer granularity. None
> of them have a way to control the ratio between mapped and unmapped
> pages, excluding this patch.

Oh... different type of resource control ? Controlling _how_ a resource
is used rather than _who_ uses the resource (which is what CKRM intends
to provide).
 
> 
> I'd like to see CKRM merged, but I'm not the one calling the shots

8-)

> (probably fortunate enough for everyone). I think CKRM has the same
> properties as the ClockPRO work - it would be nice to have it included
> in mainline, but these patches modify lots of crital code and
> therefore has problems getting accepted that easily.
> 
> So this patch is YASSITRD. (Yet Another Small Step In The Right Direction)
> 
> Thank you!
> 
> / magnus
> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


