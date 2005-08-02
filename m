Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261401AbVHBGrX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261401AbVHBGrX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 02:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbVHBGrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 02:47:16 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:34458 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261400AbVHBGqc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 02:46:32 -0400
Date: Tue, 2 Aug 2005 08:48:31 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Daniel Drake <dsd@gentoo.org>, Otto Meier <gf435@gmx.net>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: Driver for sata adapter promise sata300 tx4
Message-ID: <20050802064827.GV22569@suse.de>
References: <42EDE918.9040807@gmx.net> <42EE3501.7010107@gentoo.org> <42EE3FB8.10008@gmx.net> <42EE4ADF.4080502@gentoo.org> <20050801201756.GQ22569@suse.de> <20050801203228.GS22569@suse.de> <42EE87DF.1080508@pobox.com> <20050801204241.GU22569@suse.de> <42EE8AD5.6080100@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42EE8AD5.6080100@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01 2005, Jeff Garzik wrote:
> Jens Axboe wrote:
> >On Mon, Aug 01 2005, Jeff Garzik wrote:
> >
> >>Jens Axboe wrote:
> >>
> >>>Oh, and forget TCQ. It's a completely worthless technology inherited
> >>
> >>>from PATA,
> >>
> >>Agreed.
> >>
> >>There are a few controllers where we may -eventually- add TCQ support, 
> >>controllers that do 100% of TCQ in hardware.  But that's so far down the 
> >>priority list, it's below just about everything else.
> >>
> >>There may just be little motivation to -ever- support TCQ, even when 
> >>libata is the 'main' IDE driver, sometime in the future.
> >
> >
> >Host supported TCQ only removes the pain from the software side, it
> >still doesn't make it a fast techology. The only reason you would want
> >to support that would be "it's easy, why not...". From my POV, I would
> >refuse to support it just from an ideological standpoint :-)
> >
> >Legacy TCQ, hell no, not in a million years.
> 
> This is largely a confusion of terminology.  On the SATA page,
> 
> "host-based TCQ" == host controller has a hardware queue (DMA ring, or 
> whatnot)
> 
> "legacy TCQ" == making use of READ/WRITE DMA QUEUED commands.
> 
> I would only consider accepting the -intersection- of these two feature 
> sets, where host TCQ and legacy TCQ are -both- present.  As an extremely 
> low, low priority.  :)

That's what I understand as host supported TCQ, you talk sanely with the
hardware and that handles the actual TCQ with the device. A controller
that just has a hardware queue but doesn't actually do queueing at the
device side is even less interesting, since it buys you very close to
nothing.

> As a terminology side note, the SATA community refers to "everything 
> that is not NCQ" as "legacy TCQ".  Legacy TCQ doesn't necessarily imply 
> use of the standard PCI IDE interface, handling SERV interrupts and all 
> that nastiness.

In part I agree with that, since "everything that is not NCQ" is legacy
in the way that if you have it, perhaps continue to support, but if not
don't bother since it's not worth it.

> Patches to software-status.html to make this more clear are certainly 
> welcome, as well :)

If I update that document, the wording will be stronger :-)

-- 
Jens Axboe

