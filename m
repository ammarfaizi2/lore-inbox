Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261820AbVC3IL5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261820AbVC3IL5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 03:11:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261816AbVC3IL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 03:11:56 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:9627 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261820AbVC3ILy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 03:11:54 -0500
Date: Wed, 30 Mar 2005 10:11:48 +0200
From: Jens Axboe <axboe@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] use cheaper elv_queue_empty when unplug a device
Message-ID: <20050330081146.GF16636@suse.de>
References: <200503290253.j2T2rqg25691@unix-os.sc.intel.com> <20050329080646.GE16636@suse.de> <42491DBE.6020303@yahoo.com.au> <20050329092819.GK16636@suse.de> <424928A1.8060400@yahoo.com.au> <4249F98D.9040706@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4249F98D.9040706@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30 2005, Nick Piggin wrote:
> Nick Piggin wrote:
> >Jens Axboe wrote:
> >
> >>Looks good, I've been toying with something very similar for a long time
> >>myself.
> >>
> >
> >Here is another thing I just noticed that should further reduce the
> >locking by at least 1, sometimes 2 lock/unlock pairs per request.
> >At the cost of uglifying the code somewhat. Although it is pretty
> >nicely contained, so Jens you might consider it acceptable as is,
> >or we could investigate how to make it nicer if Kenneth reports some
> >improvement.
> >
> >Note, this isn't runtime tested - it could easily have a bug.
> >
> 
> OK - I have booted this on a 4-way SMP with SCSI disks, and done
> some IO tests, and no hangs.
> 
> So Kenneth if you could look into this one as well, to see if
> it is worthwhile, that would be great.

I think it is definitely worth while. It might not be the prettiest, but
it isn't as bad as you originally stated :-)

-- 
Jens Axboe

