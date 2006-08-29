Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965004AbWH2OoQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965004AbWH2OoQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 10:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965006AbWH2OoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 10:44:16 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:59861 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S965004AbWH2OoP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 10:44:15 -0400
Date: Tue, 29 Aug 2006 16:43:58 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: john stultz <johnstul@us.ibm.com>
cc: linux@horizon.com, linux-kernel@vger.kernel.org, theotso@us.ibm.com
Subject: Re: Linux time code
In-Reply-To: <1156804609.16398.17.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0608291635260.6761@scrub.home>
References: <20060824023525.31199.qmail@science.horizon.com> 
 <Pine.LNX.4.64.0608281250060.6761@scrub.home> <1156804609.16398.17.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 28 Aug 2006, john stultz wrote:

> While its possible to smooth out the leapsecond (which would be useful
> to many folks), the problem is one's system would then diverge from UTC
> for that leapsecond. 
> 
> The idea he's proposing here is to keep both UTC and UTS as separate
> clock ids, allowing apps to choose which standard (well, I UTS isn't
> quite a standard) they want to follow.

Making it a separate clock would be a bit more complex and I don't know if 
it's really worth it for an event that only happens every few years.
We already have everything we need to adjust CLOCK_REALTIME, so it would 
be not a real problem to support a timezone UTS.

> I think this would be quite useful, as I've seen a number of requests
> where users don't want the leapsecond inconsistency, and others where
> they need to strictly follow UTC.
> 
> I think having TAI would be nice too, but that requires quite a bit of
> infrastructure work (NTP distributing absolute leapsecond counts, etc).

That's the other possibility, as soon as we update the userspace interface 
to NTP4, it will also include the TAI value, so it will be available via 
adjtimex()/ntp_gettime().

bye, Roman
