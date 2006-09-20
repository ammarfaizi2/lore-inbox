Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932065AbWITRQG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbWITRQG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 13:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932067AbWITRQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 13:16:06 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:54756 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932066AbWITRQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 13:16:03 -0400
Date: Wed, 20 Sep 2006 10:15:52 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Rohit Seth <rohitseth@google.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, devel@openvz.org,
       pj@sgi.com, npiggin@suse.de,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch00/05]: Containers(V2)- Introduction
In-Reply-To: <1158773699.7705.19.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0609201012310.30793@schroedinger.engr.sgi.com>
References: <1158718568.29000.44.camel@galaxy.corp.google.com> 
 <Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com>
 <1158773699.7705.19.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sep 2006, Alan Cox wrote:

> Ar Mer, 2006-09-20 am 09:25 -0700, ysgrifennodd Christoph Lameter:
> > We already have such a functionality in the kernel its called a cpuset. A 
> > container could be created simply by creating a fake node that then 
> > allows constraining applications to this node. We already track the 
> > types of pages per node. The statistics you want are already existing. 
> > See /proc/zoneinfo and /sys/devices/system/node/node*/*.
> 
> CPUsets don't appear to scale to large numbers of containers (say 5000,
> with 200-500 doing stuff at a time). They also don't appear to do any
> tracking of kernel side resource objects, which is critical to
> containment. Indeed for some of us the CPU management and user memory
> management angle is mostly uninteresting.

The scalability issues can certainly be managed. See the discussions on 
linux-mm. Kernel side resource objects? slab pages? Those are tracked.

> I'm also not clear how you handle shared pages correctly under the fake
> node system, can you perhaps explain that further how this works for say
> a single apache/php/glibc shared page set across 5000 containers each a
> web site.

Cpusets can share nodes. I am not sure what the problem would be? Paul may 
be able to give you more details.
