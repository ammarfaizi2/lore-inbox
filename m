Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932723AbVLHXlB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932723AbVLHXlB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 18:41:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932733AbVLHXlB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 18:41:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:46571 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932723AbVLHXlA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 18:41:00 -0500
Date: Fri, 9 Dec 2005 00:40:58 +0100
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: Andi Kleen <ak@suse.de>, akpm@osdl.org,
       Christoph Hellwig <hch@infradead.org>, linux-ia64@vger.kernel.org,
       steiner@sgi.com, linux-kernel@vger.kernel.org,
       Wu Fengguang <wfg@mail.ustc.edu.cn>, discuss@x86-64.org
Subject: Re: [discuss] Re: [PATCH 1/3] Zone reclaim V3: main patch
Message-ID: <20051208234058.GA11190@wotan.suse.de>
References: <20051208203707.30456.57439.sendpatchset@schroedinger.engr.sgi.com> <20051208210850.GS11190@wotan.suse.de> <Pine.LNX.4.62.0512081320200.30786@schroedinger.engr.sgi.com> <20051208225102.GW11190@wotan.suse.de> <Pine.LNX.4.62.0512081514510.31246@schroedinger.engr.sgi.com> <20051208232827.GZ11190@wotan.suse.de> <Pine.LNX.4.62.0512081531150.31342@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0512081531150.31342@schroedinger.engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2005 at 03:35:05PM -0800, Christoph Lameter wrote:
> On Fri, 9 Dec 2005, Andi Kleen wrote:
> 
> > > My experience is that at 20 systems do not need zone reclaim yet.
> > 
> > I really cannot confirm your experience here.
> 
> Maybe the meaning of these numbers varies? I know that 10 is a local 
> access but the assumption in include/linux/numa.h that 20 is a remote 
> access is probably already a guess.

The spec seems to suggest it's roughly the NUMA factor scaled (so for 1.4
you would get 14). But I haven't actually seen a Opteron with correct
SLIT yet so I don't know what they use ...

> I know that our Altix machines seem to use 10 for a local and 20 for 
> nonlocal but same box. The distances then increase from there.

Unless non local same box is 2 times as slow as the local I wouldn't
consider that correct.  (I would expect the Altix to do better than that) 
-Andi
