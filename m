Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262442AbUKZToV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262442AbUKZToV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 14:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263104AbUKZTnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:43:19 -0500
Received: from zeus.kernel.org ([204.152.189.113]:4291 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262442AbUKZT1g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:27:36 -0500
Date: Fri, 26 Nov 2004 00:26:12 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Suspend2 merge: 1/51: Device trees
Message-ID: <20041125232612.GJ2711@elf.ucw.cz>
References: <20041125165413.GB476@openzaurus.ucw.cz> <20041125185304.GA1260@elf.ucw.cz> <1101421336.27250.80.camel@desktop.cunninghams> <20041125224124.GE2711@elf.ucw.cz> <1101423148.27250.110.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101423148.27250.110.camel@desktop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > I thought I wrote - perhaps I'm wrong here - that I understand that your
> > > new work in this area might make this unnecessary. I really only want to
> > > do it this way because I don't know what other drivers might be doing
> > > while we're writing the LRU pages. I'm not worried about them touching
> > > LRU. What I am worried about is them allocating memory and starving
> > > suspend so that we get hangs due to being oom. If they're suspended, we
> > > have more certainty as to how memory is being used. I don't remember
> > > what prompted me to do this in the first place, but I'm pretty sure it
> > > would have been a real observed issue.
> > 
> > Uh... It seems like quite a lot of work. Would not reserving few more
> > pages help here? Or perhaps right solution is to fix "broken" drivers
> > that need too much memory...
> 
> I'd agree, except that I don't know how many to allocate. It makes
> getting a reliable suspend the result of guess work and favourable
> circumstances. Fixing 'broken' drivers by really suspending them seems
> to me to be the right solution. Make their memory requirements perfectly
> predictable.

Except for the few drivers that are between suspend device and
root. So you still have the same problem, and still need to
guess. Plus you get complex changes to driver model.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
