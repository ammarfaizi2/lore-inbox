Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261409AbULHXsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbULHXsq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 18:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbULHXsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 18:48:45 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:46274 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261409AbULHXsg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 18:48:36 -0500
Date: Wed, 8 Dec 2004 15:47:21 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: George Anzinger <george@mvista.com>
cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       tim@physik3.uni-rostock.de, albert@users.sourceforge.net,
       Ulrich.Windl@rz.uni-regensburg.de, Len Brown <len.brown@intel.com>,
       linux@dominikbrodowski.de, David Mosberger <davidm@hpl.hp.com>,
       Andi Kleen <ak@suse.de>, paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, greg kh <greg@kroah.com>,
       Patricia Gaughen <gone@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max <amax@us.ibm.com>, mahuja@us.ibm.com
Subject: Re: [RFC] New timeofday proposal (v.A1)
In-Reply-To: <41B77134.90804@mvista.com>
Message-ID: <Pine.LNX.4.58.0412081545080.4783@schroedinger.engr.sgi.com>
References: <1102470914.1281.27.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.58.0412081009540.27324@schroedinger.engr.sgi.com> 
 <1102533066.1281.81.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.58.0412081114590.27324@schroedinger.engr.sgi.com>
 <1102535891.1281.148.camel@cog.beaverton.ibm.com>
 <Pine.LNX.4.58.0412081207010.28001@schroedinger.engr.sgi.com>
 <41B77134.90804@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Dec 2004, George Anzinger wrote:

> Right.  We seem to be doing ok now by just adjusting things at tick time and
> using the "normal" interpolation between ticks.
>
> As for the math, the current code keeps a running "remainder" which is the
> amount of the correction that was finer than the clock resolution (i.e. less
> than a nano second) and rolls this in on the next tick.  This gives resolution
> out to several bits to the right of the nano second.  And I think this is all
> done with 32 bit math (if memory serves).

That is probably the i386 version with which I am not familiar. The time
interpolator logic (IA64 and SPARC64) does fine with a scaled 64 bit
factor without a remainder. The factor may be used to express fractions of
nanoseconds.

