Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261487AbULIHtL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261487AbULIHtL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 02:49:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261489AbULIHtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 02:49:11 -0500
Received: from rrzmta2.rz.uni-regensburg.de ([132.199.1.17]:6372 "EHLO
	rrzmta2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S261487AbULIHtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 02:49:04 -0500
From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: john stultz <johnstul@us.ibm.com>
Date: Thu, 09 Dec 2004 08:47:20 +0100
MIME-Version: 1.0
Subject: Re: [RFC] New timeofday proposal (v.A1)
Cc: lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       george anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich.Windl@rz.uni-regensburg.de, Len Brown <len.brown@intel.com>,
       linux@dominikbrodowski.de, David Mosberger <davidm@hpl.hp.com>,
       Andi Kleen <ak@suse.de>, paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, greg kh <greg@kroah.com>,
       Patricia Gaughen <gone@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max <amax@us.ibm.com>, mahuja@us.ibm.com
Message-ID: <41B81119.19559.EE57A05@rkdvmks1.ngate.uni-regensburg.de>
In-reply-to: <1102535891.1281.148.camel@cog.beaverton.ibm.com>
References: <Pine.LNX.4.58.0412081114590.27324@schroedinger.engr.sgi.com>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.25/Sophos-P=3.88.0+V=3.88+U=2.07.079+R=06 December 2004+T=97715@20041209.074751Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 Dec 2004 at 11:58, john stultz wrote:

[...]
> behavior of adjtimex().  We need to be able to implement the following
> adjustments within a single tick:
> 
> 1. Adjust the frequency by 500ppm for 10usecs 

What do you mean by "for 10usecs"?

> 2. After that adjust the frequency by 30ppm for the rest of the tick.

I'm not sure what you are taling about: plain old adjtime() or the NTP kernel 
interface?

[...]
> I may have asked this before, but w/ 32 bit mult and shifts, how
> granular can these adjustments be?

Independent of any bits, the precision should be up to 1ns for reading and setting 
the clock, and as a consequence you might provide internal fractional nanoseconds 
(if you want to have a truly stable nanosecond clock model). If we get this right, 
there will be peace in this area until the wires in a PC are significantly shorter 
than 30cm (I think this is how far the light goes in 1ns). ;-)

> 
> Also additional complications arise when we have multiple things (like
> cpufreq) playing with the timesource frequency values as well. 

I see a bug difference between precise time keeping and "playing" with 
timesources.

Regards,
Ulrich

