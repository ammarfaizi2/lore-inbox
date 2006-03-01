Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932258AbWCAOmA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbWCAOmA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 09:42:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbWCAOmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 09:42:00 -0500
Received: from ns.suse.de ([195.135.220.2]:41602 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932258AbWCAOl4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 09:41:56 -0500
From: Andi Kleen <ak@suse.de>
To: Jens Axboe <axboe@suse.de>
Subject: Re: adding swap workarounds oom - was: Re: Out of Memory: Killed process 16498 (java).
Date: Wed, 1 Mar 2006 15:41:50 +0100
User-Agent: KMail/1.9.1
Cc: Andy Chittenden <AChittenden@bluearc.com>,
       Anton Altaparmakov <aia21@cam.ac.uk>, Andrew Morton <akpm@osdl.org>,
       davej@redhat.com, linux-kernel@vger.kernel.org, lwoodman@redhat.com,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
References: <89E85E0168AD994693B574C80EDB9C270393C104@uk-email.terastack.bluearc.com> <200603011526.39457.ak@suse.de> <20060301143438.GX4816@suse.de>
In-Reply-To: <20060301143438.GX4816@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603011541.51812.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 March 2006 15:34, Jens Axboe wrote:


> > It shouldn't end up with more, only with less.
> 
> Sure yes, but if that 'less' is still more than what the driver can
> handle, then there's a problem.

The driver needs to handle the full list it passed in. It's quite
possible that the iommu layer is unable to merge anything.


This isn't the block layer based merging where we guarantee
to be able to merge in advance - just lazy after the fact merging.

-Andi
