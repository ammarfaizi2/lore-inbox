Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261451AbSLCOSG>; Tue, 3 Dec 2002 09:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261486AbSLCOSG>; Tue, 3 Dec 2002 09:18:06 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:16901 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S261451AbSLCOSF>; Tue, 3 Dec 2002 09:18:05 -0500
Date: Tue, 3 Dec 2002 09:24:09 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Robert Love <rml@tech9.net>
cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] deprecate use of bdflush()
In-Reply-To: <1038867991.1221.56.camel@phantasy>
Message-ID: <Pine.LNX.3.96.1021203091821.5578A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 Dec 2002, Robert Love wrote:

> On Mon, 2002-12-02 at 17:11, Andrew Morton wrote:
> 
> > Ho-hum.  I was going to do this months ago but general exhaustion
> > and sluggishness won out.
> > 
> > We should tell the user which process called sys_bdflush() to aid
> > their expunging efforts.
> 
> Good idea.
> 
> I could do without the rate limiting, though - the print is after the
> CAP_SYS_ADMIN check.  Root has plenty of other ways to print crap to the
> screen and it saves 32-bits from bss.  But, uh, not a big deal at all
> either way.

My take on this is that it's premature. This would be fine in the 2.6.0-rc
series, but the truth is that the majority of 2.5 users boot 2.5 for
testing but run 2.4 for normal use. They aren't going to get rid of
bdflush and this just craps up the logs. At least with the occurrence
limit it will only happen a few times. I would like to see it once only,
myself, as a reminder rather than a nag.

While it's possible to do version dependent things in init scripts, in
this case there is no need, the call hurts nothing. Some users may post to
the list asking what it means, and others may actually do it, and break
their production systems.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

