Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262132AbUK0F26@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262132AbUK0F26 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 00:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262133AbUK0Dyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 22:54:54 -0500
Received: from zeus.kernel.org ([204.152.189.113]:5572 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262517AbUKZTdb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:33:31 -0500
Date: Fri, 26 Nov 2004 01:20:03 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Suspend2 merge: 1/51: Device trees
Message-ID: <20041126002003.GO2711@elf.ucw.cz>
References: <20041125165413.GB476@openzaurus.ucw.cz> <20041125185304.GA1260@elf.ucw.cz> <1101421336.27250.80.camel@desktop.cunninghams> <20041125224124.GE2711@elf.ucw.cz> <1101423148.27250.110.camel@desktop.cunninghams> <20041125232612.GJ2711@elf.ucw.cz> <1101426734.27250.155.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101426734.27250.155.camel@desktop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > I'd agree, except that I don't know how many to allocate. It makes
> > > getting a reliable suspend the result of guess work and favourable
> > > circumstances. Fixing 'broken' drivers by really suspending them seems
> > > to me to be the right solution. Make their memory requirements perfectly
> > > predictable.
> > 
> > Except for the few drivers that are between suspend device and
> > root. So you still have the same problem, and still need to
> > guess. Plus you get complex changes to driver model.
> 
> I think you're overstating your case. All we're talking about doing is
> quiescing the same drivers that would be quiesced later, in the same
> way, but earlier in the process. Apart from the code I already have in
> that patch, nothing else is needed. The changes aren't that complex,
> either.

Driver model now needs to know how to handle tree where some parts are
suspended and some are not, and I think that's quite a big change.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
