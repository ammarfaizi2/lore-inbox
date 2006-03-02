Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751204AbWCBM0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbWCBM0r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 07:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbWCBM0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 07:26:47 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:23896 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751204AbWCBM0q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 07:26:46 -0500
Date: Thu, 2 Mar 2006 13:26:14 +0100
From: Jens Axboe <axboe@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Andy Chittenden <AChittenden@bluearc.com>,
       Anton Altaparmakov <aia21@cam.ac.uk>, Andrew Morton <akpm@osdl.org>,
       davej@redhat.com, linux-kernel@vger.kernel.org, lwoodman@redhat.com,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: adding swap workarounds oom - was: Re: Out of Memory: Killed process 16498 (java).
Message-ID: <20060302122614.GK4329@suse.de>
References: <89E85E0168AD994693B574C80EDB9C270393C1BF@uk-email.terastack.bluearc.com> <20060302111046.GF4329@suse.de> <200603021321.09082.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603021321.09082.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02 2006, Andi Kleen wrote:
> On Thursday 02 March 2006 12:10, Jens Axboe wrote:
> 
> > I'm waiting for Andi to render an opinion on the problem. It should have
> > no corruption implications, the PIO path will handle arbitrarily large
> > requests. I'm assuming the mapped sg table is correct, just odd looking
> > for some reason.
> 
> I was waiting for feedback if iommu=nomerge changes anything. With that option
> the IOMMU code will never touch the layout of the sg list, just rewrite
> ->dma_address

Andy already reported that it didn't change anything. The output doesn't
looked merged anyways in most of the cases, it's the offsetting that
looks odd.

-- 
Jens Axboe

