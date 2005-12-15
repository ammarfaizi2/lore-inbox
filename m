Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030210AbVLOBfl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030210AbVLOBfl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 20:35:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030265AbVLOBfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 20:35:41 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:6628 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030210AbVLOBfk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 20:35:40 -0500
Date: Thu, 15 Dec 2005 02:35:25 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: George Anzinger <george@mvista.com>
cc: tglx@linutronix.de, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, rostedt@goodmis.org, johnstul@us.ibm.com,
       mingo@elte.hu
Subject: Re: [patch 00/21] hrtimer - High-resolution timer subsystem
In-Reply-To: <439E2308.1000600@mvista.com>
Message-ID: <Pine.LNX.4.61.0512150141050.1609@scrub.home>
References: <20051206000126.589223000@tglx.tec.linutronix.de> 
 <Pine.LNX.4.61.0512061628050.1610@scrub.home>  <1133908082.16302.93.camel@tglx.tec.linutronix.de>
  <Pine.LNX.4.61.0512070347450.1609@scrub.home>  <1134148980.16302.409.camel@tglx.tec.linutronix.de>
  <Pine.LNX.4.61.0512120007010.1609@scrub.home> <1134405768.4205.190.camel@tglx.tec.linutronix.de>
 <439E2308.1000600@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 12 Dec 2005, George Anzinger wrote:

> My $0.02 worth: It is clear (from the standard) that the initial time is to be
> ABS_TIME.

Yes.

>  It is also clear that the interval is to be added to that time.

Not necessarily. It says it_interval is a "reload value", it's used to 
reload the timer to count down to the next expiration.
It's up to the implementation, whether it really counts down this time or 
whether it converts it first into an absolute value.

> IMHO then, the result should have the same property, i.e. ABS_TIME.  Sort of
> like adding an offset to a relative address. The result is still relative.

If the result is relative, why should have a clock set any effect?
IMO the spec makes it quite clear that initial timer and the periodic 
timer are two different types of the timer. The initial timer only 
specifies how the periodic timer is started and the periodic timer itself 
is a "relative time service".

bye, Roman
