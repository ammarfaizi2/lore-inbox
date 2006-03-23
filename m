Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751036AbWCWMMd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbWCWMMd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 07:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbWCWMMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 07:12:33 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:27987 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751036AbWCWMMc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 07:12:32 -0500
Date: Thu, 23 Mar 2006 13:12:36 +0100
From: Jens Axboe <axboe@suse.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: ck@vds.kolivas.org, "Ryan M." <kubisuro@att.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [ck] Re: -mm merge plans
Message-ID: <20060323121236.GY4285@suse.de>
References: <20060322205305.0604f49b.akpm@osdl.org> <4422554D.6000602@att.net> <20060323080925.GP4285@suse.de> <cone.1143104848.990946.31285.501@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cone.1143104848.990946.31285.501@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23 2006, Con Kolivas wrote:
> Jens Axboe writes:
> 
> >It's a heuristic, and sometimes that will work well and sometimes it
> >will not. What if during this period of inactivity, you start bringing
> >everything in from swap again, only to page it right out because the
> >next memory hog starts running? From a logical standpoint, swap prefetch
> >and the vm must work closely together to avoid paging in things which
> >really aren't needed.
> 
> If the system is idle it doesn't cost anything to bring those pages in 
> (laptop mode disables any prefetching if you're thinking about power 
> consumption on laptops). And if the system wants the ram that has been 
> filled with prefetched pages wrongly, the prefetched pages are at the tail 
> end of the inactive LRU list with a copy on backing store so if they're not 
> accessed they'll be the first thing dropped in preference to anything 
> else, without any I/O.

I missed the fact that you left these pages on backing store for easy
dropping in the future. I guess if you didn't, it could coarsely be
handled in user space easily.

-- 
Jens Axboe

