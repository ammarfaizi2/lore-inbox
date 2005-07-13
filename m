Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261241AbVGMQuH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbVGMQuH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 12:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261223AbVGMQsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 12:48:15 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:59310 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261250AbVGMQrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 12:47:15 -0400
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
From: Lee Revell <rlrevell@joe-job.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: George Anzinger <george@mvista.com>, "Theodore Ts'o" <tytso@mit.edu>,
       Andrew Morton <akpm@osdl.org>, arjan@infradead.org,
       azarah@nosferatu.za.org, cw@f00f.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org, christoph@lameter.org
In-Reply-To: <42D53A71.8030901@tmr.com>
References: <200506231828.j5NISlCe020350@hera.kernel.org>
	 <20050708214908.GA31225@taniwha.stupidest.org>
	 <20050708145953.0b2d8030.akpm@osdl.org>
	 <1120928891.17184.10.camel@lycan.lan> <1120932991.6488.64.camel@mindpipe>
	 <1120933916.3176.57.camel@laptopd505.fenrus.org>
	 <1120934163.6488.72.camel@mindpipe> <20050709121212.7539a048.akpm@osdl.org>
	 <1120936561.6488.84.camel@mindpipe>
	 <1121088186.7407.61.camel@localhost.localdomain>
	 <20050711140510.GB14529@thunk.org>  <42D53A71.8030901@tmr.com>
Content-Type: text/plain
Date: Wed, 13 Jul 2005 12:47:12 -0400
Message-Id: <1121273233.4435.32.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-07-13 at 11:59 -0400, Bill Davidsen wrote:
> Theodore Ts'o wrote:
> > The real answer here is for the tickless patches to cleaned up to the
> > point where they can be merged, and then we won't waste battery power
> > entering the timer interrupt in the first place.  :-)
> 
> And that does seem to be the long term solution. Most (not all) modern 
> hardware has a readable timer as accurate as the tick, so doing a timer 
> to clock conversion as needed would be possible.
> 
> Unfortunately the interest in tickless operation seems to be mostly in 
> the power saving possibilities of laptops. If you could make it part of 
> some really sexy high interest area, like real time premption, it might 
> get done sooner ;-)
> 

Actually, there is quite a bit of interest already in the same circles
that are using RT preempt.  "How do I get a timer with better than 1ms
resolution" is an FAQ on linux-audio-dev, and once you have dynamic tick
the next logical step is high res timers.

Currently we refer these users to George's site.  I suspect the only
reason there has not been more interest is that not many users are up to
integrating the HRT and the RT preempt patch.

Lee

