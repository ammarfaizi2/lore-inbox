Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261425AbULIBZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261425AbULIBZV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 20:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261427AbULIBZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 20:25:21 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:42898 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261425AbULIBZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 20:25:16 -0500
Date: Wed, 8 Dec 2004 17:24:08 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: john stultz <johnstul@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       george anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich.Windl@rz.uni-regensburg.de, Len Brown <len.brown@intel.com>,
       linux@dominikbrodowski.de, David Mosberger <davidm@hpl.hp.com>,
       Andi Kleen <ak@suse.de>, paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, greg kh <greg@kroah.com>,
       Patricia Gaughen <gone@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max <amax@us.ibm.com>, mahuja@us.ibm.com
Subject: Re: [RFC] New timeofday proposal (v.A1)
In-Reply-To: <1102553491.1281.297.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.58.0412081722010.5364@schroedinger.engr.sgi.com>
References: <1102470914.1281.27.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.58.0412081009540.27324@schroedinger.engr.sgi.com> 
 <1102533066.1281.81.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.58.0412081114590.27324@schroedinger.engr.sgi.com> 
 <1102535891.1281.148.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.58.0412081207010.28001@schroedinger.engr.sgi.com> 
 <1102549009.1281.267.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.58.0412081548010.4783@schroedinger.engr.sgi.com> 
 <1102551441.1281.286.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.58.0412081640020.5165@schroedinger.engr.sgi.com>
 <1102553491.1281.297.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Dec 2004, john stultz wrote:

> Well, ok, you're right. I got my wires twisted and misspoke. Today we
> really don't, since NTP adjustments only occur on tick boundaries. So
> yes, singleshot adjustments are in multiples of ticks right now. But we
> do assume ticks arrive at regular periods. If they don't, well, then we
> apply it for only one ticks worth, but we've lost a tick so we're wrong
> anyway.
>
> The code above, however, can handle non-regular interrupt intervals,
> which is something I think we should assume will occur.

Then we might also assume that we are beyond the technology of the
eighties and that there is some way that hardware can give
us an interrupt at a certain point in the future that will allow us to
change the scaling factor? I think its safe to not do this two scale
stuff. Too complex for the hot code path anyways.

