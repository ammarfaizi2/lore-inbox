Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932562AbVHOXYD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932562AbVHOXYD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 19:24:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932564AbVHOXYD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 19:24:03 -0400
Received: from ns2.suse.de ([195.135.220.15]:32162 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932562AbVHOXYB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 19:24:01 -0400
Date: Tue, 16 Aug 2005 01:24:00 +0200
From: Andi Kleen <ak@suse.de>
To: zach@vmware.com
Cc: akpm@osdl.org, chrisw@osdl.org, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org
Subject: Re: [PATCH 0/6] i386 virtualization patches, Set 3
Message-ID: <20050815232400.GV27628@wotan.suse.de>
References: <200508152258.j7FMw9p8005295@zach-dev.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508152258.j7FMw9p8005295@zach-dev.vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2005 at 03:58:09PM -0700, zach@vmware.com wrote:
> I was going to attempt to clean up the math-emu code to make it use the
> nice new segment and descriptor table accessors, but it quickly became
> apparent that this would be a long, tedious, error prone process that
> would eventually result in the death of a large section of my brain.
> In addition, it is not very fun to test this on the actual hardware it
> is designed to run on (although I did manage to track down a 386 with
> detachable i387 coprocessor, the owner is not sure it still boots).
> Someday it would be nice to have an audit of this code; it appears to
> be riddled with bugs relating to segmentation, for example it assumes
> LDT segments on overrides, does not use the mm->context semaphore to
> protect LDT access, and generally looks scarily out of date in both
> function and appearance.

Perhaps the best would be to just remove it. Near all 386s should be far
beyond their MTBF by now. Mark it CONFIG_BROKEN and if nobody complains for 
one or two releases remove it completely.

The ugly verify_area 386 bugfix workaround code could go at the same
time.

-Andi
