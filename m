Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266073AbUHaBYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266073AbUHaBYn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 21:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266196AbUHaBYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 21:24:43 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:44977 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S266073AbUHaBYl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 21:24:41 -0400
Subject: Re: [PATCH] Re: boot time, process start time, and NOW time
From: john stultz <johnstul@us.ibm.com>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: george anzinger <george@mvista.com>, Andrew Morton <akpm@osdl.org>,
       Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>,
       albert@users.sourceforge.net, hirofumi@mail.parknet.co.jp,
       lkml <linux-kernel@vger.kernel.org>, voland@dmz.com.pl,
       nicolas.george@ens.fr, david+powerix@blue-labs.org
In-Reply-To: <Pine.LNX.4.53.0408310228050.5907@gockel.physik3.uni-rostock.de>
References: <87smcf5zx7.fsf@devron.myhome.or.jp>
	 <20040816124136.27646d14.akpm@osdl.org>
	 <Pine.LNX.4.53.0408172207520.24814@gockel.physik3.uni-rostock.de>
	 <412285A5.9080003@mvista.com>
	 <1092782243.2429.254.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.53.0408180051540.25366@gockel.physik3.uni-rostock.de>
	 <1092787863.2429.311.camel@cog.beaverton.ibm.com>
	 <1092781172.2301.1654.camel@cube>
	 <1092791363.2429.319.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.53.0408180927450.14935@gockel.physik3.uni-rostock.de>
	 <20040819191537.GA24060@elektroni.ee.tut.fi>
	 <20040826040436.360f05f7.akpm@osdl.org>
	 <Pine.LNX.4.53.0408261311040.21236@gockel.physik3.uni-rostock.de>
	 <Pine.LNX.4.53.0408310037280.5596@gockel.physik3.uni-rostock.de>
	 <1093909116.14662.105.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.53.0408310228050.5907@gockel.physik3.uni-rostock.de>
Content-Type: text/plain
Message-Id: <1093915424.14662.141.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 30 Aug 2004 18:23:44 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-30 at 17:45, Tim Schmielau wrote:
> On Mon, 30 Aug 2004, john stultz wrote:
> 
> > On Mon, 2004-08-30 at 16:00, Tim Schmielau wrote:
> > > George, please excuse my lack of understanding. What again where the
> > > precise reasons to have an ntp-corrected uptime?
> > 
> > If I remember correctly, folks were complaining that boot time was
> > drifting due to the same issue. 
> 
> Yes, I remember this was discussed at the same time. However, I don't see
> that boot time display actually is connected to uptime. Boot time is
> available in /proc/stat as seconds sice the beginning of the epoch. It's
> now derived from wall_to_monotonic, thus should be reasonable constant
> (and I'm not aware of recent reports that say otherwise).
> 
> If some program thinks it has to calculate boot time from 
> gettimeofday() - uptime, and it drifts, so what?
> It's got a better way to do that. 

Hmm. Maybe I'm confusing problems. I need to re-read my mail archive. In
the meantime, maybe George could remind us why exactly the patch was
needed.

thanks
-john

