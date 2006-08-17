Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030330AbWHQWuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030330AbWHQWuQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 18:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030329AbWHQWuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 18:50:14 -0400
Received: from outbound-mail-38.bluehost.com ([70.98.111.192]:59298 "HELO
	outbound-mail-38.bluehost.com") by vger.kernel.org with SMTP
	id S1030307AbWHQWuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 18:50:12 -0400
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: john stultz <johnstul@us.ibm.com>
Subject: Re: Linux time code
Date: Thu, 17 Aug 2006 15:50:28 -0700
User-Agent: KMail/1.9.4
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       linux-kernel@vger.kernel.org, Udo van den Heuvel <udovdh@xs4all.nl>
References: <44E32B23.16949.BBB1EC4@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de> <200608171512.00417.jbarnes@virtuousgeek.org> <1155853964.31755.131.camel@cog.beaverton.ibm.com>
In-Reply-To: <1155853964.31755.131.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608171550.31097.jbarnes@virtuousgeek.org>
X-Identified-User: {642:box128.bluehost.com:virtuous:virtuousgeek.org} {sentby:smtp auth 71.198.43.183 authed with jbarnes@virtuousgeek.org}
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, August 17, 2006 3:32 pm, john stultz wrote:
> On Thu, 2006-08-17 at 15:11 -0700, Jesse Barnes wrote:
> > On Thursday, August 17, 2006 2:58 pm, john stultz wrote:
> > > On Thu, 2006-08-17 at 13:43 +0200, Roman Zippel wrote:
> > > > What is missing is the abiltity to map a clock to a posix clock,
> > > > so that you would have CLOCK_REALTIME/CLOCK_MONOTONIC as NTP
> > > > controlled clocks and other CLOCK_* as the raw clock.
> > >
> > > Is there a use case for this (wanting non-NTP corrected time on a
> > > system running NTPd) you have in mind?
> >
> > Isn't this what CLOCK_MONOTONIC[_HR] is for?  It's not supposed to
> > jump around at all, so the basic usage model is to use this source
> > for timestamping purposes...
>
> Well, CLOCK_MONOTONIC is not affected by calls to settimeofday() so it
> will never go backward, however it does get frequency correction if
> provided by NTP (thus a second will be a correct second and you won't
> accumulate error).

Hm, I guess that's ok for most of the timestamp applications I'm aware of 
as long as NTP won't cause the clock to stand still...

FWIW I think many other Unices provide a raw cycle counter via the POSIX 
clock routines.  I don't imagine they're NTP corrected, since at least 
on IRIX the application is expected to handle even cycle counter 
wraparound.

Jesse
