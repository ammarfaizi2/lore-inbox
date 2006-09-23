Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751472AbWIWTWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472AbWIWTWs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 15:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbWIWTWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 15:22:48 -0400
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:25060 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1751472AbWIWTWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 15:22:48 -0400
Date: Sat, 23 Sep 2006 21:22:25 +0200
From: Voluspa <lista1@comhem.se>
To: Daniel Walker <dwalker@mvista.com>
Cc: brugolsky@telemetry-investments.com, mingo@elte.hu, pavel@suse.cz,
       akpm@osdl.org, tglx@linutronix.de, linux-kernel@vger.kernel.org
Subject: Re: hires timer patchset [was Re: 2.6.19 -mm merge plans]
Message-ID: <20060923212225.060bb5f7@loke.fish.not>
In-Reply-To: <1159034967.21405.22.camel@c-67-180-230-165.hsd1.ca.comcast.net>
References: <20060923041746.2b9b7e1f@loke.fish.not>
	<1159034967.21405.22.camel@c-67-180-230-165.hsd1.ca.comcast.net>
X-Mailer: Sylpheed-Claws 2.4.0 (GTK+ 2.4.13; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Sep 2006 11:09:26 -0700 Daniel Walker wrote:
> On Sat, 2006-09-23 at 04:17 +0200, Voluspa wrote:
> 
> > Here's another data point: I tried 2.6.18-rt3 today on a x86_64
> > notebook. I'm on an eternal quest for extended battery time, so
> > NO_HZ would be perfect. Long story shortened, HIGH_RES_TIMERS
> > (prerequisite for NO_HZ) caused the CPU to never step down from max
> > speed (ondemand, powernow_k8) at 2200 MHz.
> > 
> > In addition, something invisible used very frequent bursts of ~30%
> > SYS CPU. Turning from PREEMPT_RT to PREEMPT_DESKTOP introduced
> > occasional bursts of ~50% USER CPU (mixed with the SYS). Toggling
> > RCU model made no difference.
> > 
> 
> It seems like you don't need all of 2.6.18-rt3 , you just want dynamic
> tick .. You can obtain just the HRT/dynamic tick patch from here,
> 
> http://www.tglx.de/projects/hrtimers/2.6.18/

Thank you pointing that out. I didn't realise that the features were so
sharply divided. Perhaps I'll even be able to debug it locally, then -
wearing ear-mufflers. I'm not kidding about the fan noise.

At the very least the experiment will tell if it's a -rt combo problem
or NO_HZ on its own.

Mvh
Mats Johannesson
