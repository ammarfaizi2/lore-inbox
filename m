Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262188AbVAZDUo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262188AbVAZDUo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 22:20:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbVAZDUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 22:20:43 -0500
Received: from gate.crashing.org ([63.228.1.57]:58571 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262188AbVAZDUh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 22:20:37 -0500
Subject: Re: [RFC][PATCH] new timeofday arch specific hooks (v. A2)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Christoph Lameter <clameter@sgi.com>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       Paul Mackerras <paulus@samba.org>, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>, Max Asbock <amax@us.ibm.com>,
       mahuja@us.ibm.com, Nishanth Aravamudan <nacc@us.ibm.com>,
       Darren Hart <darren@dvhart.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>
In-Reply-To: <1106698655.1589.8.camel@cog.beaverton.ibm.com>
References: <1106607089.30884.10.camel@cog.beaverton.ibm.com>
	 <1106607153.30884.12.camel@cog.beaverton.ibm.com>
	 <1106620134.15850.3.camel@gaston>
	 <1106694561.30884.52.camel@cog.beaverton.ibm.com>
	 <1106697227.5235.28.camel@gaston>
	 <1106698655.1589.8.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Wed, 26 Jan 2005 14:14:52 +1100
Message-Id: <1106709293.6249.37.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-25 at 16:17 -0800, john stultz wrote:

> Hmm. In my code, I move the interval delta (similar to your pre-scale
> offset) to system_time (seems to be equivalent to the post-scale) at
> each call to timeofday_interrupt_hook(). So while 64 bits are normally
> used, you could probably get away doing the interval delta calculations
> in 32bits if your timesource frequency isn't too large. This would only
> be done in the arch-specific 32bit vsyscall code, right?

Yes. Looks ok so far, but I need to make sure by looking at the code.
I'll let you know.

> > > I still want to support vsyscall gettimeofday, although it does have to
> > > be done on an arch-by-arch basis. It's likely the systemcfg data
> > > structure can still be generated and exported. I'll look into it and see
> > > what can be done.
> > 
> > Well, since it only contains the prescale and postscale offsets and the
> > scaling value, it only needs to be updated when they change, so a hook
> > here would be fine.
> 
> Great, thats what I was hoping.
> 
> thanks
> -john
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

