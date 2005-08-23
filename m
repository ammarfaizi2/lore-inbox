Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932396AbVHWVeS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbVHWVeS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 17:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932397AbVHWVeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 17:34:18 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:54707 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932396AbVHWVeR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 17:34:17 -0400
Date: Tue, 23 Aug 2005 23:34:05 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: john stultz <johnstul@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>, George Anzinger <george@mvista.com>,
       frank@tuxrocks.com, Anton Blanchard <anton@samba.org>,
       benh@kernel.crashing.org, Nishanth Aravamudan <nacc@us.ibm.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
Subject: Re: [RFC - 0/9] Generic timekeeping subsystem  (v. B5)
In-Reply-To: <1124830262.20464.26.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.61.0508232321530.3728@scrub.home>
References: <1123723279.30963.267.camel@cog.beaverton.ibm.com> 
 <1123726394.32531.33.camel@cog.beaverton.ibm.com>  <Pine.LNX.4.61.0508152115480.3728@scrub.home>
  <1124151001.8630.87.camel@cog.beaverton.ibm.com>  <Pine.LNX.4.61.0508162337130.3728@scrub.home>
  <1124241449.8630.137.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.61.0508182213100.3728@scrub.home>  <1124505151.22195.78.camel@cog.beaverton.ibm.com>
  <Pine.LNX.4.61.0508202204240.3728@scrub.home>  <1124737075.22195.114.camel@cog.beaverton.ibm.com>
  <Pine.LNX.4.61.0508230134210.3728@scrub.home> <1124830262.20464.26.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 23 Aug 2005, john stultz wrote:

> In the case above, you're accumulating in fixed cycle intervals. This
> does avoid having to do the mult/shift combo each interrupt, however
> since you do not accumulate the entire interval, and there is some
> sub-tick remainder in cycle_offset. We have to ensure that that sub-tick
> remainder is accumulated at the next interrupt using the same ntp
> adjustment it would use in a call to gettimeofday() just prior to this
> interrupt.

Look closer and you'll notice that the cycle_offset remainder isn't lost. :)

bye, Roman
