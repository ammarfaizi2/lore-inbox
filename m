Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262071AbUIOIzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbUIOIzi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 04:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263540AbUIOIzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 04:55:38 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:59788 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S262071AbUIOIzh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 04:55:37 -0400
Date: Wed, 15 Sep 2004 10:54:50 +0200
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: George Anzinger <george@mvista.com>
Cc: Christoph Lameter <clameter@sgi.com>, john stultz <johnstul@us.ibm.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       Ulrich.Windl@rz.uni-regensburg.de, Len Brown <len.brown@intel.com>,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com, jimix@us.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, greg kh <greg@kroah.com>,
       Patricia Gaughen <gone@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v.A0)
Message-ID: <20040915085450.GA5242@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.de>,
	George Anzinger <george@mvista.com>,
	Christoph Lameter <clameter@sgi.com>,
	john stultz <johnstul@us.ibm.com>,
	Albert Cahalan <albert@users.sourceforge.net>,
	lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
	Ulrich.Windl@rz.uni-regensburg.de, Len Brown <len.brown@intel.com>,
	David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
	paulus@samba.org, schwidefsky@de.ibm.com, jimix@us.ibm.com,
	keith maanthey <kmannth@us.ibm.com>, greg kh <greg@kroah.com>,
	Patricia Gaughen <gone@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>
References: <1094700768.29408.124.camel@cog.beaverton.ibm.com> <413FDC9F.1030409@mvista.com> <1094756870.29408.157.camel@cog.beaverton.ibm.com> <4140C1ED.4040505@mvista.com> <Pine.LNX.4.58.0409131420500.490@schroedinger.engr.sgi.com> <1095114307.29408.285.camel@cog.beaverton.ibm.com> <Pine.LNX.4.58.0409141045370.6963@schroedinger.engr.sgi.com> <41479369.6020506@mvista.com> <Pine.LNX.4.58.0409142024270.10739@schroedinger.engr.sgi.com> <4147F774.6000800@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4147F774.6000800@mvista.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 01:04:04AM -0700, George Anzinger wrote:
> >One could do this but we want to have a tickless system. The tick is only
> >necessary if the time needs to be adjusted.
> 
> I really think a tickless system, for other than UML systems, is a loosing 
> thing.  The accounting overhead on context switch (which increases as the 
> number of switchs per second) will cause more overhead than a periodic 
> accounting tick once a respectable load appears.
			 ^^^^^^^^^^^^^^^^

On a largely idle system (like notebooks on battery power in typical use)
the accounting overhead will be less a problem. However, the CPU being 
woken up each millisecond will cause an increased battery usage. So if 
the load is less than a certain threshold, tickless systems do make much 
sense.

	Dominik
