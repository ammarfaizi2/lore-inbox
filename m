Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268237AbUHFTba@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268237AbUHFTba (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 15:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268245AbUHFT27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 15:28:59 -0400
Received: from gprs214-146.eurotel.cz ([160.218.214.146]:41600 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S268246AbUHFT1P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 15:27:15 -0400
Date: Fri, 6 Aug 2004 21:26:56 +0200
From: Pavel Machek <pavel@suse.cz>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [6/25] Merge pmdisk and swsusp
Message-ID: <20040806192656.GG3048@elf.ucw.cz>
References: <Pine.LNX.4.50.0407171528280.22290-100000@monsoon.he.net> <20040718220954.GB31958@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.50.0408012018370.30101-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0408012018370.30101-100000@monsoon.he.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Sorry about the delay; all the conferences are finally over (for
> now)

:-). Well, I'm back from canoes for now, so I'm at least able to read
the mail...

> > > +static void calc_order(void)
> > > +{
> > > +	int diff;
> > > +	int order;
> > > +
> > > +	order = get_bitmask_order(SUSPEND_PD_PAGES(nr_copy_pages));
> > > +	nr_copy_pages += 1 << order;
> > > +	do {
> > > +		diff = get_bitmask_order(SUSPEND_PD_PAGES(nr_copy_pages)) - order;
> > > +		if (diff) {
> > > +			order += diff;
> > > +			nr_copy_pages += 1 << diff;
> > > +		}
> > > +	} while(diff);
> > > +	pagedir_order = order;
> > > +}
> >
> > This code is "interesting". Perhaps at least comment would be good
> > here?
> 
> Sure, patch below.

Looks good.
									Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
