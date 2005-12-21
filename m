Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964930AbVLUXE1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964930AbVLUXE1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 18:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbVLUXE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 18:04:27 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:50826 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932322AbVLUXE0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 18:04:26 -0500
Date: Thu, 22 Dec 2005 00:03:54 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: George Anzinger <george@mvista.com>
cc: tglx@linutronix.de, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, rostedt@goodmis.org, johnstul@us.ibm.com,
       mingo@elte.hu
Subject: Re: [patch 00/21] hrtimer - High-resolution timer subsystem
In-Reply-To: <43A71E07.30403@mvista.com>
Message-ID: <Pine.LNX.4.61.0512212350110.2778@scrub.home>
References: <20051206000126.589223000@tglx.tec.linutronix.de> 
 <Pine.LNX.4.61.0512061628050.1610@scrub.home>  <1133908082.16302.93.camel@tglx.tec.linutronix.de>
  <Pine.LNX.4.61.0512070347450.1609@scrub.home>  <1134148980.16302.409.camel@tglx.tec.linutronix.de>
  <Pine.LNX.4.61.0512120007010.1609@scrub.home> <1134405768.4205.190.camel@tglx.tec.linutronix.de>
 <439E2308.1000600@mvista.com> <Pine.LNX.4.61.0512150141050.1609@scrub.home>
 <43A0D505.3080507@mvista.com> <Pine.LNX.4.61.0512191550460.1609@scrub.home>
 <43A71E07.30403@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 19 Dec 2005, George Anzinger wrote:

> > You don't think the current behaviour is wrong.
> > 
> > 
> On of the issues I see with using your assumption is that moving the timer to
> an absolute clock after the initial expiry _may_ lead to additional
> qauntization errors, depending on how aligned the two clocks are.

What do you mean by "moving the timer to an an absolute clock"?

> I would guess, then, that either the non-absolute or the absolute timer
> behaves badly in the face of clock setting.  Could you provide a pointer to
> the NetBSD code so I can have a look too?

http://cvsweb.netbsd.org/bsdweb.cgi/src/sys/kern/kern_time.c?rev=1.98&content-type=text/x-cvsweb-markup
AFAICT TIMER_ABSTIME is only used to convert the relative value to an 
absolute value.

bye, Roman
