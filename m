Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161018AbWGNKGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161018AbWGNKGU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 06:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964813AbWGNKGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 06:06:20 -0400
Received: from mkedef1.rockwellautomation.com ([208.22.104.18]:43921 "EHLO
	ranasmtp01.ra.rockwell.com") by vger.kernel.org with ESMTP
	id S964812AbWGNKGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 06:06:19 -0400
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de
Subject: Re: [PATCH] 2.6.17-rt add clockevent to ixp4xx
MIME-Version: 1.0
X-Mailer: Lotus Notes Release 5.0.12   February 13, 2003
Message-ID: <OFB20BB02A.F062E106-ONC12571AB.00374FBF-C12571AB.00379295@ra.rockwell.com>
From: Milan Svoboda <msvoboda@ra.rockwell.com>
Date: Fri, 14 Jul 2006 12:06:44 +0200
X-MIMETrack: Serialize by Router on RANASMTP01/NorthAmerica/RA/Rockwell(Release 6.5.4FP1|June
 19, 2005) at 07/14/2006 05:07:07 AM,
	Serialize complete at 07/14/2006 05:07:07 AM
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > there are patches that enable clock event on ixp4xx platform. This 
should
> > enable high resolution timers... Option for hrtimers in menuconfig is 
> > also enabled.
> > 
> > I tested it on nanosleep test program (included in attachments) and 
obtained
> > this results:
> > 
> > requested: 899000 us, got: 899159 us, diff: -159 us
> > requested: 897000 us, got: 897209 us, diff: -209 us
> > requested: 895000 us, got: 899803 us, diff: -4803 us
> > requested: 893000 us, got: 899425 us, diff: -6425 us
> > requested: 891000 us, got: 899806 us, diff: -8806 us
> > requested: 889000 us, got: 890142 us, diff: -1142 us
> > requested: 887000 us, got: 889873 us, diff: -2873 us
> > requested: 885000 us, got: 888096 us, diff: -3096 us
> 
> I'd turn off some of the debugging options, and retest. For instance,
> the pi-list debugging option will cause arbitrary latency, which you
> seem to show in your results. Normally with PREEMPT_RT turned on you
> would expect the timers to trigger within a constant amount of time from
> when they are suppose to.
> 

Thanks, yes I've seen decrease of latency times with debugging turned off.

Milan

