Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932383AbVHWXzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932383AbVHWXzF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 19:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932495AbVHWXzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 19:55:05 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:42676 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932383AbVHWXzE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 19:55:04 -0400
Date: Wed, 24 Aug 2005 01:54:36 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: john stultz <johnstul@us.ibm.com>
cc: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Nishanth Aravamudan <nacc@us.ibm.com>, benh@kernel.crashing.org,
       Anton Blanchard <anton@samba.org>, frank@tuxrocks.com,
       George Anzinger <george@mvista.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC - 0/9] Generic timekeeping subsystem  (v. B5)
In-Reply-To: <1124838847.20617.11.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.61.0508240134050.3743@scrub.home>
References: <1123723279.30963.267.camel@cog.beaverton.ibm.com> 
 <1123726394.32531.33.camel@cog.beaverton.ibm.com>  <Pine.LNX.4.61.0508152115480.3728@scrub.home>
  <1124151001.8630.87.camel@cog.beaverton.ibm.com>  <Pine.LNX.4.61.0508162337130.3728@scrub.home>
  <1124241449.8630.137.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.61.0508182213100.3728@scrub.home>  <1124505151.22195.78.camel@cog.beaverton.ibm.com>
  <Pine.LNX.4.61.0508202204240.3728@scrub.home>  <1124737075.22195.114.camel@cog.beaverton.ibm.com>
  <Pine.LNX.4.61.0508230134210.3728@scrub.home>  <1124830262.20464.26.camel@cog.beaverton.ibm.com>
  <Pine.LNX.4.61.0508232321530.3728@scrub.home> <1124838847.20617.11.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 23 Aug 2005, john stultz wrote:

> I'm assuming gettimeofday()/clock_gettime() looks something like:
>    xtime + (get_cycles()-last_update)*(mult+ntp_adj)>>shift

Where did you get the ntp_adj from? It's not in my example.
gettimeofday() was in the previous mail: "xtime + (cycle_offset * mult +
error) >> shift". The difference between system time and reference 
time is really important. gettimeofday() returns the system time, NTP 
controls the reference time and these two are synchronized regularly.
I didn't see that anywhere in your example.

bye, Roman
