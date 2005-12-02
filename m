Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932594AbVLBBC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932594AbVLBBC2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 20:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932596AbVLBBC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 20:02:28 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:13533 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932594AbVLBBC1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 20:02:27 -0500
Date: Fri, 2 Dec 2005 02:01:38 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Kyle Moffett <mrmacman_g4@mac.com>
cc: Steven Rostedt <rostedt@goodmis.org>, johnstul@us.ibm.com,
       george@mvista.com, mingo@elte.hu, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       ray-gmail@madrabbit.org, Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 00/43] ktimer reworked
In-Reply-To: <91D50CB6-A9B0-4501-AAD2-7D80948E7367@mac.com>
Message-ID: <Pine.LNX.4.61.0512020146310.1609@scrub.home>
References: <1133395019.32542.443.camel@tglx.tec.linutronix.de>
 <Pine.LNX.4.61.0512010118200.1609@scrub.home> <23CA09D3-4C11-4A4B-A5C6-3C38FA9C203D@mac.com>
 <Pine.LNX.4.61.0512011352590.1609@scrub.home>
 <2c0942db0512010822x1ae20622obf224ce9728e83f8@mail.gmail.com>
 <20051201165144.GC31551@flint.arm.linux.org.uk> <Pine.LNX.4.61.0512011828150.1609@scrub.home>
 <1133464097.7130.15.camel@localhost.localdomain> <Pine.LNX.4.61.0512012048140.1609@scrub.home>
 <Pine.LNX.4.58.0512011619590.32095@gandalf.stny.rr.com>
 <Pine.LNX.4.61.0512020120180.1609@scrub.home> <91D50CB6-A9B0-4501-AAD2-7D80948E7367@mac.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 1 Dec 2005, Kyle Moffett wrote:

> > I'm not against HR timer, I have a problem with using them as timer for
> > everything.
> 
> This is _exactly_ why there is the timer/timeout distinction.  Some things
> don't care, and as a result use a timer wheel exactly like they always have.
> For the things that do, however, the new timer API provides it using the
> fastest hardware interface available.

This is about kernel programming - people should care. We have enough crap 
as it is. timer wheel is fast as well, but everything has its limits, 
putting this focus completely to delivery is nonsense. It can't be that 
difficult to put together a decent list of criteria, where to use which 
timer. Both are still _timer_, introducing this timer/timeout thing is 
only confusing.

bye, Roman
