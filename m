Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269756AbUICTXw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269756AbUICTXw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 15:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269758AbUICTXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 15:23:51 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:44212 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269756AbUICTXU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 15:23:20 -0400
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v.A0)
From: john stultz <johnstul@us.ibm.com>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: george anzinger <george@mvista.com>, lkml <linux-kernel@vger.kernel.org>,
       tim@physik3.uni-rostock.de, Ulrich.Windl@rz.uni-regensburg.de,
       clameter@sgi.com, Len Brown <len.brown@intel.com>,
       linux@dominikbrodowski.de, David Mosberger <davidm@hpl.hp.com>,
       Andi Kleen <ak@suse.de>, paulus@samba.org, schwidefsky@de.ibm.com,
       jimix@us.ibm.com, keith maanthey <kmannth@us.ibm.com>,
       greg kh <greg@kroah.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>
In-Reply-To: <1094193731.434.7232.camel@cube>
References: <1094159238.14662.318.camel@cog.beaverton.ibm.com>
	 <1094159379.14662.322.camel@cog.beaverton.ibm.com>
	 <4137CB3E.4060205@mvista.com>  <1094193731.434.7232.camel@cube>
Content-Type: text/plain
Message-Id: <1094239113.14662.500.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 03 Sep 2004 12:18:34 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-02 at 23:42, Albert Cahalan wrote:
> > > +int ntp_leapsecond(struct timespec now)
> > > +{
> > > +	/*
> > > +	 * Leap second processing. If in leap-insert state at
> > > +	 * the end of the day, the system clock is set back one
> > > +	 * second; if in leap-delete state, the system clock is
> > > +	 * set ahead one second. The microtime() routine or
> > > +	 * external clock driver will insure that reported time
> > > +	 * is always monotonic. The ugly divides should be
> > > +	 * replaced.
> 
> Don't optimize until the patch is in and stable.
> The divides can be removed much later. Wait months,
> if not forever, before making the code less readable.
> 
> The same goes for arch-specific non-syscall hacks.

Yep. Code readability is crucial, although performance is also a concern
that *has* to be addressed. 

As much as I'm probably digging myself a hole in doing all of this, I
really don't want to work on time for the rest of my life, so making the
code clear and readable is my only hope for passing this on.  :)

-john


