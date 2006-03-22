Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbWCVFsY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbWCVFsY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 00:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbWCVFsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 00:48:24 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:42429 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S1750784AbWCVFsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 00:48:23 -0500
Date: Wed, 22 Mar 2006 06:48:20 +0100
From: Sander <sander@humilis.net>
To: Jeff Garzik <jeff@garzik.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Sander <sander@humilis.net>,
       Mark Lord <liml@rtr.ca>, Mark Lord <lkml@rtr.ca>,
       Andrew Morton <akpm@osdl.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6.xx: sata_mv: another critical fix
Message-ID: <20060322054820.GA5081@favonius>
Reply-To: sander@humilis.net
References: <442004E4.7010002@rtr.ca> <20060321153708.GA11703@favonius> <Pine.LNX.4.64.0603211028380.3622@g5.osdl.org> <20060321191547.GC20426@favonius> <Pine.LNX.4.64.0603211132340.3622@g5.osdl.org> <20060321204435.GE25066@favonius> <Pine.LNX.4.64.0603211249270.3622@g5.osdl.org> <44206B81.1030309@garzik.org> <Pine.LNX.4.64.0603211316580.3622@g5.osdl.org> <44207210.9080903@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44207210.9080903@garzik.org>
X-Uptime: 06:35:35 up 19 days, 10:45, 29 users,  load average: 3.61, 2.57, 2.30
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote (ao):
> Linus Torvalds wrote:
> >Maybe back-porting any critical sata_mv fixes to 2.6.16.x is appropriate, 
> >considering that I don't think RH or SuSE will necessarily want to pull 
> >the whole thing.

I'll try the 2.6.16-git3 snapshot.

> Agreed -- in theory -- but I'll let Mark Lord or somebody else do that, 
> if they are motivated. sata_mv is labelled "HIGHLY EXPERIMENTAL" for a 
> reason :)  Its a known bug report generator, with bugs far outpacing 
> fixes at present.
> 
> Key patches to backport or test, in priority order, would be:
> 
> [libata sata_mv] do not enable PCI MSI by default

Is this in -rc6-mm2 already? Because just for fun I enabled
CONFIG_PCI_MSI=y in my -rc6-mm2 .config and it still is rock stable.

> After that, you're at the mercy of not-yet-worked-around hardware bugs, 
> and (as Mark Lord appears to be finding) some driver bugs as well.
> 
> sata_mv development slowed to a trickle for a long time, after the 
> original developer disappeared, and I didn't have time to dig deep into 
> the hardware details. Mark Lord recently started picking up the pieces, 
> so things are looking much better already. I have another patch from 
> Mark to forward to you and 2.6.16.x (stable@), coming to you today.

Things indeed look much, much better. I'll try and find some more
serious fs tests and hit -rc6-mm2.

Thank you all for your work on this driver! I'll order two more of these
fine controllers.

	Sander

-- 
Humilis IT Services and Solutions
http://www.humilis.net
