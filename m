Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932491AbWEHRV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932491AbWEHRV0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 13:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932490AbWEHRV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 13:21:26 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:28688 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S932491AbWEHRV0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 13:21:26 -0400
Date: Mon, 8 May 2006 17:21:12 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Matt Mackall <mpm@selenic.com>
Cc: "David S. Miller" <davem@davemloft.net>, tytso@mit.edu,
       mrmacman_g4@mac.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/14] random: Remove SA_SAMPLE_RANDOM from network drivers
Message-ID: <20060508172111.GA5266@ucw.cz>
References: <20060506.170810.74552888.davem@davemloft.net> <20060507045920.GH15445@waste.org> <20060508062604.GD5765@ucw.cz> <20060508.000754.06312852.davem@davemloft.net> <20060508140500.GZ15445@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060508140500.GZ15445@waste.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > What do other platforms without a TSC do?
> 
> Using get_cycles() for /dev/random is new as of 2.6. Before that, we
> were directly calling rdtsc on x86 alone. 10msec resolution is fine
> for plenty of sources.

For what devices are timestamps still 'random/unobservable' in 10msec
range?

Maybe keyboard... but no, keyboard has autorepeat and can be observed
remotely with 10msec accuracy in many cases. (telnet to bbs?)

Disk requests take less than 10msec.

It is trivial to measure packets with 10msec accuracy.

Mouse will generate many events within 10msec when user actually uses
it.

...so, what devices are still random with 10msec sampling?
-- 
Thanks for all the (sleeping) penguins.
