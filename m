Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268854AbUJPUkr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268854AbUJPUkr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 16:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268856AbUJPUkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 16:40:47 -0400
Received: from gprs214-153.eurotel.cz ([160.218.214.153]:49536 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S268854AbUJPUkq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 16:40:46 -0400
Date: Sat, 16 Oct 2004 22:40:27 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ncunningham@linuxmail.org, pascal.schmidt@email.de,
       Stefan Seyfried <seife@suse.de>
Subject: Re: swsusp: 8-order allocation failure on demand (update)
Message-ID: <20041016204027.GA24434@elf.ucw.cz>
References: <2HO0C-4xh-29@gated-at.bofh.it> <200410142354.25665.rjw@sisk.pl> <20041016164347.GA2636@atrey.karlin.mff.cuni.cz> <200410162131.19761.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410162131.19761.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Unfortunately that's rather ugly. You'd ~32 bytes per 4K page, that's
> > almost 1% overhead, not nice. Better solution (but more work) is to
> > switch to link-lists or integrate swsusp2.
> 
> Well, I wonder if the page allocation failures are a swsusp problem,
> really.  

Yes, they are. Kernel memory allocation is not design to do 8-order
allocations properly. swsusp really should not use them.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
