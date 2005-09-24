Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932196AbVIXQvw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbVIXQvw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 12:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbVIXQvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 12:51:52 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:44530 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S932196AbVIXQvv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 12:51:51 -0400
Subject: Re: [ANNOUNCE] ktimers subsystem
From: Daniel Walker <dwalker@mvista.com>
To: tglx@linutronix.de
Cc: Roman Zippel <zippel@linux-m68k.org>, Ingo Molnar <mingo@elte.hu>,
       Christopher Friesen <cfriesen@nortel.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, george@mvista.com, johnstul@us.ibm.com,
       paulmck@us.ibm.com
In-Reply-To: <1127570212.15115.77.camel@tglx.tec.linutronix.de>
References: <20050919184834.1.patchmail@tglx.tec.linutronix.de>
	 <Pine.LNX.4.61.0509201247190.3743@scrub.home>
	 <1127342485.24044.600.camel@tglx.tec.linutronix.de>
	 <Pine.LNX.4.61.0509221816030.3728@scrub.home> <43333EBA.5030506@nortel.com>
	 <Pine.LNX.4.61.0509230151080.3743@scrub.home>
	 <1127458197.24044.726.camel@tglx.tec.linutronix.de>
	 <Pine.LNX.4.61.0509240443440.3728@scrub.home>
	 <20050924051643.GB29052@elte.hu>
	 <Pine.LNX.4.61.0509241212170.3728@scrub.home>
	 <1127570212.15115.77.camel@tglx.tec.linutronix.de>
Content-Type: text/plain
Date: Sat, 24 Sep 2005 09:51:21 -0700
Message-Id: <1127580681.18231.42.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-09-24 at 15:56 +0200, Thomas Gleixner wrote:
> On Sat, 2005-09-24 at 12:35 +0200, Roman Zippel wrote:
> > Hi,
> > 
> > On Sat, 24 Sep 2005, Ingo Molnar wrote:
> > 
> > > > Anyway, the biggest cost is the conversion from/to the 64bit ns value 
> > > > [...]
> > > 
> > > Where do you get that notion from? Have you personally measured the 
> > > performance and code size impact of it? If yes, would you mind to share 
> > > the resulting data with us?
> > > 
> > > Our data is that the use of 64-bit nsec_t significantly reduces the size 
> > > of a representative piece of code (object size in bytes):
> > > 
> > >                 AMD64    I386        ARM          PPC32       M68K
> > >    nsec_t_ops   226      284         252          428         206
> > >    timespec_ops 412      324         448          640         342
> > > 
> > > i.e. a ~40% size reduction when going to nsec_t on m68k, in that 
> > > particular function. Even larger, ~45% code size reduction on a true 
> > > 64-bit platform.
> > 
> > Without any source these numbers are not verifiable. You don't even 
> > mention here what that "representative piece of code" is...

These numbers are misleading .. Doing a total code comparison shows that
a 2.6.14-rc2+ktimers kernel is slightly bigger than a vanilla 2.6.14-rc2
kernel (gcc 4.0, defconfig) .. So your argument that "small is faster"
must mean ktimers is slower, or at least not faster ..  

Making a speed argument based on code size doesn't make much sense to
me, if it's actually faster then show that it's faster. 

Daniel


