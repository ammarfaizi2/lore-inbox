Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030217AbWCAPB3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030217AbWCAPB3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 10:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030218AbWCAPBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 10:01:20 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:53102 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1030209AbWCAPBD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 10:01:03 -0500
Date: Wed, 1 Mar 2006 16:00:29 +0100
From: Jens Axboe <axboe@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Andy Chittenden <AChittenden@bluearc.com>,
       Anton Altaparmakov <aia21@cam.ac.uk>, Andrew Morton <akpm@osdl.org>,
       davej@redhat.com, linux-kernel@vger.kernel.org, lwoodman@redhat.com,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: adding swap workarounds oom - was: Re: Out of Memory: Killed process 16498 (java).
Message-ID: <20060301150028.GY4816@suse.de>
References: <89E85E0168AD994693B574C80EDB9C270393C104@uk-email.terastack.bluearc.com> <200603011526.39457.ak@suse.de> <20060301143438.GX4816@suse.de> <200603011541.51812.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603011541.51812.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01 2006, Andi Kleen wrote:
> On Wednesday 01 March 2006 15:34, Jens Axboe wrote:
> 
> 
> > > It shouldn't end up with more, only with less.
> > 
> > Sure yes, but if that 'less' is still more than what the driver can
> > handle, then there's a problem.
> 
> The driver needs to handle the full list it passed in. It's quite
> possible that the iommu layer is unable to merge anything.
> 
> 
> This isn't the block layer based merging where we guarantee
> to be able to merge in advance - just lazy after the fact merging.

Yes I realize that, I wonder if the bounce patch screwed something up
that destroys the block layer merging/accounting. We'll know when Andy
posts results that dump the request as well.

-- 
Jens Axboe

