Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751436AbWBRQAg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbWBRQAg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 11:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbWBRQAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 11:00:36 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:17580 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751439AbWBRQAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 11:00:33 -0500
Date: Sat, 18 Feb 2006 16:11:16 +0100
From: Pavel Machek <pavel@suse.cz>
To: Richard Mittendorfer <delist@gmx.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [swsusp] not enough memory
Message-ID: <20060218151115.GC5658@openzaurus.ucw.cz>
References: <20060218005814.6548092d.delist@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060218005814.6548092d.delist@gmx.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 18-02-06 00:58:14, Richard Mittendorfer wrote:
> Hi *,
> 
> On my 64MB notebook I get the following message, when going swsusp:
> 
> ..
> swsusp: Need to copy 15526 pages
> swsusp: Not enough free memory
> Error -12 suspending
> ..
> 
> # free
>              total     used     free   shared    buffers   cached
> Mem:         62760    59884     2876        0       3828    16052
> -/+ buffers/cache:    40004    22756
> Swap:       200804    30316   170488
> 
> If I end all apps but the XServer it works. I've allready added some
> more swapspace, but that didn't help. So, how much memory will I need
> for a successful suspend or better (since i can't stuff any more into 
> it) is there a way to minimize the amount needed?

128MB should be enough for you. Or try modifying try_to_free memory routine to
retry shrink_all_mem few more times, with schedule()  in between...
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

