Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261198AbULHMsA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbULHMsA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 07:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261199AbULHMsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 07:48:00 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:16594 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261198AbULHMr6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 07:47:58 -0500
Date: Wed, 8 Dec 2004 13:47:01 +0100
From: Jens Axboe <axboe@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Time sliced CFQ io scheduler
Message-ID: <20041208124701.GS19522@suse.de>
References: <20041208003736.GD16322@dualathlon.random> <1102467253.8095.10.camel@npiggin-nld.site> <20041208013732.GF16322@dualathlon.random> <20041207180033.6699425b.akpm@osdl.org> <20041208065534.GF3035@suse.de> <1102489719.8095.56.camel@npiggin-nld.site> <20041208071141.GB19522@suse.de> <1102490389.8095.69.camel@npiggin-nld.site> <20041208072616.GD19522@suse.de> <20041208093552.GK19522@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041208093552.GK19522@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08 2004, Jens Axboe wrote:
> On Wed, Dec 08 2004, Jens Axboe wrote:
> > > Hmm, damn. Lots of stuff. I guess some of the notable ones that I've
> > > had trouble with are OraSim (Oracle might give you a copy), Andrew's
> > > patch scripts when applying a stack of patches, pgbench... can't
> > > really remember any others off the top of my head.
> > 
> > The patch scripts case is interesting, last night (when committing other
> > patches) I was thinking I should try and bench that today. It has a good
> > mix of reads and writes.
> 
> AS is currently 10 seconds faster for that workload (untar of a kernel
> and then applying 2237 patches). AS completes it in 155 seconds, CFQ
> takes 164 seconds.

Turned out to be a stupid dispatch sort error in cfq, now it has the
exact same runtime as AS.

-- 
Jens Axboe

