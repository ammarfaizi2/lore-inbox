Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268290AbUIGQQp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268290AbUIGQQp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 12:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268259AbUIGQOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 12:14:20 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:43970 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S268170AbUIGQNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 12:13:42 -0400
Date: Tue, 7 Sep 2004 09:10:27 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Andi Kleen <ak@suse.de>
cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       tim@physik3.uni-rostock.de, george anzinger <george@mvista.com>,
       albert@users.sourceforge.net, Ulrich.Windl@rz.uni-regensburg.de,
       Len Brown <len.brown@intel.com>, linux@dominikbrodowski.de,
       David Mosberger <davidm@hpl.hp.com>, paulus@samba.org,
       schwidefsky@de.ibm.com, jimix@us.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, greg kh <greg@kroah.com>,
       Patricia Gaughen <gone@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>
Subject: Re: [RFC] New Time of day proposal (updated 9/2/04)
In-Reply-To: <20040904130022.GB21912@wotan.suse.de>
Message-ID: <Pine.LNX.4.58.0409070908290.8484@schroedinger.engr.sgi.com>
References: <1094159238.14662.318.camel@cog.beaverton.ibm.com>
 <20040903151710.GB12956@wotan.suse.de> <1094242317.14662.556.camel@cog.beaverton.ibm.com>
 <20040904130022.GB21912@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Sep 2004, Andi Kleen wrote:

> On Fri, Sep 03, 2004 at 01:11:58PM -0700, john stultz wrote:
> > The timeofday_hook (should be timeofday_interrupt_hook, my bad) is
> > called by the semi-periodic-irregular-interval(also known as "timer")
> > interrupt. Its what does the housekeeping for all the timeofday code so
> > we don't run into a counter overflow.
> >
> > monotonic_clock() is an accessor that returns the amount of time that
> > has been accumulated since boot in nanoseconds.
>
> Ok, but you need different low level drivers for those.  The TSC is not
> stable enough as a long term time source, but it is best&fastest for
> the offset calculation between timer interrupts.

I thought the NTP daemon etc would even that out? ITC (TSC on IA64) is
used by default on IA64 for all time keeping purposes. The CPU has on chip
support for timer interrupt generation.
