Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964953AbWFHUHq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964953AbWFHUHq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 16:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964961AbWFHUHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 16:07:46 -0400
Received: from tim.rpsys.net ([194.106.48.114]:41187 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S964953AbWFHUHp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 16:07:45 -0400
Subject: Re: [PATCH] limit power budget on spitz
From: Richard Purdie <rpurdie@rpsys.net>
To: David Brownell <david-b@pacbell.net>, Pavel Machek <pavel@suse.cz>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Cc: lenz@cs.wisc.edu, kernel list <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net,
       Oliver Neukum <oliver@neukum.org>,
       David Liontooth <liontooth@cogweb.net>
In-Reply-To: <200606081126.20142.david-b@pacbell.net>
References: <447EB0DC.4040203@cogweb.net>
	 <1149758570.16945.156.camel@localhost.localdomain>
	 <20060608170913.GB15337@flint.arm.linux.org.uk>
	 <200606081126.20142.david-b@pacbell.net>
Content-Type: text/plain
Date: Thu, 08 Jun 2006 21:06:55 +0100
Message-Id: <1149797216.16945.234.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-08 at 11:26 -0700, David Brownell wrote:
> On Thu, Jun 08, 2006 at 10:22:50AM +0100, Richard Purdie wrote:
> > Just because the omap does it that way, doesn't mean it can't be done
> > better ;-).
> 
> Agreed that platform_data is a better approach overall for holding that
> power budget.  OMAP and AT91 should do so too.
>
> Sounds like someone should update the patch to (a) use a 150 mA budget,
> and (b) test for those other machines.  As a near term patch, anyway.
> 
> Unless there's a patch to provide and use platform_data ... but that'd
> be much more involved, since ISTR the PXA platforms don't yet have a
> mechanism to provide board-specific platform_data.  (I'll suggest the
> AT91 code as a model there; it's simpler hardware than OMAP, so the
> code is more straightforward.)

The PXA platform does have an existing mechanism to pass platform data
(I added it a while back). I've added
http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=3547/1
into the patch system replacing Pavel's version.

Cheers,

Richard

