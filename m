Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751059AbWJHVPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbWJHVPQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 17:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751074AbWJHVPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 17:15:16 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:56019 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1751059AbWJHVPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 17:15:14 -0400
Subject: Re: + clocksource-increase-initcall-priority.patch added to -mm
	tree
From: Daniel Walker <dwalker@mvista.com>
To: tglx@linutronix.de
Cc: akpm@osdl.org, johnstul@us.ibm.com, mingo@elte.hu, zippel@linux-m68k.org,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1160340722.5686.85.camel@localhost.localdomain>
References: <200610070153.k971ren4020838@shell0.pdx.osdl.net>
	 <1160294812.22911.8.camel@localhost.localdomain>
	 <1160302797.22911.37.camel@localhost.localdomain>
	 <1160319033.3693.19.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <1160319234.5686.12.camel@localhost.localdomain>
	 <1160322317.3693.47.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <1160323127.5686.37.camel@localhost.localdomain>
	 <1160324288.3693.71.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <1160326363.5686.48.camel@localhost.localdomain>
	 <1160327879.3693.97.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <1160334205.5686.72.camel@localhost.localdomain>
	 <1160339986.3693.135.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <1160340722.5686.85.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sun, 08 Oct 2006 14:15:12 -0700
Message-Id: <1160342112.3693.146.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-10-08 at 22:52 +0200, Thomas Gleixner wrote:

> See above, but I'm happy to copy it.
> > > The reason why this was delayed into late boot is simply that the
> > > unstable, unsynchronized TSC's made way too much trouble and the pmtimer
> > > can not be initialized early.
> 
> I don't have the bug reports handy, but they are in the LKML archives.

Like I said I need more detail. I'm assuming John will know what your
talking about, or do you have a rough time frame?

> > > This early boot instrumentation code can work with low resolution time
> > > information quite well and none of the boot code does need any high res
> > > time information. Boot code is different from a running system and has
> > > different requirements. 
> > > 
> > > This is a solution for a nonexisting problem, which just brings back
> > > already solved ones.
> > 
> > There is at least one existing problem which it does solve. 
> 
> Which one exactly? I'm not aware of a problem with the existing code at
> all.

Clock shuffling.

> > How about we
> > discuss the early TSC boot breakage, which you mention above, so I can
> > properly fix this situation.
> 
> See above. Also it interferes probably with the highres/dyntick code, as
> we might switch over way too early. Have not looked into that yet.

I would be surprised if it caused problems. The clock switching is done
at the same time as always. I tried not to alter generic time
functionality in any way.

Daniel

