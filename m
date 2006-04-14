Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751177AbWDNCwm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbWDNCwm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 22:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbWDNCwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 22:52:42 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:4509 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751177AbWDNCwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 22:52:41 -0400
Date: Thu, 13 Apr 2006 21:53:16 -0400
From: Jeff Dike <jdike@addtoit.com>
To: john stultz <johnstul@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: [RFC] PATCH 0/4 - Time virtualization
Message-ID: <20060414015316.GA7723@ccure.user-mode-linux.org>
References: <200604131719.k3DHJcZG004674@ccure.user-mode-linux.org> <1144974688.8548.26.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1144974688.8548.26.camel@cog.beaverton.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2006 at 05:31:27PM -0700, john stultz wrote:
> Looks interesting. I've never quite understood the need for different
> time domains, it only allows you to run one domain with the incorrect
> time, but I'm sure there is some use case that is desired.

There are a few possible answers -

If when this virtualization stuff is done, no one has done anything with
time, someone is going to moan.

Once in a while, you want to fiddle your system clock to make sure that
a cron job or something does what it's supposed to.

There was some extra infrastructure that UML needed in order to start using
this stuff, so I chose a fairly simple virtualization case to accompany it.

> I'm not psyched about possible namespace vs nanosecond confusion w/
> terms like "time_ns", but that's pretty minor.

Yeah, names can be changed.

> Also I hope you're not wanting to deal w/ NTP adjustments between
> domains that have the incorrect time? That would be very ugly.

No, the domain stores an offset from the system time, so it automatically
gets the system's NTP adjustments.

				Jeff
