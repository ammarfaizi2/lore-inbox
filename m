Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932744AbVLHX2m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932744AbVLHX2m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 18:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932740AbVLHX2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 18:28:41 -0500
Received: from ns.suse.de ([195.135.220.2]:21436 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932733AbVLHX2j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 18:28:39 -0500
Date: Fri, 9 Dec 2005 00:28:27 +0100
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: Andi Kleen <ak@suse.de>, akpm@osdl.org,
       Christoph Hellwig <hch@infradead.org>, linux-ia64@vger.kernel.org,
       steiner@sgi.com, linux-kernel@vger.kernel.org,
       Wu Fengguang <wfg@mail.ustc.edu.cn>, discuss@x86-64.org
Subject: Re: [discuss] Re: [PATCH 1/3] Zone reclaim V3: main patch
Message-ID: <20051208232827.GZ11190@wotan.suse.de>
References: <20051208203707.30456.57439.sendpatchset@schroedinger.engr.sgi.com> <20051208210850.GS11190@wotan.suse.de> <Pine.LNX.4.62.0512081320200.30786@schroedinger.engr.sgi.com> <20051208225102.GW11190@wotan.suse.de> <Pine.LNX.4.62.0512081514510.31246@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0512081514510.31246@schroedinger.engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2005 at 03:19:36PM -0800, Christoph Lameter wrote:
> On Thu, 8 Dec 2005, Andi Kleen wrote:
> 
> > I would use > LOCAL_DISTANCE or perhaps if you really want
> > a new constant with value 12-15. 
> 
> One may define RECLAIM_DISTANCE to be 12 for x86_64 in topology.h
> in order to get zone reclaim earlier for the opteron clusters. I would 
> think though that large opteron clusters also have distances > 20.
> 
> My experience is that at 20 systems do not need zone reclaim yet.

I really cannot confirm your experience here.

>  
> > > RECLAIM_DISTANCE can be set per arch if the default is not okay.
> > 
> > Well if anything it would be per system - perhaps need to make
> > it a boot option or somesuch later. 
> 
> The idea here was to avoid any manual configuration. The numa distances 

Sure as a default this makes sense.

I'm just questioning your default values.

> must related in some real way to performance (at least per arch) in order 
> for the automatic determination of zone reclaim to make sense. We could 
> have a boot time override but then RECLAIM_DISTANCE needs to be a 
> variable not a macro.

The macro can be always later defined to a variable, no problem.

-Andi

