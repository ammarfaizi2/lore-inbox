Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262851AbULRHnb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262851AbULRHnb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 02:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262849AbULRHnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 02:43:31 -0500
Received: from gprs215-176.eurotel.cz ([160.218.215.176]:5518 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262847AbULRHnT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 02:43:19 -0500
Date: Sat, 18 Dec 2004 08:42:02 +0100
From: Pavel Machek <pavel@suse.cz>
To: Michael Frank <mhf@berlios.de>
Cc: Patrick Mochel <mochel@digitalimplant.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       softwaresuspend-devel@lists.berlios.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [SoftwareSuspend-devel] 2.6 Suspend PM issues
Message-ID: <20041218074202.GG29084@elf.ucw.cz>
References: <200412171315.50463.mhf@berlios.de> <1103263067.19280.4.camel@desktop.cunninghams> <20041217092642.GH25573@elf.ucw.cz> <200412181014.30998.mhf@berlios.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412181014.30998.mhf@berlios.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > By what was discussed wrt ALSA issue I gather that you still resume
> > > > _all_ drivers after doing the atomic copy?
> > > >
> > > > As explained earlier this year, if this is the case, it is firstly
> > > > unacceptable as it will result in loss of data in many applications and
> > > > secondly very clumsy.
> > > >
> > > > Example With 2.4 OK, with 2.6 It would fail:
> > > > A datalogger connected to a seral port of a notebook in the field. Data
> > > > transfer in progress which can be put on hold bo lowering RTS (HW
> > > > handshake) but _cannot_ be restarted. Battery low, must suspend to
> > > > change battery, upon resume transfer can continue.
> > > >
> > > > Will this be taken care of?
> >
> > Driver will get enough info in its resume routine ("hey, it is resume,
> > but it is only resume after atomic copy"), so it can ignore the resume
> > if it really needs to.
> 
> Each driver has to make the decision when to ignore resume? that would add a 
> lot of bloat as well as lots of work to implement and test the changes for 
> 100s of drivers...

No, only those drivers where extra resume does some damage. So far I
know about one, and that's your data logging device.
									Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
