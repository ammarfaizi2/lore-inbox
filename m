Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265075AbUFGVYe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265075AbUFGVYe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 17:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265080AbUFGVYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 17:24:23 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:42456 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S265075AbUFGVWn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 17:22:43 -0400
Date: Mon, 7 Jun 2004 23:23:48 +0200
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, george anzinger <george@mvista.com>,
       greg kh <greg@kroah.com>, Chris McDermott <lcm@us.ibm.com>
Subject: Re: Too much error in __const_udelay() ?
Message-ID: <20040607212348.GD23106@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.de>,
	john stultz <johnstul@us.ibm.com>,
	lkml <linux-kernel@vger.kernel.org>,
	george anzinger <george@mvista.com>, greg kh <greg@kroah.com>,
	Chris McDermott <lcm@us.ibm.com>
References: <1086419565.2234.133.camel@cog.beaverton.ibm.com> <20040605152326.GA11239@dominikbrodowski.de> <1086635568.2234.171.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1086635568.2234.171.camel@cog.beaverton.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2004 at 12:12:48PM -0700, john stultz wrote:
> I agree w/ Pavel that rounding up sounds better, but I can't get the
> math to work, so this may be the best solution. 

It's some strange sort of rounding, see my patch "3"...

> I'm also spinning up a patch w/ these changes to test, let me know how
> your testing went and I'll do the same.

Testing went fine -- even for the PMTMR-based delay case [*].

	Dominik

[*] though I noticed the cpufreq notifier breaks then: it updates
loops_per_jiffy without evaluating if it's indeed TSC- or even
frequency-based. It'll fail on cyclone, too, I think...
