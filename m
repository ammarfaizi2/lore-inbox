Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965002AbVI0Qy4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965002AbVI0Qy4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 12:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965007AbVI0Qy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 12:54:56 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:28638 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S965002AbVI0Qy4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 12:54:56 -0400
Date: Tue, 27 Sep 2005 18:54:04 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Thomas Gleixner <tglx@linutronix.de>
cc: Ingo Molnar <mingo@elte.hu>, Christopher Friesen <cfriesen@nortel.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, george@mvista.com,
       johnstul@us.ibm.com, paulmck@us.ibm.com
Subject: Re: [ANNOUNCE] ktimers subsystem
In-Reply-To: <1127682006.15115.96.camel@tglx.tec.linutronix.de>
Message-ID: <Pine.LNX.4.61.0509271848040.3728@scrub.home>
References: <20050919184834.1.patchmail@tglx.tec.linutronix.de> 
 <Pine.LNX.4.61.0509201247190.3743@scrub.home>  <1127342485.24044.600.camel@tglx.tec.linutronix.de>
  <Pine.LNX.4.61.0509221816030.3728@scrub.home> <43333EBA.5030506@nortel.com>
  <Pine.LNX.4.61.0509230151080.3743@scrub.home>  <1127458197.24044.726.camel@tglx.tec.linutronix.de>
  <Pine.LNX.4.61.0509240443440.3728@scrub.home>  <20050924051643.GB29052@elte.hu>
  <Pine.LNX.4.61.0509241212170.3728@scrub.home>  <1127570212.15115.77.camel@tglx.tec.linutronix.de>
  <Pine.LNX.4.61.0509250052390.3728@scrub.home> <1127682006.15115.96.camel@tglx.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 25 Sep 2005, Thomas Gleixner wrote:

> > You know very well, that the conversion back to timespec is the killer in 
> > your calculation. You graciously decide that the "vast majority" doesn't 
> > want to read the timer, how did you get to that conclusion?
> 
> I graciously put instrumentation into _all_ the relevant syscalls on a
> desktop and a server machine. The result is that less than 1% of the
> calls provide the read back variable.

That sill means it is used and if an application actually depends on it, 
it would be penalized by your implementation.
These timers may open up new application (in kernel or user space), where 
this conversion may be needed, so _only_ looking at the current numbers is 
a bit misleading.

bye, Roman
