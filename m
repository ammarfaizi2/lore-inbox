Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbUIZSfI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbUIZSfI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 14:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbUIZSfI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 14:35:08 -0400
Received: from gprs214-244.eurotel.cz ([160.218.214.244]:45696 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261610AbUIZSfD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 14:35:03 -0400
Date: Sun, 26 Sep 2004 20:34:49 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, Stefan Seyfried <seife@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.9-rc2-mm3: swsusp horribly slow on AMD64
Message-ID: <20040926183449.GA28810@elf.ucw.cz>
References: <200409251214.28743.rjw@sisk.pl> <200409261202.34138.rjw@sisk.pl> <200409261345.10565.rjw@sisk.pl> <200409261906.10635.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409261906.10635.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> [-- snip --]
> >  swsusp: Image: 11145 Pages
> >  swsusp: Pagedir: 0 Pages
> > Writing data to swap (11145 pages)...   0%
> > 
> > Here I have to press the red button unless I want to wait for a couple of 
> > hours.  I'll send you more info when there's more.
> 
> I figured out that the slowdown occurs in device_resume(), so I put a printk() 
> in dpm_resume(), like this:

When you hit "writing data to swap", device_resume should be no longer
happening.

Try to unload all modules etc, see if it goes away. If not, fix sysrq
to work for you, and look at backtrace.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
