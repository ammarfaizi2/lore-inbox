Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262775AbULQJ1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262775AbULQJ1A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 04:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262778AbULQJ1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 04:27:00 -0500
Received: from gprs215-223.eurotel.cz ([160.218.215.223]:8327 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262775AbULQJ06 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 04:26:58 -0500
Date: Fri, 17 Dec 2004 10:26:42 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Michael Frank <mhf@berlios.de>,
       SoftwareSuspend Development 
	<softwaresuspend-devel@lists.berlios.de>,
       Patrick Mochel <mochel@digitalimplant.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [SoftwareSuspend-devel] 2.6 Suspend PM issues
Message-ID: <20041217092642.GH25573@elf.ucw.cz>
References: <200412171315.50463.mhf@berlios.de> <1103263067.19280.4.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1103263067.19280.4.camel@desktop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > By what was discussed wrt ALSA issue I gather that you still resume _all_ 
> > drivers after doing the atomic copy?
> > 
> > As explained earlier this year, if this is the case, it is firstly 
> > unacceptable as it will result in loss of data in many applications and 
> > secondly very clumsy.
> > 
> > Example With 2.4 OK, with 2.6 It would fail:
> > A datalogger connected to a seral port of a notebook in the field. Data 
> > transfer in progress which can be put on hold bo lowering RTS (HW handshake) 
> > but _cannot_ be restarted. Battery low, must suspend to change battery, upon 
> > resume transfer can continue.
> > 
> > Will this be taken care of?

Driver will get enough info in its resume routine ("hey, it is resume,
but it is only resume after atomic copy"), so it can ignore the resume
if it really needs to.

But this is 2.6.11 material.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
