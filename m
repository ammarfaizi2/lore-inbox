Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932592AbVLBA6M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932592AbVLBA6M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 19:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932593AbVLBA6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 19:58:12 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:8636 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932592AbVLBA6K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 19:58:10 -0500
Subject: Re: [patch 00/43] ktimer reworked
From: john stultz <johnstul@us.ibm.com>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Roman Zippel <zippel@linux-m68k.org>, Steven Rostedt <rostedt@goodmis.org>,
       george@mvista.com, mingo@elte.hu, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       ray-gmail@madrabbit.org, Russell King <rmk+lkml@arm.linux.org.uk>
In-Reply-To: <91D50CB6-A9B0-4501-AAD2-7D80948E7367@mac.com>
References: <1133395019.32542.443.camel@tglx.tec.linutronix.de>
	 <Pine.LNX.4.61.0512010118200.1609@scrub.home>
	 <23CA09D3-4C11-4A4B-A5C6-3C38FA9C203D@mac.com>
	 <Pine.LNX.4.61.0512011352590.1609@scrub.home>
	 <2c0942db0512010822x1ae20622obf224ce9728e83f8@mail.gmail.com>
	 <20051201165144.GC31551@flint.arm.linux.org.uk>
	 <Pine.LNX.4.61.0512011828150.1609@scrub.home>
	 <1133464097.7130.15.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0512012048140.1609@scrub.home>
	 <Pine.LNX.4.58.0512011619590.32095@gandalf.stny.rr.com>
	 <Pine.LNX.4.61.0512020120180.1609@scrub.home>
	 <91D50CB6-A9B0-4501-AAD2-7D80948E7367@mac.com>
Content-Type: text/plain
Date: Thu, 01 Dec 2005 16:58:06 -0800
Message-Id: <1133485086.7605.9.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-01 at 19:41 -0500, Kyle Moffett wrote:
> On Dec 01, 2005, at 19:29, Roman Zippel wrote:
> > Hi,
> >
> >> As for portablility, I believe John Stultz has some nice plugins  
> >> coming to what timer source you want to use, so if there's a  
> >> better way to get a time, these should make things easy to add.
> >
> > These plugins can do no magic, if the hardware timer is slow, the  
> > whole thing gets slow.
> 
> The point is that you could switch both the timer and timeout  
> implementations to jiffies if you wanted to, at the expense of the  
> accuracy that a lot of people care about.

While I'm not challenging the possibility of doing this, my timekeeping
work does not provide quite this level of flexibility you imply. Indeed
one could use jiffies as a clocksource, limiting all time users
(including ktimers) to jiffies resolution, but I would consider that to
be abusing the interface.

thanks
-john

