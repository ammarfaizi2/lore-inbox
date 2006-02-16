Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030371AbWBPSBc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030371AbWBPSBc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 13:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030406AbWBPSBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 13:01:32 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:31498 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1030371AbWBPSBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 13:01:31 -0500
Date: Thu, 16 Feb 2006 18:01:25 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Tejun Heo <htejun@gmail.com>, Linus Torvalds <torvalds@osdl.org>
Cc: Matt Reimer <mattjreimer@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] block: convert IDE to use blk_kmap helpers
Message-ID: <20060216180125.GE29443@flint.arm.linux.org.uk>
Mail-Followup-To: Tejun Heo <htejun@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Matt Reimer <mattjreimer@gmail.com>, linux-kernel@vger.kernel.org
References: <11371658562541-git-send-email-htejun@gmail.com> <1137165856390-git-send-email-htejun@gmail.com> <f383264b0602141107v78864d7bua38fbaeefafd5@mail.gmail.com> <43F28C4E.1090104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F28C4E.1090104@gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2006 at 11:05:02AM +0900, Tejun Heo wrote:
> Matt Reimer wrote:
> >On 1/13/06, Tejun Heo <htejun@gmail.com> wrote:
> >
> >>Convert direct uses of kmap/unmap to blk_kmap/unmap in IDE.  This
> >>combined with the previous bio helper change fixes PIO cache coherency
> >>bugs on architectures with aliased caches.
> >>
> >>Signed-off-by: Tejun Heo <htejun@gmail.com>
> >
> >
> >This series of patches makes booting from CF on my PXA255 device. Thanks 
> >Tejun.
> >
> >Will these patches make 2.6.16?
> >
> 
> Unfortunately, this patchset has some pending issues and probably should 
> be spinned one more time with another approach, although I'm currently 
> not very sure what the another approach should be.  :-(
> 
> I'll try to do something.  Thanks.

I think that's a mistake.  Yes, James has decided to object, but I
think that James' objections are unfounded.

Since James doesn't even have a machine which shows this bug, it's
rather convenient for him to object and effectively stand in the way
of having the bug being fixed.

Or that's how I'm reading the current impass on these patches.

Linus - can we merge Tejun's patches so that we have an IDE subsystem
which works on ARM platforms please?  If James wants to come up with
another solution later on, I'm sure we can transition all drivers
over to that new solution once we know what it is.  Until then, can
we please fix the bug?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
