Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131411AbRCSL0L>; Mon, 19 Mar 2001 06:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131450AbRCSLZw>; Mon, 19 Mar 2001 06:25:52 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:37643 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S131411AbRCSLZt>;
	Mon, 19 Mar 2001 06:25:49 -0500
Date: Mon, 19 Mar 2001 12:24:36 +0100
From: Jens Axboe <axboe@suse.de>
To: David Mansfield <lkml@dm.ultramaster.com>
Cc: Pierre Etchemaite <petchema@concept-micro.com>,
        Jani Jaakkola <jjaakkol@cs.Helsinki.FI>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix a bug in ioctl(CDROMREADAUDIO) in cdrom.c in 2.2
Message-ID: <20010319122436.Q29105@suse.de>
In-Reply-To: <XFMail.20010315140400.petchema@concept-micro.com> <3AB264F2.7D19842F@dm.ultramaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3AB264F2.7D19842F@dm.ultramaster.com>; from lkml@dm.ultramaster.com on Fri, Mar 16, 2001 at 02:09:38PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16 2001, David Mansfield wrote:
> > Same thing for 2.4.2.
> > 
> > Is my allocation loop "over engineering", or just plain bad thing to do ?
> > 
> 
> I've been running this (or close: my version tries 8 frames, then jumps
> immediately to 1, without trying 4 and 2 in between if the kmalloc
> fails) since it was changed.  Without such a patch, my CDDA read speed
> drops to 25% the original rate.  You also have the fix that started the
> thread!
> 
> Jens (cdrom maintainer) said he was working on a more elegant solution,
> but to me, such a simple fix as yours should go in the kernel in the
> meantime.  Jens?

I haven't integrated it yet, because of the vm printing memory
allocations errors. Which sort of destroys the idea of doing "clever"
allocations like this.

-- 
Jens Axboe

