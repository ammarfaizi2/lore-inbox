Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262490AbULOURH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262490AbULOURH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 15:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262491AbULOURG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 15:17:06 -0500
Received: from gprs215-213.eurotel.cz ([160.218.215.213]:63616 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262490AbULOUQj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 15:16:39 -0500
Date: Wed, 15 Dec 2004 21:16:18 +0100
From: Pavel Machek <pavel@suse.cz>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org, Andrea Arcangeli <andrea@suse.de>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Con Kolivas <kernel@kolivas.org>
Subject: Re: USB making time drift [was Re: dynamic-hz]
Message-ID: <20041215201618.GA5797@elf.ucw.cz>
References: <20041213002751.GP16322@dualathlon.random> <200412142159.23488.gene.heskett@verizon.net> <20041215091741.GA16322@dualathlon.random> <200412151144.38785.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412151144.38785.gene.heskett@verizon.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> Which way?  I was running quite fast here, several minutes an
> >
> >In the future, if I disable the logic it goes in the past at the
> > same speed it was previously going in the future.
> >
> >> hour, then I discovered the tickadj command, found its default
> >> was 10000, and started reducing it.  At 9926, I'm staying within
> >> a sec an hour now.  I have no idea when this started, I didn't
> >
> >That seems quite an hack, note I did an hack too and it make the
> > drift much smaller (it gets manageable). But our modifications are
> > wrong.
> >
> >The point is that this didn't happen with HZ=100, so it's not that
> >tickadj is wrong, it's the tick adjustment code that doesn't work.
> >
> The HZ=1000 is the culprit?
> 
> >You may want to recompile your kernel with HZ=100 and verify it goes
> >away (I didn't verify myself, but I verified the max irq latency I
> > get is 4msec, and in turn I'm sure HZ=100 would fix it
> 
> Humm, that might also reduce the obviousness of the irq activity in
> the audio, there are times when I can hear it very plainly while a
> low level audio src is in use, like the sub-millivolt levels that come
> out of my Hauppauge WinTV-GO+FM card.   I keep having to turn the

Try idle=poll. That noise may be commig from cpu switching between
powersave and full speed.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
