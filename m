Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263284AbUKZXLU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263284AbUKZXLU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 18:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263283AbUKZTss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:48:48 -0500
Received: from zeus.kernel.org ([204.152.189.113]:4291 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262375AbUKZT27 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:28:59 -0500
Date: Thu, 25 Nov 2004 23:45:18 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend 2 merge: 17/51: Disable MCE checking during suspend.
Message-ID: <20041125224517.GF2711@elf.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101295216.5805.256.camel@desktop.cunninghams> <20041125181954.GG1417@openzaurus.ucw.cz> <1101420341.27250.58.camel@desktop.cunninghams> <20041125223155.GB2711@elf.ucw.cz> <1101422304.27250.97.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101422304.27250.97.camel@desktop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > > Avoid a potential SMP deadlock here.
> > > > 
> > > > ..and loose MCE report.
> > > 
> > > Deadlock or get an MCE report and do a printk when we're shutting down
> > > anyway?
> > 
> > If MCE happens, I'd like user to report it. Loosing it is wrong,
> > deadlocking may be actually better because at least you get the
> > report. I'd BUG(). 
> > 
> > MCEs are hardware problem, right? They should not be common.
> 
> It's not them occurring that's the problem, it's checking for them that
> involves an SMP call :<

Oops, that bad... and checking is done periodically? That's bad. Okay,
your solution is right here.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
