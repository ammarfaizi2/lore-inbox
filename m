Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265446AbVBETtB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265446AbVBETtB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 14:49:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269785AbVBETtA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 14:49:00 -0500
Received: from gprs214-21.eurotel.cz ([160.218.214.21]:54727 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265448AbVBETrh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 14:47:37 -0500
Date: Sat, 5 Feb 2005 20:47:22 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.11-rc3-mm1: softlockup and suspend/resume
Message-ID: <20050205194722.GB1547@elf.ucw.cz>
References: <20050204103350.241a907a.akpm@osdl.org> <200502051411.16194.rjw@sisk.pl> <20050205143511.GA28656@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050205143511.GA28656@elte.hu>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > It looks like softlockup is not happy with suspend/resume:
> 
> Does it happen while writing out state to disk? I've attached a patch
> for touch_softlockup_watchdog() below - but i think what we really need
> is another mechanism. I'm wondering what the primary reason for the
> lockup-detection is - did swsuspend stop the the softlockup threads?

swsusp likes all threads stopped. You can mark threads
PF_NOFREEZE and swsusp will leave them alone.
								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
