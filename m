Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750787AbWCJRvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbWCJRvI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 12:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbWCJRvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 12:51:08 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:53632 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750787AbWCJRvH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 12:51:07 -0500
Date: Fri, 10 Mar 2006 18:50:54 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: lenz@cs.wisc.edu, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] Collie battery status sensing code
Message-ID: <20060310175054.GC8018@elf.ucw.cz>
References: <20060309123842.GA3619@elf.ucw.cz> <1141910391.10107.49.camel@localhost.localdomain> <20060305001254.GA2423@ucw.cz> <1141924371.10107.75.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141924371.10107.75.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I thought about it, and considered it quite ugly. Result would be all
> > data on the platform bus with half-empty device on ucb1x00 "bus". It
> > would bring me some problems with registering order: if platform
> > device is registered too soon, ucb will be NULL and it will crash and
> > burn. OTOH I already have static *ucb, so it is doable, and I can do
> > it if you prefer it that way...
> 
> If you register the sharpsl-pm device in the collie_pm_add() function,
> ucb should always have registered by that point? As you say, you already
> have the static *ucb and I'm hoping using the platform device will mean
> less invasive changes in sharpsl_pm itself in the future?

Well, difference is not going to be 

> For the record, this patch from Dirk Opfer also exists. He's working on
> using sharpsl-pm on tosa.
> 
> http://www.rpsys.net/openzaurus/patches/archive/sharpsl_pm-do-r2.patch

Yep, looks nice, and will be useful for collie, too.
								Pavel

-- 
68:        byte [] adUSER = GetAtomData( GetAtomPos( AtomUSER ), true );
