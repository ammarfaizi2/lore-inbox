Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751444AbWBRQCB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444AbWBRQCB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 11:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbWBRQAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 11:00:40 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:17324 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751441AbWBRQAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 11:00:33 -0500
Date: Sat, 18 Feb 2006 16:08:29 +0100
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Richard Mittendorfer <delist@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [swsusp] not enough memory
Message-ID: <20060218150828.GB5658@openzaurus.ucw.cz>
References: <20060218005814.6548092d.delist@gmx.net> <200602181008.02801.ncunningham@cyclades.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602181008.02801.ncunningham@cyclades.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > On my 64MB notebook I get the following message, when going swsusp:
> >
> > ..
> > swsusp: Need to copy 15526 pages
> > swsusp: Not enough free memory
> > Error -12 suspending
> > ..
> >
> > # free
> >              total     used     free   shared    buffers   cached
> > Mem:         62760    59884     2876        0       3828    16052
> > -/+ buffers/cache:    40004    22756
> > Swap:       200804    30316   170488
> >
> > If I end all apps but the XServer it works. I've allready added some
> > more swapspace, but that didn't help. So, how much memory will I need
> > for a successful suspend or better (since i can't stuff any more into
> > it) is there a way to minimize the amount needed?
> 
> swsusp needs to be able to free half your memory to be able to suspend. I 
> don't know it intimately, but you may well be failing to do this. Being 
> completely biased (and not unwilling to admit it!), I'd suggest you try 
> Suspend2 (www.suspend2.net). It doesn't have such a limitation.

Actually suspend2 has exactly the same limitation. If more than
half memory is occupied by something else than disk caches,
you loose in swsusp and suspend2.


-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

