Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932085AbWITRYO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbWITRYO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 13:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932088AbWITRYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 13:24:14 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:29914 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932085AbWITRYM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 13:24:12 -0400
Subject: Re: [patch00/05]: Containers(V2)- Introduction
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Lameter <clameter@sgi.com>
Cc: Rohit Seth <rohitseth@google.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, devel@openvz.org,
       pj@sgi.com, npiggin@suse.de,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0609201012310.30793@schroedinger.engr.sgi.com>
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	 <Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com>
	 <1158773699.7705.19.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0609201012310.30793@schroedinger.engr.sgi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 20 Sep 2006 18:48:11 +0100
Message-Id: <1158774491.7705.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-09-20 am 10:15 -0700, ysgrifennodd Christoph Lameter:
> The scalability issues can certainly be managed. See the discussions on 
> linux-mm.

I'll take a look at a web archive of it, I don't follow -mm.

>  Kernel side resource objects? slab pages? Those are tracked.

Slab pages isn't a useful tracking tool for two reasons. The first is
that some resources are genuinely a shared kernel managed pool and
should be treated that way - thats obviously easy to sort out.

The second is that slab pages are not the granularity of allocations so
it becomes possible (and deliberately influencable) to make someone else
allocate the pages all the time so you don't pay the cost. Hence the
beancounters track the real objects.

> Cpusets can share nodes. I am not sure what the problem would be? Paul may 
> be able to give you more details.

If it can do it in a human understandable way, configured at runtime
with dynamic sharing, overcommit and reconfiguration of sizes then
great. Lets see what Paul has to say.

Alan
