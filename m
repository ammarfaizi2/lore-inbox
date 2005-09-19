Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbVISW6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbVISW6X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 18:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750715AbVISW6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 18:58:22 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:1238
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1750716AbVISW6W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 18:58:22 -0400
Subject: Re: [ANNOUNCE] ktimers subsystem
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: john stultz <johnstul@us.ibm.com>
Cc: Christoph Lameter <clameter@engr.sgi.com>, linux-kernel@vger.kernel.org,
       mingo@elte.hu, akpm@osdl.org, george@mvista.com, paulmck@us.ibm.com
In-Reply-To: <1127170253.3455.236.camel@cog.beaverton.ibm.com>
References: <20050919184834.1.patchmail@tglx.tec.linutronix.de>
	 <Pine.LNX.4.62.0509191500040.27238@schroedinger.engr.sgi.com>
	 <1127168232.24044.265.camel@tglx.tec.linutronix.de>
	 <Pine.LNX.4.62.0509191521400.27238@schroedinger.engr.sgi.com>
	 <1127169849.24044.279.camel@tglx.tec.linutronix.de>
	 <1127170253.3455.236.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Organization: linutronix
Date: Tue, 20 Sep 2005 00:58:29 +0200
Message-Id: <1127170710.24044.294.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-09-19 at 15:50 -0700, john stultz wrote:
> > 2. All gettimeofday implementations I have looked at do a lot of math
> > anyway, so its definitely more interesting to look at those oddities
> > rather than discussing a single add. John Stulz timeofday rework have a
> > clean solution for this - please do not argue about the div64 in his
> > original patches which he is reworking at the moment.
> 
> The simplest solution is to keep wall-time maintained in a timespec as
> well as the nsec_t based system_time/wall_time_offset combo. This avoids
> the extra add in the hotpath, and only costs an extra add at interrupt
> time.

<NITPICKING>
The crucial question is what's the hot path ? Depending on the
application type I want to avoid the add in the interrupt code. :)
</NITPICKING>


> Many arches have userspace gtod implementations (x86-64, ppc64, and ia64
> as well). Although my timeofday code allows for this as well (I had it
> working for x86-64 awhile back). 

Was not aware of that. Thanks for clarification.

tglx


