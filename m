Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262170AbVCOAo5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262170AbVCOAo5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 19:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262149AbVCOAoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 19:44:09 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:31626 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262160AbVCOAnV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 19:43:21 -0500
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v. A3)
From: john stultz <johnstul@us.ibm.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: Matt Mackall <mpm@selenic.com>, lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>, Max Asbock <masbock@us.ibm.com>,
       mahuja@us.ibm.com, Nishanth Aravamudan <nacc@us.ibm.com>,
       Darren Hart <darren@dvhart.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com
In-Reply-To: <Pine.LNX.4.58.0503141627010.15138@schroedinger.engr.sgi.com>
References: <1110590655.30498.327.camel@cog.beaverton.ibm.com>
	 <20050313004902.GD3163@waste.org>
	 <1110825765.30498.370.camel@cog.beaverton.ibm.com>
	 <20050314192918.GC32638@waste.org>
	 <1110829401.30498.383.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.58.0503141627010.15138@schroedinger.engr.sgi.com>
Content-Type: text/plain
Date: Mon, 14 Mar 2005 16:43:14 -0800
Message-Id: <1110847394.30498.423.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-03-14 at 16:28 -0800, Christoph Lameter wrote:
> On Mon, 14 Mar 2005, john stultz wrote:
> 
> > Huh. So if I understand you properly, all timesources should have valid
> > read_fnct pointers that return the cycle value, however we'll still
> > preserve the type and mmio_ptr so fsyscall/vsyscall bits can use them
> > externally?
> >
> > Hmm. I'm a little cautious, as I really want to make the vsyscall
> > gettimeofday and regular do_gettimeofday be a similar as possible to
> > avoid some of the bugs we've seen between different gettimeofday
> > implementations. However I'm not completely against the idea.
> >
> > Christoph: Do you have any thoughts on this?
> 
> Sorry to be late to the party. It would be a weird implementation to have
> two ways to obtain time for each timesource. Also would be even more a
> headache to maintain than the existing fastcall vs. fullcall.

That's my feeling as well, unless a more convincing argument comes up.

thanks
-john

