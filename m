Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262702AbVAVLbR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262702AbVAVLbR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 06:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262703AbVAVLbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 06:31:17 -0500
Received: from gprs215-31.eurotel.cz ([160.218.215.31]:45696 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262702AbVAVLbP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 06:31:15 -0500
Date: Sat, 22 Jan 2005 12:30:53 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andi Kleen <ak@suse.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] swsusp: speed up image restoring on x86-64
Message-ID: <20050122113053.GA9306@elf.ucw.cz>
References: <200501202032.31481.rjw@sisk.pl> <20050122025019.GC27060@wotan.suse.de> <20050122095432.GA2366@elf.ucw.cz> <20050122112608.GB1303@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050122112608.GB1303@wotan.suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > + * TLB flush is purely and debugging attempt to make it fail fast if we
> > + * do something wrong. TLB is properly flushed in swsusp_restore.
> 
> Did you measure it doesn't noticeable slow down suspend? CR3 reload is quite
> expensive, and doing it for each page is quite often.

It slows it down horribly on vmware (like adding 2 minutes). On normal
hardware, copying pages does not take long enough for me to notice.

> Also if you want to really flush everything you should do a global
> flush.

That cr3 reload can probably be just removed, because swsusp is now
stable...
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
