Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269076AbUI3Ow3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269076AbUI3Ow3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 10:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269300AbUI3Ow2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 10:52:28 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:64492 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S269076AbUI3OwK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 10:52:10 -0400
Date: Thu, 30 Sep 2004 16:49:34 +0200
From: Jens Axboe <axboe@suse.de>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][1/1] Per-priority statistics for CFQ w/iopriorities 2.6.8.1
Message-ID: <20040930144934.GC3251@suse.de>
References: <20040930065917.GA2288@suse.de> <415C1643.8000605@watson.ibm.com> <20040930142004.GB3251@suse.de> <415C1C6D.1030307@watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <415C1C6D.1030307@watson.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30 2004, Shailabh Nagar wrote:
> Jens Axboe wrote:
> 
> >On Thu, Sep 30 2004, Shailabh Nagar wrote:
> >
> >>Jens Axboe wrote:
> >>
> >>>Hi,
> >>>
> >>>Missed this patch the first time over (thank you lwn :-) - why are you
> >>>using atomic counters? In all the paths you set them, you already have
> >>>the queue lock.
> >>>
> >>
> >>Thats right, there's no need for them. I used these instinctively....
> >>Will fix in next version, unless (hint, hint) you're taking a look at 
> >>adding priorities back to mainline's CFQ.
> >
> >
> >It will never be for the mainline cfq, that is a dead code base. -mm has
> >a first stab at a cfq v2 with persistent io contexts, the priority based
> >code will go on top of that.
> >
> 
> Great. In CKRM, we'll switch to using -mm's cfq then.

You'll note that the cic is a per-process-per-queue context, this could
hold a reference to whatever CKRM grouping structure you use.

-- 
Jens Axboe

