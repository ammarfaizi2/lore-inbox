Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261397AbVA2Sfa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261397AbVA2Sfa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 13:35:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261399AbVA2Sfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 13:35:30 -0500
Received: from gprs213-58.eurotel.cz ([160.218.213.58]:384 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261397AbVA2Sf0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 13:35:26 -0500
Date: Sat, 29 Jan 2005 19:35:11 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: critical bugs in md raid5 and ATA disk failure/recovery modes
Message-ID: <20050129183511.GA2055@elf.ucw.cz>
References: <20050127035906.GA7025@schmorp.de> <m1vf9j4fsp.fsf@muc.de> <20050127063131.GA29574@schmorp.de> <20050127095102.GA88779@muc.de> <20050127163323.GA7474@schmorp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050127163323.GA7474@schmorp.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > The nasty part there is that it can affect completely unrelated
> > data too (on a traditional disk you normally only lose the data
> > that is currently being written) because of of the relationship
> > between stripes on different disks.

Well, you could set stripe size to 512B; that way, RAID-5 would be
*very* slow, but it should have same characteristics as normal disc
w.r.t. crash. Unrelated data would not be lost, and you'd either get
old data or new data...

Nasty part might be that if it went to degraded mode (before resync is
done), data on disk might silently change; that's bad I guess.

Performance would not be good, also.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
