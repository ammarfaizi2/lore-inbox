Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751391AbVIXDjI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbVIXDjI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 23:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbVIXDjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 23:39:08 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:62657 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751391AbVIXDjG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 23:39:06 -0400
Date: Sat, 24 Sep 2005 05:38:28 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: "Paul E. McKenney" <paulmck@us.ibm.com>
cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       mingo@elte.hu, akpm@osdl.org, george@mvista.com, johnstul@us.ibm.com
Subject: Re: [ANNOUNCE] ktimers subsystem
In-Reply-To: <20050923152141.GA29941@us.ibm.com>
Message-ID: <Pine.LNX.4.61.0509240516020.3728@scrub.home>
References: <20050919184834.1.patchmail@tglx.tec.linutronix.de>
 <Pine.LNX.4.61.0509201247190.3743@scrub.home> <1127342485.24044.600.camel@tglx.tec.linutronix.de>
 <Pine.LNX.4.61.0509221816030.3728@scrub.home> <20050923152141.GA29941@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 23 Sep 2005, Paul E. McKenney wrote:

> I believe Thomas is concerned about workloads that need a short-term
> stable timebase.  For example, a process-control application might need
> to accurately measure a (say) 1500-millisecond time interval.  Both
> user-programmability and NTP adjustments to a given timebase could
> destroy the needed measurement accuracy.

NTP adjustments a quite small and not applied all at once, this means as 
soon as the time is synchronized, we could switch CLOCK_MONOTONIC to it.

bye, Roman
