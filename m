Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264259AbTKTEBo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 23:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264258AbTKTEBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 23:01:43 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:34512 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264259AbTKTEBl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 23:01:41 -0500
Subject: Re: Losing too many ticks! TSC cannot be used as time sourc
From: john stultz <johnstul@us.ibm.com>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3A9BE1FAD@vcnet.vc.cvut.cz>
References: <3A9BE1FAD@vcnet.vc.cvut.cz>
Content-Type: text/plain
Organization: 
Message-Id: <1069300604.23568.137.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 19 Nov 2003 19:56:45 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-11-19 at 14:10, Petr Vandrovec wrote:
> On 19 Nov 03 at 14:37, john stultz wrote:
> > On Wed, 2003-11-19 at 03:21, Petr Vandrovec wrote:
> > > Hi,
> > >   today morning my kernel (2.6.0-test9-something) said that
> > > TSC became unusable. There are no other messages around this
> > > time in the log. It could be thermal throttling, but it should
> > > print some message when X86_MCE_P4THERMAL is enabled, yes?
> > > It happened after 17hrs 56min of uptime. System never produced
> > > this message before. 
> > 
> > Hmmm. Interesting. You haven't seen it before and you've been running
> > 2.6.0-testX for awhile?
> 
> I do not know when this monitoring entered kernel, but system is running
> 2.6.0-testX kernels since July 22, when it booted 2.6.0-test1-c1534...

Alrighty. If it happens again let me know. The fallback code may need to
be tweaked if folks start tripping this too easily. 


> > Well, the TSC didn't stop working, we just stopped using it as a time
> > source. Things should work fine using just the PIT, although I'd be
> > interested to hear if ntpd finally settled down after the change. If it
> > cannot stay synced it may be an issue w/ your system's PIT. 
> 
> It did not produce any message since 9:54 (>14 hrs ago). Only difference
> is that in the past /var/lib/ntp/ntp.drift listed value 4.496 to 4.967
> (looking at all values I have logged in /var/log/syslog), but now
> it says 45.662. But what I can expect from PIT...

Ok, that all looks fine. I just wanted to be sure your PIT wasn't
continually acting up.

thanks
-john

