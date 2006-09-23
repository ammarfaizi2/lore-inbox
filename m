Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751387AbWIWSJd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbWIWSJd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 14:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbWIWSJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 14:09:33 -0400
Received: from homer.mvista.com ([63.81.120.158]:49379 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1751387AbWIWSJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 14:09:33 -0400
Subject: Re: hires timer patchset [was Re: 2.6.19 -mm merge plans]
From: Daniel Walker <dwalker@mvista.com>
To: Voluspa <lista1@comhem.se>
Cc: brugolsky@telemetry-investments.com, mingo@elte.hu, pavel@suse.cz,
       akpm@osdl.org, tglx@linutronix.de, linux-kernel@vger.kernel.org
In-Reply-To: <20060923041746.2b9b7e1f@loke.fish.not>
References: <20060923041746.2b9b7e1f@loke.fish.not>
Content-Type: text/plain
Date: Sat, 23 Sep 2006 11:09:26 -0700
Message-Id: <1159034967.21405.22.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-09-23 at 04:17 +0200, Voluspa wrote:

> Here's another data point: I tried 2.6.18-rt3 today on a x86_64
> notebook. I'm on an eternal quest for extended battery time, so
> NO_HZ would be perfect. Long story shortened, HIGH_RES_TIMERS
> (prerequisite for NO_HZ) caused the CPU to never step down from max
> speed (ondemand, powernow_k8) at 2200 MHz.
> 
> In addition, something invisible used very frequent bursts of ~30% SYS
> CPU. Turning from PREEMPT_RT to PREEMPT_DESKTOP introduced occasional
> bursts of ~50% USER CPU (mixed with the SYS). Toggling RCU model
> made no difference.
> 

It seems like you don't need all of 2.6.18-rt3 , you just want dynamic
tick .. You can obtain just the HRT/dynamic tick patch from here,

http://www.tglx.de/projects/hrtimers/2.6.18/

Daniel

