Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270937AbVBEUBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270937AbVBEUBN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 15:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270419AbVBETzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 14:55:33 -0500
Received: from gprs214-21.eurotel.cz ([160.218.214.21]:56007 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S269471AbVBETtE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 14:49:04 -0500
Date: Sat, 5 Feb 2005 20:48:52 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.11-rc3-mm1: softlockup and suspend/resume
Message-ID: <20050205194851.GC1547@elf.ucw.cz>
References: <20050204103350.241a907a.akpm@osdl.org> <200502051411.16194.rjw@sisk.pl> <20050205143511.GA28656@elte.hu> <200502051548.26729.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502051548.26729.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > It looks like softlockup is not happy with suspend/resume:
> > 
> > Does it happen while writing out state to disk?
> 
> No, it occurs during resume, right after the image has been restored (sorry,
> I should have said this before).
> 
> > I've attached a patch for touch_softlockup_watchdog() below - but i think
> > what we really need is another mechanism. I'm wondering what the primary
> > reason for the lockup-detection is - did swsuspend stop the the softlockup
> > threads? 
> 
> If my understanding is correct, the time between suspend (ie the creation of
> the image) and resume (ie the resotration of the image) is considered as spent
> in the kernel, so it triggers softlockup as soon as its threads are woken up (is
> that correct, Pavel?).

I do not know how exactly softlockup works, but yes, that seems
reasonable.
									Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
