Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262244AbTH3XHM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 19:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262245AbTH3XHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 19:07:12 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:38588 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S262244AbTH3XHJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 19:07:09 -0400
Date: Sat, 30 Aug 2003 16:07:01 -0700
From: Larry McVoy <lm@bitmover.com>
To: Pascal Schmidt <der.eremit@email.de>
Cc: J?rn Engel <joern@wohnheim.fh-wedel.de>, linux-kernel@vger.kernel.org
Subject: Re: bandwidth for bkbits.net (good news)
Message-ID: <20030830230701.GA25845@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Pascal Schmidt <der.eremit@email.de>,
	J?rn Engel <joern@wohnheim.fh-wedel.de>,
	linux-kernel@vger.kernel.org
References: <q2SH.AA.3@gated-at.bofh.it> <qfwI.15D.27@gated-at.bofh.it> <qgCn.2y4.11@gated-at.bofh.it> <E19tEfx-0002vL-00@neptune.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E19tEfx-0002vL-00@neptune.local>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 31, 2003 at 12:58:33AM +0200, Pascal Schmidt wrote:
> On Sat, 30 Aug 2003 18:20:11 +0200, you wrote in linux.kernel:
> 
> > In order to control incoming traffic, it is easiest to look at tcp.
> > udp can work similarly, but it doesn't have to.  To throttle the
> > stream of tcp packets, you could simply throw away the acks and the
> > sending side will reduce it's speed.  So you have to measure one
> > stream and control a related but different one.  Maybe this is
> > possible, not sure.
> 
> All you have to do is drop the incoming packets if they exceed
> a certain bandwidth. 

If you think we haven't done that, think again.  We're at the wrong end
of the pipe to do that, I'm pretty sure that what you are describing 
simply won't work.  We've already tried rate limiting all traffic except
for the phone traffic to 1/2 the T1 line and it doesn't work.

Remember, we're talking vioce here.  Retransmits don't work and aren't
even attempted.  I've got people in 5 or 6 states spread out from one 
end of the USA to the other.  So any disruption means things don't work.

All of the traffic shaping tends to be focussed on "good" versus "bad"
bandwidth utilization.  That's nice but it means that you are tolerant
of a "settling time" during which everyone is fighting for bandwidth.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
