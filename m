Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751272AbWDNQYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbWDNQYq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 12:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWDNQYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 12:24:46 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:60581 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751268AbWDNQYp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 12:24:45 -0400
Subject: Re: [uml-devel] Re: [RFC] PATCH 0/4 - Time virtualization
From: john stultz <johnstul@us.ibm.com>
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
In-Reply-To: <20060414015316.GA7723@ccure.user-mode-linux.org>
References: <200604131719.k3DHJcZG004674@ccure.user-mode-linux.org>
	 <1144974688.8548.26.camel@cog.beaverton.ibm.com>
	 <20060414015316.GA7723@ccure.user-mode-linux.org>
Content-Type: text/plain
Date: Fri, 14 Apr 2006 09:24:20 -0700
Message-Id: <1145031860.10781.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-13 at 21:53 -0400, Jeff Dike wrote:
> On Thu, Apr 13, 2006 at 05:31:27PM -0700, john stultz wrote:
> > Looks interesting. I've never quite understood the need for different
> > time domains, it only allows you to run one domain with the incorrect
> > time, but I'm sure there is some use case that is desired.
> 
> There are a few possible answers -
> 
> If when this virtualization stuff is done, no one has done anything with
> time, someone is going to moan.

Apparently its like painting a wall then, no? 
"You missed those spots over there!"  :)


> Once in a while, you want to fiddle your system clock to make sure that
> a cron job or something does what it's supposed to.
> 
> There was some extra infrastructure that UML needed in order to start using
> this stuff, so I chose a fairly simple virtualization case to accompany it.
> 
> > I'm not psyched about possible namespace vs nanosecond confusion w/
> > terms like "time_ns", but that's pretty minor.
> 
> Yeah, names can be changed.

Well, as long as its pretty isolated its not such a big deal. Just
figured I'd bring it up as a consideration.

> > Also I hope you're not wanting to deal w/ NTP adjustments between
> > domains that have the incorrect time? That would be very ugly.
> 
> No, the domain stores an offset from the system time, so it automatically
> gets the system's NTP adjustments.

Ok, as long as you don't intend to go down that path, these patches
looks pretty harmless.

thanks
-john

